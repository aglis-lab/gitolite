#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Please provide tag name for deployment"
    exit 1
fi

podman build --arch amd64 -t gooner0709/gitolite:amd64 .
podman build --arch arm64 -t gooner0709/gitolite:arm64 .

podman manifest create gooner0709/gitolite:$1
podman manifest add gooner0709/gitolite:$1 gooner0709/gitolite:amd64
podman manifest add gooner0709/gitolite:$1 gooner0709/gitolite:arm64

podman manifest push gooner0709/gitolite:$1 docker.io/gooner0709/gitolite:$1
podman manifest push gooner0709/gitolite:$1 docker.io/gooner0709/gitolite:latest
