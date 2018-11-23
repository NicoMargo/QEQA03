-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 23-11-2018 a las 18:02:35
-- Versión del servidor: 5.7.21
-- Versión de PHP: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdpaises`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `1` ()  NO SQL
Select Nombre, Población FROM paises$$

DROP PROCEDURE IF EXISTS `10`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `10` ()  NO SQL
select paises.Nombre AS NombrePais, COUNT(persona.Pais) AS CuentaPais FROM Persona inner join paises on paises.IdPais = persona.Pais 
group by paises.Nombre
ORDER BY CuentaPais DESC
Limit 1$$

DROP PROCEDURE IF EXISTS `2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `2` ()  NO SQL
Select Nombre, Apellido From persona where Apellido Like '%O%'$$

DROP PROCEDURE IF EXISTS `3`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3` ()  NO SQL
Select Nombre, Población, Fecha_Fundacion From Paises ORDER BY Población Desc$$

DROP PROCEDURE IF EXISTS `4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `4` ()  NO SQL
Select Nombre From Paises where Nombre Like 'A%'$$

DROP PROCEDURE IF EXISTS `5`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `5` ()  NO SQL
Select AVG(Población) AS PrimedioContinente, Continente From Paises GROUP BY Continente$$

DROP PROCEDURE IF EXISTS `6`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `6` ()  NO SQL
select SUM(paises.Población) as TotalPoblacion from paises 
group by Continente$$

DROP PROCEDURE IF EXISTS `7`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `7` ()  NO SQL
select * from paises order by Fecha_Fundacion DESC LIMIT 5$$

DROP PROCEDURE IF EXISTS `8`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `8` ()  NO SQL
select persona.Nombre, persona.Apellido, paises.Moneda from persona 
inner join paises on paises.IdPais = persona.pais$$

DROP PROCEDURE IF EXISTS `9`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `9` ()  NO SQL
select Nombre, Fecha_Fundacion from paises 
where Fecha_Fundacion between '1918/09/11' and '1945/05/08'$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

DROP TABLE IF EXISTS `paises`;
CREATE TABLE IF NOT EXISTS `paises` (
  `Nombre` varchar(50) DEFAULT NULL,
  `Población` int(11) DEFAULT NULL,
  `Moneda` varchar(50) DEFAULT NULL,
  `Fecha_Fundacion` date DEFAULT NULL,
  `Superficie total` int(11) DEFAULT NULL,
  `IdPais` int(11) NOT NULL,
  `Continente` varchar(50) NOT NULL,
  PRIMARY KEY (`IdPais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`Nombre`, `Población`, `Moneda`, `Fecha_Fundacion`, `Superficie total`, `IdPais`, `Continente`) VALUES
('Japon', 126800000, 'Yen', '1925-03-16', 10000, 1, 'Asia'),
('Rusia', 126800000, 'Rublo', '2016-03-16', 10000, 2, 'Asia'),
('Alemania', 126800000, 'Euro', '2016-03-16', 10000, 3, 'Europa'),
('Italia', 127, 'Euro', '2016-03-16', 10000, 4, 'Europa'),
('España', 126800000, 'Euro', '1936-03-16', 10000, 5, 'Europa'),
('Portugal', 126800000, 'Euro', '2016-03-16', 10000, 6, 'Europa'),
('Austria', 126800000, 'Euro', '2016-03-16', 10000, 7, 'Europa'),
('Grecia', 126800000, 'Euro', '2016-03-16', 10000, 8, 'Europa'),
('Francia', 126800000, 'Euro', '2016-03-16', 10000, 9, 'Europa'),
('Polonia', 126800000, 'Euro', '2016-03-16', 10000, 10, 'Europa'),
('Holanda', 15678, 'Euro', '2016-03-16', 10000, 11, 'Europa'),
('Belgica', 126800000, 'Euro', '2016-03-16', 10000, 12, 'Europa'),
('Estonia', 126800000, 'Euro', '2016-03-16', 10000, 13, 'Europa'),
('Lituania', 126800000, 'Euro', '2016-03-16', 10000, 14, 'Europa'),
('Eslovaquia', 126800000, 'Euro', '2016-03-16', 10000, 15, 'Europa'),
('Finlandia', 1268000, 'Euro', '2016-03-16', 10000, 16, 'Europa'),
('Irlanda', 126800000, 'Euro', '2016-03-16', 10000, 17, 'Europa'),
('Luxemburgo', 3, 'Euro', '1920-03-16', 10000, 18, 'Europa'),
('Malta', 3, 'Euro', '2016-03-16', 10000, 19, 'Europa'),
('Chipre', 1, 'Euro', '2016-03-16', 10000, 20, 'Europa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `IdP` int(11) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Pais` int(11) NOT NULL,
  PRIMARY KEY (`IdP`),
  KEY `FKPPais_Paises` (`Pais`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`IdP`, `Apellido`, `Nombre`, `Pais`) VALUES
(1, 'Margossian', 'Nicolas', 1),
(2, 'Gibaut', 'Jon', 18),
(3, 'Kemeny', 'Ezequiel', 15),
(4, 'Jonatan', 'Liu', 10),
(5, 'A', 'A', 4),
(6, 'B', 'B', 3),
(7, 'C', 'C', 20),
(8, 'D', 'D', 4),
(9, 'E', 'E', 18),
(10, 'F', 'F', 18);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `FKPPais_Paises` FOREIGN KEY (`Pais`) REFERENCES `paises` (`IdPais`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
