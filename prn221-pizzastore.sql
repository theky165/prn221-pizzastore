USE [master]
GO
/****** Object:  Database [PizzaStore]    Script Date: 21-Feb-23 2:09:39 PM ******/
CREATE DATABASE [PizzaStore]
GO
ALTER DATABASE [PizzaStore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PizzaStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PizzaStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PizzaStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PizzaStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PizzaStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PizzaStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [PizzaStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PizzaStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PizzaStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PizzaStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PizzaStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PizzaStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PizzaStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PizzaStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PizzaStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PizzaStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PizzaStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PizzaStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PizzaStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PizzaStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PizzaStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PizzaStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PizzaStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PizzaStore] SET RECOVERY FULL 
GO
ALTER DATABASE [PizzaStore] SET  MULTI_USER 
GO
ALTER DATABASE [PizzaStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PizzaStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PizzaStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PizzaStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PizzaStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PizzaStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PizzaStore', N'ON'
GO
ALTER DATABASE [PizzaStore] SET QUERY_STORE = OFF
GO
USE [PizzaStore]
GO
/****** Object:  User [admin]    Script Date: 21-Feb-23 2:09:39 PM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 21-Feb-23 2:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[FullName] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 21-Feb-23 2:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NULL,
	[Description] [text] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 21-Feb-23 2:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[ContactName] [varchar](50) NULL,
	[Address] [varchar](255) NULL,
	[Phone] [varchar](50) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 21-Feb-23 2:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [float] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 21-Feb-23 2:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[Freight] [float] NULL,
	[ShipAddress] [varchar](255) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 21-Feb-23 2:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [int] NULL,
	[UnitPrice] [float] NULL,
	[ProductImage] [varchar](50) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 21-Feb-23 2:09:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](50) NULL,
	[Address] [varchar](255) NULL,
	[Phone] [varchar](50) NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Categories]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Suppliers]
GO
USE [master]
GO
ALTER DATABASE [PizzaStore] SET  READ_WRITE 
GO
