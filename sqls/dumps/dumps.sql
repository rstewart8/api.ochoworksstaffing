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
) ENGINE=InnoDB AUTO_INCREMENT=5875 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (5761,1,'user','create',0,1,0,0),(5762,2,'user','create',0,0,0,0),(5763,3,'user','create',0,0,0,0),(5764,1,'user','fetch',1,0,0,0),(5765,2,'user','fetch',1,0,0,0),(5766,3,'user','fetch',1,0,0,0),(5767,1,'user','update',0,0,1,0),(5768,2,'user','update',0,0,0,0),(5769,3,'user','update',0,0,0,0),(5770,1,'client','list',1,0,0,0),(5771,2,'client','list',0,0,0,0),(5772,3,'client','list',0,0,0,0),(5773,1,'client','create',0,1,0,0),(5774,2,'client','create',0,0,0,0),(5775,3,'client','create',0,0,0,0),(5776,1,'client','fetch',1,0,0,0),(5777,2,'client','fetch',1,0,0,0),(5778,3,'client','fetch',0,0,0,0),(5779,1,'client','update',0,0,1,0),(5780,2,'client','update',0,0,0,0),(5781,3,'client','update',0,0,0,0),(5782,1,'client','users',1,0,0,0),(5783,2,'client','users',1,0,0,0),(5784,3,'client','users',0,0,0,0),(5785,1,'client','workdays',1,1,0,0),(5786,2,'client','workdays',1,0,0,0),(5787,3,'client','workdays',1,0,0,0),(5788,1,'utilities','states',1,0,0,0),(5789,2,'utilities','states',1,0,0,0),(5790,3,'utilities','states',1,0,0,0),(5791,1,'utilities','roles',1,0,0,0),(5792,2,'utilities','roles',1,0,0,0),(5793,3,'utilities','roles',0,0,0,0),(5794,1,'utilities','weekdays',1,0,0,0),(5795,2,'utilities','weekdays',1,0,0,0),(5796,3,'utilities','weekdays',1,0,0,0),(5797,1,'utilities','holidays',1,0,0,0),(5798,2,'utilities','holidays',1,0,0,0),(5799,3,'utilities','holidays',1,0,0,0),(5800,1,'utilities','workdays',1,0,0,0),(5801,2,'utilities','workdays',1,0,0,0),(5802,3,'utilities','workdays',1,0,0,0),(5803,1,'job','list',1,0,0,0),(5804,2,'job','list',1,0,0,0),(5805,3,'job','list',0,0,0,0),(5806,1,'job','create',0,1,0,0),(5807,2,'job','create',0,1,0,0),(5808,3,'job','create',0,0,0,0),(5809,1,'job','fetch',1,0,0,0),(5810,2,'job','fetch',1,0,0,0),(5811,3,'job','fetch',0,0,0,0),(5812,1,'job','update',0,0,1,0),(5813,2,'job','update',0,0,1,0),(5814,3,'job','update',0,0,0,0),(5815,1,'schedule','list',1,0,0,0),(5816,2,'schedule','list',1,0,0,0),(5817,3,'schedule','list',0,0,0,0),(5818,1,'schedule','create',0,1,0,0),(5819,2,'schedule','create',0,1,0,0),(5820,3,'schedule','create',0,0,0,0),(5821,1,'schedule','fetch',1,0,0,0),(5822,2,'schedule','fetch',1,0,0,0),(5823,3,'schedule','fetch',0,0,0,0),(5824,1,'schedule','pending',1,0,0,0),(5825,2,'schedule','pending',1,0,0,0),(5826,3,'schedule','pending',0,0,0,0),(5827,1,'schedule','status',1,0,0,0),(5828,2,'schedule','status',1,0,0,0),(5829,3,'schedule','status',0,0,0,0),(5830,1,'schedule','assignment',1,1,0,1),(5831,2,'schedule','assignment',1,1,0,1),(5832,3,'schedule','assignment',0,0,0,0),(5833,1,'schedule','assignments',1,0,0,0),(5834,2,'schedule','assignments',1,0,0,0),(5835,3,'schedule','assignments',0,0,0,0),(5836,1,'schedule','days',1,0,0,0),(5837,2,'schedule','days',1,0,0,0),(5838,3,'schedule','days',0,0,0,0),(5839,1,'schedule','update',1,0,1,0),(5840,2,'schedule','update',1,0,1,0),(5841,3,'schedule','update',0,0,0,0),(5842,1,'schedule','delete',0,0,0,1),(5843,2,'schedule','delete',0,0,0,1),(5844,3,'schedule','delete',0,0,0,0),(5845,1,'schedule','clientReport',1,0,0,0),(5846,2,'schedule','clientReport',1,0,0,0),(5847,3,'schedule','clientReport',0,0,0,0),(5848,1,'schedule','reportData',1,0,0,0),(5849,2,'schedule','reportData',1,0,0,0),(5850,3,'schedule','reportData',0,0,0,0),(5851,1,'skill','create',0,1,0,0),(5852,2,'skill','create',0,1,0,0),(5853,3,'skill','create',0,0,0,0),(5854,1,'skill','list',1,0,0,0),(5855,2,'skill','list',1,0,0,0),(5856,3,'skill','list',0,0,0,0),(5857,1,'skill','delete',0,0,1,0),(5858,2,'skill','delete',0,0,0,0),(5859,3,'skill','delete',0,0,0,0),(5860,1,'employee','list',1,0,0,0),(5861,2,'employee','list',1,0,0,0),(5862,3,'employee','list',0,0,0,0),(5863,1,'employee','create',0,1,0,0),(5864,2,'employee','create',0,1,0,0),(5865,3,'employee','create',0,0,0,0),(5866,1,'employee','schedule',1,0,0,0),(5867,2,'employee','schedule',1,0,0,0),(5868,3,'employee','schedule',0,0,0,0),(5869,1,'employee','available',1,0,0,0),(5870,2,'employee','available',1,0,0,0),(5871,3,'employee','available',0,0,0,0),(5872,1,'employee','assignments',1,0,0,0),(5873,2,'employee','assignments',1,0,0,0),(5874,3,'employee','assignments',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=5755 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (5641,1,'user','create',0,1,0,0),(5642,2,'user','create',0,1,0,0),(5643,3,'user','create',0,0,0,0),(5644,1,'user','fetch',1,0,0,0),(5645,2,'user','fetch',1,0,0,0),(5646,3,'user','fetch',1,0,0,0),(5647,1,'user','update',0,0,1,0),(5648,2,'user','update',0,0,1,0),(5649,3,'user','update',0,0,0,0),(5650,1,'client','list',1,0,0,0),(5651,2,'client','list',0,0,0,0),(5652,3,'client','list',0,0,0,0),(5653,1,'client','create',0,1,0,0),(5654,2,'client','create',0,0,0,0),(5655,3,'client','create',0,0,0,0),(5656,1,'client','fetch',1,0,0,0),(5657,2,'client','fetch',1,0,0,0),(5658,3,'client','fetch',0,0,0,0),(5659,1,'client','update',0,0,1,0),(5660,2,'client','update',0,0,1,0),(5661,3,'client','update',0,0,0,0),(5662,1,'client','users',1,0,0,0),(5663,2,'client','users',1,0,0,0),(5664,3,'client','users',0,0,0,0),(5665,1,'client','workdays',1,1,0,0),(5666,2,'client','workdays',1,0,0,0),(5667,3,'client','workdays',1,0,0,0),(5668,1,'utilities','states',1,0,0,0),(5669,2,'utilities','states',1,0,0,0),(5670,3,'utilities','states',1,0,0,0),(5671,1,'utilities','roles',1,0,0,0),(5672,2,'utilities','roles',1,0,0,0),(5673,3,'utilities','roles',0,0,0,0),(5674,1,'utilities','weekdays',1,0,0,0),(5675,2,'utilities','weekdays',1,0,0,0),(5676,3,'utilities','weekdays',1,0,0,0),(5677,1,'utilities','holidays',1,0,0,0),(5678,2,'utilities','holidays',1,0,0,0),(5679,3,'utilities','holidays',1,0,0,0),(5680,1,'utilities','workdays',1,0,0,0),(5681,2,'utilities','workdays',1,0,0,0),(5682,3,'utilities','workdays',1,0,0,0),(5683,1,'job','list',1,0,0,0),(5684,2,'job','list',1,0,0,0),(5685,3,'job','list',0,0,0,0),(5686,1,'job','create',0,1,0,0),(5687,2,'job','create',0,1,0,0),(5688,3,'job','create',0,0,0,0),(5689,1,'job','fetch',1,0,0,0),(5690,2,'job','fetch',1,0,0,0),(5691,3,'job','fetch',0,0,0,0),(5692,1,'job','update',0,0,1,0),(5693,2,'job','update',0,0,1,0),(5694,3,'job','update',0,0,0,0),(5695,1,'schedule','list',1,0,0,0),(5696,2,'schedule','list',1,0,0,0),(5697,3,'schedule','list',0,0,0,0),(5698,1,'schedule','create',0,1,0,0),(5699,2,'schedule','create',0,1,0,0),(5700,3,'schedule','create',0,0,0,0),(5701,1,'schedule','fetch',1,0,0,0),(5702,2,'schedule','fetch',1,0,0,0),(5703,3,'schedule','fetch',0,0,0,0),(5704,1,'schedule','pending',1,0,0,0),(5705,2,'schedule','pending',1,0,0,0),(5706,3,'schedule','pending',0,0,0,0),(5707,1,'schedule','status',1,0,0,0),(5708,2,'schedule','status',1,0,0,0),(5709,3,'schedule','status',0,0,0,0),(5710,1,'schedule','assignment',1,1,0,1),(5711,2,'schedule','assignment',1,0,0,0),(5712,3,'schedule','assignment',0,0,0,0),(5713,1,'schedule','assignments',1,0,0,0),(5714,2,'schedule','assignments',1,0,0,0),(5715,3,'schedule','assignments',1,0,0,0),(5716,1,'schedule','days',1,0,0,0),(5717,2,'schedule','days',0,0,0,0),(5718,3,'schedule','days',0,0,0,0),(5719,1,'schedule','update',1,0,1,0),(5720,2,'schedule','update',1,0,1,0),(5721,3,'schedule','update',0,0,0,0),(5722,1,'schedule','delete',0,0,0,1),(5723,2,'schedule','delete',0,0,0,0),(5724,3,'schedule','delete',0,0,0,0),(5725,1,'schedule','clientReport',1,0,0,0),(5726,2,'schedule','clientReport',1,0,0,0),(5727,3,'schedule','clientReport',0,0,0,0),(5728,1,'schedule','reportData',1,0,0,0),(5729,2,'schedule','reportData',1,0,0,0),(5730,3,'schedule','reportData',0,0,0,0),(5731,1,'skill','create',0,1,0,0),(5732,2,'skill','create',0,0,0,0),(5733,3,'skill','create',0,0,0,0),(5734,1,'skill','list',1,0,0,0),(5735,2,'skill','list',1,0,0,0),(5736,3,'skill','list',0,0,0,0),(5737,1,'skill','delete',0,0,1,0),(5738,2,'skill','delete',0,0,0,0),(5739,3,'skill','delete',0,0,0,0),(5740,1,'employee','list',1,0,0,0),(5741,2,'employee','list',0,0,0,0),(5742,3,'employee','list',0,0,0,0),(5743,1,'employee','create',0,1,0,0),(5744,2,'employee','create',0,0,0,0),(5745,3,'employee','create',0,0,0,0),(5746,1,'employee','schedule',1,0,0,0),(5747,2,'employee','schedule',0,0,0,0),(5748,3,'employee','schedule',0,0,0,0),(5749,1,'employee','available',1,0,0,0),(5750,2,'employee','available',0,0,0,0),(5751,3,'employee','available',0,0,0,0),(5752,1,'employee','assignments',1,0,0,0),(5753,2,'employee','assignments',1,0,0,0),(5754,3,'employee','assignments',1,0,0,0);
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

-- Dump completed on 2024-04-08 16:31:36
