## Build base image
This image is built on top of this [repo](https://github.com/jupyter/docker-stacks).
To reproduce follow the steps below:
- Clone repo 
- Build the image(`jupyter/custom`) using the command below
```
docker build --rm --force-rm --no-cache \
-t jupyter/custom35 ./images/pyspark-notebook \
--build-arg openjdk_version=17 \
--build-arg spark_version=3.5.7 \
--build-arg hadoop_version=3 \
--build-arg spark_download_url="https://archive.apache.org/dist/spark/" \
--platform linux/amd64
```

## Additional information 
- `gcs-connector-hadoop3-2.2.11-shaded.jar` is added to spark 
- `google-cloud-cli-458.0.1-linux-x86_64.tar.gz` is installed
- python package requirements are added from poetry project
- spark-defaults are to be mounted with the deployment in data-tasks repo. 
They should contain the image build from `data-science/pyspark` folder

## Build & publish
- patch
```sh
make patch publish
```
- minor 
```sh
make minor publish
```
- major 
```sh
make major publish
```

