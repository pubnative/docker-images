# Base data science pyspark image
This image is also used for jupyterhub spark executors. It is passed via spark defaults and mounted onto the deployment in data-tasks
## build pyspark image with docker image tool
- Make sure your SPARK_HOME is set to the SPARK 3.2.2
- We need to build this with java8 so that it is compatible with gcs-connector
```sh
make pyspark
```
## build image with added jar for shaded gcs connector 
```sh
make build
```
## push image to pubnative/pyspark
```sh
make push
```