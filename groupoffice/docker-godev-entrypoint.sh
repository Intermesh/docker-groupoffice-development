#!/bin/sh
set -e

echo "Settig up host.docker.internal"

# For supporting host.docker.internal on Linux. See https://github.com/docker/for-linux/issues/264
ip -4 route list match 0/0 | awk '{print $3 " host.docker.internal"}' >> /etc/hosts

echo "Calling original with $@"
# call original
docker-go-entrypoint.sh "$@"
