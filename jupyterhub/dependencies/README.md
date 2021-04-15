### Dependencies
Build requirements.txt to install on images with Poetry

###Instructions
1. Install poetry
2. move to dependencies folder,
```shell
# initialize poetry environment
poetry shell

# add new dependency
poetry add <my new dep>

# resolve environment
poetry install 

# export resolved env to requirements.txt
poetry export > requirements.txt
```