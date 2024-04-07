CREATE TABLE identitys (
 id INT(10) NOT NULL AUTO_INCREMENT,
 name VARCHAR(45) NOT NULL,
 PRIMARY KEY(`id`)
);

INSERT INTO `identitys` (`name`) VALUES ('company');
INSERT INTO `identitys` (`name`) VALUES ('client');
INSERT INTO `identitys` (`name`) VALUES ('employee');

ALTER TABLE `users` 
ADD COLUMN `client_id` INT NULL DEFAULT NULL AFTER `company_id`;

CREATE TABLE `states` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `abbr` VARCHAR(2) NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`));

INSERT into states (abbr,name) values ('AL', 'Alabama'),
('AK', 'Alaska'),
('AL', 'Alabama'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('PR', 'Puerto Rico'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming');

ALTER TABLE `users` 
ADD COLUMN `cell` VARCHAR(45) NULL DEFAULT NULL AFTER `phone`;

CREATE TABLE `jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `client_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `zip` varchar(16) DEFAULT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `client_id` int NOT NULL,
  `job_id` int NOT NULL,
  `start` date NOT NULL,
  `end` date DEFAULT NULL,
  `employee_cnt` int DEFAULT 0,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `skills` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` VARCHAR(45) DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);

CREATE TABLE `schedule_skills` (
  `schedule_id` int NOT NULL,
  `skill_id` int NOT NULL
);

CREATE TABLE `employee_skills` (
  `user_id` int NOT NULL,
  `skill_id` int NOT NULL
);

CREATE TABLE `schedule_assignments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `schedule_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` VARCHAR(45) DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);

CREATE TABLE `weekdays` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `no` INT NOT NULL,
  `day` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);

INSERT INTO weekdays (`no`,`day`) VALUES (0,'sunday'),
(1,'monday'),
(2,'tuesday'),
(3,'wednesday'),
(4,'thursday'),
(5,'friday'),
(6,'saturday');

CREATE TABLE `holidays` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT DEFAULT NULL,
  `name` VARCHAR(64) NOT NULL,
  `date` VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);

INSERT INTO holidays (`name`,`date`) VALUES
('New Year''s Day','-01-01'),
('MLK Day','Third Monday of January'),
('President''s Day','Third Monday of February'),
('Easter',null),
('Memorial Day','Last Monday of May'),
('Independence Day','-07-04'),
('Labor Day','First Monday of September'),
('Columbus Day','Second Monday of October'),
('Veterans Day','-01-01'),
('Thanksgiving','Fourth Thursday of November'),
('Christmas Eve','-12-24'),
('Christmas Day','-12-25'),
('New Year''s Eve','-12-31');

CREATE TABLE `workdays` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `name` VARCHAR(16) NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` VARCHAR(45) DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);

CREATE TABLE `workday_weekdays` (
  `workday_id` int NOT NULL,
  `weekday_id` int NOT NULL
);

CREATE TABLE `workday_holidays` (
  `workday_id` int NOT NULL,
  `holiday_id` int NOT NULL
);

ALTER TABLE `schedules` 
ADD COLUMN `workday_id` INT NOT NULL AFTER `job_id`;

ALTER TABLE `users` 
ADD COLUMN `sex` VARCHAR(8) NULL DEFAULT 'male' AFTER `password`;

ALTER TABLE `users` 
ADD COLUMN `photo` VARCHAR(64) NOT NULL DEFAULT 'default-avatar.png' AFTER `sex`;

UPDATE `holidays` SET `date` = '*yr*-01-01' WHERE (`id` = '1');
UPDATE `holidays` SET `date` = '*yr*-07-04' WHERE (`id` = '6');
UPDATE `holidays` SET `date` = '*yr*-01-01' WHERE (`id` = '9');
UPDATE `holidays` SET `date` = 'Third Monday of January *yr*' WHERE (`id` = '2');
UPDATE `holidays` SET `date` = 'Third Monday of February *yr*' WHERE (`id` = '3');
UPDATE `holidays` SET `date` = 'Last Monday of May *yr*' WHERE (`id` = '5');
UPDATE `holidays` SET `date` = 'First Monday of September *yr*' WHERE (`id` = '7');
UPDATE `holidays` SET `date` = 'Second Monday of October *yr*' WHERE (`id` = '8');
UPDATE `holidays` SET `date` = 'Fourth Thursday of November *yr*' WHERE (`id` = '10');
UPDATE `holidays` SET `date` = '*yr*-12-24' WHERE (`id` = '11');
UPDATE `holidays` SET `date` = '*yr*-12-25' WHERE (`id` = '12');
UPDATE `holidays` SET `date` = '*yr*-12-31' WHERE (`id` = '13');

ALTER TABLE `users` 
CHANGE COLUMN `photo` `photo` VARCHAR(64) NULL DEFAULT NULL ;


