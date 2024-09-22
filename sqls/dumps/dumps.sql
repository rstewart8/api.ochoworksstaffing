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
) ENGINE=InnoDB AUTO_INCREMENT=9898 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (9736,1,'user','create',0,1,0,0),(9737,2,'user','create',0,0,0,0),(9738,3,'user','create',0,0,0,0),(9739,1,'user','fetch',1,0,0,0),(9740,2,'user','fetch',1,0,0,0),(9741,3,'user','fetch',1,0,0,0),(9742,1,'user','update',0,0,1,0),(9743,2,'user','update',0,0,0,0),(9744,3,'user','update',0,0,0,0),(9745,1,'user','profile',1,0,1,0),(9746,2,'user','profile',1,0,1,0),(9747,3,'user','profile',1,0,1,0),(9748,1,'user','photo',0,1,0,0),(9749,2,'user','photo',0,1,0,0),(9750,3,'user','photo',0,1,0,0),(9751,1,'user','resetPassword',0,0,1,0),(9752,2,'user','resetPassword',0,0,1,0),(9753,3,'user','resetPassword',0,0,1,0),(9754,1,'client','list',1,0,0,0),(9755,2,'client','list',0,0,0,0),(9756,3,'client','list',0,0,0,0),(9757,1,'client','create',0,1,0,0),(9758,2,'client','create',0,0,0,0),(9759,3,'client','create',0,0,0,0),(9760,1,'client','fetch',1,0,0,0),(9761,2,'client','fetch',1,0,0,0),(9762,3,'client','fetch',0,0,0,0),(9763,1,'client','update',0,0,1,0),(9764,2,'client','update',0,0,0,0),(9765,3,'client','update',0,0,0,0),(9766,1,'client','users',1,0,0,0),(9767,2,'client','users',1,0,0,0),(9768,3,'client','users',0,0,0,0),(9769,1,'client','workdays',1,1,0,0),(9770,2,'client','workdays',1,0,0,0),(9771,3,'client','workdays',1,0,0,0),(9772,1,'utilities','states',1,0,0,0),(9773,2,'utilities','states',1,0,0,0),(9774,3,'utilities','states',1,0,0,0),(9775,1,'utilities','roles',1,0,0,0),(9776,2,'utilities','roles',1,0,0,0),(9777,3,'utilities','roles',0,0,0,0),(9778,1,'utilities','weekdays',1,0,0,0),(9779,2,'utilities','weekdays',1,0,0,0),(9780,3,'utilities','weekdays',1,0,0,0),(9781,1,'utilities','holidays',1,0,0,0),(9782,2,'utilities','holidays',1,0,0,0),(9783,3,'utilities','holidays',1,0,0,0),(9784,1,'utilities','workdays',1,0,0,0),(9785,2,'utilities','workdays',1,0,0,0),(9786,3,'utilities','workdays',1,0,0,0),(9787,1,'utilities','scheduleTimes',1,0,0,0),(9788,2,'utilities','scheduleTimes',1,0,0,0),(9789,3,'utilities','scheduleTimes',1,0,0,0),(9790,1,'job','list',1,0,0,0),(9791,2,'job','list',1,0,0,0),(9792,3,'job','list',0,0,0,0),(9793,1,'job','create',0,1,0,0),(9794,2,'job','create',0,1,0,0),(9795,3,'job','create',0,0,0,0),(9796,1,'job','fetch',1,0,0,0),(9797,2,'job','fetch',1,0,0,0),(9798,3,'job','fetch',0,0,0,0),(9799,1,'job','update',0,0,1,0),(9800,2,'job','update',0,0,1,0),(9801,3,'job','update',0,0,0,0),(9802,1,'schedule','list',1,0,0,0),(9803,2,'schedule','list',1,0,0,0),(9804,3,'schedule','list',0,0,0,0),(9805,1,'schedule','create',0,1,0,0),(9806,2,'schedule','create',0,1,0,0),(9807,3,'schedule','create',0,0,0,0),(9808,1,'schedule','fetch',1,0,0,0),(9809,2,'schedule','fetch',1,0,0,0),(9810,3,'schedule','fetch',0,0,0,0),(9811,1,'schedule','pending',1,0,0,0),(9812,2,'schedule','pending',1,0,0,0),(9813,3,'schedule','pending',0,0,0,0),(9814,1,'schedule','status',1,0,0,0),(9815,2,'schedule','status',1,0,0,0),(9816,3,'schedule','status',0,0,0,0),(9817,1,'schedule','assignment',1,1,0,1),(9818,2,'schedule','assignment',1,1,0,1),(9819,3,'schedule','assignment',0,0,0,0),(9820,1,'schedule','assignments',1,0,0,0),(9821,2,'schedule','assignments',1,0,0,0),(9822,3,'schedule','assignments',0,0,0,0),(9823,1,'schedule','days',1,0,0,0),(9824,2,'schedule','days',1,0,0,0),(9825,3,'schedule','days',0,0,0,0),(9826,1,'schedule','update',1,0,1,0),(9827,2,'schedule','update',1,0,1,0),(9828,3,'schedule','update',0,0,0,0),(9829,1,'schedule','delete',0,0,0,1),(9830,2,'schedule','delete',0,0,0,1),(9831,3,'schedule','delete',0,0,0,0),(9832,1,'schedule','clientReportByDay',1,0,0,0),(9833,2,'schedule','clientReportByDay',1,0,0,0),(9834,3,'schedule','clientReportByDay',0,0,0,0),(9835,1,'schedule','reportData',1,0,0,0),(9836,2,'schedule','reportData',1,0,0,0),(9837,3,'schedule','reportData',0,0,0,0),(9838,1,'schedule','scheduleStatusByRange',1,0,0,0),(9839,2,'schedule','scheduleStatusByRange',1,0,0,0),(9840,3,'schedule','scheduleStatusByRange',0,0,0,0),(9841,1,'schedule','notes',1,0,1,0),(9842,2,'schedule','notes',1,0,1,0),(9843,3,'schedule','notes',1,0,1,0),(9844,1,'schedule','jobReportByDay',1,0,0,0),(9845,2,'schedule','jobReportByDay',1,0,0,0),(9846,3,'schedule','jobReportByDay',0,0,0,0),(9847,1,'skill','create',0,1,0,0),(9848,2,'skill','create',0,1,0,0),(9849,3,'skill','create',0,0,0,0),(9850,1,'skill','list',1,0,0,0),(9851,2,'skill','list',1,0,0,0),(9852,3,'skill','list',0,0,0,0),(9853,1,'skill','delete',0,0,1,0),(9854,2,'skill','delete',0,0,0,0),(9855,3,'skill','delete',0,0,0,0),(9856,1,'employee','list',1,0,0,0),(9857,2,'employee','list',1,0,0,0),(9858,3,'employee','list',0,0,0,0),(9859,1,'employee','create',0,1,0,0),(9860,2,'employee','create',0,1,0,0),(9861,3,'employee','create',0,0,0,0),(9862,1,'employee','schedule',1,0,0,0),(9863,2,'employee','schedule',1,0,0,0),(9864,3,'employee','schedule',0,0,0,0),(9865,1,'employee','available',1,0,0,0),(9866,2,'employee','available',1,0,0,0),(9867,3,'employee','available',0,0,0,0),(9868,1,'employee','assignments',1,0,0,0),(9869,2,'employee','assignments',1,0,0,0),(9870,3,'employee','assignments',0,0,0,0),(9871,1,'employee','fetch',1,0,0,0),(9872,2,'employee','fetch',1,0,0,0),(9873,3,'employee','fetch',1,0,0,0),(9874,1,'employee','update',0,0,1,0),(9875,2,'employee','update',0,0,1,0),(9876,3,'employee','update',0,0,0,0),(9877,1,'employee','workDays',1,1,0,0),(9878,2,'employee','workDays',1,1,0,0),(9879,3,'employee','workDays',1,0,0,0),(9880,1,'employee','skills',1,1,0,0),(9881,2,'employee','skills',1,1,0,0),(9882,3,'employee','skills',1,0,0,0),(9883,1,'employee','assignmentDetails',1,0,0,0),(9884,2,'employee','assignmentDetails',1,0,0,0),(9885,3,'employee','assignmentDetails',1,0,0,0),(9886,1,'employee','forClientByDays',1,0,0,0),(9887,2,'employee','forClientByDays',1,0,0,0),(9888,3,'employee','forClientByDays',0,0,0,0),(9889,1,'company','fetch',1,0,0,0),(9890,2,'company','fetch',0,0,0,0),(9891,3,'company','fetch',0,0,0,0),(9892,1,'company','update',0,0,1,0),(9893,2,'company','update',0,0,0,0),(9894,3,'company','update',0,0,0,0),(9895,1,'company','users',1,0,0,0),(9896,2,'company','users',0,0,0,0),(9897,3,'company','users',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9778 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (9616,1,'user','create',0,1,0,0),(9617,2,'user','create',0,1,0,0),(9618,3,'user','create',0,0,0,0),(9619,1,'user','fetch',1,0,0,0),(9620,2,'user','fetch',1,0,0,0),(9621,3,'user','fetch',1,0,0,0),(9622,1,'user','update',0,0,1,0),(9623,2,'user','update',0,0,1,0),(9624,3,'user','update',0,0,0,0),(9625,1,'user','profile',1,0,1,0),(9626,2,'user','profile',1,0,1,0),(9627,3,'user','profile',1,0,1,0),(9628,1,'user','photo',0,1,0,0),(9629,2,'user','photo',0,1,0,0),(9630,3,'user','photo',0,1,0,0),(9631,1,'user','resetPassword',0,0,1,0),(9632,2,'user','resetPassword',0,0,1,0),(9633,3,'user','resetPassword',0,0,1,0),(9634,1,'client','list',1,0,0,0),(9635,2,'client','list',0,0,0,0),(9636,3,'client','list',0,0,0,0),(9637,1,'client','create',0,1,0,0),(9638,2,'client','create',0,0,0,0),(9639,3,'client','create',0,0,0,0),(9640,1,'client','fetch',1,0,0,0),(9641,2,'client','fetch',1,0,0,0),(9642,3,'client','fetch',0,0,0,0),(9643,1,'client','update',0,0,1,0),(9644,2,'client','update',0,0,1,0),(9645,3,'client','update',0,0,0,0),(9646,1,'client','users',1,0,0,0),(9647,2,'client','users',1,0,0,0),(9648,3,'client','users',0,0,0,0),(9649,1,'client','workdays',1,1,0,0),(9650,2,'client','workdays',1,0,0,0),(9651,3,'client','workdays',1,0,0,0),(9652,1,'utilities','states',1,0,0,0),(9653,2,'utilities','states',1,0,0,0),(9654,3,'utilities','states',1,0,0,0),(9655,1,'utilities','roles',1,0,0,0),(9656,2,'utilities','roles',1,0,0,0),(9657,3,'utilities','roles',0,0,0,0),(9658,1,'utilities','weekdays',1,0,0,0),(9659,2,'utilities','weekdays',1,0,0,0),(9660,3,'utilities','weekdays',1,0,0,0),(9661,1,'utilities','holidays',1,0,0,0),(9662,2,'utilities','holidays',1,0,0,0),(9663,3,'utilities','holidays',1,0,0,0),(9664,1,'utilities','workdays',1,0,0,0),(9665,2,'utilities','workdays',1,0,0,0),(9666,3,'utilities','workdays',1,0,0,0),(9667,1,'utilities','scheduleTimes',1,0,0,0),(9668,2,'utilities','scheduleTimes',1,0,0,0),(9669,3,'utilities','scheduleTimes',1,0,0,0),(9670,1,'job','list',1,0,0,0),(9671,2,'job','list',1,0,0,0),(9672,3,'job','list',0,0,0,0),(9673,1,'job','create',0,1,0,0),(9674,2,'job','create',0,1,0,0),(9675,3,'job','create',0,0,0,0),(9676,1,'job','fetch',1,0,0,0),(9677,2,'job','fetch',1,0,0,0),(9678,3,'job','fetch',0,0,0,0),(9679,1,'job','update',0,0,1,0),(9680,2,'job','update',0,0,1,0),(9681,3,'job','update',0,0,0,0),(9682,1,'schedule','list',1,0,0,0),(9683,2,'schedule','list',1,0,0,0),(9684,3,'schedule','list',0,0,0,0),(9685,1,'schedule','create',0,1,0,0),(9686,2,'schedule','create',0,1,0,0),(9687,3,'schedule','create',0,0,0,0),(9688,1,'schedule','fetch',1,0,0,0),(9689,2,'schedule','fetch',1,0,0,0),(9690,3,'schedule','fetch',0,0,0,0),(9691,1,'schedule','pending',1,0,0,0),(9692,2,'schedule','pending',1,0,0,0),(9693,3,'schedule','pending',0,0,0,0),(9694,1,'schedule','status',1,0,0,0),(9695,2,'schedule','status',1,0,0,0),(9696,3,'schedule','status',0,0,0,0),(9697,1,'schedule','assignment',1,1,0,1),(9698,2,'schedule','assignment',1,0,0,0),(9699,3,'schedule','assignment',0,0,0,0),(9700,1,'schedule','assignments',1,0,0,0),(9701,2,'schedule','assignments',1,0,0,0),(9702,3,'schedule','assignments',1,0,0,0),(9703,1,'schedule','days',1,0,0,0),(9704,2,'schedule','days',1,0,0,0),(9705,3,'schedule','days',0,0,0,0),(9706,1,'schedule','update',1,0,1,0),(9707,2,'schedule','update',1,0,1,0),(9708,3,'schedule','update',0,0,0,0),(9709,1,'schedule','delete',0,0,0,1),(9710,2,'schedule','delete',0,0,0,0),(9711,3,'schedule','delete',0,0,0,0),(9712,1,'schedule','clientReportByDay',1,0,0,0),(9713,2,'schedule','clientReportByDay',1,0,0,0),(9714,3,'schedule','clientReportByDay',0,0,0,0),(9715,1,'schedule','reportData',1,0,0,0),(9716,2,'schedule','reportData',1,0,0,0),(9717,3,'schedule','reportData',0,0,0,0),(9718,1,'schedule','scheduleStatusByRange',1,0,0,0),(9719,2,'schedule','scheduleStatusByRange',1,0,0,0),(9720,3,'schedule','scheduleStatusByRange',0,0,0,0),(9721,1,'schedule','notes',1,0,1,0),(9722,2,'schedule','notes',1,0,1,0),(9723,3,'schedule','notes',0,0,0,0),(9724,1,'schedule','jobReportByDay',1,0,0,0),(9725,2,'schedule','jobReportByDay',1,0,0,0),(9726,3,'schedule','jobReportByDay',0,0,0,0),(9727,1,'skill','create',0,1,0,0),(9728,2,'skill','create',0,0,0,0),(9729,3,'skill','create',0,0,0,0),(9730,1,'skill','list',1,0,0,0),(9731,2,'skill','list',1,0,0,0),(9732,3,'skill','list',0,0,0,0),(9733,1,'skill','delete',0,0,1,0),(9734,2,'skill','delete',0,0,0,0),(9735,3,'skill','delete',0,0,0,0),(9736,1,'employee','list',1,0,0,0),(9737,2,'employee','list',0,0,0,0),(9738,3,'employee','list',0,0,0,0),(9739,1,'employee','create',0,1,0,0),(9740,2,'employee','create',0,0,0,0),(9741,3,'employee','create',0,0,0,0),(9742,1,'employee','schedule',1,0,0,0),(9743,2,'employee','schedule',0,0,0,0),(9744,3,'employee','schedule',0,0,0,0),(9745,1,'employee','available',1,0,0,0),(9746,2,'employee','available',0,0,0,0),(9747,3,'employee','available',0,0,0,0),(9748,1,'employee','assignments',1,0,0,0),(9749,2,'employee','assignments',1,0,0,0),(9750,3,'employee','assignments',1,0,0,0),(9751,1,'employee','fetch',1,0,0,0),(9752,2,'employee','fetch',1,0,0,0),(9753,3,'employee','fetch',1,0,0,0),(9754,1,'employee','update',0,0,1,0),(9755,2,'employee','update',0,0,0,0),(9756,3,'employee','update',0,0,0,0),(9757,1,'employee','workDays',1,1,0,0),(9758,2,'employee','workDays',0,0,0,0),(9759,3,'employee','workDays',1,0,0,0),(9760,1,'employee','skills',1,1,0,0),(9761,2,'employee','skills',0,0,0,0),(9762,3,'employee','skills',1,0,0,0),(9763,1,'employee','assignmentDetails',1,0,0,0),(9764,2,'employee','assignmentDetails',1,0,0,0),(9765,3,'employee','assignmentDetails',1,0,0,0),(9766,1,'employee','forClientByDays',1,0,0,0),(9767,2,'employee','forClientByDays',1,0,0,0),(9768,3,'employee','forClientByDays',0,0,0,0),(9769,1,'company','fetch',1,0,0,0),(9770,2,'company','fetch',0,0,0,0),(9771,3,'company','fetch',0,0,0,0),(9772,1,'company','update',0,0,1,0),(9773,2,'company','update',0,0,0,0),(9774,3,'company','update',0,0,0,0),(9775,1,'company','users',1,0,0,0),(9776,2,'company','users',0,0,0,0),(9777,3,'company','users',0,0,0,0);
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

-- Dump completed on 2024-09-21 21:33:12
