## Info 
- This image is built on 
`jupyter/all-spark-notebook:spark-3.4.1`
- `gcs-connector-hadoop3-2.2.11-shaded.jar` is added to spark 
- `google-cloud-cli-458.0.1-linux-x86_64.tar.gz` is installed
- python package requirements are added from poetry project
- spark-defaults are to be mounted with the deployment in data-tasks repo. 
They should contain the image build from `data-science/pyspark` folder

## Build & publish
- patch
```sh
make patch publish
```
- minor 
```sh
make minor publish
```
- major 
```sh
make major publish
```