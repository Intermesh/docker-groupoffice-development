#!/bin/sh
set -e

DIR="$(pwd)";

if [ ! -d "/usr/local/share/src/www/vendor" ]; then
  echo "Running composer install for PHP"
  cd "/usr/local/share/src/www/";
  for line in $(find . -name composer.json -type f -not -path '*/vendor/*')
  do
    COMPOSER_DIR="$(dirname "${line}")";
    echo "Composer install:" $COMPOSER_DIR;
    cd $COMPOSER_DIR;
    composer install -o
     cd "/usr/local/share/src/www/";
  done
fi

cd $DIR;

echo "Calling original with $@"
# call original
docker-go-entrypoint.sh "$@"
