#!/bin/sh

show_usage() {
	echo >&2 "Usage: $0 <path/to/file> <directorylevel>"
}

f="$1";shift
if [ ! -f "$f" ]; then
	show_usage
	exit 1
fi

leveldir="$1";shift
if [ -z "$leveldir" ]; then
	show_usage
	exit 1
fi
dir=""
for n in $(seq 1 $leveldir); do
	dir="${dir}../"
done
#dir="../"

# "/wiki/	-> "../wiki/
# "/images/	-> "../images/
# "/styles/	-> "../styles/
cat -- "$f" \
| dos2unix \
| mac2unix \
| iconv -f ISO-8859-1 -t UTF-8 \
| sed -e 's,"/wiki/,"'"$dir"'wiki/,g' \
| sed -e 's,"/images/,"'"$dir"'images/,g' \
| sed -e 's,"/styles/,"'"$dir"'styles/,g' \
| sed -e 's,="/",="'"$dir"index.html'",g' \
| sed -e 's,wiki/",wiki/index.html",g' \
| sed -e 's,\(wiki/[^."]*\)\(\.html\|\)",\1.html",g'

#| sed -e 's,<form .*>.*</form>,,g'

# <form method="post" action="../wiki/FindPage" enctype="application/x-www-form-urlencoded" style="display:inline; margin:0;">
# <input type="hidden" name="action" value="search"  /><input type="text" name="string"  size="20" style="" id="search_query1" /><input type="hidden" name="title" value="1"  /><input type="submit" name=".submit" value="Search" /><input type="hidden" name="body" value="on"  /></form></td></tr> </table>

