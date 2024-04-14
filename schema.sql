--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Debian 14.11-1.pgdg120+2)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: typecode; Type: TYPE; Schema: public; Owner: mdall
--

CREATE TYPE public.typecode AS ENUM (
    'D',
    'S',
    'K',
    'F',
    'G',
    'Y',
    ''
);


ALTER TYPE public.typecode OWNER TO mdall;

--
-- Name: typedescription; Type: TYPE; Schema: public; Owner: mdall
--

CREATE TYPE public.typedescription AS ENUM (
    'Single Device',
    'System',
    'Test Kit',
    'Device Family',
    'Device Group',
    'Device Group Family',
    'Unknown'
);


ALTER TYPE public.typedescription OWNER TO mdall;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: companies; Type: TABLE; Schema: public; Owner: mdall
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name text,
    address text,
    postal_code text,
    city text,
    country text,
    region text,
    status text
);


ALTER TABLE public.companies OWNER TO mdall;

--
-- Name: devices; Type: TABLE; Schema: public; Owner: mdall
--

CREATE TABLE public.devices (
    id integer NOT NULL,
    name text,
    licence_number integer
);


ALTER TABLE public.devices OWNER TO mdall;

--
-- Name: licence_types; Type: TABLE; Schema: public; Owner: mdall
--

CREATE TABLE public.licence_types (
    id integer NOT NULL,
    code public.typecode,
    description public.typedescription
);


ALTER TABLE public.licence_types OWNER TO mdall;

--
-- Name: licences; Type: TABLE; Schema: public; Owner: mdall
--

CREATE TABLE public.licences (
    number integer NOT NULL,
    status text,
    risk_class integer,
    created_on date,
    refreshed_on date,
    expired_on date,
    licence_type_id integer,
    company_id integer
);


ALTER TABLE public.licences OWNER TO mdall;

--
-- Name: licences_devices; Type: TABLE; Schema: public; Owner: mdall
--

CREATE TABLE public.licences_devices (
    id integer NOT NULL,
    licence_number integer,
    device_id integer
);


ALTER TABLE public.licences_devices OWNER TO mdall;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: mdall
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    dirty boolean NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO mdall;

--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (id);


--
-- Name: licence_types licence_types_pkey; Type: CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.licence_types
    ADD CONSTRAINT licence_types_pkey PRIMARY KEY (id);


--
-- Name: licences_devices licences_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.licences_devices
    ADD CONSTRAINT licences_devices_pkey PRIMARY KEY (id);


--
-- Name: licences licences_pkey; Type: CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.licences
    ADD CONSTRAINT licences_pkey PRIMARY KEY (number);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: licences licences_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.licences
    ADD CONSTRAINT licences_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: licences_devices licences_devices_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.licences_devices
    ADD CONSTRAINT licences_devices_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(id);


--
-- Name: licences_devices licences_devices_licence_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.licences_devices
    ADD CONSTRAINT licences_devices_licence_number_fkey FOREIGN KEY (licence_number) REFERENCES public.licences(number);


--
-- Name: licences licences_licence_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mdall
--

ALTER TABLE ONLY public.licences
    ADD CONSTRAINT licences_licence_type_id_fkey FOREIGN KEY (licence_type_id) REFERENCES public.licence_types(id);


--
-- PostgreSQL database dump complete
--

