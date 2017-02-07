#!/bin/bash

set -x
echo "$PRIVATE_KEY" > /root/.ssh/id_rsa
chmod 700 /root/.ssh/id_rsa
cat /root/.ssh/id_rsa

autossh -M 0 \
 -g \
 -N \
 -o StrictHostKeyChecking=no \
 -o ServerAliveInterval=10 \
 -o ServerAliveCountMax=3 \
 -o ExitOnForwardFailure=yes \
 -i /root/.ssh/id_rsa \
 $*
