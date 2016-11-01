#!/usr/bin/env bash

# Usage: ./import_regii.sh Regii_Autonome.csv

set -ue

INPUT_FILE="$1"

psql -h localhost -U postgres -d public_transport -c "drop table if exists regii_autonome"
psql -h localhost -U postgres -d public_transport < ../sql/schema/public/tables/public.regii_autonome.sql
psql -h localhost -U postgres -d public_transport -c "\copy regii_autonome(judet, url) from '$INPUT_FILE' with (format CSV, header true)"
