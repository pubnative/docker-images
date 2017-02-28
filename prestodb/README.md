# PrestoDB docker image

* [Presto Documentation](https://prestodb.io/docs/current/index.html)
* [Deploying Presto](https://prestodb.io/docs/current/installation/deployment.html)
* [Configuration Management Tool to build templates](https://github.com/kelseyhightower/confd)

```
docker build -t pubnative/prestodb:0.167 .
docker build -f Dockerfile.157 -t pubnative/prestodb:0.157.1 .

docker run -v $(pwd)/catalog:/opt/presto/installation/etc/catalog --env PRESTO_COORDINATOR_ENABLED=true --env PRESTO_DISCOVERY_ENABLED=true --env PRESTO_INCLUDE_COORDINATOR=true --name test-presto -d -t -i test/prestodb

docker exec -it test-presto bin/presto --server localhost:8080 --catalog hive --schema default
presto:default> show tables;
```
