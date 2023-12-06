/****** Object:  Database ist722_hhkhan_ob2_dw    Script Date: 9/1/2023 12:51:10 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_hhkhan_ob2_dw
GO
CREATE DATABASE ist722_hhkhan_ob2_dw
GO
ALTER DATABASE ist722_hhkhan_ob2_dw
SET RECOVERY SIMPLE
GO
*/
USE ist722_hhkhan_ob2_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;





-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
/*GO
CREATE SCHEMA fudgeworld
GO
*/





/* Drop table fudgeworld.FactSales */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeworld.FactSales') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeworld.FactSales 
;

/* Create table fudgeworld.FactSales */
CREATE TABLE fudgeworld.FactSales (
   [ProductKey]  int   NOT NULL
,  [DivisionID]  int   NOT NULL
,  [OrderID]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
,  [Quantity]  smallint   NOT NULL
,  [SalesAmount]  money   NOT NULL
,  [CostAmount]  money  DEFAULT 0 NOT NULL
,  [ProfitAmount]  money   NOT NULL
, CONSTRAINT [PK_fudgeworld.FactSales] PRIMARY KEY NONCLUSTERED 
( [ProductKey], [DivisionID], [OrderID] )
) ON [PRIMARY]
;


-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeworld].[Sales]'))
DROP VIEW [fudgeworld].[Sales]
GO
CREATE VIEW [fudgeworld].[Sales] AS 
SELECT [ProductKey] AS [ProductKey]
, [DivisionID] AS [DivisionID]
, [OrderID] AS [OrderID]
, [CustomerKey] AS [CustomerKey]
, [OrderDateKey] AS [OrderDateKey]
, [ShippedDateKey] AS [ShippedDateKey]
, [Quantity] AS [Quantity]
, [SalesAmount] AS [SalesAmount]
, [CostAmount] AS [DiscountAmount]
, [ProfitAmount] AS [ProfitAmount]
FROM fudgeworld.FactSales
GO



/* Drop table fudgeworld.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeworld.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeworld.DimCustomer 
;

/* Create table fudgeworld.DimCustomer */
CREATE TABLE fudgeworld.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  int NOT NULL
,  [CustomerName]  nvarchar(120)   NOT NULL
,  [CustomerState]  varchar(20)  DEFAULT 'N/A' NOT NULL
,  [CustomerCity]  nvarchar(50)   NOT NULL
,  [CustomerPostalCode]  varchar(25)   NOT NULL
,  [CustomerSource]  nvarchar(20)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudgeworld.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT fudgeworld.DimCustomer ON
;
INSERT INTO fudgeworld.DimCustomer (CustomerKey, CustomerID, CustomerName, CustomerState, CustomerCity, CustomerPostalCode, CustomerSource, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown Name', 'None', 'None', 'None', 'None', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudgeworld.DimCustomer OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeworld].[Customer]'))
DROP VIEW [fudgeworld].[Customer]
GO
CREATE VIEW [fudgeworld].[Customer] AS 
SELECT [CustomerKey] AS [CustomerKey]
, [CustomerID] AS [CustomerID]
, [CustomerName] AS [CustomerName]
, [CustomerState] AS [CustomerState]
, [CustomerCity] AS [CustomerCity]
, [CustomerPostalCode] AS [CustomerPostalCode]
, [CustomerSource] AS [CustomerSource]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM fudgeworld.DimCustomer
GO





/* Drop table fudgeworld.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeworld.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeworld.DimProduct 
;

/* Create table fudgeworld.DimProduct */
CREATE TABLE fudgeworld.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  int   NOT NULL
,  [ProductName] varchar(51)   NOT NULL
,  [ProductDepartment]  nvarchar(40)  DEFAULT 'N' NOT NULL
,  [ProductSource]  nvarchar(40)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudgeworld.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;


SET IDENTITY_INSERT fudgeworld.DimProduct ON
;
INSERT INTO fudgeworld.DimProduct (ProductKey, ProductID, ProductName, ProductDepartment, ProductSource, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown', '?', 'Unknown', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudgeworld.DimProduct OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeworld].[Product]'))
DROP VIEW [fudgeworld].[Product]
GO
CREATE VIEW [fudgeworld].[Product] AS 
SELECT [ProductKey] AS [ProductKey]
, [ProductID] AS [ProductID]
, [ProductName] AS [ProductName]
, [ProductDepartment] AS [ProductDepartment]
, [ProductSource] AS [ProductSource]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM fudgeworld.DimProduct
GO





/* Drop table fudgeworld.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeworld.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeworld.DimDate 
;

/* Create table fudgeworld.DimDate */
CREATE TABLE fudgeworld.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  datetime   NULL
,  [FullDateUSA]  nchar(11)   NOT NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  int   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  int   NOT NULL
,  [IsAWeekday]  varchar(1)  DEFAULT 'N' NOT NULL
, CONSTRAINT [PK_fudgeworld.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;


INSERT INTO fudgeworld.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsAWeekday)
VALUES (-1, '', 'Unk date', 0, 'Unk day', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, '?')
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeworld].[Date]'))
DROP VIEW [fudgeworld].[Date]
GO
CREATE VIEW [fudgeworld].[Date] AS 
SELECT [DateKey] AS [DateKey]
, [Date] AS [Date]
, [FullDateUSA] AS [FullDateUSA]
, [DayOfWeek] AS [DayOfWeek]
, [DayName] AS [DayName]
, [DayOfMonth] AS [DayOfMonth]
, [DayOfYear] AS [DayOfYear]
, [WeekOfYear] AS [WeekOfYear]
, [MonthName] AS [MonthName]
, [MonthOfYear] AS [MonthOfYear]
, [Quarter] AS [Quarter]
, [QuarterName] AS [QuarterName]
, [Year] AS [Year]
, [IsAWeekday] AS [IsAWeekday]
FROM fudgeworld.DimDate
GO

ALTER TABLE fudgeworld.FactSales ADD CONSTRAINT
   FK_fudgeworld_FactSales_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES fudgeworld.DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudgeworld.FactSales ADD CONSTRAINT
   FK_fudgeworld_FactSales_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES fudgeworld.DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudgeworld.FactSales ADD CONSTRAINT
   FK_fudgeworld_FactSales_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES fudgeworld.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudgeworld.FactSales ADD CONSTRAINT
   FK_fudgeworld_FactSales_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES fudgeworld.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 

