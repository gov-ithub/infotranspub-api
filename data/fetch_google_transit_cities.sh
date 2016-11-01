#!/usr/bin/env bash

OUTPUT_FILE="GoogleMaps_Transit_Cities.csv"
echo "City" > "$OUTPUT_FILE"

# TODO
xidel -q -e "//*/div/article/ul/li[47]/span[contains(@class, 'city-dump')]" --data='https://maps.google.com/landing/transit/cities/#Europe' | tee -a "$OUTPUT_FILE"
tail -n +2 "$OUTPUT_FILE" | wc -l

# cat "$OUTPUT_FILE" | awk -F'\n' '{print "\"" $1 "\""; }' | tr '\n' ','