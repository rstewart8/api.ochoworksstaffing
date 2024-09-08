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
) ENGINE=InnoDB AUTO_INCREMENT=9262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (9109,1,'user','create',0,1,0,0),(9110,2,'user','create',0,0,0,0),(9111,3,'user','create',0,0,0,0),(9112,1,'user','fetch',1,0,0,0),(9113,2,'user','fetch',1,0,0,0),(9114,3,'user','fetch',1,0,0,0),(9115,1,'user','update',0,0,1,0),(9116,2,'user','update',0,0,0,0),(9117,3,'user','update',0,0,0,0),(9118,1,'user','profile',1,0,1,0),(9119,2,'user','profile',1,0,1,0),(9120,3,'user','profile',1,0,1,0),(9121,1,'client','list',1,0,0,0),(9122,2,'client','list',0,0,0,0),(9123,3,'client','list',0,0,0,0),(9124,1,'client','create',0,1,0,0),(9125,2,'client','create',0,0,0,0),(9126,3,'client','create',0,0,0,0),(9127,1,'client','fetch',1,0,0,0),(9128,2,'client','fetch',1,0,0,0),(9129,3,'client','fetch',0,0,0,0),(9130,1,'client','update',0,0,1,0),(9131,2,'client','update',0,0,0,0),(9132,3,'client','update',0,0,0,0),(9133,1,'client','users',1,0,0,0),(9134,2,'client','users',1,0,0,0),(9135,3,'client','users',0,0,0,0),(9136,1,'client','workdays',1,1,0,0),(9137,2,'client','workdays',1,0,0,0),(9138,3,'client','workdays',1,0,0,0),(9139,1,'utilities','states',1,0,0,0),(9140,2,'utilities','states',1,0,0,0),(9141,3,'utilities','states',1,0,0,0),(9142,1,'utilities','roles',1,0,0,0),(9143,2,'utilities','roles',1,0,0,0),(9144,3,'utilities','roles',0,0,0,0),(9145,1,'utilities','weekdays',1,0,0,0),(9146,2,'utilities','weekdays',1,0,0,0),(9147,3,'utilities','weekdays',1,0,0,0),(9148,1,'utilities','holidays',1,0,0,0),(9149,2,'utilities','holidays',1,0,0,0),(9150,3,'utilities','holidays',1,0,0,0),(9151,1,'utilities','workdays',1,0,0,0),(9152,2,'utilities','workdays',1,0,0,0),(9153,3,'utilities','workdays',1,0,0,0),(9154,1,'utilities','scheduleTimes',1,0,0,0),(9155,2,'utilities','scheduleTimes',1,0,0,0),(9156,3,'utilities','scheduleTimes',1,0,0,0),(9157,1,'job','list',1,0,0,0),(9158,2,'job','list',1,0,0,0),(9159,3,'job','list',0,0,0,0),(9160,1,'job','create',0,1,0,0),(9161,2,'job','create',0,1,0,0),(9162,3,'job','create',0,0,0,0),(9163,1,'job','fetch',1,0,0,0),(9164,2,'job','fetch',1,0,0,0),(9165,3,'job','fetch',0,0,0,0),(9166,1,'job','update',0,0,1,0),(9167,2,'job','update',0,0,1,0),(9168,3,'job','update',0,0,0,0),(9169,1,'schedule','list',1,0,0,0),(9170,2,'schedule','list',1,0,0,0),(9171,3,'schedule','list',0,0,0,0),(9172,1,'schedule','create',0,1,0,0),(9173,2,'schedule','create',0,1,0,0),(9174,3,'schedule','create',0,0,0,0),(9175,1,'schedule','fetch',1,0,0,0),(9176,2,'schedule','fetch',1,0,0,0),(9177,3,'schedule','fetch',0,0,0,0),(9178,1,'schedule','pending',1,0,0,0),(9179,2,'schedule','pending',1,0,0,0),(9180,3,'schedule','pending',0,0,0,0),(9181,1,'schedule','status',1,0,0,0),(9182,2,'schedule','status',1,0,0,0),(9183,3,'schedule','status',0,0,0,0),(9184,1,'schedule','assignment',1,1,0,1),(9185,2,'schedule','assignment',1,1,0,1),(9186,3,'schedule','assignment',0,0,0,0),(9187,1,'schedule','assignments',1,0,0,0),(9188,2,'schedule','assignments',1,0,0,0),(9189,3,'schedule','assignments',0,0,0,0),(9190,1,'schedule','days',1,0,0,0),(9191,2,'schedule','days',1,0,0,0),(9192,3,'schedule','days',0,0,0,0),(9193,1,'schedule','update',1,0,1,0),(9194,2,'schedule','update',1,0,1,0),(9195,3,'schedule','update',0,0,0,0),(9196,1,'schedule','delete',0,0,0,1),(9197,2,'schedule','delete',0,0,0,1),(9198,3,'schedule','delete',0,0,0,0),(9199,1,'schedule','clientReportByDay',1,0,0,0),(9200,2,'schedule','clientReportByDay',1,0,0,0),(9201,3,'schedule','clientReportByDay',0,0,0,0),(9202,1,'schedule','reportData',1,0,0,0),(9203,2,'schedule','reportData',1,0,0,0),(9204,3,'schedule','reportData',0,0,0,0),(9205,1,'schedule','scheduleStatusByRange',1,0,0,0),(9206,2,'schedule','scheduleStatusByRange',1,0,0,0),(9207,3,'schedule','scheduleStatusByRange',0,0,0,0),(9208,1,'schedule','notes',1,0,1,0),(9209,2,'schedule','notes',1,0,1,0),(9210,3,'schedule','notes',1,0,1,0),(9211,1,'schedule','jobReportByDay',1,0,0,0),(9212,2,'schedule','jobReportByDay',1,0,0,0),(9213,3,'schedule','jobReportByDay',0,0,0,0),(9214,1,'skill','create',0,1,0,0),(9215,2,'skill','create',0,1,0,0),(9216,3,'skill','create',0,0,0,0),(9217,1,'skill','list',1,0,0,0),(9218,2,'skill','list',1,0,0,0),(9219,3,'skill','list',0,0,0,0),(9220,1,'skill','delete',0,0,1,0),(9221,2,'skill','delete',0,0,0,0),(9222,3,'skill','delete',0,0,0,0),(9223,1,'employee','list',1,0,0,0),(9224,2,'employee','list',1,0,0,0),(9225,3,'employee','list',0,0,0,0),(9226,1,'employee','create',0,1,0,0),(9227,2,'employee','create',0,1,0,0),(9228,3,'employee','create',0,0,0,0),(9229,1,'employee','schedule',1,0,0,0),(9230,2,'employee','schedule',1,0,0,0),(9231,3,'employee','schedule',0,0,0,0),(9232,1,'employee','available',1,0,0,0),(9233,2,'employee','available',1,0,0,0),(9234,3,'employee','available',0,0,0,0),(9235,1,'employee','assignments',1,0,0,0),(9236,2,'employee','assignments',1,0,0,0),(9237,3,'employee','assignments',0,0,0,0),(9238,1,'employee','fetch',1,0,0,0),(9239,2,'employee','fetch',1,0,0,0),(9240,3,'employee','fetch',1,0,0,0),(9241,1,'employee','update',0,0,1,0),(9242,2,'employee','update',0,0,1,0),(9243,3,'employee','update',0,0,0,0),(9244,1,'employee','workDays',1,1,0,0),(9245,2,'employee','workDays',1,1,0,0),(9246,3,'employee','workDays',1,0,0,0),(9247,1,'employee','skills',1,1,0,0),(9248,2,'employee','skills',1,1,0,0),(9249,3,'employee','skills',1,0,0,0),(9250,1,'employee','assignmentDetails',1,0,0,0),(9251,2,'employee','assignmentDetails',1,0,0,0),(9252,3,'employee','assignmentDetails',1,0,0,0),(9253,1,'company','fetch',1,0,0,0),(9254,2,'company','fetch',0,0,0,0),(9255,3,'company','fetch',0,0,0,0),(9256,1,'company','update',0,0,1,0),(9257,2,'company','update',0,0,0,0),(9258,3,'company','update',0,0,0,0),(9259,1,'company','users',1,0,0,0),(9260,2,'company','users',0,0,0,0),(9261,3,'company','users',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (8989,1,'user','create',0,1,0,0),(8990,2,'user','create',0,1,0,0),(8991,3,'user','create',0,0,0,0),(8992,1,'user','fetch',1,0,0,0),(8993,2,'user','fetch',1,0,0,0),(8994,3,'user','fetch',1,0,0,0),(8995,1,'user','update',0,0,1,0),(8996,2,'user','update',0,0,1,0),(8997,3,'user','update',0,0,0,0),(8998,1,'user','profile',1,0,1,0),(8999,2,'user','profile',1,0,1,0),(9000,3,'user','profile',1,0,1,0),(9001,1,'client','list',1,0,0,0),(9002,2,'client','list',0,0,0,0),(9003,3,'client','list',0,0,0,0),(9004,1,'client','create',0,1,0,0),(9005,2,'client','create',0,0,0,0),(9006,3,'client','create',0,0,0,0),(9007,1,'client','fetch',1,0,0,0),(9008,2,'client','fetch',1,0,0,0),(9009,3,'client','fetch',0,0,0,0),(9010,1,'client','update',0,0,1,0),(9011,2,'client','update',0,0,1,0),(9012,3,'client','update',0,0,0,0),(9013,1,'client','users',1,0,0,0),(9014,2,'client','users',1,0,0,0),(9015,3,'client','users',0,0,0,0),(9016,1,'client','workdays',1,1,0,0),(9017,2,'client','workdays',1,0,0,0),(9018,3,'client','workdays',1,0,0,0),(9019,1,'utilities','states',1,0,0,0),(9020,2,'utilities','states',1,0,0,0),(9021,3,'utilities','states',1,0,0,0),(9022,1,'utilities','roles',1,0,0,0),(9023,2,'utilities','roles',1,0,0,0),(9024,3,'utilities','roles',0,0,0,0),(9025,1,'utilities','weekdays',1,0,0,0),(9026,2,'utilities','weekdays',1,0,0,0),(9027,3,'utilities','weekdays',1,0,0,0),(9028,1,'utilities','holidays',1,0,0,0),(9029,2,'utilities','holidays',1,0,0,0),(9030,3,'utilities','holidays',1,0,0,0),(9031,1,'utilities','workdays',1,0,0,0),(9032,2,'utilities','workdays',1,0,0,0),(9033,3,'utilities','workdays',1,0,0,0),(9034,1,'utilities','scheduleTimes',1,0,0,0),(9035,2,'utilities','scheduleTimes',1,0,0,0),(9036,3,'utilities','scheduleTimes',1,0,0,0),(9037,1,'job','list',1,0,0,0),(9038,2,'job','list',1,0,0,0),(9039,3,'job','list',0,0,0,0),(9040,1,'job','create',0,1,0,0),(9041,2,'job','create',0,1,0,0),(9042,3,'job','create',0,0,0,0),(9043,1,'job','fetch',1,0,0,0),(9044,2,'job','fetch',1,0,0,0),(9045,3,'job','fetch',0,0,0,0),(9046,1,'job','update',0,0,1,0),(9047,2,'job','update',0,0,1,0),(9048,3,'job','update',0,0,0,0),(9049,1,'schedule','list',1,0,0,0),(9050,2,'schedule','list',1,0,0,0),(9051,3,'schedule','list',0,0,0,0),(9052,1,'schedule','create',0,1,0,0),(9053,2,'schedule','create',0,1,0,0),(9054,3,'schedule','create',0,0,0,0),(9055,1,'schedule','fetch',1,0,0,0),(9056,2,'schedule','fetch',1,0,0,0),(9057,3,'schedule','fetch',0,0,0,0),(9058,1,'schedule','pending',1,0,0,0),(9059,2,'schedule','pending',1,0,0,0),(9060,3,'schedule','pending',0,0,0,0),(9061,1,'schedule','status',1,0,0,0),(9062,2,'schedule','status',1,0,0,0),(9063,3,'schedule','status',0,0,0,0),(9064,1,'schedule','assignment',1,1,0,1),(9065,2,'schedule','assignment',1,0,0,0),(9066,3,'schedule','assignment',0,0,0,0),(9067,1,'schedule','assignments',1,0,0,0),(9068,2,'schedule','assignments',1,0,0,0),(9069,3,'schedule','assignments',1,0,0,0),(9070,1,'schedule','days',1,0,0,0),(9071,2,'schedule','days',1,0,0,0),(9072,3,'schedule','days',0,0,0,0),(9073,1,'schedule','update',1,0,1,0),(9074,2,'schedule','update',1,0,1,0),(9075,3,'schedule','update',0,0,0,0),(9076,1,'schedule','delete',0,0,0,1),(9077,2,'schedule','delete',0,0,0,0),(9078,3,'schedule','delete',0,0,0,0),(9079,1,'schedule','clientReportByDay',1,0,0,0),(9080,2,'schedule','clientReportByDay',1,0,0,0),(9081,3,'schedule','clientReportByDay',0,0,0,0),(9082,1,'schedule','reportData',1,0,0,0),(9083,2,'schedule','reportData',1,0,0,0),(9084,3,'schedule','reportData',0,0,0,0),(9085,1,'schedule','scheduleStatusByRange',1,0,0,0),(9086,2,'schedule','scheduleStatusByRange',1,0,0,0),(9087,3,'schedule','scheduleStatusByRange',0,0,0,0),(9088,1,'schedule','notes',1,0,1,0),(9089,2,'schedule','notes',1,0,1,0),(9090,3,'schedule','notes',0,0,0,0),(9091,1,'schedule','jobReportByDay',1,0,0,0),(9092,2,'schedule','jobReportByDay',1,0,0,0),(9093,3,'schedule','jobReportByDay',0,0,0,0),(9094,1,'skill','create',0,1,0,0),(9095,2,'skill','create',0,0,0,0),(9096,3,'skill','create',0,0,0,0),(9097,1,'skill','list',1,0,0,0),(9098,2,'skill','list',1,0,0,0),(9099,3,'skill','list',0,0,0,0),(9100,1,'skill','delete',0,0,1,0),(9101,2,'skill','delete',0,0,0,0),(9102,3,'skill','delete',0,0,0,0),(9103,1,'employee','list',1,0,0,0),(9104,2,'employee','list',0,0,0,0),(9105,3,'employee','list',0,0,0,0),(9106,1,'employee','create',0,1,0,0),(9107,2,'employee','create',0,0,0,0),(9108,3,'employee','create',0,0,0,0),(9109,1,'employee','schedule',1,0,0,0),(9110,2,'employee','schedule',0,0,0,0),(9111,3,'employee','schedule',0,0,0,0),(9112,1,'employee','available',1,0,0,0),(9113,2,'employee','available',0,0,0,0),(9114,3,'employee','available',0,0,0,0),(9115,1,'employee','assignments',1,0,0,0),(9116,2,'employee','assignments',1,0,0,0),(9117,3,'employee','assignments',1,0,0,0),(9118,1,'employee','fetch',1,0,0,0),(9119,2,'employee','fetch',1,0,0,0),(9120,3,'employee','fetch',1,0,0,0),(9121,1,'employee','update',0,0,1,0),(9122,2,'employee','update',0,0,0,0),(9123,3,'employee','update',0,0,0,0),(9124,1,'employee','workDays',1,1,0,0),(9125,2,'employee','workDays',0,0,0,0),(9126,3,'employee','workDays',1,0,0,0),(9127,1,'employee','skills',1,1,0,0),(9128,2,'employee','skills',0,0,0,0),(9129,3,'employee','skills',1,0,0,0),(9130,1,'employee','assignmentDetails',1,0,0,0),(9131,2,'employee','assignmentDetails',1,0,0,0),(9132,3,'employee','assignmentDetails',1,0,0,0),(9133,1,'company','fetch',1,0,0,0),(9134,2,'company','fetch',0,0,0,0),(9135,3,'company','fetch',0,0,0,0),(9136,1,'company','update',0,0,1,0),(9137,2,'company','update',0,0,0,0),(9138,3,'company','update',0,0,0,0),(9139,1,'company','users',1,0,0,0),(9140,2,'company','users',0,0,0,0),(9141,3,'company','users',0,0,0,0);
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

-- Dump completed on 2024-09-08 11:50:26
