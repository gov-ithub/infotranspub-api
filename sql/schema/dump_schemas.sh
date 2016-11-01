#!/usr/bin/env bash

psql -t -X -A -h localhost -d public_transport -U postgres -c "select schema_name from information_schema.schemata where schema_name ilike 'gtfs_%';" | while read -r schema; \
do 
    echo "$schema"
    pg_dump -U postgres -d public_transport -n $schema -s -f $schema.sql 
done

