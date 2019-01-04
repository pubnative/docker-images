# Build

```shell
$ make build DRUID_VERSION=<druid_version> DOCKER_REPO_DOCKERFILE_FOLDER=<child_folder_with_Dockerfile>
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

$ docker run -p 8090:8090 -v $(pwd)/conf:/druid/conf/druid/ -it pubnative/druid:v0.12.3 /opt/druid/bin/start-node.sh coordinator
```
