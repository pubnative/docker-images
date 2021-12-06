# Base data science pyspark image
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