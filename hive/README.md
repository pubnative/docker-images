# Hive docker image

Hive docker image for `metastore` (mysql backed) and `server`

## Build
```
docker build -t pubnative/hive .
```

## Run

### Metastore

```
docker run -p 9083:9083 pubnative/hive hive --service metastore
```

Configuration parameters:

```
MYSQL_URI jdbc:mysql://<host>:<port>/<db_name>
MYSQL_USER <mysql_user>
MYSQL_PASSWORD <mysql_password>
```

Example:

```
docker run \
  -e "MYSQL_URI=jdbc:mysql://localhost:3306/hive" \
  -e "MYSQL_USER=root" \
  -e "MYSQL_PASSWORD=super-password" \
  -p 9083:9083 \
  pubnative/hive hive --service metastore
```

### Metastore

```
docker run -p 9083:9083 pubnative/hive hive --service metastore
```

Configuration parameters:

```
HIVE_METASTORE_URL <metastore_host>:<metastore_port>
AWS_ACCESS_KEY_ID <id>
AWS_SECRET_ACCESS_KEY <key>
```

Example:

```
docker run \
  -e "HIVE_METASTORE_URL=thrift://localhost:9083" \
  -e "AWS_ACCESS_KEY_ID=xxx" \
  -e "AWS_SECRET_ACCESS_KEY=yyy" \
  -p 10000:10000 \
  pubnative/hive hive --service hiveserver2
```

### Configuration

See above configuration parameters per container type.
For another customisations copy file with configuration to `/opt/hadoop/etc/hadoop/hive-site.xml.tpl` in container

#TODO:

- Get rid of warnings about double log4j bindings. We need to exclude `hadoop` logger in `hive`: `/opt/hadoop/share/hadoop/common/lib/slf4j-log4j12-*.jar`
- Upgrade hive and versions
