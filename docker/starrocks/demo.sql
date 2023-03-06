CREATE TABLE `products` (
  `id` int NOT NULL,
  `productCode` varchar(15) NOT NULL,
  `productName` varchar(70) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `productScale` varchar(10) NOT NULL,
  `productVendor` varchar(50) NOT NULL,
  `productDescription` varchar(256) NOT NULL,
  `quantityInStock` int NOT NULL,
  `buyPrice` decimal(10, 2) NOT NULL,
  `MSRP` decimal(10, 2) NOT NULL
) DISTRIBUTED BY HASH(id);

CREATE TABLE IF NOT EXISTS products (
  id INT,
  productCode STRING,
  productName STRING,
  productLine STRING,
  productScale STRING,
  productVendor STRING,
  productDescription STRING,
  quantityInStock INT,
  buyPrice DECIMAL(10, 2),
  MSRP DECIMAL(10, 2)
)
DISTRIBUTED BY HASH(id)
PROPERTIES(
    "replication_num" = "1"
);