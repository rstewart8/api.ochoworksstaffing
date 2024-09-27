-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: ochoworksstaffing
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `controller` varchar(45) NOT NULL,
  `function` varchar(45) NOT NULL,
  `get` int NOT NULL DEFAULT '0',
  `post` int NOT NULL DEFAULT '0',
  `put` int NOT NULL DEFAULT '0',
  `delete` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11083 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (10912,1,'user','create',0,1,0,0),(10913,2,'user','create',0,0,0,0),(10914,3,'user','create',0,0,0,0),(10915,1,'user','fetch',1,0,0,0),(10916,2,'user','fetch',1,0,0,0),(10917,3,'user','fetch',1,0,0,0),(10918,1,'user','update',0,0,1,0),(10919,2,'user','update',0,0,0,0),(10920,3,'user','update',0,0,0,0),(10921,1,'user','profile',1,0,1,0),(10922,2,'user','profile',1,0,1,0),(10923,3,'user','profile',1,0,1,0),(10924,1,'user','photo',0,1,0,0),(10925,2,'user','photo',0,1,0,0),(10926,3,'user','photo',0,1,0,0),(10927,1,'user','resetPassword',0,0,1,0),(10928,2,'user','resetPassword',0,0,1,0),(10929,3,'user','resetPassword',0,0,1,0),(10930,1,'client','list',1,0,0,0),(10931,2,'client','list',0,0,0,0),(10932,3,'client','list',0,0,0,0),(10933,1,'client','create',0,1,0,0),(10934,2,'client','create',0,0,0,0),(10935,3,'client','create',0,0,0,0),(10936,1,'client','fetch',1,0,0,0),(10937,2,'client','fetch',1,0,0,0),(10938,3,'client','fetch',0,0,0,0),(10939,1,'client','update',0,0,1,0),(10940,2,'client','update',0,0,0,0),(10941,3,'client','update',0,0,0,0),(10942,1,'client','users',1,0,0,0),(10943,2,'client','users',1,0,0,0),(10944,3,'client','users',0,0,0,0),(10945,1,'client','workdays',1,1,0,0),(10946,2,'client','workdays',1,0,0,0),(10947,3,'client','workdays',1,0,0,0),(10948,1,'utilities','states',1,0,0,0),(10949,2,'utilities','states',1,0,0,0),(10950,3,'utilities','states',1,0,0,0),(10951,1,'utilities','roles',1,0,0,0),(10952,2,'utilities','roles',1,0,0,0),(10953,3,'utilities','roles',0,0,0,0),(10954,1,'utilities','weekdays',1,0,0,0),(10955,2,'utilities','weekdays',1,0,0,0),(10956,3,'utilities','weekdays',1,0,0,0),(10957,1,'utilities','holidays',1,0,0,0),(10958,2,'utilities','holidays',1,0,0,0),(10959,3,'utilities','holidays',1,0,0,0),(10960,1,'utilities','workdays',1,0,0,0),(10961,2,'utilities','workdays',1,0,0,0),(10962,3,'utilities','workdays',1,0,0,0),(10963,1,'utilities','scheduleTimes',1,0,0,0),(10964,2,'utilities','scheduleTimes',1,0,0,0),(10965,3,'utilities','scheduleTimes',1,0,0,0),(10966,1,'job','list',1,0,0,0),(10967,2,'job','list',1,0,0,0),(10968,3,'job','list',0,0,0,0),(10969,1,'job','create',0,1,0,0),(10970,2,'job','create',0,1,0,0),(10971,3,'job','create',0,0,0,0),(10972,1,'job','fetch',1,0,0,0),(10973,2,'job','fetch',1,0,0,0),(10974,3,'job','fetch',0,0,0,0),(10975,1,'job','update',0,0,1,0),(10976,2,'job','update',0,0,1,0),(10977,3,'job','update',0,0,0,0),(10978,1,'schedule','list',1,0,0,0),(10979,2,'schedule','list',1,0,0,0),(10980,3,'schedule','list',0,0,0,0),(10981,1,'schedule','create',0,1,0,0),(10982,2,'schedule','create',0,1,0,0),(10983,3,'schedule','create',0,0,0,0),(10984,1,'schedule','fetch',1,0,0,0),(10985,2,'schedule','fetch',1,0,0,0),(10986,3,'schedule','fetch',0,0,0,0),(10987,1,'schedule','pending',1,0,0,0),(10988,2,'schedule','pending',1,0,0,0),(10989,3,'schedule','pending',0,0,0,0),(10990,1,'schedule','status',1,0,0,0),(10991,2,'schedule','status',1,0,0,0),(10992,3,'schedule','status',0,0,0,0),(10993,1,'schedule','assignment',1,1,0,1),(10994,2,'schedule','assignment',1,1,0,1),(10995,3,'schedule','assignment',0,0,0,0),(10996,1,'schedule','assignments',1,0,0,0),(10997,2,'schedule','assignments',1,0,0,0),(10998,3,'schedule','assignments',0,0,0,0),(10999,1,'schedule','days',1,0,0,0),(11000,2,'schedule','days',1,0,0,0),(11001,3,'schedule','days',0,0,0,0),(11002,1,'schedule','update',1,0,1,0),(11003,2,'schedule','update',1,0,1,0),(11004,3,'schedule','update',0,0,0,0),(11005,1,'schedule','delete',0,0,0,1),(11006,2,'schedule','delete',0,0,0,1),(11007,3,'schedule','delete',0,0,0,0),(11008,1,'schedule','clientReportByDay',1,0,0,0),(11009,2,'schedule','clientReportByDay',1,0,0,0),(11010,3,'schedule','clientReportByDay',0,0,0,0),(11011,1,'schedule','reportData',1,0,0,0),(11012,2,'schedule','reportData',1,0,0,0),(11013,3,'schedule','reportData',0,0,0,0),(11014,1,'schedule','scheduleStatusByRange',1,0,0,0),(11015,2,'schedule','scheduleStatusByRange',1,0,0,0),(11016,3,'schedule','scheduleStatusByRange',0,0,0,0),(11017,1,'schedule','notes',1,0,1,0),(11018,2,'schedule','notes',1,0,1,0),(11019,3,'schedule','notes',1,0,1,0),(11020,1,'schedule','jobReportByDay',1,0,0,0),(11021,2,'schedule','jobReportByDay',1,0,0,0),(11022,3,'schedule','jobReportByDay',0,0,0,0),(11023,1,'skill','create',0,1,0,0),(11024,2,'skill','create',0,1,0,0),(11025,3,'skill','create',0,0,0,0),(11026,1,'skill','list',1,0,0,0),(11027,2,'skill','list',1,0,0,0),(11028,3,'skill','list',0,0,0,0),(11029,1,'skill','delete',0,0,1,0),(11030,2,'skill','delete',0,0,0,0),(11031,3,'skill','delete',0,0,0,0),(11032,1,'employee','list',1,0,0,0),(11033,2,'employee','list',1,0,0,0),(11034,3,'employee','list',0,0,0,0),(11035,1,'employee','create',0,1,0,0),(11036,2,'employee','create',0,1,0,0),(11037,3,'employee','create',0,0,0,0),(11038,1,'employee','schedule',1,0,0,0),(11039,2,'employee','schedule',1,0,0,0),(11040,3,'employee','schedule',0,0,0,0),(11041,1,'employee','available',1,0,0,0),(11042,2,'employee','available',1,0,0,0),(11043,3,'employee','available',0,0,0,0),(11044,1,'employee','assignments',1,0,0,0),(11045,2,'employee','assignments',1,0,0,0),(11046,3,'employee','assignments',0,0,0,0),(11047,1,'employee','fetch',1,0,0,0),(11048,2,'employee','fetch',1,0,0,0),(11049,3,'employee','fetch',1,0,0,0),(11050,1,'employee','update',0,0,1,0),(11051,2,'employee','update',0,0,1,0),(11052,3,'employee','update',0,0,0,0),(11053,1,'employee','workDays',1,1,0,0),(11054,2,'employee','workDays',1,1,0,0),(11055,3,'employee','workDays',1,0,0,0),(11056,1,'employee','skills',1,1,0,0),(11057,2,'employee','skills',1,1,0,0),(11058,3,'employee','skills',1,0,0,0),(11059,1,'employee','assignmentDetails',1,0,0,0),(11060,2,'employee','assignmentDetails',1,0,0,0),(11061,3,'employee','assignmentDetails',1,0,0,0),(11062,1,'employee','forClientByDays',1,0,0,0),(11063,2,'employee','forClientByDays',1,0,0,0),(11064,3,'employee','forClientByDays',0,0,0,0),(11065,1,'company','fetch',1,0,0,0),(11066,2,'company','fetch',0,0,0,0),(11067,3,'company','fetch',0,0,0,0),(11068,1,'company','update',0,0,1,0),(11069,2,'company','update',0,0,0,0),(11070,3,'company','update',0,0,0,0),(11071,1,'company','users',1,0,0,0),(11072,2,'company','users',0,0,0,0),(11073,3,'company','users',0,0,0,0),(11074,1,'notification','list',1,0,0,0),(11075,2,'notification','list',1,0,0,0),(11076,3,'notification','list',1,0,0,0),(11077,1,'notification','companyToggle',0,1,0,0),(11078,2,'notification','companyToggle',0,0,0,0),(11079,3,'notification','companyToggle',0,0,0,0),(11080,1,'notification','employeeToggle',0,1,0,0),(11081,2,'notification','employeeToggle',0,1,0,0),(11082,3,'notification','employeeToggle',0,1,0,0);
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identity_permissions`
--

DROP TABLE IF EXISTS `identity_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10963 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (10792,1,'user','create',0,1,0,0),(10793,2,'user','create',0,1,0,0),(10794,3,'user','create',0,0,0,0),(10795,1,'user','fetch',1,0,0,0),(10796,2,'user','fetch',1,0,0,0),(10797,3,'user','fetch',1,0,0,0),(10798,1,'user','update',0,0,1,0),(10799,2,'user','update',0,0,1,0),(10800,3,'user','update',0,0,0,0),(10801,1,'user','profile',1,0,1,0),(10802,2,'user','profile',1,0,1,0),(10803,3,'user','profile',1,0,1,0),(10804,1,'user','photo',0,1,0,0),(10805,2,'user','photo',0,1,0,0),(10806,3,'user','photo',0,1,0,0),(10807,1,'user','resetPassword',0,0,1,0),(10808,2,'user','resetPassword',0,0,1,0),(10809,3,'user','resetPassword',0,0,1,0),(10810,1,'client','list',1,0,0,0),(10811,2,'client','list',0,0,0,0),(10812,3,'client','list',0,0,0,0),(10813,1,'client','create',0,1,0,0),(10814,2,'client','create',0,0,0,0),(10815,3,'client','create',0,0,0,0),(10816,1,'client','fetch',1,0,0,0),(10817,2,'client','fetch',1,0,0,0),(10818,3,'client','fetch',0,0,0,0),(10819,1,'client','update',0,0,1,0),(10820,2,'client','update',0,0,1,0),(10821,3,'client','update',0,0,0,0),(10822,1,'client','users',1,0,0,0),(10823,2,'client','users',1,0,0,0),(10824,3,'client','users',0,0,0,0),(10825,1,'client','workdays',1,1,0,0),(10826,2,'client','workdays',1,0,0,0),(10827,3,'client','workdays',1,0,0,0),(10828,1,'utilities','states',1,0,0,0),(10829,2,'utilities','states',1,0,0,0),(10830,3,'utilities','states',1,0,0,0),(10831,1,'utilities','roles',1,0,0,0),(10832,2,'utilities','roles',1,0,0,0),(10833,3,'utilities','roles',0,0,0,0),(10834,1,'utilities','weekdays',1,0,0,0),(10835,2,'utilities','weekdays',1,0,0,0),(10836,3,'utilities','weekdays',1,0,0,0),(10837,1,'utilities','holidays',1,0,0,0),(10838,2,'utilities','holidays',1,0,0,0),(10839,3,'utilities','holidays',1,0,0,0),(10840,1,'utilities','workdays',1,0,0,0),(10841,2,'utilities','workdays',1,0,0,0),(10842,3,'utilities','workdays',1,0,0,0),(10843,1,'utilities','scheduleTimes',1,0,0,0),(10844,2,'utilities','scheduleTimes',1,0,0,0),(10845,3,'utilities','scheduleTimes',1,0,0,0),(10846,1,'job','list',1,0,0,0),(10847,2,'job','list',1,0,0,0),(10848,3,'job','list',0,0,0,0),(10849,1,'job','create',0,1,0,0),(10850,2,'job','create',0,1,0,0),(10851,3,'job','create',0,0,0,0),(10852,1,'job','fetch',1,0,0,0),(10853,2,'job','fetch',1,0,0,0),(10854,3,'job','fetch',0,0,0,0),(10855,1,'job','update',0,0,1,0),(10856,2,'job','update',0,0,1,0),(10857,3,'job','update',0,0,0,0),(10858,1,'schedule','list',1,0,0,0),(10859,2,'schedule','list',1,0,0,0),(10860,3,'schedule','list',0,0,0,0),(10861,1,'schedule','create',0,1,0,0),(10862,2,'schedule','create',0,1,0,0),(10863,3,'schedule','create',0,0,0,0),(10864,1,'schedule','fetch',1,0,0,0),(10865,2,'schedule','fetch',1,0,0,0),(10866,3,'schedule','fetch',0,0,0,0),(10867,1,'schedule','pending',1,0,0,0),(10868,2,'schedule','pending',1,0,0,0),(10869,3,'schedule','pending',0,0,0,0),(10870,1,'schedule','status',1,0,0,0),(10871,2,'schedule','status',1,0,0,0),(10872,3,'schedule','status',0,0,0,0),(10873,1,'schedule','assignment',1,1,0,1),(10874,2,'schedule','assignment',1,0,0,0),(10875,3,'schedule','assignment',0,0,0,0),(10876,1,'schedule','assignments',1,0,0,0),(10877,2,'schedule','assignments',1,0,0,0),(10878,3,'schedule','assignments',1,0,0,0),(10879,1,'schedule','days',1,0,0,0),(10880,2,'schedule','days',1,0,0,0),(10881,3,'schedule','days',0,0,0,0),(10882,1,'schedule','update',1,0,1,0),(10883,2,'schedule','update',1,0,1,0),(10884,3,'schedule','update',0,0,0,0),(10885,1,'schedule','delete',0,0,0,1),(10886,2,'schedule','delete',0,0,0,0),(10887,3,'schedule','delete',0,0,0,0),(10888,1,'schedule','clientReportByDay',1,0,0,0),(10889,2,'schedule','clientReportByDay',1,0,0,0),(10890,3,'schedule','clientReportByDay',0,0,0,0),(10891,1,'schedule','reportData',1,0,0,0),(10892,2,'schedule','reportData',1,0,0,0),(10893,3,'schedule','reportData',0,0,0,0),(10894,1,'schedule','scheduleStatusByRange',1,0,0,0),(10895,2,'schedule','scheduleStatusByRange',1,0,0,0),(10896,3,'schedule','scheduleStatusByRange',0,0,0,0),(10897,1,'schedule','notes',1,0,1,0),(10898,2,'schedule','notes',1,0,1,0),(10899,3,'schedule','notes',0,0,0,0),(10900,1,'schedule','jobReportByDay',1,0,0,0),(10901,2,'schedule','jobReportByDay',1,0,0,0),(10902,3,'schedule','jobReportByDay',0,0,0,0),(10903,1,'skill','create',0,1,0,0),(10904,2,'skill','create',0,0,0,0),(10905,3,'skill','create',0,0,0,0),(10906,1,'skill','list',1,0,0,0),(10907,2,'skill','list',1,0,0,0),(10908,3,'skill','list',0,0,0,0),(10909,1,'skill','delete',0,0,1,0),(10910,2,'skill','delete',0,0,0,0),(10911,3,'skill','delete',0,0,0,0),(10912,1,'employee','list',1,0,0,0),(10913,2,'employee','list',0,0,0,0),(10914,3,'employee','list',0,0,0,0),(10915,1,'employee','create',0,1,0,0),(10916,2,'employee','create',0,0,0,0),(10917,3,'employee','create',0,0,0,0),(10918,1,'employee','schedule',1,0,0,0),(10919,2,'employee','schedule',0,0,0,0),(10920,3,'employee','schedule',0,0,0,0),(10921,1,'employee','available',1,0,0,0),(10922,2,'employee','available',0,0,0,0),(10923,3,'employee','available',0,0,0,0),(10924,1,'employee','assignments',1,0,0,0),(10925,2,'employee','assignments',1,0,0,0),(10926,3,'employee','assignments',1,0,0,0),(10927,1,'employee','fetch',1,0,0,0),(10928,2,'employee','fetch',1,0,0,0),(10929,3,'employee','fetch',1,0,0,0),(10930,1,'employee','update',0,0,1,0),(10931,2,'employee','update',0,0,0,0),(10932,3,'employee','update',0,0,0,0),(10933,1,'employee','workDays',1,1,0,0),(10934,2,'employee','workDays',0,0,0,0),(10935,3,'employee','workDays',1,0,0,0),(10936,1,'employee','skills',1,1,0,0),(10937,2,'employee','skills',0,0,0,0),(10938,3,'employee','skills',1,0,0,0),(10939,1,'employee','assignmentDetails',1,0,0,0),(10940,2,'employee','assignmentDetails',1,0,0,0),(10941,3,'employee','assignmentDetails',1,0,0,0),(10942,1,'employee','forClientByDays',1,0,0,0),(10943,2,'employee','forClientByDays',1,0,0,0),(10944,3,'employee','forClientByDays',0,0,0,0),(10945,1,'company','fetch',1,0,0,0),(10946,2,'company','fetch',0,0,0,0),(10947,3,'company','fetch',0,0,0,0),(10948,1,'company','update',0,0,1,0),(10949,2,'company','update',0,0,0,0),(10950,3,'company','update',0,0,0,0),(10951,1,'company','users',1,0,0,0),(10952,2,'company','users',0,0,0,0),(10953,3,'company','users',0,0,0,0),(10954,1,'notification','list',1,0,0,0),(10955,2,'notification','list',0,0,0,0),(10956,3,'notification','list',1,0,0,0),(10957,1,'notification','companyToggle',0,1,0,0),(10958,2,'notification','companyToggle',0,0,0,0),(10959,3,'notification','companyToggle',0,0,0,0),(10960,1,'notification','employeeToggle',0,1,0,0),(10961,2,'notification','employeeToggle',0,0,0,0),(10962,3,'notification','employeeToggle',0,1,0,0);
/*!40000 ALTER TABLE `identity_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-24  0:21:09
