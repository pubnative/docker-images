### Spark executors
This builds a docker image for spark executors for spark jobs on jupyter.

We pass our dockerfile to this tool to add python binding for Python3.8 to spark image.

By default, spark provided Dockerfile for python binding will install python3.7.

This is because Debian 10 on which spark is build does not provide python3.8 yet.

Hence, we build python3.8 from source in our Dockerfile and pass it to the docker-image-tool of spark.

Eventually we get spark image with
- spark 3.1.1
- python 3.8
- hadoop 3.2

It pushes two images 
- spark to target `annoyingllama/spark`
- spark with python bindings (pyspark) `annoyingllama/spark-py`

###Instructions:
1. Get Spark 3.1.1
```shell
curl -O https://downloads.apache.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz
tar -xvzf spark-3.1.1-bin-hadoop3.2.tgz 
export SPARK_HOME=`pwd`/spark-3.1.1-bin-hadoop3.2.tgz
```

2. We use docker-image-tool.sh provided by spark to build this image.
```shell
 $SPARK_HOME/bin/docker-image-tool.sh
```

3. call one of the make targets to build and push image
```shell
# copy requirements to your spark home
# since build context is in your SPARK_HOME you have to copy requirements.txt 
# there so build tool can copy it to the docker file
make requirements

# build 
make build

# push 
make push

# build & push 
make build-push
```
 
