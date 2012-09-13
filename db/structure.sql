--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: crickets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE crickets (
    id integer NOT NULL,
    name text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: crickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE crickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: crickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE crickets_id_seq OWNED BY crickets.id;


--
-- Name: custom_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE custom_fields (
    id integer NOT NULL,
    key text,
    value text,
    custom_fieldable_id integer,
    custom_fieldable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: custom_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE custom_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE custom_fields_id_seq OWNED BY custom_fields.id;


--
-- Name: horseflies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horseflies (
    id integer NOT NULL,
    name text,
    parts hstore,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: horseflies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE horseflies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: horseflies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE horseflies_id_seq OWNED BY horseflies.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY crickets ALTER COLUMN id SET DEFAULT nextval('crickets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY custom_fields ALTER COLUMN id SET DEFAULT nextval('custom_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY horseflies ALTER COLUMN id SET DEFAULT nextval('horseflies_id_seq'::regclass);


--
-- Name: crickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY crickets
    ADD CONSTRAINT crickets_pkey PRIMARY KEY (id);


--
-- Name: custom_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY custom_fields
    ADD CONSTRAINT custom_fields_pkey PRIMARY KEY (id);


--
-- Name: horseflies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horseflies
    ADD CONSTRAINT horseflies_pkey PRIMARY KEY (id);


--
-- Name: custom_fields_gin_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX custom_fields_gin_key ON custom_fields USING btree (key);


--
-- Name: custom_fields_gin_value; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX custom_fields_gin_value ON custom_fields USING btree (value);


--
-- Name: horseflies_gin_parts; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX horseflies_gin_parts ON horseflies USING gin (parts);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120912134000');

INSERT INTO schema_migrations (version) VALUES ('20120912134739');

INSERT INTO schema_migrations (version) VALUES ('20120912134839');

INSERT INTO schema_migrations (version) VALUES ('20120912135323');