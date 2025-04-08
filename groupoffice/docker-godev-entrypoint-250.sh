#!/bin/sh
set -e

#usermod --non-unique --uid $APACHE_UID www-data

DIR="$(pwd)";

if [ ! -d "/usr/local/share/src/www/vendor" ]; then
  echo "Building after first start"
  /usr/local/share/src/scripts/build.sh;
fi

cd $DIR;

echo "Calling original with $@"
# call original
docker-go-entrypoint.sh "$@"
