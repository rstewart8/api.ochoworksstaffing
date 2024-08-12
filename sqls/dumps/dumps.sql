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
) ENGINE=InnoDB AUTO_INCREMENT=8059 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (7918,1,'user','create',0,1,0,0),(7919,2,'user','create',0,0,0,0),(7920,3,'user','create',0,0,0,0),(7921,1,'user','fetch',1,0,0,0),(7922,2,'user','fetch',1,0,0,0),(7923,3,'user','fetch',1,0,0,0),(7924,1,'user','update',0,0,1,0),(7925,2,'user','update',0,0,0,0),(7926,3,'user','update',0,0,0,0),(7927,1,'user','profile',1,0,1,0),(7928,2,'user','profile',1,0,1,0),(7929,3,'user','profile',1,0,1,0),(7930,1,'client','list',1,0,0,0),(7931,2,'client','list',0,0,0,0),(7932,3,'client','list',0,0,0,0),(7933,1,'client','create',0,1,0,0),(7934,2,'client','create',0,0,0,0),(7935,3,'client','create',0,0,0,0),(7936,1,'client','fetch',1,0,0,0),(7937,2,'client','fetch',1,0,0,0),(7938,3,'client','fetch',0,0,0,0),(7939,1,'client','update',0,0,1,0),(7940,2,'client','update',0,0,0,0),(7941,3,'client','update',0,0,0,0),(7942,1,'client','users',1,0,0,0),(7943,2,'client','users',1,0,0,0),(7944,3,'client','users',0,0,0,0),(7945,1,'client','workdays',1,1,0,0),(7946,2,'client','workdays',1,0,0,0),(7947,3,'client','workdays',1,0,0,0),(7948,1,'utilities','states',1,0,0,0),(7949,2,'utilities','states',1,0,0,0),(7950,3,'utilities','states',1,0,0,0),(7951,1,'utilities','roles',1,0,0,0),(7952,2,'utilities','roles',1,0,0,0),(7953,3,'utilities','roles',0,0,0,0),(7954,1,'utilities','weekdays',1,0,0,0),(7955,2,'utilities','weekdays',1,0,0,0),(7956,3,'utilities','weekdays',1,0,0,0),(7957,1,'utilities','holidays',1,0,0,0),(7958,2,'utilities','holidays',1,0,0,0),(7959,3,'utilities','holidays',1,0,0,0),(7960,1,'utilities','workdays',1,0,0,0),(7961,2,'utilities','workdays',1,0,0,0),(7962,3,'utilities','workdays',1,0,0,0),(7963,1,'utilities','scheduleTimes',1,0,0,0),(7964,2,'utilities','scheduleTimes',1,0,0,0),(7965,3,'utilities','scheduleTimes',1,0,0,0),(7966,1,'job','list',1,0,0,0),(7967,2,'job','list',1,0,0,0),(7968,3,'job','list',0,0,0,0),(7969,1,'job','create',0,1,0,0),(7970,2,'job','create',0,1,0,0),(7971,3,'job','create',0,0,0,0),(7972,1,'job','fetch',1,0,0,0),(7973,2,'job','fetch',1,0,0,0),(7974,3,'job','fetch',0,0,0,0),(7975,1,'job','update',0,0,1,0),(7976,2,'job','update',0,0,1,0),(7977,3,'job','update',0,0,0,0),(7978,1,'schedule','list',1,0,0,0),(7979,2,'schedule','list',1,0,0,0),(7980,3,'schedule','list',0,0,0,0),(7981,1,'schedule','create',0,1,0,0),(7982,2,'schedule','create',0,1,0,0),(7983,3,'schedule','create',0,0,0,0),(7984,1,'schedule','fetch',1,0,0,0),(7985,2,'schedule','fetch',1,0,0,0),(7986,3,'schedule','fetch',0,0,0,0),(7987,1,'schedule','pending',1,0,0,0),(7988,2,'schedule','pending',1,0,0,0),(7989,3,'schedule','pending',0,0,0,0),(7990,1,'schedule','status',1,0,0,0),(7991,2,'schedule','status',1,0,0,0),(7992,3,'schedule','status',0,0,0,0),(7993,1,'schedule','assignment',1,1,0,1),(7994,2,'schedule','assignment',1,1,0,1),(7995,3,'schedule','assignment',0,0,0,0),(7996,1,'schedule','assignments',1,0,0,0),(7997,2,'schedule','assignments',1,0,0,0),(7998,3,'schedule','assignments',0,0,0,0),(7999,1,'schedule','days',1,0,0,0),(8000,2,'schedule','days',1,0,0,0),(8001,3,'schedule','days',0,0,0,0),(8002,1,'schedule','update',1,0,1,0),(8003,2,'schedule','update',1,0,1,0),(8004,3,'schedule','update',0,0,0,0),(8005,1,'schedule','delete',0,0,0,1),(8006,2,'schedule','delete',0,0,0,1),(8007,3,'schedule','delete',0,0,0,0),(8008,1,'schedule','clientReportByDay',1,0,0,0),(8009,2,'schedule','clientReportByDay',1,0,0,0),(8010,3,'schedule','clientReportByDay',0,0,0,0),(8011,1,'schedule','reportData',1,0,0,0),(8012,2,'schedule','reportData',1,0,0,0),(8013,3,'schedule','reportData',0,0,0,0),(8014,1,'schedule','scheduleStatusByRange',1,0,0,0),(8015,2,'schedule','scheduleStatusByRange',1,0,0,0),(8016,3,'schedule','scheduleStatusByRange',0,0,0,0),(8017,1,'schedule','notes',1,0,1,0),(8018,2,'schedule','notes',1,0,1,0),(8019,3,'schedule','notes',1,0,1,0),(8020,1,'skill','create',0,1,0,0),(8021,2,'skill','create',0,1,0,0),(8022,3,'skill','create',0,0,0,0),(8023,1,'skill','list',1,0,0,0),(8024,2,'skill','list',1,0,0,0),(8025,3,'skill','list',0,0,0,0),(8026,1,'skill','delete',0,0,1,0),(8027,2,'skill','delete',0,0,0,0),(8028,3,'skill','delete',0,0,0,0),(8029,1,'employee','list',1,0,0,0),(8030,2,'employee','list',1,0,0,0),(8031,3,'employee','list',0,0,0,0),(8032,1,'employee','create',0,1,0,0),(8033,2,'employee','create',0,1,0,0),(8034,3,'employee','create',0,0,0,0),(8035,1,'employee','schedule',1,0,0,0),(8036,2,'employee','schedule',1,0,0,0),(8037,3,'employee','schedule',0,0,0,0),(8038,1,'employee','available',1,0,0,0),(8039,2,'employee','available',1,0,0,0),(8040,3,'employee','available',0,0,0,0),(8041,1,'employee','assignments',1,0,0,0),(8042,2,'employee','assignments',1,0,0,0),(8043,3,'employee','assignments',0,0,0,0),(8044,1,'employee','fetch',1,0,0,0),(8045,2,'employee','fetch',1,0,0,0),(8046,3,'employee','fetch',1,0,0,0),(8047,1,'employee','update',0,0,1,0),(8048,2,'employee','update',0,0,1,0),(8049,3,'employee','update',0,0,0,0),(8050,1,'employee','workDays',1,1,0,0),(8051,2,'employee','workDays',1,1,0,0),(8052,3,'employee','workDays',1,0,0,0),(8053,1,'employee','skills',1,1,0,0),(8054,2,'employee','skills',1,1,0,0),(8055,3,'employee','skills',1,0,0,0),(8056,1,'employee','assignmentDetails',1,0,0,0),(8057,2,'employee','assignmentDetails',1,0,0,0),(8058,3,'employee','assignmentDetails',1,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=7939 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (7798,1,'user','create',0,1,0,0),(7799,2,'user','create',0,1,0,0),(7800,3,'user','create',0,0,0,0),(7801,1,'user','fetch',1,0,0,0),(7802,2,'user','fetch',1,0,0,0),(7803,3,'user','fetch',1,0,0,0),(7804,1,'user','update',0,0,1,0),(7805,2,'user','update',0,0,1,0),(7806,3,'user','update',0,0,0,0),(7807,1,'user','profile',1,0,1,0),(7808,2,'user','profile',1,0,1,0),(7809,3,'user','profile',1,0,1,0),(7810,1,'client','list',1,0,0,0),(7811,2,'client','list',0,0,0,0),(7812,3,'client','list',0,0,0,0),(7813,1,'client','create',0,1,0,0),(7814,2,'client','create',0,0,0,0),(7815,3,'client','create',0,0,0,0),(7816,1,'client','fetch',1,0,0,0),(7817,2,'client','fetch',1,0,0,0),(7818,3,'client','fetch',0,0,0,0),(7819,1,'client','update',0,0,1,0),(7820,2,'client','update',0,0,1,0),(7821,3,'client','update',0,0,0,0),(7822,1,'client','users',1,0,0,0),(7823,2,'client','users',1,0,0,0),(7824,3,'client','users',0,0,0,0),(7825,1,'client','workdays',1,1,0,0),(7826,2,'client','workdays',1,0,0,0),(7827,3,'client','workdays',1,0,0,0),(7828,1,'utilities','states',1,0,0,0),(7829,2,'utilities','states',1,0,0,0),(7830,3,'utilities','states',1,0,0,0),(7831,1,'utilities','roles',1,0,0,0),(7832,2,'utilities','roles',1,0,0,0),(7833,3,'utilities','roles',0,0,0,0),(7834,1,'utilities','weekdays',1,0,0,0),(7835,2,'utilities','weekdays',1,0,0,0),(7836,3,'utilities','weekdays',1,0,0,0),(7837,1,'utilities','holidays',1,0,0,0),(7838,2,'utilities','holidays',1,0,0,0),(7839,3,'utilities','holidays',1,0,0,0),(7840,1,'utilities','workdays',1,0,0,0),(7841,2,'utilities','workdays',1,0,0,0),(7842,3,'utilities','workdays',1,0,0,0),(7843,1,'utilities','scheduleTimes',1,0,0,0),(7844,2,'utilities','scheduleTimes',1,0,0,0),(7845,3,'utilities','scheduleTimes',1,0,0,0),(7846,1,'job','list',1,0,0,0),(7847,2,'job','list',1,0,0,0),(7848,3,'job','list',0,0,0,0),(7849,1,'job','create',0,1,0,0),(7850,2,'job','create',0,1,0,0),(7851,3,'job','create',0,0,0,0),(7852,1,'job','fetch',1,0,0,0),(7853,2,'job','fetch',1,0,0,0),(7854,3,'job','fetch',0,0,0,0),(7855,1,'job','update',0,0,1,0),(7856,2,'job','update',0,0,1,0),(7857,3,'job','update',0,0,0,0),(7858,1,'schedule','list',1,0,0,0),(7859,2,'schedule','list',1,0,0,0),(7860,3,'schedule','list',0,0,0,0),(7861,1,'schedule','create',0,1,0,0),(7862,2,'schedule','create',0,1,0,0),(7863,3,'schedule','create',0,0,0,0),(7864,1,'schedule','fetch',1,0,0,0),(7865,2,'schedule','fetch',1,0,0,0),(7866,3,'schedule','fetch',0,0,0,0),(7867,1,'schedule','pending',1,0,0,0),(7868,2,'schedule','pending',1,0,0,0),(7869,3,'schedule','pending',0,0,0,0),(7870,1,'schedule','status',1,0,0,0),(7871,2,'schedule','status',1,0,0,0),(7872,3,'schedule','status',0,0,0,0),(7873,1,'schedule','assignment',1,1,0,1),(7874,2,'schedule','assignment',1,0,0,0),(7875,3,'schedule','assignment',0,0,0,0),(7876,1,'schedule','assignments',1,0,0,0),(7877,2,'schedule','assignments',1,0,0,0),(7878,3,'schedule','assignments',1,0,0,0),(7879,1,'schedule','days',1,0,0,0),(7880,2,'schedule','days',0,0,0,0),(7881,3,'schedule','days',0,0,0,0),(7882,1,'schedule','update',1,0,1,0),(7883,2,'schedule','update',1,0,1,0),(7884,3,'schedule','update',0,0,0,0),(7885,1,'schedule','delete',0,0,0,1),(7886,2,'schedule','delete',0,0,0,0),(7887,3,'schedule','delete',0,0,0,0),(7888,1,'schedule','clientReportByDay',1,0,0,0),(7889,2,'schedule','clientReportByDay',1,0,0,0),(7890,3,'schedule','clientReportByDay',0,0,0,0),(7891,1,'schedule','reportData',1,0,0,0),(7892,2,'schedule','reportData',1,0,0,0),(7893,3,'schedule','reportData',0,0,0,0),(7894,1,'schedule','scheduleStatusByRange',1,0,0,0),(7895,2,'schedule','scheduleStatusByRange',1,0,0,0),(7896,3,'schedule','scheduleStatusByRange',0,0,0,0),(7897,1,'schedule','notes',1,0,1,0),(7898,2,'schedule','notes',1,0,1,0),(7899,3,'schedule','notes',0,0,0,0),(7900,1,'skill','create',0,1,0,0),(7901,2,'skill','create',0,0,0,0),(7902,3,'skill','create',0,0,0,0),(7903,1,'skill','list',1,0,0,0),(7904,2,'skill','list',1,0,0,0),(7905,3,'skill','list',0,0,0,0),(7906,1,'skill','delete',0,0,1,0),(7907,2,'skill','delete',0,0,0,0),(7908,3,'skill','delete',0,0,0,0),(7909,1,'employee','list',1,0,0,0),(7910,2,'employee','list',0,0,0,0),(7911,3,'employee','list',0,0,0,0),(7912,1,'employee','create',0,1,0,0),(7913,2,'employee','create',0,0,0,0),(7914,3,'employee','create',0,0,0,0),(7915,1,'employee','schedule',1,0,0,0),(7916,2,'employee','schedule',0,0,0,0),(7917,3,'employee','schedule',0,0,0,0),(7918,1,'employee','available',1,0,0,0),(7919,2,'employee','available',0,0,0,0),(7920,3,'employee','available',0,0,0,0),(7921,1,'employee','assignments',1,0,0,0),(7922,2,'employee','assignments',1,0,0,0),(7923,3,'employee','assignments',1,0,0,0),(7924,1,'employee','fetch',1,0,0,0),(7925,2,'employee','fetch',1,0,0,0),(7926,3,'employee','fetch',1,0,0,0),(7927,1,'employee','update',0,0,1,0),(7928,2,'employee','update',0,0,0,0),(7929,3,'employee','update',0,0,0,0),(7930,1,'employee','workDays',1,1,0,0),(7931,2,'employee','workDays',0,0,0,0),(7932,3,'employee','workDays',0,0,0,0),(7933,1,'employee','skills',1,1,0,0),(7934,2,'employee','skills',0,0,0,0),(7935,3,'employee','skills',0,0,0,0),(7936,1,'employee','assignmentDetails',1,0,0,0),(7937,2,'employee','assignmentDetails',1,0,0,0),(7938,3,'employee','assignmentDetails',1,0,0,0);
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

-- Dump completed on 2024-08-11 22:33:58
