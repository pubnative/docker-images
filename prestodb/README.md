# PrestoDB docker image

* [Presto Documentation](https://prestodb.io/docs/current/index.html)
* [Deploying Presto](https://prestodb.io/docs/current/installation/deployment.html)
* [Configuration Management Tool to build templates](https://github.com/kelseyhightower/confd)

Prepare a tarball `catalog.tar.gz` containing all needed connectors, see `example/catalog`:

```
docker build -t test/prestodb .

docker run --env CATALOG_URL=http://s3.pubnative.com/catalog.tar.gz --env PRESTO_COORDINATOR_ENABLED=true --env PRESTO_DISCOVERY_ENABLED=true --env PRESTO_INCLUDE_COORDINATOR=true --name test-presto -d -t -i test/prestodb

docker exec -it test-presto /bin/bash
root@installation# bin/presto --server localhost:8080 --catalog hive --schema default
presto:default> show tables;
```
