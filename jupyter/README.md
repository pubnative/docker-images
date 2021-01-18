# Jupyter

Image for Jupyter Lab.

## User poetry to resolve dependencies
```shell
# install poetry
pip install poetry
# initialize poetry, this will create pyproject.toml file
poetry init
# create new venv where poetry in install and resolve deps for this project
poetry shell
# add dependencies to pyproject.toml, every addition will be installed and poetry.lock is updated
poetry add numpy
poetry add pandas
```

## compile dependencies
```sh
# export resolved packages from .lock, this will create requirements.txt with fixed hashes
poetry export > requirements.txt


## All in one
To build the image, and push it to Docker Hub:

```sh
make build
```
## Note
- Special exception was made for s3fs as poetry could not figure out the right version and newer version of this 
conflict with awscli. Internet tells us that only 0.4.* versions of s3fs play nice so we fix that in .toml