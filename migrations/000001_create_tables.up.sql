CREATE TABLE "companies" (
  "id" integer PRIMARY KEY UNIQUE,
  "name" text,
  "address" text,
  "postal_code" text,
  "city" text,
  "country" text,
  "region" text,
  "status" text
);

CREATE TABLE "devices" (
  "id" integer PRIMARY KEY UNIQUE,
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

CREATE TABLE "licence_types" (
  "id" integer PRIMARY KEY UNIQUE GENERATED ALWAYS AS IDENTITY,
  "code" typecode,
  "description" typedescription
);

CREATE TABLE "licences" (
  "number" integer PRIMARY KEY UNIQUE,
  "status" text,
  "risk_class" integer,
  "created_on" date,
  "refreshed_on" date,
  "expired_on" date,
  "licence_type_id" integer REFERENCES licence_types(id),
  "company_id" integer REFERENCES companies(id)
);

CREATE TABLE "licences_devices" (
  "id" integer PRIMARY KEY UNIQUE,
  "licence_number" integer REFERENCES licences(number),
  "device_id" integer REFERENCES devices(id)
);
