#!/bin/bash

set -e

docker build \
       $@ \
       -t alpine-docker . \
       --build-arg=SOURCE_COMMIT=$(git rev-parse --short HEAD) \
       --build-arg=SOURCE_BRANCH=$(git rev-parse --abbrev-ref HEAD)

docker tag alpine-docker porzione/alpine-docker
