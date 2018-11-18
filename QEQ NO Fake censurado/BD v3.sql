USE [master]
GO
/****** Object:  Database [QEQA03]    Script Date: 18/11/2018 18:26:41 p.m. ******/
CREATE DATABASE [QEQA03]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QEQA03', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QEQA03.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QEQA03_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QEQA03_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QEQA03] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QEQA03].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QEQA03] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QEQA03] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QEQA03] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QEQA03] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QEQA03] SET ARITHABORT OFF 
GO
ALTER DATABASE [QEQA03] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QEQA03] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QEQA03] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QEQA03] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QEQA03] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QEQA03] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QEQA03] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QEQA03] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QEQA03] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QEQA03] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QEQA03] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QEQA03] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QEQA03] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QEQA03] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QEQA03] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QEQA03] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QEQA03] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QEQA03] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QEQA03] SET RECOVERY FULL 
GO
ALTER DATABASE [QEQA03] SET  MULTI_USER 
GO
ALTER DATABASE [QEQA03] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QEQA03] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QEQA03] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QEQA03] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [QEQA03]
GO
/****** Object:  StoredProcedure [dbo].[spBuscarPartidas]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spBuscarPartidas] 
as
select IdPartida, IdUsuario1, Ip1, Puntos from Partidas where Multijugador = 1 and IdUsuario2 is null


GO
/****** Object:  StoredProcedure [dbo].[spCargarRespuestas]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCargarRespuestas] 
@idPersonaje int,
@idPregunta int
as
if((select top 1 idPersona from Personas where idPersona = @idPersonaje) is not null and (select top 1 idPregunta from Preguntas where idPregunta = idPregunta) is not null)
begin
	insert into Respuestas(idPersona,idPregunta) values(@idPersonaje,@idPregunta)
end



GO
/****** Object:  StoredProcedure [dbo].[spCrearCat]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearCat] 
@Nombre varchar(50)
as
declare @msg varchar(100) = ''
if exists(select Categoria from Categorias where Categoria=@Nombre)
SET @msg = 'Ya hay una categoria con ese nombre'
else
insert into Categorias(Categoria) values(@Nombre)

select @msg as msg
	



GO
/****** Object:  StoredProcedure [dbo].[spCrearGrupo]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearGrupo] 
@Nombre varchar(50)
as
declare @msg varchar(100) = ''
if exists(select Nombre from Grupo where Nombre=@Nombre)
SET @msg = 'Ya hay un grupo de preguntas con ese nombre'
else
insert into Grupo(Nombre) values(@Nombre)

select @msg as msg
	



GO
/****** Object:  StoredProcedure [dbo].[spCrearPartida]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[spCrearPartida] 
 @IdUsuarioHost int,
 @IpHost int
as
if exists(select * from Usuarios where idUsuarios= @IdUsuarioHost)
begin
	insert into Partidas(IdUsuario1,Ip1,Multijugador) values(@IdUsuarioHost,@IpHost,1)
end


GO
/****** Object:  StoredProcedure [dbo].[spCrearPersonaje]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearPersonaje] 
@Nombre varchar(50),
@Foto image,
@idCategoria int
as
--Se crea un personaje , insertar un nuevo personaje en la tabla con los parametros @nombre, @foto y categoria
--SE DEBE VERIFICAR SI LA CATEGORIA EXISTE, SI NO DEBE DEVOLVER UN ERROR EN FORMA DE BOOL (O BIT) @exito (0 fallido, 1 exitoso)
--select ‘PR3498’, ‘Campos’,’Pardo’,’Luis’,’15/01/1997′, ‘A’, * from OpenRowset(Bulk ‘D:\EmpleadosFotos\CamposPardoLuis.jpg’, Single_Blob) As EmpleadosFoto
--SELECT 1, 'Norman', BulkColumn  FROM Openrowset( Bulk 'C:\ImagenFichero.bmp', Single_Blob) as Imagen
declare @Msg varchar = 'El nombre ya esta siendo utilizado'
if((select top 1 idCategoria from Categorias where idCategoria = @idCategoria)is not null and (select top 1 Nombre from Personas where Nombre = @Nombre) is null)
begin
	insert into Personas(Nombre,idCategoria,Foto) values (@Nombre, @idCategoria, @Foto)
	set @Msg = ''
	select @Msg as msg, idPersona from Personas where Nombre = @Nombre
end
else
select @Msg as msg, -1 as idPersona
--//LISTO



GO
/****** Object:  StoredProcedure [dbo].[spCrearPregunta]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearPregunta] 
@Texto varchar(150),
@idGrupo varchar(50),
@Puntos int
as
declare @msg varchar(50) = 'Existe una pregunta con el mismo texto'
if((select Texto from Preguntas where @Texto = Texto) is null and @idGrupo is not null)
begin
	insert into Preguntas(Texto, idGrupo,Puntos) values(@Texto, @idGrupo,@Puntos)
	set @msg = ''
end
select @msg as msg



GO
/****** Object:  StoredProcedure [dbo].[spDatosPartida]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spDatosPartida] 
@idPartida int,
@idUsuario int
as
if exists(select * from Partidas where IdPartida = @IdPartida and Ganador is not null)
begin
	if exists(select * from Partidas where IdPartida = @IdPartida and idUsuario1 = @idUsuario)
	select Nombre, Preguntas, Ganador  from Partidas inner join Usuarios on IdUsuario2 = idUsuarios
	where IdPartida = @IdPartida
	else
	begin
		if exists(select * from Partidas where IdPartida = @IdPartida and idUsuario2 = @idUsuario)
		select Nombre, Preguntas, Ganador  from Partidas inner join Usuarios on IdUsuario1 = idUsuarios
		where IdPartida = @IdPartida
	end
end


GO
/****** Object:  StoredProcedure [dbo].[spEliminarCat]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarCat] 
@id int
as
declare @msg varchar (100) = ''
if exists(select * from Categorias where idCategoria=@id)
begin
	set @msg = 'Se elimino la categoria: ' + (select top 1 Categoria from Categorias where idCategoria=@id)
	delete from Categorias 
	where idCategoria = @id
end
else
set @msg = 'No se encontro la categoria'

select @msg as msg



GO
/****** Object:  StoredProcedure [dbo].[spEliminarGrupo]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarGrupo] 
@id int
as
declare @msg varchar (100) = '' 
if exists(select * from Grupo where idGrupo=@id)
begin
	set @msg = 'Se elimino el grupo: ' + (select top 1 Nombre from Grupo where idGrupo = @id) 
	delete from Grupo 
	where idGrupo = @id
end
else
set @msg = 'No se encontro el Grupo'

select @msg as msg



GO
/****** Object:  StoredProcedure [dbo].[spEliminarPersonaje]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarPersonaje] 
@Id int
as
declare @msg varchar(50) = 'Persona no encontrada'
declare @idPer int = (select top 1 idPersona from Personas where idPersona = @Id)
if(@idPer is not null)
begin
	set @msg = 'Se elimino el personaje: ' + (select top 1 Nombre from Personas where idPersona = @Id)
	delete from Respuestas where idPersona = @Id
	delete from Personas where idPersona = @Id 
end
select @msg as msg



GO
/****** Object:  StoredProcedure [dbo].[spEliminarPregunta]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spEliminarPregunta]
@idPregunta int
as
declare @msg varchar(100) = 'no se encontro la pregunta a eliminar'
declare @idPre int = (select top 1 idPregunta from Preguntas where @idPregunta = idPregunta)
if(@idPre is not null)
begin
	delete from Respuestas where idPregunta = @idPre
	delete from Preguntas where  @idPregunta = idPregunta
	set @msg = 'Eliminacion satisfactoria'
end
select @msg as msg

GO
/****** Object:  StoredProcedure [dbo].[spEliminarUsuario]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarUsuario] 
--recibe el nombre, (y quiza la contrasenia, eso lo veremos despues) y elimina el usuario y todos los puntajes que realizo
@Username varchar(50)
AS
Declare @Exito bit = 0
IF (@Username IS NOT NULL)
BEGIN
    IF ((SELECT Username FROM Usuarios WHERE Username = @Username) IS NOT NULL)
    BEGIN
        DELETE FROM Usuarios WHERE Username = @Username
        Set @Exito = 1
    END
END
select @Exito




GO
/****** Object:  StoredProcedure [dbo].[spFinalizarPartida]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spFinalizarPartida] 
@IdPartida int,
@IdUsuario int,
@Fecha date
as
if exists(select * from Partidas where IdPartida = @IdPartida)
begin
update Partidas set Fecha = @Fecha where idPartida= @IdPartida
	if(@IdUsuario = (select IdUsuario1 from Partidas where IdPartida = @IdPartida))
	update Partidas set Ganador = 1 where idPartida= @IdPartida
	else
	update Partidas set Ganador = 0 where idPartida= @IdPartida
end


GO
/****** Object:  StoredProcedure [dbo].[spGuardarPartida]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGuardarPartida]  
@idUsuario int,
@ip int,
@puntos int,
@CantPreguntas int,
@Ganador bit,
@Fecha date
as
insert into Partidas(IdUsuario1,Ip1,Puntos,Preguntas,Ganador,Fecha,Multijugador) values(@IdUsuario,@Ip,@Puntos,@CantPreguntas,@Ganador,@Fecha,0)


GO
/****** Object:  StoredProcedure [dbo].[spGuardarPartida1]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGuardarPartida1]
@Usuario int,
@ip varchar(50),
@fecha date,
@cantPregunta int,
@Ganador bit,
@idPersonaje int
as
if exists (select top 1 Nombre from Usuarios where idUsuarios=@Usuario)
begin
	insert into Partidas(idUsuario1,ip1,Fecha,Preguntas,Multijugador,Ganador,idPer1) values(@Usuario,@ip,@fecha,@cantPregunta,0,@Ganador,@idPersonaje)
end

GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spLogin]
@Mac varchar(20),
@Ip varchar(50),
@Username varchar(50),
@Password varchar(50)
AS
Declare @msg varchar(50) = '', @Pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@Password))

if  Exists(select Username from Usuarios where Username = @Username and Pass = @pass)
Begin
if (@Mac is not null and @Ip is not null)
begin
update Usuarios set mac = @Mac where @Username = Username
update Usuarios set Ip1 = @Ip where @Username = Username
end
set @msg = 'OK'
SELECT  @msg as msg, *  FROM Usuarios WHERE @Username = Username AND @pass = Pass
 
End
Else if  Not Exists(Select Username from Usuarios where Username = @Username )
Begin
set @msg = 'Username incorrecto'
select @msg as msg
End
Else 
Begin
	set @msg = 'Contraseña incorrecta'
	select @msg as msg
End
	
 
     




GO
/****** Object:  StoredProcedure [dbo].[spModificarCategoria]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spModificarCategoria]
@newCategoria varchar(50),
@idCategoria int
as
declare @msg varchar(100)= ''
if exists(select top 1 idCategoria from Categorias where @idCategoria=idCategoria)
begin
	if exists(select top 1 @newCategoria from Categorias where @newCategoria = Categoria)
	set @msg = 'Ya hay una categoria con ese nuevo nombre'
	else
	update Categorias set Categoria = @newCategoria where @idCategoria = idCategoria
end
else
set @msg = 'Categoria no Encontrada'

select @msg as msg

GO
/****** Object:  StoredProcedure [dbo].[spModificarGrupo]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spModificarGrupo]
@newGrupo varchar(50),
@idGrupo int
as
declare @msg varchar(100)= ''
if exists(select top 1 idGrupo from Grupo where @idGrupo=idGrupo)
begin
	if exists(select top 1 idGrupo from Grupo where @newGrupo=Nombre)
	set @msg = 'ya hay un grupo de preguntas con ese nuevo nombre'
	else
	update Grupo set Nombre = @newGrupo where @idGrupo = idGrupo
end
else
set @msg = 'Grupo no encontrado'

select @msg as msg


GO
/****** Object:  StoredProcedure [dbo].[spModificarPersonaje]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spModificarPersonaje]
@Id int,
@nuevoNombre varchar(150),
@Foto image,
@idCategoria int
as
declare @msg varchar(200)= 'Se modifico a '+ @nuevoNombre
if exists(select * from Personas where @Id=idPersona)
begin
	delete from Respuestas where idPersona = (select idPersona from Personas where @Id=idPersona)
	if(@nuevoNombre is not null and @nuevoNombre !='')
	begin
		if exists(select * from Personas where @nuevoNombre=Nombre)
		set @msg += ',Error: el Nombre ya esta siendo utilizado '
		else
		begin
			update Personas set Nombre = @nuevoNombre where @Id = idPersona
			set @msg += ',Nombre modificado '
		end
	end
	if(@idCategoria is not null and @idCategoria !='')
	begin
		if exists(select * from Categorias where @idCategoria=idCategoria)
		begin
			update Personas set idCategoria = @idCategoria where @Id = idPersona
			set @msg += ',Categoria modificada '
		end
		else
		set @msg += ',Error: Categoria no encontrada '
	end
	if(@Foto is not null)
	begin
		update Personas set Foto = @Foto where @Id = idPersona
		set @msg += ',Foto Modificada '
	end
end
else
set @msg = 'La id no Corresponde a ningun personaje'

select @msg as msg


GO
/****** Object:  StoredProcedure [dbo].[spModificarPregunta]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spModificarPregunta]
@idPregunta int,
@nuevoTexto varchar(150),
@idGrupo int,
@Puntos int
as
declare @msg varchar(50) = 'Pregunta No encontrada'
if exists(select Texto from Preguntas where idPregunta = @idPregunta) 
begin
	if (@idGrupo is not null)
	begin
		update Preguntas set Texto = @nuevoTexto where idPregunta = @idPregunta
		update Preguntas set idGrupo = @idGrupo where idPregunta = @idPregunta
		update Preguntas set Puntos  = @Puntos where idPregunta = @idPregunta
		set @msg = ''

	end
	else
	begin
		if(@idGrupo is null)
		begin
		set @msg = 'Se actualizo la pregunta "'+ (select Top 1 Texto from Preguntas where idPregunta = @idPregunta)+ '?" Por "'+ @nuevoTexto + '?"'
		update Preguntas set Texto = @nuevoTexto where idPregunta = @idPregunta
		end
	end
end
select @msg as msg


GO
/****** Object:  StoredProcedure [dbo].[spModificarUsuario]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spModificarUsuario]
@Username varchar(50),
@nuevoUsername varchar(50),
@NuevaPass varchar(50),
@nuevoNombre varchar(50),
@nuevoMail varchar(50)
as
declare @pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@NuevaPass))

if not exists (select Username from Usuarios where @nuevoUsername = Username)
Begin
	if (@NuevaPass != 'a')
	Begin
	update Usuarios set Pass = @pass where @Username = Username	
	End	
	update Usuarios set Nombre = @nuevoNombre where @Username = Username
	update Usuarios set Mail = @nuevoMail where @Username = Username
	update Usuarios set Username = @nuevoUsername where @Username = Username
end




if ( @nuevoUsername = @Username)
Begin
	if (@NuevaPass != 'a')
	Begin
	update Usuarios set Pass = @pass where @Username = Username	
	End	
	update Usuarios set Nombre = @nuevoNombre where @Username = Username
	update Usuarios set Mail = @nuevoMail where @Username = Username
	update Usuarios set Username = @nuevoUsername where @Username = Username
end





GO
/****** Object:  StoredProcedure [dbo].[spOlvidoPass]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procEDURE [dbo].[spOlvidoPass] 
@NuevaPass varchar(50),
@Username varchar(50)
AS
declare @pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@NuevaPass))
if exists(select Username from Usuarios where Username = @Username)
Begin
update Usuarios set Pass = @pass where @Username = Username
select '' as NoUser
end
else 
begin
select 'El Username no existe' as NoUser
end

GO
/****** Object:  StoredProcedure [dbo].[spPasarTurno]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spPasarTurno]
@IdPartida int,
@IdUsuario int
as
if exists(select * from Partidas where IdPartida = @IdPartida and Ganador is null)
begin
	if(@IdUsuario = (select IdUsuario1 from Partidas where IdPartida = @IdPartida))
	update Partidas set Preguntas = Preguntas+1 where idPartida= @IdPartida
	select '' as msg
end	
else
select 'La partida esta finalizada' as msg

GO
/****** Object:  StoredProcedure [dbo].[spRanking]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procEDURE [dbo].[spRanking]
AS
select top 5  Puntos, idPartida , idUsuario1  From Partidas where Multijugador = 1 order by puntos desc 

GO
/****** Object:  StoredProcedure [dbo].[spRegister]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spRegister]
@Username varchar(50),
@Password varchar(50),
@Nomb varchar(50),
@Mail varchar(75),
@Mac varchar(50),
@Ip1 varchar(50),
@Admin bit
as
declare @exito bit = 0, @pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@Password))
if (@Mail is not null and @Mail != '' and @Nomb is not null and @Nomb != '' and @Username is not null and @Username != '' and @Password is not null and @Password != '' )
begin
if not exists(select Username from Usuarios where Username = @Username)
begin
    insert into Usuarios(Username,Pass,Nombre,Administrador,Mail,Puntos,mac,Ip1) values (@Username,@pass,@Nomb,@Admin,@Mail,0,@Ip1, @Mac)
    set @exito = 1
	end
end
select @exito as exito


GO
/****** Object:  StoredProcedure [dbo].[spTraerCats]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerCats] --traer categorias
as
select idCategoria, Categoria from Categorias


GO
/****** Object:  StoredProcedure [dbo].[spTraerGrupos]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerGrupos]
as
select idGrupo, Nombre from Grupo


GO
/****** Object:  StoredProcedure [dbo].[spTraerPersonajes]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerPersonajes]
@idCategoria int
as
--Trae una lista de personajes, parametros : @categoria varchar , si se envia nulo o '' se traera a todos  

if((select top 1 Categoria from Categorias where @idCategoria = idCategoria) is not null or @idCategoria=0)
begin
	if(@idCategoria != 0)
	begin
		select idPersona,Foto, Nombre, idCategoria from Personas 
		where @idCategoria = idCategoria
	end
	else
	begin
		select idPersona,Foto, Nombre, idCategoria from Personas 
	end
end


GO
/****** Object:  StoredProcedure [dbo].[spTraerPreguntas]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerPreguntas]
as
select idPregunta, Texto , idGrupo, Puntos from Preguntas


GO
/****** Object:  StoredProcedure [dbo].[spTraerRespuestas]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerRespuestas]
@idCategoria int
as
declare @Exito bit = 0
if((select Categoria from Categorias where @idCategoria = idCategoria) is not null)
begin
	if(@idCategoria !=0)
	begin
		select idRespuestas,idPregunta,Respuestas.idPersona from Respuestas inner join Personas on Personas.idPersona = Respuestas.idPersona
		where @idCategoria = Personas.idCategoria
	end
	else
	begin
		select * from Respuestas
	end
end

GO
/****** Object:  StoredProcedure [dbo].[spTraerRxP]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerRxP]
@idPersona int
as
if((select Top 1 Nombre from Personas where @idPersona = idPersona) is not null)
begin
	select Respuestas.idPregunta, Texto,idGrupo,Puntos
	from Respuestas inner join Preguntas on Preguntas.idPregunta = Respuestas.idPregunta
	where @idPersona = idPersona
end
else
select 0 as idPregunta, '' as Texto, 0 as idGrupo, 0 as Puntos

GO
/****** Object:  StoredProcedure [dbo].[spUnirse]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spUnirse]
@IdPartida int,
@IdUsuario2 int,
@Ip2 int
as
declare @msg varchar(50) = 'Partida no encontrada'
if exists(select * from Partidas where IdPartida = @IdPartida and Multijugador = 1 and IdUsuario2 is null and IdUsuario1 != @IdUsuario2)
begin
	update Partidas set IdUsuario2 = @IdUsuario2 where idPartida= @IdPartida
	update Partidas set Ip2 = @Ip2 where idPartida= @IdPartida
	set @msg = 'Partida encontrada'
end
select @msg

GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categorias](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Categoria] [varchar](50) NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Grupo]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Grupo](
	[Nombre] [varchar](50) NULL,
	[idGrupo] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED 
(
	[idGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Partidas]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Partidas](
	[idPartida] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario1] [int] NULL,
	[idUsuario2] [int] NULL,
	[Puntos] [int] NULL,
	[Ip1] [varchar](50) NULL,
	[Ip2] [varchar](50) NULL,
	[Preguntas] [int] NULL,
	[Multijugador] [bit] NULL,
	[Ganador] [bit] NULL,
	[Fecha] [date] NULL,
	[idPer1] [int] NULL,
	[idPer2] [int] NULL,
 CONSTRAINT [PK_PartidosFinalizada] PRIMARY KEY CLUSTERED 
(
	[idPartida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Personas](
	[idPersona] [int] IDENTITY(1,1) NOT NULL,
	[idCategoria] [int] NULL,
	[Nombre] [varchar](50) NULL,
	[Foto] [image] NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[idPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Preguntas]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Preguntas](
	[idPregunta] [int] IDENTITY(1,1) NOT NULL,
	[Texto] [varchar](200) NULL,
	[idGrupo] [int] NULL,
	[Puntos] [int] NULL,
 CONSTRAINT [PK_Preguntas] PRIMARY KEY CLUSTERED 
(
	[idPregunta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Respuestas]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Respuestas](
	[idRespuestas] [int] IDENTITY(1,1) NOT NULL,
	[idPersona] [int] NULL,
	[idPregunta] [int] NULL,
 CONSTRAINT [PK_PreguntasXPersona] PRIMARY KEY CLUSTERED 
(
	[idRespuestas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 18/11/2018 18:26:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuarios] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Pass] [varchar](50) NULL,
	[Ip1] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Mail] [varchar](50) NULL,
	[Administrador] [bit] NULL,
	[mac] [varchar](50) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[idUsuarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (5, N'Dragon Ball Z')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (6, N'Naruto')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (11, N'Bizarro')
SET IDENTITY_INSERT [dbo].[Categorias] OFF
SET IDENTITY_INSERT [dbo].[Grupo] ON 

INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Lentes', 1)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Color de Ojos', 2)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Color de Pelo', 5)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Longitud de Pelo', 6)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Bigote', 7)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Longitud de Barba', 8)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Color de Piel', 9)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Nariz', 10)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Genero (?', 11)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Aldea oculta', 12)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Sombreros', 13)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Barba (tiene o no tiene)', 14)
SET IDENTITY_INSERT [dbo].[Grupo] OFF
SET IDENTITY_INSERT [dbo].[Personas] ON 

INSERT [dbo].[Personas] ([idPersona], [idCategoria], [Nombre], [Foto]) VALUES (5, 5, N'kukun', 0x89504E470D0A1A0A0000000D4948445200000156000000C008030000006839BB5B00000300504C544500EEFF88FFFFEEFFFF77FFFF00EEFFBBFFFF99FFFFDDFFFFAAFFFFCCFFFFFFFFFF66FFFFFFAA1155FFFF00CCFF44EEFF55FFFF33EEFF00FFFF44FFFF99330000CCEE00001122EEFFFFFFEE11EEFF66FFFF00004400CCDDFFAA1100BBFF0099FF00BBDD00DDFFDDBB8800AAFFFFFFFF33FFFF00001100BBCC002255000000000055660000DDAA772255550099BB00BBEE11FFFFFFBB44FFAA33006677FFCC77DDCCAA0088FF0088AADDCC99FFBB66CCAA77FFDD9900AACC66CCFFDD9955226666BB9966330000000033771100447777EEDDAADDBB99BB7755AADDEE557777FFFFEE44999933AABB994400669999BB997700AABBFFBB2200AAEEAA3300110000FFEE88558888EEDDBB66BBCCFFCC88FFDDCC667777007799FFCC22002266CCDDEEFFBB1166220077889955AAAA0077AAAA6644FFAA11EECC998822006688AADDAA66EEBB88006699BB33000088BB331100004466CC886644888866553311BBCC2299AAAABBBBBB8866887766446666335555550000772200557766CC8822FFFFEEAA8877DD997799441166666655BBFFDDFFFFFFCC1100AADDAA7755AA5522778888EEAA6644CCFF00112299BBBB991100FFAA44FFDD770088EEEEBB77AA4411CC9944996644AAEEEE44BBCC88AABB66CCDD6633110099AA77CCFFFFCC6699AAAA3322220099FF888877CCBB99008899FFEEDDBBAA88BB774400BBBB552200AA6611BB6622999988EE99330011110099CC005577FFDD55FFCC33FFDDAA11CCDDCC6611AA663388000033CCDD22777700114477441133CCCC003344CC5500885522225577BBCCCC55779999CCCCCCEEFF55CCDD33BBDDBB8844668899888888EEEEDDFFBB33554433889999DDCCBB33333377AAAA222222BB776633BBBB99553388DDEEFFCC77BB5511EE7711004488FFDD9966665588EEEEEE8811FFFF99883300555555AA9988AA885500AAAABBEEFF883311770000FFDDDD22CCFFBBBBAACCCCCC77CCDDAAAAAA44555500EEDD0055BBAA4400FFEE2255DDFF00CCCC00EEFFAACCCC77FFFF55AAEEFFCC4422EEFF5599CC33BBFF0099DDAAFFFF00FFFF44EEFF4588AEC2000089D14944415478DA74985F681BD9158747B235A319238F748DAA6818EC51859885C2D820885E0642215D1646A88358B6A22B30ACDC878209464826CD4BB3842008C40F7958D9594192AD020E5D88A114A2764509F606D7E48F778D9F560F011B822D6F1E94B51E0AA53DE7DC91E4E0F6CEE84A711CE6CEA7DF7CE7DC08D95A6D76B6664C4F27F3F9D959A3669A95EC5EA5B2B75AC2E1941CA7EAB8861EA5A1EBFCC364E2DC184F08898440231E5153536155EB6B61CDA7F5FB3E5114F125E308D0BC254B920CAFC1F03FDD91BA9DFDEEFECAE6CA5AB77BB7104929CAA776C5AC7EDA481F2992C0DEA65B19AB98DE28E29466D2F50FD2E974BB692DB47794EBEF98C0848C6BB5E614A56C644BA5AC2EBE3C9564EF8A700C4710064DC1A0188445C1D4F1F9FA3E5FA7DFEFF8345A74B8A7A96A241E535535DC8BC050E180332E8C06DC2EBDC1806B1382C9C4E4E4348E645228552D03C8E2E77C12C0DAB661E2A8C0E27EEFE41CC729970F0C409980433774223C39790E2A72F5AE158BA4F65627606D7D4D133B300158C01AA80703C013CE2D0029D3296D795C9F2A81AEB8BFB9DF05AC856EA15098F329BF691988F5D28E12644C4FA733D6623ABD681537006BE0C3767AB1BDF4B8D87EA8FCA9C960B819B7D1628AB26DBBA56CD608BD59196245AE75820A4BC01730AD07C5BA7720D2311F81EDF73AFD5EB81756116B1C812251154724168B8F882606EF70DBE6FDA8C795634D22D69C0D619D9D4DE2C827676B3503B8C2ABB25722A630AAAE97D2A8C1A99E638AD3B817D6981A997AFD28044BEBFBC2F8EDAB9A2876C4C340902795C28A6829ADC4D53F7FAC889B6277B3CBB1DE2D149E30BF72D4345CC0AA28138CED2DA62D0B029A06AC8B4B2CF497DBE98DDB5716DB17949769A4FA3663D9D516FCA3CF5CBBE464CDD443C4BA2507B610EA1631C549866520533828AC1457D1D741A8FB1A82D57A2AE634168B1156CE143EC4E3C495875410788E08EB2B8E15C2865029ADB9AC6D1835243C9D4FA2080C03B99AC0B55422A865A76A4675538FEA6881A103C6879317564AAB301E8FAB6AA8544A699A0A0A507B6A38AC89415F3070485821B078BBF442A8C0D62FF98F7794B14D1124D05DDB5C5B2BDC5D2D1404D0C05799E6B5F465459913D8C162CB82B46EA4AF14978A6D36F7F0F622E4F595A2BCB9C4D8386316606D3699A4BC704DA79435E7941549F2D27A3892407D933C20625EC53A91AD83A228B0FDBED6EFC0B23D8AF81681F5635AF113608E0DA1F27B659C2B7701729D4E720D08B9124413C23A334316400F900560CA3AE54FCA783AEF123AFC8098C20B2492F83F1680ACC6F0D9096158D51E2C540DA303823E116FEA50DE0AF0A0CA670DE00707F8096BB7BBD65D2914BE7D96759CBD7BCB47272727DB378EDE401A9BC5B495C1B45E5940AC4C692FB59780AA728D8158995EB42CFB7286C9CA3D0BB1DACC7F220D1E0E200B493D84C75FBEFF9D0C5985B38E66E527469514D083A30F1C7BE8D478843FFF312FB111A819B1334C8504D37576265B9E02E84D28DDAA44A38415C0E28BB8AEBB0671FDA4EC941D2797D575201D1D8CF3E56A9C6C83531C9F1D58451F970201E860683112C3B41252CFB09E036E3E55A4B153C07AB7BB7277AD94CBED2E1F3FBCA078E3E9D7AD75C0DA22AC1B994C3BD3169872AD7DFB47F8CBD76F096BA681582D16504E2C3397AD20565922DFBC57B2564E03E4D5915D49AE9C2B54019C54CA28E08CC4223CB9DCAD706BC3ACE2CC9E3F62C2002A650DD24A584102B95C0594C9B9DE9999E17975D7D10515CC2B0A3697354DD788920112D17356C56AE85546C1AB9F9A46679864E5438F05D1AD87D80390566569D408F8E7E715796C99D25A28DC5B3EF67B4025599425FCF0616BA358F4B05E01AC5126FDF0B31B8A5FB9F10E0DC06C08ABEB5EB65950596E9839A3E230FFB23C6A0528AE6457346B00B34A7AE576ED506229AF1AAA95838CA93121AEAAFC4FF043A861712FA7FC8DBDFAB3CD12C200C6248F2B4C93288117253D3A4D582F5EBC38F380FC6ADAD40E20528CABB35731DF9100886AF47C58877D400CB06AC41534A0F5FAA20F128BCF5A10EB854C5AC5946258B7BCB87A587DFBDDC2CAF10E672A89A13988E14FCD75C6266445F9BAED612D5AED2B6D93F9BE780D54AFAE636BC512450C6B7588D5AC6C33698015EA2340F5025BFFF7A0B942B77A1610A903ECC093055985BC62C9826E6A54B1A6A642847590539E2276FBAF3F50E91A1F6205AEE45748EB8B92A1CFCE4E2791EA45882B60B56D97F4EA82E270949CD58AA927B80126CFB7019E04A8B9E24BD150ABB0CA3111DB425C3724059F7C59E60DAB97D51DAA58803530B6D2D95CDEE1488313293618076500CB44E5B74B0B16617D0C696DB0D4E7F0BB570F8029A43593B1AC865D6E7A58B70D13B01EC19502A3BCD629ABD85C615ABDAE15CB168A007A01112D8079257D45D43854A8488F6E263CF5ECC914408E9F6D5B21ADDFFDE20FC230AC03AC5EC9DADD5D7D9605AE79C27A315F03AED8BBDA50CA2A03AED552C5C45E407FCFADE367B602FC4A31FEEDC2A3C4ADAA4DD0D3D509D60FE18E645EAB78A5DA9247258B633D269BCAC189A9542AFEE4C92A7E953F01D2BD1682952FBC5E5CC49AF5B80DBD009B3B5A56BE40AA30CC62C32DB68CCB0D1BDCBA6C557246F616621DC6F58C5C79C1A24680CA1685B5EE8900B8C203066D6B040C809DAA4659EDDDFFC797DFA62267FB569C99DE10D810C324D52CD20061CDEDAEAE422F904F5256EFE41FE493358337AFEB1C6B158E3D2C5AB42D4870BD8E9F853B001B0B13D5B00A39F569611FD6807E1F0B04C685728A521D552BA28A583F3ADDF1FBFD37836313A1FF40DB5AF8571686056D9389896D01DE29E56A1BB86E584BE98D25C64E3FFFE701A372F5B698B11A971A760B7E173B0137A757BDB40EF6751CE9E120B204160B173559756E02FCFED1023D8D97A8417F3515FAF8EFBFFA9D93F2E29A189900AE2E9CA959030BC010729FE5760BDF18865D430BDC793083076CBB0CEA5FAB59DCBE3AD52A34D8A631D8148CDC3A1E25A8E3094F02319E55800B85AAAFC1E3EFEB83076063738866F5F6565EB9DA99F77B5C6FCEFB4F5EFE71FEF869B700DB8135E8B05661403D775D0B1EF0046310D80653AEB7B166C1560B3AACE097DCAB8C2D2C5856F152AD597E6C60DF6A57B3E6B6C3A413BA105CF4A33AAF5954B5B072D683C3C4525411AA8FD6DAC11840ABDDF3C0A20142977FF9F2E7CFD51462F6360489910A0654A323AE4056C86D8306F6A2A65BCB63CD7A907F00650B2C60B8D8BA024E07D0425CB348D5FC9FFF25803DEB50ADC415DD1AC6358EA1B320AC0035B0257B521D36ADA7C8154FFFB122ED63FD977CA14E776D6D6DB7F0EC196075812B805DC844D94175BDC8945FC3DEAA585CCAFC4D60A1AF18ED0398B5D8B09A97D001964E9B57C7B56F65A11390782FB779AB3EB0409D4B20C0D32A7ABB02CFAE70005794804ABB57D400CC21F5E347DF3FFF668AB6AF31E1ECFE95FF47C87B61450D4C22D6DC6E69F7BF6C5A5D685A691A8E1AFF4E68939E204D441A43090E2C390D083D3707BCC985A2C8212C12E807B98897E2BADD286320ECC2320402938BDC688A8B9BA95DB2B0A0B0BD58870656F2C354A6AD6CF162C18B290994316D2E92E8C532CCECFBBEDF774E34CCD128CD4DCD739EEF799FE77985138E2A80B82E2DEDEDCC80C0FA4F0156C05687B3B89A8D654FF51B6DE5741D1DD200BA75D334B090AD24537D8BCD822E00197286F67138B45AC38E86152FA715DE6DFDDD0688AB6BF28E7779B9D56AC5D6D66284AA0EE388A9F255763F08B87E1B0C260FD25F07E4B93FF9685E5DA554A5C242E05AB5D2F5823455F747F558E2BDFC316725BD29777B6ED361D95D8604901D20DFEA22EFEA206DED9321F4F6A96BE1E17572F2DDEFEAE377D0C5C22F4C77052FA302DA2169E57C1DF92EFE260EF61910DC7CF89066169075099B018F8FE2166A5C365BD2F500682A0558CFD0BC1AF4ACC4D509F056A4AC90032C364E552C0488AD7C621D1163AD5D87A3D19410D695A664B1B47777BB40D83B93DEE5E249F14D5C0B681A87153496795E5610D7FF1CD458267DC064F913880038304015640134A0AE95E4A8D465F091B35B57736F1B56B7DBDA2B3BADDB6E93AD80A89D1F7F812D3A010358ECB038AEC8D8FB22B382B6C243C481E9E9E91B2730882A0F5982B00F1F8C2412894824FE1242FFD24354D719D257C415000454F5581670D54F11568FEFD752D68D0F2058BD70842EFB16BCE14057F0562E1E1D8D3A90CB29CDAB1557AF105E91B8C302B2E4CE97737F94A4B1B9C9E2FF4E4E62DFC069D60854452DA929CD777A5A91A52FBF65E924ABC9F2761D9535C54AE9200B5536EB605DE537D2A712D8EDECD6F5D873FC2FCADB70120E9DC856415601AA9DFB5664A9CB48B1160C85FDCE251C33AE028671BD43CD002AEBF4C830AA588622021E915D0D751D79BA985F4CB45E213351053068CDA01B40583DE807F4FD7D8455095027803FB71CAB595D518AC61030C1AB4B6F07F3159501F6235E5B91D81DA19E62C5B2622F343A9D065A80AE64B7380E0FDBCF76C18E3A16E68E63B113FFD693ACA26B40D792A2A64B4CB93A3D85B9F5FD176996AC05E4FB5720AC8C610BCB429A52D7D4C0C58FD222E856349B905D1FACD6F09B069C855E1845E0CC5D80BBEBE221CBC55F4426700879C58975D9E7D5C0A5595C61C49A98F022ACA3C8D7FB37A160944FAC5193AC1C571C59F9F5C5FC46BCFCCA13D01E20AC7B685F771EEF8119F050BFAAEB6BF0494FF7C909F86E190183AE7451393941D9B5DFB79077B5B8ECC85637F82B1200A30A70D25B73C5D168B41D611002985936C7F9F6F9F9B31608814B968F63AF63FEC413901F222CD05565D5FD4AE56A41FA6D4A65A9246585648AA3CA365945533D571F5F04C1BE4036941B0DA95CB64A4EBBB54C4C75F3918578DA85B6164441C8DD2BA980A5DF86A9D5A688382E1A42FC7B28BC025BEF8D0B1D303BECC1E42A6400615D5FCFE7F391F8EABFFC81079CAD3BA8B03F115D7D60B240DC2072E9B421F0DDEA0408D30B43C445D4F37AF9B402546D169C56FCCF321C00B2B5C945E0AB1557B8D7EB753A5D898BEBE1E1F9F6B355C0D521CB1E652B1A781A519F564805F04A6E9E0683F2DC3FBF4E3356436BC5705C05199BAFEA214557E57DE953C5AF476389D385E7B9724F92ECB2656A9737D9E6C422E75A10D816A8CCE26AC06B01DE0C105B27EE9119301501861686DA69C3BBA2B48E0C465743030056407503EC406BCD0F5E804C16E00A3AB0E4E7530B41D5F0C12BEC59CFAD34306B0E2CCE54325660AD78C9E2C271C545C0E91EAC573065399BF642B8D168143AE16E53725920BD9E6F2F1F0B5C67ABD18416899418C755A9A659AD5AC90465DBEF3369F65F8809A9949A8671C542751C5820AD2D69510B64B3B127D7635F969D923409E1AC7BE8B49B2D16672A7FE3EE8AF7D934BD4439D8FF8B97B7AEA265C1F66542EC0746EEDDBB3F905F69680DB2D5F05823F98D8D7C1E506DADAEDDC5628022ECCEE3A51D340300AC5FD74861D114F86E32D6C06548380EAC8971DE5C81BF429DB2D988AD582393AE1E71AA9A01ABEB7684C38D5E2F5CE834A69C160BAAC0A767C751C0D522CB3E259B5016172B0C81D592F3F3F54A287490D997ED7F48C1E9BF065455443535AF682190DFC0451734009435FA34505E212991652957E0B0A21F29885D16DF1010B422C3125F714500DE956F08062F8A072802D8134C0F34D9C25E1AF68A9E145E37F2EBEB91562B114FAC79B01EA4626046882BF115A00D68445982F5EE105B7977352ADF44813E12D6E6152E80E2959D571E476ED304705CADCDAF5C618E6BBB135E011538DF6E035D4FA26F89693E45899416EB151654D5F9F5FD6B5C51860E928AECFE6B92B1148C2BECB4D83CD390ACEAF5D5146800A871700BEE8B15DB9AF7CB5299AFB20CB292C08A256141509523DBA1ACD5B1A0BA8A006BA2EA35772FF7C6CD40606C5D7E8DADEB9FF3F9442B9E887F1703723E78C8C9BA83E28AB8D2420088AAF935AC04EE0ED92B51B78EC82FC14252CF8A2280DA8AC28A7E90E2D5D919D92BC3B49A2B0180B5E92A00AEA0AFEDC376A757E8205DCBC7C72789A6F4625A96038AFEE74A9E55D8BB77EF653F4BA552494FE520A52E3CFF42652CC9510DCE2B5520ABA2CAABA0015A25B8D89088EDB2BCFAF4CE54D9692C5F0B66DF7266142EC452236871C2125B8761E51A809B432C0AA6CDADABE1026E92ABE107505BD7F32DC4B5A8035B055D1159485A40549C537EDAC1A0C1A21B332803A3E85AE5D3DF8CC8C8556A81BD1D78E2A6859A6B3B11C5ED36DB4088024DBE1380D0DAB473BA861B886BB887236BB7755C3C894C49FFC075AAA2E7EBF5E0BBA83C0BDC04635549553307A9E4DCBF93846A4D9035A4954ADA75EE05F3B3D027AC16A9585C7DE273BCDD76F291051FA3E0E24576416CB40D64E985272D1402DA15093DBDD100D0055A738D0C6FB50743D640784511C883042412C535135634037B9B4B9B81475C5FA9250C78C4C41A6E5CB1789CFDFB4B8015790AD725AE5B39AC88EB918B34805314DF9B6E51B46217E07608BAF6DAEDC3F3CEE12E70F5CD72B1A86F491FE3804CBA5ACAAFFFB000C11F743495C9D458329D01DAB2245393846A70BEAA105967F75F9453F50F582E8E41A8FD7935F65A1B71FFB8E2740F7C4D80D75882ACFCE970DD00DB2119A09405277F6280ADF0E3255C87BE2960FAABD941B222AC2002A402ABAB455ABD70501FEFCC00ACFE479E47DC0F10BCB37C64DD1D5C0BF003F172EE3E9F99784FBD6390572CD8061488AE677C29C0711D92016BD3EAB28741591BB95EAEDD3E3F6F03B0C7AD56B17852FA20BD7D2FCBD76AF533523589331F50AC656A4908590C2500FE9D0AA60ED42A43B2AA905CD75B58D9BAB081B98847B7626BB25476DEF4D8762EAD76FAB28079F1D6557095AFB6B17625382FC5E9874080DE15AF6963EFC23DD66DB6726041043636229144221E8F467564EB0C4D2C74AEF835974794B578FD2ABE8331EC047816200900B68EF5BD1363365BDFD6B7F03DBC8B76F3B414B8D5B1F2A21554006520DCCB6DE76895F5CC7BDE7A5D2CBEF7B3B7D2DF2047F9BEBF9035984D10FC6B990C56AD99A00AB8A6D3B58383837996095695753460DA45B79BC3F3BF808EF65542DF8AC5AEE75E94ADEE01DFCAC115E1D5685B0D9F25B495AF60BD869C12BA13C896F171B31B34EC95A1AD836C256DFDBC11D9C86F4400D5D5988E3B82991D4C04337B7B3F01B060B280AE1AB1D52720359759A3E6CA55EC5ABC36DA5C82AF42AEA2994158796635E83AB0C5C6A2B509010C65A07D988307E05A6E5DFEB2FB3ABAB6E6AF4BD237D772FE4256FECFB6F58536B1A7D134357F3AC5DC3812D4107A5344B23E64529887791910E422868412CA52B2CD40C1E4310CC1CD8815CA2E2C974021457CB889254B2944F0C26AE6C1872A7758C458BC856ADC72592EB70F2B2D94AD6E1ED25658E8C37EDFF7FBCD64AA3B952A72E1EAF1CCF79D73BE13AD05F249AE5849D9B24CD3ACC8255D2FD7DF9B8A9EB4605FC972A725953CBB17B7BC82F73CB9AF4C465D2A26AAE22B5619EAD295D00E5C1B3E1E0DFA8713961D63798C85C00E384D59D049C291BB5954AE4E5360F2548A3DE1B015514D1716D3BD6273233E313133B306B8AE7DBBF600403DA98178C57B613C927251F5B416A07F3BA69D41587DA61BF6088C2866B8F960A595E5755EFF4D862A7CDB0C00516EBEFA05715D5E5E5E79BDF2702BFFDF73BD6A2E93FE9B202C5D3B0254C10B48F23B5391F44EA58EB89AC054599714BDF34EEE284A4B6F29BAA7277C104629D78EA48D2A58B4DC517FEE4E970D01DF1E77AF1C5B566D613996DF8E07D1126067004B18E1C13912563401D0100C9C2576C17578B1213DB5B110D6C542617121B9D0CB3F834D0F749D39597B003A001C018E815A8A6D2D3B0B88B8C9EA5459C8B7E28B0244A509807FBA2027AB8FEE57C456C2B2EBE5690B4A8179A1711371056481ADCBAB0F575EBFEEDD6A46AA1F5E8ABBFBC25D9C0080AA9E4CB6013F4DE9C8EF01D7BAA5753A3A4801E0AB26B5308A891FCEBDCD13A831A9904B2C01DF55B177B1C762731E613990B2DC95D7051A4147633530762783180E9FB3C72A413A080FEC29E0B9E41AAE6786258161E01A02975558BC974C622AC0615D3B79B0067380622C1C03A9DA70AAC21019CED633A752164CAE6065ED8CA368A55BEB1E8B5A793F888956475B718535FFA7B163F86B81BC828D756739BFDACBE7D737D27F9E1B152352E11F7DACAB0068F0AE4B4A094495A6CBF5725DEE74CA15590754C12768BAD26A699E8CF0065FFF98DA2A54734B996C227B74F8727ED9AE60345890DD60E8124D51B1323FC0B52B775A23605F7984855300E902EAE61BE6BCCE5128F08510601B6BD2BE688770B622AAC985E9627E1DD04BC56B40565859F00D1C019E0970BA3A2E801D5C9C31C06316EC5C84797E8DCF0ECA003A61F9C6B81270662B0DD74D42D60BC275DEDB3886FF14707D051E6B35FF70B56864E6BCA22727D5926F458F26499DF6BBE74055E02AACAA926E3EB53A7AC582392B9BF05B8936A2DBE91F086DF265463A9E2B189944352B66BC9F6E069C8BB66B69055D6501C76B21C64C0B806E75EC2BC5C74CC646690C5C705DB1BE5202FCF20A6C5D0054EF6186556C3E034F159F415881ADB8B480ABA8064067E1700DA1139824C23AF2CA2E5EE1EBC2BC00BC43D86A1C41998D052132AFDC08E0FB4F8A157F2260030702282C3FF1F5E3C79587ABF95EFAC3C551F057AA2ADFF08B3905515510D5521BB42A28ABCE7BB36355741DA0352B1A5859D009A5C8F3FD3BFD235D5133B371A36018D544D6739817B6026CB0FB781793DD09DDAA9537B282DC678D503030F8EC0C523603C0E884074CC8BA936C9E0D46DC6E80C6800751058DB5D4CB4F379BD5582A5503381F9CD078A5CEC04C9CC92C1A042167B49E71B72E80AD619C00E3E3519CAD23786D63EA2A4865962EEF08BB52163E09BC075EC17F8C1932CAAB95957C6FF6AD3075A4AAC6ECC21FE117886AB285A82A889E8663C0520055180812F05556CAE06AA5D2D1951B7F913555BD7D3B9229B4700454C58C6F7ED9CB8B02C326E630C6726E5A4C5C71EDCAB3962853016C0A1061E0673CC55CF0B8A31657AF6D781E0058EF0155410D2CE59BC5E676B31AC19D05B09E00AC6B086A8AC42BE21A628D9688CBB732B2629B8DD84A69C068740704963F08C0B2D3E0DE98DD64710901DBBD7ABBD8BC386E8C8C10AEAF9BB7F603301F8DD9B4217F124455511550A5F0962741F5836B050B5B0695A597D168E99609B0C688AE935784B982F69D11BF7DDB308C0490757B5D589D0FD865013B6E6D386742F6BD4172802503CCC0EE50B0C9CBC30826C715FF86C4D64B4EDAFA95CB9AE01ACB934450616D4DE78BC56235164AA52EAFAD21B2D8C762A8C691AD13886B087F0C8580AB294C6FC978344CA0E2680DD2219B7184C2569C0178BF0A7049D0654300E91A1C394687056CDD987E14149F65DFCC668C9639E7F728520B51557458FD26682A5DD1F4CAD3B2FE6B39562E97CA1AFC565912735A4BD162538270578AA76F4B88AA14EBEF0637B7BC4EBDCD5E569460F9EC5ECB70C8B2294BF5C1CFBF60D335CA5CD5E01BA6AEA2CC146026600B57574BC03D0488AD68B2F00BCC6B71FB194C0118AE27F0CC807A7D60B335C5D81AA2211072D72FD9C2C25B4B341C462B802701ACB4D35EC5EE25E52C5D1E606FF2E8AACB5D16C0FAFD81E01D1D3DDEF98864455437B24B6F3286D15A10A6628A744DC102465291AC4AE94445647F5F39296547C5D8AF8A051E41D714D86B3A6881C9B3C21D2DDD6EC1BA5273EAA5CC944DD6AE6DB3B87D057DC226AADFB9163270F10F4D6D81E85F515185B9CF2258F1130544E04BFC50C8C97AE6CB4880C10A442DA4F10197F5530CAF2CF8EAD700574096A6C004A01A4A215B19B0A7E4D5249F015C5E81BA02AEA2A8A6433153023403BA01F763EB2B7C0EE685B171C275A5081260BDB8349DCDAAAAB42488397DA1DD6997D4E73918009D78DBAA5B9DB25533AD47825F6C954D3366E95A9955DB9496281C24959661E412AA1429F6C71E6D7987AD7AFB9C1564F635D8700CD6F22BDFF0F8E2F405F87D804D8030558848BF46798635C9AB022E5C2786B8921D282C2E2EDC5B286E679FC51271B506B2EA047185E1BAC670251D4098864E7901365A91AD4057FC9F83A526E73AC25F2B325930045C9536642C73599B1CD763AFE01B1F05E5DAFC245C59CFFE8CAD5F55D26E7845450365554AECC665AB944A24EB56C52A991A58ACABFF16CE8BE5B2E5499694B2478C039BC1BE06E664A5DDC62B78BC787845D89A673D5A365A1B630D676B359CF300A0FCE36F3ED7E2DAE15DACC1808AA4206F70BE61A6454B8C3E02C3B795BB80E54E5A10D634B275F11EE881E9E676763B9BCBA9F1991A3E2727DFCE60ED3D05B88652CE0C70C55767EC9E20DDD158EB821A82BC85E7A77B1CB3593405BC5FD095ABD73B80EBD9D1571FF3FBBE0BCD5BD3D56A35A7C41FCF8D4C22094BB1DD98697522EDF72F2C782A6605C0B5AECE0962AC5C3F6A9795F2913899D454A9D41FDB3795B6842DD2EC365077D51BA05B2FCB049CADC5842B67ABDF57F8718BB395AA182C72458985CA35CA352BC08C05484A5E4F5FB3BEBA1032B61600571459C9E477006B364B11A0DA01CA82809D416011D508FFB23F35C0AAB25C5D5D42D98AF7EBE8386A2B4495D81A64D418DB73155A3769B03254BDF61CD8245CC73F7E12CEAEF76E6D6C6425A92F3E9EBB92808D558AECF6E5DF8562FF7972FF07EB45BD6E3DB5AC7AFDC5F5AB824F94AEC70E4D5058A2C79225498B01ACED16A0AA1A457154580AF0D677D7ED071A2C1664992BB1F5A113BAF046262AAC1DB6FB791830FCA29396AD04FECFCA626C9D045831C84658AF15B3DBD55C2E1E89D75415D93AC31EC095144028743AC1B6B721FBB040383A1E458B45136084B4003C7B24C44FA5AC6ED14A3BCB1B10BE475CCF9F7B2B5C686E3537B2D91CB850E3227E7A458BEC1ECA1531F1F7FB4F9EFCE1A2D0AB5CAFBFB04CE3B7BB3FFC4B98F2BCC8F52B8AD217C5A40C9B0DD85A915478DD8C5951147E7EE90D044E7D348B1F8179D5DDC7E36C16B4D9A98B7D286477C27078608B2B0A0BC91038F6757876097D49570FA14AB02E6432CDEA76E6712C9E503B882B03F5F2C465A02B9356A12F8AED8CAD886A1461FD8CF915CE00BA0EFA195B59019B4EAE5DFBF567E6D5612BFCEA13ECAD9FF6C7267BD3D5EDAC04FC9BFA00A3B5558A1F3E6E9B62FB9FF7FFC7C6D586B49965E1F84E35BEA7D4DA5B42A304495A8A0C4C924258A425983FA1ACD495303FB4A381C0EA32503AAE6895A68B5AB63F1C0C75FD632DD3EC3A745FBB69A7D281D9E934D42261B3DD3118DB59B74C87BA603782346858D4E6E7B2F79C7BDF8FB89B8A4D9142783CEFB9CF79CEF3DCB17339408D3A164313FC37FF3CFB74DBCE063436D0E7E343AB179305FBD01D4054933D6C4F799707A9EB92295B6E09851D536C0A6BF582350D59F2851A964EA908562258A2BBD61F356CD91ECF0173ABA4018E3A31BCF23FD7BCA16B8317F8F87A85F7567E928A6A1519381C738906782AE601C33B877EE5C6C3BCFFAC931E4081BC1AA161D75667AB556BB5E29CA564755FAB78A1BB4D192942C659F5E7E5F6DB4F866D2C3505E7D5FDA8162C150A5116783D3DD3054A8EBF9CE0743AE79D3033B6B0022C9966CFFA8205567A11E5D4751F5639AC415F1B8B4C157B8020CD4C19EB0175D63CB1745FB60553DD8621F62ED405A803C86140A435EAA5F35577601D3A7860195316A1CA718DB77576AC39DCE408F0251F8962EDE74716E6E2EA8440E3315AABB00A1BD916EC00BBE5F261DE0438AC48046A842620FC2C59AB80ADC8938BE349C0C2F6885D018E6B068EB4E76F73EECC0AABD0F3C71A17A7A48554927939AA3904753CA7BFA0EBDBE9DF6ED7B8426CA03F9562A917015EAD0CDEF1F135D2C9B476751920FB7E2AFF3093A73061B52E0DCA9D8BCC11CCCA08AC845638DED7D70957EC02421814C52AD82BD56BE3B1031A569D59ADA25BDA08529C60C36D9D9DED7BCDCD2EDE5EF9EF3CC8613D35D14789CD537EBD05382AF56BC95B456A9877003CB30415A8D515AC6AD5AA0888425574115B56EB5C2EC31FEDCC1C9CFEFEE5F313CF59A11B26E7BA8F472EDB10D58D85D6738A22E01C97DFC7A175666C482D85D8E560C1C542DE50D4E76B87B71CD6B6BDA85675F5FDD4E45C7135579BA5A58BC81061BDD69AD2808565C97215268C2AB40B90CB6D576882BBA2588F1A5DE16883850958250187AC3ED204A85671A115D60A11F406A12B0061C54AFD98729BF4BFFEC77D29CA95B756DCB71E46E18AC38A2276CDBADCC0A3AB356BB884F8E36FD7A135FBAA0223EFA13812E3636C69B9BD619F15B6729390E93E1E75ED69DAE137AF5B4F620318370A769CCA756CEC0D70587F7269AC3410F06A3E5F074CB604C33E6DF0CCF57C9177E2E21A3BBD6C24345573976565AF160D4B68AEEB24B9628AA0AC9768A33CB0C438808E37E43FE694E538D0041C0ED904E26D9C1184D3C94832996AC6516B2228BAC0293AB2B00B90FA65A157C60292B71A59ADFCC921546517A8219F103181AC55692186451D5607B623064A265F54AFFCF239A7005BC53CC0B6F374CB7F345673F54FAD2715FDE957C6E9DD3CEFB1CAC2833C34A7595FAA7026D417F0FA7CBE2908FB92C9E1305BEE067BACA3C0F6CFBCE574C09A2434260255606A48AFB57AA66856E408D036F8AA7CD4D8B7E810EF92528714EB446524ABC904159B8044B5AD8D1F5D218D8AD5EDC284064AAD1FFB25AA4D7506A61572009D58C7712B598F9121B97315B967FCA0C2DAAE3BDA62A67E95AB28D7626F0C20B3AA5EE93DC151E5DD008A1BD0C0B452F5D5C78993E2B0C2821D3FC771256439AC4F63A0156CCD81D33FFB7222C4618DAC422832C151BD90A9DAD30A8CAD5D78B90DB25AE5925082BA69ECB5B04C37258BD5B5411922C0CD8B85B6369A1C169B4083305FD80E9E58B83D21580D54AF85D2510EAB0B5DAD41F7847BC28F836B93DF38B2AC5B0193081C136B098C607158E594255DF922EB2E2C98B94A4DD01C5E39AE7FB9B80E5B5BD591DB7C0AC88C002C0FC481A534F5FA3F10558540E5DFBABECD81A856C8BD5E811AEF3E0B2C4228D01F08B5040BCEDCD7EEE11DB6B846D14347CF70E93AD8550B7535A72C027656065F6A4D9F8B4C6ACAAD362E0A1B853CAFB32B42F7E889065B83E5CCAA33D7AE0EBD0920AAA33D713E0EC4C3A3E948CA45A62B37DEDDC051457645B4D563AD558F2544D3400601FC75F26E74186F64A892B1415A65896B1954AB7E6D57B2B25E75D60AC5BFBE3CF26AAB7698B9CE8F6460351D88F6000BD88B4B898FE850132D005A1F748168AEF0E9BFBF878B01567808BF29A502012DEA1986B72DC91DDB931BA935C63C2D3786D95D20BF87D0B068FD23FAAB3AABEAA917234D2063DB32F42282C5BB4211AC18B368F372CC2402874C22E0684294C8A766A35A1D15A886C3692D857916B7DB1FC4BB1BFC7E479343D6AAA3621830AE8040AD151D1F946E5EC7068BBC75B64AEC0684FF52B506DCB2075B00BE81A9232F53CE75379BCBC5201FF5852FDF8542B732347D09C6F98F454B55BA1FDCF944403C0E893B9BE065A9B7B0F29D2D75D9D71764790847AF794A2B8B8CB91EA5DB7C6C704B9181A5EA8A7DD6AC5520A8A5B960937FD55A9B2BBA051AC5838FD54AEFCA92BDD29C25696BA52E28DE23ACD7E23D84EA4E9C53AC78406B76D115177E375A04FC4D72375331B51E324BD5768CC34A5A2BE7569CB4F26180CE518CBAF3CFBAA98BAD86F742916D40C2A98FAFCAD617A7279D55AC771E203CD012D706DEDA3B60693A217B2F3EFB1CCAC743D38A9378ABF3DB15C8A7BEE0A83EF88CC3DADFC234273C0BB84B838C35F7FBC2833E5B6155B1EB3930ECADF4DCABA85054EB4BAD4DC10668B9556D4883B3641842154BCC00825535EEAED3A825D4163DF7566913C03E89A83A6C715405719D85B086D3E9888B2CAD0EC704DE8DE3D719ABE5C43AA467863CBA5598F6938D65FC2C54AC24B7D49A3E2155B52882125EB35A698885776716E78FEFAD422E3D909BBF115D7997C9DDF2EE7C0A046BEE3E7FC339D5BF8616BA141CB5E09B5F4C293DB187F9A1E9D7BF6385AFFBD8DE43D81898285D60AE161FA2EAD9BB0732B298356C58AA2A2658D53CBD04AEBA6D406633386F451B89A8D77A51AA8264958DDB716C07AA55CCA106AC12D5364E5CC3A1E1C161175D2082970CE15EA0CE54038C55F621233448B8A28A8EDD15A756F185420B3F5637E5222B6B49B966ED59C3D56641D5AE385FDE86231DB095F63DE433FFCED2085CBFC958E0BCC075E47EA20B5A5B3F1F5A98E13F75765D5AB8037373F19DAFA67F0C7959FA2756BA01F93701B61FF1F50787E39ACF5D7A08BA99CEE8ADF2DC52F5EC9B95118853CBAC56A1651B325623C58ACAAFE4A2FB84C4D5545B3DA209D451C8D2611B8DEF98A8860631DB4AB66B3F11015EAC6272F0D4FD9F4B843C7A1EB37E97AC57E2E111079610DD4815D4A5165D6ECD597C02A26A29FCDE0399ADF9B45BBB073988DD89C56EA29B22F07720D5A0E7E9F4B999C4E74389B193B98F66C666BE9AFBF9CD9B4BD30B2B6E96DC7F86A8B66DC33DED514B30120EB7F89A4B93A01B146573DD14A796C4B75AD8DE8DCDA19CB8F083AFD3A1BBFE016520F031D48B75B72CAE9E107E21220315BDD55327CE2B87C3631B452A406B9778C81B0F0FF6B637D3FD218209F825A8D6EB598CDC309137AC579C05681CC0170D597A7A581A86D5834B57B3B9E61439CAC2B692D91A5C7CE29B838DBBB0D1F1C69B469EA45D05CE5B9DF0C35882C3BA9498F9DBD8C2D2D2D2E38B1FDE9F9EFE0C2F15D20A7BFBCBCED11CC0D6C044500BA5355F70BF1314E9A7552BD4416977DF54A9AFE23FE8EF4D3917880B9C6A486B29D33D43F5925D95C54420452C92998D9B6F44B5D2438D064BCE5CF99485040BC9001FACC3E1CE0BBD294CB8E3A0E5169DD5D202ACA30059AFF0B7768C77800F1A516C41A5B54A385A48C8E41F7853E757AA01A9F05F89934A9E5884F3487175CDD5BB989A835B8FB7332F3E49FCB8D49D2EB1D406F0F30A621FB65E4AFCEA5662A6F5ECD2AFAF9EFDF2C5D81F5EBF70E34D4D5AD2B5BDBA01C51FC039908C07A2E1346FB14E45EF007679658BF46008DF906AEC6155D3F52AA757DDD9F2AA5CFE3DD2010493BAAA105CE9CC6A20CF89DE06EAA4DEEAD18B1509D67FE9BADE90B6D6331E8F6DD3F35E502BB8A6210C733F4C2EB7AE0CEF85D9827E71659268FBC1A57F52109A0F833A504CAE33198D853028CA1D05A7A6E8AEE274D3B5968116AE5811B773290DB6B6E4F63288505D0345494BA96D3EEF7DFEBCEF39B17706AB35ADEDF9E539CFFB3CCFEFF7FCBCDE1A668240066B6F20129CC33E0B613DC5844085FF236690986CEA06AA3E2962FB8AC400B5AEBC37A03631ACD278CDB80D678545B0BA0B81EAEAE0F976CF8DFED1AB3B3F7C7A6DDE2D52B2E34FBC025C1F770C358E8E0E3535AE74EC8AA63BB716FF8CFE57EFEBE7DEDFBED1213A57C63BC5B3869999D70DA7F6431E45EF685C598461EA14A03C06D41E1C5458CAB101EEBA7258D6412146A5CA025E3D1C44E7A6132EC752969F93000A7FE0C8625413CDB216E895D11A0C424B00326C42B5C65FEAD0A43712300B90AE0E3C44BC386C816045A1106D10EBD4EA5C7675F2AE7078D1338549F7C0F45CF59B9657E752DBB9C4F0C9E1872921CED65757D72F02AE89EE2FA2D1C6C6F9CF32E297F7CF5CDEDEAFAEDE6F68FDC366F5CBB5B7777F3DFE30EA16AB57E2AF1B7EFE724768D2CCD424219F588EDC0AF2A131BB4918D3FD003204E545EAB47493E5A5C8AD92D9B6F2B8D60DFBFDB67018A3952A01896A2BCAB06036D8120AC9434BC18AC14A5D40C58FB9DD303350050FA4D490CDC621360F042858891E20C1200B314B8A562EB9063FC83AEBEC72F59B273B5DBF6FDAE81F3A3D14B5E4B19F9AAB6EE892C79878F676657CA1FB6B996BBB2E9F95A17ABEBE7FF6D5E70D2DF793DFB744A39B3943AC269A27CE072E10AAB4094EC0DA3C210D07F294059C514B5B45477826000B2FE534C4D26940D3592CC45213011576D0B5627A954900B22AA00A522C843594CDC670FB02156DA5FAA003271674AEB8E50A3E8DC0B98081080E5BC758286493036689C6DD211A6460F95C333C3BCB4F2F9FECEA1F8D5E1697EF84855B888DE5EA8973C223326D6D6DF36189AA989550BF5C3D2BEBD7A9B6D185A1C68D8D91D1FF8E1ABBAB331341D89DD7370741EAF070344BAA813CBD8F61AB709485C494C7A01FC0CD62AF1EB414B121802DA24ABD41E4A0085521004E41AE56CDBA60FB2AB340369BAD635CD1E8E2A368B5F5723815240F01096B397403C863A172F428819AD70BEF96CEAD1945101A36CBCD17EF167B61CFB5AEDCC34DB7303CB94E59A6EE3537ECCF4DC3060BF657323134BFDF5FDEF89BFC42F8C5C2C2A717BA9E45477E683C2D1AAE7CC5A02A5F38B3A474552980D2A90C581B692E5CC7F8C492B882009A46AE50B17AB9C682203A4E6B449ACAA2AD2C48AB122FDC0CF6B9AE2718D57882606D0F068331740F3975CAC7920B7F092FA01D45953103CC75CA412C5CD432015C81C2CA8593ABA5B6B2ECDD0155B4CA4F2D7C00FEA6210AEB8BD77237C727E58D9FD91E9CEC14EB331B1313ADE4E2267FED9F995BBD37F308F8C2F95B676576F8F7FC68FFF088E8DFCC80239923915375E534C573B404FA2387EE51A66021B3CA7B0EFA70EC60D5AE19C46C15CB5E8F9510AF284FAD5089D5E7F32DB9E2F5CC0F24E2CD980522D9603616A4705596A235250E8D7EDB06E6046DBA57023DE8857E0F7145DDC551665CD408DB74DB1F0CBBC6520C0CCD0F654CAD3F5E6E159772A3C99CAC57073C7B7753DB8F0A423C9D083CC9EDEE65C4AB8689E527C2F34A741606A7BA841830C4F6F8F7DB4D8B8599E0D3BEF53FAA9D9A922C60A9124BE1CAA0E64D5D1B2019ABEBAB328C566872AA74DD4AE301B4203C7650D9E6AFC0CE09CC586156E56A212A4B456B28D40EA6B8C118A48853D4891DD81CB607D820BF8204A096DDCBCBB91780B255162C790E568A45BE5267B4DA0716B90E02B4A96733576E9E39991B9DFA20D814CF534885FF3ADD702FD767E4A6269A531E5178144E4D1776E573B319618D273747CEEC817DD3CCD77D06B7CAF6FDAF67AE746A616652E8C223AFAC3154F7BA85E26119AE5E550170D4A2140BCD46B4A2E59083734163008275B99982B519EA2B805586AB3CB482E8CEE4ABA9281D5D1D7214ADDC6255A277143ADE6C21E3424A863C6D66B2E385AAB1547A25D2D5EDC8AD96B21C9249E0773DA3972EE556A685BB30B899DB8CC3BA75E7CEFDB5FEABEB3B9F352CF687A7772923C0B4D010FF5A59BBF99B27F5333DFFEC792C0C6D5B80DFD372D6ADBAD5728C08F037DC74B16FC3119C192339CF5900DF8BD4BCD2E2AB1DAD6A33AB86B5D512B4A52557A01933807C6B861156AF0C574803415F1D6F0DF91D9B2DB689901FED6F6186FD0EEE934F8A5E9E0A1CA1130BBB81318A5675145B6CD1E0285C55D16AE959937C084F6835FAC5B9E83343ACAFEFAEAD6C4C7577BCEEEB4A2E3C9CEF5EFBCF2202DA3998F849C7D4EB4158709D1ADFB8B4D7D3D3D322A3D7B08B0ACBD10EB8558A31D9E0C8AE63E9771CADCABCA90CA771802B3A0CE81E0B02160D1B1C62EC432C7287BB9BAC58656EFDAA17542DCD897842C66A4B6BAF0456C22ACFAC3AB66BAEF8C851F48D5FB90AA3FD0EB421505DA1B9349216C80F1D664B31EB80145B2D11B2A8C54DDB2FA6D324D310C6EDE850D7DA6344F0D2426363F2C58BB5F0DE42D34272588477C39BDD1DDDFFB83F04CF1AE24F9F4587A77FD63099117A0EA0DFF85BEA4460A9B3CB6275266B8AF35C0A30F78A072F1073500D50A1C5D9D54BFE224A38ACA295CA0098A9E291F59D2B1058065CE38978FC7A0B846B6F7BE44130E6ABA93BE0CBA21C09F42AED71F266414D1D8804D0611ABB1476EFC9A3B3A87998332BB5037A81C8D03A0C7DC258BAC03544E7C6D0371B709B1BE2C9C364F2DAAC84B06924795288DD685BDBDB3BB7167E2B60B825C4E6DFBFC98511530294D589A68E57FA942B82BC92113B0CD0B93A50C3963265E88ABA7234CCF66EE91CA08CB34BF6B26413F05398B2A029B3EFDBB4AB77B9A519D22BD601ADADBDB2C2CA2E65B33EB6BBF11FD05DE1A85539B4D1A0B588C2D622F8C7606D45B4501E9788E9BF5D62D66ACBDB0D85AC652700B70A2F616D8FACF521E92A32A72F004F28AEDD3F293C1240CFF0FD64F24B313B0BB076AEFC62EA36606A9F52A59D87C5985A66A7DBF6E656464718BFF9C3EC99A90DDCCA54E90ABB6F5CBD6E4199459B1AE02F5212AE7ECA0175B19804EEDB8BAE804453A680389C58B052DC128A44B20FD2602FEC538B833F1EAEC7787D1866E8F88F13DDC2BA56356AB1688C6D5A8E8D2C671AE0EB67C37C1DAE10D1E1F90471D90344128A1B1B022503328847BE14F87543A4BAA74282D9DDD2978F39743D6D719C5C1A5E3DDDB2932B2BB20957980F3E2FBED3A5004C5EAA58E3EA2F5975A1604D03AC4B69572410E96D6989C71955D9BC4622E958D65773BEEE805BEB21A79318F5AD95A46B055E004C4E88721DA324802B59A6A90C054D6ED2DD079A2C43A500156DBA1D934FC7F704B3AE990198B94E0261887CB6447616F805614CC95E4BF9419A2AB596E83EED299606963B3A3D311C03E75CD20AB01613668365E5E48CE565732CEFF32AE461AB94AD80D364B446364FB5BE58ACB6CEB7F49D2B9BBE18EA055821B186E0AD3D9B7D10A853A6ED35FEFF3713F4A2001324D8C52DDA6B86066B8B2CD0C6946AD832ED32D254462D86BDF4665FBA6523CFA78E584F71B862B0163A3250C9925020C3B05E7D2161FD60B895E0DBB24FACCC4158E57BA7A32AD1258A69872B1D594867959761C548466EA423069A10C82D6807587FC1FC00A7D6DA6CAC76DFE77BE08A6423F2C60F4115203FB6437D15496723D4BE52B0D27A1BBF34CABB501E56CA46840045E505960114AFF93CA8302DBE02A74D8BDA7855F920836D903321AAD253BC46B9054B03E6BB65EB3AB9E7C9CC1AB3F0850138B0A69219D13768B875AC9A4E4D02AE2C711CDB185AEA0F52AB8262229347834A28800FAE5C8B14B4EF8A6A8C05028C138ED120D102705AC5E0075EF8D22EF8292381F6F6502BC56A7BA03D1049A7977C73CAB3592F0D6A128B5280975798A1B88297B48CB881234C648D1D25174CCBBE4E4B4F041C1316C3510B988E0ED72C09573AB9EE15C4744A1E5A03B3B33A585716E47176DDA0BF6BD04CA054ECA1AA56DD17B8D5AEA8E93425E70D18E5D952468456391A6341F1E8FD0B730432CFD2FABBDFA5CA561A0A42FF245340EDD2D245576C7F49A65789662BA22A717D1AC9A6D1AA1567B34E1AFB90DFF6D96433B177D8D86DE18155862B995B642A41B99564027C9D8E1988EA07F451CD231167B985B8CA7A5F27572152A9BB1E99637F05E10AB08ACEA9A6E40521B6114D89E9242EB8D91920E378951486EA5ED03C97A57EE203BB0BB0972BCC0564C0E0D5BD2B7BEE45A5C073F42145534757B54DBD56507B85456BADEFC145976F7F291D40400153096F7BE4623AEDD33F62A0428F02FE47D7D585B6759E61F9D48AA20FB6CC9E857F1021DE28A134B05D2C50611031699103735C70B688FAC23446AC381742388DDDC528AECC40B25AE39248516A521B6F45C85AAEAA1C0C1288C071D31869561205436DB00776611043918958EEF6FE7CDFD151C28E13614C90A3E7BCE7FD9EF7EF797BA50B5039961E5517805F8BCDC23C8A21177AB088CFBE5D9989D1C04FA33162D350CD0A97B3F14F1A6C491C5E17A677EDDA585959D9FBA77870190FAC9B785E2518D6430D40BD3392B9D13FA259E5CC55BEC1126C194ED3D39BD543A5E5B27F5C0D67B1B1B628FD39196DF5D4B9448054E0D79DD7DA2D3D832ED71A0A32A00B4082E5C22523636317E19A03482BF0C79FCA1D2941C1A6D2208B407286A587FB2E800AF00403F9222AB9CA03EB78F3E0408339319E1BAA25D3E4078D9CA1C3ECD880C7FA09E27A93ACF5C536AA926FBCF70000FE168C7734188E03AC9A581AF94C8C6EF6BFFBF1622478577B33A86B7038C37C6779FB0C4BDF1BB6B790CE187D146AC4DAA9CB9E01AC16D638D2DA21A98FB773FDFF68B7680202AA68AB40AFD6527EDB2997FB8FE04C2FA2A9C2353656A9F8FD85A3235EE264D6065ACDAD0DD66616AAB600B12217D0A27CEB1D96181F60512175E23A0C25D4A0A9836BB491C2365E333107265E311815B3A5EB42F6B77671C2F5F286208E357FE97EDC4BB0963736BEEC3F7F502A15270E8277B4867E89E5EC72360B9E3BCC4C2C1F5906175E8E37B9D616B598E839592BA59368261EC281F66B3F2DB7DB4C9B73D572E8024E030DF0FB09D667A982821550BD9B829FA768318E526590C7556B63CD10A7AF49F6AA2EAB6966EF155BAB7D739393199C9F76184E8B0C9EE668245ACD9F9AAB73E831D58463BEEC109A714164AE08212706F636F7BABEEDBA49A88E6416C61300EBBFC05AFF231E0617378B597DA2985FD634AB919A0F81222556A00DD9ABADE6E2EF98C3593BDC2C8035AD7B186661FC7A0FBFBD477370E0593F1DFEB0DD660649AFBE408675FA43A001042B9002778E9CC0183A0134567F8E3B865E73026634D0DDCDBAA648E7EA140A10A8E8027654FECA5E1970DA959C881C2394CF1F3CF81BE620910975D3A30B6EB3B278FE4670403C1C110B8B878CABF8FBF4EEA420D22AB4CDFC82D7EB4D84C26735F1F08510EF67625B31BD3A51CC1C0AAD6962D12C4D34DC90D120B42A45600A67B3B1526600F9CDF33AB7B73CC7A407BCD669C6B8ADADFDFD2D57BB4206CCAC9778C0B34281613DE5761DB9531544156C153D6B2A55C0D30AB980459745E9B5F34836090BF730B5DA915E40E5AF880828CFEA54594F3E391A49EC0D65AEC69B519126064AD35BF9FCF4A5D19765317E3FBF6C882E2A647D27BAC8545F06C3F74B092F5AEB5921FEBA2166A7B762D56A4CCFE70FFACB02CCDC299A6DB6117F6D34E50DB997685F750B1C6B62AE7C6A8191D6A4E5CA1D4570FDFED39F5CCAB7B69EA8B5211F85202B95F2E356AADF81595E23582B158615F02E00A2EED34A02D7259B042D1557DB091A1CE41B491E8078EB73D9864D4D2DFB4E39E5E274A81C96C552ACDECF9076AB324DC23197B99D9DD8CC1F9C7FE7CB51F15EC23B182C73D29A622C212E6416EE1F9E0563F586C21F88A9274BA5F3B763B12A7E2DE60F8206DC96CCBCB0F86AA7E5187458CA3F0DC911E7BE5D6A8E714E802C163F579D4BCAF829F1A92445677080BF78FB1A13ACD6D6DE13B55A0D61CDA59E1552A975801569ACFBA840D65A41179042541BB0BA9A7A845451A093B32C75CE08D6EB7C6BE500B14A09D8655653424BB662C816574DE5B22C1F51BEA2A9EE66F52AA07AE3D2C3B951B1A4C7F5D5CCE6DF043DFF5D68AABBDF3C38DCB80FA012C1DADBCB0CC722D508A00AE63A519CDEBB0BB765715E3443F8063590DEDC6E19D84073DDE1A137524621B3D9C15D7A3BF5E7757368F304F2CB7695C06AEDEC6D6DC3661637186B6A1D70B5E1B045AFBB50A9D079E507CF9A2A00ACBD2EF75143B0B9553966DC8745E3026D5416A873E8CA3CA4855D2B57B3B95D4C890CF3A165D5693134C76BE6AA3E3C98EA624C0FC40EE169DE042200E77C359E2866078357B8B43550EA5FFD66F5B00B502527D0E578B2B815014C2364AE917C15EC3CAB07B28B2FC5FF8595AB144ED94EB8EFB49B83DBDC8E2D73833856FC568B0A77C81B500DF6441B369E906A5BAFB9D40160FD3EF58CADF524C507CFC62AE5313AAF2AA9428E78ADCBED6A1E7337F3AC2C7B45FAF768AE3D64A9EC048E9BB4755FE95E10BD329463B348E169C61B8E95BCEA44241DD0D313A5DD4B73D8E92A44598F8FEBC5ECEA62706F6E6E7639B31BF6AC7E26BC8F10D444DCB312ECF83982B61A41546FC78AA5BD00BC4320909DB8C345C646A39745348E191F3B01BBECD5B637E6B4B9844C5E807D2C7CDF738FDCC1BD1E56CA6E3333589C1B70B973DFA79047150A36A2FDA72B6305FF5D3FD300F401789D7629C9572B65EDE4B7C4BEF61AF99D9A3CAE948E0033015A38C4C092BF349C0AD20D739050B384AF14CFE36687B97C360D88244BD39750DDF68C8435B18AD7E06E7E777035E18900AA612F9E589E739B3786238311B2567C896D954A595DD763013DAB1F5E2C9797E65F0E8C2267E37E792BFB92E16BA365E8B88CB294F03017B5785B290D6C12CBC2AD04A8E75CEB5679ECEE57AFE0F58BAF73EEB5B5D43A582538013CF49FA5723980F9AEDF3F46B0CA6D18AED78C15B84077270B1862929CF2902DCCAED8B7F2EE19D980B56F371A8557756038CD51178763E9C5F57DB3A6ADCD3F7E61EC6F47D2D1005C7B9927709A6BE3AB23006B319E8817F3DE7404A1D5BD9EC8AC8823AA5EAF672AF8C9CF842A410A54205B9A000700A0C2ADD94BC2314657726A6A6AE57179FEFA4343338195796C07B7145345D3A22AC0C64ADB08480F0389E43D1AD9C495559DDDD488A9927A647AB5F5350CB2103D7202EED3D75CF0E4A79071A17325116C97FBB50503CA0BB4D10E995FD16A2912377A4B46593BC7CC180B2747EC2A7F857EC0309C56F74AD140F9D65793532BD79D5CD62E17F5EA5E544F47A3E9407A3B0856AA5DF62E54C111945701D647EF786F25F4553D31EED9BD20AE861F95BCDE78BCD43F3CDC31D841A8921FD82A25B3886F201BD8DE0EA47D784DFA42215FE8A92F1D880692F00B35CD1A241B4E4B53B6F2ADAA6388A900EEA7432FC7148B27B33ABB2D3A583620AEAFDA6A5FE7729C4C61588F30E83A5A5B5F2BACFBC7C650658CFAB39A95C46C8A0AC8A5B23C63DFD3D342154A35E63660320153044F6539555ECA9031D6D2ADBE1F873E0F45A7CA033841540CF9A66E3D0A90AD562FCD02AA7DDE896D8CB0CAD51FE169CF14E3DE71F85A58FC417C10F606D371CFB9E577873B3A10D48E882402CBE7EE472028886593DBC934DC229F2FFA74F2E9245C43F037047F4281C79A2C491866654BC9E5CAD6E11D739D2633D796BA946E001FC0FA2D52664C859FB65AADAD565B5F57CB8410D65ED729CC0080B70572305649512AE675F95B9B4A0A7673379B6C65C195B33BAA4BE898146961D76A572579F6AB86D3D9743E01AA7D67668686C092928F9DCEA4CF37FB076FD217055CB3CB7FC642B6FEA4349E2DA313E87A04E69A8F83330D2F7C7C457485E3CB798F67BBFF13403542D67A9B6C35B69C5838005BCDEA7BDB6970D15178BBA86F72D287B84ECECCCC9CB93AB332147DA9996BBB6421CBA9C4C79402866CC46A3926632D49B4689AE004B5B6745AB45A6CBD9D6DB6B6E7BD39B5F6C676F2E42F015637186601C303BF24584AAAB5D5DAD1D62A6B5872F52995CEA93781CA033C3A88FFA97D9AC6D8A766524EBD37163AA934CBFCADEFFAFA86F80AA5B7677DA1E4BFBF4A220E8174FE22A03A5EDA3CE7F1E800EBD26ED76FC25EBCC2E18F16E10789855266E156E9C670C72E7C0D1E44A46FBDBD7CEEBF07553DB6553D4CA6D1EAD15A7D4FA368AD33F07AA6EF2F8FE7A666428FCD9AA4213B5CEEA89641D5E7CE0D43C4B0E479CC21816C7235655C5B1B9D29DD1411108572DB7E4BB8A261BA0157620229DC3BA88A2D2E73124B655AA5FC3E8F2BF5706E4772908163722A530D6470018E9F3726AF32C69A3FD3D7D7777566E8734475726AE469E8E9EC9F424900351AC89600D5C9E5294FFCDC38C27A7DFAA39B612453D9B8F81F5B571BD2569A856B50AB97B2B5A0AD0E765833B0CB40FE24443037102CA5B1032B97E094CE2514677E7494C852429626CB94EC55D925A374D6604D67462686948968CC40A31304CB86B2ED046BDC6E83AD8B75B14A5C5AFA41DB45B1FFF69CF3BEEF4D52F6D64668292D4F9FFBBCE73D1FCFF9E43B880E2CBE4B412E004055AEAD6B43EBB1DCCDA16C2693CCE733886A177C01B02104B5A0C9E3F673739F0063352574D6505634A8AFE72EC435357575E54D830029729515EBD1738C0503B405F21837C9D613AE7A2306F1F5104DB5C3F904B07ECBE87A6BA1F5B7BF5BA8B015D6ED6F5104705D0CDF8D475D02F482080960967DAC3250640D834209F459C23B870D7BB27D8393D5EB55E25AC0EB8D24C2F0C602ACD3BB539214B82FDB3CB2C3938123EBF6D2B834919B00AA4A2FE1B7CEA7223341DFA5BF12AA042AC17A6D3DB673330912F035C602194ED65017503514D24CEA39BB35BE3D17D0B4B8569862ED2F7C2D92E871E7E38475A2A2BD29E6B368328A25E970328B2F283AD1A2FB34706CABE16E2A60FDE857002BBDF5B7BE5D04AE7E76B7B5F5973FB436FDBF1EECB2A55847697927E2BAAF07024C5B995513ABBB5E676D7AF5BDF5C2769C42D4B38A7D63C3DEA711AC4ADC1BF723593DA8AC5D17337983F4D8370A0194C7313A3B2235F74EA6A4F33F6343CBFDDB5273736AFA52323F8302805F8D5B802A4458D7AE5D8DDC4CED8214E49720AACA1059515C515E4DAADD1A1E9FBB313FBFED46BE6A9535C31AB627AD6CC7034BC6553121E022C00EAD7D36F9CAD6145774638A66572C0202AC6D3C578DA718D175E1BFBF6E5DA888042AE32BBC1037D08985B6CD2C85857F71159356246B91EF71286FD5D3D96A286E2357E74D0A69C0B217C8EA0F28485694D6A165C9B76633FEE39EC9E1F16CDD909AFF3CF9EF7B92F3BC742FD62B3543C41ACB4E6E71AA366E75B350E0F5EE55DF4DF3D0EE7AF67E36689EDE5DBBA8837AD16B55D547E101F7EABCB37DFE05E21AD933D47365BDC3DA04AEEB66185C5C09D24D5D641F56D145E0074C0E3630A3BC63B4A9BCAD7CBD13DB23C4D88A2280928091EA029D590BBFB4F28E96EA920B3E37BBE0DB9BDE1E6D20636EBCBBF28C809056E6DAC552027C632EBBC3F240C0503FA72259EDDB0AE21A57BC6EBFBF1038371A2A000A1733D9C37F7AD60CD721C9E130E5B68CD28F52FEE73E50DB670F0CD23DA9CF928F655FD3594564251978DD38E38B1C1C2477D7271F7C3D168DDE4CAD01AE21948148972D6CB5AA61E3881CDFB63B3BCEBC001D08AC721FA74A2BE23AE139BAC93B300459A9FE498582CD2A6C746366F9A27BB8BAE2A5D661FD8852D5A80A8BDFC375E09FB75AEFB6EA0B9C8400F02EA1B6136CB0A5815661D00488C8B350D5B5B6587BBDC8E98A1702F2F411C32E22B41AB06FF46DD88D1A47558B7B0BFE44B850206E25E34049033AB3E43C8ECC920C503E59B701AAC3946849E58E27FFD64F44653FBB1BBB5F5FC94F44560E52BBD762F72D0751B3D9163523AED3A1C8454FD86A7B640DCB6E5996876FF4B5B7CFAFC63525506F28D5B64A4E18DC6AF0BADE30448B3F599CB559C5525854D726376700A285B7B60864F9FE000CB088AD6D4DF8DA2F7CF60DB075B1E96EF902A76AD177C1F70E37D04D800F63EDB355482285CDDA05F15F5864B365F08FEE2DB5919104EC9980AB1BF370602506956538B2E00C1994AD4056888600D65EBE977C7C747C3A3313075857BB1DBDDF5DBDBC3AFCE4C9E4A59F822554E973A8E72B5F3A9B4AAF340EC580B26363E631B3391AED5A8BAC45BCD1B0F591CD1A56E2B292909580B3BDBDFDCC8866D22E1B0E979A858AC25A40DCB2EA3679D985B4A01625802F24D8E4452DBE4BA7852FD02CDFF34651BEB01758BC4B7DEF88EBDDD68585B60AF3DB52FEAA855507B11DB18185AD5820D08F2B8A59EBD892AC1A6A6A6161EB9D7ACA1989E3AA6F03644053648801BC8A16F717ACA0AC053F05AD81BF4F2D8F8C8C2CFBB2814836B8841C757F1C9BF962E9CA95ADEEF5A5C923BF3FCDE0DC62C876F75FCABC59CAA50FD6B7623B07660BA00A5F3673D4B1767114A86AB35AC31AA0AA2412C6B9785F7BC7991B6E45992B1BAE29B90C5D2F193A3355E56F61154F28930EFC40C052DFA05841505DBE950D0B808798A133DB28F0AAA9E9FBBDE77717179A16754EEBE92B91153CA1EFC6C3BC003624D06945C09EE5A3436C909C4F40F11860F82CABCE3361DD80A015B8AA0DAA485655368E86FC4456C7E3C85A762D0B8F6FC9979F990948EE7CC691846736391B9CF47DDE735A682A3DAF4FC7526FB2D9743AD5FF6007A84A9802AA365BD4168DDA6CC8D538A2EA4C2872229E00BA9E9FD3E440D1202A03A5DDBAC2DB9D89ABD05756FA6495D887FB8CB36F79B340698166490590AF8798CD15FECA5BD48185E77BCF17DECB0608AAE267CB215A2A8B2B79F6E9C4121D02E2610D2D756C9CF48E6822877BC0C76E03C23AA51259E7ED468801B48173AA3F5E183FA759E12E44A77667C8D199C327E318B78D19E77E1AD66CA959F624635957E315F6EEF333ABE7ABBCEB42309F369B1B7F933B18B330B29A6D2004082D3C61AB5B03548D679C48D84407D0B53D3E18FA463A2CE2007CAD9877131F1E10DAAA2B018E9B6DD268E126CB0E304772DDBCAD9CAE545645583F243D78F794A05C7CBED8FAF4D5D38A512C9E6411BDED222380162D28E32264254331D1DBCA5C7DEF303F01BC0BC456699DAD11B8AACEC389256B238A0A37AD4060F09C2901642D205947033BF84C47320E9323F8A3B4BC27A9C1EC6C66760D7EC6827FE9EF2F111570ED39954DBB2C31CB4A7AFD782E8DA892B4225BF1131420EA19D6E4CE84B3C3D90EF27A237103D5754EF196FB8ED58B3B568D58A87BBD96AB2B492B9DC644A087EC3EB9FF015F4AC642AC43D595CB19115632B9425C5BDA5EC119F6B4E9C462659A45ECC66CE3852CAE0154D945B63EE4A8962E59BC92C57610F2108B5E394331610750D50D75C3AE2D1BED76D53E3EAC84C3DBE3FE02A21AEAF2043AFD3BA16938C109D597BDCD13494AB3AE256763A9CF4FF70B5DC5EF3DFD9F06D3475C4B4157FA5FC7270E2CC455335701E42CC880E656E44EB9BDC309C0225BE9D07AA60D86CE96A5B08BAC5DB0A6CC0C8BE50689B2558CB4C420BA4F56E9E5D796CA896226014D4C04782CF08E7EE7DD313D79D5545D26ADA2E0DAC2E631B136402E719BFBE28285C115676B1D9B21A4467D6E8DCD6E35DB2AC13AAFDA9DCB20B0AA6AD7DCAA6A554C05206BA82B3216D8F1EFEC842239936922D72CE50DCD41476608B99ACCC65C0C55FDE939FD2075E1A42B9375B9529FE6D21620ABC56246BEC2870DBE47A39EC7A1CECECE449F139F76196005B602B271AFFF8581B56095ECDCC4FA2C41D65A11B972B612A4FB8CAD6CE4E5A8BE00BEE2CC02C0D0958DF7582096C7DEB6BDFF88BDE3F8E7B10BF90426B130BC421713DE2AC8FE7329E643608B757C489785567413C02427A658FB105575A3CF6EB7275455758FC38702812B5E05A6C71FE7E0AE95934D9E89891FA5FBBD5270C293E99ECDCE269762178E20AAA4A9F4BDE754CCE53A79F2E492CB6249A6D2C8D5150B69808D3ECC5173C0FDC7904393DB81A91DF0E5E46C759E9FF27BE758AA0545A05853626BA9CF9D9D56559B22F5CA52032C994DDD83C784E168651CA0C3AA770435F17BC27BEB9B08D457ACF78A368D6010806C25BA5691B63FACD5D72617EB98951F250679A6E570EFD4E5C37B802A0A401F7CC0FBBF9DB0AB038A5D0D0F6805B8670159473B1303B26C329A3C8E897BD2F00B09BB811CB9CC6CD037F3E6CBFFF4EBE12A72F594EF82EBCB9316FC615941A25A5652298AAE583870907BB2AD0EBC0CC9200046A26B1FC00AA87638CFDC0E0D6A5C05F475F0DCC7515F545ECBBD1158C78068E0A3BC36A5441B2A475F2BE87AE843667749BFFA8A6561CA8BD87AF68A45AD58C02133FC0FC48CEDBEC85EE3D5550C0FB1FF7FEE7E41958129373C23A0A67462A918B81A97ED2A3E56D518F0D281356D0BFC8FADAB0B692B4DC3F1107F7A36D491ED681472616E9B1B43026A49E8D08ED35E0C72688BA622660F6CD4B8504A40B30CC40E75C53DCE16A59B140D3125454B5A3317057B234BC68CD098345DA7545B46655B9185D652A86053BCDAF77DBFEF9C9CD83D6AA337161E9F3CEFCFF7BDCF3B64B502A884EAFB1ED1197287C36EBFBF6D62F9E30EE32A892A50F5D4E507E3768BC9029812B004EB8B30C24AF1EA732A101C1AB20E0DBDB6F6ABB03A5B01D667C0D66F57833F76DEE2A72E9A4D1EEFB4B0FD03DC166F9B4B00EBB8D2B11DDD21C6750F18B21AFF0F5FF5B03697E75E65FDAB92DB85C1D8405D01728D67C703945C6DA86C5507B2F6B88B1F9F648DF7C80559CE66E47B08AC8762D65A3F83D533BD10BC0E116B22E23EFBE676BBCDD60E0A80C3D9388885D7ACDC9391E8F88EA6AB08EDA581FA50AF1D41B5A42C2AAE53F934492B92F573E475FB900DFE46431D373BFA11551001A793D80AE22A247EEC2C50F15AA91A0BEC95761372D7615EBEC2DBBEAA821FBBF0246BFB809703758CAB06DD9825879579DD19F53542F989EB074D961961D97A79EC617DDADEDE266555D3D63BBA2B2D749185753338AAB2AC6433CA02000B589E5958E0A87ACE2C064746BEDB9DF873CBA2D36F4301681F15C4ADB7620E9BD7EEEB9301E4EAA9520E3000C1CAE2F501AA290B419A626CB5A75BA6EC2C1740AAE25FC86AEDBF77B3BFD50AA87638EF39EF753A5B9DF09DB88885966E18A3929BB8DED1AF7B5465952B2A4BD0375891A5B506BFACB2B4E255378159EE7EABB3BFE5E7837838C68C4430C7A25BAD1B54E8B1AC95D11518D0B7323C3CFC8EDE66C2AD1E80B480C82AC058E51E11765145D5339D4069FD2EE2761FF663B0F2770982F82C298E8AB6A5D093500AB8BAF4C3E973E70606B8B05E3A7D0D8295C96751D9CAE89A0F470056CA04029D407BBFDBDAEE075C178266A70DE90A3C5DC07FADCFC4F79DED71F54C9B5DC3D4BCDB08D49A6D16B32A588655F189755BD8C156053A0B60DEDAA89FD1D4ED25D4C16AD4DEF9E5FD6B836ED21D8F1AEAF8A6433211A8E0ED806DF51C8B75050FE333DDC562F1E86830FEAE5A38EC9189ACF8A5287226A3401AD0AA91D5E1B909A88E4C44E676FF06EF785B97208E8E8AD14E3127885D56FFE442D26B7FF56A69E9E5A58173802D70F534E45A7693CF8764DD014477B8B4DEBF9FA782E0F3E3E066BBDFEDEF12475BFD7EEBEF8937A2D38A1A809C852F6B4E1CBE81DAAAADD363CEEEDC71B8465D00AFCD10F0730206F0061D89D08D21CED62FA4955481C1FA7573F3B1C5B865018B5E6A699ABEB1AEAE81DA58EA29363716E50B472A57E247AE98ABDB05FFB88A47B7DEDE5488AA6BC0550581553299C533FD1AAC28AD200211778B2C3EEBC8D1A0A038949C270B1178FEBA235924F6985EBD3C756EE0741253008BCFC2E86AA7A885B046C2792A5F5B22C054B753400B879CD56FEB0FBE035C5B29CFEA000DB00AE2CAC88D0B6A57604F5BA2A5E602FC8E1E65ADD8C2D64EB7C98798ADD3C29E6B83B699F478267052AF0227CBBA5BBCC0D249004E6335D53636F22B581417A9726649342B040E8F5CAEFD99353916DB8FC133D65D48ACC9F4C0CB203C80EC79050A03550482CF9F3F9F885C9F7EB282D785F042BB607E18E037DBC5C1EFBD00205013C2BEE49524EF122800424AEFFF1D8B16B1EC10B138ACBF9D9DB48ED2E811FA3E76D8AC09117085CC0A94D5D96AFD5610FB26DE68B7DCD56280EF77A852D94A2DAC0DD6B6225037F0836EBC33AFDCAF1A4AEB898DE521EB2437C762487EE97561E099C007763680A665E42A08391659DFA9D5C005AE009587DDAE194410981A236401E44202098B5405501159A5E7FC1AC715C80A15C0C8EDE9B9A0601E35D34D2CD1938EF0AEEBEA352FB21270F5413EE5F3495254F222A6C4578B0E558858A80158C0BEDE1A4250E94F848CEDDF7D230A1D2401C856F80F56B756D4CB42ABDAF2D7CA1ACD17B38A79BA57686C655FDC62A0892DD32BAD262DB36C50E782D862913237516DB6C5A0771169361C705B0D3211A9A0C1D00A5D22B05773413E42626663AE31D73EA2BA0F6210DB2F0415D455054025CA66E58B1717AE10B009C76D8763DAE168498866C061FEEAD5AEAEC9C0AE38DF19598E98FFBD249188222F531693C99B0C49C85DA22FC26B0250FF2E21AAA9345505532DE1B3C111203BF329865751980719C841D8EAB03A4159859CD8D72354EBE7324FE099A6B649B7AAEC4636EB0962379B0A5810D75813DB555EABDF506C38A6AD9CA825D73B63E99E20B311C2028B4DD0D7613790B5050F9A7888E4DBE668FF6C65222BAFAFCBF23E082B636B31360B8475752B0985901DE4C00E6680B0573CD3ED9DD31E07769BA7D644F3DB40349ABEEF76B705FC67937F4AEF5E2D24C71984404B13645452F481973117A98BE540CA6E91D22100540ABFA08865FF7CBFD31F300BF3B47D43606B0A727D66A10B3085E71919ED1E0A27B87F01DA39D2C92B26DC5AAB859B0E3359DDE0A4A5E38198BA4C0B19A6AD7A3494250306BD3BD6B1A065FCA00E61503AC060A55511F03B699A46356ADC509B0295F11E006C46EE0686CE025B0154421628EB9A49245006649081EC60369B05602F0E5DF1BC69773836DBDA361DA902A454E2BC7337F034FD241089867E070DF8D984A0222B2D3B00646F7A59A2D2CA07596B92CB404A0A2D3F02690D3D6622F0287263338026DACC186E14673BC97A93B200277E2BBE5B114ABE38EABD3695AE559A1F56951AA7085976C08417A40EC80DAB566BB5946503C6526DC5803D9EB5AAA3C3A5A181063467A03AEB93FEE6153B18809805A8AECB05C802668B84E9AC0BC3563136069AE05A0F2A594541094068B3D94CE6BCEDCA2248C026B0750E60A51BA8A2D9BD9B7E3AE9BE2A0A62E67B78C7DB11570A5ADED05D89A0F449DEF150741C2B02403CBFF34D1EF3AB87795E6C8D4CBD58D460253302813E6C561BA19A135756AA3597111C1A40BAD670D78E2AD5C3915DC9C630A5CE14D2C56CCC5AE93CBBA1B6B44DDBA0BBD9A2130155574FEA0C198CBA86003FC9AA6D684011C0B6E01FD8B26C76AF86CF6416103079260660AA9FFBAEE2BE6B365604BEFE8412ABB0B09595073380EB2FB7DB1D1E646BDBDC94220A6472E1743B0267534EF869F5B2D7C402167CA2B2265310AE4C3E536FE8DADDFABBBD12ABB3A49D6F1E3FB2E71F83144095D562D912FAC35B3A58855142157E372A007C5B2D1E5EA8D65D66DCE35CAD2999B8D6A855163DB14FEAC1363770A38B02EAB5419662E99A28A55D2FCDA519777D795BDE6841ABA23ADC204367D91574EF93777AC80917C80AE16A90F084670C1E7C05B6165D002F29410F970119D83A087CBD01D2DA86B8B6A0012EA09A0B4FEE06DAC266480AFEB5E4A51C2085EF7AC802965158ED900DFCF6F3035FB4FEB245A298957FF5DF24C04A0A0B11CBB2854EBA6C329EDDC0A6A440E0BED188B138BC7ACC4AA092872B756BCE1DCD03838FF1D0643F2D293C60DE6D40D73A836E45B1FEF0C5702C533D66CA60D4CE0670BC858D62347D05D0E2B9C0010E8256946E5F55D5A0B2CAEB31AA03BA67666EC5E3EBEB47C531F819E9CA28BB16A4B0851A006CCD642E4E7B3609D6B9896A82D51A9E7C0AC5969813679292C9C4E2D30E00EB0D2D630A0B58D62F8F7B3F4643A17A4CAE4C96DE97033F84F31AAC3B3745409492568123CB4540FB4E2CF40927D44B587BDA2D016D7F1639E5ABF52A5DC442270C885907DBCC64E88F046BA32A02C6632581E158FFB5F9782F46378CD5401E4DB524D7E47A03D0569506884192E0FDAD401910731DCD0CF7F129F3BEE1F811C059848FB15950D89F66124A168316A20A9F7FE9C4A3FC398035740160358BEEC9DDA76D38772DFE830A2948AD7C089EC594049011D6FA17E396715FBDE9E3F2B55E14D7DE7F0E0C041EE5D3290A592D21850D759BD9300653578627BD76E584EAF82DFD0E9D1AB5DBCAD6956B73DAEA34F1274A023469E577B01A1B4A114BA7ABC6725875A87ECDBAAF466A5F69CD964692567EB5B5E980CD6456F0234A94A35F7BD61519A879545829397A02B4B9F78340D97D622DAA422288A940A687D1F5174CAFF049C545D280DB9189C9B07954CCFC4762BACAA2546FF4A18492301E7D0AA83EAC4F7B2DD265AA06F2A7062E25538F9653C4D6CFFF63EBEA629A4CB370AD2D3F5F48AA49036AD2D958AF8CBDA1B1C9968DA406317A41C817D93048BEE56733FC391B639A605D0C83B51A10A263401A2502291912D8722186990B1341649C858A7F898B06C900C189E3BA1B86044ADA9B3D3FEFFB7DADB3B4E5C604EAC3E9F39EF79CE73C67B456C1756538A9CC732E8A11AD99F01DA7393F3EDA4C2DB686AD620189DEE1307C87DF6D09E5206A4EF7DDDD2705AE796CE39C727FD595839F09B33EE780CF1C05657B70D7861CABDBF74EEFBAD281555B0BD780C64FB28429BD1133E70612900BDCA1808D1FE99A075CA7138D9588EAF4D7919B0C6B2C808E819E5BDDFEC25B4D8A72A54CA54C6A09AF547575DAE8C8554EA8721DAAF6E0606BB52307908EE191656F58BF38F91BC3EADE2EB90D60CE9A9FF90381C87CF31562EC6FE841F4EA010E1828AF6A360B0E4819750BCB9D84D2BC2D431E5414A7A889203FD75DBB488095B7377587A6E9F747D667AC2A33019329B5869D47DD6CEC8DED427ED1AD4432E40471656DED918DF87C15A39ABD26BF03AE991FE7E37890FD3B741799E04500CEABAE69C675CACBE1BADD3B0384EA2A6CF277B6FE5151FE3E41C914A6A8C8006AD912A405905AB5BE54AB477335A4DDAB0F46F10EA662C570647CD24D24B0FD6053312F3F578A0BBBBB9B0A57FDB3330A9B3B89903D0E1946B4FCCA40CA2D2BDBA80A4A09860E2C6556AFC5EC8070C2A185846287A6A1A1485502FE1F58FF6BD80798D2C3157E906D1F99C6535B80DBAE617179CD7A7CB9F1C89144D46AECF8918EC9682B606E6E4416208E0D757D59395DD915AA245CBF0E70B8F6B73603AC40ADBD9D40AD9B239A83932BBC4E39B4C19F35BAB4AAA37D9ADA37F81B640075DA602B40AF3A1AEC25EB353FF5BA396D7D9059E57F5005799ACBE574D6377DEF9F372B3ABD9A8FA3FFC050B9F97AA6ECB5CF885E86550F54BD4F284732F0B5936F585812A44460EF6E5BEA9A37A1CCB6E8D16AF9FCA832A56859F4272F1FDE6B2391F73BAEB5924F1BB100BE955944F5935C9E443E93D63572A1A6776F9E9B0F513610BF0389D7979527131B899390094C4F4DA1AA072F0495681CE6ED5DED6CDDA3BC5C521D7C0DC8814C551D3D5A8D400288FF18D172D483935701EAD65C6CBDBA978AEC25C1537D7E6E148EFBA77BBF85640D602D00600B7CE7BE5AFC9598C08C09025605578A3DE681CC34031C729A946BDE32E41C51CAACCB4E0E5722562AB300AC225CD3D855CE59A41DFD26F1CDF23B666565EB6E1B19C512B63BD3EEAE596140F5AFCDD959BAE77476D8CA7B69D6C4D4DB5C20BE7104713D12075C17A7BBBA0054F87ADB06E19AEFF5BA9F2ACAE95B9DFEF38585CA8B16CD0DD72B7852FD5F2D9BD0446DC0915B8D39D6A4A68DE6222FC06D0060B5F7D4BC1C2758B79FF7797F82AB05462BC6EBEA799F6F3172FF1B4EB78E3F53CCB3F51E8F727D864B58EC44CE823C8E525E052F6CC6B822C8FB6AE0D6CADCBA41B72C016B0A0DA4009712A77AAA2AFEC9920A2C55597155366DE97BB725BD1964132BAB39BED1D86CA52D49422F48EAA61929C382E0683FF7022E097742F1D08FA1AE7F2EC6BB1297E14220C235DF9B3F52A59403AC8585DDE5079762220380578E367248753B18616D6450ABAB76E7C2D7181E6A0EF50D46EB7AC353823596FFFCFB7FF5DE56CCCF205A9D2EE71940D55710089CF160A655EE529481D262CFF13D9B55BA75FE1A5B628A0D6FA2F192257558B4F84372AB5C4A68631AD00F2DA3FD6AF99C5B8D396C79653019059ADDC25C9C0787F0C8E26B1DFCDA13ACBDBA1D4A7CE23FB958A1B666D5F7A808E170E45221104128F4633C14EF0A2D3672B81E9B7EEB2358B78BE62111E87CDA54E87D7E0830728C7163C5AD8D96BD51F522AB9A0B97AD6AB5B555C333CCE1884D60FF70BDA16F9CEB824FBF3A3CF9483197DFC26075397DE77DA5A5AEC0CA19E79C62767ABE1B8E60536BCF23B27ACB4E1B7A974D17EE13868DF12C5E467297B7EA52018B97E8EE4D4F044C6935018BDC2A94A612E69745CE61C0E52A4F68DA36C8CA6C87B11727630D3E39B7E351D2DE734598DE28F02A9E57225833CD03AF5CE7230028466B3C99B89CC470C568BDD08FC1EAB52F03AC900874FA2858E98A054056AB6576D59D238AAC0EB5755405BE55910000F53184B5C41E14D19A7F6FB2FDF06495A220AC050C2BE05A1019AE7095970F150F4586863D9EA1EF3E6E1A1683D9B2F92A5880E3C4F0C97EC77BC9B658D04B2581DDD820DCBBD7644AF5CAB71862E0B472967E92E96995DCE3C8DE77E44F80EA761224DEDDD23D04B2B24E24E679200B911532019AD015520178994FB45F5A696B4F20AEF0F8702DF12179F2E4F4B163536F0BFB5136D9D132771AF32BEFCBA2187CE62158C7EADC7540012D4B6A0E15B13835C881632C9643A18A29D7C245235AF3B79706570FE31E088A56E0568615701DAA1F82389D1D1E421DD6E9AA4D29709D11A781B1EB55145DC33AAEAF05A6D2D2D9265669E7A5518029BD82A553A99EAFA6EEC7E585CE482754C0E60D279474ECD8929617F0B77DDCB86925F995D8FB4BDBB25830648C65452E9546CEB7372611D564E84965B2AB91C375F99E373FDFDB5113B80FB07A57CBDE8C0B6605248102FEA611CB52FB0A91CD7168130F7384F442E568B523ACDBEE1E7BCDE2CD498415132C974B87D517A8AFF71447579CD1E1628FB3FC4AB35CF964B5B25B933E3B205D3C64E24A9581BBFB70DE95E29505EE36B1EC5502AB1F4B96B4238B649A1623E5628980EC0D9241890D7F223CD944400CB88479FD68ED6DAE58AE71B48605BDCE4829264E67020B5C8AB6B5ADCE2793F1783C994CC0EBC24988560CD76FF3F33BDEFBBB3B9BFC875F16A92A8980C62069050AF8A14EA5A460C9E1100D17EDCD2FD41BC08E768CB41925A7CEBAC7631317DF077B06BB7BAB70BE1BA3D57506612D2885475BF47EF1AFD1A1A128E457CED399CD994220C21F2BABDE76E5AD9F59C2834ED0C016BB7FF399C5E78C0CD6FDC638A1C9A86059F41D0D3A07A49E5898B2DAF27653A0EE4256C19E2B2B05D90C9BEA1259E100CBB0A5B69583401C56C2A63ED35CD50EE11A70F65F035C93086C3C397DE1D814B0C0F2BDFCFCED8EE0A0ABB37371F1E8C371E4000723D8D7F250230CA99C4D01AA4DB44C6822F7820C6B1D700DAED7F8D5604330D8D361F74F32AC0590B69EF1ADFA4A7D086B418428C0196DABF738E7AA6451608D97E6C85117112559611697CA4621159636E832B0256135E93DE9D4AE762AB7EA26FA26538AF9AD8C579BCC015025B841EB30E86CE4DDEED4AB7CFC58983793BB20260161B9A4120860531AFBCD9E2B8D5456FCA93F720051C5C7936508D6A9A9BF8C6D03AC3D23BE6EAFAFEC869B5B2B0E38A7AE8E1EBD91532DB3003721AB3D6C39A589960BB280DAD0102CB1AFF70DDA7B68A8B8A70C609D93D1BA0A1916231B75A21E3B1AADF71C5730C142C6B74AC77CAB5113CCC8E011CDB03E98414BB5315F67546DB2E3A27B64EB7638024ECBFED48B8125ED866511E0CA310C5C7EAEDB347126C08B71E8E0D4EB95F24240C2610AD6C16576FE335F7F752972ED6645C5CDB603A164FC09A0FAC5F4852964816584B5A366D17B78F1D0420C3FF258618173FFEC2F1304F218442C5707AAD70F1539B018E05E72A3ACC5117303AE7081ED1BEC015C3B3A164620C19A9309D62A712BA0EA8CAC00AA432B91FAE3E555F3E66CBD36C84B3445D345FE87E82C7E271599B4E98D3EA71B7419B0C127184B588670D86470ABC594A2B4B2B01783CEAF269912E4D964E5CA063F92FD84766C092F910C5D0C26E482FAB2CF6C9ED186A779BE8C1D56CD33ED97022B7F0658FBDBFE40C11AFF90589EE270BD37F67EE1E2E061DFD91B4B3164D6250ACCBE961BD52AF7091D546F55ABED45450B1AE55A0EEE683B54F7CF900D94F4BC1F0C2E20B03568565ED844A94001462BA25A303C3CEB1C86780558E79A07A40C7346F71310A516A6810C56640AEBE1ADD7BCC6768B64D8DCC91299C0FEF45C40F7C4312E57FB0D2B41E65F296DDF2D8295C65C85B9E896D8962D26C4D09A4154D8AD72C1DF8C50639BAF2F9B85C9D5ECAB88B3A2A2A2BBA27F95707D72E08B0B0CEB7FEE75043BDE9FED7E5A748AB22B84AD4E6D3DFAC384CAA4CA6D42D5D150D4D0A052FB1599956075ABB19E227B30B81E7CFE6001C2B5684031EF696A22C920C20A14F03FB2AE3F24CEFB0E5FF434DE7141BD1C71EA4EF18E64C658E8DC1DE8091B7A8B14C690571D7284F73450F55834DA75D3343AB18E051D5CB358D96DDC9AA416EC4C4C582E986C4AB5598E8E55A328A96FB278B8162DA44410A159A0F9639F1FDFEFFBBE7667092550489F7CEEF93E9F5FCF07F7873C13930182F576EF6F5BEEE97E9849CC5B62E250798C3DA833F5C78B0AF5A2108A0358E2580ED98AE4EB430216338E568B9958ADE2C658898EBDECB5E461192C5B2C631608BB2DF876C4E42216FFF5B248115602E28E52D2B8F10862C0FEF51F26FE1DAA2E7FE312E00AFCFA4DC37F8BCEEE20AC8FC383DAE8E8F6D44E3C328802949E2687D27DD7A5309E3C1C984805075C5FA6149EC082804E8911D7C44C7013701D5F8A6BE3A3116C37FEDC1CAD14AC81CFA7719B70A26379FA3BC9DE349B74BFB051E355CCB5F0FF8A2001FEE540BAD820A4FB593964A890CBCB6E168B297DB51AE784A41D9BE1D26CD5AB2F56FDCA50BE9EB51608A5F19E31D066ACB8C4C8AB690B6915A23529C3D5EC7BF19BA1EA50757DE0922F74F99CF79B4FBC9F78BD3B1F63C03E5ED146C7B7A7561B5D8BACAE2020D5B9FEBB8F148ED514BE4F0A8E0F0777551209151CB0625C287123823A408BAF8C6A9153006B39D75ACABFE0340B500D4C4E04E097A1BA2BFE4FD3DE916B845B6260304B1E25354E3DCAF50CF61CC5987D0F6750F9DB6B1CCB30B1ABFE42596470EA4B98327515AA353B3727373F976704314EF7D8C7F4F906852B1D44A3E22FEA2B712187C6F185D128FB5E48D746FBEF10D69140C8E7F3A11E686868287A9DC2B5A7077811C831329340A0900580022218AC6284D55DA1CEE02466D0A170A640F48A45037CB72A1617C707400768DB2BC35DFFB1DBED1EAE0C9693C0225C273DD3F068053CD34F4F36DBAF48A35151208EC9DBC431AE0C8A82A72CBBE2F0D5C61E0DB70B5C73F57EB639232831E957ABD40256B967B4BF2F90C7B7F1F60A448F8CCC8D0F703182FF2031990A88133978D4077540866DDFB99683F6FB81EA50E85C7908717D710A71F5369C67765D99D7E6AE8E0F60911FC1723BD4EE4810BFEF24034016A8DA979BAECDE08C0A8A80863258B756B4AA2A4E612D26301B007DB512475F924A56581E11AD806B7DF907D3A00526A79B2B97EDBD2DECE09A140F964DCF5FB3787F9F074C3744319B0F3E1688FA15C7AB397795252CAEFF4B656531D5AE446A60228EC33C2A4F4DAC0D1C9BD51732B9DD2239764B5A8D33B9DA32F45895B0A6F5568542E500AB0F3FDFFF4711866B27E0DAF3714F78787E69D8A52598021C0E75A13FB2ABBA39201D80B286E9D4800B0B2DEE94D0B090C7B60E5EBBEE5613806C2215D91E1F1ED5E2AB76539AC5528090AD9BF080C27A7AB2D26FA726A1B199657B70DFC68398221BE7344B9A0F13AE7CE22987DC868DA68BE55BE12AEBA986F1B5E4538B516EE1D30D5C0FC8CD96CEA2BCBC9C259D1AB732A50A1046A849BE4C2B332C13B74EFB805A47CAD13BA16A7DFDF7AF1761B8AEF4200B84577E1AD722B8624550AAD79B5CC176EEBE628B0093A94D17C52FCD0A22B088EA606D595961EDEA3545055C2B22DB245CD3281F087804B962363009C0764CA0707D7612F201916689212C5BC6F1159BBE9C299E8C03623342540671AC953D1A4006E4EB17346505DBA2E701568BB9F162D16BDBE21D13E5166C2FE4D00BC8B3C294C591757BCC7415836EBB728A95C16688491B1F2526535CE97F530FF26A6D04A3751D3E976E9C055C8BFEFA0A466B4FF8AAB63BBC9952DD372A2A1CEAA3E3AE88A63AE87BEE685794465ACB088ADF7273C9C57D61A1B0AC74B6345C56181D042A80870BF975AAC56EFFF48701C6552404F868DDC6EC15A215603D785F9875B217E23B5304ABB47126357E40CCEFD3C8301ECBA096CB5ECEE1A347859837D55AE8ADB718DC2ADA00566B895177359F1DCDCB164B437C22F3B9746B1406029931D1A8602DC01B59497946F15BD76BD25E0B54579713AC21DFBBBEF5AA5BFF1CF3BEF4BEFC0830859FD25D8035A82D2E820898A939DD088F1365FE88AA2B887B2E2859E9B76E70F5F5C25C61D9EC6C29FE94152E29898AC475A057ADA9171D0A596179CEF4F5A1C2827F3EB83D8D320B60AD4CA326211F77C3247B62AAC9665C22A3778B2B027AA350345E0184C33BBF70E61BC3427881C062902746AB55BC4E4647D62AE3573F3D8CA736F2781303EB2C986C14B06B2CAF0C09EBAB2C2104F8D6AF4DE602C6C54C5CD144B3B6FABEB5721CBCC221A1F517E78ABD0DDE1EC015900DAFCE8F4340BADCAAAA9DE86E0CCEAB5461713818551750C023C5AD0FBCBA2B08D552C0143FE1B2DAC1C48B0A6481A607ACB03CB893883557A2568475C853F9F9B3E6655058BDFBA6B09ED4FCDAA6AFBCC5642D5BC40E1BBABF47578A0188A34B4BCE7CF8F0E6BBD3F9E7FFE75683604BF45AAC38302028807B0B79382384CF20FEA56DF04A0DBF57BA9708BD58D415C0C4258397DE4DF6CD825A43437D6B018C561EBD5AFC31C0FA7216A31590B93ADF08E04552DADD6E084D3755AF21565B23882A4B561EC7400E50D4B9420CD4685394E2B5345CB8907801C1BAD08DC2B58E2AAE1E51CB465791BADBCF863CCD931256FDFE2B7CAFFE74CAA697063975CD129581CF885DD3797B107935FB706EFEABF05E712FCB6959B9F82BE77EE16AD11B5AD61253EDCAB48F65112A222F678F46B1395A9FCBB545C1445972313B6B4B3FA2AC9BE21ABEC2695B4321346B1B79FB12722BE17AAB029EADA2CE6829C11ABEDAB58BB8BA4E4F75819222FE0406881003B882118752C1147003F4D68538F06A69F4E691E8CD8F3862C385D76E01AC4B533BA0B0FCD47609E032615D7D1FA4AFF5FE934F27EA9AFD04ABFD5E52BF599EA1DBB70AE12AD75D7860872BAE7B90BAB2A350F6D13C5CCCE49384CEF327DE7DCB69918F96D584A8B5C410AE46A9C538954D3B2E72D9951C46C5A612D7258468A5151C366E154D019B7E45A485A3F5EB00193612AC5504EBE5AAEBC32F215E3BF98B5C1A8E6E76A1CB5577A32BE8A6B996F6564215C03EE1722B3C2D8009979AEAC7D76AF548341A3D76F3712D011B9E4D8D8F3F5C8AACD8B139CEF900FCD45506E0D9AAF3773C9DE83849B02EDBEFC5746BA12D7DB64D8E0DCB6095A6A39F71DF958B823990CDE7A29F3D5140F7C299BF3BF7CF5F588C3680F12F967DE49A6FC90746C8A7137CC8D7D8CA7A2E1C8E330509D1F0D25616D7AEE4F954C9AC26F77BA2D63E2081372079A568BD7CB9EDE1CC9BDEE206EFD9D95AC675B6DBD5D5D57DBA115E272250C5111980588D0483330A4D66A26C55D4F6F99AC2F0EC2C846AF4586DF4D80F1E8BFF7C55D316E29BDDACB000526C13C2A7B22E50E7F7777C35D1E16758D3BE7A4D6C1166B0B70C2F6866658ABD57D12B1496CE14ADE9057C770914407E1E1A0E230794F43F59FB9E73FF1E91C5BAAF3860D06B8951FAE6FA1768ACECBC829C4378AC778FC6E8328DA136E65576C38D19236DFB2DE911DE07A16AA056003644D15AB50EA8B6DD99EFF48E8D798B1F47111988B9E8E9CDA94617E6ADA801DC802A60BA39E35681121CC0AC0E457568174F43AC468F1C0354295CBD61C2355CBAABCDC5B7BB5BB8D8C24F16D200ED0F31AC579A979797D374E19A217BDA1CAAA222C0512BD7DE38CD127B3E28AC8057F16896C5F9DDA9B925A7E456BD8B2D3604CC6541F3443CFE9A8D1B1DE8F5909F93FEC79F20AE6CB9B5214F3AF2D082E86289272029604D1E34CEE5A5D9CE01AC237DF56B02569FEF43B4AD9BD91EF38EBD2CF68E95D6C2CB035269169980606D8758C57D572DA5A8AD62634851DAB5E045576DB8EC26A20A9F9BD1E8F19EA25A6281707C3E1EDFAE01858555017AB1185844B6A3E55F27FDFE6986F5BEF900917196581F16C8D43DB144330B6B4C9C6F823242CF7184F52FFDC33F72EEEB1296ECEB6D9938D56A311F20CF2D002D010F606EDEA1BFD53CDC2948A7BE002F84C5C8F98A9A2DEC75B0C57556F6C49536E3F29E50CBB9F2EA1092C01AA6AE55EBBE2FDEFCB0ADEDCEE8FC2B10AE6363C5DECE5A016CED54D745174D629E38E1024C955651605554E5516330E8EA8A72ACE2CF2A42DB545CCCB8AEECC6E7B6FB410AA4F9895C1956F614A86C9910B0FA45B41EE463CF6C326872C2626085C0E22621DD7DE66A2B92402E2DBD3A7F59F396F3558BB92860958B2FE6E101915E1985192CB5A048036A3D747EA1B97E259DAE0D898792FF10F464897280B8FC9BB4D9F69DC24B528B70EDCCCFDE06161859A7F5169FEF49DB9DB63B77AE3776161503AEEF7BDF0F1FAB9D854F595974601E84402AB29B5A54152A56B7BB5B13AD292DF23FB6AE36A6CDEB0A834966E7B2159322333C150B909071F8039AA38449537116F8B555C8442C8DB063751908C5323452828695A6A05476272783D230150D582AA572C3AC8629D9644410125214CF8582F229220193FD0344C78414949F3BE7DC73EFFBB22D4913FAA1567D727CEEF978CEF3E0417138E209A408555F8AC375EE2D282700D6B9F5D9D93C8A6B0B5C1054D733B02DF8A36B711A609D5CC268C5DDEBA2D5D8BA48A71CCD6E93C316A5DF26ED1C58FF0A2B78EA5EA970FDFBD1A31566D2609569AE6288B557190C214EACC434427A7BF117CD97B6BCE3BF0354F779BC63338909D96C721C200BD623CA9BCEECD70488FEEC2C4AAA628705B9F5DE3FE7BFBAF0E06E7C3679D155E37261C0EEFA1CD836A53DBEF14EECA83ADBE46E903EFC0F09D3B2B270D21390B18A88CA6FED232E1F25D7F5FC6C74ED3BF483ACFEDC48AE18ADD5A7AF43B49EFE7609A3D57259DD102DF24E9B839575DB105643139386AD74975DC2015B4E9B97F28AA3050797AF46A7CA3817E872D5545D955738A10426BB91E25F8CAF6D2E5D9AE25370F95E2ABB5CDB584E32DA8824B468580D64CC43ECBED5FA33F5B12BB1FAE16778373431B1F1E0C18527B3D97838D9BB7BFCB8CB05E8F652C042339AFC049782BF9593D5B6B61765A75803C30F89359DAAC5E70A51ADA52C50F74D651A5B82C0EC7A7EE0C6EB1DBC4BA67D16E25A4F59A03E730460EDDAF132ACA6FB014E02A489A091FD81BA3C65E5464DBDA08805544D3C7733B9ADC0FCF1E7CFBE89D3C63703E548BFB2EF39DFFE707CB37F2B1B2934A4B0B96FCD69D7ECC3FADCE9A09B2DE9E106BFBBDD77EDEC992BABB1BEE167922BFCEEA5BB4F66C7B3CF471F9E7F31BBFC12A0ADA919493B281100AEC40F80606D6BBBDF7D2A5AE6F7AF87305853882A5656540550B0FAEA562AA9D3724FCD96355B83E7F064A0E3F31E59B872B48A45CCAD5E8A56EB652DDC963BAC8FDF6D4A5040BB3DF29B25BD47F6D5F9106D09CB95705B4181C1B4601ABB2E615590F217BA6E453D6C5A38FEE88F49EFEDECA5E62FC8EC8078ADD493E4F4E84A92AF72DC5F2D72A866F4B0D5722376E5CA99B3B1D815EAB210D7B5F9D9F9ECFCF3FCFD37FFE884CC393EB77BBCB2E6A5C34709F66BC255820A09D53F1E0154D7C3218F1BEAD55A07A6805ADF8A4C020C2B54AE73D1ACB06CD0391232B1F8C98290F58AE0358415055B2CD6D7D6034E844AA68186582636264BE120159B16AF945EB1CB2AD7B81AFBD743C67126EFB235EDC5C46953EAEDCEBD62A8D8DEFEF5F8D6E6C6B5E60F30DFD0D86C8CE901BC6C19536C0645123CE00706B00A714EA68198BA6F99E8599E9FCD3E1F5C6F6C686C6C842AEAFCF3F65ED75B2394083CBE1F9E4762C00B02B52C148944B103832A205597C03E00336B2A2503164A2C863590981662882C8D45A607ABAC26995E33FF0FD6C5C37C3FA0760336356F1DA30501959285453813DD93D436B9242C57B01EB8232A30E8170546A96A3A743546DF15A54EBAF3B47F31BE797BE3BD88B3506F25C7B413390F5A91D53EA62DDD4C1679D4640931DDDFB70A69E0D66772D202AFD6AD710CD6C106B96E6D9B99BA193EF6B2F27882709DFA049AD43202351981502554A39EB4CF47B0A6642F90F0257CB5ED7FAE495307BC3217486CA32F1C0969585AB01EA8A660B588E026C27A02BE5BAE6B2AA66C08982520571DDC1028660B31CEC8C90A7FE60521569D38DC339D69AB7AF5D07F495E9A9FAB0AC3C1C18E6A8525C5451BC9FEE9F95F29A791A73413CC314F90996C8A2168F8651B6FD6A4B034DDBEB60A69E0560F472BBC5ACBCB77E3900388A2FE4EE77CBBDF1FBEB952731CE315C3D50FA0FA11D481A894C40E4F79D25808C8605DE1E4DA3E5739E2A3DCBA920EB81DDB622343379A16F17E13E15A5F6F9177032CDA0475ABB2732082F3D861934A838D679E63744E8852F9D40BC86865B2104EB02A4CFC3683E75E50653C55FC5899E82CFC5389B3B464BF08B5848AF657221F67F70B756AD52F968D86C1743044AC2B65AA6CD5AE83F0EDFAA4C8BC77E753A803CEF4C454B4429195055849790DB268A303C05BF787A72A471C985D93E15312D45052098DFB131EF83B04AB2C04F087A36EA4528E05022B8940C05D278243425AC55B444713F4B13D1D789A7DE7348A0C7A4FB48860D06A55914A67DABC9197A316DCB9D854032B55C55EEDC921BED318B7B0CE82AE48555A3DA4375946563DB0F52258514A8C560345451F2E7FA06D71E8F73247B19AE389A0F6C7515E6D3A036021B02332EF566FF6F7C57E3ADCF78C516DB877097D431AA4304867B659421786EA1E714D84C3FE6424190A0D74FBA51696DF9FC68580CFC1612ACB01C8ACB2CB82249070077A7FB221CE418D25F0CECD2244C7096F0625712E2367F804C6AB6521A8BC72A8DB1ED3432C393B42A96F79FA2AF759FB7C3BA0782DF866618DA4F759A619568159F352935E0EB235A079B5B3B3F3BEB3B8A8B8A8488B352A89262D313E46AD001B7CB1C9A055DBE4052F03AC77AA1FC7565787550E38F9E6E7D9783C7F55E680CEABED519666BDB95BE94E0080EBEB10A9518A55D617D5B0A61C2A56138EF691CADD5A42B51761750712427CBFCDF19AF931BAC66242785C4D92984B5EAF78CD960E7A41C06B793DBBA24A80ED6B2565903CCAC93AD34E87EFA5F4935A68992EB415FD52E580AA2A5D59699C91265882FF2E220BF1E58796BFA370B549BFA923C64A808B56B3AD9A25B8203E42A2E9B9D5D8C7C3346B85609D58CBC707F38DF2C5EA8C0CA88F7A3852E38267CBD39E045055064060C36508ABC7E7482552722600FD6BDD37352E355994B0FAB6C5F5EF3FC26B624CB0F238536C4FBEDF4249C0DB6179AD0D74A516969214904D8E29CB728145244C6A60E593850657A5AA21E0498AA95D95F8FDCBA85955223844A2CD05E576FB9EB41DC35C6097424DAAFFE0501DB37102D0E5959104C8B18EC00558332DB8A31B6A8D7DC697AE6F7E9F8D3FC98FCA609D996F0E691D4108D75D076481EE107CD36897FDB23B49D19A76A4B00EC01490826085AE37C14B2D0D2BA657C107DA7444281E5B3AAA4FA0729BB723B860393017543ACE36D56591F4A8E6B74817A2A7FBCA29872A01EA08FEE780407FF8CDC43780D348C1156496BD27FDB2A57D83B48EC176590EAE72B41280AF48A88B395747B4FBB0295C2D98045A5A905CD6DFAA0AD789589E73C03B8D337F69C7D79E35EFC22B35356E789D42A700D66448C10A5FE3C80007D8042BD50310AC386F35722BC16A95B8920937022BB677443DA9E22D79333782562D8CCBD7EF3926B771B325FF50AAA32AB3E271AA5DEA3494F2F5FB01BE907AAA0C388D110B4F5C2A504A08A3B4D4C9240127DB48CA592BEF5A647D45C6AE9C5B95D38845BD5964F27E1DDE90962EE29BB7C65A09D786892CDA08FEE1DE9B99999917ED03A1A85F698A87BB476AA01AF04420071C0B25A11E80EFEBA16477C4832383748A52800F07027510AC23B5BCB6A102AB3790C0FFA4581812529C01F380782C3A506D10470299C9A0C5446B2153173D1C5426BA365564D1B065EF15C9DF3859B9924C19CD49401F12198B409EB11A5FCB9045AE11A414BB34C841D99BA7A824F0B4B09059427A1C201917DAC94D59E3495C33FC6750B792F677FDEDA1BE5BAD13806B434F165D44E377EFDEBFFA700011F4B34CAB3F3CF0D25513A8D559A06CBD3B1A02DC432B9803DC14ACB27D4DB45F94C1CAD18ABB4677823C9FC5CE63A9DB849DC1CE65518D02635D4B5B1D5B525CC8AA2D8872266D11AA04C8A4466E602907483BED3D2958C5E461491F36AA7D2E5C0DA6CB01D13BED8A51514ECD00915B15B56D5F8A0B2A6AAB341C926C365CB62C1E31AD5BA53FA6AA5E2D931912A56B6AEA5F8BB502AE905A7BA0688D0F0EE6BBA3DD6553504725295CB114881C8BB85C58BC721638964CC2EB05C51624063794AD29EAAEB070AD4BC13FE8D37C81398435BD2CE86322CE7DCB7A582283C18A0FD6E9AD9DAE1DAC04D88F74510E5B7286C618FEAF511199E3C82D64EFF7FD7DBBEC38F9EEB5D43C15D00A433CB2364D040E9C6F94DB4BD5B92B11109DE4C7E57CA5EC1C395A595958AF5B4D6BC18CD5B0AAB45A5E2F0878325ABABE5C8B0DC5BE7AF268E2E4BD47CBF1787C343E3A38F8EF320C56C295508D741FDBA570955900818D625B104D7BDC2AB13A70E292A8FB8DCB75B1D6AD60C5222BE0FB549AE78A85C8B6C4554C6744753555015BDE2F836281DD9D0CD1716DEB227FC578E5D51656024518AD7F42CEE09E2C374BB8C032C56B95796C55654C04CC6D003402AFECF4ABB3C4C9A72E74885144030825C5A3B6D87C3064C46AC6D40E64A4632EF403F031FCEBF4AD58FF5AEB85278F864FC6B3E3B3F97C7E70749461055C694E1D3915FADB1C44216401FACB21F8F823A8DD49B7C7ED68074C71868DE9B5EE3F6D5D6F485B5916D737DAC40B33260CC4C6828F266C88D17E4CB05970DD270DFDB2146603B25388B83018D4990404EB8CD9E9802CCCB6A403298D1F64A9A368917142A1E0B0AF48B7200C0D5557703F8404BA536CC1D2E50DC2F4D37CD873CE3DF7E645F626B52229D693E3EF9E3FBFF33B95B049D195F2D73C78AB35C7661DDF2E3F15A4D4B625AA532952C8BF1FDF409E00EBF6AB45AFA48827E917746148B37A97E49627DAB9486916AD7CEF6614403DDB9E26D95D36AEDCE1694B2AA02530E9436F3779BEDF47B71552BE5BBCD5CB056C0EAE77352FC00502DCD0368C542835395F9EFFBA3EFFE093A3E16DDC1BB6BCBC3CB1FCEAE79F0FA5F91626FEF869014D3CFAFB440230D3C6C015902097DBC42F1E646CAB42E580C861040B2EE919B07E919858CD53844080F69C8F972FCF621B56DC12223E2833ACFBFB9371A1C633BB64378B5BDA2C2D720E9C454A51113593C65DDE83F495EA2D2827E0EFA65DDA5CCA0ABAA4063B34F9EAFF64583C3AE4439A1082808CD6688418A73259115F212B512FE5CA09B5D9B969CB26BA1A4FE7C43E9875B1FE75B98C3B998F8EB6BF7BFEF8315815BD94CC46389ACDD127AF6B64B01C5C5AA300AA88B1A3A30F3317206205AB06B03F00716BBF99309D089AD5B29465F35655C8F5D17F2D5FBE5DDF15620FB000791808AE6FC7E26B5531A7D611AA3DAF2C3226E9AD146AA9BE76438FBE9FA236BE1E57A7A5CFC1E0D949ED565F6D6385162D78419B07C9E7FD1CBA9E12BB1527DDBC4C6739D6E87AAC653A94AB565B6E2CB4F07D711ECC3A74BD5E2E97EB0F1EE04A564081E5C2329973459A75000BABF8C968CE4C846BC5C382045582D801275644AB4630B20A44AC629A5E0466B5AC9AC39996EDD864564F97E1A9DF9E1EAC8BF167022EAC90941EC7086B9F19AE52C57997A2D625BDD44111871A727F564312DD25199DE9D872DFAD0E062E7208A5CAD8FA063B23CD224BAD3E240B0649171FC30164B470E755F215E5F6516FA7AE094A8EE0AE868096DA20BA2BA2C0E44FF5D9F26CFD93EDEDBF3D597E5E206F05F0CC91E1E0E4A475470766CC92990914C0A8A3E0C468E9030720002B5788AB11AB92FB46DADE8A644AE1B01925BB5A25FB44305169FEF6E0F4D44B8000831A2F29EAB9805D3DC6DC2E97B1F5ADB5C46B1EA58E63A74A5E25211B00504EBCFA64D7857B2FD8D776A9E25124D0E102DA8B6E994665DF1ED6D4ED818B8F48DE38F4C1BA178A812DE3564A078EF5806BD55516349AFEBA27AAC9542A34995AAD1FCDCE3ED93E5A7EF59C9D15DC959D7493D180D0D534ADF4C46861A2304AB830E3F457B07C4D314071B390CD2E242060E8B79CB059820482CC6A87A35B82BF7FFDF660686A19C7350749291FAD3AF6662CFEC618BFC32870CC8AC32E2696865997B74A0CE8E6F66B8FEE15F6045DD8DAA6EBAD6D1D67A52F5D0B487D72B6D38FE24F7248999842B226A0BEFBB11A6F55DEDAAC0A7230A08061FC3EBA6B28F4DBC9C5FFCC1E3D7EF2F8F1ABE595426142DA912F2DF65AF8F3DA0E27CC44FA876CCE3A9CC8160AA30BA50B692C0402BC5AC55C013284C240092C1F853CAB94304B61BAB8ECBE5A5D7AABB85ABE3B38BD0DEFA648B19EFBBEF4D67D0F8D6528BEE0B157A9E433134BA6AE4A65486E1CC065A13EBA667C1A5B090782AEC280AA60C9D56F6D179BA9D64517A785F2339CC7F8904A580DB92F97B5DB79104BCD60F0C090A207553DAA265865B7357E593C79042030B95ABF31557EFE02D75EFE61B9F0E245166C96CD6E6E660BA305765AC285813CD8B5B430606762C5747AE2874BA5343A2B5A35022F0643675FCF20C120015675F289B0839156A6AFB4C266FD736A6AF0EEAC219D1579586C56A4B87AEE283AB64CB058588472ADCE7318635182C0F32EB4839D9CB5D7AFFBDADD4DB33607B1DA9AB3589ACED222D80A9E1CC41A4D90420178ABA801D9201D81865E3BA673AC5D571FDB500E5B6D8658E2FEDB47AB5B93A9ADC5F99191EFEBE6AF970E76760E760EE9ACE4E0402605CE5AE0932D7CF33A6A42B09F0EC4003103958552260D3715B5063731AB85D46B216F96C0A860D5978F8A256C68D9F9B0B9731E57651BBFECADDF9BFEF11938EBFE5448828072D73700F54B9EB33BB4957E238FBF71AB5012B2FF0D4916C9B8F3B8AA8E079A5A381D7ACEBDC3D5E16A6D0DF2CC6BAF1F87DF095C09049464EBF139AF5AEA2A67875B31C0A3322C1DBA1A77E6D6A7E3D7E7D1A8378667C31F5C2C4142240F4746361DCB8270F490CC3CB1502985FB1EF65B313B56EC2F96D28122F75B6C3E5611894670FE2BC4FA41C28980B786C3B538E6FCE2D6EEFAF05D085C6F1A48C1480D51DCCA6685FFDD1D8F9ACE3CE66616AB8C69495792C6D463DA7FF7F9B830D8CD1B1868F5754F8F4BB2C93DDCAA7EF9DD8EDA342B8A6975FB8344C67E47BAAD2CBCA1560F4AFD10561082E4B5EA8257437F3ABE27200CF86AF55A72E4C6C8F0FCCC3F1F3E8494284369670C1F762CCA8F8C0D086AC1A318E94F67CC0F0EFBB1110B19550012D60A4400152B1383D7C5AC0B563A41CE9A1933BA8CF35F24A2112B1A369D55E1E9EC1A5F14D5E1E12D7113322C640B4C6EAC8161C7F69133B80F6FFBD3AB1E7487254D195CE2C6362B39CA6696B75D47AEA82EC6E36E2A20F04BB3B654FF5CB3831DAAA1A55EC09B8B64E68B912B8AE14A7D0625D97A4EB9AB72D6661BABBAAB5357639C4C2BF6B08A3C99BC06BEFAF2E58FC3CF0F560003E01CEEA09BCA279FA81D90D554CCFCD38152388DE5D498D52F6901954A805D359AF85DCA311102E6F1EE37D6F3662D62012C7C2E3C5D62EFAD308687AF00060C4D11B76D0D27B3185D019DAA77643A20D32C6553293DDAE9A576969AD06AB4B3161E1548FCFEEE5E17C0F6047559C0B502A30900AE06E16F707D5910B739057122C3D72D35869514EE92342AB75C94B3B66CCAADBA232CB87865612E3932920C25932FBFFF8B59CA44E9F79F4680A4519565AD4031404FEA54A56BC50824AD5614B0E1B042595614CBAE76C0499C9CAFE17D153D4FF1BF5875FA4A0EDC61B58F85C7F85C0831786F4818370789DB929A5C7BB6B67642DE0AB180C778AB3858C79D5A759C35723BBDED7200D5DB90BB00580CEFD4C702764A15A405053ADCAB1B5B66053400F87D7057D1AA3C94C4F6A17EF1BB76B52B5733B0B87ED5D9D5EAAD9CB6569B40B0273E0E419673ED466832141A4A7EF98FBE30D5450853E5AC8A1D5370400D40341F5CFC95A20D31550620206349AA70201091D62F269CB7229F2899CE5782D61E8945C7FC164303E7276160155BA4EE0D19626C8A28186BA92B1B5BF193F83E265A717CAB9778151957B03AF5A5A596BF935DD57C266D60C4A14A9DCF4B88F5075B022C77B3A525BD62E306A5B82062C969EFFB724396627DF260268DB7602840EEEA698E0C19EACE92402BE69E0AA2EE5E4B0EE14FF8A7EF3EEBFB08CD9A57460523494795DE1A91108024804AD406F78448207A01832B3A6069BCDBFA9C0DF10539ABE47FA38D7FC50B2C7149883D9CCF1AFB724C1829CD1D1EDBDA583B19DBA7CE0BC4025765DB65E9AA26B76902B16BE123E503A85AFD8EA4464F959FFA5CDEDA8C0538D66A3B5361510E1B64822BFCBBF72110EE9652028D76BD256B89B559F4C8100702AA1DC0F9ABC1BD812AE5E4F8D38592A1CB7533FCED4E3ECFCE2A4180486AF0D1B2A940CD74EB48C48E59959805907081F841112B021117796B0D40F4BA833754276DE7ACD6302E00C39A337171EB29F6B171535472504D10C4C7B650618C22570CB124B4E616BB581C8D83814ECA07580AA7FD9C9ED2A64D163E6550FE9BB505740CE0EABC9CDD31D026E78EFCD8D0C27E2BF12F7A7B1BEFF536DAD59D25F957E8AAE4AEAC1EA06A2D55DD78E506E17E88F6AA207B2F397DEFB370F8A3685EDB55DE54510E05E0CA8A60453500613F0453562C5A89D98409F2090F46814C7FF5C431F3EB1E32ABE7A4C6E196E93C13D799DF6654A790DF46DE1ABF12DFDA48C9720B99955282957F75799BBB07BC6C569A2494B3DADC1D6830D3FDB4E9ABB2EEDAE672D7FF013B0F5063B451CA240000000049454E44AE426082)
INSERT [dbo].[Personas] ([idPersona], [idCategoria], [Nombre], [Foto]) VALUES (6, 6, N'binkor', 0x89504E470D0A1A0A0000000D49484452000001F4000001F40806000000CBD6DF8A0000001974455874536F6674776172650041646F626520496D616765526561647971C9653C0000032269545874584D4C3A636F6D2E61646F62652E786D7000000000003C3F787061636B657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B633964223F3E203C783A786D706D65746120786D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F726520352E332D633031312036362E3134353636312C20323031322F30322F30362D31343A35363A32372020202020202020223E203C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E7323223E203C7264663A4465736372697074696F6E207264663A61626F75743D222220786D6C6E733A786D703D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220786D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F2220786D6C6E733A73745265663D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F73547970652F5265736F75726365526566232220786D703A43726561746F72546F6F6C3D2241646F62652050686F746F73686F7020435336202857696E646F7773292220786D704D4D3A496E7374616E636549443D22786D702E6969643A41314434353446304444434331314538413943413944324235433333433043462220786D704D4D3A446F63756D656E7449443D22786D702E6469643A4131443435344631444443433131453841394341394432423543333343304346223E203C786D704D4D3A4465726976656446726F6D2073745265663A696E7374616E636549443D22786D702E6969643A4131443435344545444443433131453841394341394432423543333343304346222073745265663A646F63756D656E7449443D22786D702E6469643A4131443435344546444443433131453841394341394432423543333343304346222F3E203C2F7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C2F783A786D706D6574613E203C3F787061636B657420656E643D2272223F3E8CDC8959000007614944415478DAECDA3D4E42411486E183A058684C08C18682CA15B8052A97E106AC8C959D151BB2B4372C80CE05D01BE5679C6867C3AD2647F33CC9B8802F785F26975EACEE0212BAAA676506125AD4736F8646CA2662388D327BB0C50147260000410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D00041D0010740040D00100410700410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D00041D0010740040D00100410700410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D0010740010740040D00100410700041D00041D0010740040D00100410700410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D00041D0010740040D00100410700410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D00041D0010740040D0010041070041370100083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A043221F2620A9AD095AEB99A083413D576620A19909486AE2B9D9F8DE59B6B1FC5C9BE2E0D79ED55D310300FCFD1B3A0024E7EE29E800FC03DEA31FE247710020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300ED0D4C00406E2562F76E860E415F98818446F5DC9A81845EEB7931432BFB88FE797D22CC4DD121E8F76620A14B4127A9E77A1ECDD0EA72BEFB0E7A19DFD8E200EFD0C9EAC20424756A82E6553781A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A00083A0020E80080A00300820E00820E00083A0020E80080A00380A00300820E00083A0020E80020E80080A00300820E00083A0008BA090040D00100410700041D0010740010740040D00100410700041D00041D0010740040D00100410700410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D00041D00107400A09541948D15C8A9776C03F229FBFA676787667B6F7F0E1D823E9C5A8184FFC4F581B959DB816C1FCCFAD43C8BE89F9BA265D04F2676E812F4327BB002E92C3FD771FDF6F4F3008D9E41C861F71E319A4719DFD88274BC4327A5BE8803083AFFE022F47D330740D00140D00100410700041D0010740010740040D00100410700041D00041D0010740040D00100410700410700041D0010740040D00100410700410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D00041D0010740040D00100410700410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D00041D0010740040D00100410700410700041D0010740040D00140D00100410700041D0010740010740040D00100410700041D0010740010740040D00100410700041D00041D0010740040D00180DFBE04180004753FA7624C4F220000000049454E44AE426082)
SET IDENTITY_INSERT [dbo].[Personas] OFF
SET IDENTITY_INSERT [dbo].[Preguntas] ON 

INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (1, N'Tiene El Pelo Largo (supera los hombros)', 6, 50)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (2, N'Tiene el pelo medianamente largo (hasta los hombros)', 6, 80)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (3, N'Tiene ojos rojos', 2, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (4, N'Tiene el Pelo muy largo(tipo Ssj3, Raditz o Madara)', 6, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (5, N'Tiene ojos azules', 2, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (6, N'Tiene ojos verdes', 2, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (7, N'Tiene ojos marrones', 2, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (8, N'Tiene Ojos negros', 2, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (9, N'Tiene Pelo Rubio', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (10, N'Tiene Pelo Cafe', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (11, N'Tiene Pelo Rojo', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (12, N'Tiene Pelo Negro', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (13, N'Tiene pelo Rosa', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (14, N'Tiene pelo verde', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (15, N'Tiene el pelo rapado', 6, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (16, N'No tiene Pelo', 6, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (17, N'Tiene el pelo medianamente corto (supera las orejas)', 6, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (18, N'Tiene el Pelo Corto (no supera las orejas)', 6, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (19, N'Tiene el pelo blanco', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (20, N'Tiene el pelo Gris', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (21, N'Tiene el pelo Naranja', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (22, N'Tiene un rastreador', 1, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (23, N'Tiene anteojos', 1, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (24, N'Tiene Sombrero?', 13, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (25, N'Tiene Bigote Largo(tipo Draven)', 7, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (26, N'Tiene Bigote normal', 7, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (28, N'Tiene Bigote corto ', 7, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (29, N'Tiene Barba Larga', 8, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (30, N'Tiene Barba corta', 8, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (31, N'Tiene Barba afeitada', 8, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (33, N'Tiene Barba', 14, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (34, N'Tiene piel de color negro', 9, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (35, N' Tiene piel de color amarillo', 9, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (36, N'Tiene piel de color salmonido', 9, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (37, N'Tiene piel de color blanco palido', 9, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (38, N'Tiene piel de color moreno', 9, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (39, N'Tiene piel color verde', 9, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (40, N'Tiene color de piel rosa', 9, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (41, N'Tiene el pelo color azul', 5, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (42, N'Tiene color de piel celeste', 9, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (43, N'tiene nariz larga', 10, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (44, N'Tiene nariz corta', 10, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (46, N'es mujer', 11, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (47, N'es hombre', 11, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (48, N'genero desconocido', 11, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (49, N'sin genero', 11, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (50, N'Trapo comun', 11, 0)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (51, N'Trapo ^-1', 11, 0)
SET IDENTITY_INSERT [dbo].[Preguntas] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (1, N'Administrador', N'ýP$¬
ð2Ví”T´èˆ', N'fe80::a46f:b8f7:e889:b57b%16', N'Administrador', N'Admin@admin.com', 1, N'fe80::a46f:b8f7:e889')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (2, N'Anush', N'ýP$¬
ð2Ví”T´èˆ', N'fe80::d086:d438:54d1:e7b0%11', N'Nico', N'Nico@gmail.com', 1, N'fe80::d086:d438:54d1')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (3, N'Chino', N'ýP$¬
ð2Ví”T´èˆ', N'10.152.2.36', N'Chino', N'chino@gmail.com', 1, N'fe80::8d09:9161:6ff9:5cbc%5')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
ALTER TABLE [dbo].[Partidas]  WITH CHECK ADD  CONSTRAINT [FK_Partidas_Personas] FOREIGN KEY([idPer1])
REFERENCES [dbo].[Personas] ([idPersona])
GO
ALTER TABLE [dbo].[Partidas] CHECK CONSTRAINT [FK_Partidas_Personas]
GO
ALTER TABLE [dbo].[Partidas]  WITH CHECK ADD  CONSTRAINT [FK_Partidas_Personas1] FOREIGN KEY([idPer2])
REFERENCES [dbo].[Personas] ([idPersona])
GO
ALTER TABLE [dbo].[Partidas] CHECK CONSTRAINT [FK_Partidas_Personas1]
GO
ALTER TABLE [dbo].[Partidas]  WITH CHECK ADD  CONSTRAINT [FK_Partidas_Usuarios] FOREIGN KEY([IdUsuario1])
REFERENCES [dbo].[Usuarios] ([idUsuarios])
GO
ALTER TABLE [dbo].[Partidas] CHECK CONSTRAINT [FK_Partidas_Usuarios]
GO
ALTER TABLE [dbo].[Partidas]  WITH CHECK ADD  CONSTRAINT [FK_Partidas_Usuarios1] FOREIGN KEY([idUsuario2])
REFERENCES [dbo].[Usuarios] ([idUsuarios])
GO
ALTER TABLE [dbo].[Partidas] CHECK CONSTRAINT [FK_Partidas_Usuarios1]
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Categoria] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categorias] ([idCategoria])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Personas] CHECK CONSTRAINT [FK_Personas_Categoria]
GO
ALTER TABLE [dbo].[Preguntas]  WITH CHECK ADD  CONSTRAINT [FK_Preguntas_Grupo] FOREIGN KEY([idGrupo])
REFERENCES [dbo].[Grupo] ([idGrupo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Preguntas] CHECK CONSTRAINT [FK_Preguntas_Grupo]
GO
ALTER TABLE [dbo].[Respuestas]  WITH CHECK ADD  CONSTRAINT [FK_PreguntasXPersona_Personas] FOREIGN KEY([idPersona])
REFERENCES [dbo].[Personas] ([idPersona])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Respuestas] CHECK CONSTRAINT [FK_PreguntasXPersona_Personas]
GO
ALTER TABLE [dbo].[Respuestas]  WITH CHECK ADD  CONSTRAINT [FK_PreguntasXPersona_Preguntas] FOREIGN KEY([idPregunta])
REFERENCES [dbo].[Preguntas] ([idPregunta])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Respuestas] CHECK CONSTRAINT [FK_PreguntasXPersona_Preguntas]
GO
USE [master]
GO
ALTER DATABASE [QEQA03] SET  READ_WRITE 
GO
