CREATE TABLE `notifications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `notification_type` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `status` VARCHAR(16) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`)
);

INSERT into notifications (notification_type,name) values 
('sms', 'Text'),
('phone', 'Phone'),
('app', 'Mobile App'),
('email', 'Email');

CREATE TABLE `company_notifications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `notification_id` int NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45)DEFAULT 'active',
  PRIMARY KEY (`id`)
);

CREATE TABLE `employee_notifications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `notification_id` int NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45)DEFAULT 'active',
  PRIMARY KEY (`id`)
);