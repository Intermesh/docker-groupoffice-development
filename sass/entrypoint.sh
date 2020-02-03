#!/bin/bash
set -e

echo "Looking for SASS files to watch...";
WATCH=

for line in $(find /src \( -name style.scss -o -name style-mobile.scss \));
do
  echo $line;
  replace1=${line/src\/style.scss/style.css};
  replace2=${replace1/src\/style-mobile.scss/style-mobile.css};
  echo $replace2;
	WATCH="$WATCH $line:$replace2";
done

echo "Found: $WATCH"

sass --watch $WATCH

