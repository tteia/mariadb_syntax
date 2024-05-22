-- MariaDB dump 10.19-11.3.2-MariaDB, for osx10.18 (arm64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `porfile_image` blob DEFAULT NULL,
  `profile_photo` longblob DEFAULT NULL,
  `ROLE` enum('admin','myuser','user') NOT NULL DEFAULT 'myuser',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'hello','hello1@test.com',NULL,NULL,24,NULL,NULL,'user',NULL,NULL,0),
(2,'hello','hello2@test.com',NULL,NULL,30,NULL,NULL,'user',NULL,NULL,0),
(3,'hello','hello3@test.com',NULL,NULL,25,NULL,NULL,'user',NULL,NULL,0),
(4,'hello','hello4@test.com',NULL,NULL,26,NULL,NULL,'myuser',NULL,'2024-05-17 17:26:31',0),
(5,'홍길동','hello5test.com',NULL,NULL,125,NULL,NULL,'user',NULL,NULL,0),
(6,'홍길동','hello6@test.com',NULL,NULL,200,NULL,NULL,'user',NULL,NULL,0),
(45,'kim','kim@test.com',NULL,NULL,32,NULL,NULL,'myuser',NULL,'2024-05-20 15:39:00',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hamin','hello world',3,500.000,NULL,'0aad59f2-141f-11ef-8cc5-82d9695c8b73'),
(3,'hamin','hamin world',3,3000.000,'2023-01-01 23:11:32','0aad5e20-141f-11ef-8cc5-82d9695c8b73'),
(6,'hello java',NULL,4,1200.000,NULL,'0aad6028-141f-11ef-8cc5-82d9695c8b73'),
(7,'hello',NULL,2,900.000,'1999-01-01 23:11:32','0aad60b4-141f-11ef-8cc5-82d9695c8b73'),
(8,'hello','hello world',1,4200.000,'2024-05-17 16:15:04','0aad6118-141f-11ef-8cc5-82d9695c8b73'),
(9,'abc',NULL,2,3420.000,'2022-05-17 16:28:39','1535989e-141f-11ef-8cc5-82d9695c8b73'),
(20,'yejun','yejun world',1,500.000,NULL,'0aad5d94-141f-11ef-8cc5-82d9695c8b73'),
(21,'hello world java',NULL,5,300.000,'2024-05-20 12:33:40','c1ca4e88-1659-11ef-8cc5-82d9695c8b73');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:19:15
