from airflow.plugins_manager import AirflowPlugin
from only_freshest_operator import OnlyFreshestOperator


class PubnativePlugin(AirflowPlugin):
    """Exposes the plugin for Airflow.

    The content will be exposed at `airflow.plugins.{type of plugin}`.

    Example:
        from airflow.plugins import DataScienceJobOperator
    """

    name = "pubnative"
    operators = [OnlyFreshestOperator]
