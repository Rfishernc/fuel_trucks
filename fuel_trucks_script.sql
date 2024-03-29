USE [master]
GO
/****** Object:  Database [Fuel_trucks]    Script Date: 8/26/2019 6:41:29 AM ******/
CREATE DATABASE [Fuel_trucks]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'fuel_trucks', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\fuel_trucks.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'fuel_trucks_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\fuel_trucks_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Fuel_trucks] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Fuel_trucks].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Fuel_trucks] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Fuel_trucks] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Fuel_trucks] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Fuel_trucks] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Fuel_trucks] SET ARITHABORT OFF 
GO
ALTER DATABASE [Fuel_trucks] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Fuel_trucks] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Fuel_trucks] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Fuel_trucks] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Fuel_trucks] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Fuel_trucks] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Fuel_trucks] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Fuel_trucks] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Fuel_trucks] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Fuel_trucks] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Fuel_trucks] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Fuel_trucks] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Fuel_trucks] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Fuel_trucks] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Fuel_trucks] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Fuel_trucks] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Fuel_trucks] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Fuel_trucks] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Fuel_trucks] SET  MULTI_USER 
GO
ALTER DATABASE [Fuel_trucks] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Fuel_trucks] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Fuel_trucks] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Fuel_trucks] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Fuel_trucks] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Fuel_trucks] SET QUERY_STORE = OFF
GO
USE [Fuel_trucks]
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
USE [Fuel_trucks]
GO
/****** Object:  Table [dbo].[FuelingEvent]    Script Date: 8/26/2019 6:41:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FuelingEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StopId] [int] NOT NULL,
	[ScheduledTime] [datetime] NULL,
	[FuelType] [nvarchar](50) NOT NULL,
	[EstimatedNeed] [decimal](6, 2) NOT NULL,
	[ActualNeed] [decimal](6, 2) NULL,
	[DeliveryTime] [datetime] NULL,
	[SchedulingStatus] [bit] NULL,
 CONSTRAINT [PK_FuelingEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperatingRegion]    Script Date: 8/26/2019 6:41:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperatingRegion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_OperatingRegion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stop]    Script Date: 8/26/2019 6:41:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stop](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Location] [nvarchar](255) NOT NULL,
	[OperatingRegionId] [int] NOT NULL,
	[EnRouteStatus] [bit] NOT NULL,
	[RecurringStatus] [bit] NULL,
	[RecurringIntervalDays] [int] NULL,
 CONSTRAINT [PK_Stop] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tank]    Script Date: 8/26/2019 6:41:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tank](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TruckId] [int] NOT NULL,
	[FuelType] [nvarchar](50) NOT NULL,
	[Capacity] [decimal](6, 2) NOT NULL,
	[FuelLevel] [decimal](6, 2) NOT NULL,
 CONSTRAINT [PK_Tank] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Truck]    Script Date: 8/26/2019 6:41:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Truck](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StopId] [int] NOT NULL,
	[OperatingRegionId] [int] NOT NULL,
	[APIAddress] [nvarchar](255) NULL,
 CONSTRAINT [PK_Truck] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[FuelingEvent] ON 

INSERT [dbo].[FuelingEvent] ([Id], [StopId], [ScheduledTime], [FuelType], [EstimatedNeed], [ActualNeed], [DeliveryTime], [SchedulingStatus]) VALUES (1, 1, NULL, N'Gasoline', CAST(120.50 AS Decimal(6, 2)), CAST(135.85 AS Decimal(6, 2)), CAST(N'2018-12-24T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[FuelingEvent] ([Id], [StopId], [ScheduledTime], [FuelType], [EstimatedNeed], [ActualNeed], [DeliveryTime], [SchedulingStatus]) VALUES (2, 2, NULL, N'Diesel', CAST(80.00 AS Decimal(6, 2)), CAST(90.00 AS Decimal(6, 2)), CAST(N'2019-03-19T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[FuelingEvent] ([Id], [StopId], [ScheduledTime], [FuelType], [EstimatedNeed], [ActualNeed], [DeliveryTime], [SchedulingStatus]) VALUES (3, 2, NULL, N'Diesel', CAST(150.00 AS Decimal(6, 2)), CAST(142.95 AS Decimal(6, 2)), CAST(N'2019-04-19T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[FuelingEvent] ([Id], [StopId], [ScheduledTime], [FuelType], [EstimatedNeed], [ActualNeed], [DeliveryTime], [SchedulingStatus]) VALUES (4, 3, NULL, N'Off-Road Diesel', CAST(200.00 AS Decimal(6, 2)), CAST(220.00 AS Decimal(6, 2)), CAST(N'2019-06-11T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[FuelingEvent] OFF
SET IDENTITY_INSERT [dbo].[OperatingRegion] ON 

INSERT [dbo].[OperatingRegion] ([Id], [Name]) VALUES (1, N'Northside')
INSERT [dbo].[OperatingRegion] ([Id], [Name]) VALUES (2, N'Southside')
INSERT [dbo].[OperatingRegion] ([Id], [Name]) VALUES (3, N'Eastside')
INSERT [dbo].[OperatingRegion] ([Id], [Name]) VALUES (4, N'Westside')
SET IDENTITY_INSERT [dbo].[OperatingRegion] OFF
SET IDENTITY_INSERT [dbo].[Stop] ON 

INSERT [dbo].[Stop] ([Id], [Location], [OperatingRegionId], [EnRouteStatus], [RecurringStatus], [RecurringIntervalDays]) VALUES (1, N'123 Street', 1, 0, 0, NULL)
INSERT [dbo].[Stop] ([Id], [Location], [OperatingRegionId], [EnRouteStatus], [RecurringStatus], [RecurringIntervalDays]) VALUES (2, N'ABC Street', 2, 0, 0, NULL)
INSERT [dbo].[Stop] ([Id], [Location], [OperatingRegionId], [EnRouteStatus], [RecurringStatus], [RecurringIntervalDays]) VALUES (3, N'ZYX Drive', 2, 0, 0, NULL)
INSERT [dbo].[Stop] ([Id], [Location], [OperatingRegionId], [EnRouteStatus], [RecurringStatus], [RecurringIntervalDays]) VALUES (4, N'987 Drive', 3, 0, 0, NULL)
INSERT [dbo].[Stop] ([Id], [Location], [OperatingRegionId], [EnRouteStatus], [RecurringStatus], [RecurringIntervalDays]) VALUES (5, N'DEPOT', 1, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[Stop] OFF
SET IDENTITY_INSERT [dbo].[Tank] ON 

INSERT [dbo].[Tank] ([Id], [TruckId], [FuelType], [Capacity], [FuelLevel]) VALUES (2, 1, N'Diesel', CAST(500.00 AS Decimal(6, 2)), CAST(350.00 AS Decimal(6, 2)))
SET IDENTITY_INSERT [dbo].[Tank] OFF
SET IDENTITY_INSERT [dbo].[Truck] ON 

INSERT [dbo].[Truck] ([Id], [StopId], [OperatingRegionId], [APIAddress]) VALUES (1, 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[Truck] OFF
ALTER TABLE [dbo].[FuelingEvent]  WITH CHECK ADD  CONSTRAINT [FK_FuelingEvent_Stop] FOREIGN KEY([StopId])
REFERENCES [dbo].[Stop] ([Id])
GO
ALTER TABLE [dbo].[FuelingEvent] CHECK CONSTRAINT [FK_FuelingEvent_Stop]
GO
ALTER TABLE [dbo].[Stop]  WITH CHECK ADD  CONSTRAINT [FK_Stop_OperatingRegion] FOREIGN KEY([OperatingRegionId])
REFERENCES [dbo].[OperatingRegion] ([Id])
GO
ALTER TABLE [dbo].[Stop] CHECK CONSTRAINT [FK_Stop_OperatingRegion]
GO
ALTER TABLE [dbo].[Tank]  WITH CHECK ADD  CONSTRAINT [FK_Tank_Truck] FOREIGN KEY([TruckId])
REFERENCES [dbo].[Truck] ([Id])
GO
ALTER TABLE [dbo].[Tank] CHECK CONSTRAINT [FK_Tank_Truck]
GO
ALTER TABLE [dbo].[Truck]  WITH CHECK ADD  CONSTRAINT [FK_Truck_OperatingRegion] FOREIGN KEY([OperatingRegionId])
REFERENCES [dbo].[OperatingRegion] ([Id])
GO
ALTER TABLE [dbo].[Truck] CHECK CONSTRAINT [FK_Truck_OperatingRegion]
GO
ALTER TABLE [dbo].[Truck]  WITH CHECK ADD  CONSTRAINT [FK_Truck_Stop] FOREIGN KEY([StopId])
REFERENCES [dbo].[Stop] ([Id])
GO
ALTER TABLE [dbo].[Truck] CHECK CONSTRAINT [FK_Truck_Stop]
GO
USE [master]
GO
ALTER DATABASE [Fuel_trucks] SET  READ_WRITE 
GO
