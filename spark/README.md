# Spark

## Available images

| Image location                   | Versioning     | Source                                                                                                                                         | Description                                  |
| -------------------------------- | -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| pubnative/spark:spark            | $SPARK_VERSION | [Apache Spark](https://github.com/apache/spark)                                                                                                | Base image for Spark.                        |
| pubnative/spark:pyspark          | $SPARK_VERSION | [Apache Spark](https://github.com/apache/spark)                                                                                                | Base image for PySpark.                      |
| pubnative/spark:pyspark-executor | $GIT_COMMIT    | [Pyspark executor](https://github.com/pubnative/docker-images/blob/4e940e55cb25b6541607990733222d1800674170/spark/pyspark-executor/Dockerfile) | Alpine image supporting Spark on Kubernetes. |


## Build

No official images exist for Spark.
So you will have to do everything yourself.

### Workflow

#### Clone the Spark repo (yes)

To build the image, Spark needs to be built.
To build Spark, you need the repo locally.

If you have it locally, refresh it:

```bash
cd SPARK_REPO
git fetch -p && git pull
```

Else, clone the repo somewhere:

```bash
git clone https://github.com/apache/spark
```

#### Build Spark

You don't want to build master, so you need to checkout a specific verson.
Usually, you need the last commit for a specific label, e.g. for `2.4.3` it is `c3e32bf06c35ba2580d46150923abfa795b4446a`.

When you have the commit you want, e.g. `c3e32bf06c35ba2580d46150923abfa795b4446a`:

```bash
git checkout tags/v$SPARK_VERSION
```

Then to build Spark:

```bash
build/mvn \
    -Pkubernetes \
    -DskipTests \
    clean package
```

This script is supposed to handle everything, including Spark and Scala versions.
If it's the last commit of a release, it's supposed to lead  to a complete build.

#### Build the images

Now, you want to build the Docker image.
If we continue the example building `2.4.3`, run:

```bash
./bin/docker-image-tool.sh -r docker.io/pubnative -t 2.4.3 build
```

#### Push the image(s)

If you want to push the Spark image:

```bash
docker push pubnative/spark:2.4.3
```

If you want to push the PySpark image:

```bash
docker tag pubnative/spark-py:2.4.3 pubnative/spark:pyspark-2.4.3
docker push pubnative/spark:pyspark-2.4.3
```

**Note**: Spark builds 3 images:

- `spark`
- `spark-py`
- `spark-r`

Right now, we don't care about `spark-r`, and we need to rename `spark-py` to map it to our registry names.

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
