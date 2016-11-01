#!/usr/bin/env bash

psql -h localhost -d public_transport -U postgres -f setup.sql  
