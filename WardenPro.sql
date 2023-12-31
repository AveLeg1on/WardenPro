USE [master]
GO
/****** Object:  Database [WardenPro]    Script Date: 11.03.2023 17:30:59 ******/
CREATE DATABASE [WardenPro]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WardenPro', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\WardenPro.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WardenPro_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\WardenPro_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [WardenPro] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WardenPro].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WardenPro] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WardenPro] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WardenPro] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WardenPro] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WardenPro] SET ARITHABORT OFF 
GO
ALTER DATABASE [WardenPro] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WardenPro] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WardenPro] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WardenPro] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WardenPro] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WardenPro] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WardenPro] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WardenPro] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WardenPro] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WardenPro] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WardenPro] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WardenPro] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WardenPro] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WardenPro] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WardenPro] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WardenPro] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WardenPro] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WardenPro] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WardenPro] SET  MULTI_USER 
GO
ALTER DATABASE [WardenPro] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WardenPro] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WardenPro] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WardenPro] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WardenPro] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WardenPro] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [WardenPro] SET QUERY_STORE = OFF
GO
USE [WardenPro]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 11.03.2023 17:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Division]    Script Date: 11.03.2023 17:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Division](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Division] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LnkVisitorRequest]    Script Date: 11.03.2023 17:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LnkVisitorRequest](
	[VisitorId] [int] NOT NULL,
	[RequestId] [int] NOT NULL,
 CONSTRAINT [PK_LnkVisitorRequest] PRIMARY KEY CLUSTERED 
(
	[VisitorId] ASC,
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Visitor]    Script Date: 11.03.2023 17:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visitor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](50) NOT NULL,
	[Middlename] [nvarchar](50) NOT NULL,
	[Lastname] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[DateBirth] [datetime] NULL,
	[PassportSerial] [int] NOT NULL,
	[PassportNumber] [int] NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[Organization] [nvarchar](50) NULL,
	[Note] [nvarchar](max) NULL,
	[ImageSource] [nvarchar](max) NULL,
	[PassportPdfSource] [nvarchar](max) NULL,
 CONSTRAINT [PK_Visitor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisitorBlackList]    Script Date: 11.03.2023 17:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisitorBlackList](
	[VisitorId] [int] NOT NULL,
	[Reason] [nvarchar](max) NULL,
 CONSTRAINT [PK_VisitorBlackList] PRIMARY KEY CLUSTERED 
(
	[VisitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisitRequest]    Script Date: 11.03.2023 17:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisitRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Purpose] [nvarchar](50) NOT NULL,
	[WorkerId] [int] NULL,
	[TypeId] [int] NULL,
	[GroupName] [nvarchar](50) NULL,
	[IsApproved] [bit] NOT NULL,
	[RejectReason] [nvarchar](max) NOT NULL,
	[DesiredDateStart] [datetime] NULL,
	[DesiredDateEnd] [datetime] NULL,
	[VisitDate] [datetime] NULL,
	[ArrivedSecurityDate] [datetime] NULL,
	[LeftSecurityDate] [datetime] NULL,
	[ArrivedWorkerDate] [datetime] NULL,
	[LeftWorkerDate] [datetime] NULL,
 CONSTRAINT [PK_VisitRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VisitRequestType]    Script Date: 11.03.2023 17:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VisitRequestType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_VisitRequestType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Worker]    Script Date: 11.03.2023 17:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Worker](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FIO] [nvarchar](50) NOT NULL,
	[DivisionId] [int] NULL,
	[DepartmentId] [int] NULL,
	[AuthCode] [int] NULL,
 CONSTRAINT [PK_Worker] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([Id], [Name]) VALUES (1, N'Общий отдел')
INSERT [dbo].[Department] ([Id], [Name]) VALUES (2, N'Охрана')
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[Division] ON 

INSERT [dbo].[Division] ([Id], [Name]) VALUES (1, N'Производство')
INSERT [dbo].[Division] ([Id], [Name]) VALUES (2, N'Сбыт')
INSERT [dbo].[Division] ([Id], [Name]) VALUES (3, N'Администрация')
INSERT [dbo].[Division] ([Id], [Name]) VALUES (4, N'Служба безопасности')
INSERT [dbo].[Division] ([Id], [Name]) VALUES (5, N'Планирование')
SET IDENTITY_INSERT [dbo].[Division] OFF
GO
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (1, 1)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (2, 2)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (3, 3)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (4, 4)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (5, 5)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (6, 6)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (7, 7)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (8, 8)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (9, 9)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (10, 10)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (11, 11)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (12, 12)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (13, 13)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (14, 14)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (15, 15)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (16, 16)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (17, 16)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (18, 16)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (19, 16)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (20, 16)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (21, 16)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (22, 16)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (23, 17)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (24, 17)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (25, 17)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (26, 17)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (27, 17)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (28, 17)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (29, 17)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (30, 17)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (31, 18)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (32, 19)
INSERT [dbo].[LnkVisitorRequest] ([VisitorId], [RequestId]) VALUES (33, 20)
GO
SET IDENTITY_INSERT [dbo].[Visitor] ON 

INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (1, N'Степанова', N'Радинка', N'Власовна', N'+7 (613) 272-60-62', N'Radinka100@yandex.ru', CAST(N'1986-10-18T00:00:00.000' AS DateTime), 208, 530509, N'Vlas86', N'︓쁚癇＋⻯౓', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (2, N'Шилов', N'Прохор', N'Герасимович', N'+7 (615) 594-77-66', N'Prohor156@list.ru', CAST(N'1977-10-09T00:00:00.000' AS DateTime), 3036, 796488, N'Prohor156', N'므ꐧ몇曩ἰḓẇ璐', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (3, N'Кононов', N'Юрин', N'Романович', N'+7 (784) 673-51-91', N'YUrin155@gmail.com', CAST(N'1971-10-08T00:00:00.000' AS DateTime), 2747, 790512, N'YUrin155', N'봣뇜﹐徺杷꘰ꑃ', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (4, N'Елисеева', N'Альбина', N'Николаевна', N'+7 (654) 864-77-46', N'Aljbina33@lenta.ru', CAST(N'1983-02-15T00:00:00.000' AS DateTime), 5241, 213304, N'Aljbina33', N'꧴ᅪ쮚韾䈘堧Άཱུ', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (5, N'Шарова', N'Клавдия', N'Макаровна', N'+7 (822) 525-82-40', N'Klavdiya113@live.com', CAST(N'1980-07-22T00:00:00.000' AS DateTime), 8143, 593309, N'Klavdiya113', N'Ɤퟚ뛟㌺羓촨렎', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (6, N'Сидорова', N'Тамара', N'Григорьевна', N'+7 (334) 692-79-77', N'Tamara179@live.com', CAST(N'1995-11-22T00:00:00.000' AS DateTime), 8143, 905520, N'Tamara179', N'⣅뿔椧Ｙ즄茮⩇鄤', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (7, N'Петухов', N'Тарас', N'Фадеевич', N'+7 (376) 220-62-51', N'Taras24@rambler.ru', CAST(N'1991-01-05T00:00:00.000' AS DateTime), 1609, 171096, N'Taras24', N'瑜ﺆᖜ㏌유', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (8, N'Родионов', N'Аркадий', N'Власович', N'+7 (491) 696-17-11', N'Arkadij123@inbox.ru', CAST(N'1993-08-11T00:00:00.000' AS DateTime), 3841, 642594, N'Arkadij123', N'Ꚑ氅앿橞태錆ꍶ', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (9, N'Горшкова', N'Глафира', N'Валентиновна', N'+7 (553) 343-38-82', N'Glafira73@outlook.com', CAST(N'1978-05-25T00:00:00.000' AS DateTime), 9170, 402601, N'Glafira73', N'ꉢ좺흢㡀ꭓ칐஻룴', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (10, N'Кириллова', N'Гавриила', N'Яковна', N'+7 (648) 700-43-34', N'Gavriila68@msn.com', CAST(N'1992-04-26T00:00:00.000' AS DateTime), 9438, 379667, N'Gavriila68', N'岥Ṍ嬙찦⏇썪읃ឱ', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (11, N'Овчинников', N'Кузьма', N'Ефимович', N'+7 (562) 866-15-27', N'Kuzjma124@yandex.ru', CAST(N'1993-08-02T00:00:00.000' AS DateTime), 766, 647226, N'Kuzjma124', N'塧ྗ筕涳줏㮑뢑', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (12, N'Беляков', N'Роман', N'Викторович', N'+7 (595) 196-56-28', N'Roman89@gmail.com', CAST(N'1991-06-07T00:00:00.000' AS DateTime), 2411, 478305, N'Roman89', N'韷攗仳詭ꉻ걭', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (13, N'Лыткин', N'Алексей', N'Максимович', N'+7 (994) 353-29-52', N'Aleksej43@gmail.com', CAST(N'1996-03-07T00:00:00.000' AS DateTime), 2383, 259825, N'Aleksej43', N'᫆躕戉寮麌ᤋ켣曽', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (14, N'Шубина', N'Надежда', N'Викторовна', N'+7 (736) 488-66-95', N'Nadezhda137@outlook.com', CAST(N'1981-09-24T00:00:00.000' AS DateTime), 8844, 708476, N'Nadezhda137', N'︺뤔褨␡Ҷ缛꣰', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (15, N'Зиновьева', N'Бронислава', N'Викторовна', N'+7 (778) 565-12-18', N'Bronislava56@yahoo.com', CAST(N'1981-03-19T00:00:00.000' AS DateTime), 6736, 319423, N'Bronislava56', N'䌿㫘ꝥ휽鮪衈퍵', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (16, N'Самойлова', N'Таисия', N'Гермоновна', N'+7 (891) 555-81-44', N'Taisiya177@lenta.ru', CAST(N'1979-11-14T00:00:00.000' AS DateTime), 5193, 897719, N'Taisiya177', N'�᰺恭ㄧꟺⶰ슨', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (17, N'Ситникова', N'Аделаида', N'Гермоновна', N'+7 (793) 736-70-31', N'Adelaida20@hotmail.com', CAST(N'1979-01-21T00:00:00.000' AS DateTime), 7561, 148016, N'Adelaida20', N'쓲뱟着帅㘶慛ൾ', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (18, N'Исаев', N'Лев', N'Юлианович', N'+7 (675) 593-89-30', N'Lev131@rambler.ru', CAST(N'1994-08-05T00:00:00.000' AS DateTime), 1860, 680004, N'Lev131', N'㡤앣쉜蝑䟍녵덮', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (19, N'Никифоров', N'Даниил', N'Степанович', N'+7 (384) 358-77-82', N'Daniil198@bk.ru', CAST(N'1970-12-13T00:00:00.000' AS DateTime), 4557, 999958, N'lzaihtvkdn', N'ྜ鄪솂ﵫ男', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (20, N'Титова', N'Людмила', N'Якововна', N'+7 (221) 729-16-84', N'Lyudmila123@hotmail.com', CAST(N'1976-08-21T00:00:00.000' AS DateTime), 7715, 639425, N'Lyudmila123', N'辣贺襞勏큾ⴋ塞犷', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (21, N'Абрамова', N'Таисия', N'Дмитриевна', N'+7 (528) 312-18-20', N'Taisiya176@hotmail.com', CAST(N'1982-11-20T00:00:00.000' AS DateTime), 7310, 893510, N'Taisiya176', N'箦쐰�橶䕄֟', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (22, N'Кузьмина', N'Вера', N'Максимовна', N'+7 (598) 583-53-45', N'Vera195@list.ru', CAST(N'1989-12-10T00:00:00.000' AS DateTime), 3537, 982933, N'Vera195', N'斱䍤浴슎皴决₠倓', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (23, N'Мартынов', N'Яков', N'Ростиславович', N'+7 (546) 159-67-33', N'YAkov196@rambler.ru', CAST(N'1976-12-05T00:00:00.000' AS DateTime), 1793, 986063, N'YAkov196', N'똝旇춢㰤륹Ɦ徇仆', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (24, N'Евсеева', N'Нина', N'Павловна', N'+7 (833) 521-31-50', N'Nina145@msn.com', CAST(N'1994-09-26T00:00:00.000' AS DateTime), 9323, 745717, N'Nina145', N'鴒휄숩뷌훆춦ېɝ', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (25, N'Голубев', N'Леонтий', N'Вячеславович', N'+7 (160) 527-57-41', N'Leontij161@mail.ru', CAST(N'1990-10-03T00:00:00.000' AS DateTime), 1059, 822077, N'Leontij161', N'᫭ﲏ䡊䦈뀐ꞝᧅ㞧', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (26, N'Карпова', N'Серафима', N'Михаиловна', N'+7 (459) 930-91-70', N'Serafima169@yahoo.com', CAST(N'1989-11-19T00:00:00.000' AS DateTime), 7034, 858987, N'Serafima169', N'䉋㨔࿆嵄㺘噠ቐ眙', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (27, N'Орехов', N'Сергей', N'Емельянович', N'+7 (669) 603-29-87', N'Sergej35@inbox.ru', CAST(N'1972-02-11T00:00:00.000' AS DateTime), 3844, 223682, N'Sergej35', N'컻鑞좿㖵䲼웙䶈✳', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (28, N'Исаев', N'Георгий', N'Павлович', N'+7 (678) 516-36-86', N'Georgij121@inbox.ru', CAST(N'1987-08-11T00:00:00.000' AS DateTime), 4076, 629809, N'Georgij121', N'ユЍ�ࢀ솄抻䱛肥', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (29, N'Богданов', N'Елизар', N'Артемович', N'+7 (165) 768-30-97', N'Elizar30@yandex.ru', CAST(N'1978-02-02T00:00:00.000' AS DateTime), 573, 198559, N'Elizar30', N'ꉰ嗀ﰇ莹棁셆', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (30, N'Тихонова', N'Лана', N'Семеновна', N'+7 (478) 467-75-15', N'Lana117@outlook.com', CAST(N'1990-07-24T00:00:00.000' AS DateTime), 8761, 609740, N'Lana117', N'刼铭鲱쯚⋵㾄', NULL, NULL, NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (31, N'ss', N'ss', NULL, NULL, N'ss@s', CAST(N'2007-02-22T00:00:00.000' AS DateTime), 1222, 222222, N'ss', NULL, NULL, N'ss', NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (32, N'f', N'f', NULL, NULL, N'ffff@d', CAST(N'2007-02-26T00:00:00.000' AS DateTime), 3333, 333333, N'ffff', NULL, NULL, N'd', NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (33, N'ф', N'ф', NULL, NULL, N'das@sas', CAST(N'2007-02-27T00:00:00.000' AS DateTime), 7876, 456344, N'das', NULL, NULL, N'sadads', NULL, NULL)
INSERT [dbo].[Visitor] ([Id], [Firstname], [Middlename], [Lastname], [Phone], [Email], [DateBirth], [PassportSerial], [PassportNumber], [Login], [Password], [Organization], [Note], [ImageSource], [PassportPdfSource]) VALUES (34, N'sd', N'sd', NULL, NULL, N'sdf2@ddas', CAST(N'2007-03-07T00:00:00.000' AS DateTime), 3215, 984654, N'sdf2', N'섬持�֍�ꊐꓞ', NULL, N'asd', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Visitor] OFF
GO
SET IDENTITY_INSERT [dbo].[VisitRequest] ON 

INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (1, N'', 1, 1, N'', 0, N'“Заявка на посещение объекта КИИ отклонена в связи с нарушением Федерального закона от 26.07.2017 № 194-ФЗ «О внесении изменений в Уголовный кодекс Российской Федерации и статью 151 Уголовно-процессуального кодекса Российской Федерации в связи с принятием Федерального закона "О безопасности критической информационной инфраструктуры Российской Федерации" по причине указания заявителем заведомо недостоверных данных”', CAST(N'2023-04-24T00:00:00.000' AS DateTime), CAST(N'2023-05-09T00:00:00.000' AS DateTime), NULL, CAST(N'2023-03-09T18:39:17.843' AS DateTime), CAST(N'2023-03-09T18:39:39.697' AS DateTime), NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (2, N'', 2, 1, N'', 1, N'одобрена', CAST(N'2023-04-24T00:00:00.000' AS DateTime), CAST(N'2023-05-09T00:00:00.000' AS DateTime), CAST(N'2023-04-24T00:00:00.000' AS DateTime), CAST(N'2023-03-09T18:38:36.233' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (3, N'', 3, 1, N'', 1, N'одобрена', CAST(N'2023-04-24T00:00:00.000' AS DateTime), CAST(N'2023-05-09T00:00:00.000' AS DateTime), CAST(N'2023-03-10T12:00:00.000' AS DateTime), CAST(N'2023-03-09T22:50:20.640' AS DateTime), CAST(N'2023-03-09T22:52:48.387' AS DateTime), NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (4, N'', 1, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(N'2023-05-10T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (5, N'', 2, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(N'2023-05-10T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (6, N'', 3, 1, N'', 0, N'отклонена', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(N'2023-05-10T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (7, N'', 1, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-26T00:00:00.000' AS DateTime), CAST(N'2023-05-11T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (8, N'', 2, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-26T00:00:00.000' AS DateTime), CAST(N'2023-05-11T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (9, N'', 3, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-26T00:00:00.000' AS DateTime), CAST(N'2023-05-11T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (10, N'', 1, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-27T00:00:00.000' AS DateTime), CAST(N'2023-05-12T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (11, N'', 2, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-27T00:00:00.000' AS DateTime), CAST(N'2023-05-12T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (12, N'', 3, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-27T00:00:00.000' AS DateTime), CAST(N'2023-05-12T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (13, N'', 1, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(N'2023-05-13T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (14, N'', 2, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(N'2023-05-13T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (15, N'', 3, 1, N'', 0, N'на рассмотрении', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(N'2023-05-13T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (16, N'', 1, 2, N'ГР1', 0, N'на рассмотрении', CAST(N'2023-04-24T00:00:00.000' AS DateTime), CAST(N'2023-05-09T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (17, N'', 1, 2, N'ГР2', 0, N'на рассмотрении', CAST(N'2023-04-24T00:00:00.000' AS DateTime), CAST(N'2023-05-09T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (18, N'sss', 3, 1, NULL, 0, N'', CAST(N'2023-03-10T12:04:03.593' AS DateTime), CAST(N'2023-03-25T12:04:03.593' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (19, N'f', 1, 1, NULL, 0, N'', CAST(N'2023-03-10T12:10:40.603' AS DateTime), CAST(N'2023-03-25T12:10:40.603' AS DateTime), NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[VisitRequest] ([Id], [Purpose], [WorkerId], [TypeId], [GroupName], [IsApproved], [RejectReason], [DesiredDateStart], [DesiredDateEnd], [VisitDate], [ArrivedSecurityDate], [LeftSecurityDate], [ArrivedWorkerDate], [LeftWorkerDate]) VALUES (20, N'sa', 2, 2, N'дщч', 0, N'а', CAST(N'2023-03-10T12:25:40.127' AS DateTime), CAST(N'2023-03-25T12:25:40.127' AS DateTime), NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[VisitRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[VisitRequestType] ON 

INSERT [dbo].[VisitRequestType] ([Id], [Name]) VALUES (1, N'Личное посещение')
INSERT [dbo].[VisitRequestType] ([Id], [Name]) VALUES (2, N'Групповое посещение')
SET IDENTITY_INSERT [dbo].[VisitRequestType] OFF
GO
SET IDENTITY_INSERT [dbo].[Worker] ON 

INSERT [dbo].[Worker] ([Id], [FIO], [DivisionId], [DepartmentId], [AuthCode]) VALUES (1, N'Фомичева Авдотья Трофимовна', 1, NULL, 9367788)
INSERT [dbo].[Worker] ([Id], [FIO], [DivisionId], [DepartmentId], [AuthCode]) VALUES (2, N'Гаврилова Римма Ефимовна', 2, NULL, 9788737)
INSERT [dbo].[Worker] ([Id], [FIO], [DivisionId], [DepartmentId], [AuthCode]) VALUES (3, N'Носкова Наталия Прохоровна', 3, NULL, 9736379)
INSERT [dbo].[Worker] ([Id], [FIO], [DivisionId], [DepartmentId], [AuthCode]) VALUES (4, N'Архипов Тимофей Васильевич', 4, NULL, 9362832)
INSERT [dbo].[Worker] ([Id], [FIO], [DivisionId], [DepartmentId], [AuthCode]) VALUES (5, N'Орехова Вероника Артемовна', 5, NULL, 9737848)
INSERT [dbo].[Worker] ([Id], [FIO], [DivisionId], [DepartmentId], [AuthCode]) VALUES (6, N'Савельев Павел Степанович', NULL, 1, 9768239)
INSERT [dbo].[Worker] ([Id], [FIO], [DivisionId], [DepartmentId], [AuthCode]) VALUES (7, N'Чернов Всеволод Наумович', NULL, 2, 9404040)
INSERT [dbo].[Worker] ([Id], [FIO], [DivisionId], [DepartmentId], [AuthCode]) VALUES (8, N'Марков Юрий Романович', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Worker] OFF
GO
ALTER TABLE [dbo].[VisitRequest] ADD  CONSTRAINT [DF_VisitRequest_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[VisitRequest] ADD  CONSTRAINT [DF_VisitRequest_RejectReason]  DEFAULT (N'на рассмотрении') FOR [RejectReason]
GO
ALTER TABLE [dbo].[LnkVisitorRequest]  WITH CHECK ADD  CONSTRAINT [FK_LnkVisitorRequest_Visitor] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitor] ([Id])
GO
ALTER TABLE [dbo].[LnkVisitorRequest] CHECK CONSTRAINT [FK_LnkVisitorRequest_Visitor]
GO
ALTER TABLE [dbo].[LnkVisitorRequest]  WITH CHECK ADD  CONSTRAINT [FK_LnkVisitorRequest_VisitRequest] FOREIGN KEY([RequestId])
REFERENCES [dbo].[VisitRequest] ([Id])
GO
ALTER TABLE [dbo].[LnkVisitorRequest] CHECK CONSTRAINT [FK_LnkVisitorRequest_VisitRequest]
GO
ALTER TABLE [dbo].[VisitorBlackList]  WITH NOCHECK ADD  CONSTRAINT [FK_VisitorBlackList_Visitor] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitor] ([Id])
GO
ALTER TABLE [dbo].[VisitorBlackList] CHECK CONSTRAINT [FK_VisitorBlackList_Visitor]
GO
ALTER TABLE [dbo].[VisitRequest]  WITH CHECK ADD  CONSTRAINT [FK_VisitRequest_VisitRequestType] FOREIGN KEY([TypeId])
REFERENCES [dbo].[VisitRequestType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VisitRequest] CHECK CONSTRAINT [FK_VisitRequest_VisitRequestType]
GO
ALTER TABLE [dbo].[VisitRequest]  WITH CHECK ADD  CONSTRAINT [FK_VisitRequest_Worker] FOREIGN KEY([WorkerId])
REFERENCES [dbo].[Worker] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VisitRequest] CHECK CONSTRAINT [FK_VisitRequest_Worker]
GO
ALTER TABLE [dbo].[Worker]  WITH CHECK ADD  CONSTRAINT [FK_Worker_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Worker] CHECK CONSTRAINT [FK_Worker_Department]
GO
ALTER TABLE [dbo].[Worker]  WITH CHECK ADD  CONSTRAINT [FK_Worker_Division] FOREIGN KEY([DivisionId])
REFERENCES [dbo].[Division] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Worker] CHECK CONSTRAINT [FK_Worker_Division]
GO
USE [master]
GO
ALTER DATABASE [WardenPro] SET  READ_WRITE 
GO
