#!/bin/bash
set -e
PLATFORM=$1

if [ "$PLATFORM" = "linux/arm64" ]; then
    ARCH="arm64";
else

    ARCH="x64";
fi

DART_SASS_VERSION=1.62.1
DART_SASS_TAR=dart-sass-${DART_SASS_VERSION}-linux-${ARCH}.tar.gz
DART_SASS_URL=https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/${DART_SASS_TAR}

echo $DART_SASS_URL;

cd /opt
curl -LO $DART_SASS_URL

ls -la

tar -xzf ${DART_SASS_TAR} && rm ${DART_SASS_TAR}