-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: 5AI_VOGLI
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `citta`
--

DROP TABLE IF EXISTS `citta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citta` (
  `idCitta` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`idCitta`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citta`
--

LOCK TABLES `citta` WRITE;
/*!40000 ALTER TABLE `citta` DISABLE KEYS */;
INSERT INTO `citta` VALUES (1,'Ospedaletto Euganeo'),(2,'Este'),(3,'Casale di Scodosia'),(4,'Lozzo Atestino'),(5,'Cagnine di Sotto'),(6,'Monselice'),(7,'Este');
/*!40000 ALTER TABLE `citta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edificio`
--

DROP TABLE IF EXISTS `edificio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edificio` (
  `idEdificio` int NOT NULL AUTO_INCREMENT,
  `indirizzo` varchar(35) NOT NULL,
  `numeroCivico` int NOT NULL,
  `citta` int NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `idProprietario` int NOT NULL,
  PRIMARY KEY (`idEdificio`),
  KEY `idProprietario` (`idProprietario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edificio`
--

LOCK TABLES `edificio` WRITE;
/*!40000 ALTER TABLE `edificio` DISABLE KEYS */;
INSERT INTO `edificio` VALUES (1,'a',1,1,'casa1',176208739),(2,'a',1,1,'casa1',176208739);
/*!40000 ALTER TABLE `edificio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proprietario`
--

DROP TABLE IF EXISTS `proprietario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proprietario` (
  `idProprietario` int NOT NULL AUTO_INCREMENT,
  `nomeUtente` varchar(64) DEFAULT NULL,
  `chiave` varchar(44) DEFAULT NULL,
  PRIMARY KEY (`idProprietario`)
) ENGINE=InnoDB AUTO_INCREMENT=176208740 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proprietario`
--

LOCK TABLES `proprietario` WRITE;
/*!40000 ALTER TABLE `proprietario` DISABLE KEYS */;
INSERT INTO `proprietario` VALUES (3,'vux','OFwtopS-P65MsCUF2PA6l4wHkGeMH0jEOQ_3ANtE3Fs='),(176208739,'Vullnet','cTpR9eZapvux9SyX9cXVJiW8gmGC0w_RTNses2Dwxls=');
/*!40000 ALTER TABLE `proprietario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stanza`
--

DROP TABLE IF EXISTS `stanza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stanza` (
  `idStanza` int NOT NULL AUTO_INCREMENT,
  `idCasa` int NOT NULL,
  `idTipo` int NOT NULL,
  `temperaturaMinima` int NOT NULL,
  `temperaturaMassima` int NOT NULL,
  `notifica` tinyint(1) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idStanza`),
  KEY `idCasa` (`idCasa`),
  KEY `idTipo` (`idTipo`),
  CONSTRAINT `stanza_ibfk_1` FOREIGN KEY (`idCasa`) REFERENCES `casa` (`idCasa`),
  CONSTRAINT `stanza_ibfk_2` FOREIGN KEY (`idTipo`) REFERENCES `tipo_stanza` (`idTipo`),
  CONSTRAINT `stanza_ibfk_3` FOREIGN KEY (`idTipo`) REFERENCES `tipo_stanza` (`idTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stanza`
--

LOCK TABLES `stanza` WRITE;
/*!40000 ALTER TABLE `stanza` DISABLE KEYS */;
INSERT INTO `stanza` VALUES (1,1,5,10,30,1,'Salotto'),(2,1,2,10,35,0,'Cucina'),(3,1,1,1,30,0,'Bagno piccolo'),(4,1,1,1,40,1,'Bagno grande'),(5,1,4,15,28,1,'Camera figlio'),(6,1,4,1,35,1,'Camera matrimoniale'),(7,2,1,10,30,1,'Bagno piccolo'),(8,2,3,10,35,1,'Salotto'),(9,3,1,1,5,1,'Bagno piccolo');
/*!40000 ALTER TABLE `stanza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temperatura`
--

DROP TABLE IF EXISTS `temperatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temperatura` (
  `idTemperatura` int NOT NULL AUTO_INCREMENT,
  `valore` int NOT NULL,
  `data` date NOT NULL,
  `ora` time NOT NULL,
  `idStanza` int NOT NULL,
  PRIMARY KEY (`idTemperatura`),
  KEY `idStanza` (`idStanza`),
  CONSTRAINT `temperatura_ibfk_1` FOREIGN KEY (`idStanza`) REFERENCES `stanza` (`idStanza`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperatura`
--

LOCK TABLES `temperatura` WRITE;
/*!40000 ALTER TABLE `temperatura` DISABLE KEYS */;
/*!40000 ALTER TABLE `temperatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_stanza`
--

DROP TABLE IF EXISTS `tipo_stanza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_stanza` (
  `idTipo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`idTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_stanza`
--

LOCK TABLES `tipo_stanza` WRITE;
/*!40000 ALTER TABLE `tipo_stanza` DISABLE KEYS */;
INSERT INTO `tipo_stanza` VALUES (1,'Bagno'),(2,'Cucina'),(3,'Salotto'),(4,'Camera da letto'),(5,'Sala degli ospiti'),(6,'Sala da pranzo'),(7,'Garage'),(8,'Cantina');
/*!40000 ALTER TABLE `tipo_stanza` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-11 16:33:19
