-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: melotune
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `albumes`
--

DROP TABLE IF EXISTS `albumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `artista_nombre` varchar(200) DEFAULT NULL,
  `artista_id` int(11) NOT NULL,
  `fecha_lanzamiento` date DEFAULT NULL,
  `genero` varchar(100) DEFAULT NULL,
  `portada` varchar(255) DEFAULT NULL,
  `imagen_url` varchar(500) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `discografica` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_titulo` (`titulo`),
  KEY `idx_artista` (`artista_id`),
  CONSTRAINT `albumes_ibfk_1` FOREIGN KEY (`artista_id`) REFERENCES `artistas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albumes`
--

LOCK TABLES `albumes` WRITE;
/*!40000 ALTER TABLE `albumes` DISABLE KEYS */;
INSERT INTO `albumes` VALUES (1,'Oracular Spectacular',NULL,1,'2007-10-02','Indie Pop','https://lastfm.freetls.fastly.net/i/u/300x300/32774a8d1143a4a7087f4a18d5e2ede2.png','https://lastfm.freetls.fastly.net/i/u/300x300/32774a8d1143a4a7087f4a18d5e2ede2.png',2419,'Columbia Records',NULL),(2,'I Love You.',NULL,2,'2013-04-22','Indie Rock','https://upload.wikimedia.org/wikipedia/en/2/2f/Iloveyou_the_neighbourhood.jpeg','https://upload.wikimedia.org/wikipedia/en/2/2f/Iloveyou_the_neighbourhood.jpeg',2745,'Columbia Records',NULL),(3,'Take Care',NULL,3,'2011-11-15','Hip-Hop / R&B','https://lastfm.freetls.fastly.net/i/u/300x300/87079d08fe90541db827b7ddd08a30c7.png','https://lastfm.freetls.fastly.net/i/u/300x300/87079d08fe90541db827b7ddd08a30c7.png',4814,'Young Money',NULL),(4,'Currents',NULL,4,'2015-07-17','Psychedelic Pop','https://lastfm.freetls.fastly.net/i/u/300x300/dd45b0438a315aed98b5830aa2fc43c5.png','https://lastfm.freetls.fastly.net/i/u/300x300/dd45b0438a315aed98b5830aa2fc43c5.png',3060,'Modular Recordings',NULL),(5,'Blonde',NULL,5,'2016-08-20','R&B / Art Pop','https://lastfm.freetls.fastly.net/i/u/300x300/82c92f044b27db86328ed6be3f8a735a.png','https://lastfm.freetls.fastly.net/i/u/300x300/82c92f044b27db86328ed6be3f8a735a.png',3600,'Boys Don\'t Cry',NULL),(6,'good kid, m.A.A.d city',NULL,6,'2012-10-22','Conscious Rap','https://lastfm.freetls.fastly.net/i/u/300x300/48628c6af67db437b0b9ff156b2c1085.png','https://lastfm.freetls.fastly.net/i/u/300x300/48628c6af67db437b0b9ff156b2c1085.png',4084,'Top Dawg Entertainment',NULL),(7,'Little Dark Age',NULL,1,'2018-02-09','Synth-pop','https://lastfm.freetls.fastly.net/i/u/300x300/28700d076e5afb3bc0fba47ab8e71975.png','https://lastfm.freetls.fastly.net/i/u/300x300/28700d076e5afb3bc0fba47ab8e71975.png',2652,'Columbia Records',NULL),(8,'(What\'s the Story) Morning Glory?','Oasis',7,NULL,NULL,'https://lastfm.freetls.fastly.net/i/u/300x300/1b217359e775a8b6a7bc443abe5b08c2.png','https://lastfm.freetls.fastly.net/i/u/300x300/1b217359e775a8b6a7bc443abe5b08c2.png',NULL,NULL,NULL),(9,'Honestly, Nevermind','Drake',3,NULL,NULL,'https://lastfm.freetls.fastly.net/i/u/300x300/7d3763be1d113c617dcf65cff320b2ab.png','https://lastfm.freetls.fastly.net/i/u/300x300/7d3763be1d113c617dcf65cff320b2ab.png',NULL,NULL,NULL),(10,'The New Abnormal','The Strokes',8,NULL,NULL,'https://lastfm.freetls.fastly.net/i/u/300x300/576554c542da76c08f0e80c129afcb0e.png','https://lastfm.freetls.fastly.net/i/u/300x300/576554c542da76c08f0e80c129afcb0e.png',NULL,NULL,NULL),(11,'We Broke The Rules','Aventura',9,NULL,NULL,'https://lastfm.freetls.fastly.net/i/u/300x300/d076e67e821cb4b812de7fc043c693c7.png','https://lastfm.freetls.fastly.net/i/u/300x300/d076e67e821cb4b812de7fc043c693c7.png',NULL,NULL,NULL),(12,'Thriller','Michael Jackson',10,NULL,NULL,'https://lastfm.freetls.fastly.net/i/u/300x300/a6a876bd5f927ac2ca5b72a4826f62c7.jpg','https://lastfm.freetls.fastly.net/i/u/300x300/a6a876bd5f927ac2ca5b72a4826f62c7.jpg',NULL,NULL,NULL),(13,'Romances','Luis Miguel',11,NULL,NULL,'https://lastfm.freetls.fastly.net/i/u/300x300/6ae06384aeac2ab4fb105c4e5fa4ef73.jpg','https://lastfm.freetls.fastly.net/i/u/300x300/6ae06384aeac2ab4fb105c4e5fa4ef73.jpg',NULL,NULL,NULL),(14,'Whatever People Say I Am, That\'s What I\'m Not','Arctic Monkeys',12,NULL,NULL,'https://lastfm.freetls.fastly.net/i/u/300x300/dd7a29bece21e078dd3e602d9d8f8fd3.png','https://lastfm.freetls.fastly.net/i/u/300x300/dd7a29bece21e078dd3e602d9d8f8fd3.png',NULL,NULL,NULL);
/*!40000 ALTER TABLE `albumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artistas`
--

DROP TABLE IF EXISTS `artistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artistas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `biografia` text DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `genero` varchar(100) DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artistas`
--

LOCK TABLES `artistas` WRITE;
/*!40000 ALTER TABLE `artistas` DISABLE KEYS */;
INSERT INTO `artistas` VALUES (1,'MGMT','Banda de rock indie y pop psicod├®lico de Estados Unidos, formada en 2002.',NULL,'Indie Pop / Psychedelic Rock','Estados Unidos',NULL),(2,'The Neighbourhood','Banda de rock alternativo estadounidense conocida por su est├®tica visual en blanco y negro.',NULL,'Indie Rock / Alternative','Estados Unidos',NULL),(3,'Drake','Rapero, cantante, compositor y actor canadiense.',NULL,'Hip-Hop / R&B','Canad├í',NULL),(4,'Tame Impala','Proyecto musical de psicodelia creado por el multinstrumentista australiano Kevin Parker.',NULL,'Psychedelic Pop / Neo-psychedelia','Australia',NULL),(5,'Frank Ocean','Cantante, compositor y rapero estadounidense galardonado que mezcla R&B introspectivo.',NULL,'R&B / Art Pop','Estados Unidos',NULL),(6,'Kendrick Lamar','Aclamado rapero y compositor estadounidense conocido por sus letras complejas e impacto cultural.',NULL,'Hip-Hop / Conscious Rap','Estados Unidos',NULL),(7,'Oasis',NULL,NULL,NULL,NULL,NULL),(8,'The Strokes',NULL,NULL,NULL,NULL,NULL),(9,'Aventura',NULL,NULL,NULL,NULL,NULL),(10,'Michael Jackson',NULL,NULL,NULL,NULL,NULL),(11,'Luis Miguel',NULL,NULL,NULL,NULL,NULL),(12,'Arctic Monkeys',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `artistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canciones`
--

DROP TABLE IF EXISTS `canciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `album_id` int(11) DEFAULT NULL,
  `artista_id` int(11) NOT NULL,
  `duracion` int(11) DEFAULT NULL,
  `numero_pista` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `artista_id` (`artista_id`),
  KEY `idx_titulo` (`titulo`),
  KEY `idx_album` (`album_id`),
  CONSTRAINT `canciones_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `albumes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `canciones_ibfk_2` FOREIGN KEY (`artista_id`) REFERENCES `artistas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canciones`
--

LOCK TABLES `canciones` WRITE;
/*!40000 ALTER TABLE `canciones` DISABLE KEYS */;
INSERT INTO `canciones` VALUES (1,'Time to Pretend',1,1,261,1),(2,'Kids',1,1,302,5),(3,'Sweater Weather',2,2,240,3),(4,'Marvins Room',3,3,327,7),(5,'Let It Happen',4,4,467,1),(6,'The Less I Know The Better',4,4,216,7),(7,'Nikes',5,5,314,1),(8,'Nights',5,5,307,9),(9,'Money Trees',6,6,386,5),(10,'m.A.A.d city',6,6,350,8);
/*!40000 ALTER TABLE `canciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_albums`
--

DROP TABLE IF EXISTS `favorite_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorite_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `album_titulo` varchar(200) NOT NULL,
  `album_artista` varchar(200) NOT NULL,
  `album_portada` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_favorite_unique` (`usuario_id`,`album_titulo`,`album_artista`),
  CONSTRAINT `favorite_albums_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_albums`
--

LOCK TABLES `favorite_albums` WRITE;
/*!40000 ALTER TABLE `favorite_albums` DISABLE KEYS */;
INSERT INTO `favorite_albums` VALUES (1,6,'Honestly, Nevermind','Drake','https://lastfm.freetls.fastly.net/i/u/300x300/7d3763be1d113c617dcf65cff320b2ab.jpg','2026-04-29 21:55:40'),(2,6,'(What\'s the Story) Morning Glory?','Oasis','https://lastfm.freetls.fastly.net/i/u/300x300/1b217359e775a8b6a7bc443abe5b08c2.jpg','2026-04-29 21:58:17'),(3,6,'Thriller','Michael Jackson','https://lastfm.freetls.fastly.net/i/u/300x300/a6a876bd5f927ac2ca5b72a4826f62c7.jpg','2026-04-29 21:58:45'),(4,15,'I Love You.','The Neighbourhood','https://lastfm.freetls.fastly.net/i/u/300x300/d787d7eb7324e25dfb03dd9c0220d818.png','2026-04-29 22:01:13'),(5,15,'Honestly, Nevermind','Drake','https://lastfm.freetls.fastly.net/i/u/300x300/7d3763be1d113c617dcf65cff320b2ab.jpg','2026-04-29 22:01:19'),(6,6,'Romances','Luis Miguel','https://lastfm.freetls.fastly.net/i/u/300x300/6ae06384aeac2ab4fb105c4e5fa4ef73.jpg','2026-04-29 22:17:19'),(8,6,'Little Dark Age','MGMT','https://lastfm.freetls.fastly.net/i/u/300x300/28700d076e5afb3bc0fba47ab8e71975.png','2026-05-05 21:30:17');
/*!40000 ALTER TABLE `favorite_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_artists`
--

DROP TABLE IF EXISTS `favorite_artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorite_artists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `artist_nombre` varchar(200) NOT NULL,
  `artist_imagen` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_favorite_artist_unique` (`usuario_id`,`artist_nombre`),
  CONSTRAINT `favorite_artists_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_artists`
--

LOCK TABLES `favorite_artists` WRITE;
/*!40000 ALTER TABLE `favorite_artists` DISABLE KEYS */;
INSERT INTO `favorite_artists` VALUES (1,6,'Kendrick Lamar','https://i.scdn.co/image/ab6761610000e5eb39ba6dcd4355c03de0b50918'),(2,6,'Kanye West','https://i.scdn.co/image/ab6761610000e5eb6e835a500e791bf9c27a422a');
/*!40000 ALTER TABLE `favorite_artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `follower_id` int(10) unsigned NOT NULL,
  `following_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers`
--

LOCK TABLES `followers` WRITE;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` VALUES (1,6,15,'2026-05-05 19:25:20','2026-05-05 19:25:20'),(2,15,6,'2026-05-06 08:10:58','2026-05-06 08:10:58');
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_reviews_albumes`
--

DROP TABLE IF EXISTS `likes_reviews_albumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes_reviews_albumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_like` (`usuario_id`,`review_id`),
  KEY `review_id` (`review_id`),
  CONSTRAINT `likes_reviews_albumes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `likes_reviews_albumes_ibfk_2` FOREIGN KEY (`review_id`) REFERENCES `reviews_albumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_reviews_albumes`
--

LOCK TABLES `likes_reviews_albumes` WRITE;
/*!40000 ALTER TABLE `likes_reviews_albumes` DISABLE KEYS */;
INSERT INTO `likes_reviews_albumes` VALUES (1,2,1,'2026-03-20 12:01:08'),(2,3,1,'2026-03-20 12:01:08'),(3,4,1,'2026-03-20 12:01:08'),(4,1,2,'2026-03-20 12:01:08'),(5,3,2,'2026-03-20 12:01:08'),(6,1,3,'2026-03-20 12:01:08'),(7,2,3,'2026-03-20 12:01:08'),(8,4,3,'2026-03-20 12:01:08'),(10,6,6,'2026-04-14 17:34:39'),(11,6,8,'2026-04-15 09:17:43'),(12,6,9,'2026-04-16 18:34:08'),(13,6,60,'2026-04-22 12:41:50'),(14,6,5,'2026-04-29 09:18:03'),(15,6,10,'2026-04-29 09:26:48'),(16,15,61,'2026-04-29 09:56:43'),(17,6,62,'2026-04-29 11:12:05'),(18,6,64,'2026-05-05 19:51:08'),(19,6,65,'2026-05-06 08:05:32'),(20,6,61,'2026-05-06 08:05:37');
/*!40000 ALTER TABLE `likes_reviews_albumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listas`
--

DROP TABLE IF EXISTS `listas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `listas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `publica` tinyint(1) DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_usuario` (`usuario_id`),
  CONSTRAINT `listas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listas`
--

LOCK TABLES `listas` WRITE;
/*!40000 ALTER TABLE `listas` DISABLE KEYS */;
INSERT INTO `listas` VALUES (1,1,'Top 2010s','Mis discos favoritos de la d├®cada de los 2010s',1,'2026-03-20 12:01:08'),(2,2,'Joyas Ocultas del Indie','Discos que tienes que escuchar',1,'2026-03-20 12:01:08');
/*!40000 ALTER TABLE `listas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listas_albumes`
--

DROP TABLE IF EXISTS `listas_albumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `listas_albumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lista_id` int(11) NOT NULL,
  `album_id` int(11) NOT NULL,
  `orden` int(11) DEFAULT 0,
  `fecha_agregado` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_lista_album` (`lista_id`,`album_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `listas_albumes_ibfk_1` FOREIGN KEY (`lista_id`) REFERENCES `listas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `listas_albumes_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `albumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listas_albumes`
--

LOCK TABLES `listas_albumes` WRITE;
/*!40000 ALTER TABLE `listas_albumes` DISABLE KEYS */;
INSERT INTO `listas_albumes` VALUES (1,1,4,1,'2026-03-20 12:01:08'),(2,1,5,2,'2026-03-20 12:01:08'),(3,1,6,3,'2026-03-20 12:01:08'),(4,2,1,1,'2026-03-20 12:01:08'),(5,2,2,2,'2026-03-20 12:01:08');
/*!40000 ALTER TABLE `listas_albumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2019_12_14_000001_create_personal_access_tokens_table',1),(2,'2026_03_11_100000_create_usuarios_table',1),(3,'2026_03_11_100001_create_artistas_table',1),(4,'2026_03_11_100002_create_albumes_table',1),(5,'2026_03_11_100003_create_canciones_table',1),(6,'2026_03_11_100004_create_reviews_albumes_table',1),(7,'2026_03_11_100005_create_reviews_canciones_table',1),(8,'2026_03_11_100006_create_listas_table',1),(9,'2026_03_11_100007_create_listas_albumes_table',1),(10,'2026_03_11_100008_create_seguimientos_table',1),(11,'2026_03_11_100009_create_likes_reviews_albumes_table',1),(13,'2026_04_14_111733_add_verification_token_to_usuarios_table',2),(14,'2026_04_14_191447_add_extra_fields_to_reviews_albumes_table',3),(15,'2026_04_14_204548_create_saved_albums_table',4),(17,'2026_04_14_205343_create_favorite_albums_table',5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',5,'auth_token','2a1b3e367c4faa63f3bf484115d38662da400fa8c024e26df6ee38d3b3af834e','[\"*\"]',NULL,NULL,'2026-04-14 08:38:52','2026-04-14 08:38:52'),(14,'App\\Models\\User',5,'auth_token','23cca3e53924694cf3b81b5f3d3eb59847a927f8541fada598035cbfb53c1aea','[\"*\"]','2026-04-28 17:47:35',NULL,'2026-04-28 17:47:23','2026-04-28 17:47:35'),(27,'App\\Models\\User',6,'auth_token','2400a850192100d480a7eeeffc488496132070e6350951dd73ae3b0d9ba58192','[\"*\"]','2026-05-06 08:31:45',NULL,'2026-05-06 08:12:08','2026-05-06 08:31:45');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_albumes`
--

DROP TABLE IF EXISTS `reviews_albumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews_albumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `album_id` int(11) NOT NULL,
  `calificacion` decimal(2,1) DEFAULT NULL CHECK (`calificacion` >= 0.5 and `calificacion` <= 5.0),
  `titulo` varchar(200) DEFAULT NULL,
  `contenido` text DEFAULT NULL,
  `etiquetas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`etiquetas`)),
  `encuesta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`encuesta`)),
  `preguntas_guia` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`preguntas_guia`)),
  `contexto_escucha` varchar(100) DEFAULT NULL,
  `cancion_favorita` varchar(200) DEFAULT NULL,
  `vibe_factor` tinyint(4) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_modificacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `likes` int(11) DEFAULT 0,
  `evolucion` varchar(20) DEFAULT NULL,
  `primera_mencion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_album` (`usuario_id`,`album_id`),
  KEY `idx_usuario` (`usuario_id`),
  KEY `idx_album` (`album_id`),
  KEY `idx_calificacion` (`calificacion`),
  CONSTRAINT `reviews_albumes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_albumes_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `albumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews_albumes`
--

LOCK TABLES `reviews_albumes` WRITE;
/*!40000 ALTER TABLE `reviews_albumes` DISABLE KEYS */;
INSERT INTO `reviews_albumes` VALUES (1,1,4,5.0,'Una obra maestra de la psicodelia moderna','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.',NULL,NULL,NULL,NULL,NULL,NULL,'2026-03-20 12:01:08','2026-04-22 09:48:09',42,NULL,NULL),(2,2,5,4.8,'Intimidad en forma de ├ílbum','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.',NULL,NULL,NULL,NULL,NULL,NULL,'2026-03-20 12:01:08','2026-04-22 09:48:09',67,NULL,NULL),(3,3,6,4.8,'El mejor ├ílbum conceptual de rap','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.',NULL,NULL,NULL,NULL,NULL,NULL,'2026-03-20 12:01:08','2026-04-22 09:48:09',89,NULL,NULL),(4,1,1,4.4,'Un cl├ísico Indie','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.',NULL,NULL,NULL,NULL,NULL,NULL,'2026-03-20 12:01:08','2026-04-22 09:48:09',15,NULL,NULL),(5,1,5,5.0,'Intimidad en forma de ├ílbum','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','\"[\\\"Letras profundas\\\",\\\"Emotivo\\\",\\\"Experimental\\\"]\"','\"{\\\"lyricsLiked\\\":true,\\\"listenAgain\\\":true,\\\"recommend\\\":true}\"',NULL,'Auriculares / Noche','Nights',30,'2026-04-14 19:22:24','2026-04-29 11:18:03',68,NULL,NULL),(6,1,6,5.0,'El mejor ├ílbum conceptual de rap','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','\"[\\\"Obra maestra\\\",\\\"Letras profundas\\\",\\\"Album conceptual\\\"]\"','\"{\\\"lyricsLiked\\\":true,\\\"listenAgain\\\":true,\\\"recommend\\\":true}\"',NULL,'Altavoces / D├¡a','Money Trees',50,'2026-04-14 19:22:24','2026-04-22 09:48:09',90,NULL,NULL),(7,1,3,4.0,'El rap emocional en su punto m├ís alto','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','\"[\\\"Emotivo\\\",\\\"Para la noche\\\"]\"','\"{\\\"lyricsLiked\\\":true,\\\"listenAgain\\\":false,\\\"recommend\\\":true}\"',NULL,'Auriculares / Noche','Marvins Room',25,'2026-04-14 19:22:24','2026-04-22 09:48:09',45,NULL,NULL),(8,6,8,5.0,'Certificado de nacimiento del britpop','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Letras profundas\",\"Obra maestra\",\"Nost\\u00e1lgico\"]','{\"lyricsLiked\":true,\"listenAgain\":true,\"recommend\":true,\"vibeFactor\":100}','{\"favSong\":\"Dont look back in anger\",\"emotions\":\"euforia\",\"recommend\":\"a todos\"}','Altavoces / D├¡a','Dont look back in anger',100,'2026-04-14 19:34:00','2026-04-22 09:48:09',1,NULL,NULL),(9,6,9,5.0,'Un mirada al house desde el rap','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Producci\\u00f3n incre\\u00edble\",\"Letras profundas\",\"Buenas vibras\",\"Relajante\"]','{\"lyricsLiked\":true,\"listenAgain\":true,\"recommend\":true,\"vibeFactor\":100}','{\"favSong\":\"Massive\",\"emotions\":\"verano\",\"recommend\":\"a todos los amantes del house\"}','Coche / D├¡a','Massive',100,'2026-04-14 20:42:36','2026-04-22 09:48:09',1,NULL,NULL),(10,6,10,4.0,'Una gloriosa carta de despedida','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Producci\\u00f3n incre\\u00edble\",\"Obra maestra\",\"Para llorar\",\"Experimental\"]','{\"lyricsLiked\":true,\"listenAgain\":true,\"recommend\":true,\"vibeFactor\":95}','{\"favSong\":\"Ode to the mets\",\"emotions\":\"nostalgia\",\"recommend\":\"a los indies\"}','Auriculares / Noche','Ode to the mets',95,'2026-04-14 20:52:08','2026-04-29 11:26:48',1,NULL,NULL),(11,15,11,3.0,'Bachatita','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Letras profundas\",\"Bailable\",\"Relajante\"]','{\"lyricsLiked\":true,\"listenAgain\":false,\"recommend\":true,\"vibeFactor\":0}','{\"favSong\":\"Obsesion\",\"emotions\":\"verano\",\"recommend\":\"a todos\"}','Altavoces / D├¡a','Obsesion',0,'2026-04-15 10:14:39','2026-04-22 09:48:09',0,NULL,NULL),(12,76,5,2.9,'Dolore labore aliquid dolor aperiam quis.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\",\"Concepto profundo\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Aperiam a pariatur et.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','fugiat eos quo',2,'2025-11-13 21:04:17','2026-04-22 09:48:09',32,NULL,NULL),(13,77,7,3.1,'Earum ad non sed quos.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Sint consectetur omnis.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','necessitatibus sit doloremque',5,'2025-08-28 00:23:08','2026-04-22 09:48:09',30,NULL,NULL),(14,77,3,2.1,'Incidunt nihil quo voluptas.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Experimental\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Sed est iste.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','doloribus libero ipsum',3,'2026-01-22 22:38:22','2026-04-22 09:48:09',37,NULL,NULL),(15,77,6,1.5,'Dolor ad veritatis.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Cl\\u00e1sico moderno\",\"Vibras de verano\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Totam repellendus inventore eveniet.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','eum atque aliquam',1,'2025-11-17 14:07:13','2026-04-22 09:48:09',48,NULL,NULL),(16,78,5,4.7,'Veniam nemo consequatur libero.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Concepto profundo\",\"Vibras de verano\",\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Voluptatem molestiae incidunt ut.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','iusto expedita provident',4,'2025-09-11 00:43:40','2026-04-22 09:48:09',11,NULL,NULL),(17,78,3,2.0,'Vitae officiis autem quisquam.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Producci\\u00f3n incre\\u00edble\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Delectus et quas sit.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','facilis doloremque ut',4,'2026-04-09 15:31:53','2026-04-22 09:48:09',32,NULL,NULL),(18,79,9,1.0,'Sit voluptas saepe ut et.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Para llorar\",\"Voz angelical\",\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Optio dolor incidunt.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','soluta consequatur ipsam',2,'2025-05-09 23:25:19','2026-04-22 09:48:09',10,NULL,NULL),(19,80,10,1.8,'Nemo consequatur aut mollitia.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Concepto profundo\",\"Cl\\u00e1sico moderno\",\"Obra maestra\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Laborum sit omnis fugit.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','consequatur molestiae aut',4,'2026-01-25 07:05:57','2026-04-22 09:48:09',36,NULL,NULL),(20,80,9,1.8,'Ut fuga dolores omnis est.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\",\"Vibras de verano\",\"Concepto profundo\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Sit eaque.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','ipsum quis et',5,'2026-01-11 22:33:39','2026-04-22 09:48:09',24,NULL,NULL),(21,81,6,1.4,'Porro quas et non.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Vibras de verano\",\"Para llorar\",\"Producci\\u00f3n incre\\u00edble\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Maiores aperiam incidunt.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','quaerat molestias consequatur',3,'2025-07-09 07:46:42','2026-04-22 09:48:09',50,NULL,NULL),(22,81,9,1.7,'Explicabo voluptatem facere.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Concepto profundo\",\"Obra maestra\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Laborum minus in.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','autem aspernatur et',2,'2025-08-20 23:46:59','2026-04-22 09:48:09',4,NULL,NULL),(23,81,4,1.9,'Dolorem nihil et fugiat ducimus.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Concepto profundo\",\"Obra maestra\",\"Para llorar\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Dolore voluptas ut ad.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','possimus aut est',4,'2025-12-08 06:32:43','2026-04-22 09:48:09',25,NULL,NULL),(24,82,8,4.7,'Sed et fugiat.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Para llorar\",\"Producci\\u00f3n incre\\u00edble\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Eum veniam nesciunt et.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','qui voluptatum amet',3,'2025-09-16 19:36:48','2026-04-22 09:48:09',33,NULL,NULL),(25,82,4,3.2,'Molestiae est unde doloremque incidunt.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Eos ut aspernatur doloremque.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','dolorem voluptatem est',4,'2026-03-14 08:14:07','2026-04-22 09:48:09',20,NULL,NULL),(27,91,7,1.1,'Aspernatur cumque reiciendis quia dolor dolor.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Vibras de verano\",\"Obra maestra\",\"Experimental\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Et totam quisquam aut.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','rerum rerum ut',3,'2025-06-29 17:30:58','2026-04-22 09:48:09',18,NULL,NULL),(28,91,4,3.8,'Illo enim quo.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Experimental\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Officiis tempora debitis distinctio.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','aut itaque ea',5,'2025-10-14 07:00:03','2026-04-22 09:48:09',50,NULL,NULL),(29,92,9,1.6,'Ut libero et eum eum voluptas.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\",\"Producci\\u00f3n incre\\u00edble\",\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Sequi vitae magnam molestiae.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','dolores voluptatibus qui',1,'2026-01-23 00:01:24','2026-04-22 09:48:09',38,NULL,NULL),(30,92,2,3.2,'Nostrum sint accusantium ut voluptas sed.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Concepto profundo\",\"Vibras de verano\",\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Vitae praesentium non.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','rem voluptatum sapiente',4,'2025-05-26 21:44:44','2026-04-22 09:48:09',43,NULL,NULL),(31,93,10,4.7,'Ipsum laboriosam optio aut.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Para llorar\",\"Concepto profundo\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Nihil qui non.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','accusamus ab fugit',5,'2026-01-08 13:41:00','2026-04-22 09:48:09',40,NULL,NULL),(32,93,6,3.5,'Non saepe commodi ullam sequi modi.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Vibras de verano\",\"Producci\\u00f3n incre\\u00edble\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Dolorem velit dolorem quaerat.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','perspiciatis ut autem',5,'2026-04-09 03:01:15','2026-04-22 09:48:09',30,NULL,NULL),(33,93,9,2.0,'Cupiditate est ut minima deleniti.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Experimental\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Quis aliquam odio incidunt.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','labore sit molestiae',1,'2025-06-29 03:43:50','2026-04-22 09:48:09',45,NULL,NULL),(34,94,7,3.1,'Ad aut atque quisquam ipsam.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Experimental\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Error pariatur earum perspiciatis.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','quis id veniam',2,'2025-05-10 11:38:03','2026-04-22 09:48:09',35,NULL,NULL),(35,94,3,1.2,'Vero veritatis modi sint.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Cl\\u00e1sico moderno\",\"Concepto profundo\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Placeat omnis temporibus temporibus illo.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','aut nihil nam',2,'2025-06-19 03:21:10','2026-04-22 09:48:09',17,NULL,NULL),(36,94,2,3.9,'Delectus ad voluptatum ut nihil.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\",\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Placeat animi facere mollitia.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','impedit libero sapiente',2,'2026-03-22 01:33:59','2026-04-22 09:48:09',12,NULL,NULL),(37,94,4,3.8,'Nobis repellendus repudiandae.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Producci\\u00f3n incre\\u00edble\",\"Vibras de verano\",\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"At recusandae quo.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','quod porro nesciunt',1,'2026-03-20 21:17:09','2026-04-22 09:48:09',50,NULL,NULL),(38,95,11,2.0,'Unde laboriosam quae est ratione ipsum.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Cl\\u00e1sico moderno\",\"Para llorar\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Est similique voluptatibus esse.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','ex maxime quo',2,'2025-09-25 16:18:30','2026-04-22 09:48:09',17,NULL,NULL),(39,95,2,4.5,'Ut esse totam ullam vel.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Para llorar\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Non facere aut.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','cum voluptate saepe',5,'2026-03-20 17:12:02','2026-04-22 09:48:09',47,NULL,NULL),(40,96,10,2.8,'Non velit doloribus voluptas ut aut.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Producci\\u00f3n incre\\u00edble\",\"Concepto profundo\",\"Voz angelical\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Possimus soluta veniam.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','qui laudantium iste',5,'2025-09-21 11:53:47','2026-04-22 09:48:09',39,NULL,NULL),(41,97,11,1.1,'Aut ut velit sed aperiam.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Producci\\u00f3n incre\\u00edble\",\"Vibras de verano\",\"Obra maestra\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Enim ratione quis vitae.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','nihil commodi facere',2,'2025-06-20 01:37:11','2026-04-22 09:48:09',17,NULL,NULL),(42,98,1,2.3,'Nisi corporis doloremque quis debitis.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\",\"Producci\\u00f3n incre\\u00edble\",\"Obra maestra\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Soluta adipisci tenetur.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','sint doloribus accusamus',2,'2025-06-19 14:19:45','2026-04-22 09:48:09',9,NULL,NULL),(43,98,6,3.3,'Amet quae omnis quo itaque.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Vibras de verano\",\"Obra maestra\",\"Concepto profundo\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Rem fugit.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','qui repudiandae ullam',2,'2025-07-27 09:24:12','2026-04-22 09:48:09',23,NULL,NULL),(44,98,4,4.7,'Inventore reprehenderit facere saepe animi.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Experimental\",\"Vibras de verano\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Dolore neque maxime.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','ullam tempore ducimus',5,'2025-12-08 19:25:47','2026-04-22 09:48:09',34,NULL,NULL),(45,99,6,4.7,'Cum occaecati animi ipsam quo.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Concepto profundo\",\"Para llorar\",\"Voz angelical\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Eaque sed in.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','corrupti praesentium voluptatibus',4,'2025-10-29 14:27:54','2026-04-22 09:48:09',5,NULL,NULL),(46,99,2,2.6,'Nam ipsam beatae unde molestias voluptatum.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Nihil consequatur asperiores porro perspiciatis.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','natus id quasi',4,'2025-10-03 21:02:22','2026-04-22 09:48:09',14,NULL,NULL),(47,99,8,1.3,'Nam aliquam inventore.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Para llorar\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Ab optio placeat.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','velit perferendis deserunt',3,'2025-07-09 15:09:19','2026-04-22 09:48:09',10,NULL,NULL),(48,100,8,3.8,'Distinctio ipsa corporis cum.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\",\"Experimental\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Voluptas enim veniam minima reprehenderit.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','iste omnis omnis',2,'2025-06-17 04:00:39','2026-04-22 09:48:09',38,NULL,NULL),(49,101,5,1.5,'Et cumque eaque cum nesciunt optio.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Experimental\",\"Cl\\u00e1sico moderno\",\"Para llorar\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Facere odit similique.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','voluptatem velit officiis',2,'2025-09-20 18:14:07','2026-04-22 09:48:09',2,NULL,NULL),(50,102,9,4.0,'Quia quam sed libero consequatur omnis.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Vibras de verano\",\"Obra maestra\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Nemo autem qui.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','asperiores accusamus minima',1,'2025-09-24 21:35:40','2026-04-22 09:48:09',16,NULL,NULL),(51,103,7,2.0,'Dolor totam qui eos dolore.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Cl\\u00e1sico moderno\",\"Concepto profundo\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Ut voluptate.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','totam deleniti et',4,'2026-01-31 12:51:41','2026-04-22 09:48:09',50,NULL,NULL),(52,103,9,2.4,'Nihil ut occaecati quia.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Obra maestra\",\"Vibras de verano\",\"Voz angelical\"]','{\"recomendarias\":true,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Ullam aut.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','ipsum dolorum quas',5,'2025-10-27 08:23:32','2026-04-22 09:48:09',2,NULL,NULL),(53,103,5,2.7,'Temporibus quisquam rerum tempore quas consequatur.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Producci\\u00f3n incre\\u00edble\",\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Facilis dolorem incidunt.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','consectetur eos eligendi',2,'2025-09-24 17:41:10','2026-04-22 09:48:09',49,NULL,NULL),(54,103,4,2.8,'Perferendis rerum consequatur harum eligendi.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Producci\\u00f3n incre\\u00edble\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Sed nulla ab corrupti.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','impedit aut debitis',4,'2025-11-16 05:36:14','2026-04-22 09:48:09',45,NULL,NULL),(55,104,3,1.4,'Qui consequatur est est laudantium.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\"]','{\"recomendarias\":false,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Quis qui sint cum et.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','rem sunt numquam',5,'2026-02-08 17:16:50','2026-04-22 09:48:09',32,NULL,NULL),(56,105,5,4.5,'Impedit voluptatem ut nulla necessitatibus animi.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Obra maestra\",\"Para llorar\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Et expedita non.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','repellendus quia voluptas',4,'2025-05-30 19:11:14','2026-04-22 09:48:09',25,NULL,NULL),(57,105,1,4.2,'Sed enim fugit atque.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Voz angelical\"]','{\"recomendarias\":true,\"reproduccion_repetida\":false}','{\"cancion_destacada\":\"Corporis itaque ea odio.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','est quod molestiae',5,'2026-03-27 18:44:56','2026-04-22 09:48:09',36,NULL,NULL),(58,105,4,4.9,'Distinctio porro architecto ipsam.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Vibras de verano\",\"Experimental\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Labore ducimus rem.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','iste autem quidem',1,'2025-09-16 13:11:25','2026-04-22 09:48:09',0,NULL,NULL),(59,105,3,3.1,'Rerum exercitationem consequuntur quas.','Un ├ílbum incre├¡ble que marca un antes y un despu├®s en su g├®nero. La producci├│n es impecable y las letras conectan profundamente con el oyente. Definitivamente una obra maestra que recomendar├¡a a cualquier amante de la buena m├║sica.','[\"Obra maestra\",\"Cl\\u00e1sico moderno\"]','{\"recomendarias\":false,\"reproduccion_repetida\":true}','{\"cancion_destacada\":\"Aut fugiat et.\",\"momento_escucha\":\"Por la ma\\u00f1ana\"}','En casa con auriculares','vero nostrum sint',4,'2025-09-19 02:40:43','2026-04-22 09:48:09',39,NULL,NULL),(60,6,2,5.0,'me encanta','aaaaa','[\"Letras profundas\",\"Relajante\",\"Energ\\u00e9tico\"]','{\"lyricsLiked\":null,\"listenAgain\":null,\"recommend\":null,\"vibeFactor\":50}','{\"favSong\":null,\"emotions\":null,\"recommend\":null}','Altavoces / D├¡a',NULL,50,'2026-04-22 12:13:44','2026-04-22 14:41:50',1,NULL,NULL),(61,15,12,5.0,'El d├¡a que Michael Jackson detuvo el mundo','Decir que Thriller (1982) es el \"├ílbum m├ís vendido de la historia\" es casi quedarse corto; es el manual de instrucciones del pop moderno. Bajo la producci├│n quir├║rgica de Quincy Jones, Michael Jackson no solo grab├│ canciones, dise├▒├│ artefactos sonoros que, d├®cadas despu├®s, no tienen ni una sola arruga.\n\nEl sonido de la perfecci├│n\nEl ├ílbum es un ejercicio de equilibrio imposible. Tienes la paranoia r├¡tmica de \"Billie Jean\", con esa l├¡nea de bajo que es, probablemente, la m├ís reconocible de la historia de la m├║sica. Luego saltas a la agresividad rockera de \"Beat It\", donde el solo de Eddie Van Halen rompi├│ las barreras entre la \"m├║sica negra\" y la radio de rock blanca de la ├®poca.\n\nM├ís que solo \"Thriller\"\nAunque la canci├│n hom├│nima y su video de 14 minutos cambiaron la industria para siempre, el coraz├│n del disco late en las joyas menos \"monstruosas\":\n\n\"Wanna Be Startin\' Somethin\'\": Un inicio fren├®tico, casi tribal, que te obliga a moverte.\n\n\"Human Nature\": La prueba definitiva de la vulnerabilidad de Michael; una balada sintetizada que suena a una noche neoyorquina llena de luces de ne├│n.\n\n\"P.Y.T. (Pretty Young Thing)\": Funk puro, fresco y dise├▒ado para la pista de baile.\n\nVeredicto\nThriller es ese extra├▒o caso donde la calidad art├¡stica est├í a la altura de su ├®xito comercial. No hay \"relleno\" (filler) en este disco. Cada pista es un single potencial. Quincy Jones puso la estructura y la elegancia, pero fue Jackson quien puso el fuego, los gritos, los jadeos y esa energ├¡a el├®ctrica que lo convirti├│ en el Rey del Pop.\n\nEs un disco que suena a perfecci├│n anal├│gica, a ambici├│n desmedida y, sobre todo, a magia pura. Si quieres entender por qu├® la m├║sica moderna suena como suena, tienes que volver a esta fuente.','[\"Producci\\u00f3n incre\\u00edble\",\"Buenas vibras\",\"Obra maestra\"]','{\"lyricsLiked\":true,\"listenAgain\":true,\"recommend\":true,\"vibeFactor\":74}','{\"favSong\":\"Billie Jean\",\"emotions\":\"HISTORICO\",\"recommend\":\"a todos\"}','Altavoces / D├¡a','Billie Jean',74,'2026-04-29 11:54:58','2026-05-06 10:05:38',2,NULL,NULL),(62,6,6,1.0,'no me gusto','yes es mejor','[\"Energ\\u00e9tico\",\"Bailable\"]','{\"lyricsLiked\":null,\"listenAgain\":null,\"recommend\":null,\"vibeFactor\":17}','{\"favSong\":\"nose\",\"emotions\":\"adad\",\"recommend\":\"adada\"}','Auriculares / Noche','nose',17,'2026-04-29 13:11:51','2026-04-29 13:12:05',1,NULL,NULL),(63,6,13,4.0,'VAYA JOYITA DE LUISMI','goat','[\"Letras profundas\",\"Para llorar\",\"Nost\\u00e1lgico\"]','{\"lyricsLiked\":true,\"listenAgain\":true,\"recommend\":true,\"vibeFactor\":93}','{\"favSong\":\"La gloria eres tu\",\"emotions\":\"romantico\",\"recommend\":\"a los puritas\"}','Altavoces / Noche','La gloria eres tu',93,'2026-04-29 22:17:18','2026-04-29 22:17:18',0,NULL,NULL),(64,6,7,3.0,NULL,'maravilloso','[]','{\"lyricsLiked\":null,\"listenAgain\":null,\"recommend\":null,\"vibeFactor\":50}','{\"emotions\":null,\"recommend\":null}','Altavoces / D├¡a',NULL,50,'2026-05-05 21:30:16','2026-05-06 09:55:15',1,NULL,NULL),(65,6,14,5.0,'obra maestra','obra maestra','[\"Obra maestra\",\"Producci\\u00f3n impecable\",\"Producci\\u00f3n minimalista\",\"Muy producido\",\"Nost\\u00e1lgico\"]','{\"lyricsLiked\":true,\"listenAgain\":true,\"recommend\":true,\"vibeFactor\":100}','{\"emotions\":\"rock and roll puro\",\"recommend\":\"a los jovenes\"}','Coche / D├¡a','When the Sun Goes Down',100,'2026-05-06 09:50:15','2026-05-06 10:05:32',1,'inmediato','que lo haga');
/*!40000 ALTER TABLE `reviews_albumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_canciones`
--

DROP TABLE IF EXISTS `reviews_canciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews_canciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `cancion_id` int(11) NOT NULL,
  `calificacion` decimal(2,1) DEFAULT NULL CHECK (`calificacion` >= 0.5 and `calificacion` <= 5.0),
  `comentario` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_cancion` (`usuario_id`,`cancion_id`),
  KEY `idx_usuario` (`usuario_id`),
  KEY `idx_cancion` (`cancion_id`),
  CONSTRAINT `reviews_canciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_canciones_ibfk_2` FOREIGN KEY (`cancion_id`) REFERENCES `canciones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews_canciones`
--

LOCK TABLES `reviews_canciones` WRITE;
/*!40000 ALTER TABLE `reviews_canciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews_canciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_albums`
--

DROP TABLE IF EXISTS `saved_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `album_titulo` varchar(200) NOT NULL,
  `album_artista` varchar(200) NOT NULL,
  `album_portada` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_album_unique` (`usuario_id`,`album_titulo`,`album_artista`),
  CONSTRAINT `saved_albums_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_albums`
--

LOCK TABLES `saved_albums` WRITE;
/*!40000 ALTER TABLE `saved_albums` DISABLE KEYS */;
INSERT INTO `saved_albums` VALUES (1,6,'(What\'s the Story) Morning Glory?','Oasis','https://lastfm.freetls.fastly.net/i/u/300x300/1b217359e775a8b6a7bc443abe5b08c2.png','2026-04-15 10:31:11'),(6,1,'Test','Test','','2026-04-29 21:59:13'),(7,6,'I Love You.','The Neighbourhood','https://lastfm.freetls.fastly.net/i/u/300x300/d787d7eb7324e25dfb03dd9c0220d818.png','2026-04-29 22:00:46'),(8,15,'I Love You.','The Neighbourhood','https://lastfm.freetls.fastly.net/i/u/300x300/d787d7eb7324e25dfb03dd9c0220d818.png','2026-04-29 22:01:14'),(9,15,'More Life','Drake','https://lastfm.freetls.fastly.net/i/u/300x300/434a922ecca5474f1f9d6bbcc3a1050c.png','2026-04-29 22:01:28'),(10,6,'Romances','Luis Miguel','https://lastfm.freetls.fastly.net/i/u/300x300/6ae06384aeac2ab4fb105c4e5fa4ef73.jpg','2026-04-29 22:17:19');
/*!40000 ALTER TABLE `saved_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguimientos`
--

DROP TABLE IF EXISTS `seguimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguimientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seguidor_id` int(11) NOT NULL,
  `seguido_id` int(11) NOT NULL,
  `fecha_seguimiento` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_seguimiento` (`seguidor_id`,`seguido_id`),
  KEY `seguido_id` (`seguido_id`),
  CONSTRAINT `seguimientos_ibfk_1` FOREIGN KEY (`seguidor_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `seguimientos_ibfk_2` FOREIGN KEY (`seguido_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`seguidor_id` <> `seguido_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguimientos`
--

LOCK TABLES `seguimientos` WRITE;
/*!40000 ALTER TABLE `seguimientos` DISABLE KEYS */;
INSERT INTO `seguimientos` VALUES (1,1,2,'2026-03-20 12:01:08'),(2,1,3,'2026-03-20 12:01:08'),(3,2,1,'2026-03-20 12:01:08'),(4,3,1,'2026-03-20 12:01:08'),(5,4,1,'2026-03-20 12:01:08');
/*!40000 ALTER TABLE `seguimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT 'default.jpg',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `activo` tinyint(1) DEFAULT 1,
  `verification_token` varchar(64) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_username` (`username`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'soundwaves_alex','alex@example.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','├ülex Soundwaves','Buscando el beat perfecto. Amante del indie y el R&B.','avatar1.jpg','2026-03-20 12:01:08',1,NULL,'2026-04-14 19:16:30'),(2,'vinyl_dreams','vinyl@example.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Vinyl Dreams','Coleccionista de vinilos. Rock progresivo y alternativo.','avatar2.jpg','2026-03-20 12:01:08',1,NULL,'2026-04-14 19:16:30'),(3,'crate_digger_mx','digger@example.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Crate Digger','Rap, Hip-Hop y todo lo que tenga buen flow.','avatar3.jpg','2026-03-20 12:01:08',1,NULL,'2026-04-14 19:16:30'),(4,'melotune_fan','fan@example.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','MeloTune Fan','Escucho de todo un poco.','default.jpg','2026-03-20 12:01:08',1,NULL,'2026-04-14 19:16:30'),(5,'testuser','test@test.com','$2y$12$1OjnKAL.3IHWR2/kEq7WWeXi4Lh7r2NIVJEEFQecG2sVzf9E8PTKC','Usuario Test','Nueva biografia','default.jpg','2026-04-14 10:38:52',1,NULL,'2026-04-14 19:16:30'),(6,'evalgar','pepito@gmail.com','$2y$12$zu4oPFjB13yNSn7.7A9jQuuEjvOMbGJjEZEnBedme1EAtM/qPcRau','Ezequiel Valgar','Amante de la m├║sica','http://127.0.0.1:8000/storage/avatars/obS7mUlkNtaf8lrKTRlT83fuHM2vPVb9aI9ldbYO.jpg','2026-04-14 10:40:34',1,NULL,'2026-04-14 19:16:30'),(7,'testuser2','test2@test.com','$2y$12$BR7uQN2p/2D/f6mycJbqNOWsCHYAF9o6ehwSWSSu8uUqvaWz5QK3a','Usuario Test',NULL,'default.jpg','2026-04-14 11:36:58',1,NULL,'2026-04-14 19:16:30'),(8,'testuser3','test3@test.com','$2y$12$Q5asSf8W3AGBhMSfOF.QyuyiBDpYArSugGcUhOZU.7HgLSd8uGqEK','Usuario Test 3',NULL,'default.jpg','2026-04-14 11:39:54',1,NULL,'2026-04-14 19:16:30'),(15,'Ezequielito','aliespres705@gmail.com','$2y$12$hhFhvvz3OJIyulCSsZnJMuG4O3GIsEoazXY/jx8tT69aXlUPQuv3O','SIx seven user','67676767676767','http://127.0.0.1:8000/storage/avatars/A0MDPVJ4xjd8uVufM0SsFo71jhuMYm8hfm0oy63t.jpg','2026-04-15 10:07:07',1,NULL,'2026-04-15 08:07:23'),(16,'larson.brenda','eschoen@example.com','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Abe Orn','And oh, I wish I hadn\'t gone down that rabbit-hole--and yet--and yet--it\'s rather curious, you.',NULL,'2026-02-08 15:07:47',1,NULL,'2026-04-21 10:04:54'),(17,'jacobs.valerie','donald79@example.com','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Prof. Kyle Koch III','CHAPTER V. Advice from a bottle marked \'poison,\' it is you hate--C and D,\' she added in an.',NULL,'2025-07-16 13:15:54',1,NULL,'2026-04-21 10:04:54'),(18,'ayla.ruecker','breanna87@example.org','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Filomena Gorczany','At this moment the King, and the Queen\'s ears--\' the Rabbit asked. \'No, I give it up,\' Alice.',NULL,'2025-12-05 07:17:24',1,NULL,'2026-04-21 10:04:54'),(19,'slangosh','doyle.vernon@example.net','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Miss Lupe Klocko','And how odd the directions will look! ALICE\'S RIGHT FOOT, ESQ. HEARTHRUG, NEAR THE FENDER, (WITH.',NULL,'2025-07-06 13:08:30',1,NULL,'2026-04-21 10:04:54'),(20,'cassin.trycia','rabshire@example.com','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Morris Gerlach','King put on your shoes and stockings for you now, dears? I\'m sure _I_ shan\'t be beheaded!\' \'What.',NULL,'2025-08-30 04:13:32',1,NULL,'2026-04-21 10:04:54'),(21,'rylee55','olson.kiara@example.org','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Karine Ratke','For instance, if you wouldn\'t squeeze so.\' said the Mock Turtle replied in an offended tone, \'so I.',NULL,'2025-10-23 07:24:41',1,NULL,'2026-04-21 10:04:54'),(22,'candelario.luettgen','chandler74@example.org','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Shayna Padberg','Mouse. \'--I proceed. \"Edwin and Morcar, the earls of Mercia and Northumbria--\"\' \'Ugh!\' said the.',NULL,'2025-12-26 13:43:24',1,NULL,'2026-04-21 10:04:54'),(23,'dietrich.christophe','okon.camila@example.com','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Rosamond Lueilwitz','Gryphon, and all the things being alive; for instance, there\'s the arch I\'ve got to?\' (Alice had.',NULL,'2025-07-04 07:27:08',1,NULL,'2026-04-21 10:04:54'),(24,'destiney.bosco','luis74@example.org','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Dr. Armand Bahringer PhD','Two. Two began in a very poor speaker,\' said the Caterpillar. \'Not QUITE right, I\'m afraid,\' said.',NULL,'2025-11-23 20:26:20',1,NULL,'2026-04-21 10:04:54'),(25,'trycia.mayert','elwin65@example.net','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Monroe Renner','Alice replied in a moment. \'Let\'s go on with the bread-knife.\' The March Hare said--\' \'I didn\'t!\'.',NULL,'2025-10-16 13:07:59',1,NULL,'2026-04-21 10:04:54'),(26,'ellie.graham','joanne89@example.org','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Ms. Leslie Anderson MD','Normans--\" How are you getting on now, my dear?\' it continued, turning to Alice, flinging the baby.',NULL,'2025-07-11 09:18:40',1,NULL,'2026-04-21 10:04:54'),(27,'colten.cronin','bfisher@example.net','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Clifford Steuber','And he got up this morning? I almost wish I could say if I might venture to ask them what the.',NULL,'2025-08-04 04:36:57',1,NULL,'2026-04-21 10:04:54'),(28,'stan09','heller.carolyn@example.net','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Maryjane Strosin','So she went on: \'But why did they draw?\' said Alice, (she had grown to her full size by this.',NULL,'2025-09-04 04:42:50',1,NULL,'2026-04-21 10:04:54'),(29,'madie96','rbartell@example.net','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Tevin Bergnaum','Soup? Pennyworth only of beautiful Soup? Beau--ootiful Soo--oop! Beau--ootiful Soo--oop! Soo--oop.',NULL,'2025-05-13 06:41:55',1,NULL,'2026-04-21 10:04:54'),(30,'crona.dangelo','heller.wilmer@example.net','$2y$12$dVHixWVn0wnN73TycvdYlev0VhbOSUg/Yo1vJnWflyQErwMDoiapW','Hal Davis','FIT you,\' said the Hatter. \'I deny it!\' said the King. \'It began with the next verse,\' the Gryphon.',NULL,'2025-12-15 03:06:55',1,NULL,'2026-04-21 10:04:54'),(31,'nwitting','ytowne@example.net','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Miss Trycia Ankunding','When the Mouse with an anxious look at them--\'I wish they\'d get the trial done,\' she thought.',NULL,'2025-05-01 22:32:19',1,NULL,'2026-04-21 10:05:47'),(32,'haylee.lind','bins.morton@example.com','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Jamaal Abernathy','ONE with such a capital one for catching mice--oh, I beg your pardon!\' cried Alice (she was rather.',NULL,'2025-07-24 12:32:40',1,NULL,'2026-04-21 10:05:47'),(33,'nkemmer','bednar.akeem@example.org','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Reta Rau','Alice said to herself; \'the March Hare took the thimble, looking as solemn as she went to the.',NULL,'2025-08-29 15:33:58',1,NULL,'2026-04-21 10:05:47'),(34,'anabelle.kuhic','estefania46@example.net','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Dallas Abshire','NOT, being made entirely of cardboard.) \'All right, so far,\' said the Cat, \'or you wouldn\'t.',NULL,'2025-06-19 11:54:10',1,NULL,'2026-04-21 10:05:47'),(35,'pfannerstill.oceane','sanford.carson@example.com','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Josefa Ledner','Adventures of hers that you weren\'t to talk to.\' \'How are you getting on?\' said the Mouse. \'Of.',NULL,'2026-04-20 15:36:55',1,NULL,'2026-04-21 10:05:47'),(36,'pearlie.skiles','linnea.runte@example.net','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Karine Olson','Mouse to Alice for some time after the candle is like after the rest of the court. \'What do you.',NULL,'2026-02-02 14:35:18',1,NULL,'2026-04-21 10:05:47'),(37,'seamus80','mbreitenberg@example.net','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Carley Legros','Alice, who was beginning to end,\' said the Gryphon: and it was an old woman--but then--always to.',NULL,'2026-03-24 18:27:23',1,NULL,'2026-04-21 10:05:47'),(38,'zola.ondricka','jaleel.schulist@example.com','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Prof. Susan Greenfelder','White Rabbit. She was a paper label, with the Mouse was bristling all over, and she drew herself.',NULL,'2025-07-28 00:57:59',1,NULL,'2026-04-21 10:05:47'),(39,'josianne05','ratke.pierre@example.com','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Prince Schuppe','Alice could only see her. She is such a long breath, and till the puppy\'s bark sounded quite faint.',NULL,'2026-01-16 04:17:31',1,NULL,'2026-04-21 10:05:47'),(40,'reid24','mariano.altenwerth@example.net','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Mr. Gaetano Reichel','At last the Caterpillar seemed to think that there was no longer to be true): If she should chance.',NULL,'2025-10-20 18:14:37',1,NULL,'2026-04-21 10:05:47'),(41,'fkoepp','cjacobi@example.com','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Brock Sawayn','Gryphon. \'--you advance twice--\' \'Each with a little feeble, squeaking voice, (\'That\'s Bill,\'.',NULL,'2025-12-14 19:22:57',1,NULL,'2026-04-21 10:05:47'),(42,'little.virginia','kole91@example.net','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Ms. Roma Anderson V','DOTH THE LITTLE BUSY BEE,\" but it said in a piteous tone. And she opened it, and found in it about.',NULL,'2025-11-10 17:17:26',1,NULL,'2026-04-21 10:05:47'),(43,'oconnell.keenan','kassulke.abelardo@example.org','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Brook Feil','I\'ve tried hedges,\' the Pigeon had finished. \'As if it had gone. \'Well! I\'ve often seen them so.',NULL,'2025-10-05 01:22:10',1,NULL,'2026-04-21 10:05:47'),(44,'fhauck','balistreri.rachelle@example.net','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Catharine Haag Sr.','Between yourself and me.\' \'That\'s the judge,\' she said to the end: then stop.\' These were the two.',NULL,'2026-02-20 07:25:56',1,NULL,'2026-04-21 10:05:47'),(45,'friesen.ashlee','joy.ritchie@example.com','$2y$12$OTB2yFW/pq5Hj0nmyOvloe7ra3OVFtJDLtz6apMW.7wU/m7ZA4cjK','Jaunita Jacobi','Lory, as soon as it spoke. \'As wet as ever,\' said Alice in a very curious to know what a Gryphon.',NULL,'2025-05-14 22:51:30',1,NULL,'2026-04-21 10:05:47'),(46,'minerva.kunde','qfunk@example.com','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Aaliyah Koelpin','VERY long claws and a pair of white kid gloves in one hand and a piece of it altogether; but after.',NULL,'2025-07-21 13:31:14',1,NULL,'2026-04-21 10:08:00'),(47,'cremin.izaiah','marquardt.ewell@example.net','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Amir Hermiston','First, however, she waited patiently. \'Once,\' said the Cat. \'I said pig,\' replied Alice; \'and I do.',NULL,'2025-07-28 03:26:18',1,NULL,'2026-04-21 10:08:00'),(48,'vcollier','omer48@example.net','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Mr. Guy Kreiger','Duchess was VERY ugly; and secondly, because she was dozing off, and that he shook both his shoes.',NULL,'2025-06-03 01:33:44',1,NULL,'2026-04-21 10:08:00'),(49,'srolfson','alden.parker@example.com','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Myles Boyer','Alice, feeling very glad to find that the pebbles were all shaped like the tone of great surprise.',NULL,'2025-12-06 17:40:33',1,NULL,'2026-04-21 10:08:00'),(50,'stanton.wilderman','sruecker@example.org','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Jacky Rohan','Queen. \'Well, I never understood what it meant till now.\' \'If that\'s all you know I\'m mad?\' said.',NULL,'2026-01-30 17:12:11',1,NULL,'2026-04-21 10:08:00'),(51,'vincenzo.schoen','mauricio76@example.org','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Prof. Modesta Maggio V','March Hare. \'I didn\'t know how to begin.\' For, you see, Alice had learnt several things of this.',NULL,'2025-10-06 03:58:47',1,NULL,'2026-04-21 10:08:00'),(52,'efren.bernhard','nolan.dejuan@example.org','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Leone Larkin','King repeated angrily, \'or I\'ll have you got in as well,\' the Hatter went on, turning to Alice: he.',NULL,'2025-06-18 20:49:16',1,NULL,'2026-04-21 10:08:00'),(53,'maye.paucek','cremin.jamal@example.net','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Ms. Raegan White MD','Alice\'s elbow was pressed so closely against her foot, that there was no label this time she saw.',NULL,'2026-01-06 22:08:16',1,NULL,'2026-04-21 10:08:00'),(54,'lhills','prosacco.cassidy@example.net','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Lavinia Durgan DDS','I look like it?\' he said, \'on and off, for days and days.\' \'But what did the Dormouse followed.',NULL,'2026-01-29 13:55:09',1,NULL,'2026-04-21 10:08:00'),(55,'cfay','harvey.dixie@example.org','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Amani Morissette','BEST butter, you know.\' \'I don\'t quite understand you,\' she said, as politely as she could, for.',NULL,'2025-08-14 22:10:50',1,NULL,'2026-04-21 10:08:00'),(56,'luettgen.emilia','remington.jacobi@example.org','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Dr. Lee Kuhn Jr.','Alice. The King turned pale, and shut his note-book hastily. \'Consider your verdict,\' the King and.',NULL,'2025-06-23 15:16:57',1,NULL,'2026-04-21 10:08:00'),(57,'mlangworth','fkulas@example.org','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Prof. Celestine Feest Jr.','I was sent for.\' \'You ought to be lost: away went Alice like the wind, and the jury asked. \'That I.',NULL,'2025-12-22 23:58:06',1,NULL,'2026-04-21 10:08:00'),(58,'qbreitenberg','ernestina68@example.net','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Marisa Feil','Why, I wouldn\'t be so kind,\' Alice replied, rather shyly, \'I--I hardly know, sir, just at first.',NULL,'2026-02-01 22:52:56',1,NULL,'2026-04-21 10:08:00'),(59,'dnader','ashlee33@example.com','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Willie Breitenberg','The Mouse did not venture to ask them what the name of the players to be a very small cake, on.',NULL,'2026-03-29 13:01:00',1,NULL,'2026-04-21 10:08:00'),(60,'ashtyn99','mafalda.schimmel@example.org','$2y$12$cC0AJ4srDCVQ9y9vmdwPDO08Uw4xZIKMGqNp.Q7g6jr9jKEn7TdnW','Sheila Streich','Alice very politely; but she knew she had read several nice little histories about children who.',NULL,'2025-08-19 20:28:41',1,NULL,'2026-04-21 10:08:00'),(61,'tremblay.armando','nyasia47@example.org','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Verner Johnson','Five, in a confused way, \'Prizes! Prizes!\' Alice had never seen such a fall as this, I shall think.',NULL,'2025-05-06 17:45:13',1,NULL,'2026-04-21 10:09:51'),(62,'langworth.minerva','eliane90@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Mr. Dino Beer DVM','The players all played at once took up the little door: but, alas! either the locks were too.',NULL,'2025-07-15 02:37:16',1,NULL,'2026-04-21 10:09:51'),(63,'kari.mosciski','emily96@example.com','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Prof. Freddie Schiller II','WHAT things?\' said the Dodo, \'the best way you go,\' said the King. \'Nothing whatever,\' said Alice.',NULL,'2025-09-01 15:56:12',1,NULL,'2026-04-21 10:09:51'),(64,'macey97','ashleigh.schiller@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Miss Asa Quigley DVM','If she should meet the real Mary Ann, and be turned out of sight, he said to herself, and began an.',NULL,'2025-08-04 01:05:46',1,NULL,'2026-04-21 10:09:51'),(65,'jed.keeling','cterry@example.com','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Ramon Medhurst Jr.','Do you think I can guess that,\' she added aloud. \'Do you mean by that?\' said the King, \'that only.',NULL,'2025-05-03 12:26:19',1,NULL,'2026-04-21 10:09:51'),(66,'joanie.larkin','allison65@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Trenton Cremin','I\'m perfectly sure I have ordered\'; and she went on, spreading out the Fish-Footman was gone, and.',NULL,'2026-02-09 16:47:56',1,NULL,'2026-04-21 10:09:51'),(67,'sydnee44','eugenia38@example.com','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Anderson Beahan','So she tucked her arm affectionately into Alice\'s, and they sat down a good way off, panting, with.',NULL,'2025-11-25 05:12:53',1,NULL,'2026-04-21 10:09:51'),(68,'vonrueden.jaylen','jrunolfsdottir@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Prof. Terrence Maggio','A little bright-eyed terrier, you know, and he wasn\'t going to turn into a tree. \'Did you say pig.',NULL,'2025-11-10 06:46:51',1,NULL,'2026-04-21 10:09:51'),(69,'cummings.norberto','cristal37@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Crystal Ryan','For anything tougher than suet; Yet you turned a corner, \'Oh my ears and the Queen said severely.',NULL,'2025-04-25 09:36:32',1,NULL,'2026-04-21 10:09:51'),(70,'kip.langosh','imelda.towne@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Trever Stokes','Gryphon, half to herself, rather sharply; \'I advise you to sit down without being seen, when she.',NULL,'2025-10-26 10:45:29',1,NULL,'2026-04-21 10:09:51'),(71,'antonio34','vmurazik@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Mrs. Alana Lind V','I give you fair warning,\' shouted the Queen furiously, throwing an inkstand at the Hatter, who.',NULL,'2025-06-30 21:39:19',1,NULL,'2026-04-21 10:09:51'),(72,'ubrakus','htromp@example.com','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Kali Wisoky','Rabbit say to itself in a deep, hollow tone: \'sit down, both of you, and listen to her. The Cat.',NULL,'2026-02-23 23:15:47',1,NULL,'2026-04-21 10:09:51'),(73,'alexandra77','norris73@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Maxine Labadie PhD','Footman\'s head: it just missed her. Alice caught the baby at her side. She was moving them about.',NULL,'2025-10-25 03:03:14',1,NULL,'2026-04-21 10:09:51'),(74,'lyla.gaylord','rodriguez.diana@example.com','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Bartholome Schroeder','Because he knows it teases.\' CHORUS. (In which the words don\'t FIT you,\' said the Gryphon, and the.',NULL,'2026-03-09 12:31:35',1,NULL,'2026-04-21 10:09:51'),(75,'marvin89','angela.block@example.net','$2y$12$ysK8.fcfx2iolxXGGkGnlOfP.YX9wRf6CmMCwcjiJ2g0WiAOeHdBC','Dr. Jerald Lesch','King. \'I can\'t remember half of them--and it belongs to the jury. They were just beginning to.',NULL,'2025-04-21 20:14:47',1,NULL,'2026-04-21 10:09:51'),(76,'xglover','gilda32@example.org','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Lina Gutkowski','Queen. First came ten soldiers carrying clubs; these were all locked; and when she found to be.',NULL,'2025-09-12 21:52:39',1,NULL,'2026-04-21 10:10:57'),(77,'rborer','lesch.lionel@example.org','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Stewart Rempel','March Hare. Alice was soon left alone. \'I wish the creatures argue. It\'s enough to drive one.',NULL,'2025-11-26 07:29:27',1,NULL,'2026-04-21 10:10:57'),(78,'earlene39','gaylord.kianna@example.org','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Daija Upton','I only wish they WOULD put their heads down! I am to see anything; then she remembered the number.',NULL,'2025-05-25 22:03:20',1,NULL,'2026-04-21 10:10:57'),(79,'uharris','alejandra.mills@example.net','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Anibal Conn','PRECIOUS nose\'; as an explanation. \'Oh, you\'re sure to do it.\' (And, as you might do very well.',NULL,'2025-05-10 03:24:26',1,NULL,'2026-04-21 10:10:57'),(80,'adan68','maida.volkman@example.net','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Kobe Ruecker MD','I only knew the name \'W. RABBIT\' engraved upon it. She stretched herself up closer to Alice\'s side.',NULL,'2025-07-08 19:01:29',1,NULL,'2026-04-21 10:10:57'),(81,'funk.merle','smith.candice@example.com','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Julie O\'Hara','Caterpillar, just as if his heart would break. She pitied him deeply. \'What is it?\' he said.',NULL,'2025-08-26 04:37:12',1,NULL,'2026-04-21 10:10:57'),(82,'grayce.sipes','domenica09@example.com','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Mrs. Myriam Rosenbaum','Alice, and looking anxiously about as it didn\'t much matter which way it was addressed to the.',NULL,'2025-05-05 10:49:55',1,NULL,'2026-04-21 10:10:57'),(83,'dustin56','emanuel.schulist@example.net','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Mellie Walsh','YOU?\' Which brought them back again to the door, and the whole she thought there was a table, with.',NULL,'2025-07-05 04:51:14',1,NULL,'2026-04-21 10:10:57'),(84,'jhodkiewicz','ismitham@example.org','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Raven Feeney MD','She pitied him deeply. \'What is his sorrow?\' she asked the Mock Turtle went on again:-- \'I didn\'t.',NULL,'2026-01-12 09:20:40',1,NULL,'2026-04-21 10:10:57'),(85,'brisa55','nitzsche.elva@example.org','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Prof. Florence Hoeger Sr.','Duchess and the other paw, \'lives a March Hare. \'Sixteenth,\' added the March Hare said--\' \'I.',NULL,'2025-12-28 19:34:55',1,NULL,'2026-04-21 10:10:57'),(86,'amie74','weissnat.geovanni@example.org','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Belle O\'Connell','The Mock Turtle yet?\' \'No,\' said the Hatter. \'You MUST remember,\' remarked the King, looking round.',NULL,'2026-03-06 16:07:09',1,NULL,'2026-04-21 10:10:57'),(87,'schmeler.matilda','hayden84@example.org','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Ms. Elnora Rau III','Said cunning old Fury: \"I\'ll try the first position in dancing.\' Alice said; but was dreadfully.',NULL,'2026-03-13 21:54:14',1,NULL,'2026-04-21 10:10:57'),(88,'beaulah54','buddy.sanford@example.com','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Joanie Leannon','Mock Turtle replied; \'and then the Mock Turtle. Alice was silent. The Dormouse slowly opened his.',NULL,'2026-03-17 18:14:34',1,NULL,'2026-04-21 10:10:57'),(89,'felipa.deckow','leland13@example.com','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Golden Rutherford','Alice, who had not gone (We know it to half-past one as long as you can--\' \'Swim after them!\'.',NULL,'2025-08-13 06:01:06',1,NULL,'2026-04-21 10:10:57'),(90,'christina54','bauch.sasha@example.com','$2y$12$M2OHD4f8GeM1am8IBbzig.K5woiu9/3U6ZBW/i6/6yra4s8MDWn9G','Mr. Sigrid Donnelly MD','Alice indignantly. \'Let me alone!\' \'Serpent, I say again!\' repeated the Pigeon, but in a bit.\'.',NULL,'2025-04-30 12:08:03',1,NULL,'2026-04-21 10:10:57'),(91,'zakary.lang','junius.zboncak@example.org','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Delia Witting','VERY deeply with a melancholy air, and, after waiting till she was quite pale (with passion, Alice.',NULL,'2025-12-10 13:55:40',1,NULL,'2026-04-21 10:12:18'),(92,'enola04','birdie.daugherty@example.net','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Kali Morar','Alice did not like the look of the window, and one foot up the fan and gloves, and, as the.',NULL,'2025-10-08 15:25:31',1,NULL,'2026-04-21 10:12:18'),(93,'alexandro.reilly','hhoeger@example.net','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Mr. Terrance Thompson','This of course, to begin with.\' \'A barrowful will do, to begin with; and being so many.',NULL,'2025-05-11 10:43:31',1,NULL,'2026-04-21 10:12:18'),(94,'nico05','gottlieb.damian@example.net','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Prof. Watson Stamm','Alice, and, after folding his arms and frowning at the Caterpillar\'s making such VERY short.',NULL,'2026-03-02 22:56:24',1,NULL,'2026-04-21 10:12:18'),(95,'lela24','lschroeder@example.net','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Howard Jakubowski','Alice. \'You must be,\' said the White Rabbit with pink eyes ran close by her. There was no one.',NULL,'2025-11-07 03:17:37',1,NULL,'2026-04-21 10:12:18'),(96,'lkoepp','ylangworth@example.com','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Prof. Leonard McDermott','The Mouse did not like the three gardeners, but she heard the Rabbit say, \'A barrowful of WHAT?\'.',NULL,'2025-10-25 19:33:35',1,NULL,'2026-04-21 10:12:18'),(97,'pbeier','wisozk.duncan@example.com','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Elody Baumbach','Alice, \'it\'s very rude.\' The Hatter was out of a procession,\' thought she, \'what would become of.',NULL,'2025-11-10 12:26:23',1,NULL,'2026-04-21 10:12:18'),(98,'derrick.boyer','aufderhar.david@example.com','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Reina Zboncak Jr.','Alice; not that she knew the meaning of it appeared. \'I don\'t know the meaning of it had made. \'He.',NULL,'2026-03-05 16:47:27',1,NULL,'2026-04-21 10:12:18'),(99,'misael.labadie','elton89@example.net','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Charles Adams','King had said that day. \'No, no!\' said the last few minutes it seemed quite natural to Alice a.',NULL,'2025-11-10 09:37:15',1,NULL,'2026-04-21 10:12:18'),(100,'chasity12','benjamin.thiel@example.net','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Asia Marks','However, this bottle does. I do so like that curious song about the reason is--\' here the Mock.',NULL,'2025-12-17 12:48:51',1,NULL,'2026-04-21 10:12:18'),(101,'hilpert.darrick','fay.edwina@example.com','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Gabe Rempel','She said it to his son, \'I feared it might be some sense in your pocket?\' he went on eagerly.',NULL,'2026-03-06 08:10:48',1,NULL,'2026-04-21 10:12:18'),(102,'maybell.bernier','eborer@example.net','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Mr. Harley Kemmer I','I wonder what CAN have happened to you? Tell us all about for them, and then another confusion of.',NULL,'2025-06-10 10:28:30',1,NULL,'2026-04-21 10:12:18'),(103,'darrel.vandervort','alfonso.reichert@example.com','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Miss Irma Kihn','I can\'t quite follow it as to bring tears into her face, and was gone across to the conclusion.',NULL,'2025-05-18 22:11:17',1,NULL,'2026-04-21 10:12:18'),(104,'elueilwitz','rogelio.parisian@example.com','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Coleman Cassin','Hatter: \'let\'s all move one place on.\' He moved on as he shook both his shoes on. \'--and just take.',NULL,'2025-09-28 14:14:26',1,NULL,'2026-04-21 10:12:18'),(105,'alicia.kertzmann','bella.bruen@example.com','$2y$12$5Usequ1cJBBZBOi7y.8NY.eoL5TyPNeaPXrjqu7zWu7pEs4/74q0a','Rebeca Spinka II','I\'m here! Digging for apples, indeed!\' said the Gryphon. \'Do you take me for his housemaid,\' she.',NULL,'2025-07-18 18:10:40',1,NULL,'2026-04-21 10:12:18');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-06 15:29:18
