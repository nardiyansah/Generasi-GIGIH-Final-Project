-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: social_media_db
-- ------------------------------------------------------
-- Server version	8.0.26-0ubuntu0.20.04.2

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
-- Table structure for table `comment_hashtags`
--

DROP TABLE IF EXISTS `comment_hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_hashtags` (
  `comment_id` int NOT NULL,
  `hashtag_id` int NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `comment_id` (`comment_id`),
  KEY `hashtag_id` (`hashtag_id`),
  CONSTRAINT `comment_hashtags_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `comment_hashtags_ibfk_2` FOREIGN KEY (`hashtag_id`) REFERENCES `hashtags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_hashtags`
--

LOCK TABLES `comment_hashtags` WRITE;
/*!40000 ALTER TABLE `comment_hashtags` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_hashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) NOT NULL,
  `attachment` varchar(500) DEFAULT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hashtags`
--

DROP TABLE IF EXISTS `hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hashtags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag` varchar(100) NOT NULL,
  `amount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hashtags`
--

LOCK TABLES `hashtags` WRITE;
/*!40000 ALTER TABLE `hashtags` DISABLE KEYS */;
INSERT INTO `hashtags` VALUES (1,'#bus',1),(2,'#circuit',2),(3,'#panel',1),(4,'#hard drive',1),(5,'#application',2),(7,'#sensor',2),(8,'#card',1),(9,'#feed',1),(10,'#pixel',1),(11,'#matrix',1),(12,'#alarm',2),(14,'#protocol',1),(15,'#capacitor',1),(17,'#driver',2),(19,'#bandwidth',1),(20,'#microchip',1);
/*!40000 ALTER TABLE `hashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_hashtags`
--

DROP TABLE IF EXISTS `post_hashtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_hashtags` (
  `post_id` int NOT NULL,
  `hashtag_id` int NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `post_id` (`post_id`),
  KEY `hashtag_id` (`hashtag_id`),
  CONSTRAINT `post_hashtags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `post_hashtags_ibfk_2` FOREIGN KEY (`hashtag_id`) REFERENCES `hashtags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_hashtags`
--

LOCK TABLES `post_hashtags` WRITE;
/*!40000 ALTER TABLE `post_hashtags` DISABLE KEYS */;
INSERT INTO `post_hashtags` VALUES (3,1,'2021-08-12 12:26:43'),(3,2,'2021-08-12 12:26:43'),(6,3,'2021-08-12 12:26:43'),(6,4,'2021-08-12 12:26:43'),(7,5,'2021-08-12 12:26:43'),(7,2,'2021-08-12 12:26:43'),(9,7,'2021-08-12 12:26:43'),(9,8,'2021-08-12 12:26:43'),(11,9,'2021-08-12 12:26:43'),(11,10,'2021-08-12 12:26:43'),(13,11,'2021-08-12 12:26:43'),(13,12,'2021-08-12 12:26:43'),(15,7,'2021-08-12 12:26:43'),(15,14,'2021-08-12 12:26:43'),(17,15,'2021-08-12 12:26:43'),(17,12,'2021-08-12 12:26:43'),(19,17,'2021-08-12 12:26:43'),(19,17,'2021-08-12 12:26:43'),(21,19,'2021-08-12 12:26:43'),(21,20,'2021-08-12 12:26:43'),(23,7,'2021-08-12 12:26:43'),(23,5,'2021-08-12 12:26:43');
/*!40000 ALTER TABLE `post_hashtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) NOT NULL,
  `attachment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'new post',''),(2,'Try to connect the XML circuit, maybe it will back up the multi-byte panel!',''),(3,'The CSS feed is down, compress the back-end sensor so we can index the AGP feed!',''),(4,'If we compress the matrix, we can get to the SQL monitor through the redundant SAS panel!',''),(5,'If we reboot the system, we can get to the PNG hard drive through the bluetooth PCI firewall!',''),(6,'Try to input the SAS interface, maybe it will transmit the wireless application!',''),(7,'We need to compress the back-end TCP port!',''),(8,'The XML system is down, bypass the optical feed so we can quantify the IB bandwidth!',''),(9,'bypassing the card won\'t do anything, we need to bypass the bluetooth THX transmitter!',''),(10,'Use the cross-platform FTP bus, then you can index the auxiliary hard drive!',''),(11,'Use the virtual SSL application, then you can index the haptic system!',''),(12,'If we index the transmitter, we can get to the SQL application through the back-end PCI hard drive!',''),(13,'If we parse the sensor, we can get to the HDD panel through the digital SSL feed!',''),(14,'You can\'t navigate the hard drive without hacking the back-end SCSI monitor!',''),(15,'The CSS program is down, bypass the neural system so we can hack the COM system!',''),(16,'Use the primary SMS port, then you can reboot the 1080p system!',''),(17,'You can\'t input the application without generating the bluetooth FTP panel!',''),(18,'You can\'t synthesize the feed without overriding the 1080p JSON array!',''),(19,'copying the array won\'t do anything, we need to index the auxiliary PNG interface!',''),(20,'We need to navigate the multi-byte EXE bandwidth!',''),(21,'We need to copy the cross-platform USB panel!',''),(22,'You can\'t back up the sensor without programming the auxiliary JSON circuit!',''),(23,'transmitting the firewall won\'t do anything, we need to reboot the 1080p THX matrix!','');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_posts`
--

DROP TABLE IF EXISTS `user_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_posts` (
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `user_posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_posts_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_posts`
--

LOCK TABLES `user_posts` WRITE;
/*!40000 ALTER TABLE `user_posts` DISABLE KEYS */;
INSERT INTO `user_posts` VALUES (3,2),(3,3),(3,4),(4,5),(4,6),(6,7),(7,8),(7,9),(8,10),(8,11),(9,12),(9,13),(10,14),(10,15),(11,16),(11,17),(12,18),(12,19),(13,20),(13,21),(14,22),(14,23);
/*!40000 ALTER TABLE `user_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `bio` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Colt_Carroll66','foo@mail.com','Use the open-source SQL feed, then you can index the redundant pixel!'),(2,'Elliot_Wiza','Hermann_DAmore85@hotmail.com','The GB hard drive is down, quantify the virtual sensor so we can input the AI driver!'),(3,'Koby11','Pasquale_Ondricka@hotmail.com','The EXE monitor is down, quantify the digital firewall so we can synthesize the XML circuit!'),(4,'Edmund30','Magnolia.Frami38@gmail.com',''),(5,'Wyatt41','Destiny.Treutel97@gmail.com',''),(6,'Aditya62','Lelia82@gmail.com',''),(7,'Grace32','Margie14@gmail.com',''),(8,'Kyra33','Emmanuelle9@gmail.com',''),(9,'Vickie.Oberbrunner19','Meredith.Rolfson28@yahoo.com','Try to navigate the HTTP application, maybe it will program the bluetooth port!'),(10,'Toney_Huel56','Anita_Skiles@yahoo.com',''),(11,'Shemar_Schultz12','Zella14@yahoo.com',''),(12,'Monty.Nienow','Dean19@yahoo.com','I\'ll calculate the multi-byte GB pixel, that should matrix the AI panel!'),(13,'Vanessa_Legros','Fidel85@gmail.com','navigating the bus won\'t do anything, we need to program the mobile SAS bus!'),(14,'Claire9','Rosina_Balistreri@gmail.com','We need to copy the 1080p FTP feed!');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-12 19:30:15
