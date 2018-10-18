USE [master]
GO
/****** Object:  Database [QEQ]    Script Date: 28/9/2018 15:59:11 ******/
CREATE DATABASE [QEQ]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QEQ', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QEQ.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QEQ_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QEQ_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [QEQ] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QEQ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QEQ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QEQ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QEQ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QEQ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QEQ] SET ARITHABORT OFF 
GO
ALTER DATABASE [QEQ] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QEQ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QEQ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QEQ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QEQ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QEQ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QEQ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QEQ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QEQ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QEQ] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QEQ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QEQ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QEQ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QEQ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QEQ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QEQ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QEQ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QEQ] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QEQ] SET  MULTI_USER 
GO
ALTER DATABASE [QEQ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QEQ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QEQ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QEQ] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QEQ] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QEQ', N'ON'
GO
ALTER DATABASE [QEQ] SET QUERY_STORE = OFF
GO
USE [QEQ]
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
USE [QEQ]
GO
/****** Object:  User [alumno]    Script Date: 28/9/2018 15:59:11 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 28/9/2018 15:59:11 ******/
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
/****** Object:  Table [dbo].[Grupo]    Script Date: 28/9/2018 15:59:11 ******/
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
/****** Object:  Table [dbo].[PartidosFinalizada]    Script Date: 28/9/2018 15:59:11 ******/
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
 CONSTRAINT [PK_PartidosFinalizada] PRIMARY KEY CLUSTERED 
(
	[idPartida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 28/9/2018 15:59:11 ******/
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
/****** Object:  Table [dbo].[Preguntas]    Script Date: 28/9/2018 15:59:11 ******/
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
/****** Object:  Table [dbo].[Respuestas]    Script Date: 28/9/2018 15:59:11 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 28/9/2018 15:59:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuarios] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Pass] [varchar](50) NULL,
	[Puntos] [int] NULL,
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
/****** Object:  StoredProcedure [dbo].[spCrearPersonaje]    Script Date: 28/9/2018 15:59:12 ******/
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
/****** Object:  StoredProcedure [dbo].[spCrearRespuestas]    Script Date: 28/9/2018 15:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spCrearRespuestas]
@Nombre varchar(50),
@TextoPregunta int,
@Correcto bit
as

declare @Exito bit = 0
declare @idPersona int = (select idPersona from Personas where Nombre = @Nombre)
declare @idPregunta int = (select idPregunta from Preguntas where Texto = @TextoPregunta)
if(@idPersona is not null and @idPersona !='' and  @idPregunta is not null and @idPregunta !='' and @Correcto is not null)
begin
	insert into Respuestas(idPersona,idPregunta,Verdadero)  
	values (@idPersona,@idPregunta,@Correcto) 
	set @Exito = 1
end
select @Exito as Exito
GO
/****** Object:  StoredProcedure [dbo].[spEliminarUsuario]    Script Date: 28/9/2018 15:59:12 ******/
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
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 28/9/2018 15:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spLogin]

@Username varchar(50),
@Password varchar(50)
AS
Declare @Exito bit = 0
IF (@Username ! = '' and @Username is not null AND @Password != '' and @Password is not null )
BEGIN
    IF ((SELECT Username FROM Usuarios WHERE @Username = Username AND @Password = Pass) = @Username )
    Begin
        Set @Exito = 1
    End    
END
if(@exito = 1)
Begin
    Select Puntuaciones.Puntuacion from Puntuaciones inner join Usuarios on Usuarios.idUsuarios = Puntuaciones.idUsuario
	where Username = @Username
End
Select @Exito as Exito



GO
/****** Object:  StoredProcedure [dbo].[spRegister]    Script Date: 28/9/2018 15:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRegister]
@Username varchar(50),
@Password varchar(50)
as
declare @exito bit = 0
if((select top 1 Username from Usuarios where Username = @Username) is null)
begin
    insert into Usuarios(Username,Pass) values (@Username,@Password)
    set @exito = 1
end
select @exito

GO
/****** Object:  StoredProcedure [dbo].[spTraerCats]    Script Date: 28/9/2018 15:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerCats] --traer categorias
as
select Categoria from Categorias
GO
/****** Object:  StoredProcedure [dbo].[spTraerPersonajes]    Script Date: 28/9/2018 15:59:12 ******/
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
/****** Object:  StoredProcedure [dbo].[spTraerPreguntas]    Script Date: 28/9/2018 15:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerPreguntas]
as
select Texto from Preguntas
GO
/****** Object:  StoredProcedure [dbo].[spTraerRespuestas]    Script Date: 28/9/2018 15:59:12 ******/
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
ALTER DATABASE [QEQ] SET  READ_WRITE 
GO
