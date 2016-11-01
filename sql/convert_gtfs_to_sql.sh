#!/usr/bin/env bash

set -ue

# Usage: ./convert_gtfs_to_sql.sh "$HOME/Projects/Me/GovITHub/ratbv-to-gtfs-converter/old_data/brasov/"

GTFS_CONVERTER_HOME="gtfs_to_sql_converter/src"
INPUT_GTFS_FEED="$1"

pushd "$GTFS_CONVERTER_HOME"

cat gtfs_tables.sql \
    <(python2 import_gtfs_to_sql.py "$INPUT_GTFS_FEED" ) \
    gtfs_tables_makespatial.sql \
    gtfs_tables_makeindexes.sql \
    vacuumer.sql > ../../out_postgres.sql
    
popd