CREATE DATABASE  IF NOT EXISTS `recogme` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `recogme`;
-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: recogme
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

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
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(255) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$ksTK4kHQ4UPt$ZR6n63NvLvI/iQ5WkQqmcQi+LhptvpQ55krs5VnO94U=','2015-10-29 11:33:56',1,'admin','','','admin@admin.com',1,1,'2015-10-27 14:58:17'),(12,'pbkdf2_sha256$20000$djJTleQmFIYQ$W3omm1w8IGm/tu/IM2inZFjbyOoZPlh62sUaGg5Wwyo=','2015-10-28 18:46:48',0,'ricooliveira@gmail.com','Ricardo','Santos de Oliveira','',0,1,'2015-10-28 18:42:27'),(13,'pbkdf2_sha256$20000$XbTG0i663g4b$6vTC6SoBnCJYwGe2hc/slm23au7sNERVwgDc3ngEoKM=','2015-10-28 18:48:09',0,'antonioricardojr@gmail.com','Antonio','Ricardo Marques Junior','',0,1,'2015-10-28 18:43:56'),(14,'pbkdf2_sha256$20000$uG7vmvUd5Eix$JL5rMr4m1PjBLNGqRNr2H4FfjKhMh4wvIQX9yzsdH/4=','2015-10-28 18:48:05',0,'arthur.senaufcg@gmail.com','arthur','sena','',0,1,'2015-10-28 18:44:16'),(15,'pbkdf2_sha256$20000$V1E6GOTKmt1M$KQHFScJ+GaJBYtFJuEBvmymCfnplut1yaIIZCiLaXZ8=','2015-10-28 18:48:14',0,'luiz.fonseca@ccc.ufcg.edu.br','Luiz','Alberto Fonseca','',0,1,'2015-10-28 18:45:00'),(16,'pbkdf2_sha256$20000$ETJFX8o4q2kA$lwWmSEbFuGrBkdT0cVBWoNXrm3riZH9Q917l7VmzENY=','2015-10-28 18:49:50',0,'leonardo.santos@ccc.ufcg.edu.br','Leonardo','Alves dos Santos','',0,1,'2015-10-28 18:45:01'),(17,'pbkdf2_sha256$20000$U0MpSlRYtWex$sBNaWeSnBZPpDcHg/hH8wADEDKpdLsUwjFzQMoDywUE=','2015-10-28 18:58:09',0,'celio.barros.filho@gmail.com','Célio','Roberto Cavalcante de Barros F','',0,1,'2015-10-28 18:53:30'),(18,'pbkdf2_sha256$20000$hyMZmaBtXxKf$6pa5VjJ381to0ZUHHfmgYBxPNQZdLQ9W18OPGDsWGcE=','2015-10-28 18:57:12',0,'orion.lima@ccc.ufcg.edu.br','Órion','Darshan Winter de Lima','',0,1,'2015-10-28 18:53:32'),(19,'pbkdf2_sha256$20000$VGGYa4DUFeQz$sKVTbgxsXL2O7trMvpQL/PEW27s7Y/ezY5rRuELPrjQ=','2015-10-28 19:05:41',0,'lwilker24@gmail.com','Lucas','Wilker Moura Barbosa','',0,1,'2015-10-28 19:01:56'),(20,'pbkdf2_sha256$20000$uZyzh5zE7crM$0ZKqN/PAfBv3zryveaPnaPt3AC90XiqZ7lRC4Bm4vbw=','2015-10-28 19:06:33',0,'laybson_flyer@hotmail.com','Laybson','Plismenn Sousa Cunha','',0,1,'2015-10-28 19:01:57'),(21,'pbkdf2_sha256$20000$MLohGBTVBK2g$odVkYrrI+BBEXAYuKKSyVJdoMheQKdN8BY02mEt8SW0=','2015-10-28 19:07:45',0,'gerson.junior@ccc.ufcg.edu.br','Gerson','Sales Araujo de Freitas Junior','',0,1,'2015-10-28 19:03:50'),(22,'pbkdf2_sha256$20000$XTeDjB73uzop$MBclh88gj19bIaoiMvSaAHvYY7MOc7vY0BoRaByfSTc=','2015-10-28 19:10:41',0,'jose.ferreira@ccc.ufcg.edu.br','José','Manoel Ferreira','',0,1,'2015-10-28 19:04:45'),(23,'pbkdf2_sha256$20000$JCmMjGzGBPpE$hsi3k2pCgRrDcfypZRsTrGpO+H1G+jdurbi1KyMHMQA=','2015-10-28 19:07:48',0,'fabio.fernando.osilva@gmail.com','Fábio','Fernando de Oliveira Silva','',0,1,'2015-10-28 19:04:57'),(24,'pbkdf2_sha256$20000$OFV7NendqPZE$QK7hY3sdQM3JnfxZY4So0PWJ05fVcmeifpIuy6XaW4E=','2015-10-28 19:18:32',0,'diegolimapereira@gmail.com','Diego','de Lima Pereira','',0,1,'2015-10-28 19:15:58'),(25,'pbkdf2_sha256$20000$AL3ocg71t9Y5$93gHSBK4rg16Vd1vP/CU7Scx8OQz4TeD9a94O2yFcfg=','2015-10-28 19:19:17',0,'albertofagner.cav@gmail.com','alberto','fagner ferreira de barros','',0,1,'2015-10-28 19:16:20'),(26,'pbkdf2_sha256$20000$qtiFosKW3JPm$qsUpHLcc2yuO9oZieTtjAzL9JfEqTTyYeEfcH97lp2Y=','2015-10-28 19:20:35',0,'andre@gmail.com','Andre','Fagner Sousa','',0,1,'2015-10-28 19:16:41'),(27,'pbkdf2_sha256$20000$hSnIE8fvKLLZ$02BZfc/CjWr/6+iYr5X0S7pPvFhnalQu5E+E//66Z5Y=','2015-10-28 19:20:06',0,'carolzinhacabral@gmail.com','Ana','Carolina Cabral de Paiva','',0,1,'2015-10-28 19:17:41'),(28,'pbkdf2_sha256$20000$q0i1ozWZmsQd$bUZHCYR37pEsS5oPEtWcqO1+Z4J2j1A1OOyEi8P5WHs=','2015-10-28 19:29:11',0,'aline.trovao@ccc.ufcg.edu.br','Aline','Cordeiro Trovão','',0,1,'2015-10-28 19:25:36'),(29,'pbkdf2_sha256$20000$JG8VvkRvdYoM$JxpMFaPT8vXXaCqzIc8FZK1gFPWoG/+M+4QiAesgtro=','2015-10-28 19:36:59',0,'teu.araujo@gmail.com','Matheus','de Araujo Maciel','',0,1,'2015-10-28 19:32:31'),(30,'pbkdf2_sha256$20000$eYp4jFeKV0it$94j15Fggg2htUpZTH+XILsb3qGLnig2NclT5gCD3QcI=','2015-10-28 19:37:31',0,'emanoel.oliveira@ccc.ufcg.edu.br','Emanoel','Barros de Sousa Oliveira','',0,1,'2015-10-28 19:33:06'),(31,'pbkdf2_sha256$20000$8gG9qEoFeje8$KjwNYLbAtBlpDrvAifAsCrk+lEDFwpoUzfj8gKJfjws=','2015-10-28 19:42:32',0,'arthur.costa@ccc.ufcg.edu.br','Arthur','Emanuel Rodrigues Costa','',0,1,'2015-10-28 19:38:19'),(32,'pbkdf2_sha256$20000$1huRqI1FBBhY$fYdMGKnW+2Awbq1GSlbUApnQR2ZmHDVv+fu95FuxkA8=','2015-10-28 19:51:18',0,'tales.tsp@gmail.com','Tales','Tenorio de Souza Pimentel','',0,1,'2015-10-28 19:47:45'),(33,'pbkdf2_sha256$20000$t9RZ2kTn8W4d$6yzq2NdC7T6NsgE5k9JzdHmbX5mp/8JhOYqvOwLp1Pc=','2015-10-28 19:53:30',0,'caionobrega0@gmail.com','caio','santos bezerra nóbrega','',0,1,'2015-10-28 19:51:06'),(34,'pbkdf2_sha256$20000$lpV0zLja56HI$Tbx7McbOUwcFPZTJw/0suwDXDtzM2CSjymKv+xANiuQ=','2015-10-28 20:15:37',0,'talitabac@gmail.com','Talita','Lobo de Menezes','',0,1,'2015-10-28 20:05:25'),(35,'pbkdf2_sha256$20000$Xxqfpu5Aoo7W$WyLZQLt4knyNDq7FoZq3NwU3KeqUjEpuT/EMXoDnyuI=','2015-10-28 20:09:17',0,'joaotargino@gmail.com','João','Paulo dos Santos Targino','',0,1,'2015-10-28 20:07:20'),(36,'pbkdf2_sha256$20000$jRhSu0JR5SlC$3iZ6kCT4PPZfWV4v9oPTTuFmbHG9Mdc9XaiLs4Q+img=','2015-10-28 20:14:00',0,'pamelaodf@gmail.com','Pamela','Oliveira Dutra de Freitas','',0,1,'2015-10-28 20:08:12'),(37,'pbkdf2_sha256$20000$7hL5Rw5UxFe3$e0pffGX3a/pTdxz0/EsxA9toAA2XqTI7C2PGOrxjmz8=','2015-10-28 20:13:47',0,'italo.batista@ccc.ufcg.edu.br','Ítalo','Héctor de Medeiros Batista','',0,1,'2015-10-28 20:10:49'),(38,'pbkdf2_sha256$20000$A5epCi0A48bF$QYAP0dA4ud7DHK+1+Hwi89XQR/OzFitrXVpf8YRPn9c=','2015-10-28 20:20:15',0,'tacianosilva@gmail.com','Taciano','de Morais Silva','',0,1,'2015-10-28 20:17:02'),(41,'pbkdf2_sha256$20000$942ncoRcBoQr$HD6J3V0ay0m29IJJVeWdEvBMtoC6JD5+3Udm72f0QnM=','2015-10-29 13:41:02',0,'balrou@gmail.com','Henryson','Getúlio Cabral das Chagas','',0,1,'2015-10-29 13:39:06'),(42,'pbkdf2_sha256$20000$lqCjlhpXrRXf$6KAmdFHcTptFVapA3SoT+JicKBzIBVD8sh5qo0v3N3c=','2015-10-29 13:50:51',0,'zegildo@gmail.com','José','Gildo de Araújo Júnior','',0,1,'2015-10-29 13:48:10'),(43,'pbkdf2_sha256$20000$XVePGYUQlCOx$QhQUQ+HWWN8+2tBmuPxHRGxe7Rjh2/3aPgwcKW+xsaM=','2015-10-29 13:59:50',0,'gustavonobrega@gmail.com','gustavo','nobrega martins','',0,1,'2015-10-29 13:56:09'),(44,'pbkdf2_sha256$20000$kRrHbjxnUylH$EXB3P1FbnA17CQ7bs/KLc039yX9ZXxZeIJwgf4/kFzU=','2015-10-29 14:00:12',0,'fellype.cavalcante@gmail.com','Fellype','Cavalcante de Albuquerque','',0,1,'2015-10-29 13:57:18');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-29 11:02:58
