USE [master]
GO
/****** Object:  Database [Traider01]    Script Date: 07.04.2022 16:44:55 ******/
CREATE DATABASE [Traider01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Traider01', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Traider01.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Traider01_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Traider01_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Traider01] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Traider01].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Traider01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Traider01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Traider01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Traider01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Traider01] SET ARITHABORT OFF 
GO
ALTER DATABASE [Traider01] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Traider01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Traider01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Traider01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Traider01] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Traider01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Traider01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Traider01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Traider01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Traider01] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Traider01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Traider01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Traider01] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Traider01] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Traider01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Traider01] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Traider01] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Traider01] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Traider01] SET  MULTI_USER 
GO
ALTER DATABASE [Traider01] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Traider01] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Traider01] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Traider01] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Traider01] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Traider01] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Traider01] SET QUERY_STORE = OFF
GO
USE [Traider01]
GO
/****** Object:  UserDefinedFunction [dbo].[BestClient]    Script Date: 07.04.2022 16:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[BestClient]()
RETURNS INT
BEGIN
	DECLARE @id INT
	SELECT TOP(1) @id = [User].Id 
	FROM [User],[Contract]
	 WHERE [User].RoleID = 1 AND [User].Id = [Contract].UserId
	 GROUP BY [User].Id 
	 ORDER BY COUNT([User].Id) DESC
RETURN @id
END;
GO
/****** Object:  Table [dbo].[Adres]    Script Date: 07.04.2022 16:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adres](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PostCode] [nvarchar](6) NOT NULL,
	[StreetId] [int] NULL,
	[HomeNumber] [nvarchar](5) NOT NULL,
	[Apartmentnumber] [nvarchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[City]    Script Date: 07.04.2022 16:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 07.04.2022 16:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[INN] [nvarchar](12) NOT NULL,
	[AdresId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contract]    Script Date: 07.04.2022 16:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contract](
	[Number] [int] NOT NULL,
	[UserId] [int] NULL,
	[CompanyId] [int] NULL,
	[Profit] [decimal](15, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 07.04.2022 16:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Street]    Script Date: 07.04.2022 16:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Street](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CityId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 07.04.2022 16:44:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[MidleName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Login] [nvarchar](320) NOT NULL,
	[Passwqord] [nvarchar](320) NOT NULL,
	[RoleID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Adres] ON 

INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (13, N'107258', 1, N'161', N'15')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (14, N'359024', 2, N'69', N'311')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (15, N'215656', 3, N'98', N'706')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (16, N'142963', 4, N'25', N'107')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (17, N'446150', 5, N'105', N'335')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (18, N'623618', 6, N'189', N'483')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (19, N'450961', 7, N'12', N'774')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (20, N'682364', 8, N'200', N'299')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (21, N'461227', 9, N'196', N'347')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (22, N'413230', 10, N'147', N'139')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (23, N'429073', 11, N'22', N'679')
INSERT [dbo].[Adres] ([ID], [PostCode], [StreetId], [HomeNumber], [Apartmentnumber]) VALUES (24, N'624092', 12, N'23', N'906')
SET IDENTITY_INSERT [dbo].[Adres] OFF
GO
SET IDENTITY_INSERT [dbo].[City] ON 

INSERT [dbo].[City] ([Id], [Name]) VALUES (1, N'Александров')
INSERT [dbo].[City] ([Id], [Name]) VALUES (2, N'Акъяр')
INSERT [dbo].[City] ([Id], [Name]) VALUES (3, N'Россошь')
INSERT [dbo].[City] ([Id], [Name]) VALUES (4, N'Фершампенуаз')
INSERT [dbo].[City] ([Id], [Name]) VALUES (5, N'Сорск')
INSERT [dbo].[City] ([Id], [Name]) VALUES (6, N'Рыльск')
INSERT [dbo].[City] ([Id], [Name]) VALUES (7, N'Карсун')
INSERT [dbo].[City] ([Id], [Name]) VALUES (8, N'Шенкурск')
INSERT [dbo].[City] ([Id], [Name]) VALUES (9, N'Павловск')
INSERT [dbo].[City] ([Id], [Name]) VALUES (10, N'Луговское')
INSERT [dbo].[City] ([Id], [Name]) VALUES (11, N'Истра')
INSERT [dbo].[City] ([Id], [Name]) VALUES (12, N'Междуреченск')
SET IDENTITY_INSERT [dbo].[City] OFF
GO
SET IDENTITY_INSERT [dbo].[Company] ON 

INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (25, N'Национальная компьютерная корпорация', N'853461374896', 13)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (26, N'СУ-155', N'466324089792', 14)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (27, N'Автомир', N'898522206600', 15)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (28, N'Корпорация «Главстрой»', N'667875519819', 16)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (29, N'Буровая компания «Евразия»', N'916627620171', 17)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (30, N'Русагро', N'427108301962', 18)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (31, N'Mercury', N'447948070350', 19)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (32, N'Технониколь', N'812582820883', 20)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (33, N'Русэнергосбыт', N'592523601120', 21)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (34, N'Группа ЛСР', N'223241707921', 22)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (35, N'Объединенная промышленная корпорация', N'326953987762', 23)
INSERT [dbo].[Company] ([Id], [Name], [INN], [AdresId]) VALUES (36, N'Цифроград', N'439380819400', 24)
SET IDENTITY_INSERT [dbo].[Company] OFF
GO
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (457, 3, 25, CAST(15000000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (587, 4, 28, CAST(2000000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (4587, 6, 29, CAST(3500000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (4797, 6, 33, CAST(125800.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (5797, 3, 30, CAST(200000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (48978, 2, 26, CAST(1000000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (54794, 11, 27, CAST(160000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (58791, 7, 35, CAST(48500000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (59749, 3, 34, CAST(3500000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (59771, 9, 31, CAST(2500084.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (59779, 12, 32, CAST(3521000.00 AS Decimal(15, 2)))
INSERT [dbo].[Contract] ([Number], [UserId], [CompanyId], [Profit]) VALUES (587941, 9, 36, CAST(3820000.00 AS Decimal(15, 2)))
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Value]) VALUES (1, N'Клиент')
INSERT [dbo].[Role] ([Id], [Value]) VALUES (2, N'Менеджер')
INSERT [dbo].[Role] ([Id], [Value]) VALUES (3, N'Директор')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Street] ON 

INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (1, N'Маяковского(Красносельский)', 1)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (2, N'Куракина', 2)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (3, N'Карачаровское ш', 3)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (4, N'Стрельнинская', 4)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (5, N'Батарейная дор', 5)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (6, N'Парголовский пер', 6)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (7, N'Лассаля', 7)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (8, N'Преображенская пл', 8)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (9, N'Пихтовая', 9)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (10, N'Никоновский пер', 10)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (11, N'Кабельная 2-я', 11)
INSERT [dbo].[Street] ([Id], [Name], [CityId]) VALUES (12, N'1-я Конная Лахта', 12)
SET IDENTITY_INSERT [dbo].[Street] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (1, N'Алиса', N'Данииловна', N'Королева', N'dyjej', N'Rg2PHz37', 1)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (2, N'Арсений', N'Александрович', N'Балашов', N'xiwaz', N'NTGFk6TS', 1)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (3, N'Матвей', N'Николаевич', N'Васильев', N'hygyc', N'CnhgXsLq', 1)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (4, N'Елизавета', N'Георгиевна', N'Колпакова', N'fobih', N'PB1P6A97', 2)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (5, N'Елена', N'Семёновна', N'Попова', N'vicaz', N'4djK2OQk', 3)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (6, N'Дмитрий', N'Давидович', N'Селезнев', N'zotag', N'dicwyuTh', 1)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (7, N'София', N'Александровна', N'Леонтьева', N'katal', N'duIveGic', 1)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (8, N'Ева', N'Васильевна', N'Гусева', N'xuloj', N'iop6IvlV', 2)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (9, N'Алина', N'Николаевна', N'Зорина', N'qefup', N'Jc8FMRXh', 3)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (10, N'Елизавета', N'Артёмовна', N'Зыкова', N'lubim', N'aGxvViTw', 1)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (11, N'Екатерина', N'Андреевна', N'Николаева', N'gaguz', N'NKilBcnY', 1)
INSERT [dbo].[User] ([Id], [FirstName], [MidleName], [LastName], [Login], [Passwqord], [RoleID]) VALUES (12, N'Анастасия', N'Матвеевна', N'Сидорова', N'voqoh', N'GoQfGSU3', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Adres]  WITH CHECK ADD FOREIGN KEY([StreetId])
REFERENCES [dbo].[Street] ([Id])
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD FOREIGN KEY([AdresId])
REFERENCES [dbo].[Adres] ([ID])
GO
ALTER TABLE [dbo].[Contract]  WITH CHECK ADD FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Contract]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Street]  WITH CHECK ADD FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([Id])
GO
USE [master]
GO
ALTER DATABASE [Traider01] SET  READ_WRITE 
GO
