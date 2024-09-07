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
) ENGINE=InnoDB AUTO_INCREMENT=8803 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (8650,1,'user','create',0,1,0,0),(8651,2,'user','create',0,0,0,0),(8652,3,'user','create',0,0,0,0),(8653,1,'user','fetch',1,0,0,0),(8654,2,'user','fetch',1,0,0,0),(8655,3,'user','fetch',1,0,0,0),(8656,1,'user','update',0,0,1,0),(8657,2,'user','update',0,0,0,0),(8658,3,'user','update',0,0,0,0),(8659,1,'user','profile',1,0,1,0),(8660,2,'user','profile',1,0,1,0),(8661,3,'user','profile',1,0,1,0),(8662,1,'client','list',1,0,0,0),(8663,2,'client','list',0,0,0,0),(8664,3,'client','list',0,0,0,0),(8665,1,'client','create',0,1,0,0),(8666,2,'client','create',0,0,0,0),(8667,3,'client','create',0,0,0,0),(8668,1,'client','fetch',1,0,0,0),(8669,2,'client','fetch',1,0,0,0),(8670,3,'client','fetch',0,0,0,0),(8671,1,'client','update',0,0,1,0),(8672,2,'client','update',0,0,0,0),(8673,3,'client','update',0,0,0,0),(8674,1,'client','users',1,0,0,0),(8675,2,'client','users',1,0,0,0),(8676,3,'client','users',0,0,0,0),(8677,1,'client','workdays',1,1,0,0),(8678,2,'client','workdays',1,0,0,0),(8679,3,'client','workdays',1,0,0,0),(8680,1,'utilities','states',1,0,0,0),(8681,2,'utilities','states',1,0,0,0),(8682,3,'utilities','states',1,0,0,0),(8683,1,'utilities','roles',1,0,0,0),(8684,2,'utilities','roles',1,0,0,0),(8685,3,'utilities','roles',0,0,0,0),(8686,1,'utilities','weekdays',1,0,0,0),(8687,2,'utilities','weekdays',1,0,0,0),(8688,3,'utilities','weekdays',1,0,0,0),(8689,1,'utilities','holidays',1,0,0,0),(8690,2,'utilities','holidays',1,0,0,0),(8691,3,'utilities','holidays',1,0,0,0),(8692,1,'utilities','workdays',1,0,0,0),(8693,2,'utilities','workdays',1,0,0,0),(8694,3,'utilities','workdays',1,0,0,0),(8695,1,'utilities','scheduleTimes',1,0,0,0),(8696,2,'utilities','scheduleTimes',1,0,0,0),(8697,3,'utilities','scheduleTimes',1,0,0,0),(8698,1,'job','list',1,0,0,0),(8699,2,'job','list',1,0,0,0),(8700,3,'job','list',0,0,0,0),(8701,1,'job','create',0,1,0,0),(8702,2,'job','create',0,1,0,0),(8703,3,'job','create',0,0,0,0),(8704,1,'job','fetch',1,0,0,0),(8705,2,'job','fetch',1,0,0,0),(8706,3,'job','fetch',0,0,0,0),(8707,1,'job','update',0,0,1,0),(8708,2,'job','update',0,0,1,0),(8709,3,'job','update',0,0,0,0),(8710,1,'schedule','list',1,0,0,0),(8711,2,'schedule','list',1,0,0,0),(8712,3,'schedule','list',0,0,0,0),(8713,1,'schedule','create',0,1,0,0),(8714,2,'schedule','create',0,1,0,0),(8715,3,'schedule','create',0,0,0,0),(8716,1,'schedule','fetch',1,0,0,0),(8717,2,'schedule','fetch',1,0,0,0),(8718,3,'schedule','fetch',0,0,0,0),(8719,1,'schedule','pending',1,0,0,0),(8720,2,'schedule','pending',1,0,0,0),(8721,3,'schedule','pending',0,0,0,0),(8722,1,'schedule','status',1,0,0,0),(8723,2,'schedule','status',1,0,0,0),(8724,3,'schedule','status',0,0,0,0),(8725,1,'schedule','assignment',1,1,0,1),(8726,2,'schedule','assignment',1,1,0,1),(8727,3,'schedule','assignment',0,0,0,0),(8728,1,'schedule','assignments',1,0,0,0),(8729,2,'schedule','assignments',1,0,0,0),(8730,3,'schedule','assignments',0,0,0,0),(8731,1,'schedule','days',1,0,0,0),(8732,2,'schedule','days',1,0,0,0),(8733,3,'schedule','days',0,0,0,0),(8734,1,'schedule','update',1,0,1,0),(8735,2,'schedule','update',1,0,1,0),(8736,3,'schedule','update',0,0,0,0),(8737,1,'schedule','delete',0,0,0,1),(8738,2,'schedule','delete',0,0,0,1),(8739,3,'schedule','delete',0,0,0,0),(8740,1,'schedule','clientReportByDay',1,0,0,0),(8741,2,'schedule','clientReportByDay',1,0,0,0),(8742,3,'schedule','clientReportByDay',0,0,0,0),(8743,1,'schedule','reportData',1,0,0,0),(8744,2,'schedule','reportData',1,0,0,0),(8745,3,'schedule','reportData',0,0,0,0),(8746,1,'schedule','scheduleStatusByRange',1,0,0,0),(8747,2,'schedule','scheduleStatusByRange',1,0,0,0),(8748,3,'schedule','scheduleStatusByRange',0,0,0,0),(8749,1,'schedule','notes',1,0,1,0),(8750,2,'schedule','notes',1,0,1,0),(8751,3,'schedule','notes',1,0,1,0),(8752,1,'schedule','jobReportByDay',1,0,0,0),(8753,2,'schedule','jobReportByDay',1,0,0,0),(8754,3,'schedule','jobReportByDay',0,0,0,0),(8755,1,'skill','create',0,1,0,0),(8756,2,'skill','create',0,1,0,0),(8757,3,'skill','create',0,0,0,0),(8758,1,'skill','list',1,0,0,0),(8759,2,'skill','list',1,0,0,0),(8760,3,'skill','list',0,0,0,0),(8761,1,'skill','delete',0,0,1,0),(8762,2,'skill','delete',0,0,0,0),(8763,3,'skill','delete',0,0,0,0),(8764,1,'employee','list',1,0,0,0),(8765,2,'employee','list',1,0,0,0),(8766,3,'employee','list',0,0,0,0),(8767,1,'employee','create',0,1,0,0),(8768,2,'employee','create',0,1,0,0),(8769,3,'employee','create',0,0,0,0),(8770,1,'employee','schedule',1,0,0,0),(8771,2,'employee','schedule',1,0,0,0),(8772,3,'employee','schedule',0,0,0,0),(8773,1,'employee','available',1,0,0,0),(8774,2,'employee','available',1,0,0,0),(8775,3,'employee','available',0,0,0,0),(8776,1,'employee','assignments',1,0,0,0),(8777,2,'employee','assignments',1,0,0,0),(8778,3,'employee','assignments',0,0,0,0),(8779,1,'employee','fetch',1,0,0,0),(8780,2,'employee','fetch',1,0,0,0),(8781,3,'employee','fetch',1,0,0,0),(8782,1,'employee','update',0,0,1,0),(8783,2,'employee','update',0,0,1,0),(8784,3,'employee','update',0,0,0,0),(8785,1,'employee','workDays',1,1,0,0),(8786,2,'employee','workDays',1,1,0,0),(8787,3,'employee','workDays',1,0,0,0),(8788,1,'employee','skills',1,1,0,0),(8789,2,'employee','skills',1,1,0,0),(8790,3,'employee','skills',1,0,0,0),(8791,1,'employee','assignmentDetails',1,0,0,0),(8792,2,'employee','assignmentDetails',1,0,0,0),(8793,3,'employee','assignmentDetails',1,0,0,0),(8794,1,'company','fetch',1,0,0,0),(8795,2,'company','fetch',0,0,0,0),(8796,3,'company','fetch',0,0,0,0),(8797,1,'company','update',0,0,1,0),(8798,2,'company','update',0,0,0,0),(8799,3,'company','update',0,0,0,0),(8800,1,'company','users',1,0,0,0),(8801,2,'company','users',0,0,0,0),(8802,3,'company','users',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=8683 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (8530,1,'user','create',0,1,0,0),(8531,2,'user','create',0,1,0,0),(8532,3,'user','create',0,0,0,0),(8533,1,'user','fetch',1,0,0,0),(8534,2,'user','fetch',1,0,0,0),(8535,3,'user','fetch',1,0,0,0),(8536,1,'user','update',0,0,1,0),(8537,2,'user','update',0,0,1,0),(8538,3,'user','update',0,0,0,0),(8539,1,'user','profile',1,0,1,0),(8540,2,'user','profile',1,0,1,0),(8541,3,'user','profile',1,0,1,0),(8542,1,'client','list',1,0,0,0),(8543,2,'client','list',0,0,0,0),(8544,3,'client','list',0,0,0,0),(8545,1,'client','create',0,1,0,0),(8546,2,'client','create',0,0,0,0),(8547,3,'client','create',0,0,0,0),(8548,1,'client','fetch',1,0,0,0),(8549,2,'client','fetch',1,0,0,0),(8550,3,'client','fetch',0,0,0,0),(8551,1,'client','update',0,0,1,0),(8552,2,'client','update',0,0,1,0),(8553,3,'client','update',0,0,0,0),(8554,1,'client','users',1,0,0,0),(8555,2,'client','users',1,0,0,0),(8556,3,'client','users',0,0,0,0),(8557,1,'client','workdays',1,1,0,0),(8558,2,'client','workdays',1,0,0,0),(8559,3,'client','workdays',1,0,0,0),(8560,1,'utilities','states',1,0,0,0),(8561,2,'utilities','states',1,0,0,0),(8562,3,'utilities','states',1,0,0,0),(8563,1,'utilities','roles',1,0,0,0),(8564,2,'utilities','roles',1,0,0,0),(8565,3,'utilities','roles',0,0,0,0),(8566,1,'utilities','weekdays',1,0,0,0),(8567,2,'utilities','weekdays',1,0,0,0),(8568,3,'utilities','weekdays',1,0,0,0),(8569,1,'utilities','holidays',1,0,0,0),(8570,2,'utilities','holidays',1,0,0,0),(8571,3,'utilities','holidays',1,0,0,0),(8572,1,'utilities','workdays',1,0,0,0),(8573,2,'utilities','workdays',1,0,0,0),(8574,3,'utilities','workdays',1,0,0,0),(8575,1,'utilities','scheduleTimes',1,0,0,0),(8576,2,'utilities','scheduleTimes',1,0,0,0),(8577,3,'utilities','scheduleTimes',1,0,0,0),(8578,1,'job','list',1,0,0,0),(8579,2,'job','list',1,0,0,0),(8580,3,'job','list',0,0,0,0),(8581,1,'job','create',0,1,0,0),(8582,2,'job','create',0,1,0,0),(8583,3,'job','create',0,0,0,0),(8584,1,'job','fetch',1,0,0,0),(8585,2,'job','fetch',1,0,0,0),(8586,3,'job','fetch',0,0,0,0),(8587,1,'job','update',0,0,1,0),(8588,2,'job','update',0,0,1,0),(8589,3,'job','update',0,0,0,0),(8590,1,'schedule','list',1,0,0,0),(8591,2,'schedule','list',1,0,0,0),(8592,3,'schedule','list',0,0,0,0),(8593,1,'schedule','create',0,1,0,0),(8594,2,'schedule','create',0,1,0,0),(8595,3,'schedule','create',0,0,0,0),(8596,1,'schedule','fetch',1,0,0,0),(8597,2,'schedule','fetch',1,0,0,0),(8598,3,'schedule','fetch',0,0,0,0),(8599,1,'schedule','pending',1,0,0,0),(8600,2,'schedule','pending',1,0,0,0),(8601,3,'schedule','pending',0,0,0,0),(8602,1,'schedule','status',1,0,0,0),(8603,2,'schedule','status',1,0,0,0),(8604,3,'schedule','status',0,0,0,0),(8605,1,'schedule','assignment',1,1,0,1),(8606,2,'schedule','assignment',1,0,0,0),(8607,3,'schedule','assignment',0,0,0,0),(8608,1,'schedule','assignments',1,0,0,0),(8609,2,'schedule','assignments',1,0,0,0),(8610,3,'schedule','assignments',1,0,0,0),(8611,1,'schedule','days',1,0,0,0),(8612,2,'schedule','days',0,0,0,0),(8613,3,'schedule','days',0,0,0,0),(8614,1,'schedule','update',1,0,1,0),(8615,2,'schedule','update',1,0,1,0),(8616,3,'schedule','update',0,0,0,0),(8617,1,'schedule','delete',0,0,0,1),(8618,2,'schedule','delete',0,0,0,0),(8619,3,'schedule','delete',0,0,0,0),(8620,1,'schedule','clientReportByDay',1,0,0,0),(8621,2,'schedule','clientReportByDay',1,0,0,0),(8622,3,'schedule','clientReportByDay',0,0,0,0),(8623,1,'schedule','reportData',1,0,0,0),(8624,2,'schedule','reportData',1,0,0,0),(8625,3,'schedule','reportData',0,0,0,0),(8626,1,'schedule','scheduleStatusByRange',1,0,0,0),(8627,2,'schedule','scheduleStatusByRange',1,0,0,0),(8628,3,'schedule','scheduleStatusByRange',0,0,0,0),(8629,1,'schedule','notes',1,0,1,0),(8630,2,'schedule','notes',1,0,1,0),(8631,3,'schedule','notes',0,0,0,0),(8632,1,'schedule','jobReportByDay',1,0,0,0),(8633,2,'schedule','jobReportByDay',1,0,0,0),(8634,3,'schedule','jobReportByDay',0,0,0,0),(8635,1,'skill','create',0,1,0,0),(8636,2,'skill','create',0,0,0,0),(8637,3,'skill','create',0,0,0,0),(8638,1,'skill','list',1,0,0,0),(8639,2,'skill','list',1,0,0,0),(8640,3,'skill','list',0,0,0,0),(8641,1,'skill','delete',0,0,1,0),(8642,2,'skill','delete',0,0,0,0),(8643,3,'skill','delete',0,0,0,0),(8644,1,'employee','list',1,0,0,0),(8645,2,'employee','list',0,0,0,0),(8646,3,'employee','list',0,0,0,0),(8647,1,'employee','create',0,1,0,0),(8648,2,'employee','create',0,0,0,0),(8649,3,'employee','create',0,0,0,0),(8650,1,'employee','schedule',1,0,0,0),(8651,2,'employee','schedule',0,0,0,0),(8652,3,'employee','schedule',0,0,0,0),(8653,1,'employee','available',1,0,0,0),(8654,2,'employee','available',0,0,0,0),(8655,3,'employee','available',0,0,0,0),(8656,1,'employee','assignments',1,0,0,0),(8657,2,'employee','assignments',1,0,0,0),(8658,3,'employee','assignments',1,0,0,0),(8659,1,'employee','fetch',1,0,0,0),(8660,2,'employee','fetch',1,0,0,0),(8661,3,'employee','fetch',1,0,0,0),(8662,1,'employee','update',0,0,1,0),(8663,2,'employee','update',0,0,0,0),(8664,3,'employee','update',0,0,0,0),(8665,1,'employee','workDays',1,1,0,0),(8666,2,'employee','workDays',0,0,0,0),(8667,3,'employee','workDays',0,0,0,0),(8668,1,'employee','skills',1,1,0,0),(8669,2,'employee','skills',0,0,0,0),(8670,3,'employee','skills',0,0,0,0),(8671,1,'employee','assignmentDetails',1,0,0,0),(8672,2,'employee','assignmentDetails',1,0,0,0),(8673,3,'employee','assignmentDetails',1,0,0,0),(8674,1,'company','fetch',1,0,0,0),(8675,2,'company','fetch',0,0,0,0),(8676,3,'company','fetch',0,0,0,0),(8677,1,'company','update',0,0,1,0),(8678,2,'company','update',0,0,0,0),(8679,3,'company','update',0,0,0,0),(8680,1,'company','users',1,0,0,0),(8681,2,'company','users',0,0,0,0),(8682,3,'company','users',0,0,0,0);
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

-- Dump completed on 2024-09-07  2:09:30
