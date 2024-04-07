CREATE TABLE `timezones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `abbreviation` VARCHAR(16) NOT NULL,
  `name` VARCHAR(16) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `offset` INT NOT NULL,
  `status` VARCHAR(16) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`));

INSERT INTO `timezones` (`abbreviation`, `name`, `location`, `offset`) VALUES ('EST', 'Eastern', 'America/New_York', '5');
INSERT INTO `timezones` (`abbreviation`, `name`, `location`, `offset`) VALUES ('CST', 'Central', 'America/Chicago', '6');
INSERT INTO `timezones` (`abbreviation`, `name`, `location`, `offset`) VALUES ('MDT', 'Mountain', 'America/Denver', '6');
INSERT INTO `timezones` (`abbreviation`, `name`, `location`, `offset`) VALUES ('MST', 'Mountain no DST', 'America/Phoenix', '7');
INSERT INTO `timezones` (`abbreviation`, `name`, `location`, `offset`) VALUES ('PST', 'Pacific', 'America/Los_Angeles', '8');
INSERT INTO `timezones` (`abbreviation`, `name`, `location`, `offset`) VALUES ('AKST', 'Alaska', 'America/Anchorage', '9');
INSERT INTO `timezones` (`abbreviation`, `name`, `location`, `offset`) VALUES ('HADT', 'Hawaii', 'America/Adak', '9');
INSERT INTO `timezones` (`abbreviation`, `name`, `location`, `offset`) VALUES ('HAST', 'Hawaii no DST', 'Pacific/Honolulu', '10');

ALTER TABLE `users` 
ADD COLUMN `timezone_id` INT NOT NULL DEFAULT 3 AFTER `photo`;
