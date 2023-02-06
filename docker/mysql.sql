drop table if exists test;

create table test (
    id int(32),
    name varchar(128) not null,
    date date,
    is_active bool,
    text blob
) engine = InnoDB default charset = utf8;

DROP TABLE IF EXISTS `products_bak`;

CREATE TABLE `products_bak` (
    `id` int NOT NULL AUTO_INCREMENT,
    `productCode` varchar(15) NOT NULL,
    `productName` varchar(70) NOT NULL,
    `productLine` varchar(50) NOT NULL,
    `productScale` varchar(10) NOT NULL,
    `productVendor` varchar(50) NOT NULL,
    `productDescription` text NOT NULL,
    `quantityInStock` smallint NOT NULL,
    `buyPrice` decimal(10, 2) NOT NULL,
    `MSRP` decimal(10, 2) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;