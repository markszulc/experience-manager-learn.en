CREATE DATABASE  IF NOT EXISTS `aemformstutorial` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `aemformstutorial`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: aemformstutorial
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `formsubmissions`
--

DROP TABLE IF EXISTS `formsubmissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `formsubmissions` (
  `formdata` longtext NOT NULL,
  `formname` varchar(45) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formsubmissions`
--

LOCK TABLES `formsubmissions` WRITE;
/*!40000 ALTER TABLE `formsubmissions` DISABLE KEYS */;
INSERT INTO `formsubmissions` VALUES ('<?xml version=\"1.0\" encoding=\"UTF-8\"?><afData><afUnboundData><data><FirstName>Girish</FirstName><LastName>Bedekar</LastName><customerEmail>girishbedekar@gmail.com</customerEmail><Company>Adobe</Company><AEM>Assets</AEM><PreferredCloudProvider>AWS</PreferredCloudProvider></data></afUnboundData><afBoundData><data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/></afBoundData><afSubmissionInfo><computedMetaInfo/><stateOverrides/><signers/><afPath>/content/dam/formsanddocuments/aemsizingquestionnaire</afPath><afSubmissionTime>20200504052317</afSubmissionTime></afSubmissionInfo></afData>','aemsizingquestionnaire',1),('<?xml version=\"1.0\" encoding=\"UTF-8\"?><afData><afUnboundData><data/></afUnboundData><afBoundData><st-sample xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><TxprNo>4940</TxprNo></st-sample></afBoundData><afSubmissionInfo><computedMetaInfo/><stateOverrides/><signers/><afPath>/content/dam/formsanddocuments/txoag-</afPath><afSubmissionTime>20200504061638</afSubmissionTime></afSubmissionInfo></afData>','txoag',2),('<?xml version=\"1.0\" encoding=\"UTF-8\"?><afData><afUnboundData><data><submitterName>Girish</submitterName><department>Engineering</department><startDate>2020-05-04</startDate><endDate>2020-05-12</endDate><initialstep>Yes</initialstep></data></afUnboundData><afBoundData><data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/></afBoundData><afSubmissionInfo><computedMetaInfo/><stateOverrides/><signers/><afPath>/content/dam/formsanddocuments/helpx/timeoffrequestform</afPath><afSubmissionTime>20200504085017</afSubmissionTime></afSubmissionInfo></afData>','timeoffrequestform',3),('<?xml version=\"1.0\" encoding=\"UTF-8\"?><afData><afUnboundData><data><submitterName>Anjali</submitterName><department>HR</department><startDate>2020-05-06</startDate><endDate>2020-05-19</endDate><initialstep>Yes</initialstep></data></afUnboundData><afBoundData><data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/></afBoundData><afSubmissionInfo><computedMetaInfo/><stateOverrides/><signers/><afPath>/content/dam/formsanddocuments/helpx/timeoffrequestform</afPath><afSubmissionTime>20200504085352</afSubmissionTime></afSubmissionInfo></afData>','timeoffrequestform',4),('<?xml version=\"1.0\" encoding=\"UTF-8\"?><afData><afUnboundData><data><FirstName>Girish</FirstName><LastName>Bedekar</LastName><customerEmail>girishbedekar@gmail.com</customerEmail><Company>Agile</Company><AEM>Sites</AEM><UseAEMToday>Yes</UseAEMToday></data></afUnboundData><afBoundData><data xmlns:xfa=\"http://www.xfa.org/schema/xfa-data/1.0/\"/></afBoundData><afSubmissionInfo><computedMetaInfo/><stateOverrides/><signers/><afPath>/content/dam/formsanddocuments/aemsizingquestionnaire</afPath><afSubmissionTime>20200505100227</afSubmissionTime></afSubmissionInfo></afData>','aemsizingquestionnaire',5);
/*!40000 ALTER TABLE `formsubmissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-05 10:08:59
