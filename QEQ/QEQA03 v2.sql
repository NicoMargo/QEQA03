USE [master]
GO
/****** Object:  Database [QEQA03]    Script Date: 18/10/2018 17:32:02 ******/
CREATE DATABASE [QEQA03]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QEQA03', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QEQA03.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QEQA03_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QEQA03_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
ALTER DATABASE [QEQA03] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QEQA03', N'ON'
GO
ALTER DATABASE [QEQA03] SET QUERY_STORE = OFF
GO
USE [QEQA03]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [QEQA03]
GO
/****** Object:  User [QEQA03]    Script Date: 18/10/2018 17:32:02 ******/
CREATE USER [QEQA03] FOR LOGIN [QEQA03] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [QEQA03]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[Grupo]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[Partidas]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partidas](
	[idPartida] [int] IDENTITY(1,1) NOT NULL,
	[PuntosDelGanador] [int] NULL,
	[PuntosDelPerdedor] [int] NULL,
	[idUsuarioGanador] [int] NULL,
	[idUsuarioPerdedor] [int] NULL,
	[DiaYHora] [date] NULL,
 CONSTRAINT [PK_PartidosFinalizada] PRIMARY KEY CLUSTERED 
(
	[idPartida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[idPersona] [int] IDENTITY(1,1) NOT NULL,
	[idCategoria] [int] NULL,
	[Nombre] [varchar](50) NULL,
	[Foto] [varchar](50) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[idPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Preguntas]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Preguntas](
	[idPregunta] [int] IDENTITY(1,1) NOT NULL,
	[Texto] [varchar](50) NULL,
	[idGrupo] [int] NULL,
 CONSTRAINT [PK_Preguntas] PRIMARY KEY CLUSTERED 
(
	[idPregunta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Respuestas]    Script Date: 18/10/2018 17:32:03 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuarios] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Pass] [varchar](50) NULL,
	[Puntos] [int] NULL,
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
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (1, N'MARGO')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (2, N'ZEKY')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (3, N'LIU')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (4, N'SHIVO')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (5, N'AAAA')
SET IDENTITY_INSERT [dbo].[Categorias] OFF
SET IDENTITY_INSERT [dbo].[Grupo] ON 

INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'QEQ', 1)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'CGS', 2)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'LOS MAS CAPOS', 3)
SET IDENTITY_INSERT [dbo].[Grupo] OFF
SET IDENTITY_INSERT [dbo].[Personas] ON 

INSERT [dbo].[Personas] ([idPersona], [idCategoria], [Nombre], [Foto]) VALUES (1, 1, N'Eze', NULL)
INSERT [dbo].[Personas] ([idPersona], [idCategoria], [Nombre], [Foto]) VALUES (2, 2, N'Jhony', NULL)
INSERT [dbo].[Personas] ([idPersona], [idCategoria], [Nombre], [Foto]) VALUES (3, 3, N'Margo', NULL)
SET IDENTITY_INSERT [dbo].[Personas] OFF
SET IDENTITY_INSERT [dbo].[Preguntas] ON 

INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo]) VALUES (1, N'HOLA COMO ESTAS', 1)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo]) VALUES (3, N'MI NOMBRE ES ZEKY', 1)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo]) VALUES (4, N'CGS', 2)
SET IDENTITY_INSERT [dbo].[Preguntas] OFF
SET IDENTITY_INSERT [dbo].[Respuestas] ON 

INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (1, 1, 1)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (4, 1, 1)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (5, 1, 1)
SET IDENTITY_INSERT [dbo].[Respuestas] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Puntos], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (4, N'Anush', N'@w4‰Q%5—CJò’gú', 0, N'168.158.25.65', N'Nicolas', N'nicolasmargossian@gmail.com', 0, N'192.168.1.113')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Puntos], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (6, N'Administrador', N'@w4‰Q%5—CJò’gú', 0, N'1.1.1.1', N'Administrador', N'Admin@admin.com', 1, N'1.1.1.1')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Puntos], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (7, N'Chino', N' ,¹b¬Y[–K-#Kp', 0, N'1.1.1.1', N'Administrador', N'Admin@admin.com', 1, N'1.1.1.1')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
ALTER TABLE [dbo].[Partidas]  WITH CHECK ADD  CONSTRAINT [FK_PartidosFinalizada_Usuarios1] FOREIGN KEY([idUsuarioGanador])
REFERENCES [dbo].[Usuarios] ([idUsuarios])
GO
ALTER TABLE [dbo].[Partidas] CHECK CONSTRAINT [FK_PartidosFinalizada_Usuarios1]
GO
ALTER TABLE [dbo].[Partidas]  WITH CHECK ADD  CONSTRAINT [FK_PartidosFinalizada_Usuarios2] FOREIGN KEY([idUsuarioPerdedor])
REFERENCES [dbo].[Usuarios] ([idUsuarios])
GO
ALTER TABLE [dbo].[Partidas] CHECK CONSTRAINT [FK_PartidosFinalizada_Usuarios2]
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
/****** Object:  StoredProcedure [dbo].[spCargarRespuestas]    Script Date: 18/10/2018 17:32:03 ******/
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
/****** Object:  StoredProcedure [dbo].[spCrearCat]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spCrearCat]
@Nombre varchar(50)
as
declare @msg varchar(100) = ''
if exists(select Categoria from Categorias where Categoria=@Nombre)
SET @msg = 'Ya hay una categoria con ese nombre'
else
insert into Categorias(Categoria) values(@Nombre)

select @msg
	
GO
/****** Object:  StoredProcedure [dbo].[spCrearGrupo]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spCrearGrupo]
@Nombre varchar(50)
as
declare @msg varchar(100) = ''
if exists(select Nombre from Grupo where Nombre=@Nombre)
SET @msg = 'Ya hay un grupo de preguntas con ese nombre'
else
insert into Grupo(Nombre) values(@Nombre)

select @msg
	
GO
/****** Object:  StoredProcedure [dbo].[spCrearPersonaje]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearPersonaje]
@Nombre varchar(50),
@Foto varchar(50),
@Categoria varchar(50)
as
--Se crea un personaje , insertar un nuevo personaje en la tabla con los parametros @nombre, @foto y categoria
--SE DEBE VERIFICAR SI LA CATEGORIA EXISTE, SI NO DEBE DEVOLVER UN ERROR EN FORMA DE BOOL (O BIT) @exito (0 fallido, 1 exitoso)
--select ‘PR3498’, ‘Campos’,’Pardo’,’Luis’,’15/01/1997′, ‘A’, * from OpenRowset(Bulk ‘D:\EmpleadosFotos\CamposPardoLuis.jpg’, Single_Blob) As EmpleadosFoto
--SELECT 1, 'Norman', BulkColumn  FROM Openrowset( Bulk 'C:\ImagenFichero.bmp', Single_Blob) as Imagen
declare @Exito bit = 0
if((select top 1 idCategoria from Categorias where Categoria = @Categoria)is not null and (select top 1 Nombre from Personas where Nombre = @Nombre) is null)
begin
	insert into Personas(Nombre, idCategoria, Foto) values (@Nombre, @Categoria, @Foto)
	set @exito = 1
end
--//LISTO
GO
/****** Object:  StoredProcedure [dbo].[spCrearPregunta]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearPregunta]
@Texto varchar(50),
@Grupo varchar(50)
as
declare @Exito bit = 0
declare @idGrupo int = (select idGrupo from Grupo where Nombre = @Grupo)
if((select Texto from Preguntas where @Texto = Texto) is null and @idGrupo is not null)
begin
	insert into Preguntas(Texto, idGrupo) values(@Texto, @idGrupo)
	set @exito = 1
end
select @exito
GO
/****** Object:  StoredProcedure [dbo].[spEliminarCat]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spEliminarCat]
@Cat varchar(50)
as
declare @msg varchar = ''
if exists(select * from Categorias where Categoria=@Cat)
begin
	delete from Categorias 
	where Categoria = @Cat
end
else
set @msg = 'No se encontro la categoria'

select @msg
GO
/****** Object:  StoredProcedure [dbo].[spEliminarGrupo]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spEliminarGrupo]
@Grupo varchar(50)
as
declare @msg varchar = ''
if exists(select * from Grupo where Nombre=@Grupo)
begin
	delete from Grupo 
	where Nombre = @Grupo
end
else
set @msg = 'No se encontro el @Grupo'

select @msg
GO
/****** Object:  StoredProcedure [dbo].[spEliminarPersonaje]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarPersonaje]
@Nombre varchar(50)
as
declare @Exito bit = 0
declare @idPer int = (select top 1 idPersona from Personas where Nombre = @Nombre)
if(@idPer is null)
begin
	delete from Respuestas where idPersona = @idPer
	delete from Usuarios where Nombre = @Nombre 
	set @Exito = 1
end
select @Exito
GO
/****** Object:  StoredProcedure [dbo].[spEliminarUsuario]    Script Date: 18/10/2018 17:32:03 ******/
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
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spLogin]

@Username varchar(50),
@Password varchar(50)
AS
Declare @msg varchar(50) = '', @Pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@Password))

if  Exists(select Username from Usuarios where Username = @Username and Pass = @pass)
Begin
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
/****** Object:  StoredProcedure [dbo].[spModificarCategoria]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spModificarCategoria]
@newCategoria varchar(50),
@Categoria varchar(50)
as
declare @msg varchar(100)= ''
if exists(select top 1 idCategoria from Categorias where @Categoria=Categoria)
begin
	if exists(select top 1 idCategoria from Categorias where @newCategoria=Categoria)
	set @msg = 'ya hay una categoria con ese nuevo nombre'
	else
	update Categorias set Categoria = @newCategoria where @Categoria = Categoria
end
else
set @msg = 'Categoria no Encontrada'

select @msg
GO
/****** Object:  StoredProcedure [dbo].[spModificarGrupo]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spModificarGrupo]
@newGrupo varchar(50),
@Grupo varchar(50)
as
declare @msg varchar(100)= ''
if exists(select top 1 idGrupo from Grupo where @Grupo=Nombre)
begin
	if exists(select top 1 idGrupo from Grupo where @newGrupo=Nombre)
	set @msg = 'ya hay una categoria con ese nuevo nombre'
	else
	update Grupo set Nombre = @newGrupo where @Grupo = Nombre
end
else
set @msg = 'Categoria no Encontrada'

select @msg
GO
/****** Object:  StoredProcedure [dbo].[spModificarPersonaje]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spModificarPersonaje]
@Nombre int,
@nuevoNombre varchar(50),
@Foto varbinary(50),
@Categoria varchar(50)
as
declare @msg varchar(100)= ''
if exists(select * from Personas where @Nombre=Nombre)
begin
	delete from Respuestas where idPersona = (select idPersona from Personas where @Nombre=Nombre)
	if(@nuevoNombre is not null and @nuevoNombre !='')
	begin
		if exists(select * from Personas where @Nombre=Nombre)
		set @msg = 'Error en los datos modificados, modificacion fallida'
		else
		update Personas set Nombre = @nuevoNombre where @Nombre = Nombre
	end
	if(@Categoria is not null and @Categoria !='')
	begin
		if exists(select * from Categorias where @Categoria=Categoria)
		update Personas set Nombre = @nuevoNombre where @Nombre = Nombre
		else
		set @msg = 'Error en los datos modificados, modificacion fallida'
	end
	if(@Foto is not null)
	update Personas set Foto = @Foto where @Foto = Foto
end
else
set @msg = 'La id no Corresponde a ningun personaje'

select @msg
GO
/****** Object:  StoredProcedure [dbo].[spModificarPregunta]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spModificarPregunta]
@idPregunta int,
@nuevoTexto varchar(50),
@Grupo varchar(50)
as
declare @Exito bit = 0
declare @idGrupo int = (select idGrupo from Grupo where Nombre = @Grupo)
if exists(select Texto from Preguntas where idPregunta = @idPregunta) 
begin
	if (@idGrupo is not null)
	begin
		update Preguntas set Texto = @nuevoTexto where idPregunta = @idPregunta
		update Preguntas set idGrupo = @idGrupo where idPregunta = @idPregunta
		set @Exito = 1

	end
	else
	begin
		if(@Grupo is null or @Grupo = '')
		begin
		update Preguntas set Texto = @nuevoTexto where idPregunta = @idPregunta
		set @Exito = 1
		end
	end
end
select @Exito
GO
/****** Object:  StoredProcedure [dbo].[spModificarUsuario]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spModificarUsuario]
@Username varchar(50),
@nuevoUsername varchar(50),
@Pass varchar(50),
@NuevaPass varchar(50),
@Puntos int,
@Nombre varchar(50),
@nuevoNombre varchar(50),
@Mail varchar(50),
@nuevoMail varchar(50),
@Administrador bit,
@mac varchar(50),
@nuevomac varchar(50),
@Ip varchar(50),
@nuevoIp varchar(50)
as
declare @msg varchar(100)= ''
if exists(select * from Usuarios where @Nombre=Nombre)
begin
	
	if(@nuevoNombre is not null and @nuevoNombre !='')
	begin
		if exists(select * from Usuarios where @Nombre=Nombre)
		begin
		set @msg = 'Error en los datos modificados, modificacion fallida'
		end
		else
		begin
		update Usuarios set Nombre = @nuevoNombre where @Nombre = Nombre
	end
	end
	end
	if exists(select * from Usuarios where @Username=Username)
begin
	
	if(@nuevoUsername is not null and @nuevoUsername !='')
	begin
		if exists(select * from Usuarios where @Username=Username)
		begin
		set @msg = 'Error en los datos modificados, modificacion fallida'
		end
		else
		begin
		update Usuarios set Username = @nuevoUsername where @Username = Username
	end
	end
	end
		if exists(select * from Usuarios where @Pass=Pass)
begin
	
	if(@NuevaPass is not null and @NuevaPass !='')
	begin
		if exists(select * from Usuarios where @Pass=Pass)
		begin
		set @msg = 'Error en los datos modificados, modificacion fallida'
		end
		else
		begin
		update Usuarios set Pass = @NuevaPass where @Pass = Username
	end
	end
	end
		if(@Puntos is not null)
		begin
	update Usuarios set Puntos = @Puntos where @Puntos = Puntos
	end
		else
		begin
		set @msg = 'Error en los datos modificados, modificacion fallida'
	end
	if exists(select * from Usuarios where @Mail=Mail)
begin
	
	if(@nuevoMail is not null and @nuevoMail !='')
	begin
		if exists(select * from Usuarios where @Mail=Mail)
		begin
		set @msg = 'Error en los datos modificados, modificacion fallida'
		end
		else
		begin
		update Usuarios set Mail = @nuevoMail where @Mail = Nombre
	end
	end
	end
		if exists(select * from Usuarios where @mac=Mail)
begin
	
	if(@nuevomac is not null and @nuevomac !='')
	begin
		if exists(select * from Usuarios where @mac=mac)
		begin
		set @msg = 'Error en los datos modificados, modificacion fallida'
		end
		else
		begin
		update Usuarios set mac = @nuevomac where @mac = mac
	end
	end
	end
		if exists(select * from Usuarios where @Ip=Ip1)
begin
	
	if(@nuevoIp is not null and @nuevoIp !='')
	begin
		if exists(select * from Usuarios where @Ip=Mail)
		begin
		set @msg = 'Error en los datos modificados, modificacion fallida'
		end
		else
		begin
		update Usuarios set Ip1 = @nuevoIp where @Ip = Ip1
	end
	end
	end
	else
	begin
set @msg = 'La id no Corresponde a ningun personaje'
end
select @msg
GO
/****** Object:  StoredProcedure [dbo].[spRegister]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRegister]
@Username varchar(50),
@Password varchar(50),
@Nomb varchar(50),
@Mail varchar(75),
@Mac varchar(20),
@Ip varchar(50),
@Admin bit
as
declare @exito bit = 0, @pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@Password))
if (@Mail is not null and @Mail != '' and @Nomb is not null and @Nomb != '' and @Username is not null and @Username != '' and @Password is not null and @Password != '' )
begin
if not exists(select Username from Usuarios where Username = @Username)
begin
    insert into Usuarios(Username,Pass,Nombre,Administrador,mac,Ip1,Mail) values (@Username,@pass,@Nomb,@Admin,@Mac,@Ip,@Mail)
    set @exito = 1
	end
end
select @exito as exito

GO
/****** Object:  StoredProcedure [dbo].[spTraerCats]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerCats] --traer categorias
as
select Categoria from Categorias
GO
/****** Object:  StoredProcedure [dbo].[spTraerGrupos]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spTraerGrupos]
as
select Nombre from Grupo
GO
/****** Object:  StoredProcedure [dbo].[spTraerPersonajes]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerPersonajes]
@Categoria varchar(50)
as
--Trae una lista de personajes, parametros : @categoria varchar , si se envia nulo o '' se traera a todos  

declare @Exito bit = 0
if((select Categoria from Categorias where @categoria = Categoria) is not null or @Categoria='Todos')
begin
	if(@Categoria !='Todos')
	begin
		select Personas.idPersona,Personas.Foto, Personas.Nombre, Categorias.Categoria from Personas inner join Categorias on Personas.idCategoria = Categorias.idCategoria
		where @Categoria = Categorias.Categoria
	end
	else
	begin
		select Personas.idPersona,Personas.Foto, Personas.Nombre, Categorias.Categoria from Personas inner join Categorias on Personas.idCategoria = Categorias.idCategoria
	end
	set @Exito = 1
end
GO
/****** Object:  StoredProcedure [dbo].[spTraerPreguntas]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerPreguntas]
as
select Preguntas.idPregunta as idPregunta,Preguntas.Texto as Texto ,Grupo.Nombre as Nombre from Preguntas
inner Join Grupo on Preguntas.IdGrupo = Grupo.idGrupo
GO
/****** Object:  StoredProcedure [dbo].[spTraerRespuestas]    Script Date: 18/10/2018 17:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerRespuestas]
@Categ varchar(50)
as
declare @Exito bit = 0
if((select Categoria from Categorias where @categ = Categoria) is not null)
begin
	if(@Categ !='Todos')
	begin
		select * from Respuestas inner join Personas on Personas.idPersona = Respuestas.idPersona
		inner join Categorias on Categorias.idCategoria = Personas.idCategoria
		where @Categ = Categorias.Categoria
	end
	else
	begin
		select * from Respuestas
	end
	set @Exito = 1
end
select @Exito as Exito
GO
USE [master]
GO
ALTER DATABASE [QEQA03] SET  READ_WRITE 
GO
