# Jupyter

Image for Jupyter Lab.

## Pip tools

We use pip tools to get the sha of dependencies.
To install the tools, run:

```sh
pip3 install pip-tools
```

## Compile dependencies

Then, the dependecy tree needs to be built and the hashes computed:

```sh
make compile_dependencies
```

This will create a `requirements.txt` that will contain the dependencies with their hashes.

## All in one

To compile dependencies, build the image, and push it to Docker Hub:

```sh
make
```
