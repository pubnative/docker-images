# Base data science pyspark image
This image is also used for jupyterhub spark executors. It is passed via spark defaults and mounted onto the deployment in data-tasks
## build pyspark image with docker image tool
- Make sure your SPARK_HOME is set to the SPARK 3.4.1
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