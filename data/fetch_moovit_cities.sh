#!/usr/bin/env bash

set -ue

xidel -q -e "//*/div/article/ul/li[47]/span[contains(@class, 'city-dump')]" --data=http://moovitapp.com/cities/ | tee Moovit_Cities.csv
wc -l < Moovit_Cities.csv