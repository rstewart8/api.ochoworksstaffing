CREATE TABLE roles (
 id INT(10) NOT NULL AUTO_INCREMENT,
 name VARCHAR(45) NOT NULL,
 PRIMARY KEY(`id`)
);

CREATE TABLE `user_permissions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `controller` VARCHAR(45) NOT NULL,
  `method` VARCHAR(45) NOT NULL,
  `permission_type` INT(1) NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `role_permissions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `role_id` INT(11) NOT NULL,
  `controller` VARCHAR(45) NOT NULL,
  `method` VARCHAR(45) NOT NULL,
  `permission_type` INT(1) NULL,
  PRIMARY KEY (`id`)
);

ALTER TABLE `user_permissions` 
CHANGE COLUMN `permission_type` `get` INT(1) NOT NULL DEFAULT 0 ,
ADD COLUMN `post` INT(1) NOT NULL DEFAULT 0 AFTER `get`,
ADD COLUMN `put` INT(1) NOT NULL DEFAULT 0 AFTER `post`,
ADD COLUMN `delete` INT(1) NOT NULL DEFAULT 0 AFTER `put`;

ALTER TABLE `role_permissions` 
CHANGE COLUMN `permission_type` `get` INT(1) NOT NULL DEFAULT 0 ,
ADD COLUMN `post` INT(1) NOT NULL DEFAULT 0 AFTER `get`,
ADD COLUMN `put` INT(1) NOT NULL DEFAULT 0 AFTER `post`,
ADD COLUMN `delete` INT(1) NOT NULL DEFAULT 0 AFTER `put`;

INSERT INTO `roles` (`name`) VALUES ('admin');
INSERT INTO `roles` (`name`) VALUES ('manager');
INSERT INTO `roles` (`name`) VALUES ('standard');

ALTER TABLE `user_permissions` 
CHANGE COLUMN `method` `function` VARCHAR(45) NOT NULL ;
ALTER TABLE `role_permissions` 
CHANGE COLUMN `method` `function` VARCHAR(45) NOT NULL ;

CREATE TABLE `identity_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identity_id` int NOT NULL,
  `controller` varchar(45) NOT NULL,
  `function` varchar(45) NOT NULL,
  `get` int NOT NULL DEFAULT '0',
  `post` int NOT NULL DEFAULT '0',
  `put` int NOT NULL DEFAULT '0',
  `delete` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
);





