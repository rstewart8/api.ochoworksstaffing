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
) ENGINE=InnoDB AUTO_INCREMENT=8500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (8350,1,'user','create',0,1,0,0),(8351,2,'user','create',0,0,0,0),(8352,3,'user','create',0,0,0,0),(8353,1,'user','fetch',1,0,0,0),(8354,2,'user','fetch',1,0,0,0),(8355,3,'user','fetch',1,0,0,0),(8356,1,'user','update',0,0,1,0),(8357,2,'user','update',0,0,0,0),(8358,3,'user','update',0,0,0,0),(8359,1,'user','profile',1,0,1,0),(8360,2,'user','profile',1,0,1,0),(8361,3,'user','profile',1,0,1,0),(8362,1,'client','list',1,0,0,0),(8363,2,'client','list',0,0,0,0),(8364,3,'client','list',0,0,0,0),(8365,1,'client','create',0,1,0,0),(8366,2,'client','create',0,0,0,0),(8367,3,'client','create',0,0,0,0),(8368,1,'client','fetch',1,0,0,0),(8369,2,'client','fetch',1,0,0,0),(8370,3,'client','fetch',0,0,0,0),(8371,1,'client','update',0,0,1,0),(8372,2,'client','update',0,0,0,0),(8373,3,'client','update',0,0,0,0),(8374,1,'client','users',1,0,0,0),(8375,2,'client','users',1,0,0,0),(8376,3,'client','users',0,0,0,0),(8377,1,'client','workdays',1,1,0,0),(8378,2,'client','workdays',1,0,0,0),(8379,3,'client','workdays',1,0,0,0),(8380,1,'utilities','states',1,0,0,0),(8381,2,'utilities','states',1,0,0,0),(8382,3,'utilities','states',1,0,0,0),(8383,1,'utilities','roles',1,0,0,0),(8384,2,'utilities','roles',1,0,0,0),(8385,3,'utilities','roles',0,0,0,0),(8386,1,'utilities','weekdays',1,0,0,0),(8387,2,'utilities','weekdays',1,0,0,0),(8388,3,'utilities','weekdays',1,0,0,0),(8389,1,'utilities','holidays',1,0,0,0),(8390,2,'utilities','holidays',1,0,0,0),(8391,3,'utilities','holidays',1,0,0,0),(8392,1,'utilities','workdays',1,0,0,0),(8393,2,'utilities','workdays',1,0,0,0),(8394,3,'utilities','workdays',1,0,0,0),(8395,1,'utilities','scheduleTimes',1,0,0,0),(8396,2,'utilities','scheduleTimes',1,0,0,0),(8397,3,'utilities','scheduleTimes',1,0,0,0),(8398,1,'job','list',1,0,0,0),(8399,2,'job','list',1,0,0,0),(8400,3,'job','list',0,0,0,0),(8401,1,'job','create',0,1,0,0),(8402,2,'job','create',0,1,0,0),(8403,3,'job','create',0,0,0,0),(8404,1,'job','fetch',1,0,0,0),(8405,2,'job','fetch',1,0,0,0),(8406,3,'job','fetch',0,0,0,0),(8407,1,'job','update',0,0,1,0),(8408,2,'job','update',0,0,1,0),(8409,3,'job','update',0,0,0,0),(8410,1,'schedule','list',1,0,0,0),(8411,2,'schedule','list',1,0,0,0),(8412,3,'schedule','list',0,0,0,0),(8413,1,'schedule','create',0,1,0,0),(8414,2,'schedule','create',0,1,0,0),(8415,3,'schedule','create',0,0,0,0),(8416,1,'schedule','fetch',1,0,0,0),(8417,2,'schedule','fetch',1,0,0,0),(8418,3,'schedule','fetch',0,0,0,0),(8419,1,'schedule','pending',1,0,0,0),(8420,2,'schedule','pending',1,0,0,0),(8421,3,'schedule','pending',0,0,0,0),(8422,1,'schedule','status',1,0,0,0),(8423,2,'schedule','status',1,0,0,0),(8424,3,'schedule','status',0,0,0,0),(8425,1,'schedule','assignment',1,1,0,1),(8426,2,'schedule','assignment',1,1,0,1),(8427,3,'schedule','assignment',0,0,0,0),(8428,1,'schedule','assignments',1,0,0,0),(8429,2,'schedule','assignments',1,0,0,0),(8430,3,'schedule','assignments',0,0,0,0),(8431,1,'schedule','days',1,0,0,0),(8432,2,'schedule','days',1,0,0,0),(8433,3,'schedule','days',0,0,0,0),(8434,1,'schedule','update',1,0,1,0),(8435,2,'schedule','update',1,0,1,0),(8436,3,'schedule','update',0,0,0,0),(8437,1,'schedule','delete',0,0,0,1),(8438,2,'schedule','delete',0,0,0,1),(8439,3,'schedule','delete',0,0,0,0),(8440,1,'schedule','clientReportByDay',1,0,0,0),(8441,2,'schedule','clientReportByDay',1,0,0,0),(8442,3,'schedule','clientReportByDay',0,0,0,0),(8443,1,'schedule','reportData',1,0,0,0),(8444,2,'schedule','reportData',1,0,0,0),(8445,3,'schedule','reportData',0,0,0,0),(8446,1,'schedule','scheduleStatusByRange',1,0,0,0),(8447,2,'schedule','scheduleStatusByRange',1,0,0,0),(8448,3,'schedule','scheduleStatusByRange',0,0,0,0),(8449,1,'schedule','notes',1,0,1,0),(8450,2,'schedule','notes',1,0,1,0),(8451,3,'schedule','notes',1,0,1,0),(8452,1,'skill','create',0,1,0,0),(8453,2,'skill','create',0,1,0,0),(8454,3,'skill','create',0,0,0,0),(8455,1,'skill','list',1,0,0,0),(8456,2,'skill','list',1,0,0,0),(8457,3,'skill','list',0,0,0,0),(8458,1,'skill','delete',0,0,1,0),(8459,2,'skill','delete',0,0,0,0),(8460,3,'skill','delete',0,0,0,0),(8461,1,'employee','list',1,0,0,0),(8462,2,'employee','list',1,0,0,0),(8463,3,'employee','list',0,0,0,0),(8464,1,'employee','create',0,1,0,0),(8465,2,'employee','create',0,1,0,0),(8466,3,'employee','create',0,0,0,0),(8467,1,'employee','schedule',1,0,0,0),(8468,2,'employee','schedule',1,0,0,0),(8469,3,'employee','schedule',0,0,0,0),(8470,1,'employee','available',1,0,0,0),(8471,2,'employee','available',1,0,0,0),(8472,3,'employee','available',0,0,0,0),(8473,1,'employee','assignments',1,0,0,0),(8474,2,'employee','assignments',1,0,0,0),(8475,3,'employee','assignments',0,0,0,0),(8476,1,'employee','fetch',1,0,0,0),(8477,2,'employee','fetch',1,0,0,0),(8478,3,'employee','fetch',1,0,0,0),(8479,1,'employee','update',0,0,1,0),(8480,2,'employee','update',0,0,1,0),(8481,3,'employee','update',0,0,0,0),(8482,1,'employee','workDays',1,1,0,0),(8483,2,'employee','workDays',1,1,0,0),(8484,3,'employee','workDays',1,0,0,0),(8485,1,'employee','skills',1,1,0,0),(8486,2,'employee','skills',1,1,0,0),(8487,3,'employee','skills',1,0,0,0),(8488,1,'employee','assignmentDetails',1,0,0,0),(8489,2,'employee','assignmentDetails',1,0,0,0),(8490,3,'employee','assignmentDetails',1,0,0,0),(8491,1,'company','fetch',1,0,0,0),(8492,2,'company','fetch',0,0,0,0),(8493,3,'company','fetch',0,0,0,0),(8494,1,'company','update',0,0,1,0),(8495,2,'company','update',0,0,0,0),(8496,3,'company','update',0,0,0,0),(8497,1,'company','users',1,0,0,0),(8498,2,'company','users',0,0,0,0),(8499,3,'company','users',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=8380 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (8230,1,'user','create',0,1,0,0),(8231,2,'user','create',0,1,0,0),(8232,3,'user','create',0,0,0,0),(8233,1,'user','fetch',1,0,0,0),(8234,2,'user','fetch',1,0,0,0),(8235,3,'user','fetch',1,0,0,0),(8236,1,'user','update',0,0,1,0),(8237,2,'user','update',0,0,1,0),(8238,3,'user','update',0,0,0,0),(8239,1,'user','profile',1,0,1,0),(8240,2,'user','profile',1,0,1,0),(8241,3,'user','profile',1,0,1,0),(8242,1,'client','list',1,0,0,0),(8243,2,'client','list',0,0,0,0),(8244,3,'client','list',0,0,0,0),(8245,1,'client','create',0,1,0,0),(8246,2,'client','create',0,0,0,0),(8247,3,'client','create',0,0,0,0),(8248,1,'client','fetch',1,0,0,0),(8249,2,'client','fetch',1,0,0,0),(8250,3,'client','fetch',0,0,0,0),(8251,1,'client','update',0,0,1,0),(8252,2,'client','update',0,0,1,0),(8253,3,'client','update',0,0,0,0),(8254,1,'client','users',1,0,0,0),(8255,2,'client','users',1,0,0,0),(8256,3,'client','users',0,0,0,0),(8257,1,'client','workdays',1,1,0,0),(8258,2,'client','workdays',1,0,0,0),(8259,3,'client','workdays',1,0,0,0),(8260,1,'utilities','states',1,0,0,0),(8261,2,'utilities','states',1,0,0,0),(8262,3,'utilities','states',1,0,0,0),(8263,1,'utilities','roles',1,0,0,0),(8264,2,'utilities','roles',1,0,0,0),(8265,3,'utilities','roles',0,0,0,0),(8266,1,'utilities','weekdays',1,0,0,0),(8267,2,'utilities','weekdays',1,0,0,0),(8268,3,'utilities','weekdays',1,0,0,0),(8269,1,'utilities','holidays',1,0,0,0),(8270,2,'utilities','holidays',1,0,0,0),(8271,3,'utilities','holidays',1,0,0,0),(8272,1,'utilities','workdays',1,0,0,0),(8273,2,'utilities','workdays',1,0,0,0),(8274,3,'utilities','workdays',1,0,0,0),(8275,1,'utilities','scheduleTimes',1,0,0,0),(8276,2,'utilities','scheduleTimes',1,0,0,0),(8277,3,'utilities','scheduleTimes',1,0,0,0),(8278,1,'job','list',1,0,0,0),(8279,2,'job','list',1,0,0,0),(8280,3,'job','list',0,0,0,0),(8281,1,'job','create',0,1,0,0),(8282,2,'job','create',0,1,0,0),(8283,3,'job','create',0,0,0,0),(8284,1,'job','fetch',1,0,0,0),(8285,2,'job','fetch',1,0,0,0),(8286,3,'job','fetch',0,0,0,0),(8287,1,'job','update',0,0,1,0),(8288,2,'job','update',0,0,1,0),(8289,3,'job','update',0,0,0,0),(8290,1,'schedule','list',1,0,0,0),(8291,2,'schedule','list',1,0,0,0),(8292,3,'schedule','list',0,0,0,0),(8293,1,'schedule','create',0,1,0,0),(8294,2,'schedule','create',0,1,0,0),(8295,3,'schedule','create',0,0,0,0),(8296,1,'schedule','fetch',1,0,0,0),(8297,2,'schedule','fetch',1,0,0,0),(8298,3,'schedule','fetch',0,0,0,0),(8299,1,'schedule','pending',1,0,0,0),(8300,2,'schedule','pending',1,0,0,0),(8301,3,'schedule','pending',0,0,0,0),(8302,1,'schedule','status',1,0,0,0),(8303,2,'schedule','status',1,0,0,0),(8304,3,'schedule','status',0,0,0,0),(8305,1,'schedule','assignment',1,1,0,1),(8306,2,'schedule','assignment',1,0,0,0),(8307,3,'schedule','assignment',0,0,0,0),(8308,1,'schedule','assignments',1,0,0,0),(8309,2,'schedule','assignments',1,0,0,0),(8310,3,'schedule','assignments',1,0,0,0),(8311,1,'schedule','days',1,0,0,0),(8312,2,'schedule','days',0,0,0,0),(8313,3,'schedule','days',0,0,0,0),(8314,1,'schedule','update',1,0,1,0),(8315,2,'schedule','update',1,0,1,0),(8316,3,'schedule','update',0,0,0,0),(8317,1,'schedule','delete',0,0,0,1),(8318,2,'schedule','delete',0,0,0,0),(8319,3,'schedule','delete',0,0,0,0),(8320,1,'schedule','clientReportByDay',1,0,0,0),(8321,2,'schedule','clientReportByDay',1,0,0,0),(8322,3,'schedule','clientReportByDay',0,0,0,0),(8323,1,'schedule','reportData',1,0,0,0),(8324,2,'schedule','reportData',1,0,0,0),(8325,3,'schedule','reportData',0,0,0,0),(8326,1,'schedule','scheduleStatusByRange',1,0,0,0),(8327,2,'schedule','scheduleStatusByRange',1,0,0,0),(8328,3,'schedule','scheduleStatusByRange',0,0,0,0),(8329,1,'schedule','notes',1,0,1,0),(8330,2,'schedule','notes',1,0,1,0),(8331,3,'schedule','notes',0,0,0,0),(8332,1,'skill','create',0,1,0,0),(8333,2,'skill','create',0,0,0,0),(8334,3,'skill','create',0,0,0,0),(8335,1,'skill','list',1,0,0,0),(8336,2,'skill','list',1,0,0,0),(8337,3,'skill','list',0,0,0,0),(8338,1,'skill','delete',0,0,1,0),(8339,2,'skill','delete',0,0,0,0),(8340,3,'skill','delete',0,0,0,0),(8341,1,'employee','list',1,0,0,0),(8342,2,'employee','list',0,0,0,0),(8343,3,'employee','list',0,0,0,0),(8344,1,'employee','create',0,1,0,0),(8345,2,'employee','create',0,0,0,0),(8346,3,'employee','create',0,0,0,0),(8347,1,'employee','schedule',1,0,0,0),(8348,2,'employee','schedule',0,0,0,0),(8349,3,'employee','schedule',0,0,0,0),(8350,1,'employee','available',1,0,0,0),(8351,2,'employee','available',0,0,0,0),(8352,3,'employee','available',0,0,0,0),(8353,1,'employee','assignments',1,0,0,0),(8354,2,'employee','assignments',1,0,0,0),(8355,3,'employee','assignments',1,0,0,0),(8356,1,'employee','fetch',1,0,0,0),(8357,2,'employee','fetch',1,0,0,0),(8358,3,'employee','fetch',1,0,0,0),(8359,1,'employee','update',0,0,1,0),(8360,2,'employee','update',0,0,0,0),(8361,3,'employee','update',0,0,0,0),(8362,1,'employee','workDays',1,1,0,0),(8363,2,'employee','workDays',0,0,0,0),(8364,3,'employee','workDays',0,0,0,0),(8365,1,'employee','skills',1,1,0,0),(8366,2,'employee','skills',0,0,0,0),(8367,3,'employee','skills',0,0,0,0),(8368,1,'employee','assignmentDetails',1,0,0,0),(8369,2,'employee','assignmentDetails',1,0,0,0),(8370,3,'employee','assignmentDetails',1,0,0,0),(8371,1,'company','fetch',1,0,0,0),(8372,2,'company','fetch',0,0,0,0),(8373,3,'company','fetch',0,0,0,0),(8374,1,'company','update',0,0,1,0),(8375,2,'company','update',0,0,0,0),(8376,3,'company','update',0,0,0,0),(8377,1,'company','users',1,0,0,0),(8378,2,'company','users',0,0,0,0),(8379,3,'company','users',0,0,0,0);
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

-- Dump completed on 2024-08-18 13:23:40
