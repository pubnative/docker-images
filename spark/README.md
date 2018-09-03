# Spark

Basic image with spark and mesos

## Build

```bash
$ docker build -t pubnative/spark:2.0.2 .
$ docker push pubnative/spark:2.0.2
```

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

# Spark with Python

This image Dockerfile can be found in `python` directory. It's an image containing spark, mesos and python.

## Build

For building and pushing the image `pubnative/spark:python3.6.5_java1.8.131_hadoop2.7.3_mesos1.3.0` please look at `python/Makefile`.
