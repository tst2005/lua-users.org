#!/bin/sh

BASEDIR="$(dirname "$0")"

find -mindepth 1 -maxdepth 1 ! -name '*.html' |grep -v '/.*[^a-zA-Z0-9].*$' \
| sort \
| while read -r dirfile; do
	echo "$dirfile"
	"$BASEDIR/convert.sh" "$dirfile" "$1" > "${dirfile}.html"
done
