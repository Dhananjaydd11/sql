/*  PROJECT ON "Fictional Online Retail Company"  part 1
==================================================================================
We'll develop a project for a "Fictional Online Retail Company". 
This project will cover creating a database, tables, and indexes, inserting data,
and writing various queries for reporting and data analysis.
==================================================================================

Project Overview: Fictional Online Retail Company
--------------------------------------
A.	Database Design
	-- Database Name: OnlineRetailDB

B.	Tables:
	-- Customers: Stores customer details.
	-- Products: Stores product details.
	-- Orders: Stores order details.
	-- OrderItems: Stores details of each item in an order.
	-- Categories: Stores product categories.

C.	Insert Sample Data:
	-- Populate each table with sample data.

D. Write Queries:
	-- Retrieve data (e.g., customer orders, popular products).
	-- Perform aggregations (e.g., total sales, average order value).
	-- Join tables for comprehensive reports.
	-- Use subqueries and common table expressions (CTEs).
*/

/* LET'S GET STARTED */

CREATE DATABASE OnlineRetailSDB;
GO

-- Use the database
USE OnlineRetailSDB;
GO

-- Create the Customers table
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Email NVARCHAR(100),
	Phone NVARCHAR(50),
	Address NVARCHAR(255),
	City NVARCHAR(50),
	State NVARCHAR(50),
	ZipCode NVARCHAR(50),
	Country NVARCHAR(50),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create the Products table
CREATE TABLE Products (
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	ProductName NVARCHAR(100),
	CategoryID INT,
	Price DECIMAL(10,2),
	Stock INT,
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create the Categories table
CREATE TABLE Categories (
	CategoryID INT PRIMARY KEY IDENTITY(1,1),
	CategoryName NVARCHAR(100),
	Description NVARCHAR(255)
);

-- Create the Orders table
CREATE TABLE Orders (
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT,
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount DECIMAL(10,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create the OrderItems table
CREATE TABLE OrderItems (
	OrderItemID INT PRIMARY KEY IDENTITY(1,1),
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Price DECIMAL(10,2),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert sample data into Categories table
INSERT INTO Categories (CategoryName, Description) 
VALUES 
('Electronics', 'Devices and Gadgets'),
('Clothing', 'Apparel and Accessories'),
('Books', 'Printed and Electronic Books');

-- Insert sample data into Products table
INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES 
('Smartphone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

-- Insert sample data into Customers table
INSERT INTO Customers(FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country)
VALUES 
('Sameer', 'Khanna', 'sameer.khanna@example.com', '123-456-7890', '123 Elm St.', 'Springfield', 
'IL', '62701', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak St.', 'Madison', 
'WI', '53703', 'USA'),
('Harshad', 'Patel', 'harshad.patel@example.com', '345-678-9012', '789 Dalal St.', 'Mumbai', 
'Maharashtra', '41520', 'INDIA');

-- Insert sample data into Orders table
INSERT INTO Orders(CustomerID, OrderDate, TotalAmount)
VALUES 
(1, GETDATE(), 719.98),
(2, GETDATE(), 49.99),
(3, GETDATE(), 44.98);

-- Insert sample data into OrderItems table
INSERT INTO OrderItems(OrderID, ProductID, Quantity, Price)
VALUES 
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 4, 1, 49.99),
(3, 5, 1, 14.99),
(3, 6, 1, 29.99);

SELECT * FROM[dbo].[Categories]
SELECT * FROM [dbo].[Customers]
SELECT * FROM [dbo].[OrderItems]
SELECT * FROM[dbo].[Orders]
SELECT * FROM[dbo].[Products]

--QUERY 1:- Retrieve all order for a specific customer - --- in this qution information regarding customer like (name ,id or information will be given)


SELECT O.ORDERID,O.OrderDate,O.TotalAmount,OI.ProductID,P.ProductName,OI.Quantity,OI.Price 
FROM Orders O
JOIN OrderItems OI
ON O.OrderID = OI.OrderID
JOIN PRODUCTS P 
ON OI.ProductID = P.ProductID
WHERE O.CustomerID = 1

--QUERY 2 :- FIND THE TOTAL SALES FOR EACH PRODUCT


SELECT 
    P.ProductID,
    P.ProductName,
    SUM(OI.Quantity * OI.Price) AS TotalSales
FROM 
    OrderItems OI
JOIN 
    Products P ON OI.ProductID = P.ProductID
GROUP BY 
    P.ProductID,
    P.ProductName
ORDER BY TOTALSALES  

--QUERY 3:- CALCULATE  THE AVERAGE ORDER VALUE

SELECT AVG(TOTALAMOUNT) AVG_ORDER FROM  Orders

--QUERY 4:- LIST THE TOP 5 CUSTOMER BY TOTAL SPENDING

SELECT TOP 5
    C.CustomerID,
    C.FirstName,
    C.LastName,
    SUM(O.TotalAmount) AS TotalSpending
FROM 
    Customers C
JOIN 
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY 
    C.CustomerID,
    C.FirstName,
    C.LastName
ORDER BY 
    TotalSpending DESC;
	/*OR */
SELECT 
    C.CustomerID,
    C.FirstName,
    C.LastName,
    SUM(O.TotalAmount) AS TotalSpending
FROM 
    Customers C
JOIN 
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY 
    C.CustomerID,
    C.FirstName,
    C.LastName
ORDER BY 
    TotalSpending DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

--QUERY 5:- Retrieve the most popular product category

select top 1 c.CategoryID,c.CategoryName, sum(oi.Quantity) as totalquantity  from OrderItems oi
join PRODUCTS p 
on oi .ProductID = p.ProductID
join Categories c
on p.CategoryID = c.CategoryID
group by c.CategoryID,c.CategoryName
order by totalquantity desc

/*or*/

select CategoryID,categoryname,totalquantity,rn from (
select c.CategoryID,c.CategoryName, sum(oi.Quantity) as totalquantity,ROW_NUMBER()over(order by sum(oi.quantity)desc )as rn
from OrderItems oi
join PRODUCTS p 
on oi.ProductID = p.ProductID
join Categories c 
on p.CategoryID = c.CategoryID
group by c.CategoryID,c.CategoryName) sub
where rn = 1


select * from PRODUCTS
--insert product with zero stock 
insert into PRODUCTS(productname,categoryid,price,stock) values ('keyboard',1,39.99,0)

--Queary 6:- list all product that are our of stock
select * from PRODUCTS
where stock = 0;

/* or*/
select p.ProductID,p.ProductName,c.CategoryName,p.Stock  from Products p 
join Categories c
on p.CategoryID = c. CategoryID
where stock = 0

--queary 7:- find customers who placed order in last 30 days 

SELECT C.CustomerID,C.FirstName,C.LastName,C.Phone,C.Email FROM CUSTOMERS C 
JOIN Orders O 
ON C.CustomerID = O.OrderID
WHERE O.OrderDate >= DATEADD(DAY,-30,GETDATE())


--QUEARY 8:- CALCULATER TOTAL NUMBER ORDER PLASED EACH MONTH


SELECT
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    COUNT(*) AS TotalOrders
FROM 
    Orders
GROUP BY 
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY 
    OrderYear,
    OrderMonth;

--QUEARY 9:- RETREIVE THE DETAILS OF MOST RECENT ORDER

SELECT TOP 1 O.OrderID,O.OrderDate,O.TotalAmount,C.FirstName,C.LastName 
FROM Orders O
  JOIN CUSTOMERS C
ON O.CustomerID = C.CustomerID
ORDER BY O.OrderDate DESC

--QUEARY 10:-  FIND	THE AVERAGE PRICE OF PRODUCT IN  EACH CATEGORY 

SELECT C.CategoryID,C.CategoryName,AVG(P.Price) AS AVGPRICE FROM PRODUCTS P 
JOIN Categories C
ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName,C.CategoryID


--QUEARY 11:- LIST CUSTOMERS WHO HAVE NEVER PLACED AN ORDER
SELECT * FROM CUSTOMERS

SELECT C.CUSTOMERID,C.FIRSTNAME,C.LASTNAME,C.EMAIL,C.PHONE,O.TotalAmount,O.OrderID
FROM CUSTOMERS C 
FULL JOIN ORDERS O 
ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL

--QUEARY 12:- RETRIVE THE TOTAL QUANTITY SOLD FOR EACH PRODUCT 
SELECT P.ProductID,P.ProductName,SUM(OI.Quantity)AS TOTALQUANTITY FROM PRODUCTS P
JOIN OrderItems OI
ON P.ProductID = OI.ProductID
GROUP BY P.ProductID,P.ProductName

--QUEARY 13:- CALCULATE THE TOTAL REVENUE GENERATED FROM EACH CATEGORY

SELECT C.CategoryID,C.CategoryName,SUM(OI.Quantity*OI.Price)AS TOTALREVENUE 
FROM OrderItems OI
JOIN PRODUCTS P
ON P.ProductID = OI.ProductID
JOIN Categories C
ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID,C.CategoryName
ORDER BY TOTALREVENUE DESC

--QUEAERY 14:- FIND THE HIGHT - PRICED IN PRODUCT IN EACH CATEGORY
 
WITH RankedProducts AS (
    SELECT P.ProductID, P.ProductName, P.CategoryID, P.Price, C.CategoryName,
        ROW_NUMBER() OVER (PARTITION BY P.CategoryID ORDER BY P.Price DESC) AS Rank
    FROM 
        Products P
    JOIN 
        Categories C ON P.CategoryID = C.CategoryID
)
SELECT 
    CategoryID,CategoryName, ProductID,ProductName,Price
FROM 
    RankedProducts
WHERE 
    Rank = 1;

	/* OR */

SELECT C.CategoryID,C.CategoryName,P1.ProductID,P1.ProductName,P1.Price
FROM Categories C 
JOIN PRODUCTS P1
ON C.CategoryID = P1.CategoryID
WHERE P1.Price=(SELECT MAX(PRICE)FROM PRODUCTS P2 WHERE P2.CategoryID = P1.CategoryID)
ORDER BY P1.Price DESC

--QUEARY 15:- RETRIEVE ORDER WITH A TOTAL AMOUNT GREATER THAN A SPECIFIC VALUE(e.g.,$500)
SELECT O.OrderID,C.CustomerID,C.FirstName,C.LastName,O.TotalAmount FROM Orders O 
JOIN Customers C 
ON O.CustomerID = C.CustomerID
WHERE O.TotalAmount > 500

--QUEARY 16:- LIST PRODUCT ALONG WITH THE NUMBER OF ORDERS THEY APPEAR IN 
select * from Orders
select * from OrderItems

SELECT P.PRODUCTID, P.PRODUCTNAME,COUNT(OI.ORDERID) AS ORDERCOUNT 
FROM PRODUCTS P JOIN OrderItems OI
ON P.ProductID = OI.ProductID
GROUP BY P.ProductID,P.ProductName


--QUEARY 17:- FIND THE TOP 3 MOST FREQUENTLY ORDERED PEODUCTS

SELECT TOP 3 P.PRODUCTID, P.PRODUCTNAME, COUNT(OI.ORDERID) AS ORDERCOUNT FROM OrderItems OI
JOIN PRODUCTS P 
ON P.ProductID = OI.ProductID
GROUP BY P.ProductID,P.ProductName
ORDER BY ORDERCOUNT DESC

--QUEARY 18:-CALCULATE THE TOTAL NUMBER OF CUSTOMERS FROM EACH COUNTRY

SELECT COUNTRY , COUNT(CustomerID)AS TOTAL_CUSTOMERS
FROM CUSTOMERS
GROUP BY COUNTRY


--QUEARY 19 :- RETRIEVE THE LIST OF CUSTOMERS ALONG WITH THIER TOTAL SPENDING

SELECT C.CUSTOMERID,C.FirstName, SUM(O.TOTALAMOUNT) AS TOTAL_SPENDING 
FROM CUSTOMERS C
JOIN Orders O 
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID,C.FirstName

--QUEARY 20:- LIST ORDERS WITH MORE THAN A SPECIFIEED NUMBER OF ITEMS (e.g., 5 ITEMS)
SELECT O.ORDERID,C.CUSTOMERID,C.FIRSTNAME,C.LASTNAME,COUNT(OI.ORDERITEMID)AS NUMBEROFITEMS
FROM Orders O JOIN OrderItems OI
ON O.OrderID = OI.OrderID
JOIN CUSTOMERS C
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID,O.OrderID,C.FirstName,C.LastName
HAVING COUNT(OI. OrderItemID) >= 1----------------NUMBER OF ITEMS ARE ONLY 1 OR 2
ORDER BY NUMBEROFITEMS

/* OR */

-- Define the threshold for the number of items
DECLARE @Threshold INT = 5;

-- Query to list orders with more than the specified number of items
SELECT 
    O.OrderID,
    O.CustomerID,
    O.OrderDate,
    SUM(OI.Quantity) AS TotalItems
FROM 
    Orders O
JOIN 
    OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY 
    O.OrderID,
    O.CustomerID,
    O.OrderDate
HAVING 
    SUM(OI.Quantity) > @Threshold
ORDER BY 
    TotalItems DESC;

/*
===========================
LOG MAINTENANCE
===========================
Let's create additional queries that involve updating, deleting, and maintaining logs of these operations 
in the OnlineRetailDB database. 

To automatically log changes in the database, you can use triggers in SQL Server. 
Triggers are special types of stored procedures that automatically execute in response 
to certain events on a table, such as INSERT, UPDATE, or DELETE.

Here’s how you can create triggers to log INSERT, UPDATE, and DELETE operations 
for the tables in the OnlineRetailDB.

We'll start by adding a table to keep logs of updates and deletions.

Step 1: Create a Log Table
Step 2: Create Triggers for Each Table
	
	A. Triggers for Products Table
		-- Trigger for INSERT on Products table
		-- Trigger for UPDATE on Products table
		-- Trigger for DELETE on Products table

	B. Triggers for Customers Table
		-- Trigger for INSERT on Customers table
		-- Trigger for UPDATE on Customers table
		-- Trigger for DELETE on Customers table
*/

-create A LOG TABLE 

CREATE TABLE CHANGELOG
(
LOGID INT PRIMARY KEY IDENTITY(1,1),
TABLENAME NVARCHAR (50),
OPERATION NVARCHAR (50),
RECORDID INT,
CHANGEDATE DATETIME DEFAULT GETDATE(),
CHAGEDBY NVARCHAR(100)
)

--A.TRIGGERS FOR PRODDUCTS TABLE
-- TRIGGER FOR INSERT ON PRODUCTS TABLE

CREATE TRIGGER TRG_INSERT_PRODUCT
ON PRODUCTS
AFTER INSERT
AS
BEGIN

---INSERT A RECORD INTO CHANGELOG TABLE
   INSERT INTO CHANGELOG (TABLENAME,OPERATION,RECORDID,CHAGEDBY)
   SELECT 'PRODUCTS','INSERT',inserted.PRODUCTID,SYSTEM_USER
   FROM inserted;

--DISPLAY A MESSAGE INDIACTING THAT THE TRIGGER HAS FIRED
PRINT 'INSERT OPERATION LOOGED FOR PRODUCTS TABLE'
   END
GO

--TRY TO INSERT ONE RECORD INTO PRODUCT TABLE
INSERT INTO PRODUCTS (ProductName,CategoryID,Price,Stock) 
VALUES ('WIRELESS MOUSE',1,4.99,20);

INSERT INTO PRODUCTS (ProductName,CategoryID,Price,Stock) 
VALUES ('spiderman multiverse comic',3,2.50,150);

SELECT * FROM PRODUCTS
SELECT * FROM CHANGELOG

--trigger on update on product table

CREATE OR ALTER TRIGGER TRG_UPDATE_PRODUCT
ON PRODUCTS
AFTER UPDATE
AS
BEGIN
INSERT INTO CHANGELOG (TABLENAME,OPERATION,RECORDID,CHAGEDBY)
SELECT 'PRODUCTS','UPDATE',inserted.ProductID,SYSTEM_USER
FROM INSERTED

PRINT 'UPDATE OPREATION LOGGED FOR PRODUCT TABLE'
END

UPDATE PRODUCTS SET Price = 550
WHERE ProductID = 2


-- TRIGGER FOR DELETE A RECORD FROM PRODUCT TABLE

CREATE OR ALTER TRIGGER TRG_DELETE_PRODUCTS
ON PRODUCTS
AFTER DELETE
AS 
BEGIN
 INSERT INTO CHANGELOG(TABLENAME,OPERATION,RECORDID,CHAGEDBY)
 SELECT 'PRODUCTS','DELETE',deleted.PRODUCTID,SYSTEM_USER
 FROM deleted
 
 PRINT 'GIVEN RECORD HAS BEN DELETED'
 END


 DELETE FROM PRODUCTS WHERE ProductID = 10

 SET NOCOUNT ON; --- WHEN QUERY IS EXECUTE THAT TIME ROW AFTECTED IS COMMING FOR OFF THAT WE CAN USE THIS FUNCTION

 SELECT * FROM PRODUCTS
 SELECT * FROM CHANGELOG


 --B. Triggers for Customers Table
		-- Trigger for INSERT on Customers table
		-- Trigger for UPDATE on Customers table
		-- Trigger for DELETE on Customers table

		SELECT * FROM CUSTOMERS
-- Trigger for INSERT on Customers table

CREATE OR ALTER TRIGGER TR_INSERT_CUSTOMERS
ON CUSTOMERS
AFTER INSERT
AS 
BEGIN
    INSERT INTO CHANGELOG (TABLENAME, OPERATION, RECORDID, CHANGEDATE, CHAGEDBY)
    SELECT 
        'CUSTOMERS',
        'INSERT',
        INSERTED.CUSTOMERID,
        GETDATE(), -- Current date and time
        SYSTEM_USER
    FROM 
        INSERTED;

    PRINT 'DATA IS INSERTED ON CUSTOMERS_TABLE'
END;
GO

-- Trigger for UPDATE on Customers table

CREATE OR ALTER TRIGGER TRg_UPDATE_CUSTOMERS
ON CUSTOMERS
AFTER UPDATE
AS 
BEGIN
    INSERT INTO CHANGELOG (TABLENAME,OPERATION,RECORDID,CHAGEDBY,CHANGEDATE)
     SELECT 
	 'CUSTOMERS',
	 'UPDATE',
	 INSERTED.CUSTOMERID,SYSTEM_USER
FROM INSERTED

PRINT 'DATA IS UPDATED IN CUSTOMERS TABLE'
END
GO

-- Trigger for DELETE on Customers table
CREATE OR ALTER TRIGGER TRG_DELETE_CUSTOMERS
ON CUSTOMERS
AFTER DELETE
AS 
BEGIN
INSERT INTO CHANGELOG(TABLENAME,OPERATION,RECORDID,CHAGEDBY)
SELECT 'CUSTOMERS','DELETE',deleted.CUSTOMERID,SYSTEM_USER
FROM deleted

PRINT ' DATA IS DELETED FROM CUSTOMER TABLE'
END

--TRY TO INSERT A NEW  RECORD TO SEE THE EFFECT OF TRIGGE IN TO  CUSTOMERS TABLE


INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country)
VALUES ('VIRAT', 'KOHLI', 'VIRAT.KINGKOHLI@EXAMPLE.COM', '123-456-7890', 'SOUTH DELHI', 'Delhi', 'DELHI', '110001', 'INDIA');



SELECT * FROM CHANGELOG
SELECT * FROM CUSTOMERS


--UPDATE CYSTOMER TABLES
UPDATE CUSTOMERS SET Address = '120 DELHI'
WHERE FirstName = 'VIRAT'

--DELETE FROM CUSTOMERS TABLES

DELETE CUSTOMERS WHERE CustomerID = 11


------------------- index ----------------------------------------------------
/* project  PROJECT ON "Fictional Online Retail Company" part 2 */

use OnlineRetailSDB

/*
===============================
Implementing Indexes
===============================

Indexes are crucial for optimizing the performance of your SQL Server database, 
especially for read-heavy operations like SELECT queries. 

Let's create indexes for the OnlineRetailDB database to improve query performance.

A. Indexes on Categories Table
	1. Clustered Index on CategoryID: Usually created with the primary key.
*/

create clustered index IDX_CATEGORIES_CATEGORYID-----------Cannot create more than one clustered index on table
ON CATEGORIES (CATEGORYID);
GO

/*
B. Indexes on Products Table
	1. Clustered Index on ProductID: This is usually created automatically when 
	   the primary key is defined.
	2. Non-Clustered Index on CategoryID: To speed up queries filtering by CategoryID.
	3. Non-Clustered Index on Price: To speed up queries filtering or sorting by Price.
*/

--DROP FOREIGN KEY CONSTRAIN FROM ORERITEM TABLE
ALTER TABLE ORDERITEMS DROP CONSTRAINT FK__OrderItem__Produ__46E78A0C

--CLUSTERED INDEX ON PRODUCT TABLE ( PRODUCT ID)

CREATE CLUSTERED INDEX IDX_PRODUCTS_PRODUCTID
ON PRODUCTS(PRODUCTID)
GO

-- Non-Clustered Index on CategoryID: To speed up queries filtering by CategoryID.
CREATE NONCLUSTERED INDEX IDX_PRODUCTS_CATEGORYID
ON PRODUCTS(CATEGORYID)
GO

--Non-Clustered Index on Price: To speed up queries filtering or sorting by Price.

CREATE NONCLUSTERED INDEX IDX_PRODUCTS_PRICE
ON PRODUCTS(PRICE)
GO

--RECREATE FORGEIGN KEY CONSTRAINT ON ORDERITEMS ( PRODUCT ID COLUMN)

ALTER TABLE ORDERITEMS ADD CONSTRAINT FK_ORDERSITEMS_PRODUCTS
FOREIGN KEY (PRODUCTID) REFERENCES PRODUCTS(PRODUCTID)
GO

/*
C. Indexes on Orders Table
	1. Clustered Index on OrderID: Usually created with the primary key.
	2. Non-Clustered Index on CustomerID: To speed up queries filtering by CustomerID.
	3. Non-Clustered Index on OrderDate: To speed up queries filtering or sorting by OrderDate.
*/

---- Drop Foreign Key Constraint from OrderItems Table - OrderID

ALTER TABLE ORDERITEMS DROP CONSTRAINT [FK__OrderItem__Order__47DBAE45]

--1. Clustered Index on OrderID: Usually created with the primary key.

CREATE CLUSTERED INDEX IDX_ORDER_ORDERID
ON ORDERS(ORDERID);
GO

--2. Non-Clustered Index on CustomerID: To speed up queries filtering by CustomerID.

CREATE NONCLUSTERED INDEX IDX_ORDES_CUSTOMERID
ON ORDERS(CUSTOMERID)
GO

--3. Non-Clustered Index on OrderDate: To speed up queries filtering or sorting by OrderDate.

CREATE NONCLUSTERED INDEX IDX_ORDERS_ORDERDATE
ON ORDERS(ORDERDATE)
GO

--RECREATE FOREIGN KEY CONSTRAIN ON ORDERITEM (ORDERID)

ALTER TABLE ORDERITEMS ADD CONSTRAINT FK_ORDERITEM_ORDERID
FOREIGN KEY (ORDERID) REFERENCES  ORDERS(ORDERID)
/*
D. INDEXES ON ORDERITEM TABLEBY ORDER
1.CLUSTERED INDEX ON ORDERITEMID : USUALLY CREATED WITH THE PRIMARY KEY.
2.NON-CLUSTERED INDEX ON ORDERID: TO SPEED UP QUARIES FILTERING BY ORERID.
3.NON-CLUSTERED INDEX ON PRODUCTID: TO SPEED UP QUERIES FILTERING BY PRODUCTID
*/

--CLUSTER INDEX IN ORDERID

CREATE CLUSTERED INDEX IDX_ORDERITEMS_ORDERITEMSID
ON ORDERITEMS(ORDERITEMID)

--NON-CLUSTER INDEX ON ORDERID : TO SPEED UP QUERIES FILTERING BY ORDERID

CREATE NONCLUSTERED INDEX IDX_ORDERITEMS_ORDERID
ON ORDERITEMS(ORDERID)

--NON-CLUSTERD INDEX ON PRODUCTID : TO SPEED UP QUERIES FILTERING BY PRODUCTID

CREATE NONCLUSTERED INDEX IDX_ORDERITEMS_PRODUCTID
ON ORDERITEMS(PRODUCTID)

/*
E.INDEXES ON CUSTOMERS TABLE
1.CLUSTERED INDEX ON ORDERITEMID : USUALLY CREATED WITH THE PRIMARY KEY.
2.NON-CLUSTERED INDEX ON ORDERID: TO SPEED UP QUARIES FILTERING BY ORERID.
3.NON-CLUSTERED INDEX ON PRODUCTID: TO SPEED UP QUERIES FILTERING BY PRODUCTID
*/

--DROP FROEIGN KEY CONSTRAIN FROM ORDER TABLE - CUSTOMERID

ALTER TABLE ORDERS DROP CONSTRAINT [FK__Orders__Customer__403A8C7D]

--1.CLUSTERED INDEX ON ORDERITEMID : USUALLY CREATED WITH THE PRIMARY KEY.

CREATE CLUSTERED INDEX IDX_CUSTOMER_CUSTOMERID
ON CUSTOMERS(CUSTOMERID)

--2.NON-CLUSTERED INDEX ON ORDERID: TO SPEED UP QUARIES FILTERING BY ORERID.

CREATE NONCLUSTERED INDEX IDX_CUSTOMER_EMAIL
ON CUSTOMERS(EMAIL)

--3.NON-CLUSTERED INDEX ON PRODUCTID: TO SPEED UP QUERIES FILTERING BY PRODUCTID

CREATE NONCLUSTERED INDEX IDX_CUSTOMER_COUNTRY
ON CUSTOMERS(COUNTRY)


-- RECREATE FORGEIN KEY CONSTRAINT ON ORDERS(CUSTOMER ID )
ALTER TABLE ORDERS ADD CONSTRAINT FK_ORDERS_CUSTOMERID
FOREIGN KEY CUSTOMERID REFERENCES CUSTOIMERS(CUSTOMERID)

--------------------------------------------------------------------------implemening views---------------------------------------------
USE ONLINERETAILSDB

/*
IMPLEMENTING VIEWS

VIEW ARE VIRTUAL TABLES THAT REPRESENT THE RESULT OF A QUERY.
THEY  CAN SIMPLIFY COMPLEX QUERIES AND ENHANCE SECURITY BY RESTRICTING ACCESS TO SPECIFIC DATA.

*/

--VIEW FOR PRODUCT DEATILS : A VIEW COMBINING PRODUCTS WITH CATEGORY NAME.
SELECT * FROM PRODUCTS
go

SELECT * FROM Categories
go

CREATE VIEW VW_productdetails as 
SELECT P.ProductID,P.ProductName,P.Price,P.Stock,C.CategoryName FROM PRODUCTS P
INNER JOIN Categories C
ON P.CategoryID = C.CategoryID
GO

--Display  PRODUCT DETAILS WITH CATEGORY NAME USING VIEW 

SELECT * FROM VW_productdetails
GO

--VIEW FOR CUSTOMER ORDERS: A VIEW TO GET A SUMMARY OF ORDERS PLACED BY EACH CUSTOMER.

CREATE VIEW VW_CUSTOMER_ORDERS AS
SELECT C.CUSTOMERID,C.FIRSTNAME,C.LASTNAME,
COUNT(O.ORDERID) 
AS TOTALORDERS,
SUM(OI.QUANTITY * P.PRICE) AS TOTALAMOUNT
FROM CUSTOMERS C
INNER JOIN 
ORDERS O ON C.CustomerID = O.CustomerID
INNER JOIN OrderItems OI
ON O.OrderID = OI.OrderID
INNER JOIN PRODUCTS P
ON P.ProductID = OI.ProductID
GROUP BY C.CustomerID,C.FirstName,C.LastName
GO

SELECT * FROM VW_CUSTOMER_ORDERS
GO
--VIEW FOR RECENT ORDERS : A VIEW TO DISPLAY ORDERS PLACED IN LAST 30 DAYS
CREATE VIEW VW_RECENTORDERS AS
SELECT O.ORDERID,O.ORDERDATE,C.CUSTOMERID,C.FIRSTNAME,C.LASTNAME,P.PRODUCTNAME,
SUM(OI.QUANTITY * P.PRICE) AS ORDERAMOUNT
FROM CUSTOMERS C
INNER JOIN ORDERS O
ON C.CustomerID = O.CustomerID
INNER JOIN OrderItems OI
ON O.OrderID = OI.OrderID
INNER JOIN PRODUCTS P 
ON P.ProductID = P.ProductID
GROUP BY C.CustomerID,C.FirstName,C.LastName,P.ProductName,O.OrderID,O.OrderDate

SELECT * FROM VW_RECENTORDERS

--query 31. RETRIEVE ALL PROCUCTS WITH CATEGORY NAME 
--USING THE VW_PRODUCTDETAILS VIEW TO GET A LIST OF ALL PRODUCT ALONG WITH THEIR CATEGORY NAMES



SELECT * FROM VW_productdetails

SELECT ProductName,CategoryName FROM VW_productdetails

--QUERY 32. RETRIEVE PRODUCTS WITHIN A SPECIFIC PRICE RANGE
--USING THE  VW_productdetails  VIEW TO FIND PRODUCTS PRICED BETWEEN $10 AND $500

SELECT * FROM VW_productdetails
WHERE PRICE BETWEEN 10 AND  500

--QUERY 33 . COUNT THE NUMBER OF PRODUCTS EACH CATEGORY
--USING THE VW_productdetails VIEW TO COUNT THE NUMBER OF PRODUCTS IN EACH CATEGORY.

SELECT CATEGORYNAME,COUNT(PRODUCTNAME) AS TOTALPRODUCTS FROM VW_productdetails
GROUP BY CATEGORYNAME

--QUERY 34. RETRIVE CUSTOMERS WITH MORE THAN 1 ORDERS
--USING THE VW_COUSTMORER_ORDER VIEW TO FIND CUSTOMER WHO HAVE PLACE MORE THAN 5 ORDERS


SELECT * FROM VW_CUSTOMER_ORDERS

SELECT  * FROM VW_CUSTOMER_ORDERS WHERE TOTALORDERS > 1

--QUERY 35. RETRIVE THE TOTAL AMOUNT SPAIND BY EACH CUSTOMER
--USING THE VW_CUSTOMERS_ORDERS VIEW TO GET THE TOTAL AMOUNT SPENT BY EACH CUSTOMER.

SELECT CUSTOMERID,FIRSTNAME,LASTNAME,TOTALAMOUNT FROM VW_CUSTOMER_ORDERS
ORDER BY TOTALAMOUNT DESC;

--QUERY 36 . RETRIVE RECENT ORDERS ABOVE A CERTRAIN AMOUNT
--USING THE VW_RECENTORDERS VIEW TO FIND RECENT ORDERS WHERE THE TOTAL AMOUNT IS GRATER THAN $1000

SELECT * FROM VW_RECENTORDERS

SELECT * FROM VW_RECENTORDERS WHERE ORDERAMOUNT > 1000

--QUERY 37 . RETRIVE THE LATEST ORDER FOR EACH CUSTOMER 
--USING THE VW_RECENTORDERS VIEW TO FIND THE LAST ORDER PLACED BY EACH CUSTOMER

SELECT RO.ORDERID,RO.ORDERDATE,RO.CUSTOMERID,RO.FIRSTNAME,RO.LASTNAME,RO.ORDERAMOUNT FROM VW_RECENTORDERS RO
INNER JOIN
(SELECT CUSTOMERID,MAX(ORDERDATE)AS LASTERORERDATE FROM VW_RECENTORDERS 
GROUP BY CUSTOMERID)
LATEST
ON RO.CUSTOMERID=LATEST.CUSTOMERID AND RO.ORDERDATE = LATEST.LASTERORERDATE
ORDER BY ORDERDATE DESC

--QUERY 38. RETERIVE PRODUCT IN A SPECIFIC CATEGORY 
S

