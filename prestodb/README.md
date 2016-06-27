# PrestoDB docker image based on Hive Hadoop S3

* [Presto Documentation](https://prestodb.io/docs/current/index.html)
* [Deploying Presto](https://prestodb.io/docs/current/installation/deployment.html)
* [Configuration Management Tool to build templates](https://github.com/kelseyhightower/confd)

To test it locally configure AWS S3 keys `HIVE_S3_ACCESSKEY`, `HIVE_S3_SECRETKEY` and `HIVE_HOST`:

```
docker build -t test/prestodb .

docker run --env PRESTO_COORDINATOR_ENABLED=true --env PRESTO_DISCOVERY_ENABLED=true --env PRESTO_INCLUDE_COORDINATOR=true --env MYSQL_USER=ROOT --env MYSQL_PASSWORD="" --env HIVE_S3_ACCESSKEY="" --env HIVE_S3_SECRETKEY="" --env HIVE_HOST=localhost --name test-presto -d -t -i test/prestodb

docker exec -it test-presto /bin/bash
root@installation# bin/presto --server localhost:8080 --catalog hive --schema default
presto:default> show tables;
```

Used connectors:

* [Hive](https://prestodb.io/docs/current/connector/hive.html)
* [MySQL](https://prestodb.io/docs/current/connector/mysql.html)
* [JMX](https://prestodb.io/docs/current/connector/jmx.html)
* [TPCH](https://prestodb.io/docs/current/connector/tpch.html)
