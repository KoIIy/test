CREATE DATABASE [Traider01]
GO
USE [Traider01]
GO
CREATE TABLE [Role](
[Id] INT PRIMARY KEY IDENTITY,
[Value]NVARCHAR(50) NOT NULL
);
GO
CREATE TABLE [User]( 
[Id] INT PRIMARY KEY IDENTITY,
[FirstName]NVARCHAR(100) NOT NULL,
[MidleName]NVARCHAR(100),
[LastName]NVARCHAR(100)NOT NULL,
[Login]NVARCHAR (320) NOT NULL,
[Passwqord]NVARCHAR (320) NOT NULL,
[RoleID] INT FOREIGN KEY REFERENCES[Role](Id) NOT NULL
);

CREATE TABLE [City](
[Id] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR (100) NOT NULL
);
GO
CREATE TABLE [Street](
[Id] INT PRIMARY KEY IDENTITY,
[Name]NVARCHAR(100) NOT NULL,
[CityId] INT FOREIGN KEY REFERENCES [City](Id) NOT NULL
);
GO
CREATE TABLE [Adres](
[ID] INT PRIMARY KEY IDENTITY,
[PostCode] NVARCHAR (6)NOT NULL,
[StreetId] INT FOREIGN KEY REFERENCES [Street](Id) NOT NULL, 
[HomeNumber]NVARCHAR (5) NOT NULL, 
[Apartmentnumber] NVARCHAR (5)
);
GO
CREATE TABLE [Company](
[Id]INT PRIMARY KEY IDENTITY,
[Name]NVARCHAR (100) NOT NULL,
[INN]NVARCHAR (12) NOT NULL,
[AdresId] INT FOREIGN KEY REFERENCES [Adres](Id) NOT NULL
);
GO
CREATE TABLE [Contract](
[Number] INT PRIMARY KEY ,
[UserId] INT FOREIGN KEY REFERENCES[User](Id) NOT NULL,
[CompanyId] INT FOREIGN KEY REFERENCES[Company](Id) NOT NULL,
[Date] DATE NOT NULL
);
GO
CREATE TABLE [Tovar](
[ID] INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(150) NOT NULL
);
CREATE TABLE [Order](
[ContractID] INT REFERENCES[Contract](Number) NOT NULL,
[TovarID] INT REFERENCES [Tovar](ID) NOT NULL,
PRIMARY KEY(ContractID,TovarID),
[Amount] INT NOT NULL,
[Profit] DECIMAL(15,2) NOT NULL
);
GO
--Функция возвращает id клиента который заключил самое большее количество сделок
CREATE FUNCTION BestClient()
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
--Проверка функции BestClient()
DECLARE @ID TINYINT
SELECT @ID = dbo.BestClient();
PRINT (@ID);
GO
--Функции которая возвращает количество контрактов заключонных в один день
CREATE FUNCTION [ClientAndDate](
@clientid INT,
@date DATE
)
RETURNS INT
	BEGIN
		DECLARE @count INT
		SELECT @count = COUNT([Contract].[UserId])
		FROM [Contract]
		WHERE [Contract].UserId = @clientid AND [Contract].[Date] = @date
		RETURN @count
	END;
GO
--Функция возвращает ФИО сотрудника заключившего сделку с самым большим значением прибыли
CREATE FUNCTION [BestProfitUser]()
RETURNS TABLE
AS
RETURN ( SELECT  [User].[LastName],[User].FirstName,[User].MidleName
		FROM [User],(  SELECT TOP(1) [Order].ContractID ,[Contract].UserId,SUM([Order].Profit) AS Prof
											FROM [Order],[Contract]
											WHERE [Contract].Number = [Order].ContractID
											GROUP BY [Order].ContractID,[Contract].UserId , [Order].Profit
											ORDER BY SUM([Order].Profit) DESC ) AS Profit
		WHERE  Profit.UserId = [User].Id
		)

GO
--Процедура добавления информации о товаре
CREATE PROC [AddTovar]
@name NVARCHAR(150)
AS
INSERT INTO Tovar([Name]) VALUES(@name)
GO
--Процедура добавления информации о заказе
CREATE PROC[AddOrder]
@contractid INT,
@tovarid INT,
@amount INT,
@profit DECIMAL(15,2)
AS
INSERT INTO [Order](ContractID,TovarID,Amount,Profit) VALUES(@contractid,@tovarid,@amount,@profit)
GO
--Процедура добавления информации о Контракте
CREATE PROC [AddContract]
@number INT,
@userid INT,
@companyid INT,
@date DATE
AS
INSERT INTO [Contract](Number,UserId,CompanyId,[Date]) VALUES (@number,@userid,@companyid,@date)
GO

