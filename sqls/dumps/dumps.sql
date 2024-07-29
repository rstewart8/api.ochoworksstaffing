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
) ENGINE=InnoDB AUTO_INCREMENT=7369 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (7237,1,'user','create',0,1,0,0),(7238,2,'user','create',0,0,0,0),(7239,3,'user','create',0,0,0,0),(7240,1,'user','fetch',1,0,0,0),(7241,2,'user','fetch',1,0,0,0),(7242,3,'user','fetch',1,0,0,0),(7243,1,'user','update',0,0,1,0),(7244,2,'user','update',0,0,0,0),(7245,3,'user','update',0,0,0,0),(7246,1,'client','list',1,0,0,0),(7247,2,'client','list',0,0,0,0),(7248,3,'client','list',0,0,0,0),(7249,1,'client','create',0,1,0,0),(7250,2,'client','create',0,0,0,0),(7251,3,'client','create',0,0,0,0),(7252,1,'client','fetch',1,0,0,0),(7253,2,'client','fetch',1,0,0,0),(7254,3,'client','fetch',0,0,0,0),(7255,1,'client','update',0,0,1,0),(7256,2,'client','update',0,0,0,0),(7257,3,'client','update',0,0,0,0),(7258,1,'client','users',1,0,0,0),(7259,2,'client','users',1,0,0,0),(7260,3,'client','users',0,0,0,0),(7261,1,'client','workdays',1,1,0,0),(7262,2,'client','workdays',1,0,0,0),(7263,3,'client','workdays',1,0,0,0),(7264,1,'utilities','states',1,0,0,0),(7265,2,'utilities','states',1,0,0,0),(7266,3,'utilities','states',1,0,0,0),(7267,1,'utilities','roles',1,0,0,0),(7268,2,'utilities','roles',1,0,0,0),(7269,3,'utilities','roles',0,0,0,0),(7270,1,'utilities','weekdays',1,0,0,0),(7271,2,'utilities','weekdays',1,0,0,0),(7272,3,'utilities','weekdays',1,0,0,0),(7273,1,'utilities','holidays',1,0,0,0),(7274,2,'utilities','holidays',1,0,0,0),(7275,3,'utilities','holidays',1,0,0,0),(7276,1,'utilities','workdays',1,0,0,0),(7277,2,'utilities','workdays',1,0,0,0),(7278,3,'utilities','workdays',1,0,0,0),(7279,1,'utilities','scheduleTimes',1,0,0,0),(7280,2,'utilities','scheduleTimes',1,0,0,0),(7281,3,'utilities','scheduleTimes',1,0,0,0),(7282,1,'job','list',1,0,0,0),(7283,2,'job','list',1,0,0,0),(7284,3,'job','list',0,0,0,0),(7285,1,'job','create',0,1,0,0),(7286,2,'job','create',0,1,0,0),(7287,3,'job','create',0,0,0,0),(7288,1,'job','fetch',1,0,0,0),(7289,2,'job','fetch',1,0,0,0),(7290,3,'job','fetch',0,0,0,0),(7291,1,'job','update',0,0,1,0),(7292,2,'job','update',0,0,1,0),(7293,3,'job','update',0,0,0,0),(7294,1,'schedule','list',1,0,0,0),(7295,2,'schedule','list',1,0,0,0),(7296,3,'schedule','list',0,0,0,0),(7297,1,'schedule','create',0,1,0,0),(7298,2,'schedule','create',0,1,0,0),(7299,3,'schedule','create',0,0,0,0),(7300,1,'schedule','fetch',1,0,0,0),(7301,2,'schedule','fetch',1,0,0,0),(7302,3,'schedule','fetch',0,0,0,0),(7303,1,'schedule','pending',1,0,0,0),(7304,2,'schedule','pending',1,0,0,0),(7305,3,'schedule','pending',0,0,0,0),(7306,1,'schedule','status',1,0,0,0),(7307,2,'schedule','status',1,0,0,0),(7308,3,'schedule','status',0,0,0,0),(7309,1,'schedule','assignment',1,1,0,1),(7310,2,'schedule','assignment',1,1,0,1),(7311,3,'schedule','assignment',0,0,0,0),(7312,1,'schedule','assignments',1,0,0,0),(7313,2,'schedule','assignments',1,0,0,0),(7314,3,'schedule','assignments',0,0,0,0),(7315,1,'schedule','days',1,0,0,0),(7316,2,'schedule','days',1,0,0,0),(7317,3,'schedule','days',0,0,0,0),(7318,1,'schedule','update',1,0,1,0),(7319,2,'schedule','update',1,0,1,0),(7320,3,'schedule','update',0,0,0,0),(7321,1,'schedule','delete',0,0,0,1),(7322,2,'schedule','delete',0,0,0,1),(7323,3,'schedule','delete',0,0,0,0),(7324,1,'schedule','clientReportByDay',1,0,0,0),(7325,2,'schedule','clientReportByDay',1,0,0,0),(7326,3,'schedule','clientReportByDay',0,0,0,0),(7327,1,'schedule','reportData',1,0,0,0),(7328,2,'schedule','reportData',1,0,0,0),(7329,3,'schedule','reportData',0,0,0,0),(7330,1,'schedule','scheduleStatusByRange',1,0,0,0),(7331,2,'schedule','scheduleStatusByRange',1,0,0,0),(7332,3,'schedule','scheduleStatusByRange',0,0,0,0),(7333,1,'skill','create',0,1,0,0),(7334,2,'skill','create',0,1,0,0),(7335,3,'skill','create',0,0,0,0),(7336,1,'skill','list',1,0,0,0),(7337,2,'skill','list',1,0,0,0),(7338,3,'skill','list',0,0,0,0),(7339,1,'skill','delete',0,0,1,0),(7340,2,'skill','delete',0,0,0,0),(7341,3,'skill','delete',0,0,0,0),(7342,1,'employee','list',1,0,0,0),(7343,2,'employee','list',1,0,0,0),(7344,3,'employee','list',0,0,0,0),(7345,1,'employee','create',0,1,0,0),(7346,2,'employee','create',0,1,0,0),(7347,3,'employee','create',0,0,0,0),(7348,1,'employee','schedule',1,0,0,0),(7349,2,'employee','schedule',1,0,0,0),(7350,3,'employee','schedule',0,0,0,0),(7351,1,'employee','available',1,0,0,0),(7352,2,'employee','available',1,0,0,0),(7353,3,'employee','available',0,0,0,0),(7354,1,'employee','assignments',1,0,0,0),(7355,2,'employee','assignments',1,0,0,0),(7356,3,'employee','assignments',0,0,0,0),(7357,1,'employee','fetch',1,0,0,0),(7358,2,'employee','fetch',1,0,0,0),(7359,3,'employee','fetch',1,0,0,0),(7360,1,'employee','update',0,0,1,0),(7361,2,'employee','update',0,0,1,0),(7362,3,'employee','update',0,0,0,0),(7363,1,'employee','workDays',1,1,0,0),(7364,2,'employee','workDays',1,1,0,0),(7365,3,'employee','workDays',1,0,0,0),(7366,1,'employee','skills',1,1,0,0),(7367,2,'employee','skills',1,1,0,0),(7368,3,'employee','skills',1,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=7249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identity_permissions`
--

LOCK TABLES `identity_permissions` WRITE;
/*!40000 ALTER TABLE `identity_permissions` DISABLE KEYS */;
INSERT INTO `identity_permissions` VALUES (7117,1,'user','create',0,1,0,0),(7118,2,'user','create',0,1,0,0),(7119,3,'user','create',0,0,0,0),(7120,1,'user','fetch',1,0,0,0),(7121,2,'user','fetch',1,0,0,0),(7122,3,'user','fetch',1,0,0,0),(7123,1,'user','update',0,0,1,0),(7124,2,'user','update',0,0,1,0),(7125,3,'user','update',0,0,0,0),(7126,1,'client','list',1,0,0,0),(7127,2,'client','list',0,0,0,0),(7128,3,'client','list',0,0,0,0),(7129,1,'client','create',0,1,0,0),(7130,2,'client','create',0,0,0,0),(7131,3,'client','create',0,0,0,0),(7132,1,'client','fetch',1,0,0,0),(7133,2,'client','fetch',1,0,0,0),(7134,3,'client','fetch',0,0,0,0),(7135,1,'client','update',0,0,1,0),(7136,2,'client','update',0,0,1,0),(7137,3,'client','update',0,0,0,0),(7138,1,'client','users',1,0,0,0),(7139,2,'client','users',1,0,0,0),(7140,3,'client','users',0,0,0,0),(7141,1,'client','workdays',1,1,0,0),(7142,2,'client','workdays',1,0,0,0),(7143,3,'client','workdays',1,0,0,0),(7144,1,'utilities','states',1,0,0,0),(7145,2,'utilities','states',1,0,0,0),(7146,3,'utilities','states',1,0,0,0),(7147,1,'utilities','roles',1,0,0,0),(7148,2,'utilities','roles',1,0,0,0),(7149,3,'utilities','roles',0,0,0,0),(7150,1,'utilities','weekdays',1,0,0,0),(7151,2,'utilities','weekdays',1,0,0,0),(7152,3,'utilities','weekdays',1,0,0,0),(7153,1,'utilities','holidays',1,0,0,0),(7154,2,'utilities','holidays',1,0,0,0),(7155,3,'utilities','holidays',1,0,0,0),(7156,1,'utilities','workdays',1,0,0,0),(7157,2,'utilities','workdays',1,0,0,0),(7158,3,'utilities','workdays',1,0,0,0),(7159,1,'utilities','scheduleTimes',1,0,0,0),(7160,2,'utilities','scheduleTimes',1,0,0,0),(7161,3,'utilities','scheduleTimes',1,0,0,0),(7162,1,'job','list',1,0,0,0),(7163,2,'job','list',1,0,0,0),(7164,3,'job','list',0,0,0,0),(7165,1,'job','create',0,1,0,0),(7166,2,'job','create',0,1,0,0),(7167,3,'job','create',0,0,0,0),(7168,1,'job','fetch',1,0,0,0),(7169,2,'job','fetch',1,0,0,0),(7170,3,'job','fetch',0,0,0,0),(7171,1,'job','update',0,0,1,0),(7172,2,'job','update',0,0,1,0),(7173,3,'job','update',0,0,0,0),(7174,1,'schedule','list',1,0,0,0),(7175,2,'schedule','list',1,0,0,0),(7176,3,'schedule','list',0,0,0,0),(7177,1,'schedule','create',0,1,0,0),(7178,2,'schedule','create',0,1,0,0),(7179,3,'schedule','create',0,0,0,0),(7180,1,'schedule','fetch',1,0,0,0),(7181,2,'schedule','fetch',1,0,0,0),(7182,3,'schedule','fetch',0,0,0,0),(7183,1,'schedule','pending',1,0,0,0),(7184,2,'schedule','pending',1,0,0,0),(7185,3,'schedule','pending',0,0,0,0),(7186,1,'schedule','status',1,0,0,0),(7187,2,'schedule','status',1,0,0,0),(7188,3,'schedule','status',0,0,0,0),(7189,1,'schedule','assignment',1,1,0,1),(7190,2,'schedule','assignment',1,0,0,0),(7191,3,'schedule','assignment',0,0,0,0),(7192,1,'schedule','assignments',1,0,0,0),(7193,2,'schedule','assignments',1,0,0,0),(7194,3,'schedule','assignments',1,0,0,0),(7195,1,'schedule','days',1,0,0,0),(7196,2,'schedule','days',0,0,0,0),(7197,3,'schedule','days',0,0,0,0),(7198,1,'schedule','update',1,0,1,0),(7199,2,'schedule','update',1,0,1,0),(7200,3,'schedule','update',0,0,0,0),(7201,1,'schedule','delete',0,0,0,1),(7202,2,'schedule','delete',0,0,0,0),(7203,3,'schedule','delete',0,0,0,0),(7204,1,'schedule','clientReportByDay',1,0,0,0),(7205,2,'schedule','clientReportByDay',1,0,0,0),(7206,3,'schedule','clientReportByDay',0,0,0,0),(7207,1,'schedule','reportData',1,0,0,0),(7208,2,'schedule','reportData',1,0,0,0),(7209,3,'schedule','reportData',0,0,0,0),(7210,1,'schedule','scheduleStatusByRange',1,0,0,0),(7211,2,'schedule','scheduleStatusByRange',1,0,0,0),(7212,3,'schedule','scheduleStatusByRange',0,0,0,0),(7213,1,'skill','create',0,1,0,0),(7214,2,'skill','create',0,0,0,0),(7215,3,'skill','create',0,0,0,0),(7216,1,'skill','list',1,0,0,0),(7217,2,'skill','list',1,0,0,0),(7218,3,'skill','list',0,0,0,0),(7219,1,'skill','delete',0,0,1,0),(7220,2,'skill','delete',0,0,0,0),(7221,3,'skill','delete',0,0,0,0),(7222,1,'employee','list',1,0,0,0),(7223,2,'employee','list',0,0,0,0),(7224,3,'employee','list',0,0,0,0),(7225,1,'employee','create',0,1,0,0),(7226,2,'employee','create',0,0,0,0),(7227,3,'employee','create',0,0,0,0),(7228,1,'employee','schedule',1,0,0,0),(7229,2,'employee','schedule',0,0,0,0),(7230,3,'employee','schedule',0,0,0,0),(7231,1,'employee','available',1,0,0,0),(7232,2,'employee','available',0,0,0,0),(7233,3,'employee','available',0,0,0,0),(7234,1,'employee','assignments',1,0,0,0),(7235,2,'employee','assignments',1,0,0,0),(7236,3,'employee','assignments',1,0,0,0),(7237,1,'employee','fetch',1,0,0,0),(7238,2,'employee','fetch',1,0,0,0),(7239,3,'employee','fetch',1,0,0,0),(7240,1,'employee','update',0,0,1,0),(7241,2,'employee','update',0,0,0,0),(7242,3,'employee','update',0,0,0,0),(7243,1,'employee','workDays',1,1,0,0),(7244,2,'employee','workDays',0,0,0,0),(7245,3,'employee','workDays',0,0,0,0),(7246,1,'employee','skills',1,1,0,0),(7247,2,'employee','skills',0,0,0,0),(7248,3,'employee','skills',0,0,0,0);
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

-- Dump completed on 2024-07-28 19:10:17
