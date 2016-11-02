#!/usr/bin/env bash

set -ue

OUTPUT_FILE="GoogleMaps_Transit_Cities.csv"
echo "City" > "$OUTPUT_FILE"

COVERAGE_FILE="google_maps_transit_coverage.json"

if [[ ! -f "$COVERAGE_FILE" || $(stat -c '%Y' "$COVERAGE_FILE") -le $(($(date +%s)-86400)) ]]; then
    curl -s 'https://maps.google.com/landing/transit/assets/coverage.json' -H 'Host: maps.google.com' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Connection: Close' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' > "$COVERAGE_FILE"
fi

echo "Region,Agency Name,Agency URL,Unofficial Source,Routing Enabled" > "$OUTPUT_FILE"
jq -r '.root.child[3].child[26].agency[] | [ "Multi-Region", .name, .url, .unofficial_source, .routing_enabled ] | @csv' "$COVERAGE_FILE"  >> "$OUTPUT_FILE"
jq -r '.root.child[3].child[26].child[] | .name as $name | (.agency[] | [$name, .name, .url, .unofficial_source, .routing_enabled]) | @csv' "$COVERAGE_FILE"  >> "$OUTPUT_FILE"
tail -n +2 "$OUTPUT_FILE" | wc -l