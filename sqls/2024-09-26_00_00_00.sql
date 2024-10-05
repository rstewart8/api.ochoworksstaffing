CREATE TABLE `notification_queue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `which` varchar(32) NOT NULL,
  `data` JSON NOT NULL, 
  `message` varchar(512) DEFAULT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT 'pending',
  PRIMARY KEY (`id`)
);

CREATE TABLE `user_schedule_notifications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `schedule_id` INT NOT NULL,
  `notification_id` INT NOT NULL,
  `notification_queue_id` INT NOT NULL,
  `which` varchar(32) NOT NULL, 
  `message` varchar(512) DEFAULT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT 'pending',
  PRIMARY KEY (`id`)
);