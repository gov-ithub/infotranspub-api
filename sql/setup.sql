\c public_transport

-- verify available extensions
SELECT name, default_version,installed_version 
FROM pg_available_extensions ORDER BY name;

SELECT PostGIS_full_version();

-- install extension for spatial database
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION postgis_tiger_geocoder; 
CREATE EXTENSION pgrouting;
