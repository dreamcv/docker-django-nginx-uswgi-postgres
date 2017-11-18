-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: qlsj1109
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `accounts_projuser`
--

DROP TABLE IF EXISTS `accounts_projuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_projuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `mugshot` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_projuser`
--

LOCK TABLES `accounts_projuser` WRITE;
/*!40000 ALTER TABLE `accounts_projuser` DISABLE KEYS */;
INSERT INTO `accounts_projuser` VALUES (1,'pbkdf2_sha256$36000$vlYJNTAVAu47$LJ79kfGh95qaT9w3JK0yWzJDpoLT5oemoFpF1xB0C2o=','2017-11-13 06:39:20.504469',1,'actanble','','','actanble@173.com',1,1,'2017-11-10 09:28:00.000000','超级管理员','upload/mugshots/logo400x400_Y3PpbcF.jpg');
/*!40000 ALTER TABLE `accounts_projuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_projuser_groups`
--

DROP TABLE IF EXISTS `accounts_projuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_projuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_projuser_groups_projuser_id_group_id_6b9efe9f_uniq` (`projuser_id`,`group_id`),
  KEY `accounts_projuser_groups_group_id_1d09b368_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_projuser_gr_projuser_id_dba8df3d_fk_accounts_` FOREIGN KEY (`projuser_id`) REFERENCES `accounts_projuser` (`id`),
  CONSTRAINT `accounts_projuser_groups_group_id_1d09b368_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_projuser_groups`
--

LOCK TABLES `accounts_projuser_groups` WRITE;
/*!40000 ALTER TABLE `accounts_projuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_projuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_projuser_user_permissions`
--

DROP TABLE IF EXISTS `accounts_projuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_projuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_projuser_user_p_projuser_id_permission_i_0f2e7389_uniq` (`projuser_id`,`permission_id`),
  KEY `accounts_projuser_us_permission_id_6f0a51fb_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_projuser_us_permission_id_6f0a51fb_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `accounts_projuser_us_projuser_id_27393580_fk_accounts_` FOREIGN KEY (`projuser_id`) REFERENCES `accounts_projuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_projuser_user_permissions`
--

LOCK TABLES `accounts_projuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_projuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_projuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_usershenfen`
--

DROP TABLE IF EXISTS `accounts_usershenfen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_usershenfen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shenfen` varchar(50) NOT NULL,
  `proty` int(11) NOT NULL,
  `webuser_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_usershenfen_webuser_id_2d68e450_fk_accounts_projuser_id` (`webuser_id`),
  CONSTRAINT `accounts_usershenfen_webuser_id_2d68e450_fk_accounts_projuser_id` FOREIGN KEY (`webuser_id`) REFERENCES `accounts_projuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_usershenfen`
--

LOCK TABLES `accounts_usershenfen` WRITE;
/*!40000 ALTER TABLE `accounts_usershenfen` DISABLE KEYS */;
INSERT INTO `accounts_usershenfen` VALUES (1,'底层维护人员',1,1);
/*!40000 ALTER TABLE `accounts_usershenfen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add 事件详细',7,'add_eventdetail'),(20,'Can change 事件详细',7,'change_eventdetail'),(21,'Can delete 事件详细',7,'delete_eventdetail'),(22,'Can add 事件',8,'add_eventbase'),(23,'Can change 事件',8,'change_eventbase'),(24,'Can delete 事件',8,'delete_eventbase'),(25,'Can add 用户身份表|固定填写',9,'add_usershenfen'),(26,'Can change 用户身份表|固定填写',9,'change_usershenfen'),(27,'Can delete 用户身份表|固定填写',9,'delete_usershenfen'),(28,'Can add 网站扩展用户',10,'add_projuser'),(29,'Can change 网站扩展用户',10,'change_projuser'),(30,'Can delete 网站扩展用户',10,'delete_projuser'),(31,'Can add Jtopo里面的IP',11,'add_jips'),(32,'Can change Jtopo里面的IP',11,'change_jips'),(33,'Can delete Jtopo里面的IP',11,'delete_jips');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_projuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_projuser_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_projuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2017-11-10 09:29:30.170550','1','actanble',2,'[{\"changed\": {\"fields\": [\"last_login\", \"nickname\", \"mugshot\"]}}]',10,1),(2,'2017-11-10 09:30:35.221257','1','底层维护人员::actanble',1,'[{\"added\": {}}]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (10,'accounts','projuser'),(9,'accounts','usershenfen'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(8,'event','eventbase'),(7,'event','eventdetail'),(11,'jtopot','jips'),(5,'sessions','session'),(6,'sites','site');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-11-10 09:13:44.530324'),(2,'contenttypes','0002_remove_content_type_name','2017-11-10 09:13:47.312174'),(3,'auth','0001_initial','2017-11-10 09:13:54.669935'),(4,'auth','0002_alter_permission_name_max_length','2017-11-10 09:13:57.420765'),(5,'auth','0003_alter_user_email_max_length','2017-11-10 09:13:57.494813'),(6,'auth','0004_alter_user_username_opts','2017-11-10 09:13:57.574867'),(7,'auth','0005_alter_user_last_login_null','2017-11-10 09:13:57.712959'),(8,'auth','0006_require_contenttypes_0002','2017-11-10 09:13:57.745980'),(9,'auth','0007_alter_validators_add_error_messages','2017-11-10 09:13:57.789010'),(10,'auth','0008_alter_user_username_max_length','2017-11-10 09:13:57.840044'),(11,'accounts','0001_initial','2017-11-10 09:14:14.574745'),(12,'accounts','0002_auto_20171109_1427','2017-11-10 09:14:25.800214'),(13,'admin','0001_initial','2017-11-10 09:14:34.088030'),(14,'admin','0002_logentry_remove_auto_add','2017-11-10 09:14:34.362212'),(15,'event','0001_initial','2017-11-10 09:14:48.139235'),(16,'sessions','0001_initial','2017-11-10 09:14:49.749307'),(17,'sites','0001_initial','2017-11-10 09:14:50.392735'),(18,'sites','0002_alter_domain_unique','2017-11-10 09:14:51.335361'),(19,'event','0002_eventdetail_opreater_name','2017-11-11 01:45:59.433208'),(20,'jtopot','0001_initial','2017-11-17 01:10:20.549900'),(21,'jtopot','0002_jips_add_date','2017-11-17 01:36:58.979532'),(22,'jtopot','0003_auto_20171117_1048','2017-11-17 02:48:49.912925'),(23,'jtopot','0004_auto_20171117_1058','2017-11-17 02:58:48.935167');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('eysjo89gw0cyfcy8gip0318ov26shwhz','Mzg1MTBhYjJmOTYzNDQyMjdlZGQxMTUxZDVjNTk2NTVjY2U0NzU4ZTp7Il9hdXRoX3VzZXJfaGFzaCI6IjhhYTMxMTJiZmM4ZmI5ODlhMTUyZWQ1MGU2Y2RkOWIwNmU1NzEyNzAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhY2NvdW50cy51c2VyX2xvZ2luX2JhY2tlbmQuRW1haWxPclVzZXJuYW1lTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==','2017-11-24 09:29:09.681059'),('g3nucazpaqc5mtajv5ebaygtevha2zhn','Mzg1MTBhYjJmOTYzNDQyMjdlZGQxMTUxZDVjNTk2NTVjY2U0NzU4ZTp7Il9hdXRoX3VzZXJfaGFzaCI6IjhhYTMxMTJiZmM4ZmI5ODlhMTUyZWQ1MGU2Y2RkOWIwNmU1NzEyNzAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhY2NvdW50cy51c2VyX2xvZ2luX2JhY2tlbmQuRW1haWxPclVzZXJuYW1lTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEifQ==','2017-11-24 09:32:03.137036'),('rntfqu78aq2ls0vvs0878aqn9zmvbg2h','MDEwNGRiN2YwN2NiZDFkNDE3YTVhZTEwODg4OWZjM2NhY2NlMGZmMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjhhYTMxMTJiZmM4ZmI5ODlhMTUyZWQ1MGU2Y2RkOWIwNmU1NzEyNzAiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFjY291bnRzLnVzZXJfbG9naW5fYmFja2VuZC5FbWFpbE9yVXNlcm5hbWVNb2RlbEJhY2tlbmQifQ==','2017-11-27 06:39:20.733093');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_eventbase`
--

DROP TABLE IF EXISTS `event_eventbase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_eventbase` (
  `event_name` varchar(150) NOT NULL,
  `event_cate` varchar(50) NOT NULL,
  `event_src` varchar(20) NOT NULL,
  `to_server` varchar(20) NOT NULL,
  `port` varchar(20) NOT NULL,
  `happened_date` date NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_eventbase`
--

LOCK TABLES `event_eventbase` WRITE;
/*!40000 ALTER TABLE `event_eventbase` DISABLE KEYS */;
INSERT INTO `event_eventbase` VALUES ('从 `192.168.36.3` 向 `192.36.53.98` 通过 `445`端口的 `交通` 信息泄露','交通','192.168.36.3','192.36.53.98','445','2017-11-10',1),('从 `192.168.36.3` 向 `192.36.53.98` 通过 `445`端口的 `交通` 信息泄露','交通','192.168.36.3','192.36.53.98','445','2017-11-10',2),('从 `192.5.6.3` 向 `192.5.3.6` 通过 `223`端口的 `户政` 信息泄露','户政','192.5.6.3','192.5.3.6','223','2017-11-10',3),('从 `187.23.45.6` 向 `136.3.6.9` 通过 `8808`端口的 `禁毒` 信息泄露','禁毒','187.23.45.6','136.3.6.9','8808','2017-11-10',4),('从 `192.168.0.1` 向 `187.23.45.6` 通过 `443`端口的 `交通` 信息泄露','交通','192.168.0.1','187.23.45.6','443','2017-11-10',5),('从 `192.168.1.1` 向 `187.23.45.6` 通过 `112`端口的 `内保` 信息泄露','内保','192.168.1.1','187.23.45.6','112','2017-11-10',6),('从 `192.168.0.110` 向 `187.23.45.6` 通过 `556`端口的 `交通` 信息泄露','交通','192.168.0.110','187.23.45.6','556','2017-11-10',7),('从 `192.168.0.11` 向 `187.23.45.6` 通过 `224`端口的 `交通` 信息泄露','交通','192.168.0.11','187.23.45.6','224','2017-11-10',8),('从 `192.168.0.1` 向 `187.23.45.6` 通过 `1120`端口的 `网安` 信息泄露','网安','192.168.0.1','187.23.45.6','1120','2017-11-10',9),('从 `192.168.0.1` 向 `187.23.45.6` 通过 `554`端口的 `交通` 信息泄露','交通','192.168.0.1','187.23.45.6','554','2017-11-10',10),('从 `192.168.0.1` 向 `187.23.45.6` 通过 `1125`端口的 `交通` 信息泄露','交通','192.168.0.1','187.23.45.6','1125','2017-11-10',11),('从 `192.168.0.1` 向 `187.23.45.6` 通过 `557`端口的 `交通` 信息泄露','交通','192.168.0.1','187.23.45.6','557','2017-11-10',12),('从 `192.5.6.3` 向 `192.5.3.6` 通过 `223`端口的 `户政` 信息泄露','户政','192.5.6.3','192.5.3.6','223','2017-11-10',13),('从 `187.23.45.6` 向 `136.3.6.9` 通过 `808`端口的 `交通` 信息泄露','交通','187.23.45.6','136.3.6.9','808','2017-11-10',14),('从 `192.168.0.1` 向 `187.23.45.6` 通过 `443`端口的 `网安` 信息泄露','网安','192.168.0.1','187.23.45.6','443','2017-11-10',15),('从 `192.168.156.1` 向 `187.23.45.6` 通过 `112`端口的 `内保` 信息泄露','内保','192.168.156.1','187.23.45.6','112','2017-11-10',16),('从 `192.168.0.110` 向 `187.23.45.6` 通过 `556`端口的 `禁毒` 信息泄露','禁毒','192.168.0.110','187.23.45.6','556','2017-11-10',17),('从 `192.168.0.1` 向 `187.23.45.6` 通过 `443`端口的 `交通` 信息泄露','交通','192.168.0.1','187.23.45.6','443','2017-11-10',18),('从 `192.168.1.1` 向 `187.23.45.6` 通过 `112`端口的 `内保` 信息泄露','内保','192.168.1.1','187.23.45.6','112','2017-11-10',19),('从 `192.168.0.110` 向 `187.23.45.6` 通过 `556`端口的 `交通` 信息泄露','交通','192.168.0.110','187.23.45.6','556','2017-11-10',20),('从 `192.168.0.11` 向 `187.23.45.6` 通过 `224`端口的 `交通` 信息泄露','交通','192.168.0.11','187.23.45.6','224','2017-11-10',21),('从 `192.168.0.1` 向 `187.23.45.6` 通过 `1120`端口的 `网安` 信息泄露','网安','192.168.0.1','187.23.45.6','1120','2017-11-10',22);
/*!40000 ALTER TABLE `event_eventbase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_eventdetail`
--

DROP TABLE IF EXISTS `event_eventdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_eventdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_stat` varchar(50) NOT NULL,
  `event_time` datetime(6) NOT NULL,
  `extra_add` longtext NOT NULL,
  `event_id` int(11) NOT NULL,
  `opreater_name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_eventdetail_event_id_bb590b56_fk_event_eventbase_id` (`event_id`),
  CONSTRAINT `event_eventdetail_event_id_bb590b56_fk_event_eventbase_id` FOREIGN KEY (`event_id`) REFERENCES `event_eventbase` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_eventdetail`
--

LOCK TABLES `event_eventdetail` WRITE;
/*!40000 ALTER TABLE `event_eventdetail` DISABLE KEYS */;
INSERT INTO `event_eventdetail` VALUES (1,'发生','2017-11-10 09:20:39.157213','',2,'actanble'),(2,'发生','2017-11-10 09:20:39.523456','',3,'actanble'),(3,'发生','2017-11-10 09:20:40.373024','',4,'actanble'),(4,'发生','2017-11-10 09:20:40.716251','',5,'actanble'),(5,'发生','2017-11-10 09:20:40.970421','',6,'actanble'),(6,'发生','2017-11-10 09:20:41.040467','',7,'actanble'),(7,'发生','2017-11-10 09:20:41.605842','',8,'actanble'),(8,'发生','2017-11-10 09:20:41.689899','',9,'actanble'),(9,'发生','2017-11-10 09:20:41.855009','',10,'actanble'),(10,'发生','2017-11-10 09:20:42.078157','',11,'actanble'),(11,'发生','2017-11-10 09:20:42.266282','',12,'actanble'),(12,'发生','2017-11-10 09:20:42.406377','',13,'actanble'),(13,'发生','2017-11-10 09:20:42.506442','',14,'actanble'),(14,'发生','2017-11-10 09:20:42.956729','',15,'actanble'),(15,'发生','2017-11-10 09:20:43.056796','',16,'actanble'),(16,'发生','2017-11-10 09:20:43.289951','',17,'actanble'),(17,'发生','2017-11-10 09:20:43.515101','',18,'actanble'),(18,'发生','2017-11-10 09:20:43.598156','',19,'actanble'),(19,'发生','2017-11-10 09:20:43.698223','',20,'actanble'),(20,'发生','2017-11-10 09:20:43.781278','',21,'actanble'),(21,'发生','2017-11-10 09:20:43.865333','',22,'actanble'),(30,'签收','2017-11-11 10:31:14.050613','页面点击签收',3,'actanble'),(33,'签收','2017-11-11 10:42:49.303596','页面点击签收',7,'actanble'),(34,'签收','2017-11-11 10:43:08.829577','页面点击签收',2,'actanble'),(35,'签收','2017-11-11 10:57:54.357781','页面点击签收',6,'actanble'),(36,'处理','2017-11-11 11:05:11.402856','\"无其他描述，这个消息正常\"',2,'actanble'),(37,'签收','2017-11-11 11:09:23.514899','页面点击签收',5,'actanble'),(38,'签收','2017-11-11 11:10:00.046720','页面点击签收',15,'actanble'),(39,'处理','2017-11-11 11:15:30.379083','处理建议要什么建议~~~~~~~~~~~~~',5,'actanble'),(40,'处理','2017-11-11 11:15:53.562087','http://127.0.0.1:8000/',3,'actanble'),(41,'签收','2017-11-11 11:40:40.357492','页面点击签收',8,'actanble'),(42,'处理','2017-11-11 11:41:11.006762','此交通类信息属于正常； 不用理会',8,'actanble'),(43,'处理','2017-11-11 11:41:29.739691','此交通类信息属于正常； 不用理会',8,'actanble'),(44,'签收','2017-11-11 11:59:33.225044','页面点击签收',11,'actanble'),(45,'签收','2017-11-11 12:02:44.652718','页面点击签收',12,'actanble'),(46,'签收','2017-11-11 12:03:41.568166','页面点击签收',10,'actanble'),(47,'签收','2017-11-11 12:05:16.479870','页面点击签收',14,'actanble'),(48,'签收','2017-11-11 12:05:57.933049','页面点击签收',4,'actanble'),(49,'签收','2017-11-11 12:06:10.487614','页面点击签收',13,'actanble'),(50,'签收','2017-11-11 13:55:16.552155','页面点击签收',16,'actanble'),(51,'签收','2017-11-11 13:55:39.816872','页面点击签收',19,'actanble'),(52,'处理','2017-11-11 13:56:05.289613','有个毛的建议都快点完了',19,'actanble'),(53,'签收','2017-11-11 14:02:44.202783','页面点击签收',21,'actanble'),(54,'处理','2017-11-11 14:34:07.497780','2',14,'actanble'),(55,'处理','2017-11-11 14:36:29.180862','fdsafdsafdsafdsafdsafdsafdsafdsafdsafds',10,'actanble'),(56,'处理','2017-11-11 14:36:52.391647','fdsafdsafdsafdsafdsafdsafdsafdsafdsafds',10,'actanble'),(57,'签收','2017-11-11 14:42:10.401706','页面点击签收',9,'actanble'),(58,'处理','2017-11-11 14:42:23.672054','Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles, weebly ning heekya handango imeem plugg dopplr jibjab, movity jajah plickers sifteo edmodo ifttt zimbra',9,'actanble'),(59,'签收','2017-11-11 14:42:54.323814','页面点击签收',20,'actanble'),(60,'处理','2017-11-11 14:43:02.637327','Take me to your leader! Switzerland is small and neutral! We are more like Germany, ambitious and misunderstood!',20,'actanble'),(61,'签收','2017-11-11 14:56:55.460950','页面点击签收',18,'actanble'),(62,'处理','2017-11-11 16:29:00.198599','签收后的操作？？？测试‘’；；；；',18,'actanble'),(63,'处理','2017-11-11 16:29:12.714773','签收重复操作侧首i‘’‘',18,'actanble'),(64,'处理','2017-11-11 16:29:20.152910','继续操作测试‘’‘’',18,'actanble'),(65,'签收','2017-11-11 16:34:09.783043','页面点击签收',22,'actanble'),(66,'处理','2017-11-13 14:40:22.358350','gdsfagdsssssssfddsfdsafdsafdsafdsafdsafdsafdsafdsafdsafdsfads fdsafdsa fdsa fdsa fdsa',9,'actanble');
/*!40000 ALTER TABLE `event_eventdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_eventdetail_connect_person`
--

DROP TABLE IF EXISTS `event_eventdetail_connect_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_eventdetail_connect_person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventdetail_id` int(11) NOT NULL,
  `projuser_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_eventdetail_connec_eventdetail_id_projuser__985b84ea_uniq` (`eventdetail_id`,`projuser_id`),
  KEY `event_eventdetail_co_projuser_id_d49f468f_fk_accounts_` (`projuser_id`),
  CONSTRAINT `event_eventdetail_co_eventdetail_id_e1f73444_fk_event_eve` FOREIGN KEY (`eventdetail_id`) REFERENCES `event_eventdetail` (`id`),
  CONSTRAINT `event_eventdetail_co_projuser_id_d49f468f_fk_accounts_` FOREIGN KEY (`projuser_id`) REFERENCES `accounts_projuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_eventdetail_connect_person`
--

LOCK TABLES `event_eventdetail_connect_person` WRITE;
/*!40000 ALTER TABLE `event_eventdetail_connect_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_eventdetail_connect_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jtopot_jips`
--

DROP TABLE IF EXISTS `jtopot_jips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jtopot_jips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) NOT NULL,
  `stat` int(11) NOT NULL,
  `belongCate` varchar(20) NOT NULL,
  `tc_text` varchar(20) NOT NULL,
  `add_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jtopot_jips`
--

LOCK TABLES `jtopot_jips` WRITE;
/*!40000 ALTER TABLE `jtopot_jips` DISABLE KEYS */;
INSERT INTO `jtopot_jips` VALUES (4,'192.168.111.1',0,'server','what_happend001','2017-11-17 10:59:25.507888'),(6,'192.168.111.4',1,'host','????','2017-11-17 11:19:09.360136'),(8,'192.168.111.5',0,'host','????','2017-11-17 11:19:25.610288'),(9,'192.168.111.6',0,'host','????','2017-11-17 11:19:30.590765'),(10,'192.168.111.7',0,'host','????','2017-11-17 11:19:35.409966'),(11,'192.168.111.10',0,'host','????','2017-11-17 11:19:39.566419'),(12,'192.168.111.110',0,'host','????','2017-11-17 11:19:50.074770'),(15,'192.168.111.124',0,'host','????','2017-11-17 11:20:02.927084'),(16,'192.168.111.222',0,'host','????','2017-11-17 11:20:28.272314'),(18,'192.168.0.11',1,'host','手动添加','2017-11-17 15:12:36.495691'),(19,'127.11.0.22',1,'add','tanchu','2017-11-17 15:20:12.331605'),(20,'128.99.0.22',1,'host','文本','2017-11-17 15:23:22.206192'),(21,'128.22.33.22',1,'host','袒护才','2017-11-17 15:23:49.430743'),(23,' 22.22.22.23 ',1,'server','dfdsaf','2017-11-17 15:28:53.294552'),(24,' 22.22.22.23',0,'server','1','2017-11-17 15:29:21.691712');
/*!40000 ALTER TABLE `jtopot_jips` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-17 15:44:47
