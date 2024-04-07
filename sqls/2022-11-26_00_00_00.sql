CREATE TABLE `companys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `zip` varchar(16) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `cell` varchar(45) DEFAULT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `companys` (`name`, `address`, `city`, `state`, `zip`, `phone`, `cell`) VALUES ('ABC Leasing', '123 Main St', 'Saint George', 'UT', '84790', '4356667777', '4356809999');

CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `zip` varchar(16) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `cell` varchar(45) DEFAULT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `inventorys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `quantity` int DEFAULT 0,
  `code` varchar(45) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

