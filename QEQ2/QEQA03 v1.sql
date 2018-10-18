USE [master]
GO
/****** Object:  Database [QEQA03]    Script Date: 5/10/2018 15:56:37 ******/
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
/****** Object:  User [QEQA03]    Script Date: 5/10/2018 15:56:37 ******/
CREATE USER [QEQA03] FOR LOGIN [QEQA03] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [QEQA03]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 5/10/2018 15:56:37 ******/
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
/****** Object:  Table [dbo].[Grupo]    Script Date: 5/10/2018 15:56:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo](
	[Nombre] [varchar](50) NULL,
	[idGrupo] [int] NOT NULL,
 CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED 
(
	[idGrupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartidosFinalizada]    Script Date: 5/10/2018 15:56:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartidosFinalizada](
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
/****** Object:  Table [dbo].[Personas]    Script Date: 5/10/2018 15:56:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[idPersona] [int] IDENTITY(1,1) NOT NULL,
	[idCategoria] [int] NULL,
	[Nombre] [varchar](50) NULL,
	[Foto] [varbinary](50) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[idPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Preguntas]    Script Date: 5/10/2018 15:56:37 ******/
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
/****** Object:  Table [dbo].[Respuestas]    Script Date: 5/10/2018 15:56:37 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 5/10/2018 15:56:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuarios] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Pass] [varchar](50) NULL,
	[Puntos] [int] NULL,
	[Ip] [int] NULL,
	[Mac] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Mail] [varchar](50) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[idUsuarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Personas] ON 

INSERT [dbo].[Personas] ([idPersona], [idCategoria], [Nombre], [Foto]) VALUES (1, NULL, N'pt', NULL)
SET IDENTITY_INSERT [dbo].[Personas] OFF
SET IDENTITY_INSERT [dbo].[Preguntas] ON 

INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo]) VALUES (1, N'pttttttt', NULL)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo]) VALUES (3, N'truquelmepiti', NULL)
SET IDENTITY_INSERT [dbo].[Preguntas] OFF
SET IDENTITY_INSERT [dbo].[Respuestas] ON 

INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (1, 1, 1)
SET IDENTITY_INSERT [dbo].[Respuestas] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Puntos], [Ip], [Mac], [Nombre], [Mail]) VALUES (44, N'Anush', N'123', 55, NULL, NULL, NULL, NULL)
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Puntos], [Ip], [Mac], [Nombre], [Mail]) VALUES (45, N'Anush', N'123', 55, NULL, NULL, NULL, NULL)
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Puntos], [Ip], [Mac], [Nombre], [Mail]) VALUES (46, N'Anush', N'123', 55, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
ALTER TABLE [dbo].[PartidosFinalizada]  WITH CHECK ADD  CONSTRAINT [FK_PartidosFinalizada_Usuarios1] FOREIGN KEY([idUsuarioGanador])
REFERENCES [dbo].[Usuarios] ([idUsuarios])
GO
ALTER TABLE [dbo].[PartidosFinalizada] CHECK CONSTRAINT [FK_PartidosFinalizada_Usuarios1]
GO
ALTER TABLE [dbo].[PartidosFinalizada]  WITH CHECK ADD  CONSTRAINT [FK_PartidosFinalizada_Usuarios2] FOREIGN KEY([idUsuarioPerdedor])
REFERENCES [dbo].[Usuarios] ([idUsuarios])
GO
ALTER TABLE [dbo].[PartidosFinalizada] CHECK CONSTRAINT [FK_PartidosFinalizada_Usuarios2]
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Categoria] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categorias] ([idCategoria])
GO
ALTER TABLE [dbo].[Personas] CHECK CONSTRAINT [FK_Personas_Categoria]
GO
ALTER TABLE [dbo].[Preguntas]  WITH CHECK ADD  CONSTRAINT [FK_Preguntas_Grupo] FOREIGN KEY([idGrupo])
REFERENCES [dbo].[Grupo] ([idGrupo])
GO
ALTER TABLE [dbo].[Preguntas] CHECK CONSTRAINT [FK_Preguntas_Grupo]
GO
ALTER TABLE [dbo].[Respuestas]  WITH CHECK ADD  CONSTRAINT [FK_PreguntasXPersona_Personas] FOREIGN KEY([idPersona])
REFERENCES [dbo].[Personas] ([idPersona])
GO
ALTER TABLE [dbo].[Respuestas] CHECK CONSTRAINT [FK_PreguntasXPersona_Personas]
GO
ALTER TABLE [dbo].[Respuestas]  WITH CHECK ADD  CONSTRAINT [FK_PreguntasXPersona_Preguntas] FOREIGN KEY([idPregunta])
REFERENCES [dbo].[Preguntas] ([idPregunta])
GO
ALTER TABLE [dbo].[Respuestas] CHECK CONSTRAINT [FK_PreguntasXPersona_Preguntas]
GO
/****** Object:  StoredProcedure [dbo].[spCrearPersonaje]    Script Date: 5/10/2018 15:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearPersonaje]
@Nombre varchar(50),
@Foto varbinary(50),
@Categoria varchar(50)
as
--Se crea un personaje , insertar un nuevo personaje en la tabla con los parametros @nombre, @foto y categoria
--SE DEBE VERIFICAR SI LA CATEGORIA EXISTE, SI NO DEBE DEVOLVER UN ERROR EN FORMA DE BOOL (O BIT) @exito (0 fallido, 1 exitoso)
declare @Exito bit = 0
if((select top 1 idCategoria from Categorias where Categoria = @Categoria)is not null and (select top 1 Nombre from Personas where Nombre = @Nombre) is null)
begin
	insert into Personas(Nombre, idCategoria, Foto) values (@Nombre, @Categoria, @Foto)
	set @exito = 1
end
GO
/****** Object:  StoredProcedure [dbo].[spCrearPregunta]    Script Date: 5/10/2018 15:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spCrearPregunta]
@Texto varchar(50),
@Grupo varchar(50)
as
declare @Exito bit = 0
declare @idGrupo int = (select idGrupo from Grupos where Nombre = @Grupo)
if((select Texto from Preguntas where @Texto = Texto) is null and @idGrupo is not null)
begin
	insert into Preguntas(Texto, idGrupo) values(@Texto, @idGrupo)
	set @exito = 1
end
select @exito
GO
/****** Object:  StoredProcedure [dbo].[spEliminarPersonaje]    Script Date: 5/10/2018 15:56:38 ******/
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
/****** Object:  StoredProcedure [dbo].[spEliminarUsuario]    Script Date: 5/10/2018 15:56:38 ******/
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
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 5/10/2018 15:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spLogin]

@Username varchar(50),
@Password varchar(50)
AS
Declare @Exito bit = 0

    IF ((SELECT Username FROM Usuarios WHERE @Username = Username AND @Password = Pass) = @Username )
    Begin
        Set @Exito = 1
    End    

Select @Exito as Exito



GO
/****** Object:  StoredProcedure [dbo].[spModificarPregunta]    Script Date: 5/10/2018 15:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spModificarPregunta]
@idPregunta int,
@nuevoTexto varchar(50),
@Grupo varchar(50)
as
declare @Exito bit = 0
declare @idGrupo int = (select idGrupo from Grupos where Nombre = @Grupo)
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
/****** Object:  StoredProcedure [dbo].[spRegister]    Script Date: 5/10/2018 15:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRegister]
@Username varchar(50),
@Password varchar(50),
@Nomb varchar(50),
@Mail varchar(75),
@ip varchar(20),
@MAC varchar(50)
as
declare @exito bit = 0
if (@Mail is not null and @Mail != '' and @Nomb is not null and @Nomb != '' and @Username is not null and @Username != '' and @Password is not null and @Password != '' and (select Username from Usuarios where Username = @Username) is null)
begin
if not exists( select Username from Usuarios where Username = @Username )
begin
    insert into Usuarios(Username,Pass) values (@Username,@Password)
    set @exito = 1
	end
end
select @exito

GO
/****** Object:  StoredProcedure [dbo].[spTraerCats]    Script Date: 5/10/2018 15:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerCats] --traer categorias
as
select Categoria from Categorias
GO
/****** Object:  StoredProcedure [dbo].[spTraerPersonajes]    Script Date: 5/10/2018 15:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerPersonajes]
@Categoria varchar(50)
as
--Trae una lista de personajes, parametros : @categoria varchar , si se envia nulo o '' se traera a todos  

declare @Exito bit = 0
if((select Categoria from Categorias where @categoria = Categoria) is not null)
begin
	if(@Categoria !='Todos')
	begin
		select Personas.Foto, Personas.Nombre from Personas inner join Categorias on Personas.idCategoria = Categorias.idCategoria
		where @Categoria = Categorias.Categoria
	end
	else
	begin
		select Personas.Foto, Personas.Nombre from Personas
	end
	set @Exito = 1
end
select @Exito as Exito
GO
/****** Object:  StoredProcedure [dbo].[spTraerPreguntas]    Script Date: 5/10/2018 15:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerPreguntas]
as
select Texto from Preguntas
GO
/****** Object:  StoredProcedure [dbo].[spTraerRespuestas]    Script Date: 5/10/2018 15:56:38 ******/
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
