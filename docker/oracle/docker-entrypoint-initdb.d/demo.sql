BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE products';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE PRODUCTS (
    id number(10) NOT NULL,
    product_code varchar2(15),
    product_name varchar2(70),
    product_line varchar2(50),
    product_scale varchar2(10),
    product_vendor varchar2(50),
    product_description clob,
    quantity_in_stock number(5),
    buy_price number(10, 2),
    msrp number(10, 2)
);