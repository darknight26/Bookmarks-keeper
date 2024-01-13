#!usr/bin/bash
echo "This script keeps you bookmarks at one place"
touch bookmrks.txt

FILE1=/home/ashutosh/.config/google-chrome/Default
if [ -d "$FILE1" ]; then
	 cat "$FILE1/Bookmarks" |grep "https"  >>bookmrks.txt
else
	echo -e "\nGoogle Chrome is not installed on the device"
fi

FILE2=/home/ashutosh/.config/BraveSoftware/Brave-Browser/Default
if [ -d "$FILE2" ]; then
	grep "https" "$FILE2/Bookmarks" >>bookmrks.txt
else
	echo -e "\nBrave is not installed on the device"
fi


FILE3=/home/ashutosh/.mozilla/firefox/qwunym1p.default-release-1704909835741
SQLITE_FILE="/home/ashutosh/.mozilla/firefox/qwunym1p.default-release-1704909835741/places.sqlite"
OUTPUT_FILE="bookmrks.txt"
if [ -d "$FILE3" ]; then
	sqlite3 "$SQLITE_FILE" <<EOF >> "$OUTPUT_FILE"
.mode csv
SELECT moz_bookmarks.title, moz_places.url
FROM moz_bookmarks
JOIN moz_places ON moz_bookmarks.fk = moz_places.id
WHERE moz_bookmarks.type = 1;
EOF
else
	echo -e "\nMozilla Firefox is not installed on the device"
fi

echo "Bookmarks extracted to $OUTPUT_FILE "

