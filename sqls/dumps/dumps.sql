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
) ENGINE=InnoDB AUTO_INCREMENT=9736 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (9577,1,'user','create',0,1,0,0),(9578,2,'user','create',0,0,0,0),(9579,3,'user','create',0,0,0,0),(9580,1,'user','fetch',1,0,0,0),(9581,2,'user','fetch',1,0,0,0),(9582,3,'user','fetch',1,0,0,0),(9583,1,'user','update',0,0,1,0),(9584,2,'user','update',0,0,0,0),(9585,3,'user','update',0,0,0,0),(9586,1,'user','profile',1,0,1,0),(9587,2,'user','profile',1,0,1,0),(9588,3,'user','profile',1,0,1,0),(9589,1,'user','photo',0,1,0,0),(9590,2,'user','photo',0,1,0,0),(9591,3,'user','photo',0,1,0,0),(9592,1,'client','list',1,0,0,0),(9593,2,'client','list',0,0,0,0),(9594,3,'client','list',0,0,0,0),(9595,1,'client','create',0,1,0,0),(9596,2,'client','create',0,0,0,0),(9597,3,'client','create',0,0,0,0),(9598,1,'client','fetch',1,0,0,0),(9599,2,'client','fetch',1,0,0,0),(9600,3,'client','fetch',0,0,0,0),(9601,1,'client','update',0,0,1,0),(9602,2,'client','update',0,0,0,0),(9603,3,'client','update',0,0,0,0),(9604,1,'client','users',1,0,0,0),(9605,2,'client','users',1,0,0,0),(9606,3,'client','users',0,0,0,0),(9607,1,'client','workdays',1,1,0,0),(9608,2,'client','workdays',1,0,0,0),(9609,3,'client','workdays',1,0,0,0),(9610,1,'utilities','states',1,0,0,0),(9611,2,'utilities','states',1,0,0,0),(9612,3,'utilities','states',1,0,0,0),(9613,1,'utilities','roles',1,0,0,0),(9614,2,'utilities','roles',1,0,0,0),(9615,3,'utilities','roles',0,0,0,0),(9616,1,'utilities','weekdays',1,0,0,0),(9617,2,'utilities','weekdays',1,0,0,0),(9618,3,'utilities','weekdays',1,0,0,0),(9619,1,'utilities','holidays',1,0,0,0),(9620,2,'utilities','holidays',1,0,0,0),(9621,3,'utilities','holidays',1,0,0,0),(9622,1,'utilities','workdays',1,0,0,0),(9623,2,'utilities','workdays',1,0,0,0),(9624,3,'utilities','workdays',1,0,0,0),(9625,1,'utilities','scheduleTimes',1,0,0,0),(9626,2,'utilities','scheduleTimes',1,0,0,0),(9627,3,'utilities','scheduleTimes',1,0,0,0),(9628,1,'job','list',1,0,0,0),(9629,2,'job','list',1,0,0,0),(9630,3,'job','list',0,0,0,0),(9631,1,'job','create',0,1,0,0),(9632,2,'job','create',0,1,0,0),(9633,3,'job','create',0,0,0,0),(9634,1,'job','fetch',1,0,0,0),(9635,2,'job','fetch',1,0,0,0),(9636,3,'job','fetch',0,0,0,0),(9637,1,'job','update',0,0,1,0),(9638,2,'job','update',0,0,1,0),(9639,3,'job','update',0,0,0,0),(9640,1,'schedule','list',1,0,0,0),(9641,2,'schedule','list',1,0,0,0),(9642,3,'schedule','list',0,0,0,0),(9643,1,'schedule','create',0,1,0,0),(9644,2,'schedule','create',0,1,0,0),(9645,3,'schedule','create',0,0,0,0),(9646,1,'schedule','fetch',1,0,0,0),(9647,2,'schedule','fetch',1,0,0,0),(9648,3,'schedule','fetch',0,0,0,0),(9649,1,'schedule','pending',1,0,0,0),(9650,2,'schedule','pending',1,0,0,0),(9651,3,'schedule','pending',0,0,0,0),(9652,1,'schedule','status',1,0,0,0),(9653,2,'schedule','status',1,0,0,0),(9654,3,'schedule','status',0,0,0,0),(9655,1,'schedule','assignment',1,1,0,1),(9656,2,'schedule','assignment',1,1,0,1),(9657,3,'schedule','assignment',0,0,0,0),(9658,1,'schedule','assignments',1,0,0,0),(9659,2,'schedule','assignments',1,0,0,0),(9660,3,'schedule','assignments',0,0,0,0),(9661,1,'schedule','days',1,0,0,0),(9662,2,'schedule','days',1,0,0,0),(9663,3,'schedule','days',0,0,0,0),(9664,1,'schedule','update',1,0,1,0),(9665,2,'schedule','update',1,0,1,0),(9666,3,'schedule','update',0,0,0,0),(9667,1,'schedule','delete',0,0,0,1),(9668,2,'schedule','delete',0,0,0,1),(9669,3,'schedule','delete',0,0,0,0),(9670,1,'schedule','clientReportByDay',1,0,0,0),(9671,2,'schedule','clientReportByDay',1,0,0,0),(9672,3,'schedule','clientReportByDay',0,0,0,0),(9673,1,'schedule','reportData',1,0,0,0),(9674,2,'schedule','reportData',1,0,0,0),(9675,3,'schedule','reportData',0,0,0,0),(9676,1,'schedule','scheduleStatusByRange',1,0,0,0),(9677,2,'schedule','scheduleStatusByRange',1,0,0,0),(9678,3,'schedule','scheduleStatusByRange',0,0,0,0),(9679,1,'schedule','notes',1,0,1,0),(9680,2,'schedule','notes',1,0,1,0),(9681,3,'schedule','notes',1,0,1,0),(9682,1,'schedule','jobReportByDay',1,0,0,0),(9683,2,'schedule','jobReportByDay',1,0,0,0),(9684,3,'schedule','jobReportByDay',0,0,0,0),(9685,1,'skill','create',0,1,0,0),(9686,2,'skill','create',0,1,0,0),(9687,3,'skill','create',0,0,0,0),(9688,1,'skill','list',1,0,0,0),(9689,2,'skill','list',1,0,0,0),(9690,3,'skill','list',0,0,0,0),(9691,1,'skill','delete',0,0,1,0),(9692,2,'skill','delete',0,0,0,0),(9693,3,'skill','delete',0,0,0,0),(9694,1,'employee','list',1,0,0,0),(9695,2,'employee','list',1,0,0,0),(9696,3,'employee','list',0,0,0,0),(9697,1,'employee','create',0,1,0,0),(9698,2,'employee','create',0,1,0,0),(9699,3,'employee','create',0,0,0,0),(9700,1,'employee','schedule',1,0,0,0),(9701,2,'employee','schedule',1,0,0,0),(9702,3,'employee','schedule',0,0,0,0),(9703,1,'employee','available',1,0,0,0),(9704,2,'employee','available',1,0,0,0),(9705,3,'employee','available',0,0,0,0),(9706,1,'employee','assignments',1,0,0,0),(9707,2,'employee','assignments',1,0,0,0),(9708,3,'employee','assignments',0,0,0,0),(9709,1,'employee','fetch',1,0,0,0),(9710,2,'employee','fetch',1,0,0,0),(9711,3,'employee','fetch',1,0,0,0),(9712,1,'employee','update',0,0,1,0),(9713,2,'employee','update',0,0,1,0),(9714,3,'employee','update',0,0,0,0),(9715,1,'employee','workDays',1,1,0,0),(9716,2,'employee','workDays',1,1,0,0),(9717,3,'employee','workDays',1,0,0,0),(9718,1,'employee','skills',1,1,0,0),(9719,2,'employee','skills',1,1,0,0),(9720,3,'employee','skills',1,0,0,0),(9721,1,'employee','assignmentDetails',1,0,0,0),(9722,2,'employee','assignmentDetails',1,0,0,0),(9723,3,'employee','assignmentDetails',1,0,0,0),(9724,1,'employee','forClientByDays',1,0,0,0),(9725,2,'employee','forClientByDays',1,0,0,0),(9726,3,'employee','forClientByDays',0,0,0,0),(9727,1,'company','fetch',1,0,0,0),(9728,2,'company','fetch',0,0,0,0),(9729,3,'company','fetch',0,0,0,0),(9730,1,'company','update',0,0,1,0),(9731,2,'company','update',0,0,0,0),(9732,3,'company','update',0,0,0,0),(9733,1,'company','users',1,0,0,0),(9734,2,'company','users',0,0,0,0),(9735,3,'company','users',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9616 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (9457,1,'user','create',0,1,0,0),(9458,2,'user','create',0,1,0,0),(9459,3,'user','create',0,0,0,0),(9460,1,'user','fetch',1,0,0,0),(9461,2,'user','fetch',1,0,0,0),(9462,3,'user','fetch',1,0,0,0),(9463,1,'user','update',0,0,1,0),(9464,2,'user','update',0,0,1,0),(9465,3,'user','update',0,0,0,0),(9466,1,'user','profile',1,0,1,0),(9467,2,'user','profile',1,0,1,0),(9468,3,'user','profile',1,0,1,0),(9469,1,'user','photo',0,1,0,0),(9470,2,'user','photo',0,1,0,0),(9471,3,'user','photo',0,1,0,0),(9472,1,'client','list',1,0,0,0),(9473,2,'client','list',0,0,0,0),(9474,3,'client','list',0,0,0,0),(9475,1,'client','create',0,1,0,0),(9476,2,'client','create',0,0,0,0),(9477,3,'client','create',0,0,0,0),(9478,1,'client','fetch',1,0,0,0),(9479,2,'client','fetch',1,0,0,0),(9480,3,'client','fetch',0,0,0,0),(9481,1,'client','update',0,0,1,0),(9482,2,'client','update',0,0,1,0),(9483,3,'client','update',0,0,0,0),(9484,1,'client','users',1,0,0,0),(9485,2,'client','users',1,0,0,0),(9486,3,'client','users',0,0,0,0),(9487,1,'client','workdays',1,1,0,0),(9488,2,'client','workdays',1,0,0,0),(9489,3,'client','workdays',1,0,0,0),(9490,1,'utilities','states',1,0,0,0),(9491,2,'utilities','states',1,0,0,0),(9492,3,'utilities','states',1,0,0,0),(9493,1,'utilities','roles',1,0,0,0),(9494,2,'utilities','roles',1,0,0,0),(9495,3,'utilities','roles',0,0,0,0),(9496,1,'utilities','weekdays',1,0,0,0),(9497,2,'utilities','weekdays',1,0,0,0),(9498,3,'utilities','weekdays',1,0,0,0),(9499,1,'utilities','holidays',1,0,0,0),(9500,2,'utilities','holidays',1,0,0,0),(9501,3,'utilities','holidays',1,0,0,0),(9502,1,'utilities','workdays',1,0,0,0),(9503,2,'utilities','workdays',1,0,0,0),(9504,3,'utilities','workdays',1,0,0,0),(9505,1,'utilities','scheduleTimes',1,0,0,0),(9506,2,'utilities','scheduleTimes',1,0,0,0),(9507,3,'utilities','scheduleTimes',1,0,0,0),(9508,1,'job','list',1,0,0,0),(9509,2,'job','list',1,0,0,0),(9510,3,'job','list',0,0,0,0),(9511,1,'job','create',0,1,0,0),(9512,2,'job','create',0,1,0,0),(9513,3,'job','create',0,0,0,0),(9514,1,'job','fetch',1,0,0,0),(9515,2,'job','fetch',1,0,0,0),(9516,3,'job','fetch',0,0,0,0),(9517,1,'job','update',0,0,1,0),(9518,2,'job','update',0,0,1,0),(9519,3,'job','update',0,0,0,0),(9520,1,'schedule','list',1,0,0,0),(9521,2,'schedule','list',1,0,0,0),(9522,3,'schedule','list',0,0,0,0),(9523,1,'schedule','create',0,1,0,0),(9524,2,'schedule','create',0,1,0,0),(9525,3,'schedule','create',0,0,0,0),(9526,1,'schedule','fetch',1,0,0,0),(9527,2,'schedule','fetch',1,0,0,0),(9528,3,'schedule','fetch',0,0,0,0),(9529,1,'schedule','pending',1,0,0,0),(9530,2,'schedule','pending',1,0,0,0),(9531,3,'schedule','pending',0,0,0,0),(9532,1,'schedule','status',1,0,0,0),(9533,2,'schedule','status',1,0,0,0),(9534,3,'schedule','status',0,0,0,0),(9535,1,'schedule','assignment',1,1,0,1),(9536,2,'schedule','assignment',1,0,0,0),(9537,3,'schedule','assignment',0,0,0,0),(9538,1,'schedule','assignments',1,0,0,0),(9539,2,'schedule','assignments',1,0,0,0),(9540,3,'schedule','assignments',1,0,0,0),(9541,1,'schedule','days',1,0,0,0),(9542,2,'schedule','days',1,0,0,0),(9543,3,'schedule','days',0,0,0,0),(9544,1,'schedule','update',1,0,1,0),(9545,2,'schedule','update',1,0,1,0),(9546,3,'schedule','update',0,0,0,0),(9547,1,'schedule','delete',0,0,0,1),(9548,2,'schedule','delete',0,0,0,0),(9549,3,'schedule','delete',0,0,0,0),(9550,1,'schedule','clientReportByDay',1,0,0,0),(9551,2,'schedule','clientReportByDay',1,0,0,0),(9552,3,'schedule','clientReportByDay',0,0,0,0),(9553,1,'schedule','reportData',1,0,0,0),(9554,2,'schedule','reportData',1,0,0,0),(9555,3,'schedule','reportData',0,0,0,0),(9556,1,'schedule','scheduleStatusByRange',1,0,0,0),(9557,2,'schedule','scheduleStatusByRange',1,0,0,0),(9558,3,'schedule','scheduleStatusByRange',0,0,0,0),(9559,1,'schedule','notes',1,0,1,0),(9560,2,'schedule','notes',1,0,1,0),(9561,3,'schedule','notes',0,0,0,0),(9562,1,'schedule','jobReportByDay',1,0,0,0),(9563,2,'schedule','jobReportByDay',1,0,0,0),(9564,3,'schedule','jobReportByDay',0,0,0,0),(9565,1,'skill','create',0,1,0,0),(9566,2,'skill','create',0,0,0,0),(9567,3,'skill','create',0,0,0,0),(9568,1,'skill','list',1,0,0,0),(9569,2,'skill','list',1,0,0,0),(9570,3,'skill','list',0,0,0,0),(9571,1,'skill','delete',0,0,1,0),(9572,2,'skill','delete',0,0,0,0),(9573,3,'skill','delete',0,0,0,0),(9574,1,'employee','list',1,0,0,0),(9575,2,'employee','list',0,0,0,0),(9576,3,'employee','list',0,0,0,0),(9577,1,'employee','create',0,1,0,0),(9578,2,'employee','create',0,0,0,0),(9579,3,'employee','create',0,0,0,0),(9580,1,'employee','schedule',1,0,0,0),(9581,2,'employee','schedule',0,0,0,0),(9582,3,'employee','schedule',0,0,0,0),(9583,1,'employee','available',1,0,0,0),(9584,2,'employee','available',0,0,0,0),(9585,3,'employee','available',0,0,0,0),(9586,1,'employee','assignments',1,0,0,0),(9587,2,'employee','assignments',1,0,0,0),(9588,3,'employee','assignments',1,0,0,0),(9589,1,'employee','fetch',1,0,0,0),(9590,2,'employee','fetch',1,0,0,0),(9591,3,'employee','fetch',1,0,0,0),(9592,1,'employee','update',0,0,1,0),(9593,2,'employee','update',0,0,0,0),(9594,3,'employee','update',0,0,0,0),(9595,1,'employee','workDays',1,1,0,0),(9596,2,'employee','workDays',0,0,0,0),(9597,3,'employee','workDays',1,0,0,0),(9598,1,'employee','skills',1,1,0,0),(9599,2,'employee','skills',0,0,0,0),(9600,3,'employee','skills',1,0,0,0),(9601,1,'employee','assignmentDetails',1,0,0,0),(9602,2,'employee','assignmentDetails',1,0,0,0),(9603,3,'employee','assignmentDetails',1,0,0,0),(9604,1,'employee','forClientByDays',1,0,0,0),(9605,2,'employee','forClientByDays',1,0,0,0),(9606,3,'employee','forClientByDays',0,0,0,0),(9607,1,'company','fetch',1,0,0,0),(9608,2,'company','fetch',0,0,0,0),(9609,3,'company','fetch',0,0,0,0),(9610,1,'company','update',0,0,1,0),(9611,2,'company','update',0,0,0,0),(9612,3,'company','update',0,0,0,0),(9613,1,'company','users',1,0,0,0),(9614,2,'company','users',0,0,0,0),(9615,3,'company','users',0,0,0,0);
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

-- Dump completed on 2024-09-14 21:55:16
