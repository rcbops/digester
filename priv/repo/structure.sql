--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: audispd_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE audispd_logs (
    id integer NOT NULL,
    datetime character varying(255),
    node character varying(255),
    type character varying(255),
    msg character varying(255),
    pid character varying(255),
    uid character varying(255),
    auid character varying(255),
    ses character varying(255),
    acct character varying(255),
    exe character varying(255),
    hostname character varying(255),
    addr character varying(255),
    terminal character varying(255),
    res character varying(255),
    content text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: audispd_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE audispd_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audispd_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE audispd_logs_id_seq OWNED BY audispd_logs.id;


--
-- Name: cron_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cron_logs (
    id integer NOT NULL,
    host_id character varying(255),
    rax_host_id character varying(255),
    rax_account_id character varying(255),
    content text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    datetime character varying(255),
    ip_address character varying(255),
    process_info jsonb,
    "user" character varying(255)
);


--
-- Name: hosts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hosts (
    id integer NOT NULL,
    brand character varying(255),
    model character varying(255),
    serial character varying(255),
    bios character varying(255),
    firmware character varying(255),
    cpus character varying(255),
    disks character varying(255),
    nics character varying(255),
    raid character varying(255),
    ram character varying(255),
    os character varying(255),
    openstack character varying(255),
    software character varying(255),
    region character varying(255),
    rack_id character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: hosts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hosts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hosts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hosts_id_seq OWNED BY hosts.id;


--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE logs_id_seq OWNED BY cron_logs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: audispd_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY audispd_logs ALTER COLUMN id SET DEFAULT nextval('audispd_logs_id_seq'::regclass);


--
-- Name: cron_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cron_logs ALTER COLUMN id SET DEFAULT nextval('logs_id_seq'::regclass);


--
-- Name: hosts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hosts ALTER COLUMN id SET DEFAULT nextval('hosts_id_seq'::regclass);


--
-- Name: audispd_logs audispd_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY audispd_logs
    ADD CONSTRAINT audispd_logs_pkey PRIMARY KEY (id);


--
-- Name: hosts hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hosts
    ADD CONSTRAINT hosts_pkey PRIMARY KEY (id);


--
-- Name: cron_logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cron_logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20170117154014), (20170117162035), (20170118021925), (20170118162025), (20170118162731), (20170118215535), (20170118223707), (20170118223909), (20170118233047), (20170119205157), (20170119213417);

