-- Adminer 4.8.1 PostgreSQL 11.5 (Debian 11.5-3.pgdg90+1) dump

\connect "etl";

DROP TABLE IF EXISTS "customer";
CREATE TABLE "public"."customer" (
    "c_w_id" integer NOT NULL,
    "c_d_id" integer NOT NULL,
    "c_id" integer NOT NULL,
    "c_discount" numeric(4,4) NOT NULL,
    "c_credit" character(2) NOT NULL,
    "c_last" character varying(16) NOT NULL,
    "c_first" character varying(16) NOT NULL,
    "c_credit_lim" numeric(12,2) NOT NULL,
    "c_balance" numeric(12,2) NOT NULL,
    "c_ytd_payment" double precision NOT NULL,
    "c_payment_cnt" integer NOT NULL,
    "c_delivery_cnt" integer NOT NULL,
    "c_street_1" character varying(20) NOT NULL,
    "c_street_2" character varying(20) NOT NULL,
    "c_city" character varying(20) NOT NULL,
    "c_state" character(2) NOT NULL,
    "c_zip" character(9) NOT NULL,
    "c_phone" character(16) NOT NULL,
    "c_since" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "c_middle" character(2) NOT NULL,
    "c_data" character varying(500) NOT NULL,
    CONSTRAINT "customer_pkey" PRIMARY KEY ("c_w_id", "c_d_id", "c_id")
) WITH (oids = false);

CREATE INDEX "idx_customer_name" ON "public"."customer" USING btree ("c_w_id", "c_d_id", "c_last", "c_first");


ALTER TABLE ONLY "public"."customer" ADD CONSTRAINT "customer_c_w_id_fkey" FOREIGN KEY (c_w_id, c_d_id) REFERENCES district(d_w_id, d_id) ON DELETE CASCADE NOT DEFERRABLE;

-- 2023-02-13 09:23:41.667266+00
