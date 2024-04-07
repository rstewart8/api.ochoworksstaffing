CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `address` varchar(256) NULL,
	`city` varchar(45) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `zip` varchar(16) DEFAULT NULL,
  `email` varchar(256) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45)DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

ALTER TABLE `users` 
ADD COLUMN `role_id` INT(11) NULL DEFAULT NULL AFTER `id`;

ALTER TABLE `users` 
ADD COLUMN `identity_id` INT NOT NULL AFTER `role_id`;

/*Test user with password = password*/

INSERT INTO users (company_id,role_id,identity_id,firstname,lastname,email,password,created,status) VALUES (1,1,1,'Test','User','test@user.com','5f4dcc3b5aa765d61d8327deb882cf99',NOW(),'active');