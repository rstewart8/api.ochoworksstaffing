ALTER TABLE `schedules` 
ADD COLUMN `time_start` TIME NOT NULL DEFAULT '08:00:00' after `end`;

ALTER TABLE `schedules` 
ADD COLUMN `time_end` VARCHAR(16) NOT NULL DEFAULT '17:00:00' after `time_start`;

ALTER TABLE `schedules` 
ADD COLUMN `notes` VARCHAR(512) NULL DEFAULT NULL after `employee_cnt`;


