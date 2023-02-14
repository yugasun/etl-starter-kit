\c etl;
drop table if exists public.test;

create table public.test (
    id bigint,
    name varchar(128) not null,
    date date,
    is_active bool,
    text bytea
);

DROP TABLE IF EXISTS public.products;

CREATE TABLE public.products (
    id SERIAL NOT NULL,
    productCode varchar(15) NOT NULL,
    productName varchar(70) NOT NULL,
    productLine varchar(50),
    productScale varchar(10),
    productCount varchar(10),
    productBase varchar(10),
    productVendor varchar(50),
    productDescription text,
    quantityInStock smallint,
    buyPrice decimal(10, 2),
    MSRP decimal(10, 2),
    PRIMARY KEY (id)
);