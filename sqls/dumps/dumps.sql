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
) ENGINE=InnoDB AUTO_INCREMENT=11257 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (11083,1,'user','create',0,1,0,0),(11084,2,'user','create',0,0,0,0),(11085,3,'user','create',0,0,0,0),(11086,1,'user','fetch',1,0,0,0),(11087,2,'user','fetch',1,0,0,0),(11088,3,'user','fetch',1,0,0,0),(11089,1,'user','update',0,0,1,0),(11090,2,'user','update',0,0,0,0),(11091,3,'user','update',0,0,0,0),(11092,1,'user','profile',1,0,1,0),(11093,2,'user','profile',1,0,1,0),(11094,3,'user','profile',1,0,1,0),(11095,1,'user','photo',0,1,0,0),(11096,2,'user','photo',0,1,0,0),(11097,3,'user','photo',0,1,0,0),(11098,1,'user','resetPassword',0,0,1,0),(11099,2,'user','resetPassword',0,0,1,0),(11100,3,'user','resetPassword',0,0,1,0),(11101,1,'client','list',1,0,0,0),(11102,2,'client','list',0,0,0,0),(11103,3,'client','list',0,0,0,0),(11104,1,'client','create',0,1,0,0),(11105,2,'client','create',0,0,0,0),(11106,3,'client','create',0,0,0,0),(11107,1,'client','fetch',1,0,0,0),(11108,2,'client','fetch',1,0,0,0),(11109,3,'client','fetch',0,0,0,0),(11110,1,'client','update',0,0,1,0),(11111,2,'client','update',0,0,0,0),(11112,3,'client','update',0,0,0,0),(11113,1,'client','users',1,0,0,0),(11114,2,'client','users',1,0,0,0),(11115,3,'client','users',0,0,0,0),(11116,1,'client','workdays',1,1,0,0),(11117,2,'client','workdays',1,0,0,0),(11118,3,'client','workdays',1,0,0,0),(11119,1,'utilities','states',1,0,0,0),(11120,2,'utilities','states',1,0,0,0),(11121,3,'utilities','states',1,0,0,0),(11122,1,'utilities','roles',1,0,0,0),(11123,2,'utilities','roles',1,0,0,0),(11124,3,'utilities','roles',0,0,0,0),(11125,1,'utilities','weekdays',1,0,0,0),(11126,2,'utilities','weekdays',1,0,0,0),(11127,3,'utilities','weekdays',1,0,0,0),(11128,1,'utilities','holidays',1,0,0,0),(11129,2,'utilities','holidays',1,0,0,0),(11130,3,'utilities','holidays',1,0,0,0),(11131,1,'utilities','workdays',1,0,0,0),(11132,2,'utilities','workdays',1,0,0,0),(11133,3,'utilities','workdays',1,0,0,0),(11134,1,'utilities','scheduleTimes',1,0,0,0),(11135,2,'utilities','scheduleTimes',1,0,0,0),(11136,3,'utilities','scheduleTimes',1,0,0,0),(11137,1,'job','list',1,0,0,0),(11138,2,'job','list',1,0,0,0),(11139,3,'job','list',0,0,0,0),(11140,1,'job','create',0,1,0,0),(11141,2,'job','create',0,1,0,0),(11142,3,'job','create',0,0,0,0),(11143,1,'job','fetch',1,0,0,0),(11144,2,'job','fetch',1,0,0,0),(11145,3,'job','fetch',0,0,0,0),(11146,1,'job','update',0,0,1,0),(11147,2,'job','update',0,0,1,0),(11148,3,'job','update',0,0,0,0),(11149,1,'schedule','list',1,0,0,0),(11150,2,'schedule','list',1,0,0,0),(11151,3,'schedule','list',0,0,0,0),(11152,1,'schedule','create',0,1,0,0),(11153,2,'schedule','create',0,1,0,0),(11154,3,'schedule','create',0,0,0,0),(11155,1,'schedule','fetch',1,0,0,0),(11156,2,'schedule','fetch',1,0,0,0),(11157,3,'schedule','fetch',0,0,0,0),(11158,1,'schedule','pending',1,0,0,0),(11159,2,'schedule','pending',1,0,0,0),(11160,3,'schedule','pending',0,0,0,0),(11161,1,'schedule','status',1,0,0,0),(11162,2,'schedule','status',1,0,0,0),(11163,3,'schedule','status',0,0,0,0),(11164,1,'schedule','assignment',1,1,0,1),(11165,2,'schedule','assignment',1,1,0,1),(11166,3,'schedule','assignment',0,0,0,0),(11167,1,'schedule','assignments',1,0,0,0),(11168,2,'schedule','assignments',1,0,0,0),(11169,3,'schedule','assignments',0,0,0,0),(11170,1,'schedule','days',1,0,0,0),(11171,2,'schedule','days',1,0,0,0),(11172,3,'schedule','days',0,0,0,0),(11173,1,'schedule','update',1,0,1,0),(11174,2,'schedule','update',1,0,1,0),(11175,3,'schedule','update',0,0,0,0),(11176,1,'schedule','delete',0,0,0,1),(11177,2,'schedule','delete',0,0,0,1),(11178,3,'schedule','delete',0,0,0,0),(11179,1,'schedule','clientReportByDay',1,0,0,0),(11180,2,'schedule','clientReportByDay',1,0,0,0),(11181,3,'schedule','clientReportByDay',0,0,0,0),(11182,1,'schedule','reportData',1,0,0,0),(11183,2,'schedule','reportData',1,0,0,0),(11184,3,'schedule','reportData',0,0,0,0),(11185,1,'schedule','scheduleStatusByRange',1,0,0,0),(11186,2,'schedule','scheduleStatusByRange',1,0,0,0),(11187,3,'schedule','scheduleStatusByRange',0,0,0,0),(11188,1,'schedule','notes',1,0,1,0),(11189,2,'schedule','notes',1,0,1,0),(11190,3,'schedule','notes',1,0,1,0),(11191,1,'schedule','jobReportByDay',1,0,0,0),(11192,2,'schedule','jobReportByDay',1,0,0,0),(11193,3,'schedule','jobReportByDay',0,0,0,0),(11194,1,'skill','create',0,1,0,0),(11195,2,'skill','create',0,1,0,0),(11196,3,'skill','create',0,0,0,0),(11197,1,'skill','list',1,0,0,0),(11198,2,'skill','list',1,0,0,0),(11199,3,'skill','list',0,0,0,0),(11200,1,'skill','delete',0,0,1,0),(11201,2,'skill','delete',0,0,0,0),(11202,3,'skill','delete',0,0,0,0),(11203,1,'employee','list',1,0,0,0),(11204,2,'employee','list',1,0,0,0),(11205,3,'employee','list',0,0,0,0),(11206,1,'employee','create',0,1,0,0),(11207,2,'employee','create',0,1,0,0),(11208,3,'employee','create',0,0,0,0),(11209,1,'employee','schedule',1,0,0,0),(11210,2,'employee','schedule',1,0,0,0),(11211,3,'employee','schedule',0,0,0,0),(11212,1,'employee','available',1,0,0,0),(11213,2,'employee','available',1,0,0,0),(11214,3,'employee','available',0,0,0,0),(11215,1,'employee','assignments',1,0,0,0),(11216,2,'employee','assignments',1,0,0,0),(11217,3,'employee','assignments',0,0,0,0),(11218,1,'employee','fetch',1,0,0,0),(11219,2,'employee','fetch',1,0,0,0),(11220,3,'employee','fetch',1,0,0,0),(11221,1,'employee','update',0,0,1,0),(11222,2,'employee','update',0,0,1,0),(11223,3,'employee','update',0,0,0,0),(11224,1,'employee','workDays',1,1,0,0),(11225,2,'employee','workDays',1,1,0,0),(11226,3,'employee','workDays',1,0,0,0),(11227,1,'employee','skills',1,1,0,0),(11228,2,'employee','skills',1,1,0,0),(11229,3,'employee','skills',1,0,0,0),(11230,1,'employee','assignmentDetails',1,0,0,0),(11231,2,'employee','assignmentDetails',1,0,0,0),(11232,3,'employee','assignmentDetails',1,0,0,0),(11233,1,'employee','forClientByDays',1,0,0,0),(11234,2,'employee','forClientByDays',1,0,0,0),(11235,3,'employee','forClientByDays',0,0,0,0),(11236,1,'company','fetch',1,0,0,0),(11237,2,'company','fetch',0,0,0,0),(11238,3,'company','fetch',0,0,0,0),(11239,1,'company','update',0,0,1,0),(11240,2,'company','update',0,0,0,0),(11241,3,'company','update',0,0,0,0),(11242,1,'company','users',1,0,0,0),(11243,2,'company','users',0,0,0,0),(11244,3,'company','users',0,0,0,0),(11245,1,'notification','list',1,0,0,0),(11246,2,'notification','list',1,0,0,0),(11247,3,'notification','list',1,0,0,0),(11248,1,'notification','companyToggle',0,1,0,0),(11249,2,'notification','companyToggle',0,0,0,0),(11250,3,'notification','companyToggle',0,0,0,0),(11251,1,'notification','employeeToggle',0,1,0,0),(11252,2,'notification','employeeToggle',0,1,0,0),(11253,3,'notification','employeeToggle',0,1,0,0),(11254,1,'notification','queueUp',0,1,0,0),(11255,2,'notification','queueUp',0,1,0,0),(11256,3,'notification','queueUp',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=11137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (10963,1,'user','create',0,1,0,0),(10964,2,'user','create',0,1,0,0),(10965,3,'user','create',0,0,0,0),(10966,1,'user','fetch',1,0,0,0),(10967,2,'user','fetch',1,0,0,0),(10968,3,'user','fetch',1,0,0,0),(10969,1,'user','update',0,0,1,0),(10970,2,'user','update',0,0,1,0),(10971,3,'user','update',0,0,0,0),(10972,1,'user','profile',1,0,1,0),(10973,2,'user','profile',1,0,1,0),(10974,3,'user','profile',1,0,1,0),(10975,1,'user','photo',0,1,0,0),(10976,2,'user','photo',0,1,0,0),(10977,3,'user','photo',0,1,0,0),(10978,1,'user','resetPassword',0,0,1,0),(10979,2,'user','resetPassword',0,0,1,0),(10980,3,'user','resetPassword',0,0,1,0),(10981,1,'client','list',1,0,0,0),(10982,2,'client','list',0,0,0,0),(10983,3,'client','list',0,0,0,0),(10984,1,'client','create',0,1,0,0),(10985,2,'client','create',0,0,0,0),(10986,3,'client','create',0,0,0,0),(10987,1,'client','fetch',1,0,0,0),(10988,2,'client','fetch',1,0,0,0),(10989,3,'client','fetch',0,0,0,0),(10990,1,'client','update',0,0,1,0),(10991,2,'client','update',0,0,1,0),(10992,3,'client','update',0,0,0,0),(10993,1,'client','users',1,0,0,0),(10994,2,'client','users',1,0,0,0),(10995,3,'client','users',0,0,0,0),(10996,1,'client','workdays',1,1,0,0),(10997,2,'client','workdays',1,0,0,0),(10998,3,'client','workdays',1,0,0,0),(10999,1,'utilities','states',1,0,0,0),(11000,2,'utilities','states',1,0,0,0),(11001,3,'utilities','states',1,0,0,0),(11002,1,'utilities','roles',1,0,0,0),(11003,2,'utilities','roles',1,0,0,0),(11004,3,'utilities','roles',0,0,0,0),(11005,1,'utilities','weekdays',1,0,0,0),(11006,2,'utilities','weekdays',1,0,0,0),(11007,3,'utilities','weekdays',1,0,0,0),(11008,1,'utilities','holidays',1,0,0,0),(11009,2,'utilities','holidays',1,0,0,0),(11010,3,'utilities','holidays',1,0,0,0),(11011,1,'utilities','workdays',1,0,0,0),(11012,2,'utilities','workdays',1,0,0,0),(11013,3,'utilities','workdays',1,0,0,0),(11014,1,'utilities','scheduleTimes',1,0,0,0),(11015,2,'utilities','scheduleTimes',1,0,0,0),(11016,3,'utilities','scheduleTimes',1,0,0,0),(11017,1,'job','list',1,0,0,0),(11018,2,'job','list',1,0,0,0),(11019,3,'job','list',0,0,0,0),(11020,1,'job','create',0,1,0,0),(11021,2,'job','create',0,1,0,0),(11022,3,'job','create',0,0,0,0),(11023,1,'job','fetch',1,0,0,0),(11024,2,'job','fetch',1,0,0,0),(11025,3,'job','fetch',0,0,0,0),(11026,1,'job','update',0,0,1,0),(11027,2,'job','update',0,0,1,0),(11028,3,'job','update',0,0,0,0),(11029,1,'schedule','list',1,0,0,0),(11030,2,'schedule','list',1,0,0,0),(11031,3,'schedule','list',0,0,0,0),(11032,1,'schedule','create',0,1,0,0),(11033,2,'schedule','create',0,1,0,0),(11034,3,'schedule','create',0,0,0,0),(11035,1,'schedule','fetch',1,0,0,0),(11036,2,'schedule','fetch',1,0,0,0),(11037,3,'schedule','fetch',0,0,0,0),(11038,1,'schedule','pending',1,0,0,0),(11039,2,'schedule','pending',1,0,0,0),(11040,3,'schedule','pending',0,0,0,0),(11041,1,'schedule','status',1,0,0,0),(11042,2,'schedule','status',1,0,0,0),(11043,3,'schedule','status',0,0,0,0),(11044,1,'schedule','assignment',1,1,0,1),(11045,2,'schedule','assignment',1,0,0,0),(11046,3,'schedule','assignment',0,0,0,0),(11047,1,'schedule','assignments',1,0,0,0),(11048,2,'schedule','assignments',1,0,0,0),(11049,3,'schedule','assignments',1,0,0,0),(11050,1,'schedule','days',1,0,0,0),(11051,2,'schedule','days',1,0,0,0),(11052,3,'schedule','days',0,0,0,0),(11053,1,'schedule','update',1,0,1,0),(11054,2,'schedule','update',1,0,1,0),(11055,3,'schedule','update',0,0,0,0),(11056,1,'schedule','delete',0,0,0,1),(11057,2,'schedule','delete',0,0,0,0),(11058,3,'schedule','delete',0,0,0,0),(11059,1,'schedule','clientReportByDay',1,0,0,0),(11060,2,'schedule','clientReportByDay',1,0,0,0),(11061,3,'schedule','clientReportByDay',0,0,0,0),(11062,1,'schedule','reportData',1,0,0,0),(11063,2,'schedule','reportData',1,0,0,0),(11064,3,'schedule','reportData',0,0,0,0),(11065,1,'schedule','scheduleStatusByRange',1,0,0,0),(11066,2,'schedule','scheduleStatusByRange',1,0,0,0),(11067,3,'schedule','scheduleStatusByRange',0,0,0,0),(11068,1,'schedule','notes',1,0,1,0),(11069,2,'schedule','notes',1,0,1,0),(11070,3,'schedule','notes',0,0,0,0),(11071,1,'schedule','jobReportByDay',1,0,0,0),(11072,2,'schedule','jobReportByDay',1,0,0,0),(11073,3,'schedule','jobReportByDay',0,0,0,0),(11074,1,'skill','create',0,1,0,0),(11075,2,'skill','create',0,0,0,0),(11076,3,'skill','create',0,0,0,0),(11077,1,'skill','list',1,0,0,0),(11078,2,'skill','list',1,0,0,0),(11079,3,'skill','list',0,0,0,0),(11080,1,'skill','delete',0,0,1,0),(11081,2,'skill','delete',0,0,0,0),(11082,3,'skill','delete',0,0,0,0),(11083,1,'employee','list',1,0,0,0),(11084,2,'employee','list',0,0,0,0),(11085,3,'employee','list',0,0,0,0),(11086,1,'employee','create',0,1,0,0),(11087,2,'employee','create',0,0,0,0),(11088,3,'employee','create',0,0,0,0),(11089,1,'employee','schedule',1,0,0,0),(11090,2,'employee','schedule',0,0,0,0),(11091,3,'employee','schedule',0,0,0,0),(11092,1,'employee','available',1,0,0,0),(11093,2,'employee','available',0,0,0,0),(11094,3,'employee','available',0,0,0,0),(11095,1,'employee','assignments',1,0,0,0),(11096,2,'employee','assignments',1,0,0,0),(11097,3,'employee','assignments',1,0,0,0),(11098,1,'employee','fetch',1,0,0,0),(11099,2,'employee','fetch',1,0,0,0),(11100,3,'employee','fetch',1,0,0,0),(11101,1,'employee','update',0,0,1,0),(11102,2,'employee','update',0,0,0,0),(11103,3,'employee','update',0,0,0,0),(11104,1,'employee','workDays',1,1,0,0),(11105,2,'employee','workDays',0,0,0,0),(11106,3,'employee','workDays',1,0,0,0),(11107,1,'employee','skills',1,1,0,0),(11108,2,'employee','skills',0,0,0,0),(11109,3,'employee','skills',1,0,0,0),(11110,1,'employee','assignmentDetails',1,0,0,0),(11111,2,'employee','assignmentDetails',1,0,0,0),(11112,3,'employee','assignmentDetails',1,0,0,0),(11113,1,'employee','forClientByDays',1,0,0,0),(11114,2,'employee','forClientByDays',1,0,0,0),(11115,3,'employee','forClientByDays',0,0,0,0),(11116,1,'company','fetch',1,0,0,0),(11117,2,'company','fetch',0,0,0,0),(11118,3,'company','fetch',0,0,0,0),(11119,1,'company','update',0,0,1,0),(11120,2,'company','update',0,0,0,0),(11121,3,'company','update',0,0,0,0),(11122,1,'company','users',1,0,0,0),(11123,2,'company','users',0,0,0,0),(11124,3,'company','users',0,0,0,0),(11125,1,'notification','list',1,0,0,0),(11126,2,'notification','list',0,0,0,0),(11127,3,'notification','list',1,0,0,0),(11128,1,'notification','companyToggle',0,1,0,0),(11129,2,'notification','companyToggle',0,0,0,0),(11130,3,'notification','companyToggle',0,0,0,0),(11131,1,'notification','employeeToggle',0,1,0,0),(11132,2,'notification','employeeToggle',0,0,0,0),(11133,3,'notification','employeeToggle',0,1,0,0),(11134,1,'notification','queueUp',0,1,0,0),(11135,2,'notification','queueUp',0,0,0,0),(11136,3,'notification','queueUp',0,0,0,0);
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

-- Dump completed on 2024-09-29 14:07:43
