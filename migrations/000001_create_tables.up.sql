-- Migration to create all tables in database
CREATE TABLE
  companies (
    "id" integer PRIMARY KEY UNIQUE,
    "name" text,
    "address" text,
    "postal_code" text,
    "city" text,
    "country" text,
    "region" text,
    "status" text
  );

CREATE TABLE
  devices (
    "id" integer PRIMARY KEY UNIQUE GENERATED ALWAYS AS IDENTITY,
    "device_id" integer,
    "name" text,
    "licence_number" integer
  );

CREATE TYPE typecode AS ENUM ('D', 'S', 'K', 'F', 'G', 'Y', '');

CREATE TYPE typedescription AS ENUM (
  'Single Device',
  'System',
  'Test Kit',
  'Device Family',
  'Device Group',
  'Device Group Family',
  'Unknown'
);

CREATE TABLE
  licence_types (
    "id" integer PRIMARY KEY UNIQUE GENERATED ALWAYS AS IDENTITY,
    "code" typecode,
    "description" typedescription
  );

-- NOTE: id and number may cause problems - to be followed
CREATE TABLE
  licences (
    "id" integer PRIMARY KEY UNIQUE GENERATED ALWAYS AS IDENTITY,
    "number" integer,
    "status" text,
    "risk_class" integer,
    "name" text,
    "created_on" date,
    "refreshed_on" date,
    "expired_on" date,
    "licence_type_id" integer REFERENCES licence_types (id),
    "company_id" integer REFERENCES companies (id)
  );

CREATE TABLE
  licences_devices (
    "licence_id" INTEGER REFERENCES licences (id),
    "device_id" INTEGER REFERENCES devices (id),
    CONSTRAINT licences_devices_pk PRIMARY KEY (licence_id, device_id)
  );