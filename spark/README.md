# Spark

## Available images

| Image location                   | Versioning                                                                      | Source                                                                                                                                         | Description                                  |
| -------------------------------- | ------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| pubnative/spark:spark            | <spark_version>-<scala_version>-java<java_version>[-k8s]-hadoop<hadoop_version> | [Apache Spark](https://github.com/apache/spark)                                                                                                | Base image for Spark.                        |
| pubnative/spark:pyspark          | <spark_version>-<scala_version>-java<java_version>[-k8s]-hadoop<hadoop_version> | [Apache Spark](https://github.com/apache/spark)                                                                                                | Base image for PySpark.                      |
| pubnative/spark:pyspark-executor | $GIT_COMMIT                                                                     | [Pyspark executor](https://github.com/pubnative/docker-images/blob/4e940e55cb25b6541607990733222d1800674170/spark/pyspark-executor/Dockerfile) | Alpine image supporting Spark on Kubernetes. |

## Build

No official images exist for Spark. So you will have to do everything yourself.

### Workflow

#### Build Spark

To build the image, Spark needs to be built. To build Spark, clone the repository and checkout the
version to build.

```bash
git clone https://github.com/apache/spark
cd spark
git checkout branch-3.4
```

Then build it with:

```bash
build/mvn \
    -Pscala-2.12 \
    -Dscala.version=2.12.15 \
    -Pkubernetes \
    -Phadoop-3.2 \
    -Dhadoop.version=3.2.2 \
    -DskipTests \
    clean package
```

When building, take into account the profiles:

- `-Pscala-2.12` will prepare the build for the 2.12 major version of Scala. Similar parameters exist for other
  versions.
- `-Dscala.version` will set the Scala minor version. For Jupuyter (or any Spark on client
  mode), this should usually match.
- `-Pkubernetes` adds Kubernetes code, if the image is thought to be executed in a Kubernetes
  cluster. You cannot run a Spark on Kubernetes without it.
- `-Phadoop-3.2`: can be used to use a different version Hadoop of Hadoop
- `-Dhadoop.version` sets the minor version for the Hadoop distribution.

To check all available profiles, check the `pom.xml` build file, inside `<profiles>`.

#### Build the images

Now, you want to build the Docker image. For the image, we will need to specify the JDK to include.
If we continue the example building `3.4.1`, run:

```bash
./bin/docker-image-tool.sh -r docker.io/pubnative -t 3.4.1 -b java_image_tag=17-jre -X build
```

**Note**: Spark builds 3 images:

- `spark`
- `spark-py`
- `spark-r`

Right now, we don't care about `spark-r`.

#### Push the image(s)

When pushing images, we need to rename them, to specify:

- Spark version
- Scala binary version
- JDK version
- Whether or not it's a Kubernetes build
- Hadoop version

Example:

```bash
docker tag pubnative/spark:3.4.1 pubnative/spark:3.4.1-2.12.15-java17-k8s-hadoop3.2.2
docker push pubnative/spark:3.4.1-2.12.15-java17-k8s-hadoop3.2.2
```

Example for PySpark:

```bash
docker tag pubnative/spark-py:3.1.1 pubnative/spark:pyspark-3.1.1-2.12.10-java80java8-k8s-hadoop3.2.0
docker push pubnative/spark:pyspark-3.1.1-2.12.10-java8-k8s-hadoop3.2.0
```

### Data science images

Data science images add python libraries and other components.

#### Data science

It adds a set of libraries that are to be shared between drivers and executors, e.g. numpy.

##### Build

```bash
make build
```

##### Push

```bash
make push
```

##### All in one

```bash
make
```

#### Data science CI

It build on top of `data-science-base` and adds Bazel and Docker, respectively to handle the CI and build image.

##### Build

```bash
make build
```

##### Push

```bash
make push
```

##### All in one

```bash
make
```
