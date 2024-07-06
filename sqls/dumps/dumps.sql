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
) ENGINE=InnoDB AUTO_INCREMENT=6343 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (6223,1,'user','create',0,1,0,0),(6224,2,'user','create',0,0,0,0),(6225,3,'user','create',0,0,0,0),(6226,1,'user','fetch',1,0,0,0),(6227,2,'user','fetch',1,0,0,0),(6228,3,'user','fetch',1,0,0,0),(6229,1,'user','update',0,0,1,0),(6230,2,'user','update',0,0,0,0),(6231,3,'user','update',0,0,0,0),(6232,1,'client','list',1,0,0,0),(6233,2,'client','list',0,0,0,0),(6234,3,'client','list',0,0,0,0),(6235,1,'client','create',0,1,0,0),(6236,2,'client','create',0,0,0,0),(6237,3,'client','create',0,0,0,0),(6238,1,'client','fetch',1,0,0,0),(6239,2,'client','fetch',1,0,0,0),(6240,3,'client','fetch',0,0,0,0),(6241,1,'client','update',0,0,1,0),(6242,2,'client','update',0,0,0,0),(6243,3,'client','update',0,0,0,0),(6244,1,'client','users',1,0,0,0),(6245,2,'client','users',1,0,0,0),(6246,3,'client','users',0,0,0,0),(6247,1,'client','workdays',1,1,0,0),(6248,2,'client','workdays',1,0,0,0),(6249,3,'client','workdays',1,0,0,0),(6250,1,'utilities','states',1,0,0,0),(6251,2,'utilities','states',1,0,0,0),(6252,3,'utilities','states',1,0,0,0),(6253,1,'utilities','roles',1,0,0,0),(6254,2,'utilities','roles',1,0,0,0),(6255,3,'utilities','roles',0,0,0,0),(6256,1,'utilities','weekdays',1,0,0,0),(6257,2,'utilities','weekdays',1,0,0,0),(6258,3,'utilities','weekdays',1,0,0,0),(6259,1,'utilities','holidays',1,0,0,0),(6260,2,'utilities','holidays',1,0,0,0),(6261,3,'utilities','holidays',1,0,0,0),(6262,1,'utilities','workdays',1,0,0,0),(6263,2,'utilities','workdays',1,0,0,0),(6264,3,'utilities','workdays',1,0,0,0),(6265,1,'utilities','scheduleTimes',1,0,0,0),(6266,2,'utilities','scheduleTimes',1,0,0,0),(6267,3,'utilities','scheduleTimes',1,0,0,0),(6268,1,'job','list',1,0,0,0),(6269,2,'job','list',1,0,0,0),(6270,3,'job','list',0,0,0,0),(6271,1,'job','create',0,1,0,0),(6272,2,'job','create',0,1,0,0),(6273,3,'job','create',0,0,0,0),(6274,1,'job','fetch',1,0,0,0),(6275,2,'job','fetch',1,0,0,0),(6276,3,'job','fetch',0,0,0,0),(6277,1,'job','update',0,0,1,0),(6278,2,'job','update',0,0,1,0),(6279,3,'job','update',0,0,0,0),(6280,1,'schedule','list',1,0,0,0),(6281,2,'schedule','list',1,0,0,0),(6282,3,'schedule','list',0,0,0,0),(6283,1,'schedule','create',0,1,0,0),(6284,2,'schedule','create',0,1,0,0),(6285,3,'schedule','create',0,0,0,0),(6286,1,'schedule','fetch',1,0,0,0),(6287,2,'schedule','fetch',1,0,0,0),(6288,3,'schedule','fetch',0,0,0,0),(6289,1,'schedule','pending',1,0,0,0),(6290,2,'schedule','pending',1,0,0,0),(6291,3,'schedule','pending',0,0,0,0),(6292,1,'schedule','status',1,0,0,0),(6293,2,'schedule','status',1,0,0,0),(6294,3,'schedule','status',0,0,0,0),(6295,1,'schedule','assignment',1,1,0,1),(6296,2,'schedule','assignment',1,1,0,1),(6297,3,'schedule','assignment',0,0,0,0),(6298,1,'schedule','assignments',1,0,0,0),(6299,2,'schedule','assignments',1,0,0,0),(6300,3,'schedule','assignments',0,0,0,0),(6301,1,'schedule','days',1,0,0,0),(6302,2,'schedule','days',1,0,0,0),(6303,3,'schedule','days',0,0,0,0),(6304,1,'schedule','update',1,0,1,0),(6305,2,'schedule','update',1,0,1,0),(6306,3,'schedule','update',0,0,0,0),(6307,1,'schedule','delete',0,0,0,1),(6308,2,'schedule','delete',0,0,0,1),(6309,3,'schedule','delete',0,0,0,0),(6310,1,'schedule','clientReportByDay',1,0,0,0),(6311,2,'schedule','clientReportByDay',1,0,0,0),(6312,3,'schedule','clientReportByDay',0,0,0,0),(6313,1,'schedule','reportData',1,0,0,0),(6314,2,'schedule','reportData',1,0,0,0),(6315,3,'schedule','reportData',0,0,0,0),(6316,1,'schedule','scheduleStatusByRange',1,0,0,0),(6317,2,'schedule','scheduleStatusByRange',1,0,0,0),(6318,3,'schedule','scheduleStatusByRange',0,0,0,0),(6319,1,'skill','create',0,1,0,0),(6320,2,'skill','create',0,1,0,0),(6321,3,'skill','create',0,0,0,0),(6322,1,'skill','list',1,0,0,0),(6323,2,'skill','list',1,0,0,0),(6324,3,'skill','list',0,0,0,0),(6325,1,'skill','delete',0,0,1,0),(6326,2,'skill','delete',0,0,0,0),(6327,3,'skill','delete',0,0,0,0),(6328,1,'employee','list',1,0,0,0),(6329,2,'employee','list',1,0,0,0),(6330,3,'employee','list',0,0,0,0),(6331,1,'employee','create',0,1,0,0),(6332,2,'employee','create',0,1,0,0),(6333,3,'employee','create',0,0,0,0),(6334,1,'employee','schedule',1,0,0,0),(6335,2,'employee','schedule',1,0,0,0),(6336,3,'employee','schedule',0,0,0,0),(6337,1,'employee','available',1,0,0,0),(6338,2,'employee','available',1,0,0,0),(6339,3,'employee','available',0,0,0,0),(6340,1,'employee','assignments',1,0,0,0),(6341,2,'employee','assignments',1,0,0,0),(6342,3,'employee','assignments',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=6223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (6103,1,'user','create',0,1,0,0),(6104,2,'user','create',0,1,0,0),(6105,3,'user','create',0,0,0,0),(6106,1,'user','fetch',1,0,0,0),(6107,2,'user','fetch',1,0,0,0),(6108,3,'user','fetch',1,0,0,0),(6109,1,'user','update',0,0,1,0),(6110,2,'user','update',0,0,1,0),(6111,3,'user','update',0,0,0,0),(6112,1,'client','list',1,0,0,0),(6113,2,'client','list',0,0,0,0),(6114,3,'client','list',0,0,0,0),(6115,1,'client','create',0,1,0,0),(6116,2,'client','create',0,0,0,0),(6117,3,'client','create',0,0,0,0),(6118,1,'client','fetch',1,0,0,0),(6119,2,'client','fetch',1,0,0,0),(6120,3,'client','fetch',0,0,0,0),(6121,1,'client','update',0,0,1,0),(6122,2,'client','update',0,0,1,0),(6123,3,'client','update',0,0,0,0),(6124,1,'client','users',1,0,0,0),(6125,2,'client','users',1,0,0,0),(6126,3,'client','users',0,0,0,0),(6127,1,'client','workdays',1,1,0,0),(6128,2,'client','workdays',1,0,0,0),(6129,3,'client','workdays',1,0,0,0),(6130,1,'utilities','states',1,0,0,0),(6131,2,'utilities','states',1,0,0,0),(6132,3,'utilities','states',1,0,0,0),(6133,1,'utilities','roles',1,0,0,0),(6134,2,'utilities','roles',1,0,0,0),(6135,3,'utilities','roles',0,0,0,0),(6136,1,'utilities','weekdays',1,0,0,0),(6137,2,'utilities','weekdays',1,0,0,0),(6138,3,'utilities','weekdays',1,0,0,0),(6139,1,'utilities','holidays',1,0,0,0),(6140,2,'utilities','holidays',1,0,0,0),(6141,3,'utilities','holidays',1,0,0,0),(6142,1,'utilities','workdays',1,0,0,0),(6143,2,'utilities','workdays',1,0,0,0),(6144,3,'utilities','workdays',1,0,0,0),(6145,1,'utilities','scheduleTimes',1,0,0,0),(6146,2,'utilities','scheduleTimes',1,0,0,0),(6147,3,'utilities','scheduleTimes',1,0,0,0),(6148,1,'job','list',1,0,0,0),(6149,2,'job','list',1,0,0,0),(6150,3,'job','list',0,0,0,0),(6151,1,'job','create',0,1,0,0),(6152,2,'job','create',0,1,0,0),(6153,3,'job','create',0,0,0,0),(6154,1,'job','fetch',1,0,0,0),(6155,2,'job','fetch',1,0,0,0),(6156,3,'job','fetch',0,0,0,0),(6157,1,'job','update',0,0,1,0),(6158,2,'job','update',0,0,1,0),(6159,3,'job','update',0,0,0,0),(6160,1,'schedule','list',1,0,0,0),(6161,2,'schedule','list',1,0,0,0),(6162,3,'schedule','list',0,0,0,0),(6163,1,'schedule','create',0,1,0,0),(6164,2,'schedule','create',0,1,0,0),(6165,3,'schedule','create',0,0,0,0),(6166,1,'schedule','fetch',1,0,0,0),(6167,2,'schedule','fetch',1,0,0,0),(6168,3,'schedule','fetch',0,0,0,0),(6169,1,'schedule','pending',1,0,0,0),(6170,2,'schedule','pending',1,0,0,0),(6171,3,'schedule','pending',0,0,0,0),(6172,1,'schedule','status',1,0,0,0),(6173,2,'schedule','status',1,0,0,0),(6174,3,'schedule','status',0,0,0,0),(6175,1,'schedule','assignment',1,1,0,1),(6176,2,'schedule','assignment',1,0,0,0),(6177,3,'schedule','assignment',0,0,0,0),(6178,1,'schedule','assignments',1,0,0,0),(6179,2,'schedule','assignments',1,0,0,0),(6180,3,'schedule','assignments',1,0,0,0),(6181,1,'schedule','days',1,0,0,0),(6182,2,'schedule','days',0,0,0,0),(6183,3,'schedule','days',0,0,0,0),(6184,1,'schedule','update',1,0,1,0),(6185,2,'schedule','update',1,0,1,0),(6186,3,'schedule','update',0,0,0,0),(6187,1,'schedule','delete',0,0,0,1),(6188,2,'schedule','delete',0,0,0,0),(6189,3,'schedule','delete',0,0,0,0),(6190,1,'schedule','clientReportByDay',1,0,0,0),(6191,2,'schedule','clientReportByDay',1,0,0,0),(6192,3,'schedule','clientReportByDay',0,0,0,0),(6193,1,'schedule','reportData',1,0,0,0),(6194,2,'schedule','reportData',1,0,0,0),(6195,3,'schedule','reportData',0,0,0,0),(6196,1,'schedule','scheduleStatusByRange',1,0,0,0),(6197,2,'schedule','scheduleStatusByRange',1,0,0,0),(6198,3,'schedule','scheduleStatusByRange',0,0,0,0),(6199,1,'skill','create',0,1,0,0),(6200,2,'skill','create',0,0,0,0),(6201,3,'skill','create',0,0,0,0),(6202,1,'skill','list',1,0,0,0),(6203,2,'skill','list',1,0,0,0),(6204,3,'skill','list',0,0,0,0),(6205,1,'skill','delete',0,0,1,0),(6206,2,'skill','delete',0,0,0,0),(6207,3,'skill','delete',0,0,0,0),(6208,1,'employee','list',1,0,0,0),(6209,2,'employee','list',0,0,0,0),(6210,3,'employee','list',0,0,0,0),(6211,1,'employee','create',0,1,0,0),(6212,2,'employee','create',0,0,0,0),(6213,3,'employee','create',0,0,0,0),(6214,1,'employee','schedule',1,0,0,0),(6215,2,'employee','schedule',0,0,0,0),(6216,3,'employee','schedule',0,0,0,0),(6217,1,'employee','available',1,0,0,0),(6218,2,'employee','available',0,0,0,0),(6219,3,'employee','available',0,0,0,0),(6220,1,'employee','assignments',1,0,0,0),(6221,2,'employee','assignments',1,0,0,0),(6222,3,'employee','assignments',1,0,0,0);
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

-- Dump completed on 2024-05-04 22:57:31
