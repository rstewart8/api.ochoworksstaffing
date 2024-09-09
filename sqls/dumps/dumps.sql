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
) ENGINE=InnoDB AUTO_INCREMENT=9418 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (9262,1,'user','create',0,1,0,0),(9263,2,'user','create',0,0,0,0),(9264,3,'user','create',0,0,0,0),(9265,1,'user','fetch',1,0,0,0),(9266,2,'user','fetch',1,0,0,0),(9267,3,'user','fetch',1,0,0,0),(9268,1,'user','update',0,0,1,0),(9269,2,'user','update',0,0,0,0),(9270,3,'user','update',0,0,0,0),(9271,1,'user','profile',1,0,1,0),(9272,2,'user','profile',1,0,1,0),(9273,3,'user','profile',1,0,1,0),(9274,1,'user','photo',0,1,0,0),(9275,2,'user','photo',0,1,0,0),(9276,3,'user','photo',0,1,0,0),(9277,1,'client','list',1,0,0,0),(9278,2,'client','list',0,0,0,0),(9279,3,'client','list',0,0,0,0),(9280,1,'client','create',0,1,0,0),(9281,2,'client','create',0,0,0,0),(9282,3,'client','create',0,0,0,0),(9283,1,'client','fetch',1,0,0,0),(9284,2,'client','fetch',1,0,0,0),(9285,3,'client','fetch',0,0,0,0),(9286,1,'client','update',0,0,1,0),(9287,2,'client','update',0,0,0,0),(9288,3,'client','update',0,0,0,0),(9289,1,'client','users',1,0,0,0),(9290,2,'client','users',1,0,0,0),(9291,3,'client','users',0,0,0,0),(9292,1,'client','workdays',1,1,0,0),(9293,2,'client','workdays',1,0,0,0),(9294,3,'client','workdays',1,0,0,0),(9295,1,'utilities','states',1,0,0,0),(9296,2,'utilities','states',1,0,0,0),(9297,3,'utilities','states',1,0,0,0),(9298,1,'utilities','roles',1,0,0,0),(9299,2,'utilities','roles',1,0,0,0),(9300,3,'utilities','roles',0,0,0,0),(9301,1,'utilities','weekdays',1,0,0,0),(9302,2,'utilities','weekdays',1,0,0,0),(9303,3,'utilities','weekdays',1,0,0,0),(9304,1,'utilities','holidays',1,0,0,0),(9305,2,'utilities','holidays',1,0,0,0),(9306,3,'utilities','holidays',1,0,0,0),(9307,1,'utilities','workdays',1,0,0,0),(9308,2,'utilities','workdays',1,0,0,0),(9309,3,'utilities','workdays',1,0,0,0),(9310,1,'utilities','scheduleTimes',1,0,0,0),(9311,2,'utilities','scheduleTimes',1,0,0,0),(9312,3,'utilities','scheduleTimes',1,0,0,0),(9313,1,'job','list',1,0,0,0),(9314,2,'job','list',1,0,0,0),(9315,3,'job','list',0,0,0,0),(9316,1,'job','create',0,1,0,0),(9317,2,'job','create',0,1,0,0),(9318,3,'job','create',0,0,0,0),(9319,1,'job','fetch',1,0,0,0),(9320,2,'job','fetch',1,0,0,0),(9321,3,'job','fetch',0,0,0,0),(9322,1,'job','update',0,0,1,0),(9323,2,'job','update',0,0,1,0),(9324,3,'job','update',0,0,0,0),(9325,1,'schedule','list',1,0,0,0),(9326,2,'schedule','list',1,0,0,0),(9327,3,'schedule','list',0,0,0,0),(9328,1,'schedule','create',0,1,0,0),(9329,2,'schedule','create',0,1,0,0),(9330,3,'schedule','create',0,0,0,0),(9331,1,'schedule','fetch',1,0,0,0),(9332,2,'schedule','fetch',1,0,0,0),(9333,3,'schedule','fetch',0,0,0,0),(9334,1,'schedule','pending',1,0,0,0),(9335,2,'schedule','pending',1,0,0,0),(9336,3,'schedule','pending',0,0,0,0),(9337,1,'schedule','status',1,0,0,0),(9338,2,'schedule','status',1,0,0,0),(9339,3,'schedule','status',0,0,0,0),(9340,1,'schedule','assignment',1,1,0,1),(9341,2,'schedule','assignment',1,1,0,1),(9342,3,'schedule','assignment',0,0,0,0),(9343,1,'schedule','assignments',1,0,0,0),(9344,2,'schedule','assignments',1,0,0,0),(9345,3,'schedule','assignments',0,0,0,0),(9346,1,'schedule','days',1,0,0,0),(9347,2,'schedule','days',1,0,0,0),(9348,3,'schedule','days',0,0,0,0),(9349,1,'schedule','update',1,0,1,0),(9350,2,'schedule','update',1,0,1,0),(9351,3,'schedule','update',0,0,0,0),(9352,1,'schedule','delete',0,0,0,1),(9353,2,'schedule','delete',0,0,0,1),(9354,3,'schedule','delete',0,0,0,0),(9355,1,'schedule','clientReportByDay',1,0,0,0),(9356,2,'schedule','clientReportByDay',1,0,0,0),(9357,3,'schedule','clientReportByDay',0,0,0,0),(9358,1,'schedule','reportData',1,0,0,0),(9359,2,'schedule','reportData',1,0,0,0),(9360,3,'schedule','reportData',0,0,0,0),(9361,1,'schedule','scheduleStatusByRange',1,0,0,0),(9362,2,'schedule','scheduleStatusByRange',1,0,0,0),(9363,3,'schedule','scheduleStatusByRange',0,0,0,0),(9364,1,'schedule','notes',1,0,1,0),(9365,2,'schedule','notes',1,0,1,0),(9366,3,'schedule','notes',1,0,1,0),(9367,1,'schedule','jobReportByDay',1,0,0,0),(9368,2,'schedule','jobReportByDay',1,0,0,0),(9369,3,'schedule','jobReportByDay',0,0,0,0),(9370,1,'skill','create',0,1,0,0),(9371,2,'skill','create',0,1,0,0),(9372,3,'skill','create',0,0,0,0),(9373,1,'skill','list',1,0,0,0),(9374,2,'skill','list',1,0,0,0),(9375,3,'skill','list',0,0,0,0),(9376,1,'skill','delete',0,0,1,0),(9377,2,'skill','delete',0,0,0,0),(9378,3,'skill','delete',0,0,0,0),(9379,1,'employee','list',1,0,0,0),(9380,2,'employee','list',1,0,0,0),(9381,3,'employee','list',0,0,0,0),(9382,1,'employee','create',0,1,0,0),(9383,2,'employee','create',0,1,0,0),(9384,3,'employee','create',0,0,0,0),(9385,1,'employee','schedule',1,0,0,0),(9386,2,'employee','schedule',1,0,0,0),(9387,3,'employee','schedule',0,0,0,0),(9388,1,'employee','available',1,0,0,0),(9389,2,'employee','available',1,0,0,0),(9390,3,'employee','available',0,0,0,0),(9391,1,'employee','assignments',1,0,0,0),(9392,2,'employee','assignments',1,0,0,0),(9393,3,'employee','assignments',0,0,0,0),(9394,1,'employee','fetch',1,0,0,0),(9395,2,'employee','fetch',1,0,0,0),(9396,3,'employee','fetch',1,0,0,0),(9397,1,'employee','update',0,0,1,0),(9398,2,'employee','update',0,0,1,0),(9399,3,'employee','update',0,0,0,0),(9400,1,'employee','workDays',1,1,0,0),(9401,2,'employee','workDays',1,1,0,0),(9402,3,'employee','workDays',1,0,0,0),(9403,1,'employee','skills',1,1,0,0),(9404,2,'employee','skills',1,1,0,0),(9405,3,'employee','skills',1,0,0,0),(9406,1,'employee','assignmentDetails',1,0,0,0),(9407,2,'employee','assignmentDetails',1,0,0,0),(9408,3,'employee','assignmentDetails',1,0,0,0),(9409,1,'company','fetch',1,0,0,0),(9410,2,'company','fetch',0,0,0,0),(9411,3,'company','fetch',0,0,0,0),(9412,1,'company','update',0,0,1,0),(9413,2,'company','update',0,0,0,0),(9414,3,'company','update',0,0,0,0),(9415,1,'company','users',1,0,0,0),(9416,2,'company','users',0,0,0,0),(9417,3,'company','users',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9298 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (9142,1,'user','create',0,1,0,0),(9143,2,'user','create',0,1,0,0),(9144,3,'user','create',0,0,0,0),(9145,1,'user','fetch',1,0,0,0),(9146,2,'user','fetch',1,0,0,0),(9147,3,'user','fetch',1,0,0,0),(9148,1,'user','update',0,0,1,0),(9149,2,'user','update',0,0,1,0),(9150,3,'user','update',0,0,0,0),(9151,1,'user','profile',1,0,1,0),(9152,2,'user','profile',1,0,1,0),(9153,3,'user','profile',1,0,1,0),(9154,1,'user','photo',0,1,0,0),(9155,2,'user','photo',0,1,0,0),(9156,3,'user','photo',0,1,0,0),(9157,1,'client','list',1,0,0,0),(9158,2,'client','list',0,0,0,0),(9159,3,'client','list',0,0,0,0),(9160,1,'client','create',0,1,0,0),(9161,2,'client','create',0,0,0,0),(9162,3,'client','create',0,0,0,0),(9163,1,'client','fetch',1,0,0,0),(9164,2,'client','fetch',1,0,0,0),(9165,3,'client','fetch',0,0,0,0),(9166,1,'client','update',0,0,1,0),(9167,2,'client','update',0,0,1,0),(9168,3,'client','update',0,0,0,0),(9169,1,'client','users',1,0,0,0),(9170,2,'client','users',1,0,0,0),(9171,3,'client','users',0,0,0,0),(9172,1,'client','workdays',1,1,0,0),(9173,2,'client','workdays',1,0,0,0),(9174,3,'client','workdays',1,0,0,0),(9175,1,'utilities','states',1,0,0,0),(9176,2,'utilities','states',1,0,0,0),(9177,3,'utilities','states',1,0,0,0),(9178,1,'utilities','roles',1,0,0,0),(9179,2,'utilities','roles',1,0,0,0),(9180,3,'utilities','roles',0,0,0,0),(9181,1,'utilities','weekdays',1,0,0,0),(9182,2,'utilities','weekdays',1,0,0,0),(9183,3,'utilities','weekdays',1,0,0,0),(9184,1,'utilities','holidays',1,0,0,0),(9185,2,'utilities','holidays',1,0,0,0),(9186,3,'utilities','holidays',1,0,0,0),(9187,1,'utilities','workdays',1,0,0,0),(9188,2,'utilities','workdays',1,0,0,0),(9189,3,'utilities','workdays',1,0,0,0),(9190,1,'utilities','scheduleTimes',1,0,0,0),(9191,2,'utilities','scheduleTimes',1,0,0,0),(9192,3,'utilities','scheduleTimes',1,0,0,0),(9193,1,'job','list',1,0,0,0),(9194,2,'job','list',1,0,0,0),(9195,3,'job','list',0,0,0,0),(9196,1,'job','create',0,1,0,0),(9197,2,'job','create',0,1,0,0),(9198,3,'job','create',0,0,0,0),(9199,1,'job','fetch',1,0,0,0),(9200,2,'job','fetch',1,0,0,0),(9201,3,'job','fetch',0,0,0,0),(9202,1,'job','update',0,0,1,0),(9203,2,'job','update',0,0,1,0),(9204,3,'job','update',0,0,0,0),(9205,1,'schedule','list',1,0,0,0),(9206,2,'schedule','list',1,0,0,0),(9207,3,'schedule','list',0,0,0,0),(9208,1,'schedule','create',0,1,0,0),(9209,2,'schedule','create',0,1,0,0),(9210,3,'schedule','create',0,0,0,0),(9211,1,'schedule','fetch',1,0,0,0),(9212,2,'schedule','fetch',1,0,0,0),(9213,3,'schedule','fetch',0,0,0,0),(9214,1,'schedule','pending',1,0,0,0),(9215,2,'schedule','pending',1,0,0,0),(9216,3,'schedule','pending',0,0,0,0),(9217,1,'schedule','status',1,0,0,0),(9218,2,'schedule','status',1,0,0,0),(9219,3,'schedule','status',0,0,0,0),(9220,1,'schedule','assignment',1,1,0,1),(9221,2,'schedule','assignment',1,0,0,0),(9222,3,'schedule','assignment',0,0,0,0),(9223,1,'schedule','assignments',1,0,0,0),(9224,2,'schedule','assignments',1,0,0,0),(9225,3,'schedule','assignments',1,0,0,0),(9226,1,'schedule','days',1,0,0,0),(9227,2,'schedule','days',1,0,0,0),(9228,3,'schedule','days',0,0,0,0),(9229,1,'schedule','update',1,0,1,0),(9230,2,'schedule','update',1,0,1,0),(9231,3,'schedule','update',0,0,0,0),(9232,1,'schedule','delete',0,0,0,1),(9233,2,'schedule','delete',0,0,0,0),(9234,3,'schedule','delete',0,0,0,0),(9235,1,'schedule','clientReportByDay',1,0,0,0),(9236,2,'schedule','clientReportByDay',1,0,0,0),(9237,3,'schedule','clientReportByDay',0,0,0,0),(9238,1,'schedule','reportData',1,0,0,0),(9239,2,'schedule','reportData',1,0,0,0),(9240,3,'schedule','reportData',0,0,0,0),(9241,1,'schedule','scheduleStatusByRange',1,0,0,0),(9242,2,'schedule','scheduleStatusByRange',1,0,0,0),(9243,3,'schedule','scheduleStatusByRange',0,0,0,0),(9244,1,'schedule','notes',1,0,1,0),(9245,2,'schedule','notes',1,0,1,0),(9246,3,'schedule','notes',0,0,0,0),(9247,1,'schedule','jobReportByDay',1,0,0,0),(9248,2,'schedule','jobReportByDay',1,0,0,0),(9249,3,'schedule','jobReportByDay',0,0,0,0),(9250,1,'skill','create',0,1,0,0),(9251,2,'skill','create',0,0,0,0),(9252,3,'skill','create',0,0,0,0),(9253,1,'skill','list',1,0,0,0),(9254,2,'skill','list',1,0,0,0),(9255,3,'skill','list',0,0,0,0),(9256,1,'skill','delete',0,0,1,0),(9257,2,'skill','delete',0,0,0,0),(9258,3,'skill','delete',0,0,0,0),(9259,1,'employee','list',1,0,0,0),(9260,2,'employee','list',0,0,0,0),(9261,3,'employee','list',0,0,0,0),(9262,1,'employee','create',0,1,0,0),(9263,2,'employee','create',0,0,0,0),(9264,3,'employee','create',0,0,0,0),(9265,1,'employee','schedule',1,0,0,0),(9266,2,'employee','schedule',0,0,0,0),(9267,3,'employee','schedule',0,0,0,0),(9268,1,'employee','available',1,0,0,0),(9269,2,'employee','available',0,0,0,0),(9270,3,'employee','available',0,0,0,0),(9271,1,'employee','assignments',1,0,0,0),(9272,2,'employee','assignments',1,0,0,0),(9273,3,'employee','assignments',1,0,0,0),(9274,1,'employee','fetch',1,0,0,0),(9275,2,'employee','fetch',1,0,0,0),(9276,3,'employee','fetch',1,0,0,0),(9277,1,'employee','update',0,0,1,0),(9278,2,'employee','update',0,0,0,0),(9279,3,'employee','update',0,0,0,0),(9280,1,'employee','workDays',1,1,0,0),(9281,2,'employee','workDays',0,0,0,0),(9282,3,'employee','workDays',1,0,0,0),(9283,1,'employee','skills',1,1,0,0),(9284,2,'employee','skills',0,0,0,0),(9285,3,'employee','skills',1,0,0,0),(9286,1,'employee','assignmentDetails',1,0,0,0),(9287,2,'employee','assignmentDetails',1,0,0,0),(9288,3,'employee','assignmentDetails',1,0,0,0),(9289,1,'company','fetch',1,0,0,0),(9290,2,'company','fetch',0,0,0,0),(9291,3,'company','fetch',0,0,0,0),(9292,1,'company','update',0,0,1,0),(9293,2,'company','update',0,0,0,0),(9294,3,'company','update',0,0,0,0),(9295,1,'company','users',1,0,0,0),(9296,2,'company','users',0,0,0,0),(9297,3,'company','users',0,0,0,0);
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

-- Dump completed on 2024-09-08 18:53:18
