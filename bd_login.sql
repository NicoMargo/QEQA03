-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 23-11-2018 a las 18:00:20
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
-- Base de datos: `bd login`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `spEliminarPerfil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarPerfil` (IN `Perfil` VARCHAR(50), IN `Pin` INT(11))  NO SQL
begin
    if exists (select Perfil.Tipo from Perfil where Tipo = Perfil)
    THEN
    	if(Pin like 123456)
        then
        set @idP = ( select Id from Perfil inner join usuarios on usuarios.idPerfil like perfil.id where Perfil.tipo = Perfil);
        delete FROM Usuarios where idPerfil = @idp;
        delete FROM perfil where Tipo = Perfil;
        select 'perfil eliminado';
        end IF;
    else
        select 'El perfil no existe o pin incorrecto';
    end if;
end$$

DROP PROCEDURE IF EXISTS `spEliminarUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEliminarUsuario` (IN `Username` VARCHAR(50))  BEGIN
	if exists (select nombre from usuarios where Usuarios.Username = Username)
    then
	delete FROM Usuarios where Usuarios.Username = Username;
	select 'Usuario Eliminado';
    else
    select 'Usuario no encontrado';
    end if;
END$$

DROP PROCEDURE IF EXISTS `spListarUsuariosxPerfil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spListarUsuariosxPerfil` (IN `perfil` VARCHAR(50))  BEGIN
	if exists(select * from Perfil where Perfil.Tipo like perfil)
    then
		select * from Usuarios Inner join Perfil on Perfil.Id like Usuarios.idPerfil where Tipo like perfil;
    ELSE
    	select 'Perfil no encontrado';
    end if;
END$$

DROP PROCEDURE IF EXISTS `spLogin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLogin` (IN `Nombre` VARCHAR(50), IN `Pass` VARCHAR(50))  begin
if exists(select * from Usuarios	where (Nombre like Username) and (Contraseña like MD5(Pass)))
THEN
    select * from Usuarios	where (Nombre like Username) and (Contraseña like MD5(Pass));
else 
	select 'Usuario inexistente o password incorrecta';
end if;
end$$

DROP PROCEDURE IF EXISTS `spModificarUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spModificarUsuario` (IN `Username` VARCHAR(100), IN `nuevoUsername` VARCHAR(100), IN `Pass` VARCHAR(100), IN `Apellido` VARCHAR(100), IN `Nombre` VARCHAR(100), IN `Mail` VARCHAR(100), IN `Perfil` VARCHAR(100))  NO SQL
BEGIN
    set @Existe  = (Select Usuarios.Username from Usuarios where Usuarios.Username like Username);
    if exists(Select Usuarios.Username from Usuarios where Usuarios.Username = Username)
    then 
            update Usuarios set USUARIOS.Contraseña = MD5(Pass) where usuarios.Username = Username;
            select 'Se ha actualizado el Pass';
            update Usuarios set USUARIOS.Apellido = Apellido where Usuarios.username=username;
            select 'Se ha actualizado el apellido';
            update Usuarios set USUARIOS.Nombre =Nombre where Usuarios.username=username;
            select 'Se ha actualizado el nombre';
            update Usuarios set USUARIOS.Mail =mail where Usuarios.username=username;
            select 'Se ha actualizado el correo electronico';
            set @Existe = (Select Perfil.id from Perfil where Perfil.Tipo = Perfil);
            if(@Existe is not null)
            then 
                update Usuarios set USUARIOS.idPerfil = @Existe where Usuarios.username=username;
                select 'Ha ascendido/descendido de clase social';
            else
            select'perfil in@Existente';
            end if;
            set @Existe = (Select Usuarios.Username from Usuarios where Usuarios.Username = nuevoUsername);
            if(@Existe is null)
            then 
                update Usuarios set USUARIOS.Username =nuevoUsername where Usuarios.Username like Username;
                select 'Se ha actualizado el nombre de usuario' ;
            else
                select 'El username no se pudo actualizar porque ya @Existe un usuario con ese nombre';
            end if;
    else
        select 'El usuario no @Existe o el campo de usuario esta vacio';
    end if;
end$$

DROP PROCEDURE IF EXISTS `spRegisterUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegisterUsuario` (IN `Username` VARCHAR(50), IN `Pass` VARCHAR(50), IN `Apellido` VARCHAR(50), IN `Nombre` VARCHAR(50), IN `mail` VARCHAR(50), IN `idPerfil` VARCHAR(50))  BEGIN
	insert into Usuarios (Username,Contraseña,Nombre,Apellido,mail,idPerfil) 
    values (Username,MD5(Pass), Nombre, Apellido, mail, idPerfil);
END$$

DROP PROCEDURE IF EXISTS `spRegistrarPerfil`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegistrarPerfil` (IN `Perfil` VARCHAR(50))  BEGIN
	insert into Perfil(Tipo)values(Perfil);
	select'Registro Exitoso';
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

DROP TABLE IF EXISTS `perfil`;
CREATE TABLE IF NOT EXISTS `perfil` (
  `Tipo` varchar(50) NOT NULL,
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id`),
  KEY `Id` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`Tipo`, `Id`) VALUES
('gin', 1),
('g', 3),
('dead', 4);

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
  `mail` varchar(50) DEFAULT NULL,
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `idPerfil` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `idPerfil` (`idPerfil`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Nombre`, `Apellido`, `Username`, `Contraseña`, `mail`, `Id`, `idPerfil`) VALUES
('namae', 'surnamae', 'user', '1a1dc91c907325c69271ddf0c944bc72', 'a@a', 1, 3),
('e', 'e', 'e', 'e1671797c52e15f763380b45e841ec32', 'e', 2, 3);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`idPerfil`) REFERENCES `perfil` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
