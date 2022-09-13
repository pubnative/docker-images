from datetime import datetime
from typing import List

from airflow import DAG
from airflow.models import BaseOperator, DagRun, TaskInstance
from airflow.models.skipmixin import SkipMixin
# from airflow.operators import LatestOnlyOperator


class OnlyFreshestOperator(BaseOperator, SkipMixin):
    """ OnlyFreshestOperator runs a task only if it
    doesn’t trail by more than `trailing_by_max` DAG runs, else it is skipped.
    """

    def __init__(self, trailing_by_max: int, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.trailing_by_max = trailing_by_max

    def execute(self, context: dict):
        # If the DAG Run is externally triggered, then return without
        # skipping downstream tasks
        if context["dag_run"] and context["dag_run"].external_trigger:
            self.log.info(
                "Externally triggered DAG_Run: allowing execution to proceed."
            )
            return

        dag: DAG = context["dag"]
        next_execution: datetime = context["execution_date"]

        future_dag_runs: List[DagRun] = dag.get_run_dates(next_execution)
        print(future_dag_runs)
        print(len(future_dag_runs))
        if len(future_dag_runs) <= self.trailing_by_max:
            print("not skipping, close enough")
            return

        print("skipping")
        downstream_tasks = context["task"].get_flat_relatives(upstream=False)
        if downstream_tasks:
            self.skip(
                context["dag_run"], context["ti"].execution_date, downstream_tasks
            )
