CREATE TABLE "devices" (
  "id" integer GENERATED ALWAYS AS IDENTITY,
  "device_id" integer,
  "licence_number" integer,
  "first_licenced_on" date,
  "licence_expires_on" date,
  "trade_name" text
);
