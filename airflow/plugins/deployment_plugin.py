from airflow.plugins_manager import AirflowPlugin

import os

def deploy_in_env(dag):
    if os.getenv("ENV") == 'prod':
        return dag
    else:
        print("Not in production environment. Skipping DAG creation.")
        return None

class DeploymentPlugin(AirflowPlugin):
    name = "deployment_plugin"
    macros = [deploy_in_env]