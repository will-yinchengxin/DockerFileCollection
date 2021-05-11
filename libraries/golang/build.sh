#!/usr/bin/env bash

DOCKER_BINARY=${1:-docker-19.03.9}

wget "https://download.docker.com/linux/static/stable/x86_64/${DOCKER_BINARY}.tgz"
mkdir -p docker-ce
tar xf "${DOCKER_BINARY}.tgz" -C docker-ce
cp docker-ce/docker/docker docker

docker build -t harbor.duomai.com/library/golang .
