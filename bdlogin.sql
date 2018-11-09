-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 02-11-2018 a las 18:56:11
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
-- Base de datos: `bdlogin`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `spEliminarUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarUsuario` (IN `Username` VARCHAR(50))  BEGIN
	delete FROM Usuarios where Usuarios.Username = Username;
	select 'Usuario Eliminado';
END$$

DROP PROCEDURE IF EXISTS `spListarUsuariosxPerfil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spListarUsuariosxPerfil` (IN `perfil` VARCHAR(50))  BEGIN
	select * from Usuarios Inner join Perfil on Perfil.Id = Usuarios.Perfil
	where Perfil.Tipo = @Perfil;
END$$

DROP PROCEDURE IF EXISTS `spLogin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLogin` (IN `Nombre` VARCHAR(50), IN `Pass` VARCHAR(50))  begin
select * from Usuarios	where (Id = idUsuario) and (Contrasena = Pass);
end$$

DROP PROCEDURE IF EXISTS `spRegister`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegister` (IN `Username` VARCHAR(50), IN `Password` VARCHAR(50), IN `Apellido` VARCHAR(50), IN `Nombre` VARCHAR(50), IN `mail` VARCHAR(50), IN `Perfil` VARCHAR(50))  BEGIN
	insert into Usuarios (Username,Contrasena,Nombre,Apellido,mail,Perfil) 
    values (Username,Hashbytes('MD5', Password), Nombre, Apellido, mail, idPerfil);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

DROP TABLE IF EXISTS `perfil`;
CREATE TABLE IF NOT EXISTS `perfil` (
  `Tipo` varchar(50) NOT NULL,
  `Id` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `Nombre` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Contraseña` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Id` int(11) NOT NULL,
  `idPerfil` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fkUsuarios_Perfiles` (`idPerfil`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fkUsuarios_Perfiles` FOREIGN KEY (`idPerfil`) REFERENCES `perfil` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
