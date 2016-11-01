#!/usr/bin/env bash

# Usage: ./postgres_import.sh gtfs_brasov out_postgres.sql

set -ue

SCHEMA_NAME="$1"
SQL_FILEPATH="$2"

psql -X -h localhost -U postgres -d public_transport -f "postgres_import.sql" \
    --set SCHEMA_NAME="$SCHEMA_NAME" \
    --set SQL_FILEPATH="$SQL_FILEPATH"
psql_exit_status=$?

if [[ $psql_exit_status != 0 ]]; then
    echo "psql failed while trying to run this sql script" 1>&2
    exit $psql_exit_status
fi

exit 0