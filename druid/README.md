# Build

```shell
$ make build
```

# Usage

```shell
$ tree conf
conf
├── _common
│   └── common.runtime.properties
└── overlord
    ├── jvm.config
    └── runtime.properties

$ docker run -p 8090:8090 -v $(pwd)/conf:/druid/conf/druid/ -it pubnative/druid:v0.12.2 overlord
```
