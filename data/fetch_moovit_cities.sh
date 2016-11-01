#!/usr/bin/env bash

set -ue

OUTPUT_FILE="Moovit_Cities.csv"
echo "City" > "$OUTPUT_FILE"
xidel -q -e "//*/div/article/ul/li[47]/span[contains(@class, 'city-dump')]" --data=http://moovitapp.com/cities/ | tee -a "$OUTPUT_FILE"
tail -n +2 "$OUTPUT_FILE" | wc -l

# cat "$OUTPUT_FILE" | awk -F'\n' '{print "\"" $1 "\""; }' | tr '\n' ','