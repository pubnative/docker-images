# Releases

Relase a new docker version via Github Actions.
Need create a new release and specify the pattern: <imagename>-<tag>

**Add comment to every Dockerfile with information about repository and tag. In this case it will be possible to find every image's definition and which tag it corresponds to**

[Example](https://github.com/pubnative/docker-images/blob/cbdc39c8ae631e842232207c4672ddc1a3e4ea1a/airflow/Dockerfile#L1)

**Fill in readme on dockerhub and in this repo about how to build the image if some extra steps should be done.**
 

## Android

When a new tag added, then it would release to docker.
Relase should have tag: android-*
