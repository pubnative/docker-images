#!/bin/bash

# Make sure that pip-tools is installed.
# (pip install pip-tools)

pip-compile \
  --generate-hashes \
  --output-file requirements.txt \
  requirements.in

chmod +r requirements.txt
