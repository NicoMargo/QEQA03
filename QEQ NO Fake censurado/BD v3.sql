USE [master]
GO
/****** Object:  Database [QEQA03]    Script Date: 22/11/2018 10:32:34 ******/
CREATE DATABASE [QEQA03]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QEQA03', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QEQA03.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QEQA03_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QEQA03_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  User [QEQA03]    Script Date: 22/11/2018 10:32:34 ******/
CREATE USER [QEQA03] FOR LOGIN [QEQA03] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [QEQA03]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 22/11/2018 10:32:34 ******/
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
/****** Object:  Table [dbo].[Grupo]    Script Date: 22/11/2018 10:32:35 ******/
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
/****** Object:  Table [dbo].[Partidas]    Script Date: 22/11/2018 10:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[idCategoria] [int] NULL,
 CONSTRAINT [PK_PartidosFinalizada] PRIMARY KEY CLUSTERED 
(
	[idPartida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 22/11/2018 10:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[Preguntas]    Script Date: 22/11/2018 10:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[Respuestas]    Script Date: 22/11/2018 10:32:35 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 22/11/2018 10:32:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (5, N'Dragon Ball Z')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (6, N'Naruto')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (11, N'Bizarro')
INSERT [dbo].[Categorias] ([idCategoria], [Categoria]) VALUES (12, N'Todos')
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
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'tiene protector frontal', 12)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Sombreros', 13)
INSERT [dbo].[Grupo] ([Nombre], [idGrupo]) VALUES (N'Barba (tiene o no tiene)', 14)
SET IDENTITY_INSERT [dbo].[Grupo] OFF
SET IDENTITY_INSERT [dbo].[Partidas] ON 

INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (2, 0, NULL, 9500, N'', NULL, 1, 0, 1, CAST(N'2018-11-22' AS Date), 5, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (3, 0, NULL, 10000, N'', NULL, 0, 0, 1, CAST(N'2018-11-22' AS Date), 5, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (4, 0, NULL, 9000, N'', NULL, 2, 0, 1, CAST(N'2018-11-22' AS Date), 5, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (5, 0, NULL, 9500, N'', NULL, 1, 0, 1, CAST(N'2018-11-22' AS Date), 7, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (6, 0, NULL, 7000, N'', NULL, 6, 0, 1, CAST(N'2018-11-22' AS Date), 8, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (7, 0, NULL, 9000, N'', NULL, 0, 0, 1, CAST(N'2018-11-22' AS Date), 8, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (8, 0, NULL, 10000, N'', NULL, 0, 0, 1, CAST(N'2018-11-22' AS Date), 5, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (9, 0, NULL, 10000, N'', NULL, 0, 0, 1, CAST(N'2018-11-22' AS Date), 5, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (10, 0, NULL, 2500, N'', NULL, 0, 0, 1, CAST(N'2018-11-22' AS Date), 5, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (11, 0, NULL, NULL, N'0', NULL, 0, 1, NULL, NULL, NULL, NULL, 5)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (12, 0, NULL, 2000, N'', NULL, 16, 0, 1, CAST(N'2018-11-22' AS Date), 5, NULL, NULL)
INSERT [dbo].[Partidas] ([idPartida], [IdUsuario1], [idUsuario2], [Puntos], [Ip1], [Ip2], [Preguntas], [Multijugador], [Ganador], [Fecha], [idPer1], [idPer2], [idCategoria]) VALUES (13, 0, NULL, 2000, N'', NULL, 16, 0, 1, CAST(N'2018-11-22' AS Date), 5, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Partidas] OFF

SET IDENTITY_INSERT [dbo].[Preguntas] ON 
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (1, N'Tiene El Pelo Largo (supera los hombros)', 6, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (2, N'Tiene el pelo medianamente largo (hasta los hombros)', 6, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (3, N'Tiene ojos rojos', 2, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (4, N'Tiene el Pelo muy largo(tipo Ssj3, Raditz o Madara)', 6, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (5, N'Tiene ojos azules', 2, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (6, N'Tiene ojos verdes', 2, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (7, N'Tiene ojos marrones', 2, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (8, N'Tiene Ojos negros', 2, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (9, N'Tiene Pelo Rubio', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (10, N'Tiene Pelo Cafe', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (11, N'Tiene Pelo Rojo', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (12, N'Tiene Pelo Negro', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (13, N'Tiene pelo Rosa', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (14, N'Tiene pelo verde', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (15, N'Tiene el pelo rapado', 6, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (16, N'No tiene Pelo', 6, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (17, N'Tiene el pelo medianamente corto (supera las orejas)', 6, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (18, N'Tiene el Pelo Corto (no supera las orejas)', 6, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (19, N'Tiene el pelo blanco', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (20, N'Tiene el pelo Gris', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (21, N'Tiene el pelo Naranja', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (22, N'Tiene un rastreador', 1, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (23, N'Tiene anteojos', 1, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (24, N'Tiene Sombrero', 13, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (25, N'Tiene Bigote Largo(tipo Draven)', 7, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (26, N'Tiene Bigote normal', 7, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (28, N'Tiene Bigote corto ', 7, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (29, N'Tiene Barba Larga', 8, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (30, N'Tiene Barba corta', 8, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (31, N'Tiene Barba afeitada', 8, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (33, N'Tiene Barba', 14, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (34, N'Tiene piel de color negro', 9, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (35, N' Tiene piel de color amarillo', 9, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (36, N'Tiene piel de color salmonido', 9, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (37, N'Tiene piel de color blanco palido', 9, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (38, N'Tiene piel de color moreno', 9, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (39, N'Tiene piel color verde', 9, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (40, N'Tiene color de piel rosa', 9, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (41, N'Tiene el pelo color azul', 5, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (42, N'Tiene color de piel celeste', 9, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (43, N'tiene nariz larga', 10, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (44, N'Tiene nariz corta', 10, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (46, N'es mujer', 11, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (47, N'es hombre', 11, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (48, N'genero desconocido', 11, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (49, N'sin genero', 11, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (50, N'Trapo comun', 11, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (51, N'Trapo ^-1', 11, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (52, N'Tiene Ojos Rosa', 2, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (53, N'si', 12, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (54, N'tiene ojos violetas', 2, 500)
INSERT [dbo].[Preguntas] ([idPregunta], [Texto], [idGrupo], [Puntos]) VALUES (55, N'tiene ojos blanco', 2, 500)
SET IDENTITY_INSERT [dbo].[Preguntas] OFF
SET IDENTITY_INSERT [dbo].[Respuestas] ON 

INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (1, 7, 22)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (2, 7, 5)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (3, 7, 14)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (4, 7, 2)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (5, 7, 37)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (6, 7, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (7, 7, 46)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (8, 8, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (9, 8, 40)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (10, 8, 49)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (11, 9, 52)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (12, 9, 39)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (13, 9, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (14, 9, 49)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (21, 5, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (22, 5, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (23, 5, 18)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (24, 5, 37)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (25, 5, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (26, 5, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (60, 10, 5)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (61, 10, 9)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (62, 10, 18)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (63, 10, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (64, 10, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (65, 10, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (66, 10, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (67, 11, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (68, 11, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (69, 11, 17)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (70, 11, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (71, 11, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (72, 11, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (73, 12, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (74, 12, 20)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (75, 12, 2)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (76, 12, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (77, 12, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (78, 12, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (79, 12, 46)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (80, 12, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (81, 13, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (82, 13, 19)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (83, 13, 4)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (84, 13, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (85, 13, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (86, 13, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (87, 13, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (88, 13, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (89, 14, 6)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (90, 14, 13)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (91, 14, 2)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (92, 14, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (93, 14, 43)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (94, 14, 46)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (95, 15, 7)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (96, 15, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (97, 15, 2)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (98, 15, 30)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (99, 15, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (100, 15, 43)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (101, 15, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (102, 15, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (103, 15, 33)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (104, 16, 5)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (105, 16, 9)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (106, 16, 1)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (107, 16, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (108, 16, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (109, 16, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (110, 16, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (111, 16, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (112, 17, 6)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (113, 17, 11)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (114, 17, 2)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (115, 17, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (116, 17, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (117, 17, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (125, 19, 3)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (126, 19, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (127, 19, 1)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (128, 19, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (129, 19, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (130, 19, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (131, 19, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (132, 19, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (133, 20, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (134, 20, 41)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (135, 20, 18)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (136, 20, 42)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (137, 20, 43)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (138, 20, 48)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (139, 20, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (140, 21, 3)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (141, 21, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (142, 21, 4)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (143, 21, 37)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (144, 21, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (145, 21, 46)
GO
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (146, 21, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (147, 22, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (148, 22, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (149, 22, 17)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (150, 22, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (151, 22, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (152, 22, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (160, 24, 5)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (161, 24, 9)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (162, 24, 2)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (163, 24, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (164, 24, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (165, 24, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (166, 24, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (167, 24, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (176, 23, 54)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (177, 23, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (178, 23, 4)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (179, 23, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (180, 23, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (181, 23, 43)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (182, 23, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (183, 25, 54)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (184, 25, 11)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (185, 25, 17)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (186, 25, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (187, 25, 37)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (188, 25, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (189, 25, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (190, 25, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (191, 18, 55)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (192, 18, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (193, 18, 4)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (194, 18, 37)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (195, 18, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (196, 18, 46)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (197, 18, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (198, 26, 55)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (199, 26, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (200, 26, 1)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (201, 26, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (202, 26, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (203, 26, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (204, 26, 53)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (205, 27, 3)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (206, 27, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (207, 27, 17)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (208, 27, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (209, 27, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (210, 27, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (211, 27, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (212, 28, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (213, 28, 9)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (214, 28, 17)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (215, 28, 25)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (216, 28, 29)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (217, 28, 38)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (218, 28, 43)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (219, 28, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (220, 28, 33)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (221, 29, 7)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (222, 29, 12)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (223, 29, 1)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (224, 29, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (225, 29, 44)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (226, 29, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (227, 30, 54)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (228, 30, 10)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (229, 30, 17)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (230, 30, 31)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (231, 30, 37)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (232, 30, 43)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (233, 30, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (234, 31, 8)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (235, 31, 19)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (236, 31, 18)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (237, 31, 25)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (238, 31, 36)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (239, 31, 43)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (240, 31, 47)
INSERT [dbo].[Respuestas] ([idRespuestas], [idPersona], [idPregunta]) VALUES (241, 31, 24)
SET IDENTITY_INSERT [dbo].[Respuestas] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (0, N'Guest', NULL, N'Unknown', N'Invitado', NULL, 0, N'Unknown')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (1, N'Administrador', N'ýP$¬
ð2Ví”T´èˆ', N'fe80::a46f:b8f7:e889:b57b%16', N'Administrador', N'Admin@admin.com', 1, N'fe80::a46f:b8f7:e889')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (2, N'Anush', N'S·lÃDDõ°š
347ã-', N'fe80::b401:56aa:4f8c:4d97%13', N'Nico', N'Nico@gmail.com', 1, N'fe80::b401:56aa:4f8c')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (3, N'Chino', N'ýP$¬
ð2Ví”T´èˆ', N'10.152.2.36', N'Chino', N'chino@gmail.com', 1, N'fe80::8d09:9161:6ff9:5cbc%5')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (4, N'casa', N'ýP$¬
ð2Ví”T´èˆ', N'fe80::ac12:eb80:d7c3:970a%5', N'casa', N'casa', 1, N'fe80::ac12:eb80:d7c3')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (5, N'ZekyDios', N'¬v—¢$ Ù³L«¾ñNl', N'fe80::8195:70a5:8303:439f%14', N'zeky2002', N'zekykemeny@gmail.com', 1, N'fe80::8195:70a5:8303')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (6, N'Jon', N'ÄŸÇÞ>ïAlÀäÚ½', N'fe80::b401:56aa:4f8c:4d97%13', N'jon', N'jongibaut@hotmail.com', 0, N'fe80::b401:56aa:4f8c')
INSERT [dbo].[Usuarios] ([idUsuarios], [Username], [Pass], [Ip1], [Nombre], [Mail], [Administrador], [mac]) VALUES (7, N'hola', N'ýP$¬
ð2Ví”T´èˆ', N'fe80::a94e:a3a1:7e:f584%16', N'hola', N'hola', 1, N'fe80::a94e:a3a1:7e:f584%16')
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
/****** Object:  StoredProcedure [dbo].[spBuscarPartidas]    Script Date: 22/11/2018 10:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spBuscarPartidas] 
as
select IdPartida, IdUsuario1, Ip1, idCategoria from Partidas where Multijugador = 1 and IdUsuario2 is null AND Ganador is null




GO
/****** Object:  StoredProcedure [dbo].[spCargarRespuestas]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spCrearCat]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spCrearGrupo]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spCrearPartida]    Script Date: 22/11/2018 10:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[spCrearPartida] 
 @IdUsuarioHost int,
 @IpHost varchar(100),
 @idCat int

as
if((select top 1 idCategoria from Categorias where idCategoria=@idCat )is not null or @idcat=0)
if exists(select * from Usuarios where idUsuarios= @IdUsuarioHost)
begin
	insert into Partidas(IdUsuario1,Ip1,Multijugador,idCategoria,Preguntas) values(@IdUsuarioHost,@IpHost,1,@idCat,0)
end




GO
/****** Object:  StoredProcedure [dbo].[spCrearPersonaje]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spCrearPregunta]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spDatosPartida]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spEliminarCat]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spEliminarGrupo]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spEliminarPersonaje]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spEliminarPregunta]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spEliminarUsuario]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spFinalizarPartida]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spGuardarPartida]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spGuardarPartida1]    Script Date: 22/11/2018 10:32:45 ******/
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
@idPersonaje int,
@Puntos int
as
if exists (select top 1 Nombre from Usuarios where idUsuarios=@Usuario)
begin
	insert into Partidas(idUsuario1,ip1,Fecha,Preguntas,Multijugador,Ganador,idPer1,Puntos) values(@Usuario,@ip,@fecha,@cantPregunta,0,@Ganador,@idPersonaje,@Puntos)
end
else if(@Usuario =0) insert into Partidas(idUsuario1,ip1,Fecha,Preguntas,Multijugador,Ganador,idPer1,Puntos) values(@Usuario,@ip,@fecha,@cantPregunta,0,@Ganador,@idPersonaje,@Puntos)
GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spModificarCategoria]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spModificarGrupo]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spModificarPersonaje]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spModificarPregunta]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spModificarUsuario]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spOlvidoPass]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spPasarTurno]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spRanking]    Script Date: 22/11/2018 10:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRanking]
AS
select idPartida,idUsuario1,idPer1,Puntos,Preguntas,Ganador,Fecha From Partidas where Multijugador = 0 order by puntos desc 
GO
/****** Object:  StoredProcedure [dbo].[spRegister]    Script Date: 22/11/2018 10:32:45 ******/
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
    insert into Usuarios(Username,Pass,Nombre,Administrador,Mail,mac,Ip1) values (@Username,@pass,@Nomb,@Admin,@Mail,@Ip1, @Mac)
    set @exito = 1
	end
end
select @exito as exito




GO
/****** Object:  StoredProcedure [dbo].[spTraerCats]    Script Date: 22/11/2018 10:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerCats] --traer categorias
as
select idCategoria, Categoria from Categorias




GO
/****** Object:  StoredProcedure [dbo].[spTraerGrupos]    Script Date: 22/11/2018 10:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerGrupos]
as
select idGrupo, Nombre from Grupo




GO
/****** Object:  StoredProcedure [dbo].[spTraerPersonajes]    Script Date: 22/11/2018 10:32:45 ******/
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
	if ((Select Categoria from Categorias where @idCategoria = idCategoria) = 'Todos')
	select idPersona,Foto, Nombre, idCategoria from Personas 
	else	
	Begin
	if(@idCategoria != 0)
	begin
		select idPersona,Foto, Nombre, idCategoria from Personas 
		where @idCategoria = idCategoria
	end
	else	
		select idPersona,Foto, Nombre, idCategoria from Personas 
	End
End
	
	
	

GO
/****** Object:  StoredProcedure [dbo].[spTraerPreguntas]    Script Date: 22/11/2018 10:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerPreguntas]
as
select idPregunta, Texto , idGrupo, Puntos from Preguntas




GO
/****** Object:  StoredProcedure [dbo].[spTraerRespuestas]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spTraerRxP]    Script Date: 22/11/2018 10:32:45 ******/
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
/****** Object:  StoredProcedure [dbo].[spTraerUsuarios]    Script Date: 22/11/2018 10:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerUsuarios]
as
select * from Usuarios
GO
/****** Object:  StoredProcedure [dbo].[spUnirse]    Script Date: 22/11/2018 10:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spUnirse]
@IdPartida int,
@IdUsuario2 int,
@Ip2 varchar
as
declare @exito bit = 0
if exists(select * from Partidas where IdPartida = @IdPartida and Multijugador = 1 and IdUsuario2 is null and IdUsuario1 != @IdUsuario2 and Ganador is null)
begin
	update Partidas set IdUsuario2 = @IdUsuario2 where idPartida= @IdPartida
	update Partidas set Ip2 = @Ip2 where idPartida= @IdPartida
	set @exito = 1
end
select @exito



GO
USE [master]
GO
ALTER DATABASE [QEQA03] SET  READ_WRITE 
GO
