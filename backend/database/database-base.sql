-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.7.20-log - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              9.4.0.5185
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para raise
CREATE DATABASE IF NOT EXISTS `raise` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `raise`;

-- Copiando estrutura para tabela raise.001t_apiauth
CREATE TABLE IF NOT EXISTS `001t_apiauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(50) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela para autenticação e acesso das rotas de API';

-- Copiando dados para a tabela raise.001t_apiauth: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `001t_apiauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `001t_apiauth` ENABLE KEYS */;

-- Copiando estrutura para tabela raise.002t_login
CREATE TABLE IF NOT EXISTS `002t_login` (
  `idlogin` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL,
  `nomecompleto` varchar(100) DEFAULT NULL,
  `tipologin` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`idlogin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Essa tabela serve para todas as opções de login , mas quando faz login via facebook ou google , apenas armazenamos o ID e o nome completo';

-- Copiando dados para a tabela raise.002t_login: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `002t_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `002t_login` ENABLE KEYS */;

-- Copiando estrutura para tabela raise.003t_dadoscomplementares
CREATE TABLE IF NOT EXISTS `003t_dadoscomplementares` (
  `fk_uuid` int(11) NOT NULL,
  `NomeCompleto` varchar(100) DEFAULT NULL,
  `foto` longtext,
  `fk_idesporte` int(11) DEFAULT NULL,
  `tempotreino` varchar(45) DEFAULT NULL,
  `dtnascimento` date DEFAULT NULL,
  PRIMARY KEY (`fk_uuid`),
  KEY `fk_idesporte_idx` (`fk_idesporte`),
  CONSTRAINT `fk_idesporte` FOREIGN KEY (`fk_idesporte`) REFERENCES `004t_esportes` (`idesporte`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_uuid` FOREIGN KEY (`fk_uuid`) REFERENCES `002t_login` (`idlogin`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela raise.003t_dadoscomplementares: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `003t_dadoscomplementares` DISABLE KEYS */;
/*!40000 ALTER TABLE `003t_dadoscomplementares` ENABLE KEYS */;

-- Copiando estrutura para tabela raise.004t_esportes
CREATE TABLE IF NOT EXISTS `004t_esportes` (
  `idesporte` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idesporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Listagem dos Esportes cadastrados	';

-- Copiando dados para a tabela raise.004t_esportes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `004t_esportes` DISABLE KEYS */;
/*!40000 ALTER TABLE `004t_esportes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
