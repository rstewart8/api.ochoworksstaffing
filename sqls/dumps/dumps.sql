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
) ENGINE=InnoDB AUTO_INCREMENT=5317 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (5209,1,'user','create',0,1,0,0),(5210,2,'user','create',0,0,0,0),(5211,3,'user','create',0,0,0,0),(5212,1,'user','fetch',1,0,0,0),(5213,2,'user','fetch',1,0,0,0),(5214,3,'user','fetch',1,0,0,0),(5215,1,'user','update',0,0,1,0),(5216,2,'user','update',0,0,0,0),(5217,3,'user','update',0,0,0,0),(5218,1,'client','list',1,0,0,0),(5219,2,'client','list',0,0,0,0),(5220,3,'client','list',0,0,0,0),(5221,1,'client','create',0,1,0,0),(5222,2,'client','create',0,0,0,0),(5223,3,'client','create',0,0,0,0),(5224,1,'client','fetch',1,0,0,0),(5225,2,'client','fetch',1,0,0,0),(5226,3,'client','fetch',0,0,0,0),(5227,1,'client','update',0,0,1,0),(5228,2,'client','update',0,0,0,0),(5229,3,'client','update',0,0,0,0),(5230,1,'client','users',1,0,0,0),(5231,2,'client','users',1,0,0,0),(5232,3,'client','users',0,0,0,0),(5233,1,'client','workdays',1,1,0,0),(5234,2,'client','workdays',1,0,0,0),(5235,3,'client','workdays',1,0,0,0),(5236,1,'utilities','states',1,0,0,0),(5237,2,'utilities','states',1,0,0,0),(5238,3,'utilities','states',1,0,0,0),(5239,1,'utilities','roles',1,0,0,0),(5240,2,'utilities','roles',1,0,0,0),(5241,3,'utilities','roles',0,0,0,0),(5242,1,'utilities','weekdays',1,0,0,0),(5243,2,'utilities','weekdays',1,0,0,0),(5244,3,'utilities','weekdays',1,0,0,0),(5245,1,'utilities','holidays',1,0,0,0),(5246,2,'utilities','holidays',1,0,0,0),(5247,3,'utilities','holidays',1,0,0,0),(5248,1,'utilities','workdays',1,0,0,0),(5249,2,'utilities','workdays',1,0,0,0),(5250,3,'utilities','workdays',1,0,0,0),(5251,1,'job','list',1,0,0,0),(5252,2,'job','list',1,0,0,0),(5253,3,'job','list',0,0,0,0),(5254,1,'job','create',0,1,0,0),(5255,2,'job','create',0,1,0,0),(5256,3,'job','create',0,0,0,0),(5257,1,'job','fetch',1,0,0,0),(5258,2,'job','fetch',1,0,0,0),(5259,3,'job','fetch',0,0,0,0),(5260,1,'job','update',0,0,1,0),(5261,2,'job','update',0,0,1,0),(5262,3,'job','update',0,0,0,0),(5263,1,'schedule','list',1,0,0,0),(5264,2,'schedule','list',1,0,0,0),(5265,3,'schedule','list',0,0,0,0),(5266,1,'schedule','create',0,1,0,0),(5267,2,'schedule','create',0,1,0,0),(5268,3,'schedule','create',0,0,0,0),(5269,1,'schedule','fetch',1,0,0,0),(5270,2,'schedule','fetch',1,0,0,0),(5271,3,'schedule','fetch',0,0,0,0),(5272,1,'schedule','pending',1,0,0,0),(5273,2,'schedule','pending',1,0,0,0),(5274,3,'schedule','pending',0,0,0,0),(5275,1,'schedule','status',1,0,0,0),(5276,2,'schedule','status',1,0,0,0),(5277,3,'schedule','status',0,0,0,0),(5278,1,'schedule','assignment',1,1,0,1),(5279,2,'schedule','assignment',1,1,0,1),(5280,3,'schedule','assignment',0,0,0,0),(5281,1,'schedule','assignments',1,0,0,0),(5282,2,'schedule','assignments',1,0,0,0),(5283,3,'schedule','assignments',0,0,0,0),(5284,1,'schedule','days',1,0,0,0),(5285,2,'schedule','days',1,0,0,0),(5286,3,'schedule','days',0,0,0,0),(5287,1,'schedule','update',1,0,1,0),(5288,2,'schedule','update',1,0,1,0),(5289,3,'schedule','update',0,0,0,0),(5290,1,'schedule','delete',0,0,0,1),(5291,2,'schedule','delete',0,0,0,1),(5292,3,'schedule','delete',0,0,0,0),(5293,1,'skill','create',0,1,0,0),(5294,2,'skill','create',0,1,0,0),(5295,3,'skill','create',0,0,0,0),(5296,1,'skill','list',1,0,0,0),(5297,2,'skill','list',1,0,0,0),(5298,3,'skill','list',0,0,0,0),(5299,1,'skill','delete',0,0,1,0),(5300,2,'skill','delete',0,0,0,0),(5301,3,'skill','delete',0,0,0,0),(5302,1,'employee','list',1,0,0,0),(5303,2,'employee','list',1,0,0,0),(5304,3,'employee','list',0,0,0,0),(5305,1,'employee','create',0,1,0,0),(5306,2,'employee','create',0,1,0,0),(5307,3,'employee','create',0,0,0,0),(5308,1,'employee','schedule',1,0,0,0),(5309,2,'employee','schedule',1,0,0,0),(5310,3,'employee','schedule',0,0,0,0),(5311,1,'employee','available',1,0,0,0),(5312,2,'employee','available',1,0,0,0),(5313,3,'employee','available',0,0,0,0),(5314,1,'employee','assignments',1,0,0,0),(5315,2,'employee','assignments',1,0,0,0),(5316,3,'employee','assignments',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=5197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (5089,1,'user','create',0,1,0,0),(5090,2,'user','create',0,1,0,0),(5091,3,'user','create',0,0,0,0),(5092,1,'user','fetch',1,0,0,0),(5093,2,'user','fetch',1,0,0,0),(5094,3,'user','fetch',1,0,0,0),(5095,1,'user','update',0,0,1,0),(5096,2,'user','update',0,0,1,0),(5097,3,'user','update',0,0,0,0),(5098,1,'client','list',1,0,0,0),(5099,2,'client','list',0,0,0,0),(5100,3,'client','list',0,0,0,0),(5101,1,'client','create',0,1,0,0),(5102,2,'client','create',0,0,0,0),(5103,3,'client','create',0,0,0,0),(5104,1,'client','fetch',1,0,0,0),(5105,2,'client','fetch',1,0,0,0),(5106,3,'client','fetch',0,0,0,0),(5107,1,'client','update',0,0,1,0),(5108,2,'client','update',0,0,1,0),(5109,3,'client','update',0,0,0,0),(5110,1,'client','users',1,0,0,0),(5111,2,'client','users',1,0,0,0),(5112,3,'client','users',0,0,0,0),(5113,1,'client','workdays',1,1,0,0),(5114,2,'client','workdays',1,0,0,0),(5115,3,'client','workdays',1,0,0,0),(5116,1,'utilities','states',1,0,0,0),(5117,2,'utilities','states',1,0,0,0),(5118,3,'utilities','states',1,0,0,0),(5119,1,'utilities','roles',1,0,0,0),(5120,2,'utilities','roles',1,0,0,0),(5121,3,'utilities','roles',0,0,0,0),(5122,1,'utilities','weekdays',1,0,0,0),(5123,2,'utilities','weekdays',1,0,0,0),(5124,3,'utilities','weekdays',1,0,0,0),(5125,1,'utilities','holidays',1,0,0,0),(5126,2,'utilities','holidays',1,0,0,0),(5127,3,'utilities','holidays',1,0,0,0),(5128,1,'utilities','workdays',1,0,0,0),(5129,2,'utilities','workdays',1,0,0,0),(5130,3,'utilities','workdays',1,0,0,0),(5131,1,'job','list',1,0,0,0),(5132,2,'job','list',1,0,0,0),(5133,3,'job','list',0,0,0,0),(5134,1,'job','create',0,1,0,0),(5135,2,'job','create',0,1,0,0),(5136,3,'job','create',0,0,0,0),(5137,1,'job','fetch',1,0,0,0),(5138,2,'job','fetch',1,0,0,0),(5139,3,'job','fetch',0,0,0,0),(5140,1,'job','update',0,0,1,0),(5141,2,'job','update',0,0,1,0),(5142,3,'job','update',0,0,0,0),(5143,1,'schedule','list',1,0,0,0),(5144,2,'schedule','list',1,0,0,0),(5145,3,'schedule','list',0,0,0,0),(5146,1,'schedule','create',0,1,0,0),(5147,2,'schedule','create',0,1,0,0),(5148,3,'schedule','create',0,0,0,0),(5149,1,'schedule','fetch',1,0,0,0),(5150,2,'schedule','fetch',1,0,0,0),(5151,3,'schedule','fetch',0,0,0,0),(5152,1,'schedule','pending',1,0,0,0),(5153,2,'schedule','pending',1,0,0,0),(5154,3,'schedule','pending',0,0,0,0),(5155,1,'schedule','status',1,0,0,0),(5156,2,'schedule','status',1,0,0,0),(5157,3,'schedule','status',0,0,0,0),(5158,1,'schedule','assignment',1,1,0,1),(5159,2,'schedule','assignment',1,0,0,0),(5160,3,'schedule','assignment',0,0,0,0),(5161,1,'schedule','assignments',1,0,0,0),(5162,2,'schedule','assignments',1,0,0,0),(5163,3,'schedule','assignments',1,0,0,0),(5164,1,'schedule','days',1,0,0,0),(5165,2,'schedule','days',0,0,0,0),(5166,3,'schedule','days',0,0,0,0),(5167,1,'schedule','update',1,0,1,0),(5168,2,'schedule','update',1,0,1,0),(5169,3,'schedule','update',0,0,0,0),(5170,1,'schedule','delete',0,0,0,1),(5171,2,'schedule','delete',0,0,0,0),(5172,3,'schedule','delete',0,0,0,0),(5173,1,'skill','create',0,1,0,0),(5174,2,'skill','create',0,0,0,0),(5175,3,'skill','create',0,0,0,0),(5176,1,'skill','list',1,0,0,0),(5177,2,'skill','list',1,0,0,0),(5178,3,'skill','list',0,0,0,0),(5179,1,'skill','delete',0,0,1,0),(5180,2,'skill','delete',0,0,0,0),(5181,3,'skill','delete',0,0,0,0),(5182,1,'employee','list',1,0,0,0),(5183,2,'employee','list',0,0,0,0),(5184,3,'employee','list',0,0,0,0),(5185,1,'employee','create',0,1,0,0),(5186,2,'employee','create',0,0,0,0),(5187,3,'employee','create',0,0,0,0),(5188,1,'employee','schedule',1,0,0,0),(5189,2,'employee','schedule',0,0,0,0),(5190,3,'employee','schedule',0,0,0,0),(5191,1,'employee','available',1,0,0,0),(5192,2,'employee','available',0,0,0,0),(5193,3,'employee','available',0,0,0,0),(5194,1,'employee','assignments',1,0,0,0),(5195,2,'employee','assignments',1,0,0,0),(5196,3,'employee','assignments',1,0,0,0);
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

-- Dump completed on 2024-04-07  1:26:36
