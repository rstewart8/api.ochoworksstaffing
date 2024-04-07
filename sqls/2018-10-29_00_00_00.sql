CREATE TABLE `system_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


/*sysAdmin user with password = password*/
INSERT INTO system_users (username,password,created,status) VALUES ('sysAdmin','5f4dcc3b5aa765d61d8327deb882cf99',NOW(),'active');