# Hive docker image

Docker image for hive partitioner.
It creates partitions for all specified tables daily.

## Build

```
docker build . -t pubnative/hive-partition
```

## Config

Wright your config in `toml` format based on [conf/config.toml](conf/config.toml)

## Run

```
docker run -v config.toml:/opt/partition/config.toml pubnative/hive-partition
```
