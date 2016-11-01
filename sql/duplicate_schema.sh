#!/usr/bin/env bash

# Usage: ./duplicate_schema.sh gtfs_brasov gtfs_bucuresti

set -xue

FROM="$1"
TO="$2"

infile="${FROM}.sql"
outfile="${TO}.sql"

pg_dump -h localhost -U postgres -d public_transport -n "$FROM" -s -f "$infile"
sed -i "s/$FROM/$TO/g" "$infile"

mv "$infile" "$outfile"

psql -h localhost -U postgres -d public_transport -c "drop schema if exists $TO"
psql -h localhost -U postgres -d public_transport < "$outfile" 
