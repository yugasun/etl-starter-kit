CREATE TABLE `products` (
  `id` int NOT NULL,
  `product_code` varchar(15) NOT NULL,
  `product_name` varchar(70) NOT NULL,
  `product_line` varchar(50) NOT NULL,
  `product_scale` varchar(10) NOT NULL,
  `product_vendor` varchar(50) NOT NULL,
  `product_description` varchar(256) NOT NULL,
  `quantity_in_stock` int NOT NULL,
  `buy_price` decimal(10, 2) NOT NULL,
  `MSRP` decimal(10, 2) NOT NULL
) DISTRIBUTED BY HASH(id);

CREATE TABLE IF NOT EXISTS products (
  id INT,
  product_code STRING,
  product_name STRING,
  product_line STRING,
  product_scale STRING,
  product_vendor STRING,
  product_description STRING,
  quantity_in_stock INT,
  buy_price DECIMAL(10, 2),
  MSRP DECIMAL(10, 2)
)
DISTRIBUTED BY HASH(id)
PROPERTIES(
    "replication_num" = "1"
);