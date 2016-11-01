--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: gtfs_brasov; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA gtfs_brasov;


ALTER SCHEMA gtfs_brasov OWNER TO postgres;

SET search_path = gtfs_brasov, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: gtfs_agency; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_agency (
    agency_id text NOT NULL,
    agency_name text NOT NULL,
    agency_url text NOT NULL,
    agency_timezone text NOT NULL,
    agency_lang text,
    agency_phone text,
    agency_fare_url text
);


ALTER TABLE gtfs_agency OWNER TO postgres;

--
-- Name: gtfs_calendar; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_calendar (
    service_id text NOT NULL,
    monday integer NOT NULL,
    tuesday integer NOT NULL,
    wednesday integer NOT NULL,
    thursday integer NOT NULL,
    friday integer NOT NULL,
    saturday integer NOT NULL,
    sunday integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE gtfs_calendar OWNER TO postgres;

--
-- Name: gtfs_calendar_dates; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_calendar_dates (
    service_id text,
    date date,
    exception_type integer
);


ALTER TABLE gtfs_calendar_dates OWNER TO postgres;

--
-- Name: gtfs_directions; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_directions (
    direction_id integer NOT NULL,
    description text
);


ALTER TABLE gtfs_directions OWNER TO postgres;

--
-- Name: gtfs_fare_attributes; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_fare_attributes (
    fare_id text NOT NULL,
    price double precision NOT NULL,
    currency_type text NOT NULL,
    payment_method integer,
    transfers integer,
    transfer_duration integer,
    agency_id text
);


ALTER TABLE gtfs_fare_attributes OWNER TO postgres;

--
-- Name: gtfs_fare_rules; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_fare_rules (
    fare_id text,
    route_id text,
    origin_id text,
    destination_id text,
    contains_id text,
    service_id text
);


ALTER TABLE gtfs_fare_rules OWNER TO postgres;

--
-- Name: gtfs_feed_info; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_feed_info (
    feed_publisher_name text,
    feed_publisher_url text,
    feed_timezone text,
    feed_lang text,
    feed_version text,
    feed_start_date text,
    feed_end_date text
);


ALTER TABLE gtfs_feed_info OWNER TO postgres;

--
-- Name: gtfs_frequencies; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_frequencies (
    trip_id text,
    start_time text NOT NULL,
    end_time text NOT NULL,
    headway_secs integer NOT NULL,
    exact_times integer,
    start_time_seconds integer,
    end_time_seconds integer
);


ALTER TABLE gtfs_frequencies OWNER TO postgres;

--
-- Name: gtfs_location_types; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_location_types (
    location_type integer NOT NULL,
    description text
);


ALTER TABLE gtfs_location_types OWNER TO postgres;

--
-- Name: gtfs_payment_methods; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_payment_methods (
    payment_method integer NOT NULL,
    description text
);


ALTER TABLE gtfs_payment_methods OWNER TO postgres;

--
-- Name: gtfs_pickup_dropoff_types; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_pickup_dropoff_types (
    type_id integer NOT NULL,
    description text
);


ALTER TABLE gtfs_pickup_dropoff_types OWNER TO postgres;

--
-- Name: gtfs_route_types; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_route_types (
    route_type integer NOT NULL,
    description text
);


ALTER TABLE gtfs_route_types OWNER TO postgres;

--
-- Name: gtfs_routes; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_routes (
    route_id text NOT NULL,
    agency_id text,
    route_short_name text DEFAULT ''::text,
    route_long_name text DEFAULT ''::text,
    route_desc text,
    route_type integer,
    route_url text,
    route_color text,
    route_text_color text
);


ALTER TABLE gtfs_routes OWNER TO postgres;

--
-- Name: gtfs_shape_geoms; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_shape_geoms (
    shape_id text,
    the_geom public.geometry(LineString,4326)
);


ALTER TABLE gtfs_shape_geoms OWNER TO postgres;

--
-- Name: gtfs_shapes; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_shapes (
    shape_id text NOT NULL,
    shape_pt_lat double precision NOT NULL,
    shape_pt_lon double precision NOT NULL,
    shape_pt_sequence integer NOT NULL,
    shape_dist_traveled double precision
);


ALTER TABLE gtfs_shapes OWNER TO postgres;

--
-- Name: gtfs_stop_times; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_stop_times (
    trip_id text,
    arrival_time text,
    departure_time text,
    stop_id text,
    stop_sequence integer NOT NULL,
    stop_headsign text,
    pickup_type integer,
    drop_off_type integer,
    shape_dist_traveled double precision,
    timepoint integer,
    arrival_time_seconds integer,
    departure_time_seconds integer,
    CONSTRAINT times_arrtime_check CHECK ((arrival_time ~~ '__:__:__'::text)),
    CONSTRAINT times_deptime_check CHECK ((departure_time ~~ '__:__:__'::text))
);


ALTER TABLE gtfs_stop_times OWNER TO postgres;

--
-- Name: gtfs_stops; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_stops (
    stop_id text NOT NULL,
    stop_name text NOT NULL,
    stop_desc text,
    stop_lat double precision,
    stop_lon double precision,
    zone_id text,
    stop_url text,
    stop_code text,
    stop_street text,
    stop_city text,
    stop_region text,
    stop_postcode text,
    stop_country text,
    location_type integer,
    parent_station text,
    stop_timezone text,
    wheelchair_boarding integer,
    direction text,
    "position" text,
    the_geom public.geometry(Point,4326)
);


ALTER TABLE gtfs_stops OWNER TO postgres;

--
-- Name: gtfs_transfer_types; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_transfer_types (
    transfer_type integer NOT NULL,
    description text
);


ALTER TABLE gtfs_transfer_types OWNER TO postgres;

--
-- Name: gtfs_transfers; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_transfers (
    from_stop_id text,
    to_stop_id text,
    transfer_type integer,
    min_transfer_time integer,
    from_route_id text,
    to_route_id text,
    service_id text
);


ALTER TABLE gtfs_transfers OWNER TO postgres;

--
-- Name: gtfs_trips; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_trips (
    route_id text,
    service_id text,
    trip_id text NOT NULL,
    trip_headsign text,
    direction_id integer NOT NULL,
    block_id text,
    shape_id text,
    trip_short_name text,
    trip_type text
);


ALTER TABLE gtfs_trips OWNER TO postgres;

--
-- Name: gtfs_wheelchair_boardings; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE gtfs_wheelchair_boardings (
    wheelchair_boarding integer NOT NULL,
    description text
);


ALTER TABLE gtfs_wheelchair_boardings OWNER TO postgres;

--
-- Name: service_combinations; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE service_combinations (
    combination_id integer,
    service_id text
);


ALTER TABLE service_combinations OWNER TO postgres;

--
-- Name: service_combo_ids; Type: TABLE; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE TABLE service_combo_ids (
    combination_id integer NOT NULL
);


ALTER TABLE service_combo_ids OWNER TO postgres;

--
-- Name: service_combo_ids_combination_id_seq; Type: SEQUENCE; Schema: gtfs_brasov; Owner: postgres
--

CREATE SEQUENCE service_combo_ids_combination_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service_combo_ids_combination_id_seq OWNER TO postgres;

--
-- Name: service_combo_ids_combination_id_seq; Type: SEQUENCE OWNED BY; Schema: gtfs_brasov; Owner: postgres
--

ALTER SEQUENCE service_combo_ids_combination_id_seq OWNED BY service_combo_ids.combination_id;


--
-- Name: combination_id; Type: DEFAULT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY service_combo_ids ALTER COLUMN combination_id SET DEFAULT nextval('service_combo_ids_combination_id_seq'::regclass);


--
-- Name: agency_name_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_agency
    ADD CONSTRAINT agency_name_pkey PRIMARY KEY (agency_id);


--
-- Name: calendar_sid_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_calendar
    ADD CONSTRAINT calendar_sid_pkey PRIMARY KEY (service_id);


--
-- Name: fare_id_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_fare_attributes
    ADD CONSTRAINT fare_id_pkey PRIMARY KEY (fare_id);


--
-- Name: gtfs_directions_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_directions
    ADD CONSTRAINT gtfs_directions_pkey PRIMARY KEY (direction_id);


--
-- Name: gtfs_location_types_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_location_types
    ADD CONSTRAINT gtfs_location_types_pkey PRIMARY KEY (location_type);


--
-- Name: gtfs_payment_methods_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_payment_methods
    ADD CONSTRAINT gtfs_payment_methods_pkey PRIMARY KEY (payment_method);


--
-- Name: gtfs_pickup_dropoff_types_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_pickup_dropoff_types
    ADD CONSTRAINT gtfs_pickup_dropoff_types_pkey PRIMARY KEY (type_id);


--
-- Name: gtfs_route_types_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_route_types
    ADD CONSTRAINT gtfs_route_types_pkey PRIMARY KEY (route_type);


--
-- Name: gtfs_transfer_types_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_transfer_types
    ADD CONSTRAINT gtfs_transfer_types_pkey PRIMARY KEY (transfer_type);


--
-- Name: gtfs_wheelchair_boardings_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_wheelchair_boardings
    ADD CONSTRAINT gtfs_wheelchair_boardings_pkey PRIMARY KEY (wheelchair_boarding);


--
-- Name: routes_id_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_routes
    ADD CONSTRAINT routes_id_pkey PRIMARY KEY (route_id);


--
-- Name: stops_id_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_stops
    ADD CONSTRAINT stops_id_pkey PRIMARY KEY (stop_id);


--
-- Name: trip_id_pkey; Type: CONSTRAINT; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gtfs_trips
    ADD CONSTRAINT trip_id_pkey PRIMARY KEY (trip_id);


--
-- Name: arr_time_index; Type: INDEX; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE INDEX arr_time_index ON gtfs_stop_times USING btree (arrival_time_seconds);


--
-- Name: dep_time_index; Type: INDEX; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE INDEX dep_time_index ON gtfs_stop_times USING btree (departure_time_seconds);


--
-- Name: gtfs_shape_geoms_the_geom_gist; Type: INDEX; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE INDEX gtfs_shape_geoms_the_geom_gist ON gtfs_shape_geoms USING gist (the_geom);


--
-- Name: gtfs_stops_the_geom_gist; Type: INDEX; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE INDEX gtfs_stops_the_geom_gist ON gtfs_stops USING gist (the_geom);


--
-- Name: stop_seq_index; Type: INDEX; Schema: gtfs_brasov; Owner: postgres; Tablespace: 
--

CREATE INDEX stop_seq_index ON gtfs_stop_times USING btree (trip_id, stop_sequence);


--
-- Name: fare_agency_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_fare_attributes
    ADD CONSTRAINT fare_agency_fkey FOREIGN KEY (agency_id) REFERENCES gtfs_agency(agency_id);


--
-- Name: fare_pay_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_fare_attributes
    ADD CONSTRAINT fare_pay_fkey FOREIGN KEY (payment_method) REFERENCES gtfs_payment_methods(payment_method);


--
-- Name: fare_rid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_fare_rules
    ADD CONSTRAINT fare_rid_fkey FOREIGN KEY (route_id) REFERENCES gtfs_routes(route_id);


--
-- Name: farer_id_pkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_fare_rules
    ADD CONSTRAINT farer_id_pkey FOREIGN KEY (fare_id) REFERENCES gtfs_fare_attributes(fare_id);


--
-- Name: freq_tid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_frequencies
    ADD CONSTRAINT freq_tid_fkey FOREIGN KEY (trip_id) REFERENCES gtfs_trips(trip_id);


--
-- Name: routes_agency_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_routes
    ADD CONSTRAINT routes_agency_fkey FOREIGN KEY (agency_id) REFERENCES gtfs_agency(agency_id);


--
-- Name: routes_rtype_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_routes
    ADD CONSTRAINT routes_rtype_fkey FOREIGN KEY (route_type) REFERENCES gtfs_route_types(route_type);


--
-- Name: stop_location_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_stops
    ADD CONSTRAINT stop_location_fkey FOREIGN KEY (location_type) REFERENCES gtfs_location_types(location_type);


--
-- Name: stop_parent_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_stops
    ADD CONSTRAINT stop_parent_fkey FOREIGN KEY (parent_station) REFERENCES gtfs_stops(stop_id);


--
-- Name: times_dtype_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_stop_times
    ADD CONSTRAINT times_dtype_fkey FOREIGN KEY (drop_off_type) REFERENCES gtfs_pickup_dropoff_types(type_id);


--
-- Name: times_ptype_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_stop_times
    ADD CONSTRAINT times_ptype_fkey FOREIGN KEY (pickup_type) REFERENCES gtfs_pickup_dropoff_types(type_id);


--
-- Name: times_sid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_stop_times
    ADD CONSTRAINT times_sid_fkey FOREIGN KEY (stop_id) REFERENCES gtfs_stops(stop_id);


--
-- Name: times_tid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_stop_times
    ADD CONSTRAINT times_tid_fkey FOREIGN KEY (trip_id) REFERENCES gtfs_trips(trip_id);


--
-- Name: trip_did_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_trips
    ADD CONSTRAINT trip_did_fkey FOREIGN KEY (direction_id) REFERENCES gtfs_directions(direction_id);


--
-- Name: trip_rid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_trips
    ADD CONSTRAINT trip_rid_fkey FOREIGN KEY (route_id) REFERENCES gtfs_routes(route_id);


--
-- Name: xfer_frid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_transfers
    ADD CONSTRAINT xfer_frid_fkey FOREIGN KEY (from_route_id) REFERENCES gtfs_routes(route_id);


--
-- Name: xfer_fsid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_transfers
    ADD CONSTRAINT xfer_fsid_fkey FOREIGN KEY (from_stop_id) REFERENCES gtfs_stops(stop_id);


--
-- Name: xfer_trid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_transfers
    ADD CONSTRAINT xfer_trid_fkey FOREIGN KEY (to_route_id) REFERENCES gtfs_routes(route_id);


--
-- Name: xfer_tsid_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_transfers
    ADD CONSTRAINT xfer_tsid_fkey FOREIGN KEY (to_stop_id) REFERENCES gtfs_stops(stop_id);


--
-- Name: xfer_xt_fkey; Type: FK CONSTRAINT; Schema: gtfs_brasov; Owner: postgres
--

ALTER TABLE ONLY gtfs_transfers
    ADD CONSTRAINT xfer_xt_fkey FOREIGN KEY (transfer_type) REFERENCES gtfs_transfer_types(transfer_type);


--
-- PostgreSQL database dump complete
--

