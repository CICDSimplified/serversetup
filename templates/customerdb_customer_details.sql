CREATE DATABASE  IF NOT EXISTS `customerdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `customerdb`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win32 (AMD64)
--
-- Host: localhost    Database: customerdb
-- ------------------------------------------------------
-- Server version	5.7.9-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer_details`
--

DROP TABLE IF EXISTS `customer_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `contactNumber` varchar(45) DEFAULT NULL,
  `alternateContactNumber` varchar(45) DEFAULT NULL,
  `specialty` varchar(45) DEFAULT NULL,
  `qualificationSummary` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_details`
--

LOCK TABLES `customer_details` WRITE;
/*!40000 ALTER TABLE `customer_details` DISABLE KEYS */;
INSERT INTO `customer_details` VALUES (1,'Saraa','chrompet','9600008084','96008083','JAVA','MCA'),(2,'Sara','US','9600008084','9600008083','JAVA','MCA'),(3,'Sara','US','9600008084','9600008083','JAVA','MCA'),(4,'Sara','US','9600008084','9600008083','JAVA','MCA'),(6,'Sara','US','9600008084','9600008083','JAVA','MCA'),(7,'Sara','US','9600008084','9600008082','JAVA','MCA'),(15,'Sara','US','9600008084','9600008083','JAVA','MCA'),(16,'Sara','US','9600008084','9600008083','JAVA','MCA'),(17,'Sara','US','9600008084','9600008083','JAVA','MCA'),(18,'Sara','US','9600008084','9600008083','JAVA','MCA'),(19,'Sara','US','9600008084','9600008083','JAVA','MCA'),(20,'Sara','US','9600008084','9600008083','JAVA','MCA'),(21,'Sara','US','9600008084','9600008083','JAVA','MCA'),(22,'Sara','US','9600008084','9600008083','JAVA','MCA');
/*!40000 ALTER TABLE `customer_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-13 16:47:26
