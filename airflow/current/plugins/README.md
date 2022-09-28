# Airflow plugins

Airflow plugins are written on a volume that is mounted on Airflow's scheduler, at `/root/airflow/plugins` (defined in `eks/data/airflow/10_config.yaml`).

## Deploy

### Airflow REST API plugin

A [plugin](https://github.com/teamclairvoyant/airflow-rest-api-plugin) is installed to use a REST API with Airflow.

To deploy it, run either:

    airflow/plugins/update_api_plugin.sh

That will install the default (1.0.7-communicate) version. Or run:

    airflow/plugins/update_api_plugin.sh X.X.X

With `X.X.X` being the version you want to update the plugins to.

### Pubnative plugins

To deploy all of Pubnative plugins (the above being excluded):

    airflow/plugins/deploy.sh

To deploy specific plugins run for instance:

    airflow/plugins/deploy.sh data_science_job_operator.py

### Adding a plugin

To add a plugin, refer to the [Airflow documentation](https://airflow.apache.org/plugins.html).

After your plugin is created, deploy it with all the others:

    airflow/plugins/deploy.sh

Alternatively, you can specifically only the plugin to be deployed using:

    airflow/plugins/deploy.sh your_plugin.py

We would need more data points, but it seems the scheduler needs to be restarted for the changes to take effect.
After that, your plugin should be available under `pubnative.{type_of_stuff_you_created}.{class_implemented}`.

For instance, in `airflow/plugins/data_science_job_operator.py` we created a plugin to implement an `Operator`.
Since it is an `Operator` (it inherits from `KubernetesPodOperator`), it will be made available under `airflow.operators`.
