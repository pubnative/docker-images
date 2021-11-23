#Jupyterhub
### TL;DR Version (4 steps) 
1. Set SPARK_HOME to spark 3.2.0 installation
2. Build and Push Spark executors image to Dockerhub
   ```shell
   make push_executors
   ```
3. Update `spark.kubernetes.container.image` in `spark-defaults.conf` in data-science-notebook folder
4. Build and Push Jupyterhub image to Dockerhub
   ```shell
   make push_jupyterhub
   ```


### How Jupyterhub images are build?
The main reason we are doing this staged build is because we want java8 instead of java11 which is incompatible with 
gcs-connector for Apache Spark
1. Package dependencies for this are resolved with Poetry. They are defined in `pyproject.toml` file in folder
   package-dependencies. These can be exported to `requirements.txt` form by running
    ```shell
    make dependencies  
    ```
2. Jupyterhub pyspark-notebook image is build from jupyterhub scipy notebook base image. openjdk_version is set to 8, 
   so that it will work with gcs connector properly. Default pyspark notebook from jupyterhub is built with openjdk 11 
   which is not suitable for us. This can be built with
   ```shell
   make pyspark
   ```
   
3. This pyspark-notebook image is then used as base image for building the jupyterhub all-spark-notebook image. This is
   depends on make target `pyspark` and can be built with
   ```shell
   make all_spark
   ```

4. Verve package dependencies are then added on this all-spark-notebook base image to create datascience-notebook image. 
   Also, spark default configuration and scala kernel`Almond` are added. This depends on make targets  
   `all_spark` and `dependencies` and can be built with
   ```shell
   make jupyterhub
   ```
   If you call this target all the dependencies are automatically build.

### How Spark executor images are built?
Since jupyterhub spark is running with Python 3.9 we need the same Python minor version on executor images. \
Default spark images come with python3.8 and is also built on java 11 with base image openjdk:11-jre-slim. \
We will build this image from openjdk:8-jre-slim and python 3.9.7. \
In addition, we will add same package dependencies to this image as we did to the jupyterhub image. 

1. Set your SPARK_HOME to your spark 3.2.0 installation
2. To build spark executor image run
   ```shell 
   make spark_executors
   ```
If you update the tag of these images. Make sure to update 
```markdown
spark.kubernetes.container.image pubnative/spark-py:3.2-hadoop3.2-py3.9-java8
```
in `spark-defaults.conf` and rebuild the data-science-notebook image with `make jupyterhub` 

