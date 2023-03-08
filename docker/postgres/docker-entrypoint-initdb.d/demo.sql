\connect "etl";

DROP TABLE IF EXISTS public.products;

CREATE TABLE public.products (
    id SERIAL NOT NULL,
    product_code varchar(15) NOT NULL,
    product_name varchar(70) NOT NULL,
    product_line varchar(50),
    product_scale varchar(10),
    product_count varchar(10),
    product_base varchar(10),
    product_vendor varchar(50),
    product_description text,
    quantity_in_stock smallint,
    buy_price decimal(10, 2),
    msrp decimal(10, 2),
    PRIMARY KEY (id)
);