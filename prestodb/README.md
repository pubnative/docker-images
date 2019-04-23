# PrestoDB docker image

* [Presto Documentation](https://prestosql.io/docs/current/index.html)
* [Deploying Presto](https://prestosql.io/docs/current/installation/deployment.html)
* [Configuration Management Tool to build templates](https://github.com/kelseyhightower/confd)

```
make build


docker run -v $(pwd)/catalog:/opt/presto/installation/etc/catalog\
           -e PRESTO_COORDINATOR_ENABLED=true \
           -e PRESTO_DISCOVERY_ENABLED=true \
           -e PRESTO_INCLUDE_COORDINATOR=true \
           --name test-presto -d -t -i test/prestodb

docker exec -it test-presto bin/presto --server localhost:8080 --catalog hive --schema default
presto:default> show tables;
```
