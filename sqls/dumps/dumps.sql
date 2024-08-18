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
) ENGINE=InnoDB AUTO_INCREMENT=8350 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (8203,1,'user','create',0,1,0,0),(8204,2,'user','create',0,0,0,0),(8205,3,'user','create',0,0,0,0),(8206,1,'user','fetch',1,0,0,0),(8207,2,'user','fetch',1,0,0,0),(8208,3,'user','fetch',1,0,0,0),(8209,1,'user','update',0,0,1,0),(8210,2,'user','update',0,0,0,0),(8211,3,'user','update',0,0,0,0),(8212,1,'user','profile',1,0,1,0),(8213,2,'user','profile',1,0,1,0),(8214,3,'user','profile',1,0,1,0),(8215,1,'client','list',1,0,0,0),(8216,2,'client','list',0,0,0,0),(8217,3,'client','list',0,0,0,0),(8218,1,'client','create',0,1,0,0),(8219,2,'client','create',0,0,0,0),(8220,3,'client','create',0,0,0,0),(8221,1,'client','fetch',1,0,0,0),(8222,2,'client','fetch',1,0,0,0),(8223,3,'client','fetch',0,0,0,0),(8224,1,'client','update',0,0,1,0),(8225,2,'client','update',0,0,0,0),(8226,3,'client','update',0,0,0,0),(8227,1,'client','users',1,0,0,0),(8228,2,'client','users',1,0,0,0),(8229,3,'client','users',0,0,0,0),(8230,1,'client','workdays',1,1,0,0),(8231,2,'client','workdays',1,0,0,0),(8232,3,'client','workdays',1,0,0,0),(8233,1,'utilities','states',1,0,0,0),(8234,2,'utilities','states',1,0,0,0),(8235,3,'utilities','states',1,0,0,0),(8236,1,'utilities','roles',1,0,0,0),(8237,2,'utilities','roles',1,0,0,0),(8238,3,'utilities','roles',0,0,0,0),(8239,1,'utilities','weekdays',1,0,0,0),(8240,2,'utilities','weekdays',1,0,0,0),(8241,3,'utilities','weekdays',1,0,0,0),(8242,1,'utilities','holidays',1,0,0,0),(8243,2,'utilities','holidays',1,0,0,0),(8244,3,'utilities','holidays',1,0,0,0),(8245,1,'utilities','workdays',1,0,0,0),(8246,2,'utilities','workdays',1,0,0,0),(8247,3,'utilities','workdays',1,0,0,0),(8248,1,'utilities','scheduleTimes',1,0,0,0),(8249,2,'utilities','scheduleTimes',1,0,0,0),(8250,3,'utilities','scheduleTimes',1,0,0,0),(8251,1,'job','list',1,0,0,0),(8252,2,'job','list',1,0,0,0),(8253,3,'job','list',0,0,0,0),(8254,1,'job','create',0,1,0,0),(8255,2,'job','create',0,1,0,0),(8256,3,'job','create',0,0,0,0),(8257,1,'job','fetch',1,0,0,0),(8258,2,'job','fetch',1,0,0,0),(8259,3,'job','fetch',0,0,0,0),(8260,1,'job','update',0,0,1,0),(8261,2,'job','update',0,0,1,0),(8262,3,'job','update',0,0,0,0),(8263,1,'schedule','list',1,0,0,0),(8264,2,'schedule','list',1,0,0,0),(8265,3,'schedule','list',0,0,0,0),(8266,1,'schedule','create',0,1,0,0),(8267,2,'schedule','create',0,1,0,0),(8268,3,'schedule','create',0,0,0,0),(8269,1,'schedule','fetch',1,0,0,0),(8270,2,'schedule','fetch',1,0,0,0),(8271,3,'schedule','fetch',0,0,0,0),(8272,1,'schedule','pending',1,0,0,0),(8273,2,'schedule','pending',1,0,0,0),(8274,3,'schedule','pending',0,0,0,0),(8275,1,'schedule','status',1,0,0,0),(8276,2,'schedule','status',1,0,0,0),(8277,3,'schedule','status',0,0,0,0),(8278,1,'schedule','assignment',1,1,0,1),(8279,2,'schedule','assignment',1,1,0,1),(8280,3,'schedule','assignment',0,0,0,0),(8281,1,'schedule','assignments',1,0,0,0),(8282,2,'schedule','assignments',1,0,0,0),(8283,3,'schedule','assignments',0,0,0,0),(8284,1,'schedule','days',1,0,0,0),(8285,2,'schedule','days',1,0,0,0),(8286,3,'schedule','days',0,0,0,0),(8287,1,'schedule','update',1,0,1,0),(8288,2,'schedule','update',1,0,1,0),(8289,3,'schedule','update',0,0,0,0),(8290,1,'schedule','delete',0,0,0,1),(8291,2,'schedule','delete',0,0,0,1),(8292,3,'schedule','delete',0,0,0,0),(8293,1,'schedule','clientReportByDay',1,0,0,0),(8294,2,'schedule','clientReportByDay',1,0,0,0),(8295,3,'schedule','clientReportByDay',0,0,0,0),(8296,1,'schedule','reportData',1,0,0,0),(8297,2,'schedule','reportData',1,0,0,0),(8298,3,'schedule','reportData',0,0,0,0),(8299,1,'schedule','scheduleStatusByRange',1,0,0,0),(8300,2,'schedule','scheduleStatusByRange',1,0,0,0),(8301,3,'schedule','scheduleStatusByRange',0,0,0,0),(8302,1,'schedule','notes',1,0,1,0),(8303,2,'schedule','notes',1,0,1,0),(8304,3,'schedule','notes',1,0,1,0),(8305,1,'skill','create',0,1,0,0),(8306,2,'skill','create',0,1,0,0),(8307,3,'skill','create',0,0,0,0),(8308,1,'skill','list',1,0,0,0),(8309,2,'skill','list',1,0,0,0),(8310,3,'skill','list',0,0,0,0),(8311,1,'skill','delete',0,0,1,0),(8312,2,'skill','delete',0,0,0,0),(8313,3,'skill','delete',0,0,0,0),(8314,1,'employee','list',1,0,0,0),(8315,2,'employee','list',1,0,0,0),(8316,3,'employee','list',0,0,0,0),(8317,1,'employee','create',0,1,0,0),(8318,2,'employee','create',0,1,0,0),(8319,3,'employee','create',0,0,0,0),(8320,1,'employee','schedule',1,0,0,0),(8321,2,'employee','schedule',1,0,0,0),(8322,3,'employee','schedule',0,0,0,0),(8323,1,'employee','available',1,0,0,0),(8324,2,'employee','available',1,0,0,0),(8325,3,'employee','available',0,0,0,0),(8326,1,'employee','assignments',1,0,0,0),(8327,2,'employee','assignments',1,0,0,0),(8328,3,'employee','assignments',0,0,0,0),(8329,1,'employee','fetch',1,0,0,0),(8330,2,'employee','fetch',1,0,0,0),(8331,3,'employee','fetch',1,0,0,0),(8332,1,'employee','update',0,0,1,0),(8333,2,'employee','update',0,0,1,0),(8334,3,'employee','update',0,0,0,0),(8335,1,'employee','workDays',1,1,0,0),(8336,2,'employee','workDays',1,1,0,0),(8337,3,'employee','workDays',1,0,0,0),(8338,1,'employee','skills',1,1,0,0),(8339,2,'employee','skills',1,1,0,0),(8340,3,'employee','skills',1,0,0,0),(8341,1,'employee','assignmentDetails',1,0,0,0),(8342,2,'employee','assignmentDetails',1,0,0,0),(8343,3,'employee','assignmentDetails',1,0,0,0),(8344,1,'company','fetch',1,0,0,0),(8345,2,'company','fetch',0,0,0,0),(8346,3,'company','fetch',0,0,0,0),(8347,1,'company','update',0,0,1,0),(8348,2,'company','update',0,0,0,0),(8349,3,'company','update',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=8230 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (8083,1,'user','create',0,1,0,0),(8084,2,'user','create',0,1,0,0),(8085,3,'user','create',0,0,0,0),(8086,1,'user','fetch',1,0,0,0),(8087,2,'user','fetch',1,0,0,0),(8088,3,'user','fetch',1,0,0,0),(8089,1,'user','update',0,0,1,0),(8090,2,'user','update',0,0,1,0),(8091,3,'user','update',0,0,0,0),(8092,1,'user','profile',1,0,1,0),(8093,2,'user','profile',1,0,1,0),(8094,3,'user','profile',1,0,1,0),(8095,1,'client','list',1,0,0,0),(8096,2,'client','list',0,0,0,0),(8097,3,'client','list',0,0,0,0),(8098,1,'client','create',0,1,0,0),(8099,2,'client','create',0,0,0,0),(8100,3,'client','create',0,0,0,0),(8101,1,'client','fetch',1,0,0,0),(8102,2,'client','fetch',1,0,0,0),(8103,3,'client','fetch',0,0,0,0),(8104,1,'client','update',0,0,1,0),(8105,2,'client','update',0,0,1,0),(8106,3,'client','update',0,0,0,0),(8107,1,'client','users',1,0,0,0),(8108,2,'client','users',1,0,0,0),(8109,3,'client','users',0,0,0,0),(8110,1,'client','workdays',1,1,0,0),(8111,2,'client','workdays',1,0,0,0),(8112,3,'client','workdays',1,0,0,0),(8113,1,'utilities','states',1,0,0,0),(8114,2,'utilities','states',1,0,0,0),(8115,3,'utilities','states',1,0,0,0),(8116,1,'utilities','roles',1,0,0,0),(8117,2,'utilities','roles',1,0,0,0),(8118,3,'utilities','roles',0,0,0,0),(8119,1,'utilities','weekdays',1,0,0,0),(8120,2,'utilities','weekdays',1,0,0,0),(8121,3,'utilities','weekdays',1,0,0,0),(8122,1,'utilities','holidays',1,0,0,0),(8123,2,'utilities','holidays',1,0,0,0),(8124,3,'utilities','holidays',1,0,0,0),(8125,1,'utilities','workdays',1,0,0,0),(8126,2,'utilities','workdays',1,0,0,0),(8127,3,'utilities','workdays',1,0,0,0),(8128,1,'utilities','scheduleTimes',1,0,0,0),(8129,2,'utilities','scheduleTimes',1,0,0,0),(8130,3,'utilities','scheduleTimes',1,0,0,0),(8131,1,'job','list',1,0,0,0),(8132,2,'job','list',1,0,0,0),(8133,3,'job','list',0,0,0,0),(8134,1,'job','create',0,1,0,0),(8135,2,'job','create',0,1,0,0),(8136,3,'job','create',0,0,0,0),(8137,1,'job','fetch',1,0,0,0),(8138,2,'job','fetch',1,0,0,0),(8139,3,'job','fetch',0,0,0,0),(8140,1,'job','update',0,0,1,0),(8141,2,'job','update',0,0,1,0),(8142,3,'job','update',0,0,0,0),(8143,1,'schedule','list',1,0,0,0),(8144,2,'schedule','list',1,0,0,0),(8145,3,'schedule','list',0,0,0,0),(8146,1,'schedule','create',0,1,0,0),(8147,2,'schedule','create',0,1,0,0),(8148,3,'schedule','create',0,0,0,0),(8149,1,'schedule','fetch',1,0,0,0),(8150,2,'schedule','fetch',1,0,0,0),(8151,3,'schedule','fetch',0,0,0,0),(8152,1,'schedule','pending',1,0,0,0),(8153,2,'schedule','pending',1,0,0,0),(8154,3,'schedule','pending',0,0,0,0),(8155,1,'schedule','status',1,0,0,0),(8156,2,'schedule','status',1,0,0,0),(8157,3,'schedule','status',0,0,0,0),(8158,1,'schedule','assignment',1,1,0,1),(8159,2,'schedule','assignment',1,0,0,0),(8160,3,'schedule','assignment',0,0,0,0),(8161,1,'schedule','assignments',1,0,0,0),(8162,2,'schedule','assignments',1,0,0,0),(8163,3,'schedule','assignments',1,0,0,0),(8164,1,'schedule','days',1,0,0,0),(8165,2,'schedule','days',0,0,0,0),(8166,3,'schedule','days',0,0,0,0),(8167,1,'schedule','update',1,0,1,0),(8168,2,'schedule','update',1,0,1,0),(8169,3,'schedule','update',0,0,0,0),(8170,1,'schedule','delete',0,0,0,1),(8171,2,'schedule','delete',0,0,0,0),(8172,3,'schedule','delete',0,0,0,0),(8173,1,'schedule','clientReportByDay',1,0,0,0),(8174,2,'schedule','clientReportByDay',1,0,0,0),(8175,3,'schedule','clientReportByDay',0,0,0,0),(8176,1,'schedule','reportData',1,0,0,0),(8177,2,'schedule','reportData',1,0,0,0),(8178,3,'schedule','reportData',0,0,0,0),(8179,1,'schedule','scheduleStatusByRange',1,0,0,0),(8180,2,'schedule','scheduleStatusByRange',1,0,0,0),(8181,3,'schedule','scheduleStatusByRange',0,0,0,0),(8182,1,'schedule','notes',1,0,1,0),(8183,2,'schedule','notes',1,0,1,0),(8184,3,'schedule','notes',0,0,0,0),(8185,1,'skill','create',0,1,0,0),(8186,2,'skill','create',0,0,0,0),(8187,3,'skill','create',0,0,0,0),(8188,1,'skill','list',1,0,0,0),(8189,2,'skill','list',1,0,0,0),(8190,3,'skill','list',0,0,0,0),(8191,1,'skill','delete',0,0,1,0),(8192,2,'skill','delete',0,0,0,0),(8193,3,'skill','delete',0,0,0,0),(8194,1,'employee','list',1,0,0,0),(8195,2,'employee','list',0,0,0,0),(8196,3,'employee','list',0,0,0,0),(8197,1,'employee','create',0,1,0,0),(8198,2,'employee','create',0,0,0,0),(8199,3,'employee','create',0,0,0,0),(8200,1,'employee','schedule',1,0,0,0),(8201,2,'employee','schedule',0,0,0,0),(8202,3,'employee','schedule',0,0,0,0),(8203,1,'employee','available',1,0,0,0),(8204,2,'employee','available',0,0,0,0),(8205,3,'employee','available',0,0,0,0),(8206,1,'employee','assignments',1,0,0,0),(8207,2,'employee','assignments',1,0,0,0),(8208,3,'employee','assignments',1,0,0,0),(8209,1,'employee','fetch',1,0,0,0),(8210,2,'employee','fetch',1,0,0,0),(8211,3,'employee','fetch',1,0,0,0),(8212,1,'employee','update',0,0,1,0),(8213,2,'employee','update',0,0,0,0),(8214,3,'employee','update',0,0,0,0),(8215,1,'employee','workDays',1,1,0,0),(8216,2,'employee','workDays',0,0,0,0),(8217,3,'employee','workDays',0,0,0,0),(8218,1,'employee','skills',1,1,0,0),(8219,2,'employee','skills',0,0,0,0),(8220,3,'employee','skills',0,0,0,0),(8221,1,'employee','assignmentDetails',1,0,0,0),(8222,2,'employee','assignmentDetails',1,0,0,0),(8223,3,'employee','assignmentDetails',1,0,0,0),(8224,1,'company','fetch',1,0,0,0),(8225,2,'company','fetch',0,0,0,0),(8226,3,'company','fetch',0,0,0,0),(8227,1,'company','update',0,0,1,0),(8228,2,'company','update',0,0,0,0),(8229,3,'company','update',0,0,0,0);
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

-- Dump completed on 2024-08-18  0:40:20
