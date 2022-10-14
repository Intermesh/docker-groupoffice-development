#!/bin/bash
set -e

echo "Looking for SASS files to watch...";
WATCH=

for line in $(find /src \( -name style.scss -o -name style-mobile.scss -o -name htmleditor.scss \)  -not -path '*/goui/*' );
do
  replace1=${line/src\/style.scss/style.css};
  replace2=${replace1/src\/style-mobile.scss/style-mobile.css};
  replace3=${replace2/src\/htmleditor.scss/htmleditor.css};
  echo $line - $replace3;
	WATCH="$WATCH $line:$replace3";
done

sass --watch $WATCH

