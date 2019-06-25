# Spark

Different Spark images.

| Image name              | Versioning     | Source                                                                                                                          | Description                             |
| ----------------------- | -------------- | ------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| pubnative/spark:spark   | $SPARK_VERSION | [Apache Spark](https://github.com/apache/spark)                                                                                 | Base image for Spark.                   |
| pubnative/spark:pyspark | $SPARK_VERSION | [Apache Spark](https://github.com/apache/spark)                                                                                 | Base image for PySpark.                 |
| pubnative/pyspark-ci    | $GIT_HASH      | [Pyspark CI](https://github.com/pubnative/docker-images/blob/8fddc7003f9c8963abd40cdab2db5c706fb86d63/spark/pyspark/Dockerfile) | Handles the CI for data-science builds. |

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

≠== TODO ==≠

## Sample

Run inside cluster example

```bash
docker run --net=host pubnative/spark:2.0.2 bin/spark-submit \
           --executor-memory 1g \
           --driver-memory 1g \
           --total-executor-cores 1 \
           --conf spark.mesos.executor.cores=1 \
           --conf spark.mesos.executor.cores_per_task=1 \
           --conf spark.mesos.executor.docker.volumes=./tmp:/tmp:rw \
           --conf spark.ui.port=31695 \
           --conf spark.mesos.executor.docker.image=pubnative/spark:2.0.2 \
           --conf spark.mesos.executor.home=/spark \
           --conf spark.mesos.constraints="role:spark-executer" \
           --conf spark.mesos.coarse=true \
           --conf spark.mesos.role=spark \
           --conf spark.port.maxRetries=1 \
           --conf spark.mesos.uris=file:///etc/docker.tar.gz \
           --master "mesos://zk://zookeeper.service.consul:2181/mesos" \
           /spark/examples/src/main/python/pi.py 1
```

Run task from the other image
