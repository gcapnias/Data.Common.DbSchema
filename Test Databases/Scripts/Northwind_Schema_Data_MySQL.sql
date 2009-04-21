# SQL Manager 2005 for MySQL 3.7.0.1
# ---------------------------------------
# Host     : dev2
# Port     : 3306
# Database : Northwind


SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `Northwind`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `Northwind`;

#
# Structure for the `Categories` table : 
#

CREATE TABLE `Categories` (
  `CategoryID` int(10) NOT NULL auto_increment,
  `CategoryName` varchar(15) NOT NULL,
  `Description` longtext,
  `Picture` longblob,
  PRIMARY KEY  (`CategoryID`),
  KEY `CategoryName` (`CategoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `CustomerDemographics` table : 
#

CREATE TABLE `CustomerDemographics` (
  `CustomerTypeID` char(10) NOT NULL,
  `CustomerDesc` longtext,
  PRIMARY KEY  (`CustomerTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Customers` table : 
#

CREATE TABLE `Customers` (
  `CustomerID` char(5) NOT NULL,
  `CompanyName` varchar(40) NOT NULL,
  `ContactName` varchar(30) default NULL,
  `ContactTitle` varchar(30) default NULL,
  `Address` varchar(60) default NULL,
  `City` varchar(15) default NULL,
  `Region` varchar(15) default NULL,
  `PostalCode` varchar(10) default NULL,
  `Country` varchar(15) default NULL,
  `Phone` varchar(24) default NULL,
  `Fax` varchar(24) default NULL,
  PRIMARY KEY  (`CustomerID`),
  KEY `City` (`City`),
  KEY `CompanyName` (`CompanyName`),
  KEY `PostalCode` (`PostalCode`),
  KEY `Region` (`Region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `CustomerCustomerDemo` table : 
#

CREATE TABLE `CustomerCustomerDemo` (
  `CustomerID` char(5) NOT NULL,
  `CustomerTypeID` char(10) NOT NULL,
  PRIMARY KEY  (`CustomerID`,`CustomerTypeID`),
  KEY `FK_CustomerCustomerDemo` (`CustomerTypeID`),
  CONSTRAINT `FK_CustomerCustomerDemo` FOREIGN KEY (`CustomerTypeID`) REFERENCES `customerdemographics` (`CustomerTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_CustomerCustomerDemo_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Employees` table : 
#

CREATE TABLE `Employees` (
  `EmployeeID` int(10) NOT NULL auto_increment,
  `LastName` varchar(20) NOT NULL,
  `FirstName` varchar(10) NOT NULL,
  `Title` varchar(30) default NULL,
  `TitleOfCourtesy` varchar(25) default NULL,
  `BirthDate` datetime default NULL,
  `HireDate` datetime default NULL,
  `Address` varchar(60) default NULL,
  `City` varchar(15) default NULL,
  `Region` varchar(15) default NULL,
  `PostalCode` varchar(10) default NULL,
  `Country` varchar(15) default NULL,
  `HomePhone` varchar(24) default NULL,
  `Extension` varchar(4) default NULL,
  `Photo` longblob,
  `Notes` longtext,
  `ReportsTo` int(10) default NULL,
  `PhotoPath` varchar(255) default NULL,
  PRIMARY KEY  (`EmployeeID`),
  KEY `LastName` (`LastName`),
  KEY `PostalCode` (`PostalCode`),
  KEY `FK_Employees_Employees` (`ReportsTo`),
  CONSTRAINT `FK_Employees_Employees` FOREIGN KEY (`ReportsTo`) REFERENCES `employees` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Region` table : 
#

CREATE TABLE `Region` (
  `RegionID` int(10) NOT NULL,
  `RegionDescription` char(50) NOT NULL,
  PRIMARY KEY  (`RegionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Territories` table : 
#

CREATE TABLE `Territories` (
  `TerritoryID` varchar(20) NOT NULL,
  `TerritoryDescription` char(50) NOT NULL,
  `RegionID` int(10) NOT NULL,
  PRIMARY KEY  (`TerritoryID`),
  KEY `FK_Territories_Region` (`RegionID`),
  CONSTRAINT `FK_Territories_Region` FOREIGN KEY (`RegionID`) REFERENCES `region` (`RegionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `EmployeeTerritories` table : 
#

CREATE TABLE `EmployeeTerritories` (
  `EmployeeID` int(10) NOT NULL,
  `TerritoryID` varchar(20) NOT NULL,
  PRIMARY KEY  (`EmployeeID`,`TerritoryID`),
  KEY `FK_EmployeeTerritories_Territories` (`TerritoryID`),
  CONSTRAINT `FK_EmployeeTerritories_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_EmployeeTerritories_Territories` FOREIGN KEY (`TerritoryID`) REFERENCES `territories` (`TerritoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Shippers` table : 
#

CREATE TABLE `Shippers` (
  `ShipperID` int(10) NOT NULL auto_increment,
  `CompanyName` varchar(40) NOT NULL,
  `Phone` varchar(24) default NULL,
  PRIMARY KEY  (`ShipperID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Orders` table : 
#

CREATE TABLE `Orders` (
  `OrderID` int(10) NOT NULL auto_increment,
  `CustomerID` char(5) default NULL,
  `EmployeeID` int(10) default NULL,
  `OrderDate` datetime default NULL,
  `RequiredDate` datetime default NULL,
  `ShippedDate` datetime default NULL,
  `ShipVia` int(10) default NULL,
  `Freight` decimal(19,4) default '0.0000',
  `ShipName` varchar(40) default NULL,
  `ShipAddress` varchar(60) default NULL,
  `ShipCity` varchar(15) default NULL,
  `ShipRegion` varchar(15) default NULL,
  `ShipPostalCode` varchar(10) default NULL,
  `ShipCountry` varchar(15) default NULL,
  PRIMARY KEY  (`OrderID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `CustomersOrders` (`CustomerID`),
  KEY `EmployeeID` (`EmployeeID`),
  KEY `EmployeesOrders` (`EmployeeID`),
  KEY `OrderDate` (`OrderDate`),
  KEY `ShippedDate` (`ShippedDate`),
  KEY `ShippersOrders` (`ShipVia`),
  KEY `ShipPostalCode` (`ShipPostalCode`),
  CONSTRAINT `FK_Orders_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Orders_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Orders_Shippers` FOREIGN KEY (`ShipVia`) REFERENCES `shippers` (`ShipperID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Suppliers` table : 
#

CREATE TABLE `Suppliers` (
  `SupplierID` int(10) NOT NULL auto_increment,
  `CompanyName` varchar(40) NOT NULL,
  `ContactName` varchar(30) default NULL,
  `ContactTitle` varchar(30) default NULL,
  `Address` varchar(60) default NULL,
  `City` varchar(15) default NULL,
  `Region` varchar(15) default NULL,
  `PostalCode` varchar(10) default NULL,
  `Country` varchar(15) default NULL,
  `Phone` varchar(24) default NULL,
  `Fax` varchar(24) default NULL,
  `HomePage` longtext,
  PRIMARY KEY  (`SupplierID`),
  KEY `CompanyName` (`CompanyName`),
  KEY `PostalCode` (`PostalCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Products` table : 
#

CREATE TABLE `Products` (
  `ProductID` int(10) NOT NULL auto_increment,
  `ProductName` varchar(40) NOT NULL,
  `SupplierID` int(10) default NULL,
  `CategoryID` int(10) default NULL,
  `QuantityPerUnit` varchar(20) default NULL,
  `UnitPrice` decimal(19,4) default '0.0000',
  `UnitsInStock` smallint(5) default '0',
  `UnitsOnOrder` smallint(5) default '0',
  `ReorderLevel` smallint(5) default '0',
  `Discontinued` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`ProductID`),
  KEY `CategoriesProducts` (`CategoryID`),
  KEY `CategoryID` (`CategoryID`),
  KEY `ProductName` (`ProductName`),
  KEY `SupplierID` (`SupplierID`),
  KEY `SuppliersProducts` (`SupplierID`),
  CONSTRAINT `FK_Products_Categories` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Products_Suppliers` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `Order Details` table : 
#

CREATE TABLE `Order Details` (
  `OrderID` int(10) NOT NULL,
  `ProductID` int(10) NOT NULL,
  `UnitPrice` decimal(19,4) NOT NULL default '0.0000',
  `Quantity` smallint(5) NOT NULL default '1',
  `Discount` float NOT NULL default '0',
  PRIMARY KEY  (`OrderID`,`ProductID`),
  KEY `OrderID` (`OrderID`),
  KEY `OrdersOrder_Details` (`OrderID`),
  KEY `ProductID` (`ProductID`),
  KEY `ProductsOrder_Details` (`ProductID`),
  CONSTRAINT `FK_Order_Details_Orders` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Order_Details_Products` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Definition for the `CustOrderHist` procedure : 
#

CREATE PROCEDURE `CustOrderHist`(IN CustomerID CHAR(5))
    DETERMINISTIC
    SQL SECURITY DEFINER
    COMMENT ''
SELECT P.ProductName, SUM(Quantity) as Total
FROM Products P, `Order Details` OD, Orders O, Customers C
WHERE C.CustomerID = CustomerID
      AND C.CustomerID = O.CustomerID
      AND O.OrderID = OD.OrderID
      AND OD.ProductID = P.ProductID
GROUP BY P.ProductName;

#
# Definition for the `CustOrdersDetail` procedure : 
#

CREATE PROCEDURE `CustOrdersDetail`(IN OrderID INTEGER(11))
    NOT DETERMINISTIC
    SQL SECURITY DEFINER
    COMMENT ''
SELECT P.ProductName,
       ROUND(Od.UnitPrice, 2) as UnitPrice,
       Od.Quantity,
       CAST(Discount * 100 as decimal(9,0)) as Discount,
       ROUND(CAST(Od.Quantity * (1 - Discount) * Od.UnitPrice as decimal), 2) as ExtendedPrice
FROM Products P, `Order Details` Od
WHERE Od.ProductID = P.ProductID
      AND Od.OrderID = OrderID;

#
# Definition for the `CustOrdersOrders` procedure : 
#

CREATE PROCEDURE `CustOrdersOrders`(IN CustomerID CHAR(5))
    NOT DETERMINISTIC
    SQL SECURITY DEFINER
    COMMENT ''
SELECT OrderID,
       OrderDate,
       RequiredDate,
       ShippedDate
FROM Orders O
WHERE O.CustomerID = CustomerID
ORDER BY OrderID;

#
# Definition for the `Employee Sales By Country` procedure : 
#

CREATE PROCEDURE `Employee Sales By Country`(IN Beginning_date DATETIME, IN Ending_date DATETIME)
    NOT DETERMINISTIC
    SQL SECURITY DEFINER
    COMMENT ''
SELECT Employees.Country,
       Employees.LastName,
       Employees.`FirstName`,
       Orders.`ShippedDate`,
       Orders.`OrderID`,
       `order subtotals`.`Subtotal` as SaleAmount
FROM Employees
     INNER JOIN (Orders INNER JOIN `order subtotals` ON Orders.OrderID = `order subtotals`.`OrderID`)
           ON Employees.`EmployeeID` = Orders.`EmployeeID`
WHERE Orders.ShippedDate BETWEEN Beginning_Date AND Ending_Date;

#
# Definition for the `Sales by Year` procedure : 
#

CREATE PROCEDURE `Sales by Year`(IN Beginning_Date DATETIME, IN Ending_Date DATETIME)
    NOT DETERMINISTIC
    SQL SECURITY DEFINER
    COMMENT ''
SELECT
      Orders.`ShippedDate`,
      Orders.`OrderID`,
      `Order Subtotals`.Subtotal,
      YEAR(Orders.`ShippedDate`) as Year
FROM  `Orders`
      INNER JOIN `Order Subtotals` ON Orders.OrderID = `Order Subtotals`.OrderID
WHERE Orders.ShippedDate BETWEEN Beginning_Date AND Ending_Date;

#
# Definition for the `SalesByCategory` procedure :
#

DELIMITER $$

CREATE PROCEDURE `SalesByCategory`(IN CategoryName VARCHAR(15), IN OrdYear CHAR(4))
    NOT DETERMINISTIC
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
     IF (OrdYear <>  '1996' AND OrdYear <> '1997' AND OrdYear <> '1998')
        THEN SELECT OrdYear = '1998';
     END IF;

     SELECT
            P.`ProductName`,
            ROUND(SUM(CAST(OD.Quantity * (1 - OD.Discount) * OD.UnitPrice as DECIMAL(14,2))), 0) as TotalPurchase
     FROM `Order Details` OD, Orders O, Products P, Categories C
     WHERE OD.`OrderID` = O.`OrderID`
           AND OD.`ProductID` = P.`ProductID`
           AND P.`CategoryID` = C.`CategoryID`
           AND C.`CategoryName` = CategoryName
           AND Convert(Year(O.OrderDate), CHAR(4)) = OrdYear
     GROUP BY P.`ProductName`
     ORDER BY P.`ProductName`;
END $$

DELIMITER ;

#
# Definition for the `Ten Most Expensive Products` procedure : 
#

CREATE PROCEDURE `Ten Most Expensive Products`()
    NOT DETERMINISTIC
    SQL SECURITY DEFINER
    COMMENT ''
SELECT
      Products.`ProductName` as TenMostExpensiveProducts,
      Products.`UnitPrice`
FROM  Products
ORDER BY Products.`UnitPrice` DESC
LIMIT 10;

#
# Definition for the `Alphabetical list of products` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Alphabetical list of products` AS
  select 
    `products`.`ProductID` AS `ProductID`,
    `products`.`ProductName` AS `ProductName`,
    `products`.`SupplierID` AS `SupplierID`,
    `products`.`CategoryID` AS `CategoryID`,
    `products`.`QuantityPerUnit` AS `QuantityPerUnit`,
    `products`.`UnitPrice` AS `UnitPrice`,
    `products`.`UnitsInStock` AS `UnitsInStock`,
    `products`.`UnitsOnOrder` AS `UnitsOnOrder`,
    `products`.`ReorderLevel` AS `ReorderLevel`,
    `products`.`Discontinued` AS `Discontinued`,
    `categories`.`CategoryName` AS `CategoryName` 
  from 
    (`categories` join `products` on((`categories`.`CategoryID` = `products`.`CategoryID`))) 
  where 
    (`products`.`Discontinued` = 0);
    
#
# Definition for the `Product Sales for 1997` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Product Sales for 1997` AS
  select
    `categories`.`CategoryName` AS `CategoryName`,
    `products`.`ProductName` AS `ProductName`,
    sum(cast(((((`order details`.`UnitPrice` * `order details`.`Quantity`) * (1 - `order details`.`Discount`)) / 100) * 100) as decimal)) AS `ProductSales`
  from
    ((`categories` join `products` on((`categories`.`CategoryID` = `products`.`CategoryID`))) join (`orders` join `order details` on((`orders`.`OrderID` = `order details`.`OrderID`))) on((`products`.`ProductID` = `order details`.`ProductID`)))
  where
    (`orders`.`ShippedDate` between '19970101' and '19971231')
  group by
    `categories`.`CategoryName`,`products`.`ProductName`;

#
# Definition for the `Category Sales for 1997` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Category Sales for 1997` AS
  select 
    `Product Sales for 1997`.`CategoryName` AS `CategoryName`,
    sum(`Product Sales for 1997`.`ProductSales`) AS `CategorySales`
  from 
    `Product Sales for 1997`
  group by 
    `Product Sales for 1997`.`CategoryName`;

#
# Definition for the `Current Product List` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Current Product List` AS
  select 
    `Product_List`.`ProductID` AS `ProductID`,
    `Product_List`.`ProductName` AS `ProductName` 
  from 
    `products` `Product_List` 
  where 
    (`Product_List`.`Discontinued` = 0);

#
# Definition for the `Customer and Suppliers by City` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Customer and Suppliers by City` AS
  select 
    `customers`.`City` AS `City`,
    `customers`.`CompanyName` AS `CompanyName`,
    `customers`.`ContactName` AS `ContactName`,
    'Customers' AS `Relationship` 
  from 
    `customers` union 
  select 
    `suppliers`.`City` AS `City`,
    `suppliers`.`CompanyName` AS `CompanyName`,
    `suppliers`.`ContactName` AS `ContactName`,
    'Suppliers' AS `Suppliers` 
  from 
    `suppliers`;

#
# Definition for the `Invoices` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Invoices` AS
  select 
    `orders`.`ShipName` AS `ShipName`,
    `orders`.`ShipAddress` AS `ShipAddress`,
    `orders`.`ShipCity` AS `ShipCity`,
    `orders`.`ShipRegion` AS `ShipRegion`,
    `orders`.`ShipPostalCode` AS `ShipPostalCode`,
    `orders`.`ShipCountry` AS `ShipCountry`,
    `orders`.`CustomerID` AS `CustomerID`,
    `customers`.`CompanyName` AS `CustomerName`,
    `customers`.`Address` AS `Address`,
    `customers`.`City` AS `City`,
    `customers`.`Region` AS `Region`,
    `customers`.`PostalCode` AS `PostalCode`,
    `customers`.`Country` AS `Country`,
    ((`employees`.`FirstName` + ' ') + `employees`.`LastName`) AS `Salesperson`,
    `orders`.`OrderID` AS `OrderID`,
    `orders`.`OrderDate` AS `OrderDate`,
    `orders`.`RequiredDate` AS `RequiredDate`,
    `orders`.`ShippedDate` AS `ShippedDate`,
    `shippers`.`CompanyName` AS `ShipperName`,
    `order details`.`ProductID` AS `ProductID`,
    `products`.`ProductName` AS `ProductName`,
    `order details`.`UnitPrice` AS `UnitPrice`,
    `order details`.`Quantity` AS `Quantity`,
    `order details`.`Discount` AS `Discount`,
    cast(((((`order details`.`UnitPrice` * `order details`.`Quantity`) * (1 - `order details`.`Discount`)) / 100) * 100) as decimal) AS `ExtendedPrice`,
    `orders`.`Freight` AS `Freight` 
  from 
    (`shippers` join (`products` join ((`employees` join (`customers` join `orders` on((`customers`.`CustomerID` = `orders`.`CustomerID`))) on((`employees`.`EmployeeID` = `orders`.`EmployeeID`))) join `order details` on((`orders`.`OrderID` = `order details`.`OrderID`))) on((`products`.`ProductID` = `order details`.`ProductID`))) on((`shippers`.`ShipperID` = `orders`.`ShipVia`)));

#
# Definition for the `Order Details Extended` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Order Details Extended` AS
  select 
    `order details`.`OrderID` AS `OrderID`,
    `order details`.`ProductID` AS `ProductID`,
    `products`.`ProductName` AS `ProductName`,
    `order details`.`UnitPrice` AS `UnitPrice`,
    `order details`.`Quantity` AS `Quantity`,
    `order details`.`Discount` AS `Discount`,
    cast(((((`order details`.`UnitPrice` * `order details`.`Quantity`) * (1 - `order details`.`Discount`)) / 100) * 100) as decimal) AS `ExtendedPrice` 
  from 
    (`products` join `order details` on((`products`.`ProductID` = `order details`.`ProductID`)));

#
# Definition for the `Order Subtotals` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Order Subtotals` AS
  select 
    `order details`.`OrderID` AS `OrderID`,
    sum(cast(((((`order details`.`UnitPrice` * `order details`.`Quantity`) * (1 - `order details`.`Discount`)) / 100) * 100) as decimal)) AS `Subtotal` 
  from 
    `order details` 
  group by 
    `order details`.`OrderID`;

#
# Definition for the `Orders Qry` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Orders Qry` AS
  select 
    `orders`.`OrderID` AS `OrderID`,
    `orders`.`CustomerID` AS `CustomerID`,
    `orders`.`EmployeeID` AS `EmployeeID`,
    `orders`.`OrderDate` AS `OrderDate`,
    `orders`.`RequiredDate` AS `RequiredDate`,
    `orders`.`ShippedDate` AS `ShippedDate`,
    `orders`.`ShipVia` AS `ShipVia`,
    `orders`.`Freight` AS `Freight`,
    `orders`.`ShipName` AS `ShipName`,
    `orders`.`ShipAddress` AS `ShipAddress`,
    `orders`.`ShipCity` AS `ShipCity`,
    `orders`.`ShipRegion` AS `ShipRegion`,
    `orders`.`ShipPostalCode` AS `ShipPostalCode`,
    `orders`.`ShipCountry` AS `ShipCountry`,
    `customers`.`CompanyName` AS `CompanyName`,
    `customers`.`Address` AS `Address`,
    `customers`.`City` AS `City`,
    `customers`.`Region` AS `Region`,
    `customers`.`PostalCode` AS `PostalCode`,
    `customers`.`Country` AS `Country` 
  from 
    (`customers` join `orders` on((`customers`.`CustomerID` = `orders`.`CustomerID`)));

#
# Definition for the `Products Above Average Price` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Products Above Average Price` AS
  select 
    `products`.`ProductName` AS `ProductName`,
    `products`.`UnitPrice` AS `UnitPrice` 
  from 
    `products` 
  where 
    (`products`.`UnitPrice` > (
  select 
    avg(`products`.`UnitPrice`) AS `AVG(UnitPrice)` 
  from 
    `products`));

#
# Definition for the `Products by Category` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Products by Category` AS
  select 
    `categories`.`CategoryName` AS `CategoryName`,
    `products`.`ProductName` AS `ProductName`,
    `products`.`QuantityPerUnit` AS `QuantityPerUnit`,
    `products`.`UnitsInStock` AS `UnitsInStock`,
    `products`.`Discontinued` AS `Discontinued` 
  from 
    (`categories` join `products` on((`categories`.`CategoryID` = `products`.`CategoryID`))) 
  where 
    (`products`.`Discontinued` <> 1);

#
# Definition for the `Quarterly Orders` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Quarterly Orders` AS
  select 
    distinct `customers`.`CustomerID` AS `CustomerID`,
    `customers`.`CompanyName` AS `CompanyName`,
    `customers`.`City` AS `City`,
    `customers`.`Country` AS `Country` 
  from 
    (`orders` left join `customers` on((`customers`.`CustomerID` = `orders`.`CustomerID`))) 
  where 
    (`orders`.`OrderDate` between '19970101' and '19971231');

#
# Definition for the `Sales by Category` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Sales by Category` AS
  select 
    `categories`.`CategoryID` AS `CategoryID`,
    `categories`.`CategoryName` AS `CategoryName`,
    `products`.`ProductName` AS `ProductName`,
    sum(`order details extended`.`ExtendedPrice`) AS `ProductSales` 
  from 
    (`categories` join (`products` join (`orders` join `order details extended` on((`orders`.`OrderID` = `order details extended`.`OrderID`))) on((`products`.`ProductID` = `order details extended`.`ProductID`))) on((`categories`.`CategoryID` = `products`.`CategoryID`))) 
  where 
    (`orders`.`OrderDate` between '19970101' and '19971231') 
  group by 
    `categories`.`CategoryID`,`categories`.`CategoryName`,`products`.`ProductName`;

#
# Definition for the `Sales Totals by Amount` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Sales Totals by Amount` AS
  select 
    `order subtotals`.`Subtotal` AS `SaleAmount`,
    `orders`.`OrderID` AS `OrderID`,
    `customers`.`CompanyName` AS `CompanyName`,
    `orders`.`ShippedDate` AS `ShippedDate` 
  from 
    (`customers` join (`orders` join `order subtotals` on((`orders`.`OrderID` = `order subtotals`.`OrderID`))) on((`customers`.`CustomerID` = `orders`.`CustomerID`))) 
  where 
    ((`order subtotals`.`Subtotal` > 2500) and (`orders`.`ShippedDate` between '19970101' and '19971231'));

#
# Definition for the `Summary of Sales by Quarter` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Summary of Sales by Quarter` AS
  select 
    `orders`.`ShippedDate` AS `ShippedDate`,
    `orders`.`OrderID` AS `OrderID`,
    `order subtotals`.`Subtotal` AS `Subtotal` 
  from 
    (`orders` join `order subtotals` on((`orders`.`OrderID` = `order subtotals`.`OrderID`))) 
  where 
    (`orders`.`ShippedDate` is not null);

#
# Definition for the `Summary of Sales by Year` view :
#

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Summary of Sales by Year` AS
  select 
    `orders`.`ShippedDate` AS `ShippedDate`,
    `orders`.`OrderID` AS `OrderID`,
    `order subtotals`.`Subtotal` AS `Subtotal` 
  from 
    (`orders` join `order subtotals` on((`orders`.`OrderID` = `order subtotals`.`OrderID`))) 
  where 
    (`orders`.`ShippedDate` is not null);

#
# Data for the `Categories` table  (LIMIT 0,500)
#

INSERT INTO `Categories` (`CategoryID`, `CategoryName`, `Description`, `Picture`) VALUES 
  (1,'Beverages','Soft drinks, coffees, teas, beers, and ales','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�)\0\0BM�)\0\0\0\0\0\0V\0\0\0(\0\0\0�\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0�
\0\0\b\0\0\0\b\0\0\0���\0\0��\0�\0�\0\0\0�\0��\0\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ppp\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0%67wwwwwwSS\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\045wwwwwwwwwwwwww\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!awwwwuuu555%wwwwwwwP\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Awwsv7cwwWgw u''wwwv4a!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0P6wWuqpP\0\0\0pqwuwwwwS4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0W50\0\0\0\0\0\0\0\0\0\0\0\0\0wwwwG\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 !\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\045\0\0\0\0e45wupGttp\0\0wWwqq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0AGq5u\0 w0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0AvWw \0\0gwwwwe`@@ 746@\0$\0\0\0\0\0\0\0 @\0\0 \0\0Gvww\0 7wWwwwSr\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0vvGg\0\0@\0WtpAgGt!@P\0CA@40\0VQ Q\00\0! pp7wwwwWwwq1wwwwwwuwq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0G@Dq\0twwgwwv\0t%$\0wwwGdgvu `%\0swwwwwwwttw''WGw\0wwwwwg3p0\0\0\0\0\0\0\0\0\0\0\0\0\0\0B` \0wBtwvwwwwugwwtdtefvwwfWFwgWSPqfswws7FwuwwwwW''vw\0Qwwwwgw`q1A\0 \0\0\0\0\0\0\0\0\0\0t@@GvwvwvpggwvtvVsGWPWg7VdtgWwrq%!gqw3w7wgwgugGewWq!7uwwwwgwS\0\0\0\0\0\0\0\0\0 g\0wgGwgvwwVwgwwww$wg`gwtgGGGggwVRVSww7dwwuvuwwtw wwwvww@4\0\0\0\0\0\0\0\0\0\0\0\0\0\0we@f`PwvwewwgtpwGwwgGfF wsvttvwwwgw757wswGwwwwwtwGpq wwvwwv1qsR\0\0\0\0\0\0\0\0\0\0\0\0\00vwWggu pvtwwGtwwttwpGgwegtgwewwwwwwwwww7fwwGetwGwwwwwvvwA7q\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0W D%geav\0gg\0GpGg p gw\0\0GwGsFVDgEgvvwwwwwwwww7Vgwwwwwwwws\0wwwwwwwSR\0\0\0\0\0\0\0\0\0\0wwq!RP0g\0wwGgBpG$wvWudp\0vswGgt''wwwwwwww6wwwwewwwwwwCGwu WwSwvvvwrw1\0\0\0\0\0\0\0\0\0\0\0\0\0qpp @F\0wFvtpwAgt6Vww@ wvt FVwgwwwwwuwww7Gguqaa$400wwwwWwu!\0\0P\0\0\0\0\0\0\0\0\0!\0%gPp C@g\0\0@vp W Wwwgw\0wtGFFegwvwwwwwwwwwswgwa\0\0\07wSP1www7wswPp\0!\0\0\0\0\0\0\0\0\00\0gwwaePG`G`tdwdpVVwgp wduttvwwwwwwwwwss7Gwws5wwwwwwwwWwwwwwgA A\0\0\0\0\0\0\0\0\0\0wtA@\0 @gvvvwgwwdwuggwtGp t fFvGwVwwwwwww7777vFwtwSRwwwgwwwwwcesSSQ00 0\0\0\0\0\0\0\0\0\0 \0\0aGvvtd`@@@@fgvvwwTvwpFdFDDVwggwwwww3ssswgwwgt$Gw7wq''wSWWu4$ @\0\0\0\0\0\0\0\0\0\00\0P\0Ff@\0\0 45!\0egwg wpvwCwggwvwwwww77737VGvW Sw pwwwe%''s\00\0\0\0\0\0\0\0\0\0P\0\0F\0\0%45\0\0\0\0\0 t\0\0wDs777wWgwwwww7777w7egWwww71ggpwwwVqw0\0\0\0!\0\0\0\0\0\0\0\0\0\0 t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 wwwssswgvwwwwwssss3sVwgww7wwwqwtpRqvs@0\0\0\0\0\0\0\0\0\0\0\0\0V`\0\0\0su``\0\0\0\0\0\0\0\0\0\0\0\0\0s ww73777wwGgwwww73sSvfwwwsw7wqgpw57wWG51\0\0\0\0\0\0\0\0\0\0\00\0e@\0\0\0\0T\0\0\0\0\0\0\0\0\0w7wgswsss7wgwwwwwgvFteeugGwwsw0wvVT5''5w\0\0\0\0\0\0\00p@\0f\0\0\0\0\0\0\0@\0\0\0\0\0\0\0\0\0\0\0\0\0wwQFs73sswwwtvwwwwttdGdfgvwwww''vs 7CWGssA\0C\0\0\0\0P\0\0p\0\0\0\0gB\0\0\0\0\0\0\0\0\0\0\0\0 wvgww7sw773swgwwwwwgdVvPutwvWa\0WsWGwcw5RpR\0P!\0\0p!e\0\0\0@\0\0\0\0gv@gvF@\0ACAwwwgfvss73sswwwvvwwwvVGgGFdftwvu''a\0#1!''!a aAs Vw\0\0W\0G@\0G@F\0\0\0FwpPGwvqsW7Vvwvvw7swssswwgwwwwwedtgeGuvwqvp tedts\0\0PRqappwqswt\07p\0\0vg`\0\0\0 @v\0wpgwwwgggggg3s37777wGgwwwwvvwGBFvtvwwgvwga1371%0s wwww\0uwp\0\0\0`v\0\0d\0\0dtg@wwwwvvvvvsw7wsswwwvwwwwwgGFvtgGwwt6pS2SRRq53SSCACqaq0wqwwww\07w\0vvgpGDf@\0Gd\0wtwwwwggggg7s733ssswgFwwwvTggGtvtvSua 1w5su%4stp5010\0Bwwww7w\0Gwwpt`pFDD\0\0F@pvpwwwwvvvvvs7sww77wwvwwwwwfVVeg gvwu p V1S4sps!6CCCC ww7www@%w7p\0''Dp\0@\0\0\0\0d\0d\0g`wwwwggvwgw3s33sswwGgwwwwtgegDdtwgv4wqru7WwuwW5qqqqqqt3aacwwwsW7@ 7w4\0F``\0\0\0\0\0@\0`vtwwwwvvgfvsw7ww777wwGgwwwgVVtgtgewq73Sw7wwwwwwwwwwww7uw7W7ww7sw GwsP\0tF\0D\0\0\0\0\0\0Gw@ ww\0fvwgv3333377wwfvwwwwwftvVFWGg``\0 53u71wwwwwwwwwwwwwww7wsws7Sww@\0qww\0\0f@$d@\0\0\0\0\0dg\0Gww\0wgfvfwwwwwsswwwwwwwvwtFFueggwSSsRSqwwwwwwwwwwwwwwwwSww7Sw7p\0vssP\0\0\0GFdfVFdD\0@d\0\0wp\0ggvww33333777wfvwwwwwgwwfvwegwqq1u!p77wwwwwwwwwwwwu7Sw7Swsww7\0ww\0@ GvgvGfvvgFv\0\0\0w\0\0vvgffwwwwws7wwugwwwww&\0wa557wwwwwwwwwswSwwwwwSw7sStp\0\0PpDfwwwvwwvwwvVf\0\0ggvww311\0wwwfegwugp@@PQ@wwScSqsSqwwwwwwwwwWuwwwwwwwwsSu7w7\0\0\0w`@@@@@F ggwap\0p\0\0q\0\0\0\0\0\0WwvwwvG$\0S\0wq0u57wwwwwqssww7w7wSw752RSvDd&W\0@\0\0\0\0\0\0@@\0vw@\0D\0\0wu\0u\0\0\0\0\0\0\0\0sGvgwted\0\0\0\00RQ50u3 7wwuwwwwwwswwwwswwSup55141q7153\0\0FD\0\0\0D\0\0\0\07p\0\0\0\0\0w41\0\0\0\0\0\0\0\0\0WwwVv`\0p\0\0\0@D!0R153q5ww7w7swuwwwW7Wwww52P1aaqcRW%p\0\0g\0\0B@\0\0\0Rsq\0\0\0\0\0\0uw\0\0\0\0\0\0\0\0\0SwveDt$@\0\0\0@100rSSw7wWwWwSswswwwwwwp543C1q1s7\0\0g\0\0\0\01u`\0\0\0\0\0\0\0 wq!\03uFgGFW p\0 S455u7sssSww7wwwww7SwP3S 5a410p0RSppC7\0\0\0\0\0\0\0\0\0\0w\0\0\0dsssvtVFwwwwsWsQ74511psswswWww7wWsusW7Www43u7ssg0q1cRs17\0\0 ssRq5t\0\0\0\0\0\0\0\0\0\0\0\0F@\0\0\0Fs7774Fdwwwwwt\0 777457sVSsSuwsuswwwwww3SswSWrwSqqcssWw\0\0 57wp\0\0\0\0\0\0\0\0\0\0\0\0`\0@gasssttWwwwwwpc 1!111s7w7www7wwwwwwwwwwu7w7wsw757sWGsswawqgwsW\0\0\0\0\0\0\0\0\0\0\0\0\0@\0\0\03s3FFswwwwwt\0w373\0Sw7wSw7wwwwwwwwwwwswwW7w7wwsgqw7sqgSSC75%w7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0s77D377wwwwp\0 t\0113173sWu7wwwwwwwwwwwwwww7swu7W7776qqe75rsg7GSsqt\0\0\0\0\0\0\0\0\0\0F\0\0\0\0\0\0\0\0ss6Cw3swwwwt 0\0\0\0\0!7377wwwwwwwwwwwwwwwwwWwsswsuuusS''3SSWSW77uv0\0\0\0\0\0\0\0\0\0$@\0\0\0@\0\0 73us3733wwwp\0 \0\0\0\0\0\0\0\0\0pGwwwwwwwwwwwwwwwwwswsuwSussswwwSW''6s77sSW75p\0\0\0\0\0\0\0\0\0@`\0\0\0\0@@s737ssw77wwp\0\0\0\0\0\0\0d7wwwsuwwwwwwwwwwwwwsw77w7www775qqu%sG7!ws@\0\0\0\0\0\0\0\0\0\0dF@\0\0\0\0\0C73s37373s7wq\0\0G4\0ewwGqwuwwwwwwwwwwwwwsuwWw5w5wwWwWsww7w77Wwqwp\0\0\0\0\0f\0\0d\0Gg@\0\0\0\0\0ss773w3ssswt\0wv\0\0\0\0@swwwwwwwwwwwwwwwwww7sw5w7ww7sw7swSqwSWW757q\0\0\0\0\0\0@@\0F@`F\0\0\0\0\0\0 73ss737777wp\0\0twB\0\0\0\0\0CWwwwwwwwwwwwwwwwwwwWwwwwwwwwwwwwwwwsw77uwwp\0\0\0\0\0F\0\0`F\0\0\0\0\0\0\0s7373ssssswv\0\0\0\0\0P6wwwwwwwwwwwwwwwwwwwwswwww7wwwwwwwwwwwwwww7sww\0\0\0\0\0\0\0\0\0\0@\0\0\0@@\0\073sss777777p\0\0\0\0wsWwwwwwwwwwwwwwwwwwwwWwwwww7wW7wWwwuw7wwwwwwwW4\0\0\0\0\0\0\0\0@\0\0\0\0\0\0\0 3s73733ssswu\0\0\0\0\0wwwwwwwwwwwwwwwqwwW7Ww7wwwsWww7ww7swSw7w5sW57W7sp\0\0\0\0\0\0\0F\0@``\0\0\0\0\0\0c73s777w773wp F\0\0\0wwwwwwwwwwwwwwwwsw7wswwswww77u57Su7wwwwwwwww7qwP\0\0\0\0\0\0\0\0\0\0D@D\0@\0\0\0\0cs773s33ss7wtt\0\0\0\0wwwwwwwwwwww7WswwWwqwswsWwwww7wwwwwwwwwwwwwwwwwp@\0\0\0\0\0\0\0\0\0\0f`\0\0\0C733s77s37wwpv\0@@wwwwwwwwwwwwwwusW7Swwwuww7wwwwwwwwwwwwwwwwwwwwww \0\0\0\0\0\0\0\0\0\0@D@\0\0\0\0sss73s77wwww`tf\0wwwwwwwwwwwwwswwwwww7sw7wwwwwww7swww7wwSwwwwwwwwP\0\0\0\0\0\0\0\0\0\0\0F`\0\0\0\0cs73s73swwwwptdp\0wwwwwwwwwwwwwwwwwwwwwwwwwwqsqwwwW7swu7wwwwswWw77\0\0\0\0\0\0\0\0\0\0Dd\0\0F\0\0\0\0\0 3ss73s7wwwsu`v\0wwwwwwwwwwwwwwwwwwwwwwwwwwwww77swsW7u7w5sww7wWwr@\0\0\0\0\0\0\0\0\0`d\0\0\0\0\0\0\0\0s77ss7wwwwsvtd\0@`WwwwwwwwwwwwwwwwwwwwwuwWqs757wWquswSsu7wwWwwwwwP\0\0\0\0\0\0\0\0e@\0\0\0\0\0\0\0\0 3s337wwwwwq`ggGggwwwwwwwwwwwwwwwswwww7w7wwusussw6777Wswsssswwsq \0\0\0\0\0\0\0\0\0F\0\0\0\0\0\0\0\0\0 7777wwwwww7pVGddawwwwwwwwwwwwwuuwwwuuuw5w75775w7WSWcW3WswWwww7wwP\0\0\0\0\0\0\0@d`\0\0\0\0\0\0\0 3s3wwwwwwwq`dv@\0wwwwwwwwWwusWwwwuuw7suwwuswwWw5ssw75w7W 77Wwwsp\0\0\0\0\0\0\0\0FvFVTd\0\0\0\0\0\0 s77wu7wwwwwtGD Fp wwwwwwWwuswsW7qw77wwsww7ssssw5wSSsCpsswWWw757wp\0\0\0\0\0\0gdt&f@\0\0\0\0\0\0s3wpttwwwwwwegd''fwwuu7wWw75wwwWwwwuwwwu7wwwuwWwwswwWw7uwW777wwuwp\0\0\0\0\0\0t `@@\0\0\0\0\0\0\0\0wwqqaswwwsvvfVFGwuswwWw7Wwwqw7wwwww5sWwwsswwwsqsW7w75u777www5w7sp\0@\0\0\0\0\0fBF\0\0\0\0\0\0\0\0www\0vwGwwwwggggG@Wwwwwswwwwwwwwsw5swsww7wwuww7wwwwwuw7wusSu5w5www\0\0\0\0\0\0@@d\0D\0\0\0\0\0\0\0 w7AGugwwwv$vvv`wwwwswwwswswwSwwwwwwwwwwwww7wwww7Sg7su5sgvwgsvsGq@$\0\0\0\0\0\0F@\0f\0\0\0\0\0\0 su  wruwww\0@vgvqwwwWwwwwwwWw7wwWwwu7qwwwwWu555wwwWuwwwSWSsWWsW\0P\0\0\0\0\0\0\0\0@@vDd\0\0\0\0ws@WWwwpD\0vBVwsw7Wu7W5swwww7sw7w7wwwww7wwwwwwqwwwwwwwswWw7uww0\0\0\0@\0\0\0\0\0\0\0\0\0\0g@\0\0\0\0ww%wsgww\0@\0`\0ge7ww7ww7w7wwwsW5wwwwwwwwwwwWwwwwwwwwwwwwwwwwww7sw57p \0@\0\0\0\0\0\0@\0\0@@\0\0\0\0\0\0 wpRWewww\0@@WswW7wwwswwwwwwwwwwwwwwwwwwwwwwwwww777u7wswVWRwwP\0\0\0\0\0\0\0\0\0\0D$$@\0d\0\0\0\0 wr@wWgwp\0`\0 \0susswWu7Suswwwwwwwwwwwwwwwwwww7wsw75wWWwwusWSss7qss\0p\0\0\0\0\0\0\0\0FFD\0\0g$@\0\0\0wu VvWwP\0D@@d@GwswwwswwwwwWwwwwwwwwwwwwwwwuswww7Wsssssssw3wu5u7uw@\0\0\0\0\0\0\0\0\0\0@\0\0@d\0\0\0Gw@wWww\0@BFF7Wwuw7wwwwwwwwww7wwwwwwwwwwwswwWsWW7WWWW%3rsCrw0 \0\0@\0\0\0\0\0\0\0\0\0\0F\0F@\0\0\0 w%%gww\0GB@CswswWwwwwwwwsw7wwusWwwwwwuswssswssww76scrsssSV7qu\0\0\0\0\0\0\0\0\0\0\0F\0\0\0\0\0\0wGwwpv\0eddwwwwwwwwwwswswwwWqwwwwwwwwswsWuwSwuqsqu55qt5%7sssqws\0p\0\0\0\0\0\0\0\0\0\0@`\0\0\0\0\0\0www5pG`FP\0rwwwww7www7wwwusW7wwwwwwwwwwsww7swswuwswswsww45t5gssw\0@@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wqqSVwF\0$puwuw7wwswuw5sWswwwwwwwwwwwwsWw7wwwwwww7W5wu55wswsqtu''q`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wq57wvv\0d@''577u7suw7wwwwwwwwwwwwwwwwwwwwwwwwwusww7w7w7ww5wu7Wssqw\0@\0\0\0\0\0\0\0\0\0D\0\0\0\0\0\0\0wWwvt\0`d!CWWwuswWwwwwwwwwwwwwwwwwwwwww7wwwwwwwwwwwwwwww7wssww7Www0$\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wqtwwVvT%775swwwwwwwwwwwwwwwwwwwwwwwwwwwwwwswwuwwwwwwwwsuww7wsSwq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wuwvGg@@awwwwwwsw7wwwwwwwswwwwsu7wwwwwwwuwwwww7sww7wSwuwssSu77w 7\0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wqqwwtgv\00SwWwwwwwwwwwww7wwwwwwwwwwwwwwwsssSqwwuwqwu7www7qwWwSuu5sSa\0\0@@@@\0\0\0\0\0\0\0\0\0\0\0\0ww vp\077sw7swWswsw7wwwwwwwwwwwwwwwwwuwwwwww7w7wwwwwwwwwsw77ssw5wS\0\0 \0\0\0@@\0\0\0\0\0\0\0\0\0wsSwwP@Cuwusuww7wwwww7wwwwwwwwwwwwwwsswwwwwwwwwwwwwwwwwwwwWwww7sswr\0P@@@@\0\0\0\0\0\0\0\0\0\0\0w5ww\0\0`u7Ssww7wwqwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww7SsWqwW550\0\0@\0\0\0@\0@\0sSWwp \0 ''swwu7wwSuwwwwwwwwwwwwwwwwwwwwwwwwwwwwWwwww7wWwwwSwSw''WcwqrRsA \0@@\0\0\0\0\0\0\0w557w\0PSSWww7wswswwwwwwwwwwwwwwwwwwwwwwwW7wswww7wwwwswwwwwSu75u''qwQsP\0 \0\0@\0\0\0@\0@\0\0wqqwwP57wssww7wwwwwwwwwwwwwwwwwwwwwwwwww77usw7wwsWw7wwswwsw7ww7qw1647\0\0a\0@\0@\0\0wSww\06wqsuwSwWwwwwwwwwwwww7wwwwwwwwwwwwWWqwwwwwsqwWswwwuwwswsSqwswvSSSq`\0p\0@@\0\0\0\05qwwvwuswwwwwwwwwwwwwwW7Wwwwwwwwwwww77swsu7wuwswwSu7swwuwwwwqusrSw7''\0% \0@@`@\0wSwqwwwwwwwswwwwuwwwwwwwwwwwwwwwwwwwwWqwSuwu7w7swswwwwwwwwwqsww7u7pwScwC \0RA\0\0\0@\0w7wwwww7wwwwwwwsw7wwwwwwwwwwwwwwwwwwwwswswwswwwwuwusw7wwwsw7wwu77u7qwSuuswWv\0\04\0wWSwwwwwwswswww7wwwwwwwwwwwwwwwwwwwwwwwwSww7wwwwwwswwwwwwwwwww7wwW7wwsw77u77570\0\0\0\0@\0\0\0w7www7wwWuuqwwwwwwwwwwwwwwwwwwwwwwwwswswwwwwwwwwwwwwwwwwwwwwwwwwwwswuwww7wuwwwwqaa!acwwwqwwwwqw7wwwwwwwwwwwwwwwwwwwwqwWswWwWwwwwwwwwwwwwwwwww7wwwwwwsw7wWsswqwqsw7SwwwwwwwwwWwwwwwww7wswwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww7swwswwwwwswWqwSwwwssuw7sw57w5sw77w7wWswswqqwwwwswwwwwwwwwswwwwwwwwwwwwwwwwwwwwwwwsWSu7wuww7uu5sWuwSswswSusWusWWSwqqsW5wSWSw7WwwWwwwww7Ww7W57swwSwwwwwwwwwwwwwwwwwwwwwwswwwsu7W7swww7wwwwwswswsw7ssw7Swww7W57swSw7wwwwwwwwuwW7uw7wwwuswwwwwwwwwwwwwwwwwwwwsWwwwwwwwwwwwwwwww7wwwwwwwwwwwwwwwwSww7wwwwwuwwwq7wqssswwswwwwswwwwwwwwwwwwwwwwwwwwwwsswwwwwwwwwwwwswwwww7wWwwwwuwwwSsswww7w7swSw7wwwqAwwuwW7www57wwwwwwwwwwwwwwwwwwwwwwwwwwwswwww7swwwwwwuwWuwW7wwqsqsSwWW577WSeswww77wwww67sswW7w7wwwwwwwwwwwwwwwwwwwwwwwwwwswuqwW77wuww5u75ssw7wwsw77wwwwwwssswqu3v75sSwwWwwwSwWwwSwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww77w7wW5su7wswwwwww7swuwWw75755wRCwSWsw7wqsssw7w7Sw7SwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwuqSGssssw7qswqsswwwwwwsww7Wwwwww7w7s777w7wwwWww7Swwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww77w7quuwW5w7wwuuqswwwwwsww7575ququwqwSwquw7sSwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwSG557ssqsSqqqsSsswwwwwwwwswwwwwww7sw757577sww7wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww7wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww55\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ǭ�'),
  (2,'Condiments','Sweet and savory sauces, relishes, spreads, and seasonings','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�)\0\0BM�)\0\0\0\0\0\0V\0\0\0(\0\0\0�\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0�
\0\0\b\0\0\0\b\0\0\0���\0\0��\0�\0�\0\0\0�\0��\0\0\0�\0\0�\0\0\0\0\0\0\0wwwww7SS171w5C0%S21sCqq57ss1qqqq!Sa1!wwwwpge GGwegagtweew@@77sw\0\0wwwwwqt55sSS4000!apSS1sS47Sq7qw774P1RwwweDrGgwgttvWpwvGt4 5uq\07 Swwwwwwww1ss571pC!C10S1AqsTsSSsq1p01qwwwpfEv egGdwaGggwgAt G@W3A6wwwwwwsSqqsS7511%50qs7 71ss571w7775R7wwu$Ptttt wwwvvWwWGGtV\0u\0SQ0wwwwwww7qC5qsSF1 1103C51q1ssqw1qswSSqspssP1sWww4G`Tpa`G`wwwwwwvFww` G t0\05!!\0wwwwwwwqsV553SqsS   QSCw45wq0qsqwAq3S7wtv@ `GDp\0wwwwwwwwufupFw`w@@0Swwwwwwwsq%13S75011143A553a7PsS1sq7pq7571st3s7www`@\0 dvwwwwwwwwwFGt5eGv\0wwwwwww55asu4qs7Rqqss5q7sW1qqsS75qsSswwt`FGFwwwwwwwwwwp@fwFw` u\0S0\0wwwwwwwss q7RA10q`QS5u53W7741sSsssSsw7wwwpFdtuwwwwwwwwwwdwtWwp\051 \0ww7wwwu541a75q1c 1q75171qssqq#SS555rSwwwwwwwwwsswwVtpd%gwwwwwwwuwwwRFWwwvw510wwsWwwwssPw17Q1 Qa75SC0W75sw70wwwwwwwwwwwwwwe@dgwwwwwstwswwwtvwwtwq `5\075wwww550q1qssQ2C5s 1q3Sq%qsPs3SW5wwwwwwwwwwwwww`d@wWwwwwwswwwwwBEwugqwAaq\0sWs5wwwssR%2Q 5!3 pq3Ss72ssW77wwwwwwww7swwwwvFd`@FG7wwwwwwwww7wugwfWvGB!\05wW77wwWa513sS75SQq11G15qaqw7Swwwww7wwww7wwwwwG@@VttwwwwwwwwwswsqvVwW7ppp!\0s51quwwsqsAsSSS51 wc57qsqsSq 7sswwwwwswsw7qq7wwwtD\0f@FFwwwwwwwwwwwwwugwwGGwAqa\00W7sww71 151sSRGsSp7571cu5wwwwwwww7sw73qwwwpvP@`GwwwwwwwpwwssCwwwggGv!a1qq55wwq2SBSCRSS1qssSqqaqq7u7swwwwww77sw3q57wwwtDed@FwwwwwwwwwswwwwGdGtG q05%0wwwW51177u4r57773ssCSwwwwwwwwsw7u7swwwd`FFVWwwwwwww7w70wutwwdGv0!\0q57ws1sSS\053Sqqe1sqq5s7wwwwwwwsusS3s57wwwFT\0d\0vwwwwwwswsP\0wvvdpv@4\00\05%5!puwRqe51sqas7u3SsS7W1gswwwwwww7sssww7ww`\0@gWwwwwwww7\0wugdt1\0Rsww1Rw1q7qSwW7s53S3wwwwwwwwwsw7731153Swwvv@ dV\0gwwwwssq\0\0WfDVeegA!10\05!p1p 75701sq5''57s577%5sSuqwwwwwwwwww777qs1qsw7w4Eddf@DDdwwu70\074`gFv@3R R1RqwsSPCsWp3RS s777wwwwwwwww3w7171q353Sww@\0@v\0@gtq\0\0dvtDV@10Rq\00p1!51q051a''3sqqqw1s@qsqqww7wwwwwwwwwsswsS3S7wwtfTpFD\0Dpep\00\0VD@gfSq1\001R1@!qsa50CSQ51! 16SSwwWwwwwwwww7753377wwsDf@@G@@\0\0p$F@\0VA00!CA0P0q5!w\051!SC@1RQp57 S7w5swwwwwwssssqq3s1qqwwqE@D\0d`d GdTt dGdGFaq!0!1133Sq1 1p 13S0 1sSwRwwwwwwwwsss7711711w 7wvdf\0\0\0\0@d\0d`\0\0Gda!!!cCCA5 SSsCS4R@sSSw7sswwwww757q1713Sq7w7wt\0\0\0\0D\0@\0\0FVF\001310415CR3@1%qq 52qq101s77wuwwwwwwwsqsq777qq1wCSswwwfFDF\0\0`\0dBVFpQ40p\0!1RS\0C%15 5117\0qSQ05!qc5sw7wwwwww7773s51113q7 7W7swWGFd F@eFD$A!01!S101141Qq@q5  12S ss57wwwwwwww7sssqss153SwSsWwwswwWGFDVRA5Q\0!!1R1RS%\0SacC505!1CSQaA577wwqswwwwwws7ss15175 775%sqw7577C !!\0!0111qA!q514S551a\0SSsSspwwwwwww7w7773175s@SqSqsRW77Qs@ps50! 11%1q%7$0Sqq5R''qp10100p5577wuswwwwwwssW3qqq1q31s5757 %pS''RQ3 !5qScS10S1s551 \0\0 sqw7swwwwwwsw73w31q13SSCAr1ps551pq52P00q 1C073557q1 1`1p10q7qw4wwwwwwwsw7s77153q$355\0qpSS \0qCQ1q0P0Scus1! \01q7777q7wwwwwwwwwwwsw731SqtpSS!pWrSSPs1!a!1!q\0 %103%!qaa7C151 sVSwwwwwwwwwwSA0pq3\0`10A00S101A!0uswsRQ5%0\051s7sW1wwwwwwwwwuqq17551q\0%52a1aQ1\0001P s0qp1q!5S51q55q77swwwwwwwww71\0QS150\00\0q!$0\0\0Q1\0000\0wswqu 1s15 01S!053s7Sw1wwwwwwwwwwQ\0\0\03S1qCA01001\01!\0s7w71sS\01aS aP13Su3wt7wwwwwwwS!\0Vr\011! 1\00\0!0\01wqwwqGR70SRS1p7!W7u7w7wswwwww5SU71Q\0qw101\0!\0\0\007ww77s57S3151q1P05sSwsw7qwwwwwwsQ53Qq\0pSa0pP1\0\0wwwwwSq1spqc1SR5#! 3Cw7w7SwWwwwwwq1q15771R\01a12 !1\0\00w7wwsqq7113 500%3SW5sqswssw7www1wSS53SW11 %!RqQA!cR!!\0\0wwswwV7qs1spqsR1sC41sswwwwwWwwwws11qswu1sqP010Cq3S1wswwss10!!\0wwww73 1551p11qs5%wwwe!''ww7w1q5545575uq1\0Q52P1Q1swWu%5w001swwwwus5sS1sCSqsq7 CSpP\0@@www7q715wwwS7P\0\07Q1Gq7wuq4\0\0\0\0\0\0Au11010Q\0\0wwwwwsE3551%537SC!5517wp\0\0\0wwwsQqsQ Swu5s1\0S527wwC@\0\0\0\0\0\0\0\0SQA\0wwwsw53W1sR3Asq754SSwG\0gV wGw5772Qu7Ww1w5\0 1sQgwqa@\0\0\0\0\0\0\0\0 \00\0wwwwww4311q 531q041 77w w@dVUpGwu1SQwsqq\0qsww \0\0\0\0\0\0\0\0\0\00wswww7qsSs0Su77S1qwuudgGgefugw7W uwww7s\0\0 q7wwQaP\0\0\0\0\0\0\0\0\0\02r\0 \0wwww7wqs5414131qqqp50qsw7wwWG@VUgVpsswCWW\0\0wwwwsW4044\0\0P\0\0\0\0\0\0!\0!\0wwwwww57SsSCSSS75CSSwwwp\0`G`fwg@swwww1su0\0\0\0\0wwwu50QA\0\0\0@p\0\0\0\0\0\0\0P\0\0wwwwwssSp730571q7R1sw77wwwtvPFGFVwwwwwwwwwwws\0\0\0\0\0 wwusS07Au51 s\0\0\0\0\0q\0q\0wwwwswu7q5sqa73S5 Swwwwwtd@veGwwwwwwwwwuu\0\0\0\0\0\0\0\0 wwwu5wWP1RW0 p\0\0\0\0\0\01\0!\0\0\0ww7WwssCqqqu53Cqsw7wwuvp fpDebWwwwwwwwwwwsp\0\0\0\0\0\0\0 wwwwsSpwWuav5q\0\0\0\0\0\0\0S!\0\0\0www7wwsS3Sas%773sq57wwwwuPFVDvvtwwwwwwwwwwwq0\0\0\0 wwwSWwSq'' B \0p\0\0\0\00 \0\0\07WqwssSCq531Qqs 57w7wwwGfGFwdGGwwWwwwwwwww7\00\0\0\0 wwwwww5t\0% \0\0\0\0\0\0!\00\0\0w77ww7Rqq2S577770swwwwwwu$$FGegwwwwwwwwwwwwqA\0\0\0 wwwwww  0ap\0\0\0\0\0S1\0qw5qwwa171qasSSSsswwwwtvTGgDdGwwwwwwwwwwww\0\0 wwwwwupWAAa`\0q\0\0\0\0Ap\00q\0\0\077wss471q7sssw7wwwwwwwwFtD`Fwwwwwwwwwwwwqp\0\0\0\0wwwWwW50RC\04\0\0\0\0q\05qws7SSsSq1a71qsw7wwwww` B eegwwwwwwwwwwwsq\0\0\0 wwwww0W%%@\0p!\0\0\0\0\0P71\0\0\077wW75!5#s5 ssqw7w7wwwwwvPFT`FFwwwvuwwwwwww71\0wwwwwW0pP\0P\0\0\0\001\0\0\0qw777sSWQqs455777sWswwwwwugtfDewWwuwwwwwwwwP\0\0\0\0wwwwwuqS0@\0\0\0\0\0 1\0\0\0\07sSW577s3q3ssusw777www7vVGE FFuwtwwwwwwwws10\0 wwwwuwwP4RB\0\0\0\0\0p5!\0\071qsssSqq451s7SsWwww7swudpDewwwwvVwwwwwu\0\07wwwwwWqaRR\0\0\0\0\0\0\0\0sSw3Wsw5571s3Ssw7sw77777su7wwDtvpFwwwuwwwwwwwq0\0wwwwwSuwA@\0\0\0\0\0\0\0\0p\03\0\0\01q5s1w7R1q53qssqqwwSqswvvt`D`DwwwFwtwwwwwq1\0wwwwwwuwua41\0\0\0\0\0!!\0\0\0\0w3s5ssw7173SSsscW75777sS71wuap\0FVwwwwWGwwwwwq1\0\07wwwwwwvqsQAE\0\0\0\0\0\0\0\0q\0\0\05sqw1wsSqa537SSsssw51sq7wVTT\0\0FwwwtpwWwwwsS7wwwwwwwSWWR\0\0\0\0\0\0!\0\0\0s57sw57sS SS73qsSsssSw1sweg\0\0\0@wweeewwwwwu11wwwwwwwwu65!A\04\0\0\0\0\0\0\0\0\01\0\0\0qwS57sssqps75qu7777751ssqwurVP\0tgwWwwgwwwwsq17wwwwwwwwwwWWWP\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\07s5sw7ww715qs73qsssSSsw1573wg\0\0 @\0wwvwwuwwwwsSwwwwwwwwwwwW571\0\0\0\0\0\0\0\0\0\0\01\0\0\0S53Swsq50S3S577777w7wwpa@t\0wwWwwGwwwwu17wwwwwwwwwwwusGu7wqt\0\0\0\0\0\0\0\0\0\0\0\00\0\0\0\05sc5sW7s''77753qqssSws3sswqa@G7wwgWFWwwwsSwwwwwwwwwwwwwuwWv\0\0\0\0\0\0\0\0\0\0\0\0\01\0\0\0\03qsw7ssqsSSSsG777wwwwwu  swwwVwwwwwwwwwwwwwwwwwwwwwwww\0\0\0\0\0\0\0\0\0\0\0\0\00\0!cC57sw7''3s7Sssswsw7ww3q@\077wwwwwwwwwwwwwwwwwwwwwwwwWwwaB\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 q1sSswssSsq747w777sssw77777wswwwwwwwwwwwwwwwwwwwwwwwwwwwwP!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\00C57ssS56s573Ss3wws7773sssssw777wwtt$gwwwwwwsqs0!7wwwwwwu454\0\0\0\0\0\0\0\0\0\0\0\0\0\01sassusu3SCSsS7w33ww3sss73s773swswwV\0Pwwwwwwwv\0\0wwwwwwSRR%\0\0\0\0\0\0\0\0\0\0\0\0\0\0!\0015w773q2377s377s373373s773w7sww\0  Gwwwwt\0\0\0\0\0\0%wwwwW \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0as5s157wqR5s3w373337377777sswsw7wwCWwptwWwww\0\0\0\0\0\0\0\0SwWwwqaqC\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0! 1Ssqsss%33s3733s73733s7s7737swwq wwPwWG ww\0\0\0\0\0\0\0 7wWu7 P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\01\05sqq%57s50Ws773333333ss73777wswwwwuGW%wwpGwp\0\0\0\0\0\0\0\0\0WwgwWqpp!\0\0\0\0\0\0\0\0\0\0\0\0\0!\01SS477s3773s33s333ss33sssss77wwwww4p%twwp\0\0\0\0\0\0\0\0\0wWWwwQ`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\00100qq543SSw71qss3333s73337737777wwwwwwwGSRuvWw\0\0\0\0\0\0\0\0\0PWwwu5q%%A\0\0\0\0\0\0\0\0\0\0\0\0\0\0sww323#3#7333377733ssssw7wwwwww\0W@w\0\0\0\0\0\0\0\0A\07wwww5q\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 0\00q054Cpqw773333333333333ss77777swwwwwwsurW@ G\0\0\0\0\0\0\0\0\0uwuwWS PQ\0\0\0\0\0\0\0\0\0\0\0\0\0SQp1s373s333#333s73s3s33ssssswwwwwwwwGtg\0gwp\0\0\0\0\0\0\0\0\0 t4www7SP\0\0\0\0\0\0\0\0\0\0\0\0\0\011!!0CSg3w73#33333#33333s3777777wwwwwwwvtv@B@\0GGu \0\0\0\0\0\0\0 WW pWSU1AA\0\0\0\0\0\0\0\0\0\0\00Rp173s32333#33333333s773ssssw7wwwwwwugw\0GtwvpW\0\0\0\0\0\0vwwwwsG\0\0\0\0\0\0\0\05\0\0\0\0\0\0P5!pPSs73333#3233323s3333s77777swwwwwFFDd\0tpwPP\0qauewp\0WSW1aS\0\0\0\0\0\0\0\0\0\0pq%732s1323233333#3s33777773s77swwwwweg@\0\0tv@\0uvw\0Ae\0Agwwwuwwwqu5!@\0\0\0\07\0\0\0\0\0BA3SQ0!0s3223333333333#33333333w3w777wwwutt\0\0eepGVR@WG p WwwwwwwWq41\0\0\0t0\0\0\0\0tu0qA2s33232333#23333s73s7773w3swwwwwBFt\0G\0\0dpGv\0w utwGtWwwwwwwwu4q1\0\0\0R\0\0\0utC1000322333333#333333333733ss3sssswwed@@@\0GD\0Atw$t vwgwwwwwwtsSCQ\0P5p\0\0\0\0d$@133233233#333233#337377377777www@\0\0g\0\0\0\0 pGwwWptuwWwwwwwugWup Q!\01P\0\0\0\0p\0@a23332333!332332333733s3sssssswwDG\0\0\0@Ad`gGGwWUgwAvwpwwwwvVtgSA0\0aC4\0\0\0 @\0\0F@!\03203321333#333333737777773ssw7tgg@F\0\0dF@gVwtwwguwFuDt wgt$gtrW%1CRPq\0\0\0\0\0d''\0G!01!3332332333333#33337333333s773wdD\0@\0\0@\0\0FwwppwVvwugwweut%dwVpW5pWqqA \0\0\0\0F@gg@\0033123323#33323733777777777ww@@\0\0\0F@\0pvwCDuGtCGtuvpVWt\0dW7wSC\0!G0\0\0\0\0\0\0D!0322333333333333373s33s3s7777d \0\0\0`@B\0@ggvtw$Wpt wew@gvG@Acquu%\0sP\0BVE\0\0e\0!031123#33333333733s3ss773sswwE@\0D\0@@\0DwGtuww@P`@wDwGFWeGG`GvDWwwR\05FtG@\0\0F023s333#23#233#3733s373sss77tfD\0\0\0\0\0\0FgvvvwgpgT$w GrPFVVwe@G`dSQwwwwwp\0TpG@\0\0G\0 12333333333333333773ss7377ww\0\0\0\0\0\0\0@\0\0vtwggwvWW`vTwd\0Fp@\0wwwwwwwu\0v\0\0\0\0\0 @vF\0s303#21333332333733737ssssst@@\0\0\0\0\0@dt\0GvvvVWeedvE eged@ud%g@p@Gwwwwwwww@\0 dv\0T\0De\0033331323#21#333s3773ss3777wp\0\0\0\0\0\0\0\0Et\0gdrG\0Ag@t\0$GVpBGGgwwwwwwwwv\0pDF\0\0@03s#33333333333s33s77777swe@\0\0\0\0@\0F\0F\0@\0@\0Tpp@ `\0G\0Gdd\0G@\0Cwwwwwwwwp@ pGpt\0t\0\0t!33173#333333#3333ss3s3sss7wd\0\0\0\0@\0t\0`6t\0@vdt\0v@E`tepWdtTwwwwwwwwp@D\0td@Ft`sq323#3#377373373w777wpF@\0\0@\0@@\0\0@@gD\0gdG@RG\0\0tfEdwBwwwwwwwwp\0ppFp@t017p2233333333#3733ss7377sst\0\0\0\0\0\0\0tVr@`\0\0 @dpgve`edd\0@ $pDewwwwwwwwp@F\0Wp`\0@\0g@q13033333333333s373sss7w@@\0@\0\0\0F@Dptt@ed\0`E@Edte@t@dv\0wwwwwwwww@\0gAGp  `@`0p2173323#2#3373s3ss7777w7t\0\0\0@\0\0@@\0p\0Dd`pvVGP\0` @GD\0G@ Ge\0 wwwwwwwwt\0\0\0\0GF@d @@10s3333333337333s33s3sssw\0F\0`@\0\0pFF@Pade@V\0VD@Ft edt\0@dwwwwwwww@\0B\0\0v\0\0C@ \017SS7#333332333s7777777wwp\0@d\0\0\0D\0e\0`F\0t\0F\0eDd\0Fppdpt@dp@wwwwwwp\0@\0w\0gD@D0s1''3#23#2337333333sssswFd\0@D\0e@`\0d`FGG@P\0\0F\0FG@\0Dt@dF@$R@d\0wwwegD\0@ @GwpGD`Vp\0SSs33333333337777773sswwD\0\0\0\0vv@GFT\0\0tdGFT@tpE\0Dg@@Fte@Gd\0G@egvVVB@d\0`wwDg@1''1533333333333333333sswwt\0\0D@\0dd\0FFFGggfte`@@F\0vwgggwv\0FF@efvddddD\0@@@Gw`\0@`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��'),
  (3,'Confections','Desserts, candies, and sweet breads','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�)\0\0BM�)\0\0\0\0\0\0V\0\0\0(\0\0\0�\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0�
\0\0\b\0\0\0\b\0\0\0���\0\0��\0�\0�\0\0\0�\0��\0\0\0�\0\0�\0\0\0\0\0\0\030sW7ww\0\0\0\0\0\0\0``\0R\0\01pp@u7cu5qrQ!q5qp57\0\0R\0 p\0\0Cagwww33sqqw777w\0\00Wsw\0\0\0\0\0\0\0\0P\03113pPsC\0@\0\0  aat3QCVSuqw1qwqp`@vwgugpd%47wwssWS777SSs7311#Ww\0\0Cq vwsgwwq1Swsw pCSapqqwsV7775cwqw7tsWw qw5cw\0gwGgwsu1373Ssq77S110057P\0wSGqw171q3wwwpsGrQawwwwsRWWw5swqu7S1swq`''wgwww65g7su33qq575ssSw7q01p1g\0sgwvw31Q7wwwwpwvwwwwqu7su7sWwsW7W 5wwVwwvwwecWwgu3u573sqssS7sw111011111qpGvpwsSS13S1wwwwcwqwqwwwwwsSW7wWww7wsS55Ssw7wwwwwaw7SW3S33S77S77q15!13!17\077wq111qwwwwwwwwwwwwwwsSSw7wwwwwWs6Wwwwwwwgwtvs7s73SswqwwS1q30GvWg317wwwwvwww47wwwwwCuwwsWwwwww75u0sWwwwww`qww71sqs73S7ss771105S11sC www113q51Swwww57wwwwwwwwwu7sqwwwwwwwww7wwgwwwwwqs13s3qsw775sw1123 1\0''qs137wwwwwWSwwwwww6Ruw7WwWwwRWSqqww56w%5%ag75531q77qqsu711!111q1\0\0`Ag111q11wwwSSsw6SWw7su7RvwW7w7swwsgWwqwwwvR57533q33Ssu7777s0101 ''3S11q11qw77w5qu7sRvWvRt7sw7wwsw7Scqwww wSRsS1ssqq3qsw1qw71!0111151`\0vPw1qS1wwwqqcv7wvwSqssaacGwWqwuwWwug WwcSa47G3S71353ssssS1s13 % 1q31q1q1wsWw7u7SCSswvuue7SW67wswsw5w7w6wwwgvCqs3s1ss53Su7q3S7101!ssq114vwSSS15sussSSu7wwVwCRrSG445vwSuw7WwsWwqpqg1q1s571s3s3q73111!3P0qe1111S11suswuwwst7w77wu6sCqwsSww7Wsswwwwwwwww6SS371ss57113!50033S11!agssSs11Swswwssqu7qwwwwwrSW464wwwwwsuwWwwwwwwwwW733171s13311133Squ7wqq1111wwwwuw7qwwwwwwwv4wWswwwwwwsw7swwwwwwww7w1333sS13311!w3114s111qw7wwSq3q1117wwwwswwwwwwwwwu5wwwWwwwwwwwwwwwwwwwwwwww3q5573111311wq111s13113www1s11wwwwwwwsqwwwww7w7777ww7wwuwwwwwwwwwwsWwq133s1w3q` q!00SC7www111qwwwwwwwwwwwwsWw7wwtw 7wqsssuwwwwwwwwwwW731175113wgp\0 15131w7u111517wwww7wwww555wswwsw7usqwwwu7wwwwwwwwwswsS11113s111q`ww\0\0rC7117qww51q7qwwwwwwwu7www7wSSw5qw7wwwu7ww5wswwwwwwwwq313311gpwp\0\0\0\07113SS7wssQ51611wwwwwwsqsusw7w777qs71w7Sssw7ww7wu7wwwwww73133153Sww44\0\0\0\0\011!qsWq1q113Swwwwwsu7wswqqqqq7 SSW757w77w7ww7wwwwq1s301113w7qwpSp\0\0\0\077q11q1q17wwssW7w57q7777q353r1qsSswuwwwww7wwwwww31W1s44A\0\0q5151577S51q1Swww7wW7uw7swwsSS3S7575777wsqqswwwww13111s3sWSCSc11q733151cw7wSwws1751!11qqq1!31!wwSswwwuswwww131\001qs11u%u1s1SS7q551s1S3wsw757SSqsS31111w5sswswswwq1111q7711ssq7w1sSsQ3SWwWw71s31111su7swwsWsws133131311557sq1!q17q1537q1q71773qs11!\013q577u0wws11313113swS10ww711Ss1q7qq1Wwq1\0\0\0!wwsw0sw313q11q1P11p501w511q1q11qq1511!1q11s10\01sw5wW q3q3111RRS53s7711111!11!\07w7sqs753533P1551sS531151151q713!!qssw7we1qs535130s1!3SSSS3q5511111557Swww013S3Ss11!7113Q15!3S1qq313!1\0\01Ss7SpRq133S3S3s 3Q1qrSSq1q3Q503s1qs1111R\0\0!p01!53swsqG1131s57711q33311q37qq1111111\01031ww21113113s 01!53111q%135171551\0111151wu 113171q57A1 !1111SWsSq11S1!\01011s57ps1111qs31s7SS1q53S!1137sw q13011111151q51q5115s1sw31!1!sw103!11sa`3s53113S751s3qs11\011\0\031qswpwwWu11pp`pp\0 s1SSQsq51sWs7110\0\0\051wWw7sw7wwwwwpSG%51s171SSs1wS1Q\01\0\0#\01wp7wwwwww7wppw%wwwa40Rw555571sq7q7w111311\0\0\0\0qswpwsuuwWwwwww6wvqwu sSsq1qw5557171s1\00 3017sw wtwsw47Ww%wwwww vp6W7u757SsSss17u1q\0\01\03qwsuwwwSwwwgvwgwpwSsqq7Sw7qqq53107wQ\0\03\0\0757wwwwwWwwwwwwwwwppw5577ssw51qw773110s1\0\0\01!17u''wswwsWwgvwwwwwpRS75773Sqq31311Wq\0\0p\0\0\0\03SwutwwwwSww%pwww%1qSssssqswSWqssQ113q\0\01\01!1#ww7WwuwwwwrW Ce1q77qsu557v77300\00Sww7wwww% 5 qwSCSSs5swpquss11\0\000q7wwwwwr BWv46q%151qswWW ssu111111qwquwu5w 5u4qww SSw7sw7sSWww111\001wwsCwww BacCpvrqqwwwwwwg7sqq111wwwuwwwuRWwwww 55vwwwwwwqsW5ss\0\0\0\0\0!swwwwwwWac''wwwwwwVwsWwwwwwwu7w5511\0\0\0\0\0\017sSwqquwwRWPwwwwwsswwswwwwwwswsw31!\0\0\0\00a!q011qwqwww''ww''wwwwtwwwwwwwwwww57S1\0\01q1%1wRW7wwPwvWwwwwwwwwwwwwwwww7sq7\0\001u7wwWwww''57wwwww7wwwwwwwwww57Sq5q1!\0\0\0\010!!54!7u7SwSWvWCGwwwwwWwwwwwwwwww73555\011\05!Sp03wWwwww57t7wwwwwsw77wwwwwwwWqq1ws311Www711a560w7wwwwCGAg6Ww''Wwwwwwwwwwss17111 sw7w1SS65qs1q7wWwwwwt746uerw7Wswwwwwwwww77151 \0w7wWs\01!3C7!pswwwwwAAasswvwswwwwwwwwwwwwq1111ss117sw''1\01q51S!1uwwwWww46!agVu5wwwwwwwwwwwwqssS1 7wu711wq1su!qsq1q11Sq377wwwwwAaRPqcRw7wwwwwwwwwwwww110sQ3S553pSsq57uS0WwWwwww!aRwwwwwwwwwwwwwwwwssWsQ13S051w''w7wq%77051 !17wWwwwwwRPu4wwwwwwwwwwwwwwwwwW37s51A0!%Q7sS10Sww5!1p!7wsWwwwRvsGwwwwwwww7wwwwwww7qq1u111R1!Q1%Q4ww1Sq1qR1q3WsWwwwwu4st7ww7wswwwwwwwwwww77553q3111S51S7www55wvsuwwwwwwwwwwwwwwwwwwws0S1!1!1%15\01Q1q0101%wwwWww7stwcGwwwwwwswwwwwwwww7wq11S11!111705 01wwwwWwwuw7W7wswwwswwwwwwwwwwsS10!!!0wqss1011!qwwwwwWwcW''Wwwwswwww7wwwwwwwwwwq11q117sSq!q0!0u!1wwwwwww7WrW''wwwwwwwwwwwwwwwwsw7151001!wwq000s!sWwwwwwwwW''u5ww7swww77swwwwwwwswSSqqp1wwqWq01sqq7wwwwwwwrW''cSwwwsw7wwwwwwwsw7qw77SsQ\011w7170SQ17101wwwwwwuwu5Wwww7wwww7wwwwwwwwswww\01wsS1 Rwq121CqqsSwwwwwwww''cswsw7w77w7wswwswwwwsWw11q1%5007w11!!515!0!130q1wwwwwwwwWwwwww7wswwwwwwwssssw7wq01qw1Rs!0P1S7q7wwwwwwwwswwwww7ssw7wswwwwwwwww3wwS11!wqs1011 q011!wwwwwwwwwwwwww7w7w7wswsw77w7777ww115 SQ s!r%0!7wwwwwwwwwwwwwwwwsssW7wswwww7wwww7www!110q7!7q5%5!0q1q0175wwwwwswwwwwwwww77w7swwqssww777qwww1W7sS5q1sW1111RQW7wwwwwwwswwwwwwwwsssCw7swwwswcwssswwww11sW551!0w1qRS1QpsR1sW773wwwww7wwwwwwwwwwsw55wwwwsW7sw77w7ww1wws5551!\0\01 w50500153usWwwwwwwswwwwwwwww5ssswwwwwwwwwqsssw1wwqss51sSq0p01\0P1qR!51p7S511aqS1swwww7wwwwwwwwwwwsw''77 wwwwqwws77wwww1sw1sS1w1!!SS131swwsw7wswwsw7wwwwww SW545ww7wqqwRsswwwwww1S1sW51s1A q011!Sqw557wwwwwwsSww7wwwwwwwwsw77''7747uwwwqsswwwwwwww1sS755500!57qw7qq7www7w7wwwwwwwwwwwwwwpwsSCesw7SW77wwwwwwww17qswSSSsQ1q1 00qqwSqw3Swwwwww777wwwswwwwwww7 s52wwqAw7''7wwwwwwwwww3SSsq77w0001sq157sw7wswwswwwsww7wwwwwswwsssv3SSQw0PsSswwwwwwwwwws7557Ssqsq77 03qw51qwW53SW7w7wsswsswwswww7wwwww7w451r7''w541swwwwwwwwwwwwsSSsSqwSw1105WWsSSSq713W73q1wwwwwwwwswwww7wwswwwwws67557swu577wwwwwwwwwwwwq17qqwq7575sSC Sq7w777577wq3Rwww7ww77swwwswwwwwww7wwwqpscW502RV77wwwwwwwwwwwwwwQ77swqw53W51qqqu5757SqsSwSWwqsqcqwsww77wwwww7wwwwwww7ww7ww7%7#cSS517wwwwwwwwwwwwwwssSSu1w7SwsWwssSqsSu777357qsSqpgRBGwswww7sw7wwwsw7wwwww7www7qw7%!cwwwwwwwwwwwwwwwwuwsw7w1sQ757w75u77757SWS131ss\0$sCwsswwwww7w7wwww7ww7wwwww77wwwwwwwwwwwwwwwwsgwSSsqsSqwww3575qqw7s17\0\0\0t4w5wsw7sww7wwswwwwwwww7wwwssswwwwwwwwwwwwwwwwwwsGW77pqu7577usWSqsswss5551!at!0\0\0\0\07sqw7ww7wwwswwww7wwwwwwwwwwwswwwwwwwwwwwwwwwwuw4rwusqw SqsSSs73qsSu1qqusss54q\0\0BqbG677cswssssww7www7wswww7w7wwpwwwwwwwwwwwwwwwwswSWwwwwpsS77SsW57w773517\0pqBS`\0\0wqw7swwwwssw7www7wsw7wwwws wwwwwwwwwwwwwwwwwwvqwwwwwP@`1!1qw7qs1wq1141 4t54AawrvSccqw7777w7w7wwwwwwww7w7wswwwwwww7wwwwwwwwwqgwwwww''7 Wgsw1`7cCC@4w7vwa qa\0pwW77qwcugRqsSwwswwsw7w7w7wpvwswwwwwwwwwwwwwwwwwwwwwwRVw Sg151w`rww t4wgwwtvpww7gwarr3w7777swwwwswwww7W7w7 aswwwwwwwwwwwwwwwwwwwwwwwwwsWu''wqrSpq usugcrSw4wwwwru4wwvwwp7wWsssR5#swSwswsrwsSSww5wswsww7wwwwwwwsw7wwwwwwwqwarWwwwv  ppwvwwswVGwwww SgewwwwpP327Cppsw5ws67wsww46wvp\0vw7wwwwwwwwwwwwwwwwww7wwwwAv''pwgw0pw  swgwC7'' wwwwQ$7vwWwrwe05777Swqp7t7sSR\0 swswwwwwww7wwwwwwwwwWwwww6!GwwSW@ %%wwv4PPCw `qw''P\0\043\055677u7wcGv7vp \0u''7sw7w7swww77wwwwwwwwwwwa\0  ''c\0\0\0 %v\0\0\0 twg`6\0SG \0\0c407\0qpw u%57 \0 swwwwwwwwwwwwwwwwwwwwwwws\0u%4\00CRCpPpWg`\0\0P\0''pC@@ QCppPC7@pwrsCvppp\0Cw577wwwwwsw7swwwwwwwwwwwww wrR  awg  @6Ww$cg 7#\0rpRW \0w 0p pqcp  `\0 Sgwwswsswwwwwww wwwwwwwwwwwwS  u`!qvwaaS''vpwag ''pvqPp%%rW%pP @p40  wgwppg777swwsw7qgwwqqqwwwwWwSWwwwRRRP``qaapR!cW p4rWwwwq a wwww% p0pwp\0qaawwwww  psswwwwwwwww77wwwwwqwwwwwww  wwwww  wwwwwwsW5wwwwwwww5wwwwwww wwwwwRWw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��'),
  (4,'Dairy Products','Cheeses','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�)\0\0BM�)\0\0\0\0\0\0V\0\0\0(\0\0\0�\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0�
\0\0\b\0\0\0\b\0\0\0���\0\0��\0�\0�\0\0\0�\0��\0\0\0�\0\0�\0\0\0\0\0\0\0wwwwwwwWswW7w7swwwWwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww44qat65psSCeqqsw#W\0\0wwww7ww7ww7e7wusww7Su7wwwwwwwwwwwwwwwwwwwwwtvW%!$4wwwwwwwwwwwwsWw7St6%426 W''wwwswwww7wwwwwwuwuwwsW7wwwwwwwwwwwwwwwwwwww%$\0\0@`@\0\0\0\0\0wwwwwwwwcSG6Spw5''WwWww7WwwwwswwsuwqwqssswqwwwwwwwwwwwwwwwwwwwwwpRC\0@ \0\0\0\0\0\0\0\0\0\0\0\0\0wwwwwwqwgsqr7 pRprqsW5gswssWwWsWw7wwwwwwuwSwwwwwwwwwwwwwwwwwwwRQ eA\0@`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 wwwwqqugWWs 7 g4sqwwwwwwsWwwwswwwwwwwwwwwwwwwwwwwwwwwwwwwwga A B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wwwww7scpu5%%asWsuvsWwsWww7WwwwSqsW7wwwwwwwwwwwwwwwwwwV\0\0\0p\0@\0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 wwwwww7vww7erWrswwwwwswwwsW5swwwwwwwwwwwwwwwwwwwwwvSawwwwe\0`\0\0\0\0\0\0@@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 wwwwW7vqqpu7wwWuswswwwwwwwwwwwwwwwwwwwwwwwwwwwwwww%wwwwqww\0@\0\0\0\0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0www7WuwwwrqqwssWwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwVu7wWgwV\0$qB\0`@@@@@@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wwwwssppuggwtw''wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwWW%6Ww''uw\0\0d%\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ww77ug7sqsSw5wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwV7cWaggWwwp\0\0P \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 wwwwqt4wwwSRqwwwwwwwwwwwwwwwwwwwwwwwwwwwww7CWcW7WagR\0u`@\0\0\0\0\0\0\0\0\0@ \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 wuswswwguwwwwwwwwwwwwwwwwwwwwwwwwwwwwwvSt5t4wpwu!a%pCBF\0\0@\0\0\0\0@@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Gsw4ucwpqsswwwwwwwwwwwwwwwwwwwwwwwwwwwwwQaCBCe%''wwV\0 @4\0\0B\0\0\0\0\0\0\0\0\0 \0@@\0\0\0\0\0\0\0\0\0\0\0\0\0wuw75awwwVwwwwwwwwwwwwwwwwwwwwwwwwwwwv64'' RVwWwwwwwp\0\0\0\0BR\0\0\0@\0\0\0\0@@\0@\0\0\0\0\0\0\0\0\0\0\0\0\0 ssRV''sSwwwwwwwwwwwwwwwwwwwwwwwwwwuAC@VAgG www45v\0\0\0\0u$@\0@\0@\0\0\0\0\0\0B$\0\0\0\0\0\0\0\0\0\0\0\0\0wVwsaWwrWwwwwwwwwwwwwwwwwwwwwwwwwwwwpsc@p1gp%  wur% \0\0\0R\0\0\0@@\0@\0\0\0@\0@\0\0\0\0\0\0\0\0\0\0 sR56477wwwwwwwwwwwwwwwwwwwwwwwwwwg% FC\0@CCBuq\0PrQ\0\0\0\0p\0\0\0\0\0\0\0\0\0@@\0 \0\0\0\0\0\0\0\0\0\0\0\0\0wwWCStwGgwwwwwwwwwwwwwwwwwwwwwwwww rCRt!$ BB\0$\0ABp`\0RG4\0\0\0\0B\0\0\0\0\0\0\0\0\0\0\0@@@\0\0\0\0\0\0\0\0\0\0\0 qr56SqsSwwwwwwwwwwwwwwwwwwwwwwwwtw4%@\0\0C`t\0a%0Ca \0\0\0@d\0\0\0\0\0\0\0\0\0\0\0\0$\0\0\0\0\0\0\0\0vwRSwwwwwwwwwwwwwwwwwwwwwwwwwwwwe74qrBB$\00C@V B@C4\0\0\0\0`\0\0\0\0\0\0\0\0\0\0\0\0$\0\0\0\0\0\0\0\0\0\0\0sPw%4455wwwwwwwwwwwwwwwwwwwwwwwwsFwCB@\0@\00e!`@\0\0\0\0\0\0!`4\0\0\0%\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0''CCSprwwwwwwwwwwwwwwwwwwwwwwwpt556\0``4@pCG\0\0\0\0@\0BAC@ \0\0\0ee\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0qCcRw 5wwwwwwwwwwwwwwwwwwwwwwwwSGvQ`a\0@rE$\0P@B\0\0\0\0\0\0\0 00P`\0\0\0\0aa`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\04q qwwwww7w7wwwwwwwwwwwwwwwWwg4w$$ @pE%!` \0@\0\0\0\0\0\0@\0@\0p\0\0\0\0BG\0@\0\0\0\0\0\0`@\0\0\0\0\0\0\0\0\0aRpw1gwwwwwwwwwwwwwwwwwwwwww7RWwRFPcG%$\0@@@\0\0\0\0\0\0\0\0@\0@@!% \0\0\0\0\0G\0$\0\0\0\0\0!@\0\0\0\0\0\0\0 VuwwwwwwwwwwwwwwwwwwwwwwegwA`u!VaRCC\0\0\0\0\0\0\0\0\0\0\0\0\0@5s@\0\0\0\0P\0\0\0\0\0\0\0\0\0\0\0\0\0\0 %5surwwwwwwwwwwwwwwwwwwwwwu7wv$tp%arV%\0@Dd\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0qg \0\0\0RB\0\0\0@t\0\0@\0\0\0\0\0\0rScurWwwwwwwwwwwwwwwwwwwwwwvVqgP2DpvWVRP\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ae \0`T`\0\0 \0\0\0\0\0\0\0   Wrwwwwwwwwwwwwwwwwwwwwwwwsqgude&E!wqa`p!e%gGt0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0p w\0 4a\0\0p\0\0\0\0\0\0\0pprWu7wwwwwwwwwwwwwwwwwwwwwvVSRSR GwCCAtpu57S\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0pPw@\0F\0Sd\0\0\0\0\0\0\0   7w7wwwwwwwwwwwwwwwwwwwwwwqst$ BG5e447Cw6vW0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0rRWww\0\0@d7@\0\0\0\0\0\0\0pquwwwwwwwwwwwwwwwwwwwwwwwwvVSCCAe 4w6tsCt5qwwA\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 1wwwBwt\0\0\0\0\0\0 %$''7SwwwwwwwwwwwwwwwwwwwwwwSstp$0GgpW4wSvwqw0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\04!wwwu\0\0Vw\0\0\0\0\0RSuwgwwwwwwwwwwwwwwwwwwwwwwvWC\0CA1wsewqgWww\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\00\0awwwv\0`\0\0BV\0\0\0\0aRswwwwwwwwwwwwwwwwwwwwwwSct%$$!GWe%6Www''sWg\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!7www\0p\0\0\0\0B@\0\0\0aCWawwwwwwwwwwwwwwwwwwwwwuu%BPRRu7VSrW5wWsW0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 www\0w\0\0\0\0\0\0\0\0%0\0 !awwwwwwwwwwwwwwwwwwwwwwrwr%%%6t54uwww''wwA\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0www\0\0\0\0\0 \0\0\0\0p@4Wwswwwwwwwwwwww7wwwwwwwwuwBRBVwvwrsGwwGw\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0! www@\0\0\0\0\0\0\0\0CC@444wwwwwwwwwwwwwu7wwwwwww p%$%%cWRWWwuwqw0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!www\0\0\0\0\0\0\0\0\0\0\0pSscwwwswswwwwwwwwwwwwwwwwqg&4sWcwruswwwtq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Wwwp\0\0\0\0\0\0\0\0\0\0 aa%5wwwwwwwww7wwwwwwwwwwwwwvqAaA`  aug5rtswww0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0''ww\0\0\0\0\0\0\0\0\0\0\0\0 wv7wssW57W5wwwwwwwwwwwwwwu4\"PrApwCwWuwuuwwP\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0$\0\0\0\0\0\0!w`\0\0\0\0\0\0\0\0\0\0\0g 45uwwwwww7wwwwwwwwwwwwwwwwgE$%qvSg''qwswsp\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@@p\0\0\0@\0\0@\0\0\0ww7sWwwwwwwwwwwwwwwwwwwwww0pbPBQgewWvqgWWp\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0v\0w\0 p5%%4wwwwwwwwwwwwwwwwwwwwwwwwvV %%$5cRpwwww''wq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0R@\0 a\0t\0  vSw7wwwwwwwwwwwwwwwwwwws uwu0t\0CF5''WwWu5wpp\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0%$\0\0\0p\0p\0\0wauwwuwwwwwwwwwwwwwwwwwwwtqgsweSAe$Vu'' gwguwp\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 \0aB\0\0\0\0\0\0\0\0\0\0 ''wwwwwwwwwwwwwwwwwswqvtwwp$6R`t6Wu7wwrWs\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0%WpRwwwwwwwwwwwwwwwwwuw wW wea@VAae%''ewuwwq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Vp`\0\0\0\0swCR\0 a 5wwwwwwwwwwwwwwwqwwpspRuaw4s`V%vSV4wwpp\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!a\0\0\0\0\047wwwwu5wwwwwwwwwwwwwwwwwwwuww %6g aaBRAe%wsewq\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\06\0\0\0\0\0\0\0\0\0$447v0qwwwwwwwwwwwwwqwwwwrGWW wrP64%$6RRWwww\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@@\0\0\0\0\0\0\0\0\0\0\0\0\0\0W''wwwuwWuwwwwwwwww5w5wspQ t0e5$PpABRAae% GC\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0   `\0\0\0\0\0\0\0\0\0\0\0\0tw7Wwwwsw777wwwwwwwuw5vwwRPpGw@rC@RVsqw3\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@\0\0p\0\0\0\0\0\0\0\0\0\0wvwwwuwwwwwswwwwww7wwwqqat5  aFW $`PRVV6ss\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0uw\0\07@\0\0 \0\0ww% wwswwsW7Wwwwww5ww7wp \0sBp5%seppR@ \0$45qs73!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wv\0w \0 `\0\0u\0\0t7V7wwwswsW77www5wwwvS p5%a`p''%$%%`pCA  Gsw6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 www\0w@\0p\0v\0 wt!guwwwww7sSWwwww7wpu4\0` !rRPWwRR@pp`@t47332\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\07wwp\0w\0\0gp\0 w\0WwBV!wwsswwqssswwwwCwwwAw0%aAe%%Ru%v@CG CBww720\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\07www\0 \0p\0w\0''wpVswwWsSsQqu7wwwpPSw644 A`put4444ppV7sss!!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0wwwt0\0\0\0W\0\0waeww0Wsw6447 wwwu0''wprSCA`46stppaa6abRRC@a  %asw776\0\0\0\0\0\0\0\0\0\0\0\0\0\0wwww\0\0\0\0\0\0\0\0uBSgpV7WsqrsSpswwsaAwwAA\0A''''\0@RU5%4`RP$7sw7371 \0\0\0\0\0\0\0\0\0\0\0\0wwvt\0\0\0\0@p%vwsG6wwWuwCAwwpRWw!qaew''40@ %45! v!ag7agSB3swsv1!\0\0\0\0\0\0\0\0\0\0\0\07wwww\0\0\0\0\0@\0Ru4pCGqr57scwsswww%''uvPqwwPA%5B\0R@R!GPpwwwws3s3s73\0\0\0\0\0\0\0\0\0wwwuvp  \0\0!Ae''RC%cwwwu5usuwRww RWww7wqq 0 PvpPGw%7!a!%''Agwwwsww7w7rs3\0\0\0\0\0\07wwwww\0W@\0\0`\0 V4Ru57sSw75wsww@0wgqwwwrQA wwwwWa$pA'' wuswssw373sss2P\0\0\0\0wwwwvw\0'' \0\0t\0uw\0gRwuWguwsuwSwGvqqwwwsq 7@Bw@!w7rp` \00@wWswsW73wsw77#s341\0\07wwwvWvWP\0\0 w\0w@$RwsS57qsqwwswswu5wwwwweuqv0qA5aCCC\0 7wuwwww3s3ssw7733#\007wwwwwwW`p\0\0\0w@0PWs\0%WgwqwtwqswwWwwwwwwwuss @\0AvQ%CB  %4\07wW7qsw7w7w7733sscs73wwwwwWwrwp7\0\0 w\0\0&wt\0\0cW57wg57uwwwSwww7wswtp\00\0wW$4\0\0W%swW7wwwSW3w3777v7733swwwwwwwGuw\0\0\0\0\0w\0Qwr\04rwqwwwwwwwswwwwwuqwwWp\0u  \0\0a\0ww7u55swswswsss3s3w77wwwwwwwwwwp\0\0\0\0\0\0$7t\0CuwwwqsW57wwwwwwwwww7Qs@\0\0v0\07pp @@\0p7w7wst5577777s7s7wwwwwwwwwwvwe \0\0\0\0GC@t7wwwwwusWwwwwqwwwwwu5gr7\0\0\0t0   5 7B\0Puvwwsrqsssss7s7wuwwwwwwwwwWp\0\0\0\0\0\00v\0twwwwwwwwwwwwwwwwwwwws C\0\0 S@\0\0`1\04\0w7wSwwSRw77SCwwwwwwwwwwwwwA\0\0\0\0\0C A\0VswwwwwwwwwwwwwwwwwwwwR4P7p\0\0\0  \0\0\0qswSuqrq6cRs0w1wwwwwwwwWwtwwr`\0\0`\0\0p\0t6\0 twwwwwwwwwwwwwwwwwww$A 5p r\0\0\0\0p\0pwW767SssSqSpWwwwwwwwwuwwwuu\0\0\0\0 \0G\0\0t7wwwwwwwwwwwwwwwww7SwwR$wrww\0\0\0\0\0\0\0\0p\0\07Sct5cSqR1pq%715s7wwwwwwwwwwwwpav\0\0w\0\0w\0$7\0\0Vwwwwwwwwwwwwwwwwwww!CA PCAp \0`\0\0\0\0\0u''5sw577VSSRSC1pwwwwwww7wwwwwvC\0\0w\0G@SWp\04swwwwwwwwwwwwwwwwwsSAcP40u!B\0%\0 `\0\0\0\0\00sqwSSAsQ3W6551t1wwuwwwvWwwwWwpt\0\0wp\0wp$vq\0CewwwwwwwwwwwwwwwwwWvrPwawBCq\0`\0\0\0\0\0\0\0psRq''776S%541rRCwwwwwwwwwwwwww@w\0\0wp\0wpWv\07wwwwwwwwwwwwwwwqswat7\00@pPpPa\0 %\0w57SRSaq53S1rSww7wwwwwWwwwwt0\0\0\0 \0\0wp`wu\0BVwwwwwwwwwwwwww7wwpqqp\0\0u\0!a\0!\0aA%!sG57qsSCRWG1ppvwwWgwwwwwwwvWs\0\0\0\0\0\0\0''7v\0!awwwwwwwwwwwwwwwwqq\0$6\0\0pPuuv@ptWcwrW437u1w#RwCwwuwwwwwuwwt0\0\0\0\0\0\0\0P''\0\0RVwwswwwwwwwwwwwWqg\0S\0\0\0\0\00`0$As wt47Wppq#RqS RpwwwqwwuwwwwwwwB\0\0\0\0\0\0\0p0\05wwwwwwwwwwwwww7wqa\0 P$a\0p \05@0$5$wwSpsq17Q5r5qq5wwwWvuwwRwwwww\0\0\0\0\0\0V\0acswwwwwwwwwwwwuwwq`\0!\00\0aar@pA\0awwwrSSRVQsCa1sQ!!C%wsWgwvwgwuwWuvr\0\0\0\0\0 p \0\0twwwwwwwwwwwww7w \0\0\0qa\0 pww7qap717%0w%#qs5wwwwuswqww7gww\0w\0\0\0''\0\0 \0\0Pwwwwwwwwwwwwww7w00\0$% \0 \0\0\000 te wwwwww SqsgQ 2Swww7swWwvwwwwwtu`\0\0 p\0 p\0\0$$wwwwwwwwwwwwwWws@ \0004\04P\04 swwwwwqps15''7R16qcQwwWwwwWwWuwwwgp\0\0p\0\0Gt\0\0swwwwwwwwwwwwwsu4\0\0\0 C!!w\0P1wwWwwu5w 1GRQap1saa6wwwvWwrwwwwww s@\0\0wp\0\07R\0`twwwwwwwwwwwwwwws\0\0\0\0\0541qsA!Gqwwwwwswq 01c csaAwwwwwGuvwwguw\0T0\0\07v\0\0ww\0P wwwwwwwwwwwwwusW\0\0\0\0\0!SSV75w5ww77w7wwwpqaCRrP7wwqwwwwwsGwwwp \0\0\0 w\0 w\0`pwwwwwwwwwwwww7ws\0\0\0\0\0\0\0\05155rqw7wuwwqww1ap7swuwwwgwwwu7wWsWww\0\0\0\0\0\0  w\0\0p wwwwwwwwwwwwwWsP\0\0\0\0\0\0!3CW''57sWwWwswwwwas!cWwwwwwwwwwSGu7wewwwwvwa\0\0\0\0\0p\0\0$\0 \0wwwwwwwwwwwwwwswp\0\0\0\0\0\0\01p1qwWqsssuwwwwwSWsswW7wrwwwwsvuwwv7Wwqw\0\0\0\0 \0\00R0`wwwwwwwwwwwwwwSs\0\0\0\0\0\0\0\0!0557sqw5uuw75wwwu!sw7www7wwuwwwwuwwuwwvqwwa`\0\0\0\0\0$At#wwwwwwwwwwwwu7wp\0\0\0\0\0\0\0\0\0aRPsu%w5g777uswwwww57w5swwuswwwwwv5rv7wwwwwwp\0\0\0\0$\0\0RP4Twwwwwwwwwwwwwww\0\0\0\0\0\01470SSsVqus4wwwwwwqqw5wwwuwwwww5wwwWwpwWgww@\0g\0C@ BpCwwuwwwwwwwwwww4\0\0\0\0\0\0\0\0\0\05#35sw757suwwwwwwwww7wwwwwwwwwuw uwwewwsuwpwp\0u w Rt0Rww7sSwwwwwwwsWw\0\0\0\0\0\0\0\0\01ArQ#P57RW7wwwwwwwwqwwwwwqwwwwwwwqawwwuwwpRw\0''vtwV\0wG%uwwwwwwwwwwwwswp\0\0\0\0\0\0\0\0007Q75#pq77SuwwwwwwwwwwwwwwwwwwwvW''wwwwSgwwpwRwGwaewppR7swwwwwwwwwwwwS\0\0\0\0\0\0\0\0\0\0QqqqpaSW7WqsCwwwwwwwwwwwwwwwwwswu7Wwwwwwwwaec@wwD%wRCwpp''wwqwwwwwwwwwqssP\0\0\0\0\0\0\0\01##5a0qS17wwwwwwwwwwwwwwwwwuwwwwwwWwwwwp!Gw!wawe$wwwwwwwwwwwwwt5! \0\0\0\0\0\0\0\0\0a#Q553tw3SwwwwwwwwwwuwwwwwwwwwwuwwvwwwwV!B!BPwwpppqwwwwwwwwwwww1p\0\0\0\0\0\0\0\0RQ56SE3cW wwwwwwwwwwwwwwwwwwwwwwwwwwwWwwsC42R R  wwwwwwwwwwww!a0C\0\0\0\0\0q51p5uqq5wwwwwwwwwwwwwwwww5wwwwwwuwwwwt\0CCDp% Ra`$4wwqv7qwwwwwwwP5 pR0\0\0Sq5u541!4S57wwwwwwwwwwwwwwvuwwwwwwwwwwwwwwpp44C PCaBpawwwwWwqcwwwwwu5a %\0\0qg553asW5qwwwwwwwwwwwwwww77Wwwwwwwwwwwwww\0a`4 ''0a%qvww7wwuwwwwwwwwRp5cRVw#Ru 47WwwwwwwwwwwwwwsWwwwwWwwwwwwwwwwtw\0V0`% wwwwwwwwwwwwwwwwww0pAa wwwwqqq5%5sSsSqqwwwwwwwwww7wwSwwWwwwwwwwGwwwwwwvw`AGw p``wwwwwww7wwqwwwwwwwwwA0wwwwwwwwwqqp%47wwwwwwwwwuwwwwuw7Wsw7wwwwwwwwGwp%pw$0w`aBwA`Raww57wuwwwwwwwwwwwwwwvwwwwwwwwwwwwwwq''wwwwwwwwqwwwwww7w7wwwwwwwwwwwwwwB@Gwu$4w4wwwu77wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwWwwwwwwwwwwWwwsVwwuwwwwwwwwwwwww7aa\0wpRCwv\0&57wgwwswwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwSuwwwwwwwww7wwwsSwwu%wwwwwwwwwwtv w%%w@Pwuwu1wwuwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwggwwwwwwWw''wwwwwwwwwwww `w!`Rw4 2@wwww7wsSwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwu55grwwWswSawwwwwwwwwww \0 `\0@@''wuwww7wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww55uswwww WwwwwwwwwwwwCCC C !`pa$wwwwwswwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwswwwwpswwwwwwwwwwww\0\0@$\0`B\0\0\0 ww\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0֭�'),
  (5,'Grains/Cereals','Breads, crackers, pasta, and cereal','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�)\0\0BM�)\0\0\0\0\0\0V\0\0\0(\0\0\0�\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0�
\0\0\b\0\0\0\b\0\0\0���\0\0��\0�\0�\0\0\0�\0��\0\0\0�\0\0�\0\0\0\0\0\0\0wwwt\0Cs@t7777 7wpCpwwwwwwwCwwwwp\0S@@g5wwu\0t\0\0@\0P\0BP\0\0wwp\0B 7777sww0  3w0ssrP\03t0\0\07777w7v CwwsGsswv7wwwwwwTwwwww@ P%swwPSPp\0P\0\0\0\0\0ww7ssssw3p@\0@@pq!Cw776r\0\0swwwwww7w@D''Cs 7wwsCAwwWwwWGpwWwww@ P\0wuwwp@aC@\0\0\0\0\0\0\0ww\0\0wssw7ssw\0@\0\0 777sSas\0\077ssssu @@@E7tww777wwwgwwwwwwwwwwp\0GpGw7wwp\0\0\0\0\0\0\0\0wwp 777sw77 \0\0@@@qsssw7774\0\0 wwwwww6D@BG 77wwwswwWwwwwEvwwwwu\0w wSwwu\0e\0\0\0@\0\0\0\0ww3sssw3sw\0@\0\0cw7sssss\0\0\0@@ssssw7p\0www77swwwwWwwww BwwWuwwwwWwuwwvs@\0\0\0\0\0\0wwv7777sw0!@\0\0@77777774\0@@\0\0wwwwsu6RD@@@G777wwwwvugwwwu4uuww7wt ww wwwqVPCQu\0\0\0\0\0\0\0w\0Cssw  \00@\0\0ssssss7r@\0\0sssswcE4\0BDswww7swwuwwwwwwgRpw5wwqw7wWuwwww@\07 q\0\0\0\0\0\0@Gwpp3sw\"Ss70@\0 7ssssv@\0@@\0wwww67 D@CwsswwwwwwwWwwwwWwWGw7wwwwwsqwww@\0\0u1v\0\0\0\0\0\0\0wq\0 73Q''7s3Csa`77w7sP`\0@\0\0@ss76Sw7ss@@w#ewsswwwwwwwwWwwVwwWwwpWvwwWww\0P\0sWq\0@\0\0\0\0\0 w@63 W0\0as7p\07\0\0@\0wwwe47cw  sD''7wwwwwwwwwwwwwWRwswwwpGwswww0u7P\0\0\0\0\0\0\0\0ww\0@\0Csssp7#q`''7s73s44\0@776@Cgw7ppw74Stwwwwwwwwwwwwewu%%wwwquu@ wWww@ \00ww\0\0\0\0\0\0\0wwSw1\0\0 7s ss7`\0S6` %cR\0\03Pwepsw7psww$  7wwwwwwwwwuwWgwTWwwsv\0w7ww\0W7w\0\0\0\0P\0\0\0\0\0w4 q7R77737\03@@737%447 @C@GVpwwssRPwu''wwwwwwwWwwuwV7wwwwwq@@wwsWwpSqWp\0\0\0\0\0\0\04\0 sCQ\0P!\0w77w77sp\0\0qw70ssp@D''`7777wwwsFVWwwwwwwwwwwueTwwwwWw\0\0 wwwu\0qg7P\0\0\0\0\0\0\0\0\0Wu3WPq0cs33s4\0@@63C w750@\0`Gwwww7sstauvwwwwwwwwwwwqcw5wt''p@Awswwwq 1qw\0\0\0\0\0\0\0\0@\0 P %q0Sqww2@\0\0\0CT0w3sr4@D@Dcssw7swt4ugwwwwwwwwwwu7VWuwwq@t\0u57wwsu\0\0\0\0\0\0\0\0\0\0sAP4\03p\0@# swsss\0@@Awww7wwstCGVWuwwwwuwwwVtwwwwww7C@twwwwwwwwp\0\0\0\0\0\0\0\0\0\0w75At0u!\0\0\0\0@\0Cs77777@DD@@w777w77wagCgvwwwwwwwuegWwwwwww@Rw7wwwww\0\0\0\0P\0\0\0A7uwRqA7!w@@@77sssss@\07cwww7wwRWEwWWWwwwwwwwwqwwwwwwu5@C`@wuwwwwwq\0P%\0\0\0\0\0\0\0AgRqPpwPq0@\0\0@\0sw77777D@t@sT$7ssrwwrVwgwwwwwuwwWVWuwwwwwpq@T w5qwwww\0P\0\0\0\0\0G W5PQA@qpqq1\0@ 73ssssv0\0gw6SGswwW77wuewwwwwwwwwvwwwwwwwwww aw7ssSWww\0\0@@\0\0pww W0 %Sw\06\07BSsss@t@w77@t2wqcgwwwwwwwwwwwwuwuwwwwwwwwSSuwWewwu7www5\0\0\0\0\0\0B\0wPSW1AA6P453\0  p\0''7723gsww4\0GvwwwwwwwwwwwwwwuwuwwwwwwwwwwwsWww5www P\0\0V\0\0\0W4!VQp sRps70BSw5#sWw7w77swsSD wwwwwwwwwwwwwwwwwWwwwwwwwwwt pwwswwpP\0\0@\0\0\0P SuaS4q5177sR@70BPs#swwwsw7w$@erwwwwwwwwwwwuwwwwwwWwwwwwwwwQwwu7ww\0\0\0 0@ w6SPs1qqAwSC73ssC0@\0077w7sswsw$DRwWwwwwwwwwwwwwwwwwwvwwwwwwwwPgWswwwq \0P@\0 qAu\0w1A% pRW7q$sws67r@\0@CCqwwwww7p@@t@ewwwwwwwwwwwwwwuwwwwuwwwwwqwwpW''wwwwwRP\0\0qp wPsS4e%SSCR7s7\0\0\04ss777qt$CG GwwwwwwwwwwwwwwwuwwwwwwwwwwwwqwwwwpC\0\0s\0\04p5`sAPQ 1p1ap\0\0wwwwwv7t@dt7wwwwwwwwwwwwwwwwwwW wwwwwwwwwvWwwwwq\0\0PT\0\0\0@@ qpSC5gWv557q\0\0\0\0@w77ssqae%4d wwwwwwwwwwwwwwwwwwwvWwswwwwwwp@wsWwwwq@ \0\0\0\0\0\0wRqa\0qSqq \0\0pW44\0@\0\03wwwwV7ssdBSwwwwwwwwwwwwwwwwwwWWqtwwuwwwwwu Wwwwwp\0@P\0\0@''VSA5@PqpqCA\0$\0\0swssqsaswwSTGwWwwwwwwwwwwwwwwWvwewCGwswwwwwwv55Swp@\0\0\0\0\0Tse5DC 15 1\0 \07\0@763wwvw77v7wwrWwwwwwwwwwwwwwwuwwVT5wwwwwwwwpu tp\0@p@\0 P@qEwsawu@s@3`0\0pBqscSwvw7sGwwwwwwwwwwwwwwwwwWwwVwwwwwwwwwt0@q!t\0\0P\0 ppWQsA@SA501Bw\0Sw\00v@DvRswwwwwwwwwwwwwwwwwwwwwWwuacWwwWwwwwpCTwqsS@\0PR\0pWqD\0pasS01 4wAC\0\0\04w33\0@@BCwWwwwwwwwwwwwwwwwwwwwwwwwwwWwww7wwwwu 7wp7wWw7wPRS3WPu57pBV5@0S\0wv@D@ 7wwwwwwwwwwwwwwwwwwwuwwwWWuewwwwwwwqwwwwuwswt\0Wpu%Awr@QqAq%\0@BP7PA@\0\076S@DBDww7wwwwwWwwwwwwwwwwwwwwwwwwwswwwwwwwwwW755wpvuww45pQAv4 qA0AA\0\0\0@\0sss @@@V7ww7wwwwwwwwwwwwwwwwwwwwwuewWwwwwwww@%wwWvw7sWAGswwwQ@C$QAq5Q \0 %\01\077 @DBD$7w7wwwwwwwwwwwwwwwwwwwwwwWwwguwwwuwwwwVaA@pvWwwwqACAS0Aqq0\0 QAsq@\0@r@WsvwwwwwwwwwwwwwwwwwwwwwwwwwWWwwwwsWwww\0aaa@D\0 w51t7wwuwACAqaA\0\0G@\0P 72@Dst5''7wwwwwwwwwwwwwwwwwwwwwwwwwGWwwwwwwqGPpa\0PegSSCSW wwpCWp\0q\0@1\0A@\0$ \0r@wswBVWwwwwwwwwwuwwwwwwwwwwwwwWwuwvwwwwwwpCCC w 57u7wqqwwwu54Fs\00P\0\0@\0P05swsuaawwwwwwwwwwwwwwwwwwwwwwwwuwwWwwwwwwuA@@P@Aeqqe7wwwu57wwqq PqpR @\0 \00 sr\0wswswswwwBWwwwwwwwwuswwwwwwwwwwwwwWuwwwwwwpp44%!wSwSSqwwwwwWwwww5SpPAq3 50swswswwwatvwwwwwWwuwuwwwwwwwwwwwwwwwuu7qwwpA@PWAgu53WwwwwwwGewqp%5 4a7\0\0ss2\0wswsww7$Gwwwwww7qwwwwwwwwwwwwwwwwwWwwwwPgwG 0w%wqwpwwwwwwwwww54wSQ@@t\0\0@P\0\042Pswsww7tTeuuwwwwuww7wuwwwwwwwwwwwwwwWwGW WW5psTW575w7wwwqsGwwwSPww1@PP\0\0\0!Cswswswwse$wgewww7wuuwwwwuwwwwwwwwwwwwwWw%pw%gWGwswwSwqsSqSwswuwW5wWwww@W\0a\0 q\0w7swswsVRWtuwwwwusWw55wwwwwwwwwwwwwwwwwWWwWWSwWwwvW5w1uw7wwwwwwww50\0Q\0\073swswsvswwugwwwwuwwwsWwwwwwwwwwwwwwwwwwwwwww7u3aww3Sqwwswu5wwwqswwwqu7W@\0\0w77swswqwswwuwwwwwwWsu7wwwww7wwwwwwwwwwwwwwwuwu1qqwW5swwuwwwwwwWVW W41@P@\0\0rsswswCg''wwwwwwwwwssWwSW5wqwwWwwwwwwwwwwwwwusswq5wwsusA77qsqqwwwwwquA@CP\067677swpSWwwwwwwwwwwWws45wwwuqwwuswwSwwuw7ww5u5qR5wwwSu7pwWuww5wwwww 5 R 507\0sswCd6w7wwwwwwwwusw7qwswwwwwuwwwWswwusWs1sSqw7SwwwswSsS wwwwwwWWqP\01\0r@\0 77p@@D wwwwwwwwwswsCWwwSWqu557wwwSwSwspqwqqqqqu75qwSwWwSRWwwwvqwqWw0s1\0prdtWwwwwwwwwwWw555su1qw7wsSwwu7wSuu70111wswwwQwwu7755%gwwwqwPw7\0WQ7r0\0 4\0@@DRBwwwwwwwwwu7usSww5su5qwwSWsuww57wS1S0qwuqqu''wwwuuwqSpwwwwAD50\0us753p\0\0@Fuwwwwwwwwwwu75wSWqR7W5557swSSWwqu3qq0sP1QwqsSwqGw57SsqwqGWuwws\0Asss6\0\0\0Dt7wwwwwwwwwqwuwSws1qqqqqaquw1 7u7sWqu77wwWw7Sw1uwsquwqw%7wwwAsss6\0\0@Fc@GwgwwwwwwwwwqwwsqSWqwWwq51 wqwS5qqqww7Su1qq7WW7qu7wpPTu5wwwqq777S\0\0@\0u%7wWwwwwwwwwwwu57wsWqw57su57w5us3qwwwswW7wwswWw1w7ww gwwRWRWssp \0\0\0@c@Rwwwwwwwwwwwwquwsqu557SSusp1Ssu1wW71q5SSp1wwu5qw3SW55ww1770G7sww5\0Psr\0P\0\0u%wwwwwwwwwwwwww5uqcWwu57S715777W51wwwww5u5q7wwu7WSSP\0Cw7wwwq@S\07673 \0\0Rw7swwwwwGwwwwwuqww555q7w705wSW5w5571CqwwwqwswSSSwW3u51@\07sA''7w642C3Cs@\0wwwwwwwwWwewwwww5qwsaww7SsuwSSSSq51u71q1qq151swwwwqwSqcwwwSsWSS B7ww7wwsP\0C730\0777swwwwwGgWWvwwwqw7WwsqsW7710Su5150sQ1 wwwu5557wW75q751\0\0Ssssw7w4\0\07C''\0sCwwwwwwwwVvwuwwwwWW7usWwWswWQsQ5151%7A11177wwwsw7Ww7WSwQsS7777sw6@\0\03Rss7wwswwwwwuuvwwwwww5wsSww5qu7531q0155q1wqqS!wwwwwqu5qswwwswSw\0sssss770\0\0@@@#773wwwwwwwwwguwwwwwwW555 Qswqq751QSSSS55!wwwww7wswuwwu7SCq\0s''7777sBP@\0\0ssscsswwwwwwwwuwwwwwwWsWsqsqwSq2SQ15q15SwwwwwW7qwwww7qsqR P 77700\0@\0\0777777wwwrwwwwwwwwwwwwsWsWSQqp5wqww55aq1SWwwww7qwqwwwwwuw51sp\07723@\0\0wssss77ww7GGwwwwwwwwwwww757501wwsswS1qqq10q057wwwuw7wwwwWwsqsSA70\07%$rs7\0! 77770wrD4VWwwwwwwwwwwuuwWWCSqWwwwwqqaqsq0517wwWwwwwWwwwwwqwSQ!sr\00\0''3s@\077\00sw0\07GCG''wwwwwwwwwwwwsu77Wswwwqu71%w5q1q30usW7wwwwwwwwwwwu1W3s72\0@a70CsP7723D4dTu Gwwwwwwwwwwu7WSSqa55awu7sSSQ5%q5qsw7sw7wwwwwww773w77\0\0\0CC 3sc\0\03r\0rCG %gvwwwwwwwwuwwwSswqsSwqSSqqQ70S7q!53  SquwW777wwwwssWWsWw3sp\0\0\0\0@\0 7w77p\0\03dTtVuwwwwwwwwvwwwwWSW5q51w 57A75SSu57Wsswuwwwwwwwuss33w7\0\0@@\0\0 3s3ss7p\0@s %qegwwwwwwwwwutwwu757WsqqSuq7sW51%17Sww77Wswuu7Swwww7uw7w0p\0@\0\0@77sw7sp\0@\0\0\0\0tVwrWwwWwwwwwwwwwwwusSswu5511 543SSW%q5wSquw77swuwWvu3s3p0q\0\0\0\0!#s73s7\0\0\0@@\0qetwwwwwwwwwwwwwWwwwwu5wqsQ3SSW#q3SU051715svsSwwswwSWu7Cw7 \0swps2P\0!777ssw1`\0\0\0\0wrswwwwwwwwwwwwwwwwwSSSwW3Q1u''Q5q3SSwwSSwuwww7w55u0 4\00s470\0r@\02770`\0\0\0\07twwwwwwwwuuwwwwwwwwqwwwsqu5CSRS7SsSSspwqw7wwsqsqqqwssws0\0ss\0sw\0\0ssp%3\0sswwwwwwwwvvwwwwwwwwwswQwWSq51q554555553Wqw ue57WwuwswW5s@7#0p72p\0\074%67 \0\0140wwwwwwwwgWWWwwwwwwwwWWswwq55sS1%571qp4qwqcwwwwSsqu7qs7qsw5\0\0P073s04 4\0Rss\0!r\0\0wwwwwwwvugggWwwwwwwwwwuqqwq55!qqSSq1wq4qgSSu77WW7q7uqv sp\00ssssss0\0\07% ''7 \0wwwwwwwwVwWWgwwwwwwwwSw7qsSS 571%GSqwW7qww7wWwursWw7qw55s@7777770@\0\0\0`R3sr\0wwwwwwwwwVwewwwwwwwwwwwwqqtqu57SSQ51a3ugv7W WsasuucpqsSRSw 77777`\0@\0\0w772ww wwwwwwuewwwwwwwwwwSquwSSwwsS7RqSWsWAussqqswwuwWsSWSRRu5su7v7777773\0\0\0\0\0 s7ssss`wwwwgwwwwwwwwwwwwwwwwwwwwwSuwu515q1q1qwWswSuug ww5%7wqeu5%55qs77p4@\0@\0s7s7770\0 ww44wwwwwwwwwwwwwwwwwWqqu1uq7swW51sWwwsusCG7qavWWwup146!rw7Rssp0\0@\0s3w3w3s@\0wwugGVwwwwwwwwwwwwwwwwwww7u07Suqq7qwwqquwWuGw v7wSCWqWVqu5PsCsp!c7701B3w3G\0\0\0w4$4uwwwwwwwwwwuwwwwwwwwSwqSuswSS57wwwwww5sCqwquww5w5p RCAq%t555\03s \0w\0\0C7s02B\0ugedt6GwwwwwwwwwGwwwwwwwWwWqq%ww557wuwuu%5vuwWaqwsqwww %''W RsSss\0ag7\0770\0\03aq1\0$PG E5wwwwwwuetwwwwwwwwwSswSSqw7wu7ww7wwaqwppwWupspSR5p\0PS!uaqapP007ss`\04\07#r\0edw4dvwwwwwwwwvwugWwwwwwwwu5squ7wwWWuwwwSAWCGuww7swW51RSSA%W S0@CCw77752\0\0@Ss1PG7u4wwwwwwwwWGgTwwwwwwwwwsW77WwwWp%gwwWww5545suwquwWqaeP1454445t41S\0 73ss3s@\0@\0 4 cw4wCGwwvwwwwwwwutwwwwwwwwugwwWwwwww WuwwWRRW5puwawsqwSq0@SRQ\0rQR51R577w77w\0\0\0\0@\0@37uw7wwtwwwwwwww CwwwwwwwwwuewwWwWwwu6uwuwswSRW wwu7Ws@\0S@rSPP5%7Q%!03s3ss1 \0@\0\0@33wwCtww7sqwuwwwwwwwwuwwwwwwwwwewwWwwuwuwww5wStw4 upW7\0\0SA440 qA Pq7w75`\0\0\0\0\07w3w77wwwwwwg Gwwwwwwrwwwwwwwwuwwwwwwwuw5wwWwSWSAu7wQwC@\0\0 4!aaqA\0pq%''77@\0\0\073#stww7wwwwttwwwwwwwwWwwGwwwwwwwwwWwwwwwwuw7qwsWuw7wu\0\0A p\0\0 Qq@7rP 73\0\0\06 777wwwwwwveE47WwwwwwwwewwwwwwwwwwwWwwuwwwwWVqucGWwewS@\0\0GpPapqe\0\001%0g6p\0\0srs\0\00\0\03sw7wwswwu`V6GFww7wwwwwSewwwwwwwwwwwwWwuuwwwsWcu55qsGwt\0\0SeP!APuQs@77702p\0\07 wwswww66VAdswwwww6FGVWwwwwwwwwwwwwwwwwwwWquwww U557Pu6wq\0\0RP\01q%\0\0\07\0w10\0\0\0wwwswwGW4d4Cwwwwww6u5t5gGwwwwwwwuugwwwwwwSw wwWwu''wGt4RRSSQaV AA\0\04P\0\0\0sw2sc1 \0\0swCww7sswPD7V4wwwtuwFVpwwwwwwwVWgwWwRTwwwqw5wWSW7W4WvRQaru\0@\0\0Qqe\0\0\0\077s773\0\0\0wst77pwwp77wasCwwww75uaGwwwwwwwwwWWgWwsGWww7uwv7gwwWw5sPqqu WR@P\0 P\0\0\0cw7ss7 \0\0\0Cww`G77wGsstFww7 7ww%GwwwwwwwwwVwgWwuwpuqtuwSWSWqw%%vWugVqaa51!@\0\0P\00@\073ss7p\0\0\0\0t7wp@agsCswwsqspewwwtw7swSwwwwwwwVWwwwuwrwsCwwtsWquww 5qpVa@Pp\0A\0\0700@7 rw77s\0 \0\0\0wp77ww77wtFV''ssswwwGgwwwwwwwwwwwwwuuuut1Ww5wwPuw5wWSSRW\0S@\03s@\01q\0\0w7 \0\0\0wpt@D$''w77ww4Pwtw7wwsWwuwwwwwwwwwwwwwwwSWwwuwvWw74wSwu%e%Pt4@e\0g77 7#@@''3prs\0\0p\0@@Swwsw7w`pd47wwwswwtrVwwwwwwwwwwwuwSe%sWq uawWSVu%wSupqCpSvP@\00@sss\0\0s@57\0t@`DT 7sswst4tDGw7wsww6uuwwwwwwwww7wwwSAegw evusWWwwRW5q\0@@\0@@7w777sw\0@usrc6\0`7g7ww5cC@BBF77w7wwwEevpgwwwwwwwwtuwwwwwqqAAAGSWusrRwuqeqwRW\0\0 73ssw3@\0\0\0sss`D74Cp\0G77rSw7@DGwww7sarRAGPwwwwwwvtwvvwwwwwwwwwpwwtTuuwsGswG!@\0\03sw7sst\0@@@@pssss\0spsppwBV77qw sppswwGwwug@wwwwwwwwWGWW wwwwwwwwWGWww7w7t770sw1`\07Rw777p@\0\0\0 777774w\0sw47p@awsG 77BV7st7777prwwwwsu%44%wwwwwwwppppsw7w7w5$ t  27\0C`\0\07sa 44\0@@qsssssspwsssssp\06swww5awCwwwwwwwuwwwwwwwGGWwwwwwwwGEeeFWwwwsssp\0\0\0ssp1s70\0sRss0\03ssssw\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��'),
  (6,'Meat/Poultry','Prepared meats','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�)\0\0BM�)\0\0\0\0\0\0V\0\0\0(\0\0\0�\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0�
\0\0\b\0\0\0\b\0\0\0���\0\0��\0�\0�\0\0\0�\0��\0\0\0�\0\0�\0\0\0\0\0\0\0s41$wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww%wwwwwwwwwwwwugwP5 wwwqvwwwv477sqrscscS773srs\0\0$ Gw7wsw7wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwvvwwgwwwRGuwwwguv 777#srsqsqsw77w677s4wwwwwwwwwwwwswwwwwwwwwwwwwwwwwwwwwwww7wwwwtwww7wwwwvwwggw`CWwwug3rssssw77777773ss3qss$ wswwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwswu$\0\0\0\0\0\0\0Aewwwwwwwu''u5gwww74ssqsss7777''7''63G73swwwwwwwswww7wwwwwwwwwwwwwwwwwwwwwwww6\0\0\0\0\0\0\0\0\0\0\0\0\0@PwwwwwwwpWwwws77''677csscssssq73sv7wswwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww4\0\0\0\0\0@A`tg@\0\0\0\0@ewwwwwwRAgww7w777773srsw77757ssr77wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwsR\0\0\0Ggw7wWsSwwwe @\0\0Cwwwwwtwww7rSssSg7771sqsr3777sswwwwwwswwwwww7ww7wwwwwwwwwwwwwt7\0\0\0w7SBG4ttwsp\0\0@wwwww\0Cwwww777773sqsw67''7wcss77wwwwwwwww7wswwwwwwwwwwwwwwwwwV7 \0\0\0WvPda@tt\0C@``@t7v\0\0\0Wwwwu$wwsssscsw7763ssss35''5sswwwwwwwwwwwwwwswwwwwwwwwwwwsww\0\0 w0RPp\0\0\0@%%u4\0\0SwwwS@wwww7''771sssw7777W3sscwwwwwwwwswwwwwwwwwwwwwwwwwu44wp\0\0\0wupG\0@\0@\0@\0@\0@@@@e$w\0wwwtpwwsw57rw6773ssss#w7773wwwwwwwwwuwwwwwwwwwwwwwwCrCw%\0\0wrRB@@\0@\0\0\0\0@\0\0\0\0\0\0@\0PA$ w \0wwwt Gwwsss3s7676SsCsws7777wwswswwwwswwwwwwwwwwwwu76 4gP\0\0Gu\0\0\0\0\0\0\0\0@\0\0\0C@wp\0 www\0www7''w7ssSs677737scsCwwwwwwwwwwwwwwwwwwwwqv7%wtwp\0\0wrRW\0@\0\0``ptT$\0@\0\0\0@aaw\0\0Gwwtww7ss73qssw777''w%777swwwww7wwwwwwwwwwwv6%4v4sp\0\0gtP@@\0\0\0WGWWuwWwwWwwp@\0\0\0@ w\0wwwuGwww7Sw''7''3ssss3g76WGwwwwwwwWwwwwwwwwwSSu6g5gv\0\0GqC@\0@$VSSwwwsu''cwwuwt\0\0\0\0@CC p\0Gwwp7wwsw63sssw773qwsVWrswwwwwwwwuwwwwwwsSrp6WcVRRq\0@wVD\0@$W77erW0WwWuuwWwwwv@\0@\0Pw`\0wwwAGwwssw7771rRu6rW''75wwwwwwww7wwwwwssC`qgSdt3cw\0\0 r4\0@\0ewpqawW5Gaw47w77vw7wt\0\0\0@\0CAp@ wwt4www73ssscs76qw7wecGwwwwwwwwwwww%%47vqds2VWt\0w@@\0\0GSR WpsRwpwu%%rSuuwWt\0\0\0\0BW0wwwwwwww75%swGw7pw777wwwwwwwwww5!7V7gt7s5eww\0\0wt \0@usg!qevSw sSsW5wWwwww`\0\0@ t\0 wwpwwssqcsswCsqg rsCGwwwwwwwww7qcvV%pu''Cq%gwgv\0w`D\0VSCWSpqg7 S 45%wCrw7wuw@\0\0\0BP7` www\0www77Gwswewsww77wwwwwwwwPs   uvw''rWwtwvp\0 pV@\0\0Wpq%47asCW%4w w551e77ww\0\0\0@w\0WwwwWwwww7Wssru7w#ws7wwww7s''4rwv1!qwGwVvww\0\0wa\04wVV@sSG5cCWRqpsC w@\0\0\0C@7\0 www wwwwwg656Ssg7Ww7www744vwG7AacvvVwfwGw`\0 u$\0@\0SG14sw%4qr7rq %45tqagu\0\0\0Gp\0wwwuwwww7www7ssw3sw7wwrpsww4t674wwwggWgwep\0w\0S@\0\0GwCRCW PSSCcqrWq7pSRp7`\0\0\0 \0w\0WwwwewwwwwWw77w77w77S7AwGFqcCGggVugWgWt7\0\0wV@@@\0453V77w0W qw 5'' Gwwwwuw\0\0\0P`@ wwww''wWWGwwssw7w7sswrpw`rsc wwwWugvvvtr7v\0 p \0\0w t1ppupq@s ''sSe61qqCWwwwuwwwt\0\0pwww7WWwww7Www7qcv5v7Awg 40pvevwggwggu7 7F\0WU`\0\0w  RpwS Sw447wW1qwwWww\0\0\0\0@Gq\0wwwwwwwwsu7wsw7wwsWw`qagwwwgGtvvwW647 7p\0sA`\0\0EvCSwpu%77a7w1cww5w6Cagwp\0\0w\0wwwwwww7\0ww5g7sswwg agwvwegwvwweg4qcGtw\0w\0\0\07qc441pSqRSVSV5swpSs 7ww\0\0\0\0@ p wwwwwsPq@P ww7wwtrsqwugGVVwggrp75''6u'' c\0Cpu`@\0TsWCRR t40677!wS%!uw %471rSCauw@\0\04 pwwwws%\0\0wwuav5wagvvwwgwvV5CvtwRts\0 @@\0\0cqu1!sWsQqqWw3SWsq55!RW477sp\0\0@A p wwwupRCGp\0www7swwwwuwGggwrW1cw4ew %2340@\0\0 uw''e45!v52  7gsu446W a%7%!sCrRWt\0\0\0B@q\0wwu!  \0Wu\0 wwwwwwwvvvwwe'' 0g@ve652S3p\0wG\0\0 RSQsCRQrU05%54ssSWw1t0qqpSqS7wP\0\0w\0WwwV%u%wp\0wwwwwwwwGwsCRprG5g7%2a!c760\0sB\0\0uersuqa4rW2WWw''1q%wCSRps6`\0\0`S\0''wwqaCwrT7twwwwwwvwt4saCusFsBS 73a3s\0t%@\0\0@SqRW04%5w0%7quwawv5%%5$6SAqswP\0\0g\0Wwwwt5GwRWwwwwwwwwws3s%''tbVq41''3rsS773@qD4\0 AtV5!wSRG5sqqcwsq7wqqaCSSC`Q'' 5wp\0\0\0B0 wwwq`5wt0wp wwwwwwt4adwV7W!&ssc73''3ps0r@\0\0\0tsusRPqq4s ''VWuw%6446U7%qps t\0\0@T P wwwwWCGwG wPwwwwww3sWsds@!cq71s5sSs37\0uG\0\0Ce%7vWCqucWswwW7SSqq2PR   su\0\0\0\0  wwwwwwpWw\0WwwwwwadbVS43773s''2s#63sss\0Gp`P\0\0@`GSu!qwgWR1wwSqgwcpSCesSqss5p\0\0t'' wwwwwtvWu\0wp wwwwwWsW3%#ss''3s53ssR71s@ p$\0\0 t0t7 Upw75w wwww!a57 5u%%%%%wp\0\0Cp wwwwww5waGtwwwwwbV pss6''3a73s5371r3\0u%\0@\0\0pWqqGgprpSSCCusWuwSuqv 5''p753Rt\0\0\0@ 0 wwwwwwtVwtw\0wwwwwW3ss7573s72s63csr770 rC@\0\0GgV7qqw6Ruw7 5wwwwsw1t5w PppRP5w\0\0\0@$ P wwwwwww%wwpwwww p33a2s63cs72S75#3qs\0pT\0\05qw CAce5qWsV7wwwSVS!sq''75''wp@\0\0\0PS  wwwwwwwTgw`t wwwwss63w1s3q73s35727\0p $@\0\0GvWAsWsUsGw#W7SWwWsv77cV47SSCSpwp\0\0\0''Gwwwwwwwwwu w\0wwww333ss3r73ss63s ''2qw3pw\0\0@4qsrS%7W45%A%sww7wwqwSW5sRqappww@\0\0\0PW\0 wwwwwwwwaGw@wpGwww6s67C73c''3ss''3s73#0\0q`d\0\0G6WpSau''uws7Su0qwwqwswssCw7Swqu\0\0\0\03\0wwwwwwwwww wpWt7www3s3q33c1s63s71sssrp7P\0\0\0Guwau0Uwe5t2RWwwwwsvW%u7pqaguww\0\0\0@@4\0wwwwwwwwwwAww w wwws663w77#s3q7''5s''3c32\0G@`@\0\0r5s wp52SrsW77wwwSsScu7www04\0\0\0\0q\0wwwwwwwwwwt wpwuwww3q3r3ass''073s273a72ss\0p @\0W \0wCS4u5uwwvwwwwwwWwwwwwwCS\0\0\0pwwwwwwwwwwwPwt7wwww63s737sss''771s73s5\0 p`T\0\0wqe''upsSwcsesSSWwwwwwwuswu0t\0\0\0  \0 wwwwwwwwwwwpWwGwww73r3c3Sc6''3S1c63s61r''\05\0\0@\0Wqp usPw %7wwuwwspstwWC \0\0\0\0Pq\0Gwwwwwwwwwwww ww7RSgss7673ssqc7''3s7416Sp\0W$@\0\0 u wp%7wwwwwVwwwwwuwVww5%\0\0\0@@\0q\0wwwwwwwwwwwwwwwwcwwW3c7s3q37373sq73GCc''W\0 pS@\07Sw!0RPqqwu67wwwwwwwww5 @\0\0\0$p\0wwwwwwwwwwwwwsCsWwwws7r6567''sss#a%G25uqc\04@\0\0GppqpA!057wsSuwwwwWwwwwwwRQp\0\0\0P \0 wwwwwwwwwwww7 wWwgrs73s3s3s770rVR6V667@\0w\0p\0\0\0wWRSRRwSwwwwwwwwwwww%6@\0\0@@\0q\0gwwwwwwwwwwwSGwwgw57Vr6s563w73 5 0vwwvww5w7\0Ct`@\0\0Gqa qp 57guwwwwWwuwwwwwsSq\0\0@\0@Cp\0wwwwwwwwwwSsgwww7%www3s7#3s44&w555swuwws@7\0P@\0\0w0wwuu7Wau7GWwuqEsWwwwwwwt\0\0\0@\0\0 wwwwwwwwwswWwwqauwwvws53ss47%aCsqcSCrsuswwwwp\0W$\0\0Wuw6t!sCV7wwu4sWwwwwww\0\0 q\0wwwwwwwqcSe6wu47wgwvww7#43CpC #BV5''757susw7ww\0 pA`\0\0 wuwwuwSWGw7W7u5wuwwWwS@\0\0\07\0 wwwwwwwwwwwww''wwwwwwww3s3aar 6qG75w7Ssswrwwwwwp\0W$ @@@\0wwwWwwwssw7Gwu5WWwwwwWt@\0PBq\0 wwwwwwwwwwwG7Wwwgwgwvw43@rRW4qc\0 sqsw757ssWwwww@SA`P\0 wwwwWwwtsGSwu5Suwwuwwsa\0@wwwwwqewwwwwwwwwwwwwwwS73a7%''!cswg63Csaw7swwwwp@w \0wwwwwuwwu7wWWRuwWwu7qwu\0Aa@ q\0GwsRVRSWwwwwvwvwww567G@rrRV0ss7Rw377sqw7wwwww\0 wAB@\0wwwwwwuqwwwwwU5wu6WWWSG%s v\0P07Wwwwwwww%vwww7%5%#aw4wwSss77wwwwwwt\0rAB@wwwwwwwwutu7wwU5wwt%`Sp\0 \0\0\0\0@AA%7wwww7wwwwwrR 3qw7#sw7w500tqepu77wwwwB@WQd4\0\0Wwwwwwwp\0RWWwagWw  @w\0P\0\0\0\0\0\0\0RRuwwwwwwW%435%sss3s77sq0cw7777rTwWwwwu\0 we@E%%t4RT\0@4WwwwWQwwPG@Ww\0\0\0\0\0\0\0wwwwwv7ssw 37 7rsw77RP4771swwwpwWwwwt\0 w@R@\0\0\0\0\0\0\0\0 PsWWwqwwTpp7\0\0\0\0\0\0\0\0\0\0\00q! Wwwwu77ssssssc57CS1%75CAC1puWWewwwwt\0CwPP@@C@\0\0\0\05eswwt%pRTwP\0\0\0\0\0\0\0\0\0\0!ASP1wwssw2777 7773arwpCsGwug@qwwwwwwpwpAae$\0@\0CWWWwWV@ w0\0\0\0\0\0\0\0\0P!% www7usssssqrV%!''S\0GtG vWwt5\0Wuuwwwww@ w4Ae! $qwwu4\0E7w\0F\0\0\0\0\0\0\0\0\0\0\0\0\0!0q7sww77''770cacsWu0WwpdpGu5twpa5wwwwwwww@\0ww\0@DDT%uwR@usu \0Dq@\0\0\0\0\0\0\0\0Aaq Wwssssssqg7 ce0 \0CtG vFRWDCwwwwwwwwt\0\0ww5\0\0\0\0\0\0uwwt\0\0Gw@\0\0\0\0 \0\0\0\0Sq1wwsss0c7Ccp47Cp@tw@`VW5eeq`dpuwwwwwwwww@\0wwwvqcPtwwww%\0\0Gww@\0\0\0PAACP7psw7w77gw 6wp4\0wV\0wDv@@CSwwwwwwwwwwD\0\0\0Aau7WwSRPp\0\0 wwwp\0\05% 5! Ppqsw7rs7!%%www P\0aw\0VwWuwetduwwwwwwwwwwww@@\0\0\0\0\0\0\0\0\0\0@Gwwwww\0 pq0APp5qGwsw7w wwwwww$pwPv\0WaGGVvWwgwwwwwwwwwwwwwwvVD$egGwwwwwwt%0 SPqquswsss!%wwwwww5\0B\0B d@evtpuwvWwqwwwwwwwwwwwwwwwwwwWwsWwwwwwww4\0\0\0\0\0\0\0QS1q0q5%T7wsw77wwwwwwwt6WpB ECGGegvVWwwwwwwwwwwwwwwwwwG0CTwwwwwwwwA\0\0\0\0\0\0\0\0\0\0aq Su!wswscswwwwwwwsP@\0A` pp%$$`VVWeegwwwwwwwwwwwwwwue5\047wwwww\0\0\0\0\0\0\0\0\0\0\0\0P\01qpsPswsssswwwwwwwtp\0  t\0\0AGgwuwwuwwwwwwwwwwwwwwwwpRq 4SuuwwwwwqA\0\0\0\0\0\0\0\0\0 445557wswsswwwwwwwww5@@@@w\0GBVuwwwW4uwwwwwwwwwwwwwwww ''wuwwwwR\0\0\0\0\0\0\0\0QCSW0sw7sr7wwwwwwwwp\0`@\0vwuvuwW4qwwwwwwwwwwwwSt4ppBsAsGwwwwwwS\0\0\0\0\0\0\0 A40540w7Cs5wwwwwwwwwR@\0@d\0A@RGuwWuwu5U5uwwwwwwwwwww SWe1u tsswWwwww@\0\0 @P0ASA w7Vwwwwwwwwwwwq$`@D$$4SvSWV7CRWwwwwuwwwww\0sAp@qutWwwwwwwP\00\0\0@\0AA0a  swwwwwwwwwwwwwwwR@\0@RP$\0CAeupu4uwWuwwwwwwtwwww\0q@0pP pssw WWwwwwppP\00R wqwuw7w77wwwwwwwww0\0@\0P%$5qauqu7W7Cuwwwwwwuwwp%BPw\0eGqwwwwwwwwP\0Caa!ACwwwwvw''wswwwwwwwwwwwqt$g@D PCW RuuuuwwwWWWwwwwwP5\0\0\0sG!wWwwwwwwwwqa\0\0PR7wwWwswwswwwV7wwwwwwwwwwGwww\04UpRwwwWwwwww7wwww@0\0\0@qGpspWsWwwwwwwwwwpqa%%%%wwwwwuwwsww77wwwwwwwwwwwq%wwwW@$ SqaawuAuwwwwwwwupwwww@4\0  @rqG6Wquwwwwwwwwwwwswwwwwqv7sw7usWwwwwwwwwwwwwv56SPtu PBQqgW5ewwCuuwwwwwwwSWwu`\075wqewgswwwwwwwssw7wwwwrSgwwwwuswwwpwwwwwwwvsqqvwp44r\0paPq0uEw7wwW7wwwwwwwwsww@\0 rSgSAw5uwwwwwwswwwwww7swww7ww7swwspwwwwwwwRStwvwgwsPup4@%4wSsW5wvWwwwWwwwwuwwA\0\0qG4qwt5wvw7wwwwwwwwwwwwwww7u76wwgsGwwwwwwg6wewvw7 GwqGCu7300w Wuuwswwwwwwsw4t\0as\07qapw7vqwWwwwwwwwwwwwswswW7wwwg5wwwwwwwwuwWww%4ugwwvwqsw3q 5q1q5wwwuwwwwwwuwR\0\04 u w sWqwwswWwwwwwwwwwwwswswwwqsWwwwwwsSg6vw''cawgvwvwesBW6S s`e7Wwwwwwwwwww`R\0qaRWwqe4wwuuwwwwwwwwww7swWqwwwswwwwwwww7wuwwwsuvWwwwwgwWsS3wssSuwwwww5wwwwpr 7asRSGvw swwwwwwwwwwww7wwwrWwwwww7W7wwvwt7Gwwgwggwww`w75cw# gu0147wwwwwwwwwwwpAqatvwqw uwWwwwwwswsw7wwrSwwwwwwwSwwVwwwwwwwgwgwwgqvrSc57qASWwwwuwwwwuw@sPwg5wpw7wwWswWwwwswwwWwgswwwwwww''swwtwt7wgwvwwwsqqgaw7SawGe!01q3qCwwwuwwwwwwwtB#e0wqCvrWqw7uwwwwwwwwwwsSwwwwwwrsqgvqg3vwwwwvwwvwWgww477v535w 5757wwwwwwwwsw7pA`WS7puqwu%wuw wwwwwwwwwswwwwwwsw7WwwuwstwwgwwwwpwwgwggWu''w2Q6ws!0CSwwwwwwwwwwww571%wps ww 7wwwwwwwwww7wwwwwwsv7wwgvsrWwwwwwt7wwwwwSqs''SqwsSsQqWt!%1 wqwswwwwSwwsVqGw0 wWwqwWwu7wwwwwwwwwwwww75wGwqqvWwgwwwwwwgww 7677Wsscqc07pSgwVuuwwww7w7wwsgw7sGWsCwwuwwwwwwwwwww7rWgwww77wwwwwgwtwwwww3sCsrs75%1''57SCq51wS1%wwwgwwwwwwwwwwwqawqspwWw wwwwwwwwwwwwwCwwwwgsewvwwvW7wwwww57Cs777''w3SSCw15SSwRwwwwwwwqwwwwwwqvpwwAgu%r7WwwwwwwwwwwW57wwwwqsGwgwwt77www7%rsswssssWw07qqqprp1s51%wwwwwwqwwwwwwwwqw7qww5w7uwwwwwwwwwsrwwwWcRwwwwwwsspvwwwsGw77773csssw34w 51w5uSwwwwwwwwwwwwwwwprwwqwwwwwwwwwwwW7wwwrwwwwwws%74wwrw7wsssw7cwsrss45#q0wsGsSp47141GwwwwwWwwwwwwwwwwW  wqgwsvwwwwwww77uwwtw7wwwvwcwsewwsWsGswww77777776ssVC Gsu0wwwwpWwwwwwwwwwwwwsu%7wwwwwwwW7wuvwwsuwvwwwsW7Www4v7wswsssVsSssqss773q7sSw05305 waWwwwwwwwwwwww77wSwwgrWwwwwwu7wtwvwsRwvwwwsCw7gw7wcqwsww7ww77757757sS5sRScW!cS4pwwwwwwvwwwwwwwwwwwwwqasuwwwwww7wwwwsw7wwwvww7wRwswv5wwws7Ssssscrscrs3cs%755''1s45rSgwwwwwu7wwwwwwwvsWwwwvwwWwwwwwu7wvwwvw5gwwww57qruwWrSwwwww7sw7777777777cs1W73C!srqsWwwwu7wswwwwt7swswwsqwwwwwwucwwwwwsqwwwwww7sagwww6wwwww7Sw7srssssssss77''5!R73cw51wwwwscwwwww7wswwWwwgRwwwwwwwsswwwwu7 wvwwgqpwwwur47wwwwwSswss%7575757sSsscw%u51q asw7svuwwswwesWwswwgswwwwwwwrwwwwgw7wwwwwwsv7www7r5wwwwwww7w7w7ssrscrs''6767773s3awqswwwcVwssswwSswgwwgwqwwwwwwsswwwwu7wgwgwwRwqvww7RwwwwwwrScss7sw777777ssssssss777 Cwww7%!w7w7wwVqswwwwwG47wwwwwwru''wtwCvwwwwwwcu4wsw CwwwwwwqcW7Ww7w77ssssss77777 04rVRswCCaasws77w7777wwww777wwwwwww7 7wgvsswwwwwwq''''w6Wsswwwwwwq77sw77sswsssssssssssssww7sw77w77777w7wsswwwwwwwwwwwwwwwww7wwwwww7wwwwww77wwwww77wwwwww77wwwwww7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���'),
  (7,'Produce','Dried fruit and bean curd','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�)\0\0BM�)\0\0\0\0\0\0V\0\0\0(\0\0\0�\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0�
\0\0\b\0\0\0\b\0\0\0���\0\0��\0�\0�\0\0\0�\0��\0\0\0�\0\0�\0\0\0\0\0\0\03''3s3ss73s!wvVw4w!&WwwvVwvwwwtpwwwwwwwwwwuwwuGWwwwwwwwww7wwwwwwwwwww7wwwwwwww!6w\0 w\0\073s72373s7!sa7wvwsawrWwwgwwvwwwwwwwwwwwWwwwpwFuwwwwwwwwwwwwwwwwwwwwwwwswwwwwwwRA%vp`3''s71sssr73ss07cG wgVrs 7gwwgwgwwwwwwwwwwwwwWwtGWVwwwwwwwwwwwswwwwwwwwwwwwwwwwwwwwRcv733s73733s773ssswVWwWGw''Vwwgwgwwwwwwwwwwuwwp`pueGwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwpCws7s72ss73s#773su#cw''gwavw7CGwwwggwwwwwwwWwwwtwew%wwwwwwwwwwww7wwwwwwwwwwwwwwwwwwwww03s72s77#ss73ssc755''WRwwu6swwGwwwwwwwwwwWwwwtwtWFWwwwwwwwwwwwwwwswwswwwwwwwwwww7wwwwps7sw3s773''3sw7373ss1#7VVvutsswvwwwwwwwwwwuwtTgFu\0tuewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww723373s3ss73237sw777sCswwvwtwssWwwwwwwWuwwu`eBWuwPGVVWwwwwwwwwwwwwwwwwwwwwwwwwswwwwwwwwwswsss''3w3737sss733rs7747 wwwaewswwwwwwwwww`GVwpdeuegwwwwwwwwwwwwwww7wwwwwwwwww7wwwwww337373s3ssv37773sv77ssssw vwwwwwwwwwwwwwwpRS@@GGR@CGV''gwwwwwwwwwwwwwww7wwwwwwwwwwwswwwss3rs73r733ss7#s''3ss7777swqwwwwwwwwWwWuwtdRVVdWVtvq7Ggwwwwwwwwwwwwwwwwwwwww7wwwwwww73773q73r7773s77773ssssw7swwwwwwwwwwWwwq@BP5a@D@gtGTu''v5wwwwwwwwwwwwwwwwwwwwwwwswwwsw3rs3s7#s73s7''7sss7777773sw7swwwwwwwwwwwd$\0@@@D\0GwwFV5&rRGwwwwwwwwwwwwwwwwwswwwwwwwww777773s71s73s3s77776777w77swwwwwwwwWwwtP@BA\0\0\0\0t@wwpGWGGRW57wwwwwwwwwwwwwwwwwwwwwwwwwws33s3s73s63s7s7s73sssss3w77swwwwwwWwwp@g\0\0@\0\0 @wutttwebG!gewwwwwwwwwwwwwwwwww7www7ww777673s63ssss3s3sg7777swsww7w7wwuwwwwtuvEe\0\0\0D\0WvV7etRwwRVswwwwwwwwwwwwwwwwww7wwwww3s3ss''7373737''7''73sssw7sw77wwwwwwwww@RGGu4pPW\0wutGu\0vTCGw%$gs\0gwwwwwwwwwwwwww7wwwwwww76w7733ssw3sssssssssw3sw7wsw7wwwwwwpD$gWGDew`@wwF DgtGed4$wqpwsWwwwwwwwwwwwwwwwwwwwww3s33sss733r73ss777773w7ssswwwwWuwwtpBPEv@G@ wtD\0Ep@VTw vw@FsVwwwwwwwwwwwwwwwwwswww77w772s677773sssss77sw7wwsswwwwwt\0G@@@RFu\0E@@@up@d\0EBegGcscBVwsDsvwwwwwwwwwwwwwwwwww3333sss73s3s773s776sw77ssswwwwwww@TdBD44@WvD@@Vq@tEGu%cGGrV%c wwwwwwwwwwwwwwwww7w%!777sw777''7''7''73w3ssw7wswuuwwp\0@a`@@V@Dt@ww@\0\0D@@DFTVRugse&sG5cF$0f7wwwwwwwwwwwwwww33sw!#S733ss33ssssw3w77sw77swwwt\0B@GA4\0GPwVt @\0\0 peeGwgSq$vVtqe''Vwwwwwwwwwwwwwww%!tpw73s7w37ww777737sw77swwwWwt\0D4\0Gp\0Gwteu \0\0@tuwDeeewvRS!&vSe$c gwwwwwwwwwwwwswsw4pr703ws33ssssww77wswswwws@\0dwQ\0\0t\0\0Fwt@t\0\0\0\0 @GwqGBVvwwvVcGtvwrspWwwwwwwwwwwwtp5swuasS#Wwssssw3swssw7wswwt4\0@A`\0d\0\0WwpAWp\0\0\0wwvueegwwwf0rGw4 605wwwwwwwwwwswwCgRswg''33sssw7w777wsw7wwt\0\0G\05@\0D@\0w`tevw\0\0\0\0\0@wwwuPFTtvvvtwvS%rwVVWC  ''wwwwwwwww5rwt7Wwwv7u67sssswwwswwwww\0t@P@\0\0\0Wt@VPt@\0\0D$wvWe$GVRWgGgdgwCGecv4v2SwwwwwwwwwC547wrRw57ecqswwwwsssww7wwp\0\0 G\0\0@ v$ V\0w\0@\0@\0WuuuW\0eedwewwvwwwsrt Gqd6sGwwwwwwrww7Rwwtvwswww77sswwww7wwww\0@GC@\0\0wTte\0@V@@\0GwdwBPueVVwvwvtvwww''q`gwCFc0wwwww54sww7%7wqwwwwww7wsww7wwwwwp\0\0\0@\0@\0Wpg\0\0V\0\0Ew`S`Gt@EdtvwdvVwgggvw\0Cwqcc4gwww7wsswwwwwwwwwwwwwww7wwwwwwq\0\0@\0@P@\0GwtDA\0\0@D\0\0\0vqEvTVS@GpGGCVwwgdvwGGwa\06vFGg6RCrgwsw37w7ww7wwwwwwwwwRTFDdwwwwww\0@w\0wC@\0t\0\0@BPtwuDu\0\0D\0wDt7''gwwewvvwwsSqdqg7 $1wwswwwswww7wwwwvu`@@\0\0\0\0\0evwwwv\0\0\0\0tTt\0\0\0@wwwst\0w\0\0wgG4u7Vwvwwegwvtpq&gGGesC37s7ssswww7wwu%\0\0\0\0\0\0@\0@www\0\0\0Wt `@D\0\0 \0\0 wwAD@GP\0\0\0 wtwG''ag4wggVudgggrQ!44qrtvswwww7wwswwwwe\0\0@P %eerW\0@Swp\0\0Dqee`E\0@\0\0\0Wwu@q\0\0\0DwupGvwVsV6VwgggwtvwvsCs&gGsVs7vwwwwwwwu\0\0  uwwwWvwwu%\0w\0\0\0GtG \0\0\0p\0@dww@GP\0 ww\0wVwgcW GwvvwwGGwtvcFeww7sswwwwwu\0\0WwuwGWweuegWwwA`p\0\0p@@A@@P\0\0D\0 Dw\0D\0\0\0wwD\077vVut624''qegfvvegggaa756vwwwwwwwq@\0 wvVVWww5wvTuduwwA@G\0\0\0@B@t@\0\0\0wDged\0A\0\0\0 u@\0\0swwwvweecS vtwwgVwwgwvSC7swwwwwww\0 wGGwWwupVSWd WgWwp@\0\0G4\0P\0@G@@WP@q\0\0u\0\0wwwww  VVSa`vCgGwfwWGgwvw3wwwwwwwwt\0\0twtWpwS57WDeEgwWe\0\0\0\0P@w@@@t@gP@@@ut@\0wwwwwwv7''egwat6qgwggvWggFGwwwwwwww\0\0wwDwdRWu%40PqtPWWwwtP\0\0@@@@@\0\0De@e`V@\0\0wt\0\0\0gfVwgwwugSwC`vrSe''gvwgVwwvwwwwwwwp\0uCGDSEwWQA\0Vegeeeww\0\0\0\0@\0\0G@GP\0@P\0G@ut\0\0\0TtPdegwgCwWG gRG''74gwwgwwgwwwwwwq\0EwVt@Eewu1Wsp@WWWWWWwwu\0\0\0D\0\0 Wtq\0\0R@7wWC@\0 GfFFGdtF@B@ww@csFT6sCBCqGgvVfVwwwwwwt\07vFVWwWqwSQR7wwwwwVWwt\0\0\0Dts@D\0\0\0DGae\0\0DttugVVGefTdFwpCs''ettw42sqgewgwwwwww\0wduwuw5wUq55Wwwwwwwuww\0\0\0wt Da\0\0\0\0 D\0wT\0\0VvvVgFdgdtVdtB@dw`50rvgegGacCrwwwwwwwt\0ttugWtuwww40AwwwwwwwwgWt\0\0GP`P\0\0\0p@GP@@\0GtttedwGVVfgGFtddurs RV56%6Gwwwwwww GGuwwwwSQqQwwu5wW7uuww\0\0\0t`@\0\0\0GTpu\0\0gGggwwvwgguttgFTd\0d53%#rVevVpr00wwwww\0 wuwqwqwwwu  wwwwwwwwwWt\0\0\0w \0\0`G@@\0gwwwwvvwwwwgggttfVF@Gf73p0qrVagGgwwwwt\0wtwWwau5wwquSUwuququwwwwww\0\0\0EpDa@P@@W@\0\0wwvwgvwwvwgwwwvvvVedtas3s !vTg%6wwwwpwWwwu57www51!P''wW77 SQwueuwt\0\0 D\0\0`@w@@\0\0wwwwwwwwwwwwgvvwwwvVed`Dd''773r1''4Wewwww\0GuwqqwwuwwwQW1\0WwwuASSGuwwwwp\0\0p\0@wT\0\0wwwvwwwwwuwwwwwwwgggvVed`ps3733RRrVwwwu\0 vuww5qusWwq01q uw15eqqwuwWw\0\0\0\0@@Ww@\0\0 wwwwwvvvFfVttwgwwwwwgefVF@F773qss3!%''wwww\0wuwu5pwsWqwvC !wwuSCwV5sGuwT\0\0p@ wT\0\0 wwwwwed@TAG @t`egwgwvVee`D`sp367773wuwp\0wWwSwWsVu0QqSQu5w5wwWtuwwp\0\0@Ww@\0\0 wwwwv@Au7wsQEBFwvwetd\0E#7733#373wwwPwwwwPuwsuqsq!C wwqP7w wuwuwpGp\0\0DT\0\0 wwwwd\0Ag7wwq5us5PDgwvdVTcs373SsS7wpwp wWW5quuwwqaqSppqqW5wSGWGqgww\0w\0\0\0\0\0\0wwwwd\055w7w113S7WwwFd\0G3rSc3#63wPwP wwwuprSWwwqW!u\0\0ww5wwA5u5twWuwPWp\0\0\0\0wwwwtAqqsuwwqS%s51w@Gvuadd 3373s3swpw\0 wWwSqQusWwws0uwwww7w0wwuwWw` w\0\0\0Wwww`@wssw75Q1Sw''vtgDc77373s3wPw\0WwwqpW7V5wwwqAqpwP\0uwwqWWWVwwwPWwp\0 wwwd5wQq57wu07q!sQ11151w0gv@g@Css1c5#7w\0w\0 uwWq1qaqWwuwW SpwwwusWwwwwWWwp ww4wwwwA%7sSW7s11SS15w\0wwD`D32w7373w\0w\0GwWwWPWwqSSuquu5 \0WwuwW%wwWwwWwwwGwwwDSsqq13Sw!105q1177spvpeCs33s3sw\0w\0 twusSW5wwQ!QCw7P5wwwwwWtuwwwuwu wwwwwt q%usCQ711SS1P755\0gvD$ 777''73w\0w\0Gwwwu5wWwu1Q5uwu5u 7wwwwwsSRuwWwwpGwvwwvAq753qS11C71501qpwp\0vv@C3r3327w\0w\0 quuwwwwws\04wwwsWwwwwwWPASwwuwwwuwwu7Sw71%1q43QqSS1SswP tds773w\0w wwwwwwwwu7wWWQwvWCWwww54twwwwuwwwwD5sqp1111q!0111015w77\0gt@3s33sw\0w@ wWwuswwwq1\0 WwwwwwqqSGwwAAquwwWvwwwt75Sss11!7SQqs0s1uwGgcs7673wwwwwuu7wP\0PwwwwwtP4wu5 GwwwwqWwwwA55sq!SsQCSsSSwqvD3c3s''w@wp\0wWWSwwww1wwwwww\0sRP7Wuwt wwsAqs7S51sA57sq551!57wwbCs773wwt\0wwu SWwqq\0u1q7wuwWwu4Wu4 WwwwuGwwT11Sq1Wqq17wq1q7sw10Swpt7333swpws\0 uwqwww1PWwwu7wS@7SAwwuwtwwCSSq71173sW71q7Cq1q15%7w\0vC3ssc3wtwu\0 wwW%ww57wwswqSp\0u5%wuwwwwp1ss7s1051sSq1s70WwPv 7273swsww\0w7wwwqp5Wwwutq4AspSWvWwdwwT5!505337715SWw1AswwpR3sss7wuwwp\0 wWWVwwqS\0P5sWvqq7\0euqewwwwQwwaq153S1111sqq!11S55517wwQ5wwwwRe#3373wwwwp\0ucw7WWwS\01SuwQSssWswuwu ww5515111qq71157 wwwq7s5577\0p5 3swwwww\0\0SsQqwqGq\05q75AAwuusuuwRWwpSs1!5wSq110755111SQ1uwgB323wwwwwp\0\0EwwCSwPS5wwwuwvwwtwT7Qqwq3q1s11w1q1Cq7BG12wwwwwu\0\0@\0Stq\0 @G5%5q\0wawWwWuwwQwwpsq31170S111sss1q 7u7Cw4 awwwwww\0\0\0 SPAw55a1wQ\0wWWwWvWwu wwq5311ssq qw51101wQQ57wsCCVwwwwwwp\0\0wSeqpwtwwu5uwuwq wwUwwdww CS55701Sq3w557S05qq15RwWw\044sacwwwwWww\0\0\0WwWwQuwQwwwwwwpWu5vwwuQwwtS1q513S7751s7w111Spwsq57wPccwwwsrwwt\0\0BVU7wwpwvWwwwwwwW5wUwup wwu%q1S1RQ51175ssSq053ww51qusWwwt5c`wwwwwSgs\0\0W\0AeuwwwwqwwwwWtwwptwwVwwwpS1q1q311p11SS15115w5''5SS737wwp''sR4wswWwwqwP\0\0u\0GSwwWP@wwWWwWuSWWwqaSwwwCqSS0Q577Qs17ssQSWWwqw7sSsww3wwwww7\0\0\0wFWSPwp$ wsqu5stqwwtPwwwwtw11151q0110sq3S0W1wqwps337wWw477wwwq@\0w0\0BWSu\0TFWuwpTwwp@wwwwPwS57q1q1!53wwC7wrs3w3sqgwvww0\0\0u5C5$5CGtt wwtwwwwwpq1114141Q!17SW0Pss77w4w777wuww@\0\0 wu5\0FDDdDPQuwwP@CWwwwww q53S1ss30555351q5731%3QWq''2ss33s3rssrSsgwsP\0\0www51QAaSSwwww\0wswwwwp!1515111s1ss51q5u!Q77q1t\0q47sw7w77777 5sWsp\0\0\0@Www7wwwwwwt@@\0WwwwwwwwV51511uqsq1wwSwsqS5SWww3rW3r3sssss3r5''7wp\0\0\0\0@VWWWGD@@\0\0swwwwwwwwpW1S3SSPsS11wW3w11qaswwQ110swp cF2w77sssssw7s7%7w\0\0\0\0\0\0\0\0\0\0\0\0\0Vwwwwwwwwwwps1QWw1SWsq1ws1wwu115wpw5a6%3ss777773s7ssscqw5!\0\0\0\0\0\0twwwww7SwwwwwpG61q75551uwS7571!ww1wPag7CV7s7773sss73ssssrwwwwppq477wwwwwwwwwsw%www sAww3w7WwSq10sqq5w`rRRv7s7sssw72sss777773 wwww7gwvwwwwwwwwwwwswu wSWsQq71C515wwq151wS50w5%''RR773sss77677w77777s wwwwwvSsswwwwwwwwwwwswwq111773Sq3ws11w5577wQqGww5!ass77''3ss3sc373sss7spwugwwwwwSuwwwwgwwwwww0wsS01q1111Q51wSWw75517www wwww73ssssw77s77w''sssws7747sGswgWwswwvwwwwwwwwqGW511!sSS1111S1sqww73wwtwwwwww777773rs73s3s77737sssp4stwwvwwsGwwwvwwwwwt3sS11115s11q1SwsS0wwPwwwwwwssss77sssw3w7s777s3w77s3C0swwwww77wwwwvwvwq1q53s310q 1q57wq1!wu''wwwwww773sss73s#73s7sss7w3ss77775#Rwwwwwwwwgwwwwp7S11!q111w171Swuw371wvWwwwwwwsss737sw7sssw3s7737ssw3ssssw747wwwswwwwwwwu551qqw73q71 51qq1S1wwwpwwwwwww3s63ws33s7773w63sv3773ss73s3sssCVwwwu7wwvwv 1Qsqqq3S7w1q11u1ww wwwwwwws717#3ww3sscw3sw737ssw''3s77w777ssWuwww47wvww1505SS5311w7Ww51R1W7wwqwwwwwwww63cc73w7773w73sss''73s67sc3sss777''6wwwsswwt sqsSs1151SSq1wQ%wqqsS7wwwtwwwwwwww17wacss73ssw3ss77777s7s3s7sssw77ssSsgwwwqvw`u5 5511 517w7WsSq51wwww wwwwwwwwccswwu%''1g773s77c3sss7s7s7s7773ss3ssqqwwgvqs SSSsS11SSS 1wwwewwwwwwwwwwtv7swug3777ss3g73sw3s3s3w77''srwssssaauwwwt\0q511!q550sw1S50sS5wwwwwwwwwwwwsw7CGwssVq3ss7773s773w7''3w3sss77377''77767wvwp sSSSS77S1q\01qwwtwwwwwwwwwwtvwwsrRwwsvu47sss7rsw3sss7''77777w7''777ssu''5cw@w511q11s10w7qSA5q1ww wwwwwwwwww7sssw7w7sRs2r7773773w7763sssssS3ss773773sC4w0 w555S51w1S1WwTwwwwwwwwwwwwwpssswssGwwue7Cssssw3w777777773w3ssswssw3ss0u\0Gw11113Swqs7wwwTW6wwwwwwwwwsssvwWww7sGrw7G7t45773w3ssssscss73W7773773w3773s\0ww5557W77w51q wwsCv4swwwwwwwwwps47277sssu''w7g7w''#S3w77777776ss7773w3ss3wssssp\0gs50q0wsSQ7swwWCcCCawwwwwwwsvwwwGSswwwsqaawwswwW''73s773ssss763scs#s77s377777SS1ue5qw1WwSwp\0cvwWww%''swwww47qew7''aqcsww7746tw7rRR3ssw7777ssss3ssscs#scs''3''7\05q17w1!7wu55wwwUu56ggw''4444wwwww7 Gqw''77777wsq7 Gwwwpr753ssss777773w3s3w7373sss70\0 WwuwWuu5wwwwwwvtGgwapsugVtwvs&qewwspwwwtwCGsswwsssCw7wuars7777ssssss3s7s3ssss737777\0wwwwwuwwwwwww Gwvwvwe''qgcGwGprw7wwww44t7777%673wswptscw%%!css777777773773s73sss73s7@DuwwwwwwsVVvwvvvwvwwcCCTw`vWewwwwwwwsswwwwwsswwsww7swwwwww73ssssssssssss73s7373s73s731aCEettueeaacwwvwwwgwvwwvwcrWwvwww\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���'),
  (8,'Seafood','Seaweed and fish','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�)\0\0BM�)\0\0\0\0\0\0V\0\0\0(\0\0\0�\0\0\0x\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0�
\0\0\b\0\0\0\b\0\0\0���\0\0��\0�\0�\0\0\0�\0��\0\0\0�\0\0�\0\0\0\0\0\0\0!1!!\00 Q\0\0\0\0\0\0 \04''Pa1aq 3RRCAa!@0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!!C%%\0 p0p\0\0\0\0\0\0\0 1!S4046CSQC5#BR`\0 \0 \0\0\0\0\0\0\0\0\0\0\0!1AP0p04R\00s\0\0\0\0\0\0!\0\01 0q@prSSSqsAu%467acCR5%%$p\0\0\0!\0\0\0\0\0\0\0\0\0\0\0\0\00\0!! CC\01!!q\0\0\0\0\0\0 \0p!1aa0''544746sw75%%vqq6\0\0\0!\0\0p\0\0\0\0\0\0\0\0\0 \0\0!BP0%Cv\0\0\0\0\0\00SCu\0qssSWsSGSSwwqt !eQp \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!Q\0q\0!! #040q\0\0\0\0\0\0\0\0a$%!4417Cwu777ww swu7Sw7wwu2sS''@\0\0\0\0\0 \0\0\0\0\0\0\0\0\0\0!001Rq!7P\0\0\0\0\0  CQ3SCqwp7SswSSwsGww7w7SucG4qdR \0\0\0\0\0\0\0\0\0\0\0\0\0QC A a%0\0\0Cw \0\0\0\0  T06577G7ww7ww4wwwwwwwV5wwwqw%!A\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!00001!!41w\0\0\0\0\0\0\0SQsCSwwpwwwwwwwuwwwwu\0@\0\0\0CqgRRA\0\0\0\0\0\0\0\0\0\0\0\0\0\0CS\0%\000\04w\0\0\0\0\0!@p6su7w7wwwwwwwgg%%\0BADt p@F\0A\0@550p! \0@\0\00\0\0\0\0\0\0\0!\0\0001Q CRABP57w\0\0\0\00 u5swwtwwwwwwRpTdFFvf@DdddFF CGP\0\0\0\0\0\0\0\0\0\0\0\00\0!!A000\07Wp\0\0\0\0esusswwwwwwww@@dDfVv\0@d\0\0\0\0\0GgFBD\0!%40\0\0\0\0\0\0\0\0\0\0\0\0\00\01R$cP1CS7p\0\0\00!a45swwwwwwwttdt`@`@ @\0F \0\0\0@$gP@@P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!\0 1ap0@!Cwp\0\0!  Gsw7wwwww''\0ggd\0\0\0pGd\0\0DFDd\0\0\0Fdd\0 \0 \0\0\0\0\0\0\0\0\0\0R1!1A1S!Ssw\0\0\0 41!pw7wwwwwv\0DFd@@@ \0\0\0u\0\0\0\0\0\0\0\0d\0V\0\0gD\0B\0\0\0\0\0\0\0\0\0\0\0 \0\0\0RP`0a a\0!q57w\0\0 \0!qswwwwww@@Ggg@\0\0 d\0d%gR\0\0\0\0\0\0\0@\0d@\0\0Fvt\0\0\0\0\0\0\0\0\0\0 1!1!!A1 Q%7p\0\0$! 754wwwwwdgd@\0 \0\0G@@ www\0\0\0\0\0\0\0\0\0 tv\0gF@\0Ft\0\0\0\0\0\0\0\0\0\0\0\0\0\0R\0\0!\0p!1swp\0 \0qsSwwwRDvwv\0pF@@s1ww1\0\0\0\0\0\0wwp@@\0\0\0FdA!\0\0\0\0\0\0\0!1!pR1!5 70\0@0474wwDFvF \0d\0d!1Sq310\0\0\0\0wp\0\0\0g@\0\0g@\0\0\0\0\0\0\0\0\0\0\0A\0\0$0\0!0!C3qq\0\0aqswWudwg@\0G@p\0 Aq33q11S1\0\0\0\0\0\0\0\0\0\0PFt`\0\0@\0\0\0\0\0\0\0\0$0R 3\0q5567\01C45777gGfvP\0Bv\0\0eq37313s3ss\0\0\0\0\0\0\0\0\0d\0FT\0\0\0 \0\0\0\0\0$0aC51%0SsQq\0\03SSSwtvd\0@g`t\0@GwR1533w773733\0\0\0\0\0\0\0\0\0f \0\0\0\0\0\0 \0 \00Q\01a!!S453Ssp\0pa7577wvFw\0 DF`\0\0wv371ssswqs110\0\0\0\0\0v@\0`\0\0\0\0\0@\00!!aBSPq0S57\0\071sswwvwwd\0Ft\0\0G''wp!1sRq\03w31w03q0\0\0\0w@\0\0\0\0\0\0 \0 0QP\053 A75''\0 TsW7wwwwFF@\0\0d`\0www01 111\07w71rs010 \0\0\0Ft\0@\0\0\0\0\0\0\0\0\0!01%!A61qsSs77wwwvv@\0\0 P\0\0\0Wwwv13ss71\0wsw1rq71011\0\0\0F\0\0\0 \0\0\0B\0\010@q!% ssap\07Swwwwwgg\0td`\0 sssw01773w0qp\0\03ws7!s010\0\0\0g@\0\0\0\0 \0\0000 %40 7\0u7''wwwwwvt\0 @wsw 7sPws71\0\00\0\0ws3s10011\0\0t\0\0\0\0\00\0 \0\01!ApCCSssc3wwwwwf@\0dp1331sw 1ww7p\0\0\0s\0\0\0 w773\0113103\0\0v@\0\0\0\0\0\0\0 \0!R\0''0pr 7wwS7wwwwgP\0\0\0S11sqsss77wsw3\0\0\0CsS\03757!\0@wd\0\0\0\00\0\05!rQ1wwwwpsq7wwwtw``\03 73770\01ww7ww\0 \0\0\0\031\0\01177s\0w@f@\0\0\0\0\0 \00\0\0! a#77Wwwqwwwwv\0e\0 s33773sw13wwwws\0\0\0\0\013su\0\0\00F\0G@\0\0\0\0\0\0 \05015!pq%0wssswwwvfD das7307s3p\03psww0p\0\01170\077s\0\0\0\01\0\0\0`\0\0\0\0\0   !! 50q Swwwwwww@\0d\07s!373qs0\00Q77ws3!\0wpC\0\0wsqqp\0\00vR\0\0\0\0\00!Rq1%0uwssqwwv\0\0\0\0ss7775!37p\0\010\04ww0s ww\0\0\0w7771\0F v@\0\0\0\0\0 \0!!000 2!CR pGwwwwwwvgv\0 353s35133qs0\0\0w71w1\0\0''w7wwp!\0pv\0\0\0 !\0\00p \0ww7wwwGv\0ta73s73351q33p\0\0\00\07s7S03sp\07w7w7gG@\0\0\0\0 \0\0000!0C10qp7\0p qw7wwf\0\01ss73ssq003RSs\0\0\0131w11Sww\001\0\0ws7\0\0d \0\0\0\0 A!\0\0\0!0Pw\0p \0w\0swwwv@t@C3s71s313!33\0\0\001ws37www77s\0\0\0 d\0\0\0P\0\0!\0!%A0q%7qwpwswwt\0\0\01u3S7753q000550\0\0\011w1577ww \01w0\0v@\0\0\0\0 00\0 \0!417p psp swwvg\0t''S3s7s33q75#3S\0\01135773swwssq1\0 \0g`t`\0\0\0\0\0\0\0% !p0s0 p \0wwwww@\0@D!Sw3773#\0\0\03ws17w777sw3\0@p\0gA\0\0\0 !! \0\040p Sw\0s \0w\0w77wv@\0\0\0S33sss710131!11 !5#3w7wssw7s1!\0\0dVDf\0 \0\0A @\0@\015!srppswwwF\0G@1qw73q37a7\0!103537s33ss3ssr743\0\0fBvA\0 ` \00p41 qc puwwvt\0$d d773sSs3qq135!110q07ws1#ww73sp3\0\0@e`0\0\0\0 P\0\0  !!qssp%`P \077wwg\0@`Ss3151330s1!001q1!#S0773w11120qw55 3\0\0\0v@\00\0\0\0!!!!411\0CpSp7\0qswwtgdp\0 \0S7777371qs3S!37s33\01\0\0@\0\0\0 P\0\0\0\0@  a3Sss0 \0pswwwvtF@Fe3SsS11q7312q%!1210517771!sq\0\0\0\0\0\0\0\0\00\0V\0D0!\0\0\0$41!555\0p 7777wv@\0g\0\0B133ss3Ss11100s#013w0\0\0\0\0\0\0\0\0\0B\0dfv50B  !sA!ss\0q\0CSwwwe`\0V@ Dssqq17133S#313q73ww\05\0\0\0\0\0\0\0\0t@\0vCGwwwww5\0`0\0P!3q!p 0 1sswwvp\0`\0d %133sq773s3s1!1011!q31113w\0\0\0\0\0\0\0V\0@g\0gwwss777w50\0 \0A4!!s B p \0p57wwGd\0\0R\0fSSSS73s373SS1!3S7311157p\00\0\0\0\0Fd`\0\0$wss3sss73ae%\0`\0q31s\00!Cqswwwg\0\0e\0@3377753s731703!s3\0ww3\0\0d\0 tDGw73s3333372a\0C\0 !!!A''p@1057swv@\0\0\0\0W573qssss71qs1711311113w7wwwr\0F\0\0F`vssss77773s31  $Bpqq3Q!P\0\0qasswwt\0\0\0FFcS15373s53s31s3s1110s173wwwws11\0\0F@\0Ggwss7333373s0 0 !! C4S \0p#57wwG`P\0\0\0wSs3s73s7771!sSS111\0vqwwwsB$\0 \0\0gwwsss7777333\0 \0ppq01q414101sSw7vgd\0a!''753ss1q733s33Sqwwwsw\011\0\0\0aFwww73733333'' fv !  P6C \00SR7wuv\0\0p\0AS3s3sS71sssS5113wwwpww 1111\0vwwwssw3sss3gvGGGgdaa@0103Qp0pq41sSw7vd\0G``\0q#s7711s771111375ww7pwp\0\00\0wwww7737333vvvVGgGA` 7c3PR577ww@\0@\0\00153ss3sss7357111ww3ww@\0\01110\01\0\0gwwwwsssssrvvwgvvvvV$4\000341ap1aqsSw5wv`@\0pS 1353757777715313wwwwp\0\0\0\0111`dwwwwwww7337w Fwgwww`47q\0R11a07SCwswug\0\0\0\0a3qs333s13s3S\0s17w\0\0\0\0\0\00wwwwwwwwwwwwWVRRtwvwtP@\00q 5CPRqsSsWGwd`\0v@\0 ss377577s73SS\077 1\0@\0\0\0\0\0\010ggwwwwwwwwwu% \0 wvG 0\0q5\0C#SS57sssV\0\0dw173S33S3S5311!#110\0G\0\0\0\0`\0@DwwwwwwwwwwrR@@@apppawvA\0qq%7!a%4$ssqswstwwwD\0\0 `573ss1ss3s311\07W t`\0@\0gtgwwwwwwwwwwDB@\0   R G@0\0\05\0P0BR1q7qaqu7wwwwwwwtv@\0 q5733337!\0@`F\0\0\0fgwwwwwwwwwue%`@@ACPquppt\00q3Qa550q%777wwwwwwwwwFp\0\0qq53qqsSs33\0\0@\0e\0g\0g@BFwwwwwwwwwwwvVFe''BDpt7   \0P0CSCsSW4cwwwwwwwwwwwt`\0Cs1557333Q37\0gPde`''wFgwwwwwwwwwwvEdeGFD RTRRWu\0\03Q#5P571sWwwwwwwwwwwwwt@D\0 1111qqq3 \0dD`p\0\0GfwwwwwwwwwwwwGvVVF$\0%''55%7t\0\00ps7wwwwwwwwwwwwwwwwgg`\0\05753S111`\0\0 `G\0\0\0@tDgwwwwwwwwwwwwwwwwwtd@`@aaPgapWsAa #5r 777wwwwvvwwgggfwvwtFV\0\0q53q13 PF@\0\0\0\0\0\0wfvwwwwwwwwwwwwwwwwwwwttRV7G%w\0A01qaqwwwwwwdwwvvwwGGvgvwtdwvS511q1wP dg\0\0\0\0ffGwwwwwwwwwwwwwwwwwwwwwtSE rSWwprSssswwwwgwwwwwvvvvwwgvwwtdg@sp`\0\0`\0\0 wvGwwwwwswwwwwwwwwwwfgegwwww@e%rt5w w1qsR7wwwwwwwvteDTeDeDvwggwwFFGgu!v@\0v \0ggDfFwwwwww7773sswwwwww EdFGFvwww RWGwP\057777wwGwwtdvvggFgFe''fvwgwwtvGFTggBGg@Dtdvwwwwwwwwsssw77wwwww EdDtveGGwtaepRSggwpsRspwwwwwwwwGgwwWwggtvVDG\0GvwgwwtwgftdeDtdvGewwwwwwww77sss77wwwwtfFggedddww V %ww \0555g77wwwwGgwwvdvVVFVDvtt\0 gvwwwGwwwwvvrWEgw7wwwwwwwwss777sswwww\0FTeggfVFDFwV5pW4rwwPasp73SwwwwwvwwtvTvVGe`edFFGdD$vwwwwwwwwqwWg''wwswwwwwwwsw7ss  wwwt\0vdvvvvdtdGubStsUww\055qt7swwwvwwwGd&D$$DBG@edFvVGvwwwwwwqgpwSe7w7wwwwww77rt4wwwww@eggggdtdBFVgC7wu%!7373Swwwwwwtdf@DFT''e$ B@GGe\0wgwwwwpu pw7SVwwwwwwwwwt7wwwwp\0vVvwgggFDd@@w55gww 2qtstwwwwwwvFp@G t@g@dp\0FVVdvt vwwwwVws`wwSv5wwwwwwwwvA wwww@ggwfvtdeFDdd uwCWwt !737swwwwvtd@\0Dg\0Ft\0eg`dt$ gdwwwww\0wWwwvBWwwwwwwwe!A wwwwFgvgwggvfddD`sCWwwp 00RstsqwwwwwG`\0dB\0DGFFtFBGEwPdwt''gwww Wvwtu%w77wwwwwvwwwtugwgvvgfgD\0\0\0\0uwwwtAC77wwwwwtd@F\0\0$fpgGddttfdefTwdwwwvRwWusswawVwswwwsPwwwvwgggfwgP\0\0\0\0\0\0wwwr\0RCsqsqwwwwF@t`dD@@d@`FttpGu''wwp w7spWw''swwwwwuRwwvGegwwwwvvd\0\0\0\0\0\0wwwA\0\0@7w77wwvV@ d `\0\0\0\0d$gFW$GwGwwu$wtus pwpw7wwa\0 wwqevwwwBF\0\0\0\0\0\0\0\0\0wua\0\0\0! sqw5wwwtdD\0`Dt$\0d`@GDG $Gtegdwwp  wswq qgvwwwww4!% 0!7wVwgwT\0@\0\0\0\0\0\0aC\0 \0\073wwwwd\0BF@FfT$\0\0edvFvVE''BVGwwwttwwwcwwQw77wsAWv vw` `R$pt!`B\0\0\0\0 \0\0w5u7wwwG@@ptfE`\0\0FVdvGgvVt pwGwswwww7swgCww74RBwwVwp@AE$WFpp\0@\0\0\0\03w7qwwv`tt\0DBDdFv\0\0ededw` \0dgwwtwwwwwwwe7wwa!PQp7pww@g$rBVBVAGG\0\0p%\0a 0\0Au7swwwuFFF\0`dG@F@\0\0GFpBv4vRWVwwpwwww3s7w3t1ss7S@40! 0 WTw`vCAe  t$4v\0\0\00p\0p\007q77w7v`G \0a@@dddp`r\0\0\0gFAGadvgwwwwwwwwwwwwW751u \0Ascpg`V%P`vGBWBW\0G\0\0%!\0 swSuwwuGDDFD\0@Dd@d\0\0\0\07wwvttw twwwwwwwwwswsrQswsu\0WVV4G$5`t$vp 17777wwvF\0@\0`t\0\0vtVv\0\03wwwwwGtwwwwww7ws7wwww6w7!B\0!!w\0G`t C4 RPFCV t\0B\0p\0C\0a`Su7w7w@gDd\0gF@`F\0B\0\0Gwwwe@gGvwwwwwwwww7!7sSswSt@  \0\0pCe CGcCD$Bpt4aeds @077qwwwwF\0DDdFt@@wGa\0 gwwvvwvwWwwwwwwwwuGwsu''7w\0\0\0P0!CRRRp4444CC Ead4pet\0P\0  4775swwDp`FPe@BFB@ddq\0gwwwGVtvwwwwwwwwws13W5sWwsp\0\0\0 4`tpVGBC@`t4e&SFVw00!qw6W7svFV$dFDd@`$RF0w wwgeewwwwwwwwwww7w1sw7qwu`\0\0!PVRa`t4444a`VRG CGw\0\0\0\0q@7577wwted@g`gB@dt \0dwp@Wwwwtvwwwwwwwwwww7wwesu7w7\0\0\0\0\0!$aae  C@eaFWpGu%gu$! aP16sGw77w@v@F@@`$@Rgwe3 wwwvwGvwwwwwwwwwswww5sw6w\0\005dadpRpRV0cB@wr \0a747wwwD`D\0`\0DD$dVgww1wwww@vWwwwwwwwwww3wwvRqaeu%aaAavBSFtRudt%%epwwu!!!\0r#sGsWsSwsqd\0$edDdd`FFDVwwswwwtggwwwwwwwwwwwwwsu7p3S7swwwwwVGCBRPa@Rc@GwC@0A0P45%57swwGt@VFD@@`dvwwswwgtwwwwwwwwwwwsww7P%%swat5`tDe%GRP\0`RVa@ ww00@p0CsWRRww7wwvFFd@\0fF\0\0FFPGww4wvwGGwwwwwwwwwwwwwws rRRG RqwBWBp\0V g$ 6wwpa4@P045%3Gqqssut@\0DT\0@@\0Df`wwwwtgvwwwwwwwwwwwwqwww0pP1!Cw57w t$B\0TprPRSVT\0www5!a !RRW qswwW6wdV` @vd\0\0EFwwvvtwwwwwwwwwwwwswwwq%57W p1@@@B\0@@$$$\0WGwa Aq60R3G0pw5777W7Wf\0ddDBF@v@etGwweGwswwwwwwwwwwwwww2PR1pcSaw!s4\0\0!\0\0wegwA2Q#\0Ap!W  G5sW''W7D@d\0 \0tDVdwwww''wwqsGwwwwwwwwwwsp4 prSRqepa\0\0@@a%pgFWeaa` 1!pR0p0a51s3V7swwG`G@\0\0FDdGFwwwEsqww5wwwwwwwwwwp%#PSq6q!%!\0\0\0BFtwRRR%000RP! aecCG5sAC57u4ud`@@\0BFtgwwcww5swwwwwwwwwww!pP6  %''SF  \0\0\0d G$ P%\0\0!!a R0a51a%''7Sqsw6VDtd FDucWsvqssS wwwwwwwwwqpRQ@q5!sS$!Q0$ Bpp0 !1a!#\0aR0Sae4psC qaq66ewsGeAeg657qe74qsqtwwwwwwwq0445RR0P2 PB44  0C\01ppSSSsp754577w 7Ru4swsCRpwwwwwwwv%5CT51arW0a0q%!1\0CA04p4$%cA#p1q$CrSsCSwsqg53pG5q50q4!u7wwtwsRRSS0p0%!\0!p\0q\0 0C!p040\0\0q$%5V%5%5''C cW sR4657\0G0sw7wPqAp50pCC5%0a  A\0!A!!0@\004 q!a!A04$ % a07BSsCS 5%!aq''qp%7SqSaas w40F23C  sRRS@00\0BR a \0!00 Pq \0q@6\0pRPSaCAqa%%1asCpCRR5`rS aq\0qqsw3R 50p0$441q!%c\0\0!!0r\0P!%4Ca0C $%2! \032@qqa0qqpa5554351q07 ''0p1`00!\0q5qCSSC\004q\0a\0Q\0AA0140\0P%!\0@6CCP%%%% C Cp C GRR  P$1pSG4C$''BCRCC Bq 0 00RQBS ApR4 $!!\001q0q57\0q50q517SSA5!01! !!0qsPq51p1!\00!\0\0!010\0!!\00CC\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���');

COMMIT;

#
# Data for the `Customers` table  (LIMIT 0,500)
#

INSERT INTO `Customers` (`CustomerID`, `CompanyName`, `ContactName`, `ContactTitle`, `Address`, `City`, `Region`, `PostalCode`, `Country`, `Phone`, `Fax`) VALUES 
  ('ALFKI','Alfreds Futterkiste','Maria Anders','Sales Representative','Obere Str. 57','Berlin',NULL,'12209','Germany','030-0074321','030-0076545'),
  ('ANATR','Ana Trujillo Emparedados y helados','Ana Trujillo','Owner','Avda. de la Constituci�n 2222','M�xico D.F.',NULL,'05021','Mexico','(5) 555-4729','(5) 555-3745'),
  ('ANTON','Antonio Moreno Taquer�a','Antonio Moreno','Owner','Mataderos  2312','M�xico D.F.',NULL,'05023','Mexico','(5) 555-3932',NULL),
  ('AROUT','Around the Horn','Thomas Hardy','Sales Representative','120 Hanover Sq.','London',NULL,'WA1 1DP','UK','(171) 555-7788','(171) 555-6750'),
  ('BERGS','Berglunds snabbk�p','Christina Berglund','Order Administrator','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden','0921-12 34 65','0921-12 34 67'),
  ('BLAUS','Blauer See Delikatessen','Hanna Moos','Sales Representative','Forsterstr. 57','Mannheim',NULL,'68306','Germany','0621-08460','0621-08924'),
  ('BLONP','Blondesddsl p�re et fils','Fr�d�rique Citeaux','Marketing Manager','24, place Kl�ber','Strasbourg',NULL,'67000','France','88.60.15.31','88.60.15.32'),
  ('BOLID','B�lido Comidas preparadas','Mart�n Sommer','Owner','C/ Araquil, 67','Madrid',NULL,'28023','Spain','(91) 555 22 82','(91) 555 91 99'),
  ('BONAP','Bon app''','Laurence Lebihan','Owner','12, rue des Bouchers','Marseille',NULL,'13008','France','91.24.45.40','91.24.45.41'),
  ('BOTTM','Bottom-Dollar Markets','Elizabeth Lincoln','Accounting Manager','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada','(604) 555-4729','(604) 555-3745'),
  ('BSBEV','B''s Beverages','Victoria Ashworth','Sales Representative','Fauntleroy Circus','London',NULL,'EC2 5NT','UK','(171) 555-1212',NULL),
  ('CACTU','Cactus Comidas para llevar','Patricio Simpson','Sales Agent','Cerrito 333','Buenos Aires',NULL,'1010','Argentina','(1) 135-5555','(1) 135-4892'),
  ('CENTC','Centro comercial Moctezuma','Francisco Chang','Marketing Manager','Sierras de Granada 9993','M�xico D.F.',NULL,'05022','Mexico','(5) 555-3392','(5) 555-7293'),
  ('CHOPS','Chop-suey Chinese','Yang Wang','Owner','Hauptstr. 29','Bern',NULL,'3012','Switzerland','0452-076545',NULL),
  ('COMMI','Com�rcio Mineiro','Pedro Afonso','Sales Associate','Av. dos Lus�adas, 23','Sao Paulo','SP','05432-043','Brazil','(11) 555-7647',NULL),
  ('CONSH','Consolidated Holdings','Elizabeth Brown','Sales Representative','Berkeley Gardens 12  Brewery','London',NULL,'WX1 6LT','UK','(171) 555-2282','(171) 555-9199'),
  ('DRACD','Drachenblut Delikatessen','Sven Ottlieb','Order Administrator','Walserweg 21','Aachen',NULL,'52066','Germany','0241-039123','0241-059428'),
  ('DUMON','Du monde entier','Janine Labrune','Owner','67, rue des Cinquante Otages','Nantes',NULL,'44000','France','40.67.88.88','40.67.89.89'),
  ('EASTC','Eastern Connection','Ann Devon','Sales Agent','35 King George','London',NULL,'WX3 6FW','UK','(171) 555-0297','(171) 555-3373'),
  ('ERNSH','Ernst Handel','Roland Mendel','Sales Manager','Kirchgasse 6','Graz',NULL,'8010','Austria','7675-3425','7675-3426'),
  ('FAMIA','Familia Arquibaldo','Aria Cruz','Marketing Assistant','Rua Or�s, 92','Sao Paulo','SP','05442-030','Brazil','(11) 555-9857',NULL),
  ('FISSA','FISSA Fabrica Inter. Salchichas S.A.','Diego Roel','Accounting Manager','C/ Moralzarzal, 86','Madrid',NULL,'28034','Spain','(91) 555 94 44','(91) 555 55 93'),
  ('FOLIG','Folies gourmandes','Martine Ranc�','Assistant Sales Agent','184, chauss�e de Tournai','Lille',NULL,'59000','France','20.16.10.16','20.16.10.17'),
  ('FOLKO','Folk och f� HB','Maria Larsson','Owner','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden','0695-34 67 21',NULL),
  ('FRANK','Frankenversand','Peter Franken','Marketing Manager','Berliner Platz 43','M�nchen',NULL,'80805','Germany','089-0877310','089-0877451'),
  ('FRANR','France restauration','Carine Schmitt','Marketing Manager','54, rue Royale','Nantes',NULL,'44000','France','40.32.21.21','40.32.21.20'),
  ('FRANS','Franchi S.p.A.','Paolo Accorti','Sales Representative','Via Monte Bianco 34','Torino',NULL,'10100','Italy','011-4988260','011-4988261'),
  ('FURIB','Furia Bacalhau e Frutos do Mar','Lino Rodriguez','Sales Manager','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal','(1) 354-2534','(1) 354-2535'),
  ('GALED','Galer�a del gastr�nomo','Eduardo Saavedra','Marketing Manager','Rambla de Catalu�a, 23','Barcelona',NULL,'08022','Spain','(93) 203 4560','(93) 203 4561'),
  ('GODOS','Godos Cocina T�pica','Jos� Pedro Freyre','Sales Manager','C/ Romero, 33','Sevilla',NULL,'41101','Spain','(95) 555 82 82',NULL),
  ('GOURL','Gourmet Lanchonetes','Andr� Fonseca','Sales Associate','Av. Brasil, 442','Campinas','SP','04876-786','Brazil','(11) 555-9482',NULL),
  ('GREAL','Great Lakes Food Market','Howard Snyder','Marketing Manager','2732 Baker Blvd.','Eugene','OR','97403','USA','(503) 555-7555',NULL),
  ('GROSR','GROSELLA-Restaurante','Manuel Pereira','Owner','5� Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela','(2) 283-2951','(2) 283-3397'),
  ('HANAR','Hanari Carnes','Mario Pontes','Accounting Manager','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil','(21) 555-0091','(21) 555-8765'),
  ('HILAA','HILARION-Abastos','Carlos Hern�ndez','Sales Representative','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela','(5) 555-1340','(5) 555-1948'),
  ('HUNGC','Hungry Coyote Import Store','Yoshi Latimer','Sales Representative','City Center Plaza 516 Main St.','Elgin','OR','97827','USA','(503) 555-6874','(503) 555-2376'),
  ('HUNGO','Hungry Owl All-Night Grocers','Patricia McKenna','Sales Associate','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland','2967 542','2967 3333'),
  ('ISLAT','Island Trading','Helen Bennett','Marketing Manager','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK','(198) 555-8888',NULL),
  ('KOENE','K�niglich Essen','Philip Cramer','Sales Associate','Maubelstr. 90','Brandenburg',NULL,'14776','Germany','0555-09876',NULL),
  ('LACOR','La corne d''abondance','Daniel Tonini','Sales Representative','67, avenue de l''Europe','Versailles',NULL,'78000','France','30.59.84.10','30.59.85.11'),
  ('LAMAI','La maison d''Asie','Annette Roulet','Sales Manager','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France','61.77.61.10','61.77.61.11'),
  ('LAUGB','Laughing Bacchus Wine Cellars','Yoshi Tannamuri','Marketing Assistant','1900 Oak St.','Vancouver','BC','V3F 2K1','Canada','(604) 555-3392','(604) 555-7293'),
  ('LAZYK','Lazy K Kountry Store','John Steel','Marketing Manager','12 Orchestra Terrace','Walla Walla','WA','99362','USA','(509) 555-7969','(509) 555-6221'),
  ('LEHMS','Lehmanns Marktstand','Renate Messner','Sales Representative','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany','069-0245984','069-0245874'),
  ('LETSS','Let''s Stop N Shop','Jaime Yorres','Owner','87 Polk St. Suite 5','San Francisco','CA','94117','USA','(415) 555-5938',NULL),
  ('LILAS','LILA-Supermercado','Carlos Gonz�lez','Accounting Manager','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela','(9) 331-6954','(9) 331-7256'),
  ('LINOD','LINO-Delicateses','Felipe Izquierdo','Owner','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela','(8) 34-56-12','(8) 34-93-93'),
  ('LONEP','Lonesome Pine Restaurant','Fran Wilson','Sales Manager','89 Chiaroscuro Rd.','Portland','OR','97219','USA','(503) 555-9573','(503) 555-9646'),
  ('MAGAA','Magazzini Alimentari Riuniti','Giovanni Rovelli','Marketing Manager','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy','035-640230','035-640231'),
  ('MAISD','Maison Dewey','Catherine Dewey','Sales Agent','Rue Joseph-Bens 532','Bruxelles',NULL,'B-1180','Belgium','(02) 201 24 67','(02) 201 24 68'),
  ('MEREP','M�re Paillarde','Jean Fresni�re','Marketing Assistant','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada','(514) 555-8054','(514) 555-8055'),
  ('MORGK','Morgenstern Gesundkost','Alexander Feuer','Marketing Assistant','Heerstr. 22','Leipzig',NULL,'04179','Germany','0342-023176',NULL),
  ('NORTS','North/South','Simon Crowther','Sales Associate','South House 300 Queensbridge','London',NULL,'SW7 1RZ','UK','(171) 555-7733','(171) 555-2530'),
  ('OCEAN','Oc�ano Atl�ntico Ltda.','Yvonne Moncada','Sales Agent','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',NULL,'1010','Argentina','(1) 135-5333','(1) 135-5535'),
  ('OLDWO','Old World Delicatessen','Rene Phillips','Sales Representative','2743 Bering St.','Anchorage','AK','99508','USA','(907) 555-7584','(907) 555-2880'),
  ('OTTIK','Ottilies K�seladen','Henriette Pfalzheim','Owner','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany','0221-0644327','0221-0765721'),
  ('PARIS','Paris sp�cialit�s','Marie Bertrand','Owner','265, boulevard Charonne','Paris',NULL,'75012','France','(1) 42.34.22.66','(1) 42.34.22.77'),
  ('PERIC','Pericles Comidas cl�sicas','Guillermo Fern�ndez','Sales Representative','Calle Dr. Jorge Cash 321','M�xico D.F.',NULL,'05033','Mexico','(5) 552-3745','(5) 545-3745'),
  ('PICCO','Piccolo und mehr','Georg Pipps','Sales Manager','Geislweg 14','Salzburg',NULL,'5020','Austria','6562-9722','6562-9723'),
  ('PRINI','Princesa Isabel Vinhos','Isabel de Castro','Sales Representative','Estrada da sa�de n. 58','Lisboa',NULL,'1756','Portugal','(1) 356-5634',NULL),
  ('QUEDE','Que Del�cia','Bernardo Batista','Accounting Manager','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil','(21) 555-4252','(21) 555-4545'),
  ('QUEEN','Queen Cozinha','L�cia Carvalho','Marketing Assistant','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil','(11) 555-1189',NULL),
  ('QUICK','QUICK-Stop','Horst Kloss','Accounting Manager','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany','0372-035188',NULL),
  ('RANCH','Rancho grande','Sergio Guti�rrez','Sales Representative','Av. del Libertador 900','Buenos Aires',NULL,'1010','Argentina','(1) 123-5555','(1) 123-5556'),
  ('RATTC','Rattlesnake Canyon Grocery','Paula Wilson','Assistant Sales Representative','2817 Milton Dr.','Albuquerque','NM','87110','USA','(505) 555-5939','(505) 555-3620'),
  ('REGGC','Reggiani Caseifici','Maurizio Moroni','Sales Associate','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy','0522-556721','0522-556722'),
  ('RICAR','Ricardo Adocicados','Janete Limeira','Assistant Sales Agent','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil','(21) 555-3412',NULL),
  ('RICSU','Richter Supermarkt','Michael Holz','Sales Manager','Grenzacherweg 237','Gen�ve',NULL,'1203','Switzerland','0897-034214',NULL),
  ('ROMEY','Romero y tomillo','Alejandra Camino','Accounting Manager','Gran V�a, 1','Madrid',NULL,'28001','Spain','(91) 745 6200','(91) 745 6210'),
  ('SANTG','Sant� Gourmet','Jonas Bergulfsen','Owner','Erling Skakkes gate 78','Stavern',NULL,'4110','Norway','07-98 92 35','07-98 92 47'),
  ('SAVEA','Save-a-lot Markets','Jose Pavarotti','Sales Representative','187 Suffolk Ln.','Boise','ID','83720','USA','(208) 555-8097',NULL),
  ('SEVES','Seven Seas Imports','Hari Kumar','Sales Manager','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK','(171) 555-1717','(171) 555-5646'),
  ('SIMOB','Simons bistro','Jytte Petersen','Owner','Vinb�ltet 34','Kobenhavn',NULL,'1734','Denmark','31 12 34 56','31 13 35 57'),
  ('SPECD','Sp�cialit�s du monde','Dominique Perrier','Marketing Manager','25, rue Lauriston','Paris',NULL,'75016','France','(1) 47.55.60.10','(1) 47.55.60.20'),
  ('SPLIR','Split Rail Beer & Ale','Art Braunschweiger','Sales Manager','P.O. Box 555','Lander','WY','82520','USA','(307) 555-4680','(307) 555-6525'),
  ('SUPRD','Supr�mes d�lices','Pascale Cartrain','Accounting Manager','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium','(071) 23 67 22 20','(071) 23 67 22 21'),
  ('THEBI','The Big Cheese','Liz Nixon','Marketing Manager','89 Jefferson Way Suite 2','Portland','OR','97201','USA','(503) 555-3612',NULL),
  ('THECR','The Cracker Box','Liu Wong','Marketing Assistant','55 Grizzly Peak Rd.','Butte','MT','59801','USA','(406) 555-5834','(406) 555-8083'),
  ('TOMSP','Toms Spezialit�ten','Karin Josephs','Marketing Manager','Luisenstr. 48','M�nster',NULL,'44087','Germany','0251-031259','0251-035695'),
  ('TORTU','Tortuga Restaurante','Miguel Angel Paolino','Owner','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico','(5) 555-2933',NULL),
  ('TRADH','Tradi��o Hipermercados','Anabela Domingues','Sales Representative','Av. In�s de Castro, 414','Sao Paulo','SP','05634-030','Brazil','(11) 555-2167','(11) 555-2168'),
  ('TRAIH','Trail''s Head Gourmet Provisioners','Helvetius Nagy','Sales Associate','722 DaVinci Blvd.','Kirkland','WA','98034','USA','(206) 555-8257','(206) 555-2174'),
  ('VAFFE','Vaffeljernet','Palle Ibsen','Sales Manager','Smagsloget 45','�rhus',NULL,'8200','Denmark','86 21 32 43','86 22 33 44'),
  ('VICTE','Victuailles en stock','Mary Saveley','Sales Agent','2, rue du Commerce','Lyon',NULL,'69004','France','78.32.54.86','78.32.54.87'),
  ('VINET','Vins et alcools Chevalier','Paul Henriot','Accounting Manager','59 rue de l''Abbaye','Reims',NULL,'51100','France','26.47.15.10','26.47.15.11'),
  ('WANDK','Die Wandernde Kuh','Rita M�ller','Sales Representative','Adenauerallee 900','Stuttgart',NULL,'70563','Germany','0711-020361','0711-035428'),
  ('WARTH','Wartian Herkku','Pirkko Koskitalo','Accounting Manager','Torikatu 38','Oulu',NULL,'90110','Finland','981-443655','981-443655'),
  ('WELLI','Wellington Importadora','Paula Parente','Sales Manager','Rua do Mercado, 12','Resende','SP','08737-363','Brazil','(14) 555-8122',NULL),
  ('WHITC','White Clover Markets','Karl Jablonski','Owner','305 - 14th Ave. S. Suite 3B','Seattle','WA','98128','USA','(206) 555-4112','(206) 555-4115'),
  ('WILMK','Wilman Kala','Matti Karttunen','Owner/Marketing Assistant','Keskuskatu 45','Helsinki',NULL,'21240','Finland','90-224 8858','90-224 8858'),
  ('WOLZA','Wolski  Zajazd','Zbyszek Piestrzeniewicz','Owner','ul. Filtrowa 68','Warszawa',NULL,'01-012','Poland','(26) 642-7012','(26) 642-7012');

COMMIT;

#
# Data for the `Employees` table  (LIMIT 0,500)
#

INSERT INTO `Employees` (`EmployeeID`, `LastName`, `FirstName`, `Title`, `TitleOfCourtesy`, `BirthDate`, `HireDate`, `Address`, `City`, `Region`, `PostalCode`, `Country`, `HomePhone`, `Extension`, `Photo`, `Notes`, `ReportsTo`, `PhotoPath`) VALUES 
  (1,'Davolio','Nancy','Sales Representative','Ms.','1948-12-08','1992-05-01','507 - 20th Ave. E.\r\nApt. 2A','Seattle','WA','98122','USA','(206) 555-9857','5467','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0 T\0\0BM T\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�S\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0�
��\0
\t\t\0\0\n\0�\t\0\0\0\0\t\t���
\t\0\n��\0\0\0����������˜�������������������\0�\0\0�\t\0�\0\0\0\0\t\n\0\t
�\0\t\0�\0\0\0\n\0�������ʐ\0��
\0\0���\0\0\t\t
\0\0�\t\0�\0\0\t\0\0�\0�������������������������������
�\n\r\0\0�\0\0\0\0\0\0\0\t\t\n\0
\0��\0\t\0\0�
\t\0�\t\0����\0��
\0\0\0\0�\0\t\0\0\0�\t��\t\0�\0\0\0\0�\0�����������ϟ�������������������
\0��\0�\0\t\0\0\0\0\0\0�\0\0��\t���\0\0�\0\t�����\0\0�\0�\0\0��\t�\0�\t\0��\r\0�\t\0\t\t\n\0\0������������������������������
��\n\0��\0\0\0�\0\0\0\t\n�\n\0\0��\0\n\0\0
�
\t\0���\0�\0��\0�\0�\0\0\t��\0\0��\0����\0\0\0�\0\0
�������������������������������\t\t\t\0�\0�\0\0\0\0\0\t\n�\0���\0�\r\t\0\0�\0

�����\0\n��
\0\0\0��\0��\0\t\0��\0\t�\0\0�\0\0������������޼���������������������\n\0\0\0�\0\0\0\0\0\0�\t\0�\0\0\0\t\0\n\0\0�\0\0\0\0��\r�ʐ\t\t��
\0\t\n�\t\0\0��\t�����\0\t
\0\t�����������\t�Ͽ����������������
\n��\n�\t\0\0\0\0\0\0\0\0\0\0\0��\0��\t\0\n\0\0��

\n��\t\0\0\t��\t\0\0\t\0\0�\t\t\0�\t���\0\0\0\0\0����������ꞟ�������������������\0�\0\t\0\0\0\0\0\0\0\0\0\0\0�\t\0\n\0�\t\0\0�\t\0\0�\0�\n\t��
�
\n\0\t\n��\0���\t\0\t\0\0�А�\0\0�\0
�����������������������������������\t\t\0\t\0\0\0\0\0�\0\0\0\0�\0\0\0
\0\0\0\n\0\0\0��\n\0��\t�\0�\0�\t�\0�\n�\0�\t�����\t�\0\0\t�������������������������������\t\0�\0\0\0��\0\0\0\0\0\0\0
\0\t\0�\0\0�\t\t��\0\n�\0����\0�\0�\0\t\t�\t�\t�\t\0�\0\0\0���\0�\0�\t����������������������޿�������\n��\0\t\0��\0\0\0\0\0\0\0\0�\t\0\0\0\0\0\0�\0�\0�\0\r��\n\n���\0��\0\0\0\t\0\n�\t�\0\t\0����\tɐ\0�\0����������������ߟ���������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�\0\0\0����\0���ɠ�\n���\t�\0��\nЩ\0\t\t
\n�\0\0������������\t�

��ﯾ������������\0�
\0\0\0��\0\0\0\0\0\0\0�\t\0\0\0\0\0\t\0\t�\0\0\0\0�\0\n��޹�\0\r\0\t\0�а����\t\0�����\0\0\0\0�����������������ߟ��������������ޞ\t\0\0�\0\0�\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\t�\0�\0\0�\0\t\0\0��ܭ�\0�\0\0\0�\tʜ\t�\0�\t\n��
\0�\0�\t����������
\t�\t����������������\0�\0�\0\t\0\0\0\0\0\0\0\0\t\0�\0\0\0�\t\0�\n�\0\0\t\0\0\n�\n�����\0ڜ�����ɩ�\t\0�\t\t��\0\0\0\0������������ڞ��������������������\t��\0\0\0\t\t\0\0\0\0\0\0\0\0\0�\t\0\0\0�\0�\0\0�\0�\0\0\0����ϼ��\t��\t\t����\n��\t
\0��\0\0\0\0���������\0����������������������\t\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t\0\0��\0\0\0
�������\0��\0��\r�\t��\0���\t\t\0\0�\t����������\0���߿������������������

\0���\t\0\0\0\0\0\0\0\0�\0\0\t\0\0\nА�\0�\0\0\0��\t������ۭ
�\t�����\0�\t
\t��\0\0\0\0���������
��\r��������������������\0\0��\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0��\0\0�\0\0�������\n����\t

й�\0\0�\0\t\0\0\0�\t�������К\0�������߼��������������\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0��\0\0\n����������
\t
��������\t��\0\0\0\0���������\t\t�
���������������ϟ�����\0\t\t\t\0
\0�\0\0\0\0\0\0\t\0\0\0�\0\t�\t�\0\0\0
\t�
���������\t�\0

\r�
\0\t\0\0\t
\0\0\0\0\t�������\t
\nɭ����������������������\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\t\0��\0\0\0���߯����鰰�\t
К��\t�\0��\0\0\0\t\0��������\0\n���ｾ������������������\0\0\0\t\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0\n��\0\0\0�\t�\n����������\t\r
\0�
\t��\0��\t\t\t\0\0\0\0\0������\0\t\r�����������������������\0\t\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\t
\0\0\t\0\0\0��\0\r
����������\n��К\t\0\t\0\0\0\0\0\0\0\t�������\t\0�\t����������߿������������\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0����\t\t\t�\0\0\0������驹�\tېЛ\t
��\t\0
\t\t\0\0\0��������\0\r
������������ߟ����������\0\0\0\0�\t\0\0\0\0\0\0\0\0\0\0\0\0
\t\0\t\0\t\0\0�\n�\0\0������������
\t驩�\0��\t\0\0\0\0\0\0\0�������\t\0�߿�������߿���������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0\0\0\t��\0�\t\t��\r\t��ɯ��н��𰐐���\n\t\0\0\t\0\0\0\0\t\t������\0������������߽����߿������\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0
�
\0\0\t�\t\0\t��\0\t\0���������ۿ

��ڟ
�\r\0\t\0��\0\0\0\0\0��������\0\t�߯�����������޼�������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\t\0��\t𐐰
\t\r\t��˭�𽭩�����\0�\t���\0�\0\0\t\0\0\0\0\t�����������������������߾�����\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\0�\t\t\0�
�\0\0���������ߩ��\t�����\0\0�\t\0\0\0\0\0\0\0�������\0�����������������������\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\t
\t\0�\n�
��\0�\r\0
\t\r��������������\t�а�\t\0\t\0\0\0\0\0\t\t�����\0�\t����������������������\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0
\t�\t\t
��\0��\n\0

��������Ϟښ��˚�
\t\t�\0\t\0\0\t\0\0\0\0\0������\t���޿����������������ﭭ��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\0\0���А�
\n�
���������뽽���Й��\t\0\t\0\0\0\0\0\0\0\0\t�����\0\0��߿���������߭�������н
\0\0�\0\0\0\0\0\0\0\0\0\0\0\0���\0�
��\n\0
\0\t�����𹭭�
˼��ښ�������\0�\0�\0\0�\0\0\0������\t\r����������߿�����������
�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\t�\0�\t��
\n\t
���
��
�
\t����˞���ې�\t��\t�\t\0\0\0\0\t\0\0\0\0\n����\0\n�����߿������߼����������\0�\0\0\0\0\0\0\0\0\0\0\0\0�\t����\t\0���
\0�\t\0\t��\t𰹼��鰼��ڛ\t\0�\0�\0\0\0\0\0\0\0\0�����\0��������������߼��������\t\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\0��\t��\0��\t�\0\0\n��������۞����\t�\t\t\0\t\t\t\0�\0\0\0�\0\0\t\t���\t�����������������������
�\0�\t\0\0\0\0\0\0\0\0\0\0\0\0�\t\0��\t\t���\0�\r
\r
\0\0����
��������\t\t\0\0\0\0\0\t\0\0\0\0\0\0����\0٭�����������������������\r\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0��\0\0\0�\0\0\0
\0
\0��������۟\r���
����\0���\t\0\0\0�\0\0\0����\0��������������ޟ�����˟
\r��\0\0\0�\0\0\0\0\0\0\0\0\0\t\0�\0\t�\t\0\0\0��\t\t\t
\t�\0\t\0�����м���������\t\0�\0\0\0\0\0�\0\0\0\0\0\0���\t魽�������������������𾞝��\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\0\0�\0\0\n\0\n\0\n\0\0\t\0\0���߾���������ː����\0�\0�\0\0\0\0�\0\0\t
\t�\0����������������\r���\r\t\t��\0\0�\0\0\0\0\0\0\0\0\t\0\t\0\0\t\t\0\0\0��\0��\t\0\0\0\t\r����������۾������\0�\0�\0\0\0\t\0\0\0\0\0\0��Р���߭�������������ڞ���ڞ\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0��\0\0\0\0\0\0\0\0\0\0\0\t\0�

�����ۚټ���
\t�\0�\0\0\0\t\0\0\0\0\0\0\0\t\t��\0����������������������\t\0\0�\0\0\0\0\0\0\0\0�\t\t\0\0\0\0\0\0\t\0\0�\0\0\0\t������ߟ�����ۼ��\r����\t\t\t\0\0\0\0\0\t\0\0\0\0\0\0�\0\t
���߿������߭��������
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0��\0\0\0\0�\0�\0�\0\t�
˟���������
��������\0\t�\0�\t\0\0\0\0\0\0\0\t
�\t���������������������\r�\t\0а\t\0\0\0\0\0\0\0\0\0\t\0��\0\t\0\0\0\0\0\0\0\0\0\0\n������������˿����
���\0�\0�\0\0\0\0\0\0�\0\0��\0\0\t�������������������
\r\0�\t�\0\0\0\0\0\0\0\0\0\0\0�
\t\0�\0\0\0\0\0\0\0\0��\t\t

\t����������鿩��\t\t\0�\0�\0\t\0\0\0\0\0\0\0\0\t\t\0\t\0���������������������\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\n\0\t\0\0�\0�\t\t\0\0\n��\t\t\r���������������۩����\t\0\t\t\0\0\t\0\0\0\0\0\0\0\0\0\0�
���������������Щ��\t\0�\t\0\0\0\0\0\0\0\0\0\0\0\0���\0\0�\0\0\0\0\0\t\0�\0\t��������۞��������ۚ��\t\0\t\0\0\0\t\0\0\0\0\0\0\0\t\t\0\0�\r
��������������ޚЩ���\r\0\t\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\t\0
\0��������������������鰽���\0��\t\t\0\0\0\0\0\0\0\0\0\n\0������������������\r������\0\n\t\0\0\0\0\0\0\0\0\0\0\0\0��\0\t\0\0\t\0\t\t\0\0�\t
\0�������
�����۽������
\t\0�\0�\0\0\0\0\0\0\0\0\0\0\t\t\0\0
\r������������ښ�
\0����\t\0\0�\0\0\0\0\0\0\0\0\0�\0\0�\0�\t\0�\0\0\0�\t\n�
�𽠿��ߟ�����鹩�����\0\t\0�\0�\0\0\0\0\0\0\0\0\0\0����������������\r���\r
�\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0�\t\0������\t�����������а�\t\0\t\0�\0\0\0\0�\0\0\t\t\0\t�ɽ�������������\t�Щ�

\t�\0�\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�\t\0\0\0��
�\t

��������˟������\t�\t\t\t\t\0\0�\t\0\0\t\0\0\0\0\0\0\0\0�\0���������ߟ���
\n�\t\0���\n\t\0\0\0\0\0\0\0\0\0\0\t\0\t\0\t\0\0\0\0\0\t\t\t\n�\n���������������۾���\t𰚚�\0��\0\0\0\0\0\0\0\0\0\0\0\t\0\0�����߿�����˭\r���\r\n�
\n
\t\0\0�\0\0\0\0\0\0\0\0\0\t\0\0\0\0�\0��\0\0\0��\t\r���\t���鯟��������ڛː�
�\0\t\t\0\t\0\0\0\t\0\0\0\t\0\0\0\0���ߟ������\r
�\n\n�

��ʜ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t\n������
ʟ������������ɹ�\0�
\t\n\0\t\0\t\t\0\0\0\0\0\0\t\0\t�������������鬜��\r����\t\n�\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\0�\0�\t\0\t\0\t
����
���о�޽���������������\t\t\0\0\0\0\0�\0\0\0\0�\0�\r
����������ڞ\t�


��

�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�
������������������������˙�
\0\0�\0\0\t\0\0\0\0\0\0\0\0\0\0\0�٭����������ڞ

�
\t
�����\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0���\n��ɰ��������\n����ߟ�����
��\t\t\0\t\0\t\0\0�\0�\0\0\0\0�\0�\t�������ߞ�����\t���\t\0�\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\0\0\0
\0\t\t��\n�
�����������������\t���\t�\t\0\0\t\0\t\0\0\0\0\0\0\0\0�������������\t�ɠ�\0\t�������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0
\0\tښ�������������������된�٩\0�\t\0\0\t\0\0�\0\0\0\0\0\0\t\t������������\t�ɠа\t\0\r�
�\t\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t\t\0�\t\0\0�\0�����������\r���������۝�
\t\0��\t\0�\0\0\t\0\0\0\0\0\0\0�\0\0����������������м\t�\r�\0\t�
\n
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t
\t��
�ߟ������������驟\t
�����\t\t\0\0\t\t\0\0\0\0\0\0\0��������������޼��\t�\0�\0�\0\0
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\0\n\0���
��������\t�齯������\0�\0\t\0�\0\0��\0\0\0\0\0\0\0\0\0\t���������������ڐ�
�
�ڐ\0��\0\0\0\0\0\0\0\t\0\0\0\0\0��\0\0�����������������������������
�\t�\t�\0\t\0\0�\0\0\0\0\0\0\t\t��������������������
�\0�\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0\n\0
\0����������
𽬟����ۛ�����\0�\t\t\0�\0\t\t\0\0\0\0\0\0\0\0��������������ߚ��\t��\0�
\t\t\t�\t\n\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0���А��
ޚ������\0���������
���\t\t\t
\0�\0\t\0\0�\0\0\0\0\0\0\0�������������������𐜼\t
���\nА\0\0\0\0\0\0�\0\0\0\0\t\0\0\0\0\0\0�
���������\0��ڽ����۟��
���\0���\0\0\t
\0\0\0\0\0\0\0
�����������������͚��\t��\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0���\0����ޚ�����\t������������\t����\0�\0\t\0\0\0\0\0\0\0\0\0��������������ݭ����\t������\0\t�
\0\0\0\0\0\0\0\0\0\0\0��\t\0\0\n\0\t\t\0���
���\0\n
������������\t
\0��\0�\0��\0\0\0\0\0\0\t������������������
�٭
�
ʐ\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t
\0\n\t
��������
�\0�������\r\t
\0����\0\t\0\t\0\0\0\0\0\0�����������������������м��\r\0�\0\t\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0�\0��
\r�
�

��\nڰ��������ޟ��鰰���
\t�\0\0\t\0\0\0\0\0\0\t����������������������\r��\r���
ʜ�\t\0\0\0\0\0\0\0\0\0\0�\0�\0�\n�\0\t\0�����������
�������
�
�\0��\t�\t\t\0\0��\0\0\0\0\0\0�������������������\t���ڜ�ڞ���\t\0��\0\0\0\0\0\0\0\0\t\0\0\0\0\t\0\t\0\0�
����
����\0
\0��������
ʙ�ɠ\t\0�\t\0\0\0�\0\0\0\0\t��������������ߟ����\t����\r�\t�\t���\0�\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\0\0�\0����������\t��������𿛙�а���
\0�\t\0\0\0\0\0\0\t�����������������ڹ�
�頰�ڜ���ɠ\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n�\0\t\0

��ʟ

�\0�\n\t���������
\t\0\t\t\0�\0\0\t\0\0\0\0\0�������������������
��\r����˚�ڐ\0\0\0\0\0\0\0�\0\0\0\t\0�\0�\n\t�н\n����𠜰ڞ�����
\t�������\t\0\0\0�\0\0\0\0
���������������������\t�\n��ڜ���\0

\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0�\t
�����\0����
��������۟�����\0
\0�\0�\0\0\0\0\0
���������������٩�\t\t\t��ٯ\t�魠����\t�\0\0\0\0\0\0\0\0�\0\0�\t\0�\0�\0���Щ���\t�����\r�������魩\t�\0�\t\0\0�\0\0\0\0�������������������К\0\t鰭\t鞞��ɩ���\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t�\t��\0����
\0���������
������\t\0\0\0\0\0\0\0\t�������������������
�А\0���\t頼��\0���\0\0\0\0\0�\0\0\0�\t\0\0\0�\0\0��\0�
�ʞ\t�\0���\0�����������
\t\t\0\0�\0\0\0\0\0\0\0
�����������������А�\t\0\0���
�\r\t\t����\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\t�\0�\r�������\0��\n��������˛К���\t\t\0\0�\0\0\0����������߿��ۙ��\t\t\0���\0\t
�����
��\0�\0��\0\0\0\0\0\0\0\0\0\0�\0\0\0\t\0\0\t\0�����\r��\0�\0��������������\t
\t\t\0\0\0\0\0\0\0\0
�������������\r\0���˼�\t\t\t\0��\n����\r\r�\n
\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\t\n������\0�\0\t鬚��߽��ߛ����\0\t\0\0\0\0\0\0\0�������������\0��������\0\0\0\0������������\0\0\0\0\0\0\0\0\0�\0\t\0\0\t\0\0\0\t
�\t���\t\0\0��

�
�޻�������\t\r�\t\0\0\0\0\0\0\0\0�����������\t\0�������\t��\0\0\0\0��������
�\n\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\0�������
\0\0�\0\t��鿿���۟
�ڐ�\0��\0\0\0\0\0\t����������ڐ\0\0��������\0\0�\0\0����а���\n��\0\0\0\0\0\0\0\0\0�\0\0\t\0\0\0\r���\t�\0�
�\0\0��
\t���������к��\t�\0\0\0\0\0\0\0\0�������������\t
\r��а��\t\0�\0\0���ګ�����Щ�\0\0\0\0\0\0\0\0\0�\0\0\t\0����\t\tڞ\r\0\0\0\0�\0���
�����ۭ�
�����\0\0\0\0\0\0\0
�����������������\0\t\t\0\t\0\t\0\0\0\0
ɭ٭\0�����\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\t����\0�\0�\t��\0\t����Ͽ𽟹�

���\t\0\0\0\0\0\0\t��������������\t\t���\0�\t�\0����
�\nн����\n\n\0\0\0\0\0\0\0�\0\0\t\0\0\0�����\t\r���\0
��\n���\0�������������\t\0\0\0\0\0\0\0���������������ߙ�����
��
��\t
м�\0\n��\t���\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\n
�\0\0��\t\0\0���\t������������
���
\0\0\0\0\0\0\0���������������������ɹ���\r\0�
�\t����੬\0\0\0\0\0\0\0\0\0\t\0\0�\t\t\t\t���ɩ�\n����
\n\0��
������ښ٭��\t\t\0\0\0\0\0\0\t�������������������
߽�А\r����ܰ�\0�����а\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0��\t\n�а�ʐ���\0��\0�����������А�\0\0\0\0\0\0\0�����������������������\t������\r�\r\t�\r


\0\0\0\0\0\0\0\0\0\0\0\t\0�\t���\t�\0
����\0�

�\r������ښۛ����\0\0\0\0\0����������޿��������齼�\t\0�К����鞚\t\0��
��\0\0\0\t\0\0\0\0\0\0\0\0\0\0�����\t����
\r�\n\0���
����ڟ������\0\0\0\0\0\0\0\t���������������������
\t\n�
\r�ٽ\n������\t�\0\0\0\0\0\0\0�\0\0\0\0\t\0�
�\t\t��\0Я������
\r�\t����߿𼛛��\t\t\0\0\0\0\0\0��������߿ߝ��������\t�О�
�а�
�\t\t\r\t���\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0��𞐠�
��찰\n\0�

�\t�����۰�А��\0\0\0\0\0\0�����������������������\0\0��
\r�𜐰�
�\n�
\0�\0\t\0\t\0\0\0\0\0\0�\t\0\t
�ڐ��
������\0�������������۩���\t\t\0\0\0\0\0����������������������\0��\0
\r
˜���
А�
\0�\0\t�\t\n\0\0\0\0\0\0\0\0\t\0\0���
���߬���\n\0\t
�����\r���\t�\0\0\0\0\0\0
�����������ɽ����߿���\0\t
��М�ɽ�����\r
\t�\n��\t�\0\t\0\0\0\0\0\0\t
\t����
�
�����\0�����������������\t\0\0\0\0\0�������������˟��\t����\0\0\0\t\0\t�����ː�\t�\t
��
\0�
\0\0\0\0\0\0\0\0\0\0����\t���
�\n\t�
\t\0\0��\0����������\r\t\0\0\0\0\0\0\0���������������������隐���ɐ��˞�
���𩠐\0�\t�\0\0\0\0\0\0\t\t\t\t�

��������\0\n\n\n\t��\t�����������
\t\t\0\0\0\0�����������ߛ\t\t���������\r�\0����й��\t
�\t�ڐ�\t\0\0\0\0\0\0\0\0\0��������\n
�\n\0�\0����\t���ۿ������\t\0�\0\0\0\0\0��������������������������К�����ڟ˚���\t�\t\t\t��\0\0\0\0\0\0\0�
�\t���
������\n\n\n\n���\t��߿�������\0�\0\0\0\0
����������߿�������͙��\0���������\r��\t��
��\t\0�\0\0\0\t\0\t\0��ڐ��
\n\0�\n\0��\t\0�\n\t\n�����������\t\t�\0\0\0\0\t���������������������ۛ��
\t����
����
����Щ\t����\0\0\0\0\t\0\t�������𰼼��\n\n\n\n\t\n������������\0��\0\0\0����������������������ޙ�
�ڝ����������ʜ\0\r\0���\0\0\0\0\0\0\0\0�К�
���\0������\t\0\n\0�\n�
���������ɐ\0\0\0\0\0�������������������������\t����а��
��
�\n��
\t\0\0\0\0\0�\0�٫��������𠠠���\t�఼����߻���\t\t\0\0\0\0����������������������ڝ�

���ߟ����\r����\n��м�\0\0\0\0�\0���п\0�\n
����
\t\0�\0��\0\t\0����߿��ː�\0�\0\0\0������������������������\t���������\t����\t��\t\0\0��\0�\0\0\0\0�
\t�����ښ۬����\0���������\0��������А�\0\0\0\0�������������������������\0����������魐��\t�\0��\0
�\0\0\0�\0\t\0��а�
\t��\t\0\n���\t\0�\0�

��������ۚ�\t\t\0\0\0\t�����������������������\t�������ڝ�����\r��\0\0\t\t\0��\0\0\0\t\0����\0����\0༐�\0����\n\n�\0�
���ߟ���ɐ�\0\0\0\0�������������������������
����������齞��а\0\0\0\0\t��\0\0\0\0
\r�������
ɭ
\n\n�\n
\t
\t�\t����\t��������\0��\0\0������������������������\0�\r\r�����ߩ����\t�
\0\0\t\0��\0\0\0\0�����\0\n\t
\0�\n��\t��\t\0\n\0�\n\n

\n�\0���ڟ�����\0\0\0\0�����������������������
�۞���޽��ڼ���\0\0\0\0��\0\0\0\0\0��
�\r\0\0�ɭ�\0���\0���\t����\t\r�����۞��\t\0\0\0\t�����������������������Ь�����ڙ���ޝ���\0\0\0\t\t\t\t\0\0\0\t
\n�\0\t�\0���������\t\n\n\0��˜�\n\0
����
�隐\0\t\0\0�����������������������\r\t�����
н霭����\t�\0\0\0�\0
�\0\0��\0�
\0�\0�\t\t\0��\n��\n\0\t\n\t�\0�\n���
�����\r���\t\0\0�
��������������������ޜ�\n���Л��ښ��������\0\0\0\0\n��\0\0\0\n�\n\0�
�
�\n\n��\t�
�\0����\n
\t���\t\t����й�\t\0�\0\t\0���������������������\r\0���ͭ�\t�������\t�\0\0\0\0��
\0\0\0�\0ɩ\0\0\n�\0\t\t\r��\n\0�
\0\0\0
\t��ښ\t�\0
����\t����\0�\0�������������߯������Ͱ���\t������\0���������\0\0�\0ɰ\0\0\0\0����

\t�����\0���


\0�
\t��\n�ښ�������\t\0�\0\0\0����������
�\n���������\r\t
�
�\0����\r���𜺐\0\0\0\0���\0\0\0\t�\0�\0�
\t\0\t\n���\0
\0�\0\0\n��ʚ���\0�����\t\t���\0\0\0������������
������������
\t\t�
����˞������\0\0��\n��\0\0\t\0\0�\t�\0�\t����\n
�\n𰐰����驞��\0���������\t\t\0\0�����������К�\t����������\0�\n�\0������\r�О��\0\0���
�\0\0����\t魠�\0����\n��\0�\n�\t\n��\n�𼼚���М��\t\0\0\t\t����������\t\0\t\t���������\r
��\t\0\0�\0\0\0\t
\t�м��\0\0\0\n

\0\0\0\0\r���\0\n\n\n\n\0�\0�\0��\n\t�\n\n\t��а\n



����\t\tې\t\0\0\t\t������\t\t���Н���������
\0�а\0\0\0\0�\0��
��\0\0\0���
\0\0\t��������\t\t
\0�
ɰ�\n\t�\0�
�ɩ���н����\t����\t\t����ڝ���\0\0�\t�\n������\t��\0\0�
\0�\0\0���\r
\0\0\t�\r�\t\0\0\0\t��
\0\0����\n���\n�\t��\n\n\0\0
��Щ�

���\0���\0\0\0\0�О���\t�\0�\0\n\0�\t������\0�
\0��\0\0\0\0\0\0\0\0\t���\0\0\0\t�\0\0\0\0\t\0����\0�\0\n��\0\t��\0�\0���\0��
�ټ��������\0�\t\t�����\0���\0\n��\t\0�������\t�\0\0�\n\0\0\0\0\0\0\t��\t�\r\0\0\0���\0\0\0
�
�\0\0�����\0頠�
\n\0��\0\t�
����
�����\t\0�\t\0\0\0������\0\0�\t�\0\0\t\0������\t\t
\0
\t\0
\0\0\0\0\0\0�������\0\0\0\0�\0�\0\0�����\n
\0\0\0�\n
\0\t\0\t���\0
\0�\t

\n
���������\t�\t\t

�\t��
\0\0\0\0\0\0�\0��������
\0�\0\0\0\0\0\0\0�\t��\tڜ��\0\0\0\t��\t\0\0\0\t��\t\0\t\0\n�\n\t��
\n
���\0�\0�\0���\0��������\t\0\t��\0\0��
۟���\0\0\0\0�\0�������

\0�\0��\0\0\0\0\0\0\n�������\0\0\0\0�\t\n\0\0���\0\n\n\n\n\0\t\t�\0��\0\0�\n\t���\n\t\0���
\t
������\t���
\t\t\t������\t��\0�\t\0\0�������\t\t�\0\t\0\0��\n�ɩ
�ː�\0\0\0\0�\0\t\0\0\0��\0�\t\0��\n\n\n�\0����\n\0�\0�\n\n\0\n\0�\n��������\0\t\0�\0
�����\t�\t\0\0\t�������а�\n�\t\0\t�\0\0����ʼ�\0\0\0\0\0\r��\0\0�
�\0�����\0\0�\0�\n\0\0
\0��\n
\0�\t\0�
\t���\t����\t\t\t\0\t\n��\t

�����\0�\t\t���ߟ���
�\t\r\t\0\0��\t�\t�\r�
���\0\0\0\0\0\t��\0\t��\0\0���\0\0��\n\0�\0���\t���\t��
\0���������
\0\t\0�\0\0���
���������������ϭ\0\0��\0�\0�ڐ��
ʟ
\0\0\0\0\0\0�\0\0\0\r\t��\n\0\n\n�\0\0\0�\0��\0�\n\0�\0�ʠ\0�\0�������������\0\0\n���

���ߟ��
ڞ�������ڐ�\t\0\0\t��ۜ��
\r�О\0�\0\0\0\0\0\0\0\0\0\t\0�\0\t����\0���\n\0\0\n\0�����
�˩��
�\0�\t������\0��\t\n\t\r\t�
߽��鐐\t\0�\t魿�����\t\0\0\0�\0�����
���\0\0\0\0\0\0\0\0\0\0�
\0�\0�\0�
\t\r\0��
\0��\0�\n�Р\0\0������������\0\0�����\t������\0\0�\t���߽�����\t\0\t\0\0\0��\t���м���\0\0\0\0\0\0\0\0\0���\0���ʐ�\n\n\n��\0\0��\n\n\n������\n��\0\0�
��������\0\0
�\t��\t��
\t��������
���齙��\0\t\0��\0���
��\0\0\0\0\0\0�\0\0\0
\0�
\n\0������\nɠ�\0�������
�\t���చ�������й\0\0����˚����\t��������������ܰ��\t�\0ɩ
а\r\0\0\0\0\0\0\0\t\0\t\0�Р����ڐ\0
\0�
�ڼ\n\n\n�\n\0��\n
�
\n�
�������\r\t\0\0�\tː������ɯ��������߻�߽�����\n����\r�\0\0\0\0\0\0\0\0\0�\nР\n\0������

\0��\0�\0�
\n��\0����������\n�\0\0\t�\t�
��𿞛����ϟ�����������������\t�
\0\0\0\0\0\0\0\0\0\0\0��\0\n���\0�\t
\n����\n�
\0�\n�\n\0��\n\n��\n�\n
�������\t��\0��
ٙ�۝��������������������������
\0\0\0\0\0\0\0\0\0\0���\0��
��\0\n\0\0\0\n\t\0���
\0����\n�\0�\t\0�\0��������
�\t\0\0����ٽ������������������޼������鰰\0\0\0\0\0\0\0\0\0\0�
\0\n
\t�\n\0�\0�
\n\t��ʐ�\0��
\n\n\0�\0�\0��\n\n\n\r������К\0���\t��
�ٹ����������߭����������������\r\0\0\0\0\0\0\0\0\0\0�\t�\t�\0\n\0��\0�\t�\t\n\n\0�\nК\t\0���
\0�\0
\0��\t����۫ۿ���\t�����\t�
�˛���������߽��������������ʚ\0\0\0\0\0\0\0\0\0\0\0��\0��\n��\n\n\n\0��\t\n\n��\0\n
\t�\0�\n\0\n\0\0�\0��������޽�\t\0\t�\t��\t������ݹ鼽�������߭�����ޟ���\0\0\0\0\0\0\0\0\0\0\t�\0�\0\n\0��\0�\0�\0
\n���˩\0\0��

\t��\0�\n\t\n\0\t
���������\t����\t\t\t
��Ϲ���������������߽���ʐ\0\0\0\0\0\0\0\0\0\0\n���ɩ\0�\0\n�\n�\0�\0\0��\0��\n�\0��\0�\0��\0�\n\0
\0���������\t\0
\r�������\t���
ۭ���ߟ��߭��������ɜ\0\0\0\0\0\0\0\0\0\0\t\r\t�\0�\0�\0��\0\t\n�\0��\0\t��\0\n\n��
\0�\0\0���
\0
\t���ڿ����\0��\r�\t
\t��۟���ߟ
����￯������ݼ��\n\0\0\0\0\0\0\0\0\0\0\0\n
��\0�\0\n\0����\0\n\0\0�\n\0�\0�\0��
\0�
\n\0\0\0\0\0\n\0\n\t������ڙ�����\0���О�������������������ɩ�\0\0\0\0\0\0\0\0\0\0\t\t�\0���\t��\0�
\n\t\n\n\0\0\0�\0�\0\n\0�\n\0\t\n\t\n\n\n\t��\0����������
ݹ��

����������������������ޞ�ڐ�\0\0\0\0\0\0\0\0\0\0����\n\0\0\0\t\n\n\n\0\t�\t\0����
\n\0�\0
\n\t��\0\n\0�\t\0\0����������ڹ��������
�������˼�ޟ�����������\n\0\0\0\0\0\0\0\0\0\0\t\t�
ʐ\n\n\n\n\0�\0\n\0\0��\0\0\0�\0\t\0���\0�\t\0�\0\n\0���\t\0���������\t���\t
����\t���ۼ��Ͻ��������������\0\0\0\0\0\0\0\0\t\t����\0\0�\0�\0\0�
\0\0��\0
\n������\0\0����
\n\0\0\0\0�\n
\0�������۞��������ڞ�
��������������������\0\0\0\0\0\0\0\0\0\0��\0���\0\0�\0�\0\0\0��\n�\0\0\0�\t\0\0\0��\0\t\0\t\0\0�
\0�\n\t\0�������ߚ������
�\t������������޽�������ڞ�
\0\0\0\0\0\0\0\0\0\0\t
��\0\n\0�\0�\0\n\0�\0\0\0\0�\n\0�����\0\0�����\0\0\0\0\0�\n\t�
�����������ː���\t���
ټ�������߿��������鬰\t\0\0\0\0\0\0\0��\0��\0���\0��\n\t\0\0\n\n�\n\0�\0ڐ\0��\t��\0\0\0\0��\n\n\0\t\0\n\t\0������ڙ�����
��
ɐ�
������������߽���
�\0\0\0\0\0\0\0\0\0\0\0��\0�����\0\n\0\0���\0\0�\0\0\n���\0��\n\n\n�\n�\t\0\t\0���\0������߿�����ɹ��\t�������������������\0\0\0\0\0\0\0\0�\t�\n��\0��\0\n�\0\0�\0\0\t\n\n\n�\n\0�\t
\0\0\0\0\t\0\0���\n\n\0\0\0\0�\0\n��������������٠����\nۜ������������������\0\0\0\0\0\0\0\0�\n��\t�\0
\n\0\0\n\t\n�
\n\t\0\0\0�\0�\n\0\n�\n�\n
\n\0\0\0�\0
\n�\0\t��\0���������˽����й��\0�����������������ۭ�\0\0\0\0\0\0�\0\0�\t���\n
\0\t\n\n\t\n\0\0\0\0\n
\n\n\n\n�\0\0�\n\0\0\0\0\0\n��\0��\0\0�\0\0\0\t��������������\t\tɰ��ۜ���������������Ь�\t\0\0\0\0\0�\t\0����\t�\n\0�\r\n\0\t�����\t�\0\0����\0�\0�\n
\0\0\t�\0\n\n�\0������ߟ��������
��\0\t����\r�����ߞ���Ͻ����\0\0\0\0\0�\0\t\n\t���\n\n\0�\n\n\0��\0\0\0\t\t�\0���\0\0��\0�\n\0\0\0�\0\t���\0��\0\n����۝���������\0�\t\0\t\0�\r����ߩ���ߞ���˛\0\0\0\0\0\0�\0�ʚ\t�м\0�\n���\t\n�
\n\n\n\n�\0\0�\n\0\0�\n\0\0
\n
\0��\0���\0���\n\t����������𼚚�\0\0�\0\t������ϭ��޿�����\0\t\0\0\0\0\0\0�\0�\0�
�\n�����\n\0\0\0\t\0\0�\0\n\n�\0\n\0\n�\0��\0\0\t\0\0\n\0\t\0
\0���\0���������������\0��\0�\0���������������\n��\0\0\0\0\t\t�\0�\n��
\0�\0\n\t\0��\t�����������\0\0�\0\0�\0\0
\n\n\0
\0
\n\n\0\0�\t\0�\t�������ߛ���\n�\0\t\0\0А��˝������\n��\t\0\0\0�\n\0\0\t��\n�\0�\n�\t\n\n\n\t�\0�\0�\0\0\0�\0��\n\0\0\0�\n\n
\0\t\0\n\0
\0\0\t\0�\0��\0�������������\0�\0\0
\0
\t��������٩����\n�\0\0\0\0\0�\t�\n��\t���\0��\0\t��\n�\n\n\n�\n\n\n\0\0��\n\0
\0\0\t\0\n\0��\n\0\n
\n\n��\0��������������됚�\0\t\0\0�\0\0\0陚���ޟ\n�\0�\0\0\0\0\0�\0�\0����\0�\0���\t\0�\0\t\0\0\0\t\0\0�\n�\0\0\n\0\0����\n\0�\0\0�\0\0\0\0\0\n\t�\t�����������\t\n\0�\0\t\0�����������
��\0��\0\0\0\t\t\t\t\0�\r\t\0\n��\n\0\0\n\n\0\n\n\n
\n\0�\n\0�����\0�\0\0\0\0\0�\0��\0�����\0\0
\0����������ڰ�\t\0\0\0\0\0\0\0\0\t\t
���\0��\t\0��\0\0\0\0\0\0\nʞ
\n���\n�\n\0\0\0
\0�\n\t\0\t\0\t�\n�\0��\0\0�\0\t�������\0\n\0\t\0\0\t\0�\n\0��������������
\0�\t\0\t\0\0\0\0\0\0�\0\n\0�\t����\t\0\0\0\0\0
\t\t\t����\0\0\0\n\0���\0����
\n\n\0\0�\0�\0��\0\0��\0\0\0\0�\0��\0
\n
\n\n\n\0�\n\0\0���߿��������\t\0\0\0\0\0\0\0\0\0\0\0���\0�\0�\0�\0\0\0\0\0\t\0���\t�\t\0��\0�\0\0\0�\0\t\0�\0�\0�\n\n\n\n\t��\0��\0\0
\n\n\n\n\n\n\t\n\0\0\0\0�\0\0\0\0\n�����ϟ������\t\t�\0\t\0\0\0\0\0\0\0\0\0�\0�\0�\0\0\0\0\0\t\n\t�\t
����\t\0�\0\n\0�\0\n\n\n\t
\0���\0\0\0\0\0�\0\0�\0\n\0\0��\0\t\0\n\t���\n\n
\n\0\n�\t\0����������\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0���
٬\0�\n\t\0\0\0\t\0\t���\0\t\0��\t��ˠ�\n\n\t�������\0�\t\0\n�\0\0\t\n�\n\n\t\t���������߼��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�����Ь
\0\n\0\0��
\n\n\n\t\0�
\n\0\0\t�\0��\t\0\0�\0\0\0\0\t\t\0\0�\0��\0\n\t�\0�\n\0\0�����������ې��\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\n��������ڜ\n\0��\0\0\0\0\t\0\n\n\0\0\0
\n\n\0���\n\0�\n\n\0�����\n�
\0\t��\n\0�\0\0\t\n\0\t������������\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t�
��ܰ�

\0\0��\0�\0\n\0��\t\0���\0\0\0�\0�\0�\n\0\0\t\0\t�\0\n\0\0
��\0\t\0\t\n\n�\n\0
\n�����������\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������
\0\0�\0\n\0\n\n\t\0\0\0��\0\0\0������\0\0\t\n\t��\n

\0���\0\n�\n\n\n\t\0\0\0
\0\t�������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�ڛϟ������\0\n\0�\0\0\n\n��\0\0���\0\0\0\0\0�
\n\n\0\0\0\t�\0\0\t\0\0\0��\0\0\t\0\n\n\n�\0\n\0
�����������\t�\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������ʹ��\n�\0\0��\0\0\0\t�
\0\t\0������\0\0\0\t��\nɠ���\n��\0�����\t\0\0\n\t\n�
����������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������
��\0\n�\0\0��\0��\t�\n\n\n\0\t\0\0���\n��\0\n\t��\t\0\n�\0���\t\0\0\0\n\n\n�\n\0�����������ɭ\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
ڝ������
��\n�\0\0\n\0\0\t�\0\0�\0\0�\t\n\n\0�\0�
\0�\n\t\0�\n\n\n\0�\n\0\0\n\n\n\n�
\0\t\0\n\0\0\0\t\t������������\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�Ϲ������\0\0\0�\n\0�\0\0\0��\0��\n\n\t\0�\t��\0\0\0�\n\0��\t\0\n\n\0�\n�\t\0�\0\0\n\0��\n�\t�������������\t�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���߽�������\0��\0�\t\n\0\n\n\0�\n\0\0��\0\n\0��\0�\n
\n\n\0\n\n\0\n\n\0\0�\0�\n\n\n\n\n\n\t\n\t\0\0\0\0\0\t

���������ޚ�\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\t\0������������\0\t�\n\n\0\0\0\0\n\0�
\0��\n\0\0����\0\0\0\0\n�\0
\0\0
\n\0\0\n\0�\t\0\0�\n\t\n\n\n\0\n\t\n�����߭��޿��ʐ�\0\0\0\0\0\0\0\0\0\0\0\0�\0����������\0\0�\n\0\0\0���\0\0\0\0�\0�\t��\n\0\0驠�\n\0��\0\n\t\0\0\n�\t������\0�\0\0�
\0\n\0��������߽��\0\0\0\0\0\0\0\0\0\0\0\0\t�\n\0

޼��������\0\0\n\0�\0\0\0���\0\t�
\0\0\0\0���\0\0�\0�\0\0��\n\0
\0\n\0\0\t\0�\0\0�\0���\0\0�\0\0��������������\0\0\0\0\0\0\t\0\0\t\0�\t\t\t\r��������\t�\0\0��\0�\0\n\0\0\0\0\0\n\0\0\0\n\0\n\t\0\0�\0����\n\n\0\0\0\n\0
\0\n\t�����\0
\0\0\0��\0�
\t�����������\0�\0\t\0\0\0\0\0\0�\0\r��\0\0\nн����\t�\n\n\0\t�\n\n\0\n\0�\n\n\t\0��\0
\0\n\t����\0\0\n���\n\n\t�\0\n��\0\t\0�\0\n\0\n\n\0�\n\n\0\0\0
\0
���������\r�\0\0\t\t\t\0\0\0\t��\n����������\0\n\n\0�\0�\n\0\0\n��\0\0���\t\n�\0
\0\0\0�\n�\0\0��\0�\0\0
\n\0\0\0���\0\n���\t\n\0\0\0�\n\n\0
\0\t�������霰��\0\0�\t\0�\t\r\0\t��𽯿��\t�\n\n�\0\0\n\t\0\0\0��\0\0\n\0\0\0�\0\n\n\0�\0\0\0
\0\0\t����\0\0�\n�\0\0\0��\n\0���\n�\t\0\0\0\n�\0
����������\r\r��������𽬙ϭ������\n\0\0�\0\n
\0�\n\0\n\t\0\0�\0\0\n\n\0��\0�\0�\n���\n
\n�\0\0����\0\0\0��\0\t��\0�\0\0\n\n\t��\0\0�\0����������ښ\t\r\nڙ��
ʽ��ߩ�����\t
\n�\n\0\0\n\n\0\n\0\n\0�\0�
\0\t\0�\0�\n\n���\t\0\t\0\0����\t\t\0���\0\t��
���\t�\0\0\0\0\0��\0\0\0����������������˹������������\0��\0
\0
\n\0\0\0\0�\0\0\t�\n\0\0\0�\0��\0\0�
\n\n\n\n�\0\0�\0���\0�\n\n\0\t\n�\0\0\0�\n�\0�\n\0�\0\n��\0��������������
��
�����༽��\0�
\n\0\n\0\0�\0��\0\0\n\0\0\0\0��\n\0�\0\n\0�ɠ\0�\0�\n�\n\n�\0\0���\0�\n\n\t\n�ښ\0\0\0\t\0\0\n\0��\0�\0\t�������������������Ϛ�����\t�
\n\0\t\n�\n\0\0\t\0\0\0��\n\0��\t\0\t\0��\t\0�\n��������\0\0��\n�\0���\0\0�\0\0\0
\0\n\n\t�\0\0�\0\n\0\0\0\t����������������������������\0\0���\0�\n\n\n\0��\0\0\0\t\0�\0�\n\n\0\0\n\n�\0�\0\0�\t\0
����\t\0\t�\0\t\0��
\n
\n\0\n\t\0\0\0�\n\0\n\0��\0\0\t���������������������
�\0\0\0���\0\0�\0�\0\0\0\0\0�\0���\0�
\0\0\0�\0\0��\n\n\n\n\n

\t\n�\n\n��\0�\n\0�\n\0\t\0\r\n\0\n\0�\t\0\0\n�\0�\0\0\0\0\n��������������������
�\0\0�\0�\0�\0�\0��\n
\0�\n\0\0\0\0�\0\0\n\0�\0\n\0�\n\t\t\0\0\t\0\0\n\0�\t\0\n\0�\t��\n\0�\0���\n\0\t\0�\n\0\0\0\n\0�\n\0\0\t\0�����������߿�����
��\0��\0���\0�\0\n\0\0\0\0\n\0\0
\0��\0��\0�\0\n\t\0��\0���\n\n
\0��\0��\n\0\n\0�\0�\0\n\t\t\0�\0��\0\0\n\0\n\t\0\0���\0
ɿ������������޿��
�\t\0\n�\0\0\n\0��\0��\n\0\0\n\0\0�\t\n\0�\n\0\n\t\n\n�
�\0\0\n\0\t\0��\t�\t\n�\n\0\0\t\n\0\n\t\0��\0�\0\t\n\0\t\n\0�\0���\t�\0
�����������������\t��\n\n�\n�\n\0\t\n\n\0�\0\0\0��\0�\0\n\0\n\n�\n�\n\0\0ʰ
\t�\0
\0��
\0\n\0�\t���\0\n���\0�\0\0�\n\0
\0\0�\0��\0\n\0\0�\t\n���������������\0��\0\0\0�\0\0�
\n\0\0��
\0�\0�\0\0\n\0\n�\0�\0�\0\n��\n\0\n\t��
\t��
\t��\t�\0\t\0�\0\0\0\t����\0\0\0�\n\0�\0\0\n\t\0\n�\0��


��������
�\t���ښ�\0����\0
\0�\0\0\0\0\0\0��\t\n\0\n�\0�\0��\n����\n\0\0�\n
���ڞ\n\0\n\0�\0����\0\0\0\0�\0�\0\0\0\0�\n\0\n
\0\n\n\0���
���\0�����\0������\0\n\n\0�\0\0
\0\n\n\n\0�\n\n\0\0\0\0\0��\0�\0\n\0\t��\0�����驯���
\t�\t�\t\0\0�\n��\n\0\0�\0���\0\0
\0\0\n\0�\0����\0\0\0\0\0\0\0\0\0�\0�\t\n�ښ\n\0�\n\n��\0��\0\0\0\0\0\0
\0�\0�\n�
ྐ\0�\0�\t\n\0��������������\t�\0���\0��\0��\n\0�\0\0
\n\n\0
\0\t\n\0�\n\n�\0\0\0\0\0\0\0\0\0�
�\n\n\t��\0\t���\0\0\0�\n����\n�\t\0\0\0�\t�\0����\n��\n\t�����������\t�\n\0�\0\t\0��\t����\n\0��\0\0�\0�\n\n\0\n\0�\t\n��\0\0\0\n\t\0���\0\t\0�\t

\0\0\0��\n\0\0���\0\0�\n\n\0�\0\0\n\r����\n\0\n��\0�\n\t������������\r�\0���\0\t\n\t�\n\t\0�\t\0�\0��\0\0\0\0\0\0�\n\0\0\0\n
\t\0\0�\0\n\n
\n\n\0\0�\0\n\0�\0�\t\n�߿\n\0\0\0\0\0\0\n������������\0�\n\tʚ������������\0�\0\0\n
\n\0\n
\0\n\n\n\0�\0�\0
\0�\0���\n\0��\n\t\0\0��\t��\t\0\0\t��
\n\0\t\0�\0\n\0\t����\n\0�\0\n�\0\0���������\0۩\n���\r�������������\n��\0\0\0��\0�\0\0\0�\0�\n\0\0\n\0\t\0\0�\0\t\0\n����\0\n\n\0\n\n\n\n\0\0\n\0\0
\n\0\0�\0\n\n���\0\0\0\0\n\0\0�\n\0��������\0�\0���\0��
����������\0\n\0����\n

\n�\t�\0\0
\0\0\0�\0\0�\t���\0\0\t\t�𐚐\0�\t\n\0\0�
\0\0\n\0\0��\0��\t\n\t�\n�\0\n\0\0\n\0������ʞ���

��۾�������
\t
\0\0\0\0��\0\0\0\0�\0\n�\0\n\0�\0��\0�\0\0���\n\n\t\0��\n\0�\n\0\n�\0\0\0
\0�\n\0�����\0\t\0\0�\0\0\n\t\0�����ΐ����\t�����\r����
����\0������\0�����\0
\0\0\0\0�\t\0\0�\0\0\n�\0\0\0\0\0��\0\0\0�\0\0
\0\0��\n\0\n\0\0�\0\0���\0\n\0�\0\0��\0\n
\n�������\t\n������������
��\0�����

���\0\t\0�\0\n\0���\0��\0�\n\0��\0\n
\t\t

\0����\0\n\0\t\n��\0\n\0�������\0\0\0�\0\0\0\t\0\0������\0\0���될��������
����\n\n\n\nڼ�������\n\t\0�\0\0\n\0\0\n\0��\0\0��\0\n\n\0\0\n�\0\0\0��\n\0\0\0\t\n\0�\0\0\t���\n\0�\0\0�\n\0���
�����������ʟ���ڟ���������\0��ɭ�߾�\0\0�\0\0�\n\n\0�\n\0\0\n\0\0\0\n\0�\0\0\n\0\0\0�\0\0\n���\0\t\n\0�\n\t\0\n\0�
���\0\0�\n�\0\0\0\0\0�����\0\0\0�\t��\t�����\n�����������������\t
\n\n
\n\n\0\0\0�\t\0�\0�\n�\0\0�
\n��\0�
\n\n\0�\n\n\n\n\0��\0�\n\0�
\0��\0��\0\0\n\0��\0�\n���\r���\0��
�\n����\r��������߼\0��������\0\t\0\0\0\t\n��\n\0�\0\0\0\0\0\t�\n\0\0\0\0�\0\0\t\0�\0�\t\t\0\t\0\0�\0�\0\0\0\n
\t�\0\0\n\0\0\0\0\0\n\0��\0��������\t�˿���\t��������


��������������\n\0�\n\0�\n\0�\n\n\0�\n\0�\n\0����������������������\0�\n\0\n\0�\n\0�\n\n�
\n�\n\n\n\0����\0����\0
��������\0�������\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���','Education includes a BA in psychology from Colorado State University in 1970.  She also completed \"The Art of the Cold Call.\"  Nancy is a member of Toastmasters International.',2,'http://accweb/emmployees/davolio.bmp'),
  (2,'Fuller','Andrew','Vice President, Sales','Dr.','1952-02-19','1992-08-14','908 W. Capital Way','Tacoma','WA','98401','USA','(206) 555-9482','3457','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0 T\0\0BM T\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�S\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����������������\0\0
\0��\0\0\n�\0����������\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������\t�\0\0\0����������������\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������\0\0�\t��
�����������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�����������������
\0\0�\0\0\0������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������\0�
������������\0\0\0\0\0\0\0\0\0\t\0\0\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������\t��\0\0\0\0������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������������������\0\t�
��\n������������\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������\0����������������\0\0\0\0\0\0\0\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������\n�\0\0\0\0
���������\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���������������������\0�\0�����������\0\0\0\0\0\0\0\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������О�ɭ�����������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������\0\0\0\0\t����������\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����������������������������������\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������������۟������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
������������������������������������\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������ۿ��߽������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������߽���������������\0\0\0\0\0\0\0\0\0\0\0\0\0��\0��ښ��龐\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
������������������������������������\0\0\0\0\0\0\0\0��\n��
���������ٰ���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������������������\0\0\0\0\0\0\r���\t������������˚��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������ڟ\nа�������������\t\0\0\0\t�
�ڙ��������ߛ�ۙ����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�����������������������\r�
�߿��������\0\0\0\0\0\t��
�
۞�����������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������
����\r\t
߿�������\0\0\0

���������隞�ߙ������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���������������ޭ�������ڝ������������\0\0\0�����\t������۟���������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������������\r���\t���������\0\0�\0����🟛
�魭���������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������ߟ߼��ڞ�������������������\0\0���\r�
ɼ�����ۛ۟
�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��������ۻ��ϰ���ޟ�\r�����������
�����\0\0
��ۛ�˛��۽����𼛟��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������ܰ�����������������ϛ����\0�������\r������ۛ�������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������ٿ����
�\r����۞\t�\t�\r����ɞ�������\n���˟
������ۛ\r����驹������
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������ͭ����\r\t�\t�����ڞ\tР
�ڟ���\0\t�۟���
���������
�������
�����\t���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����
������\t𜜰�О�������������������\t���𼹰��鯛��
��
���
�˝��𽚛��ې��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�������
ɩڙ��п��\r������������������\0\0���۞��
��������𼼟��������ɹ뛭���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������м�����
������������˟��𿞞��\t\t

�\r�˩�������
Л�����������۝������\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\t���
��ɩ�������\t������ޛ�߽��۟�����\0�\0й����۟
���𼿼���۟�������\r�𹭹���\0\0\0\0\0\0\0\0\0\0\0\0\0
��˛ϰ�\r\n��������ߞ��
齽������߿������\0\t\t

\r�٩���ٽ�����˞��
�ۭ��ڝ�����������\0\0\0\0\0\0\0\0\0\0\0\0��靭��

�
����\r������������������������\0\n�
��
��ۛ
���
Ͻ�����������٭�鼟�鯙�\0\0\0\0\0\0\0\0\0\0\0\0������\t��\t����\r��п�����������������������\t\0\t�𼹭��𽫛۟
��
˚н�ڝ�н�
��٭\0\0\0\0\0\0\0\0\0\0\0
�\t��\r�\0���\t�����ͼ������������������������\0�\t��ۜ��˟�����������
˽���
˚��������\0\0\0\0\0\0\0\0\0\0������\r\r�\t�
������������������������߽����\0\0\0\t\t��˼�����۟��ۛɩ����ڝ����\r��ۙ�\r\0\0\0\0\0\0\0\0\0\0������\r�����\t����ڝ��������������߽�����������\t�\0������������������
ɭ�����ڛڟ\r�����\0\0\0\0\0\0\0\0
�\r�ۛ\0���
�ښ���������������������߿���������\0\0\t\0���ɭ�����۟����������н���������\0\0\0\0\0\0\0\0�����\r\t��������������������������������������\t
\t\t�ٹ��𼼰�����\t��鞙
��
������
\0\0\0\0\0\0\0\0�
ڙ������\t��˟�������ڽ�����������������������\0
\0������\t�۟�ڞ�ڛ�۞�ې��������˙����\0\0\0\0\0\0\0�\r���\t���˟��\t�����������������ߟ���������������\0\0���������������𽼹�����
\t
۝������ڞ��\0\0\0\0\0
�\tК��\0�������������������������������������߽��
\0\t�隞����
����ڛ�����
�
�К������\0\0\0\0\0���
\0�����������ɽ������������������ߟ����������\0����۟\r����������𽼹�����������������\0\0\0\0\0�\r��\0�魹�����������˟��ڟ���۟�����������������\0\0\0
���
�����˟�
�˞�ߙ��\t�����н���\t
�\0\0\0\0��\t鰟\t�������ۛ��߽���ߛ۟��������߽������������\0\r\0�������������������ښ���а�����ɭ���\0\0\0\0���\t\0\0\t�������ۼ��鼟��ٰ���������߿��������������\t\n\t��м�
������齼������
�
�ڛй���
\t��\0\0\0
�\t��\r\t���
�߿ɛ������۟��۟��������������ߟ���\0\t\0\0��
۞���˹魩�������ڜ����
���鯞����\0\0\0\0\t�\0�������
�ߛ��۟�������н��������߿������������\0\r\t鰽��ڞ��ϙ�����������
������ɩ�������\0\0\0\0
��\0���ɿ���������������������������ۿ�������������\t����
����\r���
���������Л��ڟ
����������\0\0\0����\t������������������������������������������ۿ��\0�\t�����������۞��
�ې���鼚������
�
��\t�\0\0\0\t�\t\t������������������������������������������߿�\0
�\t������
����������˞�����
ڟ���������\0\0\0��

���ߟ�����������۽����������������������������\0
\0���𼺚���������������🐟��ۙ����\t\0\0
��������������������������������������������������\0\0�\t��������������𼾙��
������
�魭���\n�\0�������߿ߟ����������������������������������������\t�\n����������˟�����ɽ����\r��ۛ
����ː���ٹ��������������������������˛�����������߿�����\0�\t

���������м����\t����۟���𹭭��˞�������������������������������������������ߟ�߽��������\0�����\t�齽������ڟ�����ڝ���˜�����٩�
��ې��\t����������������������߿������������������������\0\0�
���
��������������٩���ڙ�����𼰼��\r����߿�߿����߿������������������������������߽���\t\t\tɩ���������˟���ڟ\r��˞������������\0�����鿿���ߟ���������ߟ���۟������������������������\0\nɩ��˞��۞���߽���𚛩�۞��˛�˛��ɿ
����
�����ٿ۟�������������۟\r��������������������������\0������������\t��
���\r�������ɽ�����ڙ�\t�\t\t��������������������ߟ���ٹ��۟����������������������\0�����˞����鿟�������ۛ�ڟ������𝭐�\r�\t�\r�˝�����߻�����������𛝟������������\0�������������\t�

۞�۟
�
˛��ߝ������𹞝�𹟰��ڛ
��\r��۞������������������˙���۟۝��ِ\0\t\t������������\0\0\t\t��鼼�������驭���ۛ�\t�����
��\t��������������������������\0\0\t\t���ٜ�����\t\t\0���������������\0���齚�ۛ�
�
˛���ɹ�\r������\r����ڐ���\r��\0������������������ې
\t\t\0��\t\0\t\tɭ\t\t����۽���������߿�\0\0\0˞��۩����������������
Лٛ��˝��˞�\t
���۞������������߽�ٽ��\r\t\t��ٽ����������߿��������������������
ڞ�ڛ����������𛟐���
��\0\0�\0ڼ��������������߿����ߛ۝��������۽�߿��������������
\n
�������۟�������
ښ�
\r��������ۜ�\0\t�\t�۟�������������������������߽�������ߟ������������������鼟���
�˛��\t��й����ɽ����\n������
ɭ����������������������ߝ������߽�������������������\0\0��
�����������������������
˟
�������������������������������������������������������������\t�\0��������

ۛ���
��������\t��齰������\t\n�����������������������������������������������������\0\0\t�����ڽ������������
�����ڟ����\r��������ߞ�����߿����ߟߟ������������������������������������\t������ٯ��������\t������ڰ��ۙ˟��������ٹ˟������߿�����������������������������ߟ����������\0����魯�����
������
���
������������\t����������������߽�����������������߿�����������������\t
��\r�����������\t��ɛ��𰽩��۟���������
����������������������������\t������������������������\n\0�����𺞛۟�
���\r�����\tڝ����������а�������۟���������ߟ�����������ۛ���������������������\t\r������������ۜ�\r�������������۟���\r��۝
������������������������ߝ������������������������\0\0��˽���������
ϭ�ɺ��������������������
�\r���������������������\r��ٿ���������ߟ����������������\t\t���������ٹ���й��٭����\t��\r����������
٩��������ߟ����������������������������������������\0�������۟��ڞ��
��\t�٩��🰹ڛ�������
\t𽾟���۽���������������������\t�����������������������\t���
��˛�ٹ�������ٰ�ڐ������������\t���������۽��������������ۙ�����������������������������\0\t����������������٭
\t��
۩�����������\t���ڟ���������������������ٽ�\0�۝��������ߟ������������\0���ڞ��\t����۟����۽����\t�ٝ��������
��\r���۟�������������߽�����\0\tۛ��߹��������������������\t���۞��
�
���������

�𼰚����ߟ�\t�\r�پ������������������߹��\t�٭�������������������������\0\0�����������۞������ۚ�𐽛���������������ٛ���������������ߟ������������������߹��������������\0�鿛ߞ��鼰����\r\t�����
ɩ�����۝������ɾ���ٿ����������߽�ߛ����������������������������������\0�𰽽���������������ڐ���������������ڝ���ߛ��������������ݻ����ٿ����������������������������������ڿ�ښ�����\r����\t������
��������Н�������۟�������������������������������ߟ�߿�����������\n���ڟ�О��������
\t���ڐ���\r�ݿ��߿����ټ������߽�����������������
���������������������������𐚛��������������ڙ��\t�ɛɺ����������˼�������߽�����������������������������������������������\0\t��ڝ������
��������
�������������\tə🟽���������������������������������������������������\t�������������뜰������ۛ���������
�������۽�������������\t����������������������������ߟ�\0\t�����
۟����ɜ����˙
ː������������\t�۟��߿���ٟ��ߟ���߿����������������������������������\0�˟���
��������
��
������\t����߽����\r��������������������������۹�����������������������������\n���������ͩ���а���
�
\r\t��\t������\t����˟���������������������ߙ����������������������������\r\t�пߚۛ˽����

�����
\tڐ����������\0��ڐ�������������߽�����������ߟ�߽������������������������\0�����ޛڜ���������
�����������������������������������ߟ����������������߽��������������
�����ۛ����������٩�����\t�\0�Л������
��\0����
������������ߝ�������������۟��������߿�����������ɝ��\t\t����������
˿��М���ڛ�\0�������ٛ�\0\t鹚����������߿��������������߿������������������������А�����������۟�˙����\t��ɹ���������
�����Ϲ�ۿ������۟���������ۙ�������ߟ����������������\0��\0۟�ߟ�������ې��\r������\0���
������\t������������߿��������������˟��������������������������\0�����������˼�\t����\t�ɛ������ߟ��\0\0\t���ڝ���ۿ������
����������ߝ�������߿ϛ�۟����������\0��\r\0�����������
��\0���
ڛ���Л������
�\0�\0���\t��������������������������۟�����齽���������������\0\t鹽�\r����߹����ٰ��\t\r�\t\t���ٿ�ߝ�\t\0��۟�ۿ۟��۹ڟ���۞����۟�������������������������������\n������𹰽�
���
\r\r��
���\0���������\0\t\0۝��齽���������������ٯ�����������������ߛ�����������
���\t��������
����ۙ����\t\r��
����������\0\t��۟������ߛ������������۽����������߽�����������������
�����ڟ����\r������\r\t\0𹜐�\t
������
�\0\t\0������������ۛ����\r���ۿ���ޛ����������������\0
�����\0���\r����齩������\t���ې�𼙰�ߟ������\0\0\t�۟���ۿ��ٙ����������ݽ������������\t���\0��\0\0�������\r���ڛڛ˟
Ϛټۜ\t�
\t�
\t\t�\tɿ�����\t\0\0\0\0������������П��\t���\t
������
����������\0\0\t\t��\0��������\t�\0��������������ۼ����𚝼����������\0\t\0\t\0����������\0\0���\0\0\t�ٙ�\t���������ڙ�\t�\0��\0�\0��\t������\0\0��
��齩���\t��߭���\t�
��
��\0����\0\0\0\0\0\0�н�럟۟���\0\0��\0\0����\t��й��������А\0\t\0\0\0��߿��𭼐\tɛ�������۩�𹰼�����\t���\t����\0\0\0\0\0\t˹������������\0\0\t�\0��\0�����ۿ�����������\t\0���\0���߿��\0\n���
˝���
˿���\0\r
ː�\r���魚\0��\0\0\0\0\0\0\0\t˟
߻����������\0\0�\0\0\nٟ�𝹽������\t\r�����������������\0�\r\tٽ������н���٩�������ɐ���\0\0\t\0\t\0�\t\t\0����\t
�齾�\r�����\t����🭽���������������\0П��������\t\n\0�ڛ��ޙ�����ٽ\n���\t�ɰ���
�\0\0\0\0\0��\0\0\n\r������ߐ�����\t˙�������\t������������
\t
�\t\t����������\0���
������\r
�پ𹚐����\r\t�\0��\0\0\0\0\0\0�\0\t�����ۭ�
����߽ڐ�КА�������������������������������\t�\0�\0й˟��ڽ����\r�\t\r\r
����
\0\0\0\0\r\t��\0\0�������\0��\t��߽�ٻٟ������������߻�\t�����������\r���
��\t�
ڽ���ۭ
��˿�����������\0���\0\0\n\0\0��\t�ڛ�������\t𙭹���߿�
����������������\0�\0����\t\0\t\0\t������\0�\r
�˞�\t��٫�����\n��\t�\r��\r��\0\0\0��\t�\n\0��������٠��
������А��\tڛ���������\t\r\n�\0\0\0\0
\0�\r\0\0����
��\t\tɩ���鰼�����𰛐�ښڐ����\0\0\0�
\0\0\tɩ�������\0\t\0�\t�\t
\r\0\0�ɰߛ���������\0\t\0�\0\0\t\0\0���\t�����\t�\0��۟ڛ���ڐ�߽
��\t��\t�ɩ鐐\t\0�\0\0\0�\t\0����������\0\t\t\0�\t��\r�\0\0\0\0�\0ɐ����������\0\0�\r\0\0����������
�\0�\n������\r����й��ې��О�\0\0\0\0\0\t\0�\0\0������ڟ��\0\0\0�\t�\t\t\n\0П\t\0�\t\n\t�����������\0�\0\0��\0���������
��\0��������ڛ
��
��٭\0��\t��\0�\0\0\0\0\0\0�
\t

۟�۟����\0\t\0\0\t��\tɠ�\0\0\0\0\r������߿������\0\0����\t�������\t���\0��\t�й\t���\r��𼚙�ٹ��Й�\0\0\0\0\0\0\0
\n\r����������\0\0����\0\0\t\t\0\0\0\t�������������ې\0\0���\0�����������\t�\0�\r�����К���\t��ɩ��ښښ�\0\0\t\0\0\0�\0�\t\0�������н���\0�����\t\0
�\0�������������������������������

�
\0\0����\t��
��
��ۙ���\t\t\t\t\r
�\0
\0\0\0
\0\0К������������������\0\0�����������������������������������\0�\0\0�ڜ�����
\t�\r������\t\0\0\0\0\0\0�\0\n\r\0������������\0�\0\t
������������������������������������������\0\0���ڜ�\t�\r\t������\t�����\0\0\0\0\0\0\0\0\0�ɹ������������О��ߛ�������������������������������������
\0\0\0\0\0\0\0\0\0�\0\0\0�\0\t\0\0�\0\0\0\0\0\t\0\0\0\0�\t\0\0\0�\0�
������������۟�������������������������������������\0��\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\0\0�а�����������������ߟ��������������������������������\0����\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\0
\0\0\0\0�\0\0\0
�����٩���ߟ�������������������������������������������\t���\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\0\0�\0�
\0���
߽����������������������������������������������\0
���\0\0\0\0\0\0\0\0\0\0\0\0\0預\0\0\0\0\0\0\0\0\0\0�\0\t\0\0\0\0�\0\t
�\r\t�������ۛ�ߟ���������������������������������������\0��

�\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\t\0\t\0\0\0\0\0\0\0\0\0�
п�������������������������������������������������\0\0��\t��\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t�\t\0\t\t\0
ɽ����߽�������������������������������������������\t
ɼ
��\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0\0\0\0\0\0
\0
\0\0\0\0\0\0\0\0����������߿����������������������������������������\0����
�\0\0\0\0\0\0\0\0\0\0\0�\0�
\0\0\0\0\0\0\0\0�\t\0\t\0\0\0\0�\0\0\0\0�\tɺ��
������������߿�����������������������������������\r�\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0\0
\0�\n\0\0\t\0\t\0\0\0\0\0\0\0�\0�
����������߿���������������������������������������\t\0�\0��
�\0\0\0\0\0\0\0\0\0\0\0�\0\n\0\0
\0�\t\0\0\0\0\0\0\0\0\0\0\0��\t\0\t�
��ڟ������������ߟ���������������響��������������\t\r����\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\r\0����۟���������������������������\0����ۿ���������\n\0���\0\0\0\0\0\0\0\0\0\0\0\0�\0��\0\0\0��\0\0\t\0\0\t\0\0\0\0\0\0\0
\t\0����������������������������������\t
������ٙɹ������\t\0\t\r\t���\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0��ܛ���������߿�������������������ɐ��������\0������\0��
��\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0
\0\0�\0\0\0\0\0\0\0\0\t\0\0\0�\t�\t�������������������������������\t������\t������\n��\0�
�\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0��������߿�������߽�����������\t\t�л���\t�\t\t
�������\t�\t��
\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0
Щ
�����ɽ������ߟ�������������ِ
�\tߝ
\t��м\t\0�����\0��
���\n\0\0\0\0\0\0\0\0\0�\0\0��\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���˛���������ۿ�������������\0�ɛ�\t��ڟ\0\t\0�\0����\t���ɾ���\0\0\0\0\0\0\0�\0\0\0�\t\0\0\0\n\0\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\t\t����ߟ�����߿���������
\t\0�\0��\t��\t�\t\0��\t\0������\0�\0\t��\r�\0\0\0\0\0\0\0\0\0\0
\0\0�\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\t
�ϟ����۽�����߿�����Й�
𝽜�������\0\0�������\t\t�\0Ь�
\r\0\0\0\0\0\0
\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\n�\n\t\tː�������������߿������𙼚��

\t��\0\t
�\0\0�\0�����\0\0\0��
\0��\0\0\0\0\0\0�\0\0\0\0\0�\n\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\t\t
\0��\t�������۟�߿��������\0����\t�
\0���\0�\0\t�\n������\0\0\0�\0��\0\0\0\0\0\0\0
\0�\0\0�\0�\0\0\0\0\0�\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\r������������ߟ������𰟐\t�\t�\0\r\t�\n\t\t\0\t��\t�ߐ
�\0\r�\t\0\0
\0��
\0\0\0�
\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\t\0\0\0�𜰝��ޟ���������������\t��\t�\0\t����\n\t\0\0\0�\t\t���\t�\0\0�\t\0\0��
��\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0��
�����������������
��\t\0�

\0��\0\r\0�Н�\r\r\0\0�\t\t�\0\0\0\0�\t\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0��\r������������۟�������А�\0����
\0\0�

\0��\t�🐠\r\0\0\0\t\t\0\r�\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0
�\0
\0�����������������\0��\0\0�\0\n�\t�\t\0\0�\t
\0��˭\t��\0�
��\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t�\t���������������\t���\0\0�����\r\t����\0��٭���\0\t\0\0\0\0\t\t\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0�\0��\r���������������\t�
\t\0\0�\0\t�\0\0�\0\0\t\t��ɬ���\n\t\0\n��\0\0\0�\0
\n�\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�
��\r����ߛ���������\n�\0\0�\0�\r\0�\t\t\0\0\0�\0�����\0��\0\0\0\0�\0\t\r��\0\0\0\0\0\0�\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\0�\r���������������
\r�\0\t\0\0\t\0\t��\0\0�\0\0\0\0\0�\0
�
\n\0�\n\t\0�\0\t\0\0���\0\0\0\0\0\0\0\0\0\t\0�\0�\n\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0\t�\t
\r�������������А��\0�\0��\0�\t\0�\0\0\0\t\t\0\0\0���\0���\t\n\0��\0�\t
��\0\0\0\0�\0�\0\t\0\0\0�\t\tʐ\0\0\0\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\0\r���������������\t\0\0\0\0\0\0\t\0\0\0\t\t\t\0\0\0\t\0
\0�\0\t��М\0\0\0\0\0\0\0�\0\0\0\0\t\0�\0\0\0�\0\0�ࠐ\0\0\0\0
�ɠ�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t韟�ߛ��������ɐ\r\0\0�\0\0\t\0\0�\0\t\0\0\0\0\0\t\0\0�\0���\t\n\0\0\0\0�\0\0\t
�\0\0\0\0\0�\n\0\0\0�\0\0�\t
�
\0�\t\t�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0���������߽�\0��\0�\0\0\t\0\0\0\0\0�\0\0�\0\0�\0\0\0�\0\t\0���\0�\0\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0
\t\n
\0
\n\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�������������ɩ\0\0\0\0�\0\0\t\0\0\0\0\t\0\t\r\0�\t
Э\0\0�\0\t�\0�\0\0\0
��\0\0\0\0\0\0\0\0\t�\0\0\0�\0\0\t

\n�\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t\0\t������������\n\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0�\0\0�\0���\0\0�\0\0\0\t\0�\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0���
���\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������А��\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\t\t\0�\0\0�\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0�\0���\0����\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��鯝�������\0�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0���\0\0��\0�\r\0�\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0��\n
\t\t�\0��\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\0\0����۽�������\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\t\0\0\t

\0\n�\t�\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\n\t\0\n�\0Р\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t�����������\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\t
\0�\0\t�\0�\t�
\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0�\0�\0���\t�\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\0\0\0\0\0\t\0
\t�۟�������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\n�\t�\0\0\0��\0\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\r\t\r��\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�\0\0\0\t\n����\t����\0\t\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0�\0\0�\0\0�\0�\0\0�\t\0\0ɩ\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0���\n\n\0\0\0\0\0\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\tʞ����\t�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t��\0�\0\0
\0�
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n�\0\t�\0\0\0\0\0\0�\0\0\0\0\0\t\0�\0\0\0\0\0\0\0\0\0\t\0\t\t�\t�\nа�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0\0\0�\0��\0\0\0\0\0
\t�\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\r��\n\0\0\0\0\0\0\0\0\t�\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\t\n����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�ʐ\0\0А�\0�\0\0���\t
\0�\0\0\0\0\0\0��\0\0\0\0\0\0\0\0�\n\0\0\0\0\0\0\0\0\0\0\0\n\0\0\n\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\r\0\r\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\n�\r\0\0\n�\0\0
�\n\0\0\0\0\0\0\n\0�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0�\t�
\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��\0���\0�\t\n\t���\t\0\0\0
\0\0��\n\0\0\n\0\0\0\0\0�\0\0\0\0\0\0��\0\0\0\0�\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0
��\t\0\t�\t\0\0�\0�\0\0\0\0�\0\t��\0\0\0\0\0\0\0\0�\0\0�
\0�
\0�\0\0�\0\0\0\0\0\t\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\t\0\0���\0�\t\0\t\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0���
\0�\0�\0\0\0\0\0\0\0\0
��\0\0\0
\0А\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0\0\0\0\0\0\0\0���\0\0\0\n\0
�\0\0\0\n\t\0\0��\0\0\0\0\0\0\0\0�\n�\0\n\0�\0\0\0\0\0\0\0\0\0�\0�\r�\t\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0��\0\0\n�\0\0�\0\0\0�\0\0\0\0\0\0\n\0�\n��\0\0\0\0\0\0\0\0��\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\t

\0\0�\0\t�\0\0\0\0\t\0\0\0�\t�\0\0\0\0\0\0\0\0ښ\0\0\0\0\n\0\0\0\0\0\0\0\0\0\n\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0�\0\0\0\t\0�\t\0
��\0\0\0\0\n\0\0\0��\0\0\0\0\0\0\0\0\0��\0\0\0\0\0��\0\0\0\0�\0\0\0\0\0�
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
\0\0\0\0\0\0�\0��\0\n\t�\0\0�\0\0\0\0\0\0\0\0\0�\t\t�\0\0\0\0\0\0\0\0�\0\0\n\0\0�\t\0\0\0\0\0\0\0\0\0\0\0�\0�\0��\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\0\0��\0\t\0\t�\0\0\0\0\0\0�\0\0\t\0�\0\0\0\0\0\0\0\0\0�\r\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0���\0
�\0\0\0\0\0\0\0�\0\0\0�\0\0\0\0\0�\0\0\0\0�\0�\0\0��\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0�\0\0\0\0\0\0\0\0\0�\0�\t�\0���\0\0\0�\0�\0\0\n\t\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\0\0\t\0\0�\0�\0�\0�\0\0\0\0\0\0\0\0\0�\0\t\0\0\0\0����\0��\0
\0\0�\n\0\0\0\0\0\t�\0\0\0\0\0\n\0\0
\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\r\0\0\0\0\0\0\0\0\0\0\0\0\0ཀྵ\t�
�\0\0\0�\0\0\0\0\0\0\0\t�\0
\n�\n\0\0
�\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\t�\t\0\0\0\0\0�\0\0�\0
�\0\0\0\0\0\0\0\0\0\0\0\n\0\0�\0\0
\0\0
\0\0�\0\0\0\0
\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\0\0\0\0\0\0\0�\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\n�\0�\0\0\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0��
�\0\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0��
\0�\0\0\0\n���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n
\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\n�\t\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0��\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\t�\t
\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0����\0\0\t\0\0\0��\0�\0\0\0\0\0\0\0\0\t\n\0\0\0\0\0\0\0�\0��\0\0�\n��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t�\0\0\0\t\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0���\n\0\0\n\0\0\0\0\0�\0\0\0\0\0\0\0\0\0�\0\t\0\0\0\0\0\0\0\0\0��\0�\0
�\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0\t�\0\0\t\0\t\0\0�\0���

\0�\0\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0ʚ�\t\0�
\0\0\0\0\0�\0\0\0\0\0\0\0\0\0�\0�\n\0\0\0\0\0\0�\0��\0\0\0\0�\0\0\0\0\0\0\0\0\0�\0\0\t
\0\0�\0\0\0\t\t\0\0\0\0\0�\0�\0\t�\0
\t\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0�\0\0\0\0\0�\0�\0��\0\0\0\0\0\0�\0\0�\t\0\0�\0\0��\0�\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\0�\0�
�\0\0\0\0\0\0\0\0���\0\t\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0\n\0\0\n\0\0\0\0\0��\0\0\0\0\0\0\0\0\r\0\0
���\0\0\0\0\0
\n\0\0\0\0
\0\n\t\n\r\0\0\0�\0\0\0\0�\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0��\t�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0�\0\0\0\n
�\0�\0\0\0\0\0\0\n\0\0\0��\0\0�\0\0\0\0\0�\0\0\0�\0�\0\t\0\n\0\0\0\0\0�\0�\0\0\0\0\0\0�\0\n�\0\t\0\0\r\0��ڐ\0\t\0\0\0\0\0\0\0\0\0\0\0\0�\0�\n\0\0\0\0\0\0\0\0�\0��\0\0\0\0\0\0\0\0\0\t�\n\0\0\0\0\0�\0\0\0\0��\0\0\t�\0\0\0
\0\0\0�\0�\0\0�\0�\0\0\0\0\0\0\0�\0�\n�\0��\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\0\0\0\0\0\0\0\0\0
��
��\0��\0\0\0\0\0��\t�\0\n\0\0�\t\0�\0\0\0\0\0\0\0\0�\0\0�\0\t\0\0\0\n��\0\0���\0\0\0\0\0\0\0\t\0\0�\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0
\n\0�\0��\0�\0�\0\0\0\0\0\0��\n\0\0\0�\0\0\0\0\0\0\0\0\n\0��\0��\0\0\0\0\t\n�\0�\0Щ\0\0\t\0\0\0\0\0\0\0\0\0\0\0�\0�\t\0�\r�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0�����\0\0\0\0�\0\0\0\0\t\0\t�\t
\t\0\0\0\n\0\0\0\n�\0�\t\0
�\0\0\0\0�\0�\0\0\0\0
\0\0\0��\0\t\0�\0��\0\t\0
\0�\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0�
����\0\0\0�\0\0\0\0\n\0\0\0\0
\0\0\0\0\0\0\0\0\n\n\0\0�\0\0
�\0\0�\0
�\0��\0�\0��\0\0\0\0\0\0\0�\0\0\t\0\0��
�\0\0\0\0\0\0\0\0\0\0\0\0\n\t\0\0\0\0\0����
�\t\n�\0
\0\0\0�\0\0\0�\0\r�\0\0\0\0\t
\0\0\0\0\0\0\0�\0\0�\n�\0�\0�\0���\0����\0��\0\t��\0\0\0\0\t\0\0\n�\r\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\n�\0�

\0\0\n\0\0\0\0\0\0\0\t\0\t\0\0�\0\0\0\0\0\n\t�\0\0\0\0\0\0\0\0\0��\0�\0
\0���\n�\n�\t\r��\0
\n\0\0\0�\0\0\0\r\t\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0�\0���
��\t\0\0\0\0\0\0\0\0�\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0�\0��\0�\0А�\0\t\0���\t\0\t\0\t\0�\n\n\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\0\0\0�\0�
\n\0�\n\0\0\0\n\0\n\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0

��\0\0\0\0\0�\0�\n\n�\t\0���\0��\0

\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0���\0�\0\0\0\0\0\0\0\0\0\0\0\0\0��\0�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0���\0\t�\0\0\n\0
�\n��\0\0
\n��\0\n��\n\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\n\0�\n\t�\0\0\0\0\0\t\0\0\0\0��\0�\0\n\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0��\n\n\0�\t\t\n\t\t�\0\t\0\0��
\0\0\0\0�\n
\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\0\t�\n\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\n
\0\0�\0\0\0\0�\t\n\0\0
\0�\0�\0\0\0\n�\0\0\0��\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0\t\0\t\0�\n�\0\0\0\0

���\0\0\0\0\0\t\0�\0\0�\0�\0\t
\0\0

\0\n\0\n\0\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\n��\0\n\0\0\0\0\0\0\0\0\0\0\0\0\n\0\n\0\n�\0\0�\0

�\n\t��
�\0\0�\n\0\0\0\0\0\0\0\0\0�\0

\0\0\0�\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\n�\0\0\n\0\0\0\0\0\0\0\0\0\0\0��\0\0\0�\0\0\0\0\0\n\0\0\0�ښ�
\0\0\0\0\0�\0\t\0�
\t��\0\0\0\t\0\0\0\0�\0\0\0\0\0\n\0�\0�\0��\0\0\0\0\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0�\0\0\n���\n\0��\0\0\0\0�\n��\t�\0�\0\n�\0\0�\0\n����\0\0
\0��\t\n\0\0\0\0\0\t\t
\t\0\0�\n\0\0\0\0\n\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\t\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\n�\0\0\0��\0\0��\t\0\0\t
�ɠ�\0�\0\0\0\0\n\t\0�頰�\0\0\0\0\0�\0�\0\0\0\0\0��
�\n�\0\0\0\0\0\0\0\0\0\n\0��\0\0\0\0\0\0\0\0\0\0\t
\n\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0\0\0�\0\0\n���\0\0�\0\0\t\0�\0\0\0\0\0\0\0\0\t��\0\t��\0\0\0\0\0\0\t\0\t
�\0�\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\n
�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\0\0\0\0��\0\0\0\0�\0\0��\0��\0\0\n�\n��\0\0��\0�\0�
�\0\0�
\0
\0\0\0\n\t�\0��\n\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\n���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
\n\0\0
\n\0\0�\0\0\0\0\0\0��
�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���','Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.',NULL,'http://accweb/emmployees/fuller.bmp'),
  (3,'Leverling','Janet','Sales Representative','Ms.','1963-08-30','1992-04-01','722 Moss Bay Blvd.','Kirkland','WA','98033','USA','(206) 555-3412','3355','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0�T\0\0BM�T\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0T\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0�������������������������������������������������������������������������������������������������\t�\n�\t����\0\t�������\t��\n����
�������������������������������������頚����
��\t����
�
�骚��\0\0��\t\0��
���������
�������ఛ�����������������������������������������������𾻯����ں��
����੯�������������������
��\r��������������������������������������������꼺������魩����\0
�����
�\0�������𾟩뜩��
������������������������������������������隟��������������������\t\0��\0\0��
��������������������������������������������������������������������\t��������������𰐼�\0\t

\n
��
ʚ������\0����˜��������
����������������������������������������ۿ��\r��������\0\t��
\0\0\0\0н����������ڿ��ྐྵ����\t���������������������������������������������
�麻��ۿ
��\n�
�
��
\t


�����\n
������ڿ\n��

��\n�������������������������������������������������
�ڻ���\t
\t��\0�
\0�\0�

�믟������������ϼ�鹩���
��������������������������������������\n����������\n
�\0�����\0����˺�
������ޜ��
�����

��������������������������������������������
���˞ڰ������\t\0\t

��\0
��\0\t������\n�����Ꙡ����
���������
�����������������������������������������뼚\t��\0��������
\0����뛯
�������������

�\t��\0�
\n�˫ۿ�����������������������������������
�����뼫�\0\0���\t�����𐰰\n
�\t������
�����������\t����˰�����������������������������������������
��
�����\0�
\n������\0\t\t\0���
�������������˩�����鯩�
驿�������������������������������������˞��
�
\0�\0\t\t����\0��\0\t\0�


��
�
\n�������п��
\0������
������������������������������������齿�\0�
������\0��
˩����\0�\n����\0����\t����
�����\n\n���\t�����������������������������������������\n\0
������\0\0\0\t\t
��
\r�\0\t
˩\n���
�������ɪ�����\0������ڜ����������������������������������������������랼�\0\0��������\n����\0���۫��\t�\0����\0�\t�\r�\n���\0������������������������������������\n\0�˛�
���
\0�\0��\t��\t�\0�����������𰺚�\0�\n
�������\t�ʚ�ʐ���������������������������������������������
�됹�\0�
����
�\t

ۺ��
��

�\t�ھ�ۚ���\0��Р�
\t����\0\t��\0��������������������������������
��
���\0���
ʰ�\0\0\t����\t\n\0\t�﫺�\t��𚾚������\t
\n����\t\0���
\0\t\0��\0\0\0�����������������������������������������
�
���������
��
\t��
��
��
ڞ
���\t\n�����\0��\0\t\0\t\0\0\0\0\0������������������������������\0���
𰿺�����\n����\n�\n\0���
��\n�����ڰ�����
\t\0���\n\0�\0
\t\t\t\0\0\0\0\0�\0\0�����������������������������������
���\n���\t
�\0����\0�\t�����\n���

ɩ��
�
ʐ\0�\0�\0�����\n\0\0\0\0\0\0\0\0\t\0\t��������������������������������
�

�����༚��\n��\t\n���˰���������𰩩\t�\t\n\0\0\0\0\t\t\0\0\0\0\0\t\0\t\0\0\0������������������������������������ꐩ
\t
\t�

�\t\0\t���麚��\n���\r���\0\t\0\0\0\0��\t\n��\n\0\0\0\0\0\0\0\0\0\0\0\0�����������������������������\t���
��
���ʐ�\0��ɠ��\0\t����\0\t�
�������\t
\0\0�\0���\n\t\0\0�\0\t\0\0\0\t\0\0\0\0\t\0�������������������������������\n\0���\t����������
��\0
�\r����\t��

�˭\n\0�\0\0\0\0\0\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0\t\0\0
�������������������������������ڜ��
�л���\0�
𺩩�\0��������������\t�����\0\0\0\0\0\0\t\0\t\0�\0\0\t\0\0\0\0\0\0\0\0\0\t\0������������������������������\n\t�\n
఩�


\n�\t�\0�\0���������ꛠڞ\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t����������������������������\t�������
\t��\0��


ɪ�\0��ڿ���������\t���\n\0\0\0\0\0�\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0�\0\0\0������������������������������\0�\n\t�����\r\n
ɩ�\0���\0�����˭���\n�ʰ𰐠\t\0\0\t\t\0\0\0\t\0\0\0\0\0�\0\0\0\0�\0�\0\0\0\0\0�������������������������������\n������\r�\t��
�\t𩠚\0

�����ﭐ\0�\t\n
�\0\0\t\0\0\0\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0�
���������������������������\t\0\0�\t\0\0\0\t\t�\t��
\0�\n\0�\t����۰��
������\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\t�
�������������������������\t\t\0\t\0\0\0\0\0\0\0\0\t�\t\t�������\t
��
���఩�\n�\n\t\0��\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�
���������������������������\0\0\0\0\0\0\0\0\0\0\t\0\t
�\t�

��
\n��������
�\t\0����\0\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t�������������������������\0\0\0\t\0\0\0\0\0\0\t\0\0\0\t\0\0\0������\0�˞���\t˺�����\n�\t\0
\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\0�����������������������\0��\0\0\0\0�\0\0\0\0\0\0\0\0\0�\t\0�\t�\n\t\n
\n���뼹��\0��\t\n���\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0\t�����������������������\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�\0��ʐ�����
�갿�\t頩\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\t�����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0����\t��������
�\t\0��\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0�����������������������\0\0�\t\0\0\0�\0\0\0\t\0\0\0\0\0\0\0\0�\0�
��������
鼺���\t
ʚ\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�\t\0\0\0\0\t\r
�����������������������\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\n
ɭ\0�\0������˫
�˯\t\0��\t\0�\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n����������������ٟ�����\0�\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\t����\t�����ɰ����\t�\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\t\n������������������\t���\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
��\n�����Ʞ���\0���\t\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n����������������ۜ����\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t��\t���������ڰ�����ఠ\t\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0��
�������ߟ�����������\0\0\0��\0�\0�\0�\0\0\0\0�\0\0\0\0\0\n����
����˞��
�\n����\t\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
���\t�����������۽������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�
�఩��\t�鬐�\0�\0\0�\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��\t����������۟�����\t\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\t�
\0��\t\0����\n��������\0�\0\0\0\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0��\t��\t������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\n��\n����頰\n\0\t\0�\0\0�����\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0��𛟛���������������\t\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t�\n��\0�˰�\t\t\0�\0
\0\t�\n�\t�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0�\0�\t\0���������ߟ�����٩�\0\0\0\t\t\0�\0\0�\t\0�\0\0\0\0\0\0\t\0\0\t�����
\0\0\0\0\t\0�\0�\t�\0�\0\0��\0\t\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�\0���������������ߛ�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�
�\n�\0��\0��
\0��\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\t\0\0\0�\0������������������
\t\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�\0�\0�\t���
�\0\0��\0\t��\0\0\0\0��\0�\0\t\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��˝�������������
�й�\t\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������\nа�\t��\0\0\t\0�\0\0\t\0\0�\0\0\0\0�\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t��۟��Ͽ�����������а\0\0\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\t\0�\0\0\t���\n\0\n����\0\0
\0\t\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0\t\0\0\0�\0\0\0\0\0\0\t\0�\n������۟���������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�
\0���\t���\t\t\0\t\0\0\t\0��\0\0\0\0\t\0\0\t\0\0\0\0\t\0\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0����������������ϛ��\t�\0�\0\t\0\0\0\t\0\t\0\0\0�\0\0\0\0\t\0\t\n\0\t\0\t\0\0\0\0����\0\0\0�\0\0\0\0\0\0\0\0\t\0�\t\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0��۽���𿛟��������\t���\0\0\0\0\0\t\0\0\0\0\0�\0\0\0\0\t\0�\0\t\t\0\t\0\t\0��\0�\0\0\0�\0\t\0\0\0\0\0\0�\0\0\0\0�\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��ٽ������ߛ���ۛ����\t\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\n\0\0\0\0\0\0\0\0\0���\t\0�М\t\0\0\0\0\0\0�\0\0\0\0\t\0\t\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t�۞��������
����������\t\0\0\0\t\0\0\0\0\0\0�\0\0\0\0\0\0�\t\t\0\0\0\0\0\0\t\0\t\0\0\0�\t\n\0�\0\0\t\0\0�\0\0\0\0�\0\0\0\0\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0�\t����ۛ��۞�������ߛ�ɰ\t\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0\0\0�\0\0\0\0\0\t\0\0��\0
\r\r\t\t\0\t\0\0\0\0\t\0\0\t\0\0\0\0\t\0\0\0\0�\0\0\0\0�\0\0\0\0�\0\0\tۙ���ڛ������������٩\0�\t\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\0�\0\0\t\t\0\t\t\t\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�������й\t\r���𾟙�\n��\0\0\0\0\0\0\0\0\t\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0

���\0�\0\t\0\t\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\t\t٭��н
н����
\r�����\0�\t\0\0\0\0�\0\0\0\0��\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0��\r\0�\0
\t\0\0\0\0\t\0\0\t\0\0\0\0\0\t\0�\0\0\t\0\0\0\0\t\0\0\0\0\0\0\0\0���ۙ\t�
���

������ٛښ�\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\0\0\0\t\0�\0\t\0ސ\r\r\0\0\0\t\0�\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0�\0\0
ɼ�
ڐ��

���
\t˙а��\r
\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0���
\0\0\t�\0\0\0\0\0\t\0\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��
��\t
������й��


\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
\r�\t
��\0\0\0\0\0\0\0\t\t\0\0\0\0\0�\0\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\t
�٩���\t\t�

�
�\n����\t�\t\0\0\0\0\0�\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0��\0\t\0�\0\t\0\0\0\0�\t\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��������ښ�К���
��\n�
�\t\t\t\t\0\0\0\0�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0��А\0\t\0\0\0\t\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\t\t


\0�\t����\t�\t
����
\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��
�\t�\0\0\0\0\0\0\0�\0\t\0�\0\0\0\0�\0�\0�\0\0\0\0\0�\0\0�\0\0���\t�������ۛڐ���𐐩�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�
\t�\t\0\0\t\t\0\0\t\0�\0\0\0\t\0�\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\t���
�ې��������\t����\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0��\t
\n\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t\0\0\0�\t
�������������ސ�����\t\0�\0\0\0\t\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t\0\0\t\0\0�\0\0\0�\t\0\0����\t\0\t��\0\0\0\0�\0\0\0�\t\t\t\t\0�\0�\0\0\0\0\0\0\0\0\0\0\0\t
\0��\r����ߛ�۽��
��ɩ��\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t\0
\0�
\0
�\t\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����������������������
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t\t�ɩ
�\0��\0�\0\t\0\0�\0\0\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0��
\r
����ߛ�ۛ�����������\t\0�\0\0\0\0\0\0\0\0\0\0�\t\0\0\0\0\0\0\0\0\0\0�\0�\0\0���\0̬\0�\0\0�\r
\0\0\0\0\0�\0�\0\0\0\t\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\t�����\t������ߟ߿�����\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\t\0\0\0\0����\r\r


��\0�\0\0\0\0\0�\t\0\0�\t\0�\0\t\0�\0\0\0\0\0\0\0\0���\t�ߛۛ۟ٛ��������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t�\0�����
\t���\0\0�\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t�\t�����ۿ��������۞�\t�\0\0�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\t
���\t\t�Ξ
�\0\0�\0�\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
\t��������ٽ������������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\t\0��
�
������\0\0\0\0�\0\0\0�\t\t\0\t\0\0\0\0\0\0\0\t\0�\0\0
���\t�����ۙ����������
�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\0\0��\r��А������\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0���\r�
л��������\r������ٰ��\0\0\t\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\t\0\0��


�\r\tɠ\0\0\0\t\0\0�\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\t����\t����
ڛ�������������ɠ�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�����\t�ʞ

���\0�\0\t\0\0\0\0�\0\0\0\0\0\0�\0\0\0\0\0\0�������
���\t���\t�������齐�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\t\0\0\0�\0\t\t������\t�\0���\0\n\0\0�\0\t\0\t\0\0\0\0�\0\t\0\0\0\0\0\0
ٹ
��\t���˹�\r������������\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0���������
�\0\t�А�\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0а����ۙ�\t�˹밹����ߟ���\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0ɬ��ޭ�Э\n�\r
\r\n\0\0�\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
����\r����˙Й���������������\0\t\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\t\t�̽������
��\r\0�\0\0\t\t\0\0\0\0\0\0\0\0\0\0\0�\0\0��۝���������
ڛ\t�����������
��\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�
�����\0

����\0�\t\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0���
\t��🟙�\t�����������������\0\0\0\0\t\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������
�\0�К���
�
\0\t\0\t\0\0\0\0\0\0�\0\0\0\0\0\0
��������������ߙ�����������ڐ\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\t\r����
�\r�


����\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\t����𰽹�ٙ�����۝�����������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������\t\0��\0\0\0\0\0\0\0\0\0\t\0\0\0�鹹�������������\t��������������\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\t\0\0\0\0\0\0\0\0\0\0�\0�\0���\r\t켼�\r�����\n\0�\0\0�\0\0\0\0\0\0\0\0\0\0\t
�������ڙ�\t���\t����������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������
��
�\0�\0�\0��\0\0\0\0\0�\0\0\0\0\0\0������陽���\0�����\t�����۟������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�����\r��
�驭\0�\n�\0\0\0\0\0\0\0\0\0\0\0\0\0��������鹐����������ٹ���
������\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��\n��������\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\t��ߙ�ۭ��\t
���������\0������������\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0����\r\t�������
��\0�\0��\0\0\0\0\0\0\0\0\0\0�����������\t����������\0\t�����������\0\0\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�����ڜ\0�
��\t���\0\0�\0\0\0\0\0\0\0\0\0\0\0\0���������\0�����
�Л��\t\0\t����������\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0�\0\t\0�\0\0�\0\0�\0��
���\r�̞��\t\0\0�\0\t\0\0\0\0\0\0\0\0\0ۙ������\t\0\0��\t\t\t�\t\t��\0\0\0�\t��������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0�\0�М��м�\n������\t�\0\0�\0\0\0\0\0\0\0\0\0\0\0���۝���\0�\0��\t�\t����������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\r�켜��ܭ�
ܭ����\0�\0\t\0\0\0\0\0\0\0\0\0\0\t�\t���ߝ�
�\t\t\t\t������������
�����߽�\0\0�\0\0\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\0��
�����\r\0Κ
��\t\0\0�\0\0\0\0\0\0\0\0\0\0\0
�������������ڝ����������\t����ݿ���\0\0\0\0\0\0\0\0\0�\0\0�\t\0\0\0\0\0\0\0\t\0\0\t\0\0���ܜ���\r\t̐��\0\0\0\0�\0\0\0\0\0\0\0\0\0\0���ٽ��ɽ�����������������\t�ݹ�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0�\0\0\t
���
�\r��
����
\0\0��\0\0\0�\0\0\0\0\0��\t����۹��������������������۽�������\t\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t\0\0\0\0\0�\0\0ɭ\r������\t�
�\r���\0\0\0\t\0\0\0\0\0\0\0\0
�\0�\t���ڐ�����������������й۝������\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\0\0\0�\0�\0\0\0����\0���\r�
���\0�\t\0\0\0\0\0\0\0\0\0\t\t\t
���������\tЛɟ���\t����������������\0\0\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�����
����\n\t\t��ڞΐ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\r����\t��Л
���
�߽����\r���������\0\t\0\0\0\0\0\0\0\0\0\t\0�\t\0\0\0�\0\0\0\0\0�\t\r\r��\nɬ��
������̐\0\t\0\0\0\t\0\0\0\0\0\0\0\0���˚���Л�\t
����\t������\t����������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�����
�\r\0�
�\t�М��\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\t˹�ۛ��ٛ����際��ٽ�����������������\t\0\0\0\0\0\0\0\0�\0\0\t\0\0\t\0\0\0�\0\0\t\0��ͩ�����\t�ڞ\r�͠\0\0\0\0\0\0\0\t\0\0\t\0\0\t\t����������\t����\0�\t

��ߛ����������ޙ\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\t\0\0\0\0��������\r��\t\0�ʜ��\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0��������������\t\0�\t���\t����������������\t\t\0\0\0\0\0\t\0\0\0\t\0�\0\0\0\0\0\0\0\0�\t\r����������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\t����ٽ��۝��\t�����˙𐛛�\t�����������\t\0\0\0\0\0�\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\t\0���
��\r��
�
��
��\0\0\0\t\0\0\0\0�\0\0\0\0\0\0\0�����۝���К�\t�\r�
�����ٹ�������������\0�\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\t\0\0�ܼ��Ϝ�������\n���\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0����߽���۽�
\t����������Н�����������ڐ\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t\0\0��\t�ͩ��
О\r
�\r��\t\0\0�\0\0\0\0\0\0\0\t\0\0\0\t\t\t���������٩�\t�ٹ�ߟ���ɹ�������������\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\0�잼ޟ\tɠ����ښ���\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\0\0��������ߟ�������������۝������������\r\0�\0\t\0\0\0\0\0�\0\0\0\0\0�\0\0\0\0\0\0\0��������\r
�
�
ͭ�А�\0\t\0�\0\0\0\0\0\0\0\0\0\t������������
\t���������\r��������������\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\t�����\r\t���\t
\0������\t\0\0\0\0\0\0\0\0\0\0\0\0������ߟ�ߝ��ِ�
��������ߛ�ߟ���������\0\0\0\0\0\0\0�\0\0\0\0\t\0\0\0\0\0\0�\0\0\0\0�����\0
\r�\0����\r
��\t\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�������������陽���������������������А\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\t����
���ޜ��
��ڜ\0\0�\0\0\0\0\0\0\0\0\0�\t\0\t������������ۙ�ٟ�������������������ߞ\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\t\0�
������\r\0��\r
��
�\0\0�\0\0\0\0\0\0\0\0\0\0��������۟����������������߿����������\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t�������\0�\r
���\0��\0\0\0�\0\0�\0\t\0\0\0\0\0\0\t�����������������ٽ��������ߟ���������\0\0\0\0\0\0\0�\0\0\0��\0\0\0\0\0\0\0\t
������\0�����
���ΐ�\0�\0\0�\0\0\0\0\0\0\0\0\0\0��߿����������
ۙ���������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�������\r�ɬ��\t\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0����ݽ��ٹ�����������������������������\0\0\0\t\t\0\0\0\0\0�\0\0\0\0\0\0\0\0\0��ޞ�����\r\r\n��\r����ސ\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0������۟ݽ���ߟ����������������������\0\0\0\t\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0\0\0\0�
�ͫ�
�������Μ\0\0�\0\0\t\0\0\0�\0\0\0\0\0\0\0\t
��������ڟ\t��\t���������˛�����������\t\0�\0\0\0\0\0\0\0�\0\0\t\0\0\0\0\0\0�\0\0��ܼ�ܼ\t\rɭ�\t�
�\r�ސ\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�����۝\t\tО�����������������
�������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0
\0\0��������
����Ь\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t���������
\t����������м�\n��������ߩ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\r�\r�ɜ������
\r�����\0\0\0\t\0\0\0\0\0\0\0\0�\0\0�������ٚ���\t\t�ٽ�����\t��\tɟ�������\0\t\0\0\0\0\0\t\0\0\0\0\0�\0\0\0\0\0\0\t\0\0\t\0��
���
�\0�\r�
����\0�\0�\0�\0\0�\0\0\0�\0\0\0\0\0\t
����ٰ����������������\0��\t���޼��\t\0\0\0�\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0�\r�ͭ�О������\r��\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\t���ۚ�\t
\0�\0�\t\t�����ڙ\t\t
���߿�����\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0
��\0ޞ����ͬ������\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��𰰽���
Й���������\t\t\0\0��Й����\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t\0\0\0\0\0\0\0
����\r\0�����ͬ��К\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t\t\0��\0���\t\t��������\0��\0���\0\0����\0\0�\0\0\0\t\0\0\0\0\0\0\0\t\t\0\0\0\t\0\0\0\0���̜\r�����К�������\r\t\0\0\0\t\0\t\0\0\0\0\0�\0\0�\t

������\0\t�\0��������\t
�\0\0\0�\0�\t\r\t\0\0\0\0\0\0\0\0\t\0\0\t\0\0\0\0\0�\0\0\0\t\t
\0\0ɠ����М\t��\0���̰�\0\t\0��\0\0\0\0\0\0\0\0\0\0\0\0\0�

\0
�\0
�\t�\t��������\t�\t\t\t\0\t�\t�
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\0\0�\r
\r
ܾ\t��\r\r
�������ɠ\0\0\0\0\0\0\0\0\0\0\0\0\0��А�\t\0��\t\t�\t
������\t\0�\0\0\0\0\0�����\t\0\0\0\0\0\t\0\0\0\0\0\0\0���\t\0\0\t\0\0\r���\0����
��
�ʞ\t\r����\0\n��\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t�\0��\0\0\t\0\0\t\0\t��������\t\0�\0\0��\n��\t\0\t\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0\0\0\0\t\0\t\0���������ڜ\t�ʜ������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0���
\t\t\0\0\t�\0���������\t\0�\0���\0�
�\0�\0\0\0�\0\0\0\0\0\t\0\t\0\0\0\t\0�\t\0\0\0\t
�\0������ڜ����\r���ޞ���\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t\0���˚\0\t������𹰐\t\t���\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0�\0
\0\0�\0\r������Μ��������콯���\0\0\0�\0\0\0\0\0\0�\0\0�����\t��\0��\t�������\t\0�\0\0�\t\t��\t\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\t\0\t\0\0\t\0����������\r\r�\t�Э�\t������\r��\0\0\0\0\0\0\0\0\0\0\0\0\t\t����\0�\t\t�������\r�\t\t\t\t\0�����\0\0\0\0�\0\0\0\t\0\0\0\0\0\t\0\0\0\t\0\t\0\0\0
\0�\0�\r����\n�����ޜ�������\n�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0����\0�\t\0\0
\t���鰐\0\0\0��\t\0\0\0\0\0\0\0\0\0\0\t\0\0\0�\0\0\0\0\0\t\0\0\0\0\t\0��М
\n���ޟ����\r�����￯����\0\0\0\0\0\0\0\0\0\0\0\0�\t\t���\t\t\0\0\t\0\0��������\0\0\0\0\0���\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0���\0\0\0
\0��\0
\r霭\0������޾��������\t��\0\0\0\0\0\0\0\0\0\0\0\0\0���\0\0�\0\t������ڛ��\t\0\0\0\0\0\0\0\0\0\0\0�\0\t\0\0\0\0\0\0�\0\t\0\0�\0\0\0\0\0\0���\0����ޞ����\r�\r���������߭\0�\0\0\0�\0\0\0\0\0\0\0\t\t�\0�\0�\0\t\t
��۟�����\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0�\0\0\0\0�\t\0\t\0�\0�\0
\0А�\r
����
�
\n�������������\0\t\0�\0\0\0\0\0\0\0\0\0\0���\t\0\0�ʜ��������۟���\t\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\t\0�\r\0�\0\0\0�\t�\t�

�
������
��ܼ���������\0�\0\0\0\0\0\0\0\0\0\0\0\t\tɚ�������ߛ�������
\0\t\0\0\0\0\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0ɩ���\t\t\0\0��
\t�
\0��ͭ߯�����������������\0\t\0\0\0\0\0\0\0\0�\0\0�����ۛ��߹ۛ������ߛ�\t\0\t\0�\0\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0���ސ�\0\t\0���
\t
\r�������������ɯ��������\0�\t\0\0\0\0\0\0\0\0\0\0\t\t��\t�������������
��\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\r����\r�\0\0�\0\r\t
\t��\r�������
\r������������\t\0\0\0\0\0\0\0\0\0\0���ٽ���������������\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\0\0�߿���̜�\t�\0���\r\0����������ڜ����������\0\0\t\0�\0\0\0\0\0\0\0\0\t\t�
�����������˝���\0�\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\0\0\0\0\0\0\0�����
�
\t�\0������������
������������\0��\0\0\0�\0\0\0�\0\0��\t������ۙ�������\t\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0\t\0\r���������
\0\r\t�\0�����Ϟ����޼������������\0\0\0\0\0\0\0�\0\0\0\t\t\tڛ���߽�������ɰ��\0\0\t\0�\0\0\t\0\0�\0\0\0\0\0\0\0�\0\t\0\0��������
\t\r\0
��\r�������������ܭ�������\0\t\0�\0\0\0\0\0\0\0\0\0\t���������۟�����\t\t\t\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0�\0\0\0
\0\0�������
��\0���
����������̭��ϯ������\t\0\t\0\0\0\0\0\0\0\0\0\t���\r�����۞���\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0\0�\0�\t\t����
\r\0�
��\0�
����������
������������\0\0\0\0\0\0\t\0\0\0\0\0\0�����ۻ�����ٝ��\t\t\0��\t\0\0\0\0\0\0�\0\0\0�\0\0\0\0\0\0\0�\0\0
��������\t�
\r\0��������������\r\r����������\t\0\0\0\0\0\0\0\0�\0��۟������ɚ�\t�\0�\0\0\0\0\0\0\t\0\0\0\0\t\0\0\0\0\0\t\0�\0\0\t\0
�����\r
\t�\r\t�\r�\r��������ߞ�����\0��������\n\t\0\0\0\0\0\0\0\0\0\0\0\t\0����ۛ۹��\t����\t\0\0\0\0\0\t\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\t
���������\0�\r\0�������������������������\0\0\0\0\0\0\0\t\0\0\0\0�����ɹ�����\t�\0\t\0\t\0\t\0\0\0\0\t\0\0\0\0\0\0\0\0\t\0\0\0�\t\0\0\t�����������\0��
�������������������������\0�\0\0\0\0\0\0\0\0�\t�Й��ۛ鹰ِ\t\0���\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0�\t̟����̐����\0�\0��\r����������������������\0�\0\0\0\0\0\0\0\0\0\0�\t��۽������\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0�\0�\0\0
Ͽ�����
\r
\t�\n�
��ޞ��������������ޞ������\0\0\0\0\0\0\0\0\0\0\0\t\n\t�������ə��\t\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\t\0\0������\0����\n��ɬ�������������������������\0\0\t\0\0\0\0\0\0\0\0���\t����й
\0�\0�\0\t\0\0�\0\t\0�\0�\0�\0\0\t\0\0\0\t\0\0\t\t\0\t\0��������Э\r
����ޞ��������������������ڐ\t\0\0\0\0\0\0\0\0\t\0\0\0\n�\r\t�����
\t\t\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\r�����\r\0��\0��������������������������������\0\0\0\0\0\t\0\0\0\0\0\t\t\t\0����\t�\t\t\0\0\0\0\t\0�\0\0\0\0\0\0\0\0\0�\t\0\0�\t\0\t\0\0\0\0�\n�������\r\t�\r
����\r���ﯟ�������������������\0\0�\0\0\0\0\0\0\0\0\0��\t�\r�ڙ��\t\0�\t\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\0\0\0\0\0\0\0\0�\0������

����������������������������������\0�\0\0\0\0\0\0\0\0\0\0�\0\t
\t���\0�\0�\t\0\0\0\0\0\0�\0�\0\0\0�\0\0\0\0\t\0�\t\0\t\0\t\0\t\r��������\r\r�\r�
�������Ͽ�����������������ϰ�\0\0\0\0\0\0\0\0\0\0\0\0\0�\t
\t
\t�\0�\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\t\0\t\0\0����������������ͭ��������������������������\0\0�\0\0\0\0\0\0�\0�\t\0����\t\0\t\0�\0�\0\t\0\0\0\0\0�\0\0\0\0\0\0\t\0\0�\0�\t\0���������

��\0����͠��������������������������\0\0�\0\t\0\0\0\0\0\0\0\0\0\t\0\t\t\t\0\t\0\0\0\0\0\0\0\t\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0��\0\0\0��������������

�\r�ޜ������������������������\0��\0\0\0\0�\0�\0\0\0\0�\0\t\0\0���\0�\0�\0\0\0\0\0\0\0\0\0\0\0�\t\0\0\0\t\0\0\0\0\0�\t����������
����������������������������������
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\0\t\t���\0�����������\r�
��
\r\r�������������������������\0
\0\0\t\0\0\0\0\0\t\0\0\0\0��\0\0\0�\0�\0\t\0\0\0\0\0\0\0\0�\0\t\0\0\0\0\0\0�\0\0�\0\t\0
���������������������������������������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\t\0\0\0\0\t\0\0�\0\t
�������������
��\r�ͬ�������������������������\0�\0�\0\0\t\0\0\0\0\0\0�\0\0\0\0\0\0\t\0\0\t\0\0\0�\0\0�\0\0\0\t\0\0�\0\0\0\0\0�\t\0\0\t\0
���������\r
\r
�\rܰ�������������������������\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0�\0��\0�����������������������������������������������\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0\0\0���\0\0\0���������\r�����
�\r����������������������������\0����\0\0\0�\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\0\0\t\0\0\t\0\0\0\t\0\0�\0\t\0\0\0\0\0���
�������������̜\r
�����������������������������\0\0\0\0\t\0\0\0\0\t\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0�\0\0\0\0�\t\0\0\0\0\t\t\0\t\t\0\0\0����������
�\r\t����������������������������\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0�������������
�
�

�����������������������������ސ\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�\0\0\0\0\t\0\0\0\0\t\0�\0\0\t\0\0\0\0\0\0\0\0�\0����������
����������������������������������Ｉ\t\0\0�\0\0\0\0\0\0\0\0\0\t\0\0\t\0\0\0\0\0\0\0\t\0\0�\0\t\0\0\0\0�\0\0\0\t\0
\0��\0\t����������𭬞\r�\r������������������������������Ϝ\n\t\0\0\0\0�\t\0\0\0\0�\0\0\0\0\0�\0\0\0�\t\0\0\0\0\0�\0\0�\0\0\0\0\0\0\t\0\0\0\0\t����������������������Ϛ�������������������������ʐ�\0\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\t\0\t\t\0��������������
��
�
��������������������������������
\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�\0\t\0�\0\0��\t\0\0\0\0\0\0
���������������������ޜ������������������������������\0\0\0�\t\0\0\0�\0\0\0\0\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t\0\0����������������
�\r
�\r
�\r�Ͽ�����������������������������\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0��\0\t\0\0\0\0\0\0\t\0\0\0�\0\0\t\0�\0\t\t\0\0�����������������\r�������������������������������ﾾ\t\0\0�\0\0\0�\0\0\t\0\0\0\0\0\0�\0\0\0\0\0\0\t\0�\0\0\0\0\0\0\0�\0\0\0��\0\0�������������
�\r������\r������������������������������\t\0\0\t\0\0\0\0�\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\0���\0\0\0\t�����������������\r
���ΰ����������������������������ﭼ\t\0\0\t\0\t\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0
���
��������������\r
�\r
��\r
�ޟ�����������������������������ʐ\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0�\0�\0\t\0\0\0\t\0\t\0\0\0\0\t\0\0�\0��
������������������������������������������������������\0�\0\0\0\0\0\0�\t\0\0\0\0\0�\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\t\0\0�\0�\0\t���������������
�\r

�\r
ܞޞ���������������������������￞�\t\0\0�\0\0\0\0\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�\t\0\t\t\n���������������������������������������������������������\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\t\0\0�\0\0\0\t\0\0�����������������
���\r����������������������������������А\0\0\t\0\0\0\t\0\0\0\t\0\t\0\0\t\0\0\0\0\t\0�\0\t\0\0\0\0\0��\0\t�����������������\r\r
\r
�������������������������������������\0\0\0\0\0\t\0\0\0�\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0������������������������Э���������������������������������������\0\0�\0\0\t\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\t\0\0\0\0\0\0\0�\0
�����������������\r
�\r�����������������������������������������\0\0\0\0\0\t\0�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\t\0\0\t
������������������
�\r
����\t����������������������������������\t\t\0\0\0\0\0\0\n\0\t\0\0�\0\0�\0\0\0\0\0�\0\0�\0\0\0\0\t\t\0�����������������
�\r\0�ͬ�ޜ�ޟ��������������������������������\0\t\0\0�\0���\0\0\0\0\t\0\0\0\0\0�\0\0\0\0\0\0�\t\t\0\n�����������������������
�\r���������������������������������������\0�\0\0\0\0\0
\0�\0\0\0\0\0\0\t\0\0\0\0\0�\0�\0\0\0\t\t���������������������
��
��ޜ��Ͽ����������������������������������\0\0\0\0�\t\0\0\0�\0\0\0\0�\0\0\0\t\0�\t\0�\0�\0\0
�������������������\r��̐��\r�ﯽ����������������������������������\t\0�\n�\t\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\t\t\0\0�\0���������������������\r
����ޞ��Ͽ�����������������������������������\t��
��\0�\0\0�\0\0�\t\0�\0��\0\0\t\0
������������������������\r
�\r���޾������������������������������������������鼐\0�\0\t\t\0\0\0\0\0�\0\0��\0\t
����������������������\t�����\r�������������������������������������������˞�����\0\0\0\0\0�\0\0�\0\0\t\0�������������������������̜\r\r\r��ޞϿ��������������������������������������ڽ���ޟ���\t\0��\0�\0\0�\0\0������������������������\t���\r\r\r�����������������������������������������ޟ�������\n\t\0\0\0\0\0�\0�������������������������\r
��������Ͽ����������������������������������������������\t�\0���\0\0\0\n������������������������\r�\r\0��\r
����Ͽ������������������������������������������߯���\0��\t\0\r\t�������������������������\r
�������ޞϽ���������������������������������������������������ʬɚ�������������������������
�\0�\t��ͭ����������������������������������������������������������߿����������������������������������������������������������������������������������������ν�ϯ�����������������������������\0\0\rɬ\r
���޽�������������������������������������������������Ͻ�߿�����������������������������\r��\0̜���ܼ����������������������������������������������������޼����������������������������������\t�
��
�޽����������������������������������������������������������������������������������\r�̞̬ɬ�������������������������������������������������������Ϟ��������������������������������
\t�\tɼ�
�߿�����������������������������������������������������������������������������������\0��������������������������������������������������������������������������������������\0\t
\t���\tϜ�������������������������������������������������Ϟ��\nڞ�������������������������������������ܹ������������������������������������������������\r������Ξ��������������������������\0\t\t\t\0���
�������������������������������������������������������������������������������������������\r�����޿��������������������������������������������������\r��\r���������������������������ʐ
\0�
\0�

\r����������������������������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���','Janet has a BS degree in chemistry from Boston College (1984).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.',2,'http://accweb/emmployees/leverling.bmp'),
  (4,'Peacock','Margaret','Sales Representative','Mrs.','1937-09-19','1993-05-03','4110 Old Redmond Rd.','Redmond','WA','98052','USA','(206) 555-8122','5176','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0 T\0\0BM T\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�S\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0��������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������ۿ���������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����۹�����������۹������������۟������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���۹���ۿ���ߛ��߻���������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��������������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
۟����������ۛ�������������������������ۛ����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����ۛ��۟�������������������������۟��������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��ۛ��������ߛ��������������������ۿ���������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������������������ۿ���������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���
�������������������������ۿ�������ۛۛ���۽����������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������������۹����������������ۻ�����������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�ۛ
��������ۻ��������������۽�������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����������������ۛ���������۹��������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������۟�������������\0��������ۻ���������������\0\0\0\0\0\0\0\0\0\0\0\0\0����\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������۹�����߽�������������
��\0\0�������۹����������������\0\0\0\0\0\0\0\0\0\0\0\0�
�������\0\0\0\0\0\0\0\0\0\0\0\0\0\t�������������ۛ�����������������\0\0\0𰽯���������߿����������\0\0\0\0\0\0\0\0\0\0\0��������ߟ���\0\0\0\0\0\0\0\0\0\0\0\0������������������������������\0\0\0\0\0�\0\0�����������۽���������\0\0\0\0\0\0\0\0\0\0�����߹���������\0\0\0\0\0\0\0\0\0\0
����������������������������\0\0\0\0\0\0�\0\0\0\0\0
�����������������\0\0\0\0\0\0\0\0\t��������뿽������\0\0\0\0\0\0\0\0\0\0
����ۛ��
��������˻����\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\t����������������\0\0\0\0\0\0\0\0�ߟ��߿������������\0\0\0\0\0\0\0\0\0\0��ۛ�������������驰���\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0

�������������\0\0\0\0\0\0\0������������ߞ��������\0\0\0\0\0\0\0\0
�������۽����������\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0
�����������\0\0\0\0\0\0
����ޛ��߼�����
ߛ����\r\0\0\0\0\0\0\0�������黛ٻ

���
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\t��ۿ�������\0\0\0\0\0\0�������߽���۟����������\0\0\0\0\0\0
���������
�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0\0\0\0\0\0\0
���������\0\0\0\0\0\t�������������������������\0\0\0\0\0\0�������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������\0\0\0\0\0\n���߿���������ߟ߿�����
���\0\0\0\0\0\0��������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��������\0\0\0\0\t�����߽��������������˞�����\0\0\0\0\0�������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������\0\0\0\0���������߽��������\r���м����\0\0\0\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������\0\0\0\0\0\t��������޻��н������
���۟
�\t�\0\0\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0
������\0\0\0\0�߽����߽����
�
\r�����ٞ�����\0\0\0\t���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\t�����\0\0\0\0\t\t������������ɼ�𜰚������𿛞�\0\0\0
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����\0\0\0\0\0
��������������\t���ڛ���\t\t�ː�\0\0
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\0\0\0\0\0�����������������\t�\t�ɩ\r
�������\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����\0\0\0
\n��������������ڙ���ڟ�������ڟ\n�\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��۠\0\0\0\0\t������������߭������������齹齠\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\n\0���\0\0\0\0\0\0\0\0����\0\0\0\t������������������
�ۛ�˟�ɭ�ʐ\0
\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\n\0\0\0��\n\0\n\0\0\0
\0\0\0\0\0\0���\0\0\0\0���ϟ�����������
����������𽿚ڹ�\0\0\0\0\0\0\0\0\0\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\n���\0\n\0\n��\0\n\n\0\0�\0
��\0\0\0\n�������������˽���������ߟ����\0\0\0\0\0�\0\0
\n\0\0\0\0\0\0\n
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\n\0\0\0�
�
�\0���
��\0\0鯰\0\0\0\0����������������������������������\0\0\0\0\0\0\0\0\0\0\0
\n\0
�\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\n\0\0\n\n\n
\n�

\0\0
\0�\0��\0\0\0\0�����������߿������߿������������\0\0\0\0\0\0\n��\0��\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\n\0\n\0���\0��\n\t�\0\0\0\0�������ߟ��������������ޟ�˟���۽�\0\0\0\0\0\0\0\0\0�\0\0\0
��\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\0�

\0\0\0\0�����߼�������ߟ������������������\0\0\0\0\0\0\0
\0\0\0�\0\0\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\n\0�
\0\0\0\0�������������߿�����������˟���ݯ�\0\0\0\0�\0\0\0\0�
\0\n\0\0��\n\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\t����ϟ�߿���������������������۟���\0\0\0�\0\0�\0\0\0\n\0\0��\n\n
\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���߿�߿�����������������������𼟽�\0\n\0\0�\0\0�\0\0\0�\0\0
\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������ߟ���������������������\0\0\0\0\0\0\0\0�\0�\n\0
\0�\0\0�\0�\0\0\n\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�������������߿�������������������߽�\0\0\0\0\0�\0\0\0�


\n\n\0\0\0\0\n\0�\n\0\0\0\0\0\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�ߟ�ߟ�������������������������������\0\0�
����\0\0\0\0�
\0\0\0\n\0\0\0\0
\0�\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�������������������������������������\0\0�\0\0\0\0\0�
��\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\n\0�\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��ޟ�������������������������������߽�\0\0\0\0
\0\0\0\0


\0\0\0�\0\0�\n\0\n
\0\0\0\n\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����������������������߽��������������\0\0�\0\n\0�\0�\t��\0�\0\0\0\0\0
\0\0\0�\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������������������\0\0\0�\0\0\0�
������
���\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��߿�������������߿���޽��������Ϳ����\0\0\0�\0\0\0\0��\0�
�
\n\n\n\n\n\0\0\0
\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������������������ߟ����\0�\n\0�
\n
�
�Щʚ
\r
�\r\0�\n\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����������������������ߝ�������������\0\n\0\0\0�\n\0�\n
\n\n����\n\n\n\n\0\0�\0
\n\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�ߟ�����������߽��߿��������𽽿������\0\0\0\0\0\0\0\0�\0Щ
��\n\0��
\0������\r\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
����ߟ�������������������߽��������������\n��
\0\n\0\0�
\n\0\n�భ��\0
�
\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������߽���������������������������\0\0\0
\0
\0\0\0\n\0
\0\0\0\0\0\t\0\0����
\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������߽������������������\0\0\0\0\n\0\0\0\0\0\0\n\0\n
\n��\n�\0�\0�
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n���ߟ���������������ݭ�靽���˟
�����ߚڜ\0�\n\0\0\0\0\0\n\0\n\0\0\0\0\0\0\0\0\n�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������߽�����٭��\t��齭���������\0�\0\0\n\0\0\0�\0\0\0\0\n\0\n\0\0\0\0\0\n\0�\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����ߟ�������������������ٝ�����������ݽ����\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\t\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n޿�������������������ߟ���ټ���������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\n\0\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������\t\r
\r\t����
�����������\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\n\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������\t������ߚ�
Н�����۽����\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������\r
\t�������߿��\0�������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������\t\0��������������\t\r�������
��\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������߯���������������������
\t���߽����\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������ߟ�����������������������������ۛڟ�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
���������韞��
���������۟������\t�����������\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����߿�������\n����Ϟ�\r�����\r���\n�������۟���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�������ߟ����\t\r��鹐�����\t���\t\t�\t���ߟ���ߞ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������ߝ���
\t�����
ݽ�ۭ�������ɟ��������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������ߟ߽������鿟��߿����ϟ����\r�������
ڞڐ�\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0�\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ʽ����������������������߿ߟ�������𚟹���������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���߿������ߟ����������������������ڞ����۟ٚ����\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
���ߟ���������������������ޟ����н�\r�������
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������۟�������߿��������˛��������ښ�
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������������������۝�ɽ��
����ɼ����\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
߿������������پ����������������ސ�ښ���������

ɠ\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����߿�������ښ��������������𞝹���������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�߿������������������۝����۞������\t�
ۙ�����ܰ���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0
\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������۹�������������߼��ڙ
�����\r������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�����������ߟ�����
�����������ܿ��\t�\t�л���������
�\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r�������������������н����ߟ���������𝝻���ߛ����\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��������ߟ�ߟ��������
�������߿�������м���������Э�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������ߟ�������������霟
߿���������\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t
\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������������������\t�������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������������������������ސ۟����
۟���\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������ߟ���Ͽ߽�ߟ����\r
����\t\0��\r
����
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������������������������ڛ߿�����������\t��
������ڜ�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����߽��������������������������������
������ߟ�\t�ː�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
����������������ߟ��������������������������߿���頼�\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������ߟ�߿�������������������ڐ�����߽����
��
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
���������������������ߞ���۟���߿�����\t�����߿�����\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������������߽��������������������ߟ�������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
ߟ���������������ܻ����ߟ�޽������ڝ���齿�߿���˽��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�������߯�������
�ߟ���������Ϳ������\t�����������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������߽���������ڐ����������������
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������������������������
���������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������������ϼ�����
�����������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�������ߟ�������������߿����������\0ښ�����������ۿ����\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������ɰ��޽����߽������������������ۭ\r��߿�������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������ߟ���������������������������
ݽ�ϟ������۞����\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��������������������߿���������\r�����\0к�����������
��\t�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������߿���������߿��������������ڭ�۩�������
�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������\0��޿��ͯ�����������������������ڼ�������߭�\t�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
������������������������������\r���ޟ\t���������������ڐ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������\0\r��������������������������������������
���\r�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������������������������������
����������
���\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������\0\0�����ɽ���������������߿��\0
\nۜ\0��\0��\r
���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
П����\0
������Ͽ������������\t��ڜ���\0������\t\0�ʜ\0�
\t�
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������
����\r������߽�ڟ���ޟ����К�������\0\0�\t���ʙ��\0\0\0\0\0\0\0\0�
\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
ߟ\t����
\0��߿���������\0

�����߿��������ڐ\0\0\0\0\0ڐ���\t\0\0\0\0\0\0\0\0\t\0��\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\t��\0\0
����\t�ߟ��Р��\n
�\r
�\r��߿�ޟ������\n���\0���\0\0\0\0\0\0\0\0\t
\0�\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0��\0\0\0����
����
�
����\r�ڞ������߿��������\t����\t\0\r�\0\0\0\0\0\0\0\0�\0\0\n\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0����Ͽ�������\0\n�\t�����������������������\t����\0\0\0\0\0
�\0�\0\0\0\0\0\0\0\0\0\0
\n\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�޿������
��\0\0
�ϛ�������������
����\0\0����\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\n\0\0\0��\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\n�\0\0\0\0\0\0\0���ޟ��ߞ���������������������ڜ���\0\0\0\t��
�\0\0\0\0\0\0\0\0\0�\n\0\0\0\0\0\0\0�\n
�\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\t������޿�����ߟ��ڙ���߿�߿������\r������\n\0\0\0\0\0\0\t�\0\0\0\0\0\0\0\0\0\0���\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������𜾟��������ߟ����鯟����\0\0\0\0\0\0\0��\0\0\0\0�\0\0\0\0\0\n\n����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\n\0������������������߽�������������ﭭ�����\t��\0\0\0\0\0\n�\0\0\0\0\0\0\0\0\0\0\0�\0�\r\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\t��������߽��ܹ��
\0���������������������ɩ�\t�\0\0�\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\n�\t࠰\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0�\0\0\0\0\0\0
��������޿������������������������������\r��\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\n\t\n�\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0\0\0\0\0\0\0\0����������������ɩ������������������������\t��\0\0\0\0\0\0\0\n\0\0\0\0\n\0\0\0\0\0\0��

��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0\0\0\0\0\0\0\t�����������������ߟ��������������������ۭ����\0\0\0\0\0�\0\0\n\0\0\0\0\n\0\0\0\0\0���\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�����������������������������������������������\0\0\0\0
\0\0\0\0\0�\0\n\0\0\0\0�\0
\t\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�
�\0\0\0\0\0\0\r�������߽����������������������������������\0�\0\0\0\0\0\t\0\0\0\0\0\n
�\0��\0\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0����߿������������߿�������������������������\0\0\0\0\0\0\0\0�\0\0\0\0\0��\0\t�\0�\0\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0

\0\t�\0\0\0\0\0\0�����ߟ��������������������������߭��߭������\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0��\0\n\n����\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\n�\0\0\0\0\0\0\0\n����������������������������߿�����߽�����\0\0\0\0\0\0\0\0\0\0\0��\n\0

�
\0\0\n\n�\0\0�\0\0\n\0\n\0\0\0\n\0\0\0��\0�\0\0\0\0\0\0\t�������߿�������������������߿�����������\t\n�\0\0\0\0\0\0\0\0\0�\0\0\0���\n
\n\n����\0\0\0\n\0\0\0\0\0\n\0\0\0\0\0\0\0��\0\0\0\0\0\0\0���������߿߿��������������������������������\0\0\0\0\0\0\0\0\0\0\0�\0\0��
\n�ɠ\0��\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0���������������������������������������랟��\0\0\0\0\0\0\0\0\0��\0��\0�\0�
������\n\0\0\0\0\n\0\0\n\0\n\0\0\0\0��\0\0�\0\0\0\0\0\0\t������������߿�����������������������ϟ����\0\0\0\0\0\0\0\0\0\0\0�\0\0��

�

��\n�\0\n\0�\0\0\0\0\0\0\0\0\0\0����\0\0\0\0\0\0\0\0��������������������������������������������\0\0\0\0\0\0\0\0\0
\0\0����\0�\n
�\n
�
�\0\0\0\0\n\0\0�\0\n\0\0\0\0\0�\0\0��\0\0\0\0\0\0\0�������������������������������������ڜ\0\0\0\0\0\0\0\0�\0\0�\0\0����
�ʜ�\0��\0\0\0\0\0\0\0\0\0\0\0\0�\0\0��\0\n\0�\0\0\0\0\0\0\n������������������߿��������������۽�����\0\0\0\0\0\0\0\0\0\0�\0\0�\t�\0�\0��
�����\n\0\0\n\0\0�\0\n\0\n\0\0\0\n\0

\0\0�\0�\0\0\0\0���������������������ߟ�����������������\n�\0\0\0\0\0\0\0\0\0\n�\n\n\n
�
�\n
��\n�\0\n\0\0\n�\0\0\0\0\0
\0\0\0\t��\0\0\0�\n\0\0\0\0
����������������������������������������\n\0\0\0\0\0\0\0\0\0\0\0�\r\0\0
\0��
\0��\0��\0\0\n�\0\0\0\n
\0�\0\0\n\0�
�
\n\0
\0\0\0\0\0
������������߿�������������������������\n�\0\0\0\0\0\0\0\0\0\0\0�\0
����
���\0�\n�\0\0�\0\0\0\n\0�\0\0�\n\0
��\n
\t\0�\t\0\0\0\0����������������������������������߾�����ɠ\0\0\0\0\0\0\0\0�\0\0\n\0\0�
\0�

��\t��\n\0\0\0�\0�\0\n\n\0�\0\0\0\n\0��
\n\0�\0\0\0\0\0\r��������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0
�
�����\0���\0\0\n\0\0�\0\0\0\0\0\0\0\0�
��\0\n\0\0\0\0\0\0\0\nڟ����������������������߿��������������\0\0\0\0\0\0\0\0\0\0\n�\t\n��
��\n���\n�\r�\0\0\0\0\0\0\0\n�\0��\0\0\0��\0
\t\0\0�\0\0\0\0\t�����������������������������������ߩ��
\0�\0\0\0\0\0\0\0\0\0\0\n\0���\r����
\n�\0�\0\0\0\0\n\0\0\0�
�
\0\0\n��
��\0�\0\0\0\0
��������������������������������߾��Л\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0��\0������\0
\0\0��\0\0\n\0�\0\0\n\0\t�
�\n\0\0\0\0\0\0\0\0

��������������������������������ߟ
\0�\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0������\0���
�\n�\0\0\n\0\0�\0\0\0\0�\0\t
�\0�\0�\0\0\0\0\0\0\0\t��������������������������������������\0�\0\0\0\0\0\0\0\0\0\0\0��\n\0�\n\0����\n���\0�\0\0\0\0\0\n\0\0
\0\0�\0\0���\0\0�\0\0\0\0\0\0�������������������������������������
\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0���
���\0�\0�ʜ�\0\0\0\0\0\0\n\0�\0�\0\t\0�\0\0���\0
\0\0\0\0\0\t
����������������������������������\t��\0\0\0�\0\0\0\0\0\0\0\0\0\0�\n\0�\0\n���\t�
��\0\0\0\0�\0
\0\0�\0�\n\0�
�\0\0\0\0\0\0�\0\0�������������߿����������������������\n\0\0\0\t\0\n\0\0\0�\0�\0\0\0\0��\0�����
���\0\0�\0\0\n\0\0�\0�\0\0\0\n\0\0
\0�\0\0\0\0\n\0\n\0\0�������������������������������
��\t\0\n\0\0\0�\0\0\0\0�\0\n\0\0\0а\n

�\n��\n���\n\0\0�\0\0\0\0\0\0��\0�\0м��\n\0\0\0\0\0\0\0��\n
�������������������������������\r���\0\0�\n\0\0\0\0\0\0\0�\0\t\n
�
�\n
������\0\0\0\0\0\0\n\0\0\t\0\0\0���\0\n\n\0�\t\0\0\0\0\0\0\t\t\r��н������߽�����ߟ������������

�\t\0�\0�\0\t\0\0��\n\0�\0�\0����а\nЬ\n���\0\0�\0\n\0\0\0�\0\0�\0\0\t
�����\0\0\0\0\0\0\0\0\n�\r������������������������۟�����К\0�\r\0�\0\t\0\t���\0�\n\0��\0�����\nɬ��\0�\0�\0\0\0\0\0\0\0�\0�

���\0\n\0\0\0\0\0�А�\t\t˛�������������������������
\n\n�\r\0�\0�\0\n\0\0\n\t���\t\0\0��\r
���\n�\0��\0\0\0\0\0\0�\0\0\0\0�\0\0\0\n�ڭ\0��\0\0\0\0\0\0\0\n\0\0����������������ޟ������鯞�\t�\t\n�а\0

�\n\0\0\r\0\0��\0\0���\0�\n�\0�\0\0\0\0\0\0\0\n\0\0�\0\0\0\0�\0\r\n�\0�\0\0\0\0\0\0\0\0\0\t
�������ߟ����
�����������\0\0���\0�\0\0\0\0�Э\n\0\t\0��\n\0�����\t�\0���\0\n\0\0\n\0\0\0\0���\0\n
\0\n\n٩�\0\0\0\0\0\0\0\0\0�\t��\r��������������
П
���\t�\0��\0\n��\0\t\0\n\n�\n\0�Р�����\t����
����\0\0\0�\0\0\0\0\0\0\0\0\0\0\n\n\t\n
\0\0\0\0\0\0\0\0�\0\0\n�\0������������𼼰����\t����\t\0\0\r\t�\n�\t�ʐ�\0�\0\0\n�\0\n
�����
\0�\0\0���\n\0\0\0\0\0�\0�\0�\0\n\t\0\t\n���\0\0\0\0\0\0\0\0\0�\0\0��
��������ɬ��
�ڐ�\tߐڐ\0��\0\0\0�\0�\0\0\0\0ɠ\t��\0\t���\nɠ���\n�\n��\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\t\nɭ��\0\0\0\0\0�\t�\0\t\r�
�魬�\0�������\t����\0\t\0\t\0�\0\0\0����\0\0\t��\0\t�\0��аɩ�ɠ�\0\0�\0\n\0\0\0\0�\0�\0\0\n�\t����\t\t\0\0\0\0\0�\0\0����\t�\0�����\0��
\t
�\r�\t�\0�\n\0\0�\0\t\0\0\n\0�\0���\0\0\0��\0\n\0���
\r�\0\0\0\0\0�\0\n\0\0\0\0\0\0\0\0\n�\n��\n�\0\0\0\0\0�\0��\0\0\0��ɩ�ɰ�������\t�
\0\t�
��\0
\n\t�
���\0�\0�
��\0���\n��\t�\t��\n�\n\0\0�\0\0\0\0\0\t�\0\0\n�\n\t�����\n�\0\0\0�\0\0��\0\0\0\t�ڼ����\r��\r�\0��\0\t
�\0\n��\0\n�\r\0\0\n
\0\0\0\0\0\0\0�\nʚ�\0��\n�������\0\0\0\0\0\0\0\0\0\0\0\0\0\0ʜ\0�\0�\t����\0\r\0\0\0\0�\0���\0\t\n�\r
��
ɩ��\0ɠ���\t\0�\0
�
\0�\0\0\0��
\0
�\0\0
���\0��ʜ\nЩ�\r����\0\0\0\0\n\0\n\0
�\n\0\0\0\0\n\n��鮜�
\r�\0\0\0\0\0����\0\0\n\0
\n��
�ڛ\0ڐа���\0�\0\t�\t�\0\0\0��\0�\0\0\n\0��\0�\0��\0�\n���
�
�\0\n\0\0\0\0\0\0\0\0\0\0\n\0�\0�\0���
��\0�\n\0\0�\t��\n\0\0
������\r\r

\t
���\0\0\0\0\n
\0
\0\n�\0\0\0\0\0\0\0\0\0\t�����\t�
������\0��\0\0\0�\0\0\0\0�\0
\0\0\0���������\0\0\0\0\0\n���\0
\0�\t\t��\t��\n���\t\0\t�\n\0\0\0\0\r
\t\0
�����\n�\0�\0�\n\n\t\n��༠�������\0�\0\0\0\0\0\n\0\0\0\0\n\0\0\0\0�\0�\0\0����\0\0\0\0\t���\0\t\n

�\r�\0
\r��\0\0\0\0\0\0�\t�\r�
�
\0�\0
\0\t\0\0\n�����\r

\n���\r��\0��\n\0\0\0\0\0\0\0\0\n\0\0\0\0\n\n\n
\0���\t���\0\0\0\0\t��
\0��\r\t

\t�𐭬\n\0\0�\n�\0\0\0\0��\r�\t\0\0
\t\0\0\0��\0\n\0\n\0�
\n
��\0�
��\t�\0�\0\0\0\0\0\0\0\0\n
\0\0\0\0�М

�\0���Щ\n\0\0�\n
\0����ڞ\t\0��\t\0�\0\0\0\0\0\0\t\n���\t
�\n�
�\n\0\0�\0�\0��\0��
\0ʞ���\n\0�\t�\0\n\0\0\n\0\0�\0\0\0�\0\0��������\0н�ɭ
\0�\0\0��\t
��
\t
\t��\0�
�
\0\0\0\0\0\0�\n\0\0�\0�\0���\0\0\n
\n\0�\n�\n��༠\n����
����\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\n�\t
���
\n\0\nА�\0���\0��
��

�\0\0\0\0\0\0�\0\r\r\0
\0\n\n\t\t\n��\0\r\n\t���ɬ\t���\0�\r���
��\r��\0\0\0�\0\0�\0\n\0�\0\n\t�\n���\0�К���ɬ��\0\0\n�\t\r\n�\t����\0\0
\0\0\0\0\0\0\0\0\0�\n�\0М\0�\0\0\n\0\0

���ʞ
���\0������\r�
�\0\0\0\0\0\0\0\0\0\0\0�\0\n\0�\0�੯����\nɠ�����\0�\r��\0����\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0����
\0
\0�\n\0
\n�

��
���\0�\n\n��
��\0\0\0\0\0\0\0\0�\0�\0�\0\0���
\0���\t�
ɬ\0
\n\0\0�\0\t��\t�\0\t\n\0\0\0\0\0\0\0\0\0\0��\0\0\0\0�
\r
��\0
\0�\0
�
\n
\n�\r�\0鬠�������\0�\0\n\0\0\0�\0\0\0�\0\0\0�\0�
\n�\0���\nЬ��\n\t\0\0��\0����\n\0�\0\0\0\0\0\0\0\0\0\0\0\0���\0\0���\0�
\0��\0\0\0�\n�

���\n�

�
��
\n\n\t��\0\0\0\0\0\0\0�\0\0\0\0\n��\0�\t\0\t\0�\n�魩ˬ\0���\0\0\n\0\0��\t��\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0\t�\0\0�\0�\0�

\0\0�
\n
\n
���\n��������
�\0\0\0\n\0\0\0\0�\0�\0\t\0\0�����୪��\r�а�\0\t\0�\0\0�\t��\n\t�\0\0\0\0\0\0\0\0\0\t

��\0
\0�\0���\0���\0\0
\0�\n
\0��\0�\n��\0��\n
�\n\t��\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0�\0А�ڜ����\n�\0�\0�\0�\0
\0���\0\0�\0\0\0\0\0\0\0\0\0\0��
\t��\0�\0\0��
\t\t��\0��
��\nЭ��\0�\t����ʜ�\0\n\0\0\0\0�\0\0\0\0\n\0\0�\0\n�\0�\0\r��\0�
�ଐɠ\0\n
\0\n\0\n\0\0\0\0\0\0\0\0\0\0\n\0\0
�
�ʐ��\r\0\n�
\0\t��\n\0\0\n��\n��\0�\0��\n\0�����\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0
��

\0�\n\r�\t��\0�
�\0\n\0\0\0\0�\r\0\0\0�\0\0\0\0\0\0\0\0
\t�
�
��\0
\n���\n\0\0��\n
���
�������
\t�\0\0\0\0\0\0\0\0�\0\0\0\0�\0�\0�

\t������К\0���
\0\0\0\0\0�\0�
\0�\0\0\0\0\0\0\0\0���
�
�\n\t�\n��
����\n�\0\0\n\0���\0����\n\n����\t�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0
\n���\0���\r��\r\0��\0\0\n\0\0\0\0\0��\0\0\0\0\0\0\0\0\0�����ɠ�\t�\n�
��

\t\0����\n���଼��ʚ�
��ɭ�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0\0�\0�\0
\r����\t��
\0�\0��\n\n\0\0\0�\0\0\0�
˚٩鬐��\0\t
\n�ʐ�ବ��\0�\n��\n�\n�ʜ\t��\0�\0��\0�\0\0�\0\0\0�\0\0
\0\0�\0\0\t\0\n\0\0������\n\n���\0�\0\0\0\0\t�\0\0\0\0\0�����\0���\0\0\0\n\0�\0�\r\n\0�\0\0�\0\r\0\n��
�������
���м��\0\0\0�\0\0\0�\0�\0\0\0\0\0\0�\0�\n�\0\0�
�����\r\0��\n\0\0\0\0\n\t�
�\0\n
\0��\nښ���\t�\0\t\0��\0���ɬ���\n\0\0\0�
�\n\0�\0�м\0��\n��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�\0\n\n\n���ɯ\n\n��\r�\0�\0\0\0\0\0\r\0��\0\t
���\0
\n
��ʐ
��\0\0��\0�\t\0
\0
\0
�
�����\n���\r���\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0�\n\0\n\0\0\0�\0頬\0��鬠��\n��\0\0\0\n\n�ڞ����\r��\0\0\0\t\0
������\0\0
\0\n\0\0�\0�\n�
���\n���\0�\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\n\r���\n\0���\r��\n\0\0\0\n\0\0\r\t�������\0\0�\0����\n\0\t��\0���\0�
\t\0�������
������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\n
�����\t��\n\0\0\0�\0�
\n\t���\t���\t\0��\0�\t\n�\0�\n��\0�\0\0\n\0\n\n�


ɠ\n\n��\0�\0\0\0\0�\0�\0\0\n\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0�
\n
�ɬ�����\0\0\0\n�\t�\n�\n\t\0�\0
\0��\0�
\0�
�\0�\0��
\0�\0\n\r�ɬ�
�����

���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0�\t�����\0��\0���\0\0Щ\r\0�\0�\t\n�\n\0����
\0�\n\0�\0\0�\0\0ɠ�\t\n�\r\n���\n
��ʐ�\0\0�\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0�
����\0\0�
\0�\0\nɠ�ࠩ\0\0��\0\n��\0�\0�\0\t\0\n\0\0
\0\0\n\0\0����\0������\n��\r�ʐ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�ڐ�\t��\n��\t\0
\0�\0\n�\n
�
\0�����\0��\0�\0�\0\n\0\n\0\0\0\n\0\0�\r���\0
\t��\0�\n\0�\n\r��\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0���
\0�
���\0��\0��\t�\n��\0�\0\0�\0\0\n\n\0\t�\0�\0�\0\0\0\0\n\t��
���������
�\n��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
���\tࠚʐ��\0�\0\0�\0ଐ�\0\0�\0�\n��\0��\0\0��\0��\n\0\0\0\0�\0��\t�\n�\n�\0�
�\n���\0\0\0\0\0\n\0\0�\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\t\n
��
��Р�
��\0�\0�����\0�
\t\n\0�\0\0\t�\0��\0\0\n\0\0
�\0
���Ь\n���\0�\r�\n
��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\r����\n���\0\0�\n�\r\r
�\n\n\0�\t��
\0�\0\0\0\0\0\0\0\0\0\0\0\t
�\n����\n���\n\0��\0���\0\n\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\n���
�
���\t��\0�\n�\0\n\n��\r\r�\t�\0�
\0�
�\0��\0\0\n\0\0\0\0�����������\n��\n\r��\0�\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0�Р�\0�
�\t�\0\r\0\0��

\t���\0�\0����\0\0\0\0\0\0\n\0\0\0\0\n\0\0���\n\t��\n�\t�\r�\n���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0��\n���\n�\r��\t�����\t\n��
\0
\0\n��\r��\0�\0\0\n\0\0\0\0\0\n\0\0\0\0�\n�����������\n
��\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0�\t�\n
\n��\0��\r���
\n\n\0��\0\0�\0\0�
�\0\0\0\0\0\0\0\0\0\0\n�
�
\0�
\0\n��
\0��\0��\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\n\0\0
\0�
�\t��\0��\0��\0�\0�\0\r\0\0\0\n\0\0\0\n�\0\0�\0\0\0�\0�\0\n\0\0\0�\0�\r�
��
�\n
�\n��\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0��\0�\t࠮��\0�\t\0���\t\0\n�
\0\0\0�\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0�
\t��\n�\n\t\0�
ɠ����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\0�\0�\0��\n\n\0���\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�頬\r��������\n��\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0�\n\0�
\r
\n\0
��\0�\0\0\0\n\0\0\n\0\0\0\0\0\0\0\0\0�\0\0\0\0\0
\0\0\0\0\0�\t\0�Р�

\r\0��
\0�
\0��\0\0\0�\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0��
\n��\0�\0
\0\0��\0\0
�\0\0\0\0\0\0\0\0�\0\0\0\n\0\0\0�\n\0\n\0\0\0\nʐ��
��\n�
�\n
�\n\0�\0�\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0�\0\n\0\0�\0
�\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\0��\t��\0��ɠ\n���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\n\0\0\0\0\0\0�\0\0\n\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0�\n\n
�
�
���\n��\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\0\0
\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����
\0�
\t�\0�\n�\n\t���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\n\0�\0\0�\0\0�\0\0\0\0\0\0\0\0\n\0\n\0\0\0\0�\0\0\0\0\0\0�\n\n��
�
�
������\n\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\n\0\0\0\n\0\0\0\0\0\0\0\0\0\0�\0\0\0\0���\0��\0�\n��\0\n
\0����\0\0\0\0\0\0\0�\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\n\0\n������������鬠�\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��������\t\0\t\t\0\0\0\r
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\n\0\0�\t���
�����������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\n\0\0\0\0\0\0�\t\n\0�\0���\0\n\0\0\n\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\n\0\0�\0�\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0�\0��������������\0\n\n�\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\n\0\0\0\0\0\0\0\0\0\n�ڐ\0��\t\0�\0�\0�\0��
���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n
���
��
�
�
�\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\n\0\n\0
\0\n\0\n\t
\t\t\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 ��','Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.',2,'http://accweb/emmployees/peacock.bmp'),
  (5,'Buchanan','Steven','Sales Manager','Mr.','1955-03-04','1993-10-17','14 Garrett Hill','London',NULL,'SW1 8JR','UK','(71) 555-4848','3453','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0 T\0\0BM T\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�S\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\n�\0\0\0\0\0\0\0\0\0\0
�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\0\0\0
\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0
�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0
�\0
\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0ʐ\0\0��\0\0\0\0\0\0\r\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\0\n\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\0\0\0\0\0��
��\0\0\0
\0\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0�\0\r�\0\0\0\0\0\0\0\0�ʐ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0
\0\0\0\n�ʜ��\0\0\t\0

\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0

\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0
��\t\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0\0�\0\0\0\0\0\0\0\0\0\0\0\0
\0\r��\0\0\0\0\0
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0

�\0\0\0
��\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0\0\0\0�\0
\0\0��
\t�
\t\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0ʞ�

����\0\0\0\0\0\0\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0\0\0\0\0\0\0\0\0\0\0
��Щɭ˚а�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0�\0\0\0\r�
�����\r��\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0
\0\0\0\0\0\0
\0\0\0
����ښ٭��
�\t\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0
\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0
ܰ����
ɭ���\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\r�
\r
���������\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0\0\0\0�\0�\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\n
���𹩩\t\t�����ʐ\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\0\0\0\0\0\0\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\t\0\0\0\0�\0\0\0\0

��٩�\r\r�������\t\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t\0\0\0\0\0\0�\0
\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\t\0\0\0\0\0\0\0�\0
\t\t\r������\t\t
��\r��\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0�\t\n\0\0\0\0\0��\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0\n�ڐۚ�
�����\r����\0\0\0\0\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\r�\0\0\0���\t\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�\0\t\0\0\0\0\0
\0\0�\t\0�ڜ\r\0��\0�
������\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\n\0\0\0�\0�\0
\t\0\0�\0\0\n�\0\t�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0
�\0\n�ڜ���\0����������\0\0\0
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\n
\0\0��\0\n\0ˠ\n\n\0�\0\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\t\r\t\t

�\t�
\r\t\n��˚��\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\n

��\0\t\0\0\0\0�����\t\n\0\0\0\0\0\0\0\0
�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0
�\0\0
�\0\0\0\0\0\t
������\0��
���\tɼ�;�\t\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0���\t\0\t\0\n�\0\0��\n\0��\nʐ\0\0\n\0�\t�\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0����\0�\t��\n�\t�\nڛ���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�߽��\n\0��\0\0�\0��\0
����\0\n�\t\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0�\0���\r\tښ�\0�Щ�\r
٭����\0\0\0\0
\0\0\0\0\0\0\0\0\0�����\0�\t\n\0\t\0�\0\0\0�\0\n�\t\0\0�\0�\0�\0\0\0�\0\0
�\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0�\0\0��\t�\t����\0�
�����О\r��\0\0\0\0�\0\0\0\0\0\0\0
�������\0\0\t
\n\0\0\t\t�\0\0޼�\0�\0\n��\0\0\0\0��\0\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�𼰰��٠���\0����\0�٩����\0\0\0
�\0\0\0\0\0\0
�������\0
\0��\0\t\0\t\0\0��\0�\t�\0\0\t\0\0\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0
�\0\0\0\0���\0\0\r\t\t�
�\0ɭ��А\0��\r�����ސ\0\0\0�\0\0\0\0\0
��������\0�\0�\0\0\0�\n\0\t�\0\0\0\0\0��\0���\0\0\0\0켐\0
\0\0\0\0\0\0\0\0\0\0\t\t\0\0\0\0��\0\t���\t����\t\0�
��\0�\0�ڝ��\0\0\0\0\0\0\0\0\0
��������
�\0\0��\t\0\t\0��\0�\0\0���\t\0\0\0\0\0\0�\0\0
�\0\0\0\0\0\0\0\0\0��\0\0\0\0�\0\0�������\r\t�預�\t
ɐɩ��Ϳڐ\0\0\0�\0\0
������������\t���\0\n\t\0\t��\0\n\t������\0\0\0\0\0��\0\n\0�\0\0\0\0\0\0\0
\t\0\0\0\0\0\0����\r������\0��\t���\0�������\0\0
\0\0�������������А\0\0\t\0�\n
�\0�\0\0\0\0\0
���\t\0\0\0\0\0��\0\0�\0�\0\0\0\0\0\0\nڐ\0\0\0\0�\0����\t\t\n���\0�\t\0
\t�\t�\t\0��ߞ��\0\0\0\0��������������\n\0\0
\0\n\0�\0����\0\n\0\0\n��\n\n\0\0�\0\0���\0\0�\0\0\0\0\0\0\0\0\0��\0\0\0\0�\r���ɬ���
\0�\t\n�����\0��\t\t����\0\0
���������������\r�\0\0�\n\0�\0\0�\0�\t\0\0\0\t\0\0\0�\0\0��\0�\0\0\0\0\0\0\0\0\0
�\0\0\0\0\0\0�\t����
������\0\0\0\0\0��\t�������\0\0\r�����������ߟ�
\0\0\t\0��\0���\0�\n\0\0\n\0\n�\0\0\0\0\0\0���\0\0�\0\0\0\0\0\0\0�\0\0\0\0\0\n����\t���\0�\t\0\0\n�\0��\t\0\0\n�\t\r
����\0\0���������������\0К\t�\0\0\0\0��\n�\n\0\0�\0�\n\0\0\0\0\t\0\0\0��\0\0\0\n\0\0\0\0\0\0\0\0�\0\0\0\0\t�����\r��������\0�\0\0\0���\0�������\0\0
����������������\0\0\t\0\t\n\0�\0�\0\0\0��\0\0\t\0\0�\0\t\0\0
\0\n\t�а\0\0\0\0\0\0�\0\0\0\0��������\0\t�\t\t�\t\0\0�\t\0\0\0\0\0�
\0����\0\0����������������
\t\t�\t���\0\n\t�\t\n\t\0\0\n\n\0\0\n�\0\n\0\0
\0
\0\0\0\n\0\0\0\0\0\0\0ސ\0\0\0
����\t������\n\0\t\0\t\0\0\0\0\0\0\t\0

�ޟ\t\0\0����������������
�\0�\0\0\n\r��\t\n\0\0\n�\0\0\0\0�\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�\0\0\0����\r\t
�\0���\t\0\0\0\0\0\0\0\0\t\t��\t����
����������������\0��\0\t�\t\0\0\0�\0\t\n
\0\0
\0\0\0�\0К\0�\n\0\0�\0��\0\0\0\0\0
�\t�\0\t�\t�ə\t\0��\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\n���\0���������������\0�\0�
\0\t\0�\0��\n\n\0���\0\n\0\0\0\0�\0\0�\0\0��
��\0\0\0\0\n��\0\0��˞����\t�\t\t\0\t\0\0\t\0\0\0\0\0\0\0\0\0\r����������������������\0�\0\0�\0�\n�\0�\t\0\0�\0\0�\t\0\t��\t��\n\t��\0��\0\0\0\0��\0\0����\t\r
\r\t��\t\0\0\0\0\0�\0\0\0\0\0\0\0\0\t\0�\r\n�������������������\0�\0ɩ\n\t\t\0
\t\0\n\t\n\0\0\0\t�\0��\0\0\0\0�\t\0\0����\0\0\0��\0�����ښ���\0\0�\t\0��\0\0\0\0\0\0\0\0\0\0\0\0
\0���\r������������������\0��\0\0�\0\0\0�\0\0\n\t\t\n\0���\0�콭��\0
\0\n
�����\0\0��\t\0�����\t�\t�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0��������������������
\0\0\0\0�\0\0��\0�
\0\n\n\0\0\0�\0\0\0��\0�\0�\0\n\0������\0
�\0����ښ����\0\t\t\t\0\0\0�\t\0\0\0\0\0\0\0\0\0\0\0\t���������������������\t�\0�
\0��\t\0\0\0
\0\0\0\0�\0�\0�\0��\n\t��\0�������\0\n�\0�����А�
\0\t\0\0\n\t\t\t\0\0\0\0\0\0��\0\0\0\0\0\0���������������������\0�\0�\0

\0�
��\0�\0�\0\0��\n\0�\n��\0�\0\0\0��������
�\0���\t٩

���\t\0��\0\0\0\0\0\0�\0\0\0\0\t\0\0\t

\0�����������������а���\t\t
\0\0�����\t\0\n\0\0
\r�\n�\n��\t����������
�\0ϟ���М\0��\0�\0\0��\0�\0�\0�\t�\t\0�\0��

�
�����������������\0\0�\0�\n\0�\t\0\t\0�\0�\n�\t\0\0�\0\0�\0\0��\0������������\0������\t
\t�\t\0�\t\t\0\0\0�\t\0\t�\t\0\0ڐ\0�\t���\0������������������������\t\0��\0�
\0�\0�\n\0\t�\0
��\n���������������\0���\t����\t\0�\0�\0\t\t
\0�\r���А\0\t\t�����\r�����������������\t
\0\0\0�\n\0\n\0\t\0��\0\t��\0
\n�\0\n�\0����������������������Щ\t\0��\t\t\0����\t\0�\t�\t��\t�а�ʜ\0�\n������������������\0��������\0���\t�\0\n�
\0�\0\0༚\n��������������\0����\t����
��\0��\t\t鐩�
������\t\r�\t��
�\r���������������
\0�\0�\0�\0\n\0\n\t\0�\t�\n\n�
\0���\0�\n\r\n�����������

���߽��\t\0�\t\t
�\t\t\n�\r\t��
���\r�����м�����������������\t\t\t�\t\0�\t\0\0\0����\n�
\t\0\0\n\0��\0\r\0���������\0

�����\t�\t\n��\0\t\t��\nڞ����

�\rޝ�ښ�\r���������������\r�\n\0\0�\0�\0\n\t\n����\0�\r\n����\0���������\n�\n\0\0\0\0���۽���
�����\r�����
ڐн\t����޽켚����������������
\t\t�\t�\0\0�\0\0\0��ɠ\n\n\t�\n\0��\r\n
\r�
\0�
\n�\0\0\t\0\t\0
���ڞ�\n�\n�\0�\t���˚ڛН�����\r������\r����������������\t�
\0\0\0К\0���ʐ�����
�\0��\n�������\0\0\n��\0
��
��������\t
\t\0�\r\n�������\t
�\r�������𼰚���������������\0�����\n\0�\0\0\t\n���\0���
\n\0\0�\t�\0�����\0\0ʚː\0\0��߽���
\t\n�����������������韟�����О���������������\n\0\0\0���\n\t\t\0�\r\n\t\0\n\t���\t�\0�鬐����������\0\0\0����\t�\n����

���\t��\t�\r���ɼ�������
�\t��������������А\0�\t\t\t\0\n\r\0�
\t\n\r\n\n�\tʚ\0��\t�������������
�\0
������\t\t\n\t\n����\t������\t����������������������
\nЩ��\0
\t\0����\n�\0\n\n\r\t

\0�
��\0�������
��\0\0���ڐ��ڙ��

\t�\t�����
\r�����ߞ۞\r���������������\t\0���\0\0\0�\0\t�\n�\0���ʜ\0��������\0\0�
ɩ���\0\0�������\t\0�
�����\t\t����\r��\0�ڙ���������������������

\0\t\0\0��������\t\n\r\0�

��ʟ�����������������\0
����\t\t\0�
\0

�
���
\tٜ���\t\0��������\0�������������\n�\n��\n\0\0�\n\t\t\nК�\r
�
�\r������������������\0\0�����\t
�������\t�\t��

�\0��а�ɼ����������������������\0�\n\t\t\t\t\t\r\0ʐ\n�\r�������ɯ����������������\0�߻�\t\t\0���\r�魩����\t���\0�\0ɩ�鼽����А�ڜ�������������\t�\t\t\0�\0�\0������\r\t���������������������\0
��ۚ��\t\t\0����\r\t�����\t��\0��
����������������������\0�
\n\0�\t\t\t��\0�\t\n
�\r\0������������������
\0\0�߹�ڐ��\t�
�����������\t\t\t\0\0\t\t\r�����۞���
������������\t\0�\0��\0�
\t\0�
�\r
\t
��\t\0��������������ߚː\0
���\t\t
\0\0�Р\r\tə����М�\0
���
�������
\r������������
\0�\0�\n\r�\t�\0�\t\0�\n�\n
\r�������������������\0\0���\t��Й�
\t\r\n���ۙ�
\t
���\t��������������������������\t�\r\0\0\0\0�\0��\n�\n��\t\n\t�\t��������������а�\0��������\t�������ٰ���ې\r\t����������\t
\r�������������\0�\t\0�
\t��\0��\0\t\t�\n\t����������������������\0\0\r����\n�\r\t��\t���
\r��\t��ۛː�ߞ���������������������ϐ
ʐ�\0�\0\t�\t�\0�
�\0ɬ�
\n\0����������������\t�\0��ʚ��\0��\r\0�������ɽ���\tɜ����������\t�ɛ���������������\t\0��
\0\t�\t�����
���А�����������������\t\0\r�۽��鰐�
\t�
\t\tʛ\t�\t���۝���������🞭��������������\t\n��\0��\0�\0�\0\n\0�\n��������������������\0��ڞ���

����
ɹ�����ۙ�˝\t\r��ϭ����\r������������������\0�\t�\0�\n��\t\t�\0��\0������������������\0\0�����
ڛ\r\t����\t
\t\t��\t��\0��\0\t\t\t�ߟ�
ʝ����������������

��
\0�\0\t\n\t�
\n�\0\0
�
\0�����������������\0\0�ښ�٭\t��\t\t�\t��������\t\t\0\0�\0\0\0\t\t�\0Й\0�ڜ����\t��������\0�\0��\t\n\t\0
�Кښ�����\0������������������\0�ߝ����Л�\t
\r\0\r�\t�\t\0\0\0��\nм��\n��\0\0���������������
\0�\t\0\n�\0���\n\0\0
����\0����������������預ϼ��\r�ɩ�ɐڙڛ�\t��\0�\t\r\t�ə��\t�����\0\0�\t�����������������
\0�����\0�\0\t�\t�
�\t�����������������\t\t\0���ۼ��\n�\t�ɩ\0\0�\0\0\t\t��������齭
\t\r��������������\t
\n�
\0\n\t�
���\n\n\0\0\r
�\n���������������������\0������
�\t�����\t\0\t\t������А�\t鯟��\r\r�\tɹ��߭���������ڐ�

�\r\0\0�\0\n\tМ��\n�

������������������\t�������й��鞐\0\0\0\0��
�\t�����������
������������������
������\t\r�\n\0
\0�
�
\t���������������������\t������
��
��\t\r\n��
�����А�
�����\r��\t齞����������۰�����\t�\n��\0�\tɩ

���Ξ�������������������М�������������\t�\t�КЭ
\t\0\0\tМ����鬹���������������ɩ��\0\0��\r\0\t��\0��
\t\0�\t��ޞ������������������
۞����\t����������\t�\t\r���\t\t\0�����ޝ��������ޟ������˭\0�\n���\t�\t�\0\t𐐚\n�
���\n����������������������������ڙ��\t\r�\t\t�
ڐ���\0\0�����ڝ���\t����
������������
�\t\n
������\0�\0�\0К\n\r������������������Ͻ�ڟ�

��А�\0������
\t\0А�\0��\r���\t\0���������������\r\t�����
\0�\n\n�\n���\0��������������������۟���߽�������\t����
\n����Й
\0�\t\r��ܼ�
��
˜������������
��\0�\t�\n�
\0��\0�\0�\r\t\0К\0�����������������������˛���
��А�\t\0�\t\t�\t\t\0А
�\0\r
�м���
��������\r�������\t�
ʚ���\t\0\0�
\t\n�\r\0�����������������ۛ߿����ߟ����\t\0�\0\t����\t\t�\t\t\n�ܽ��ڙ\t����������������
��\0�\t\r\n�\n��\0\0
\n�\t
���
\r��������������ِٽ������������ۙ\t\0���\r\t\t\0������
��
\tʐй���Ϝ��\t���������頰��\n�
\0�\n��
\0�����������������
���������������ʐ\t\0������\t\r\t
������Й�
ͭ������������ˠ�А\r
\t��\0�
�\0�\n�\t\0�\n\r������������������������������й�\t��\t��\0\t\0\t��й��ې�\t
\0�����������������\0�������\t\0\0\0�\t�\0��\t�����������������\t\t��\r��������
�ٹɩ�\t\t\0\t\t�\t\t��ڝ��������\r�����������������\t�\0\t
�\0��
���\t\n�\t୭\r��������������ې���������۟�ٹ٩�����\0��۟������߹\t\t�����ߞ�������������𰰐���\0\0
��\n�\0��ڞ���������������\t\t
������������٩��
���۝�����������ڐ�\r��������������ʚ�\t\t�\0\n\n\0\t\t�\0\t�\t�\0����������������\t���������߿�����۽�\t\t�
\0\t\t���۝��������\r���������ޞ��������\0�\n
\t\t

�\0�\0����\0������������������������������������\t�ښ����������������\r�������������������ې\t�\0�\n�\0���\0�����������������������\t\t�����������ݻ����Н\n\t��н���������������������\r��������\0˚��\n���\n\0\0\t�\n\n
\r\0\t����������������ې\t����������ߛ����ɩ���\t�����������А۟����������������𼐰\0\0\t\t\t�\0\t\t
�
\t�
\n����������������\t�\r���������������ٹ���Й�ۜ���۟�������������޽�������\t�\nڞ�\n
\0�\0\0��\n\0�\t�\0���������������\t�Й��������۟۟��ٽ�����˛������������������߿������������\t\0\t�\n�\t
\0�\n\0�����ʞ���������������\t\0����������������٩������۝���۟���������������ߟ������������\t\n\0\0\t�\r
��\t\0�\0����������������ٹ\t����������ۛ���
���ڞ����۟��������������������������
�\0�\n��\0�\t�\0\n\0\t
\n�\r�\r�����������ٟ���������������ݽ�\r���ڙ�
��ɟ�����������ޟ����������������

\n�\0\0\0\n\0����\0
�����������������������\t\0�������۟�ۛ�ٹ�˛������������������������������������
�\0�
\0��
\0�\n\0а
���\r�������������������\t���������������ۙЛ\t������ٻ���������������������������

\n�\0\t\0\0��\0\r\t\n��\t\n�������������������ِ��������ۛٛ��\r����������ٽ���������߭��������������𜰰�\t�
\0\0\0�\0\0\n���\n��\0Э������������������������������������\t\t
�������߽���\t������������\t����ߩ\t\0�\n\n\0\0��\0����
�\0Щ���
��������������������������ۙ��ۙ��
�����������������������������������\0А��\0\0�
�


\0�������������������\t����ٹ������۝��\t˙Н
\tɐ�������������\t���Ͻ��������������\t
\n\n\0�\n\0�\0
\0����������������������������������\r���ٹ�
������ٹ�������\r
\t�\n��\r���\0��������
�\0���\0\0\0\0��\0����\r����������������\t�����\0�������а��ڐ��\t

�ə�������ِ\t�М������������������\0���\0\0�\t\0�\0\0���\t\0\n����������������\t��ۛ��\t\0�����й��\t\t\t�\t���\0�����۟�߼���\t�\t
��ޟߟ���\r���랞\t�\t��\n\0\0\0\0\t\0\n\r\r
����������������٭����\0\t���������\r�����\t\t
\t\tɟ�������\0�\0��������������������\t\n\0\n\0\t\0\0\0\n��\0\0���\n\t�\r���������������������
��������˙�\t�\t\n��\0\0�\t
\t�������\t\t\t\t��������\r�����������
�\r\0\0�\0�\0\0���\0\t\r���ɬ�������������\t
۟�\0�\0��������������\r\t\t\t\t���ɽ����\0�\0\0\0\0������������������\0��\0��\0\0\0\n\0�
�
\0�\t�����������������ݽ���������\t�\r�\t�\r\t\0�\0\0�\t
�������ېн��\n���\r������������ڐ����\0�\0\0�\t�

\t
��ɭ�����������������\0\0�\0����۩�\0
�\t�\t�
\r\t\t\t�\0�����ߐ�\0\t\t\0\0\0�ޜ���߰��������\t\0�\n�\0�\t\0\0��\0\0\0����\t��Я����������������\0\0�������А\t��\0�\0����\0��������ɠ���\0\0\0\r����������������\r\t
\t�\0\0\0�\0���\0\n\t���������������������\0�\0�
����а�\t\0\t\n�\0\0
�\0\0�\t\0��������\0\0\t\0\0\0�А\0�������������\0��\0�\0��\0\0\0�

\r\t�\0���\0���������������\t\0\0\t\0\0������
А\0\t\0\0\0\0޹\0\t\0�������\0�\t\0\0\0\0��
\tϾ����������ʐ�ڐ�\n�\0\0\0\0\0
\0\n
��\0�����������������\0\0\0\0\0���������\t\0\0\0\0\0\r�\0\t\0\t\nɹ���ߜ�\0�\0\0\0\0\t\0\t
�\r�\0��������\t\0\0\n\0�\0�\t\0�\0\0\nА�\0��\t���������������\0\t\0\0\0\0������
��\0�\0\0\0\0\0\0�\t\0\t������\t��\0\t\0\0\0\0\0���������������
\t�
�\n\0\0\0\0��\0���
��\t��������������\0\0\0\0\t������
�ٰ�\t\0\0\0\0\0�\0\0\t\t��������\t\0\0\0\t\0\0���
�����������\0
\0�\t\0\t\0�\0\0�\0�\r\t\0\t\n��\t�\n��������������\0\0\0\0\0\n������𼽽\0\0�\0\0�\0
\0�\t\t������\n�\0�\0\r
\t�������������ڜ���\n\r\0\t\0\0�\0

���\r
ɬ\t\r��������������\0\t\0�\0\0������\t\t\t\t�����
��\t��
������\n�ʝ\0�������\r����������\0\0\0\0ʐ\0�\0\0��\0
\0���\0�\0\0\0���������������\0\0\0\0\t\0�������������Л\t\0�\t\tК��ߛ�\t\t\t\n\t���\r���޾���������\r\n��\0�\0\0\0����\n�\n�\0��\t\t��������������\0\0\0\0\0\0�����\0��\t�
��
\0��\t\0��������\0\0�������\0\t��\0��������\0�\n�\0\0�\0\t\0\0\0\0\0\t\t
�\r\0\n�\t\0ϯ������������\0\0\0\0
�
������\0�\0�\t\t\t\t\t\0\t\0�\t��ٟ���\t��\0\0\0\0\0\0\t\r���\0�����߭�\t\0
��\0\n\0\0\0�\0

�\0\0��\t
\0���������������\0\0\t\0\t\0��������\t\0�\0\0\0\0\0\0\0\0����������\t\0\0\0\0\0\0\n\0\t��\0�������\r���\0\0\r\t\0\t\n\0\0\0\0�����\n�ʚ���������������\0\0\0\0\0\0�������\r\0\0\0\0\0\0\0\0\0\t\t�\t
\t����
ɩ�\t\0\0\0\0�
��߰\0������ڐ��\0��\n\0\0\0\0\n���\n\0��\nК�
���������������\0\0\0\0\0\t\0��������\t�\0��\0\0\t


����������
����\t\0�����\0��������\r\0\n\n\0\0\0\0\t\0\0\0\t\t�\t�\0�������������������\0\0\0\0\0\0�����������\n\0��\0��������������������������\r������ڐ\n\t\t\0�\t
\t\0\0\0\0\t\0�\0\0�ɩ����������������\0\0\0\0\0����������

�\t�\t��������������������������\0��������\t
�
\0�\0\0\0\0\0�\n\t\t\0����

����������������\0\0\0\0\0�����������ټ������������������������������\0��������\0\0�\0
\0�\0\0\0\0�\0\t\0��\0�\r

����������������\0\0\0\0\0�������������������������������������������\0�������\r\0
\0�\0�\0\t\0\0\0\0��\t\t\t�\0\0�����������������\0\0\0\0\0
\tʛ����ߟ��ݿ�����˛������������ߟ��������\0�������\0\n��
\0\t\n\t\0\0\0\0
\0

\n\0ɩ�����������������\0\0\0\0\t\t������������۽���������������������������������������\n��\t\n\0\0\0\0\0�\0
\0\n�ښ�\0\t����������������\0\0\0\0\0\n������������۟۟��ߟ���������������������\0�������\0��\0\0\0\t\0\0\0�\0\t\0���\0�\t�����������������\0�\0\0\0\0�\t�������������������ߟ������������������\0������ۜ�\t\0��\t\t\0\0\t\0\0\0\n�\n\0��\0�\0�����������������\0\0\0\0\0\r\t���������������ߟ�������������������������\0�������ɠ\0�\0\0\n\0�\0\0\0\0\0���\0����\0���������������\0\0\0\0�\0\0����������������۟����������߽�����������\0���������
��\n��\0\0\0\0�\t\0\0����\0�����������������\0\0\0\0\0�\r������ݿ�ߛ�ߛ�������������������������А�������\0�\0\0
��\0\0\0\0�\0
��\0\r\0�\t�\0����������������\0\0\0\0\0�\t\n����������������������������������������\0
�������
���\0�\0\0�\0�\0�\t\0\t\n�\0�\n�\n����������������\0\0\0\t༼�����۽�ۛ��۟�������������߽�����������\0������
�\n\0�\0�\0�\0\0\0\0\0\0\0\t\n\0\n���\0����������������\0\t\0\0\0�\t�������������������۽�������ۿ۽���������\0\n��������\t\t�
�\0�\0\t\0�\0�
��\n\n���������������\0\0\0\t\0��������۹����ۛ��������������������������\0\r�������\t�\t\0\t\n\0\0\0\0\0\0\0\0�\t\0\n
\r\t\r\0\t���������������\0
\0\0\0�����������۟������������߽���ۛ�����������\0������
\0
\0�\n\t�\0\0\0\0\0�\n\0
\0
\n\n�����������������\0�\0\0\0��ߟ��������������������������������������\0\0������\r�
\0��\0\0\n�\0�\t\0\0���\r\t\t\t\t\0����������������\0�\0\0�����ߟ������ۙ�������������������������
\0
������
�
\0���\0\0\0\0\0�\0\0�\0\n\n\0�������������������\0\t\0\0\0\r�ߟ�����ۛ����߹�������������������������\0�������
��\0\0�\0\0\0\0\0\0\0\0��\0\t\r\t\t\t\0����������������\0\0\0\0\r
Ͽ�������������ߟ��۽��ߟ���������������\0\0������\n\0�\n\0�\n�\t\0\0\0�
\0\r\0\0�\n�\n����������������\0\0\0\t\n����߽����������������ٿ����������������ې\0\0�������А\0\r\t\0�\0\0\0\t\0\0\0\t�\0���А\0�����������������\t�\0\0\0\0������������������ٿ��߿���������������\0\0������\n\0ʐ�\n�\0\0\0\0\0\0\0\t�\0��\0�\n\0������������������\0\0\0\0\0����������������������������������������\0\0\0�������\r�\0��\t\n\0�\0\0\0\t\0\0\0�
\0�
\t�\0�����������������\n\0\0\0\0\t�������������۟���������߽�������������\0\0
�������\n\t�\n�\0�\0�\0\0\0\0\0�\n\0\t���\0�������������������\0\0\0\0
��������������߽���������۽�����������\0\0�������\t��\0�\0\0\0\0\0\0\0\0
\0�\0\0
\t��\0�����������������\0�\0\0\0\0������ߟ�������������ߟ�۽����߽�������\0\0\0
�������\n
�\0��\0\0�\t\0\0\0\0\0��\0\n\t�
�����������������\0\0\0\0\0\0\0ڟ����������۟���������߹�����������\0\0\0\0������ސ\0��\0\0\0
\0\0\0\0\t\0\0\t�\0\t\t��

������������������\0\0\0\0\0\t�������������������������߽����������\0\0\0\r����������\t�\0�\0\0\0\0\0\t\0�\0\0ࠚ\0�������������������\t\0�\0\0\0\tɭ�鞟���������������߿�������������\0\0\0\nϾ����ߚ\0�\r\0\0\0�\0\0\0\0\0\0\0�\0�\0�\0�а������������������\0�\0\0\0\0\0
���۽��߿��������������ߟ��������\0\0\0\0
��������ɠ\n\n�
\0\0\0\0\t\0�\0�\0��\0а\n
������������������\0\0�\0\0\0��
�
��߿��������ߟ�����������������\0\0\0�������\r������
\0\0�\0\0\0\0\0\0�\0\0��\n��������������������\0�\0\0\0\0\0\0���˜������۟������ݿ�����������\0\0\0\0
���������\0��\0
\0\t�\0\0\0\0\0\0\t\0�\0\t\r
\n\t��������������������\0\0\0\0\0\0\0\t\n���������������������������\t\0\0\0\0\0�������������\0��\0\0\0\0\t\0\t�\0
\0�\n\t\r�������������������\0�\t\0\0\0\0\t\0\t
\r\t�\t��ٽ�������Ͻ�ۿ����𜰐\0\0\0\0\0\0���������
�\0\0�\t\0\t\0\0\0\0\0\0\0\t\0
\n\t
��������������������\0
�\0\0\0\0\0\t\0�������
н�𿰛�����К��\t�\0\0\0\0\0\0
����������
��\0\n\0\0\0\0�\0\0\0\t\0
\0\t��\r��������������������\0\0�\0\0\0\0\0\0\0\0\0\0\t\t\t\n�
ڞ�\0��������
\t\0\0\t\t\0\0\0\0\0\0�������������
��ɠ\0\0\0\0\0\0\0\n\0\0�\t�����������������������\0�\t\0\0\0\0\0\0\0�\t\0�\n���\t\t\t�
��\t�\0�\t\0\0�\t\0\0\0\0\0\0\0
�����������\0\0\0\n\0\0\0�\0\0\t\0\t�\t�\t��\t
���������������������\0\0\0\0\0\0\0\0�\0\0�\0\0�\0\t\t\0\0\0\t\0�\0\0�\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0����������\t\n�\0�\0�\0\0\0\0\0\0\0\0\0\t�\t\r�����������������������\0�\0\0\0\0\0\0\0\t\0\0\t\t\0\t\0\0\0�\0�\t\0\t\t\0�\t\0�\0\0\0\0\0\0\0\0\0\0�����������\n�\0\n
\t\t\0\0\0\0\0\0\0\0�\0\0\0\0\t\0���������������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������
�\0\0�\t�\0\0\0\0\0\0\0\0�\0\0�\n�ڟ���������������������
\0\0\0\0\0\0\0\0\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������а��\n��\0��\t\0\0\t\0\0�
�\0�\t\0
����������������������\0�\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������\t\0\r\0\0\0\0\0\0\0\0\0�\0��

�����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������\n�\0\0\0\t�\0\0\0\0\0\0\0\0��\0\t

\0
�����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������
\n�\0\n�\0\0\0�\0\0\0\0\t�\t\0
��������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
���������������\t�\t\0\0�\0\0\0\0\0\0\0\0�\0\0\n�

�����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������
\0�\0\0
\0\0\0\0\0\0\0\0\t\0\0\0
�\n
������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������\0\0\0\t\0
\0�\0\0\0\0\0\0\0\0�\0�
��������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������\0\n\0�\t�\0\0\0\0\t\0\0
\0�\0\n
\0
�������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
���������������
\0���\0�\0\n\0\0\t\0\0\0\0\0\0\0�\n���������������������������
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������
\0��\0\0�\t\0\0\0\0\0\0�\0\0�\0�
�������������������������\r�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������ڐ\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\t\0�\0�\n
��������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������ۜ���
\0\nР\0\0\0\0\t\0\0\0�\0
�\0���������������������������\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������
�\n�\0\0\0\0\t\0\0\0\0\0\0�\0\t\0�����������������������������\n�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������\0\0\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\t\0�\0����������������������������\0�\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������\0\t\0��\t\0\0\0\0\0\0\0\0\0\0\t\n\0\0��
��������������������������\0�\n�\r\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0��������������������
�\0�\0\0\0�\0\0\0\0\0\0\0\0\t\0\0\0�\0\0����������������������������\r
\n�\t�\0\0�
�\0�\0\0\0\0\0\0\0
\0�����������������������\0\0�\0\0�\0\0\0\0�\0\t\0\0\t\0�
\n��������������������������\0�������˭�
�\0
��\0\0\0\0�������������������������\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������������


\t
\r��ڛ���������������������������������\r�\t\0\n\0\n\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0\n\0�������������������������������
�
�\r�
�����������������������������������\t\0\0\0�\0\0�\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0����������������������������
\r����\r�޽����������������������������������ޞ�\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0����������������������������ښ\0�
����������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������������\t�\t
\n
����������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0

��������������������������\t�������������������������������������������\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n����������������������������\r��������������������������������������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\r�������������������������\t\t�����
���������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������������\t
\0࠭�����������������������������Ͽ�������\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r��������������������������\t\t�������������������������߿���������߼������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n߿������������������������
�
\r��������������������\r���������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������������������\nښ\t\0\t������������������ʚ\r����������������\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������������\0�\r\0\0�༯�����������������
�������������������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������������\0���\r\t\r�������������������\t\0���������������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��޿���������������������\t�\0�\n�\nͯ����������������\r��������������˞���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t

�����������������������
\n�
�\t�\tɫ������������������\0
�����������н��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\r�
�����߿������������
\t��\0������������������ڞ��
\t�������
��
𼰐�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t�������������������\t\n\0ఠ�ڐ\0�����ٞ��

�\t��\0�\0\0\n�\r�\t��
٭���\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�\0\0�\t��\t�\n\t�
\0����
\t�
\t\0��\r\t��\0���������аам������

\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\t\0�\t\0�\0\0�\0\0�\t\0\0\0\0���������\t\n\0\t\0�\0\0\0�\0\0\0\0\0\0\0\0\0�\0�\0�\0��\0�\0\0\n�����\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�\0\0\0\t\0�\0���
���\0�\0�\0\0\0�\0�\0�\t\0�\t\0�\t\0�\t\0�\t\0�\0\0�\t\0�\0�����\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n��ʞ�\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t

���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\t\0\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������������������������������������������������������������������������߭�Ͻ�߭�Ͻ��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0v��','Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 1993.  Mr. Buchanan has completed the courses \"Successful Telemarketing\" and \"International Sales Management.\"  He is fluent in French.',2,'http://accweb/emmployees/buchanan.bmp'),
  (6,'Suyama','Michael','Sales Representative','Mr.','1963-07-02','1993-10-17','Coventry House\r\nMiner Rd.','London',NULL,'EC2 7JR','UK','(71) 555-7773','428','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0 T\0\0BMT\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�S\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0��������������������������������������Ϛ����\0\0\0\0\0\0

ϛ�����������������������������������������������������������������������������������ޚ\0\0\0\0\0\0\0���������������������������������������������������������������������������������������\0\0\0\0\0\0\nм���������������������������������������������������������������������������������\r���\n\0\0\0\0\0\0\t
�
�������������������������������������������������������������������������������������\0\0\0\0\0\0\0������������������������������������������������������������������������������������\t��\0\0\0\0\0\0\0\0
����������������������������������������������������������������������������������\n
\0\0\0\0\0\0\0\0\0
������������������������������������������������������������������������������������\r��\0\0\0\0\0\0\0\0\0\0�����������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0������������������������������������������������������������������������������������
\0\0\0\0\0\0\0\0\0\0\0������������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\t������������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0
������������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0������������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0��������������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0
��������������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0��������������������������������������������������������������������������������������\0\0\0\0\0\0\0\0\0����������������������������������������������
�����������������������������������������\0\0\0\0\0\0\0\0����������������������������������������������\0�����������������������������������������\0\0\0\0\0\0\0
����������������������������������������������\0\0���������������������������������������\0\0\0\0\0\0\0�����������������������������������������������\0\0\0���������������������������������������\0\0\0\0\0\0�����������������������������������������������\0\0\0\0���������������������������������������\0\0\0\0\0
�����������������������������������������������\0\0\0\0\0��������������������������������������\0\0\0�\0������������������������������������������������\0\0\0\0\0\0��������������������������������������\0��п�����������������������������������������������\0\0\0\0\0\0�\n\n�����������������������������������\t��������������������������������������������������\0\0\0\0\0
��\0��������������������������������������������������������������������������������������\0\0\0\0\0\0\t��\0\0����������������������������������\0��������������������������������������������������\0\0\0\0\0\0��\t\0�\0��������������������������������\t\t\0\0�����������������������������������������������\0\0\0\0\0\0����\0\0\0�������������������������������\t�ڛ\t\0����������������������������������������������\0\0\0\0\0\0\0�\t\0\0\0�\0����������������������������𐰙\t\0������������������������������������������������\0\0\0\0\0\0��\0\0\0\0�����������������������������\t����\t\t\t\0���������������������������������������������\t\0\0\0\0\0�\t��\0\0\0\0���������������������������\0��\t���\t\0�\0��������������������������������������������\0�\0\0\0�����\0\0\0\t�
������������������������\t�\0\t\t\0�
\0\t�����������������������������������������\0�\t�\0\0\0\0\0\0���\n\0\0�Р����������������������
\r\t�\t\t�\0\t\0���
��������������������������������������\0\t\0�\n\0\0\0\0\0\0\t
��\0\t�����������������������������\0��\t\0�\t\t\0�\0������������������������������������������\0\0\0\0\0\0\0\n\0��\n\0\0\t�\t\t\0�������������������
\t
\0
\0\t\0�\t\0\n\t��\t������������������������������������
\0\0\0�\0\0\0\0\0\0\0\0\0\t
�\0�����\0\t����������������������\0�\0\0\0\0�\t\0\t\t\0����������������������������������ఠ����\0\0\0\n�\0\n\0�
\0\0\t\n
�ښ\0
����������������\t\t�\t\n��\t\0\0�
\0\n�\0��������������������������������\n\t
\0�\n��\0\0\0\0\n\0\0\0\0�\0\0\0�\t�\0\0\0����������������\t\t���а\t\t\0�
\t\0�
�\0��������������������������������\n�����\t��

\n�\0\0\0\0�\0\0\0�\0\0\0\n

\0
˪��������������\t�\t�
�\n\t�
���\0\0\t\t\0��������������������������������
\r���\0�����\0\0\0\0\0\0\0�\0\0\0\0��\0��\0\0�����������\t��\t������\0\0�\0�������������������������������������\0�\0�\n���\0�
\0\0\0\0�\0\0\0\n\0\0\0
\n�\0\0��\0�����������\t��О\t\0\0\0�\t\0���
\t\t�\t\t������������������������𩠠\0��ڰ��\n�\0���\0\0\0\0\0\0\n\t\0\0\t�\0�
\r\0�\n�����������\r����
\0�\0�\t\0М��\0\t
\r�������������������������\n��\t\0��\0\0��\0\0\t\n\0\0\0\0�\0\t�\0\0\0
��\t\0��\0\0
\0�������\t�����\0�\0����\n\t���ڛ���\t\t����������������������\t��\0\0\nں�\0�\n�\n\t�\0\t�\0\n�\t\0\0
\0\0\n\0��\0\0�
\n\t��\0���������\t�\0���\0�\t\0�

\t�\t

����������������������\n\0
�\0�\0������\0\0�\0\0\0\0\0\0\0\0���\t��\0\0\0\0���
�\0\0
���������ښ�
\0�\0�\0�\t\0����ʟ\t��\t�������������������\n�\0����\0����˩��\0\0\0�\t\n\0\n\0�
\n�\t\n���\n\0
��\0�\0\0
������𰐐ڐ\t\0\t\0\t���ڐ�������������������������\0\0\0\n���\0\0\n��\n�\0\n�\0\0\0\0\0�\0�\0�\0\0
�\n\0��\0���ࠐ�\0\0������
�
˞��������\t\0���
\t魐�\t\t���������������\0\n�\0\0\t����\0\0�\0�\n���\0\0\0\0\0\0\0\n\0\0\0\0��\0
\t\0\n\n��ڐ�
�\0\0

������ٰ�\t�����\t�˚���\r�����\t���������������\0\n\0\0\0�\0����\0�ʚ\0��
\0\0\0\0\0\0\0\0�\0\0
�\0�\n\0\t\t�۩�\0�\t\0\n\0�����\r�𚟚���\r����
\t��
ɭ���К������������\0\n\0�\0\n\t\0\0����\0��
�\t���\0\0\0�\0\0\n\0\0\0\0\0��\0\n��\n\n��\0\0\0��\0\0

������
\t�������\t������
�����陯���������\0\0\t\0\0�\0\0\0
���\0\0�\n\n�����\n�\0\0�\0\0\0�\t\0\0\n\0��\0\0\0\0�\0\0\0�\0\0\0\0\t����
\t��\tۛ뙭�\t��ۙ�ڐڙ��
\t�����������\0\n\0\n\0\n\0\0\0\0����\0

�����\t���\n\t�\0��\0��\0
��
\t\0\t�\0\0�����\0����а�к�ٞ��\r��\t����������𙹹���������\0�\0\0\n\0��\n\0
���\0\0�\0\0�\0�\0�����\0\t��\0\0\0\0\0����\n\n\0\0\t\0��\0\0\0\t������\t������������ٛ�
���\t\n����ڙ�������\0\n\0\n\0�\0\0\0\0�����\t�\n\0�\t�𠐐�\n\0�\0\0\0\0�\0\0
�\0�\0\0\0�����\0�����\0��\n��������л
�����������
���������\0\0\t\0\0\n\0\0\0\0����\0
�
�\t\n\0�\0\n\nа���\0�\0\n\0�\0����
�\0\0\n�٠\0\0�\0��ۙ
�\n��\t��а��ڛɼ�
\0�
ɩ
������������\0��\0\0�\0\0��\n����\0�\n\n����\t��\n\t�
\t\0�\0�\t\0


˰\0\0\0\0
�
\0\0�
��\t����а�\t����
\t��������𼰚ٹ������\0\0\0\n\0\0\0\0�\0\t����\0\0�\t\0
��\0\0\0�ڼ��\0���\n\0����\0\0\n\0��\0
\t\0�������\t��\t\t\n�\t\t��������

\t�\t����������\0�\n\0�\0�\0\0\0\t\n����\0\n
\0�����

\t�
˞���ښ\t
�\t\0\0\t
�\n\t�\n
���\t\r���\n��\t\t\0���\t驹\r���ۙ������������\0�\n\0\n\0��\0�\0���\0\0�
\t�ʐ\n��
\0����������\n\0������\0���\t�\t������\n��
Й���\0�\0��\r�����\t�\0�𼝽��������\n\0\0\0\0\0\0\t\0�����\0\n
\n\0�����
���\0�\t
��ڼ��
\n�\0\t�\n�\0\0
\0\0�ۚ���������\t\t\0\t\t\t\t�����������


��������\t�\0\0\0\0�\0\0���\0\r\0���\0��\n�\0�\n��\0\0�\0\n\0
\n������\0�\0�\0\0\n����������\t\n\0\t\0\0�\t\t��ڝ��\r�����������\0���\0\0\0\0�\0\0\0\0����\0��\t\0�\0�\t\0�\0\t�
\n�\0���
��\n\0����Р\n\n\0�\t


���\0���
�����\0����\t���\t���������������\n\n\n\0\0�\0\0\0\0\0
���\0\t\0���\0���\0�\0\0\0
\0\0\n\t\0\0\0�ˠ\t\0�
�۠\0\t�\n\n������������\t\t\t�\t�\t
\r���\t�����������
����\0�\r\t\n\0\n\0\0�\0�\0����\0�\0����\0\0\0�
\0����\0\0\0
\0۠�\0\0��𰰞�\t\0�˚���\t\tڰ۹���ٰۙ������𽩩������������
\n\n\0\0\0\0\0\0\0\n\0\0����\0
\n��ʚ��\0\0\0\0\0\0\t��\0�\0\0���\0\0\n�\n\0
�ߠ
۹����ې�۞�\t𹙹������\t\t�
\t���������
��\n\t\0\0\n\0\0\0\0\t����\0\0���\0\0��\0�\0�\0\0�����\0\0��\t�\0
\r�\0\t\0���ڟ\r����\tɐ������������
\t��������������۟�\0�\n\0\0\0\n\0�\n\0\0\0\n���\0\0���\0����\0\0\0\0�\0������\n\0���\0\0�\n\0\0
���������ں���
����������ɽ�ڟ\t\t
�ښ�����������
ʐ\0\0\0�\0\0\t����\0\r\n\0�����\0\0\t\0\0\0\0����\0\0\0\t\0��\0�\t\0\0\0�������ۛ��
\t\t������������

��������\t�������\0������\0\0�\n����\0\n���\0���\0\0\0\0\0\0�
\r�\t�\t
\n\t\0\0
\0\0\0\0\0�������
ڻ
��

��\t�\0�\t�۝���\t�\t�\t����
ٰ�\t��\t
���ʐ�\0
���\0����\n\0�\0�\0\0�\0�\0�\0\0\0����\0\0\0\0\n\0\0\0\0\0\0\0
�������А\0\0�����
ɠ�\0�۰�
�\n�������
\t�ۛଠ�ࠩ\n\0\0\n\0\0\0
���\0\0���\0���\0\0\0\0�\0�\n���\0\0\t\0\0
\0\0\0�\0\0���ڛ������\0�\0\0\t
\n����\t\r���Й\t\t�����ɹ��
ː\0��
\t�\n
��\t\0�\n\t���\0\0�
�
\t�\0�\0\0\0\0�\0\0����\0�\0\0\0��\0\t\0\0\r����魰��ښ\0\0\0\0�����ː������
\t����뚜�\t����
��\n��\0\0\n\0\0\0\0����\0�
��
��\t\n\t\0\0\0������\t\0\0\0\0�\0\0�\0\0\0�������
�����\0\0\0\0
\0�\t\t��
\0��\t\0\0����������

�
���а\n\n\0\0\0\0\0\0\n���\0\0���
\t�
�\0\0\0\t\0\n\n����
\0\0\0\0�\0�\0\0\0\0\t��𞚚��
\t\t\0\0������\0\0�����\0\0�\t\t
������
\r�����
��\r���\0\0\0\0\0\t���\0\0\t���\r��\0\0\n\0\0�\t��

\0���\0\0��\0�\0\0\n�������
�����\t
�\t\t\0���
\0�\0\0\0\0\0\n��۰�\r�����ɰ�������\t�\0\n\0\0\n���\0
\n����\n\n�\0\0�\0�\0��\n\0\r�\0�\n\0\0�\0\0\0\0\0\t����
�������������\t\0���\t\t\0\0\0\t\t�������
˚�
����˭��\0�\t\0\0\t����\0
\n\t�\n\0��\0�\0\t\0�\0������\n�
\t\0\t\0\0�\0��ۛ۹�
�\t��
\t�ِ���\t\t�\0�\n\0\t\0��������Л��ɩ\r�������\n\0\0\0\0���\0\0

�\0༠�\0\0�\n\0��������
��\n\0\0\0�\0
����А�\t
\t��
\t�
����������\0�
\t����
\t
��ٺ���������\0\0\0�
���\0\t�
\n�\n\0�\t\n\0�\0�\n��
\n�\0�
����\0����ۛٹ�

ɰ𞐹������۽���\t\0�\t\t
��������������������\0���\0
���\0\0\0�\0����\t�\t\0\0\n\t\t�\n�\0�\t
\t\0�\0��\n\t\0�����������
\t�\n����
������\n�\t\0��������К��
���￿��\0\0\0�\0\0����\0��\n�\0\0�\0\0\0�\t�\n�\0\t\0�\0\0\0\n
\0�\0\n\t\n
������𐛚����
�\r��\r����\0��\n���\r������ټ����޿����ڠ\0\0\0\0\n\t���\0\n\0\n����\n�\0\t�����\0�\0\n\0\0\t���\t\t\n\0��\t����\r�\t����ɫ�������\r������������\r����

��ɿ����\t�\n\0\0����\0\t�\n��\0��
\0�

\n�
\t\0�\t\0���\0\0\n\0��\0
���

���ə�����

���\0�

ː�\t
��������������
�������\0\0�\0\0
���\0\0�\0�
\0�\0

Ϛ�
\0��\t�\t\0���
\0�\0\t\0\t�����𽩰𐼙������\t
\t�А������\r���\t
ښ�
ڼ������
�\t\0\0\0�\0����\0�

\t\0��𚐟��\0��\t\t\n��\t\0\0\0\0\0\n\0\n\0\n��ۚ�������������\t���\t���
�ٟ���ɚ���
�����������鬬\0�\0\0\0
���\0\n\nР��\0\n�𞾝�
\0�\0��
\0��
\0�
\0\t\0\n�������ۙ
\t�
ٚ���
\t\t
\t

й����\t���障��ڼ����߾��
�\t�\0\0�\0���\0\0�\n�������
�����\0�А\0�\0\0\0\0\0\n\t\0����
�������������
\0�
\r������ۛ\r���ٛ��������������\0\t\0\0

���\0\0����\t\n\0�����

\0��\t��\0
\t�
\0�\0\n\0��ښ۟\r�����ɐ�А\t\t\0�����
��������������
۩����ښ�\0��\n\0\0����\0��
\n\t��
�\t�\0
\0�\t\t\0��\0\0�\0\0��\t
��������ٛ����
\0����\n\t�\r���ۙ�ٹ�а�ٹ\r��������Ͽ��預\0\t\0\0
���\0\n\0��\t�\n�𰰰��\t
\0\0\0��\t\0������\n\n\0��������ٺ�
\0�
�\0\0�\n\0��\t
������
\t�
ۚ�л
����魼���Р\0\0��
���\0\0\n�\0���\0\0\0\n\t\n\0�\t\0
\t���\0\0\n\0\0\0��ۼ���
����ٛ��\t\0\0\t��\0\t\0�\t���\t������ٹ�ٽ���
��������\0��\0\0����\0\t�\n\n�\n�\0�\t\0\t\0\n\t\0\0\n\0\t��\tڐ�\t���\n\t��������ۻ
���
�\t\0\n\t\t�\0\0\t\0��
���

ڙ�۩�����ڞ���������\0\0�\0\n����\n\t\0\n����\n\t\n\t\t\n\0\0\0\t\n����\n\0�\0\t\0�
ￛ������������������\0\0���\t�����������۟�
��������\nښ\0�\n\0\0����\0\0\0��\r����\0\0\0\0\0\0\n\t��
\t\0�\0�\n\t�
\0��\t���۟����ې�����
�
\t�����\t��������л
���ڟ

�𽩭��
\t�\n�����\0
ʚ�\n\0�\n�\0�\t\0\n\t\0�\0��\t�
\0�\t\t��\0����\t�������됹����
������ٹ\n�ɹ�����鿝����������˭��\0�\0\0\0���\0\0���\0��\n\0\0
\t\0\n\0�����\0�\t�\n�\0�\0�ۛ���۟�������\t���ɰ��

�
�\t�������������۟�����������\0�\0\0���\0\0�
\t\0�\n�\t\0�\0\n\t\0\0���\t�
\n\t�\t�

ۚ���߿�������������ۙ�����������������������
�������\0��\t�����\0\n\0��\t\n\n��\0��\t\n���

\t��а��\0��\0\t������������\t�ߟ���������\t������������������ڛ�����\n�\n\0\n\0\0����\0\t��\0���\n𰩐��\0\0\0\0���\t�
\t��\r\0���������������������������������������ۼ�������������\0�\0\n\t���\0\n\n\0��\n��\t��\t���\0���\t�����\0��\t\t���������ۛ���������������\t
ڛ������������������
���\t�Р��\n\t���\0\0��
\n\t�𹩰��\0\0\n\n��\n���
\t�\t\t��������������������������ۛ�������ۿ�����������˻���\t�\0���
���\0\n
����
\0�
�����\t\t\t\n�\t\n�����\n\n\t��������۽�����ۿ�����������ڿ������߿�������
˫�Л�����\0��\0\0����\0\t�\n���������\t\0\n\0\n\t\0������
\t\t\n���ۿ�����������۹�������ۛ��������������������������ک\0�\0������\0\n\n\0���ˠ�\t
�����
\t\n���������������������������������������������������������
�����˰��\0\0�\0\n���\0\0����
\0��

\0\0��\0\t
\n�
����
\0������۰��黟�����������������������߽��������
�
������\0\0�\0\0����\0\0���\n��\0�\0�\0\0\0\0\0\0\n\0\t\0�\n����
���������������������������۽���������������
�������
���\0�\0\0\0����\0��\r�\t\n��\t\0\t\0\0\0\t\0\0�\t�
\0��������ۿ�������٩�����߿����۽�
�۟�߽���ۿ�����˚��
�����\t\0\0\0\n����\0\0
\n\t�����\0\0\0\t\0\t\n\t����\n�������\t������۟\r�������������������������߽���������������\n\0\0\0\0
����\0�\t�\n�����\0\0
\0�\0�\t\n\0�

\t����\0������������\t�𰹽��������������ڟ���߻�ߛ��ٻڙ����ɛ�\0\0\0�\0����\0\n��\t�
\0��\n\0��\t\0\0����\0�\0����\t�\t������������\t\r�驟��߿������𼹹���������������\t\0���\0\0�\0�����\0��������\t�\0\t�\0��
\t�
\n�\0����\0�������ۻ�
\t�\t�
\t����������������˚������������韟��\t��\0��\0�\n����\0\n���а\0���
\0�\0\0
\0����\0����

�\t����������
\t\t\t

������������\r���۟������۹����
��\t�����\0

�����\0\0��\n��
��\n��\0�\t\0

\0���\0��
\0����������
\0\0�������������۰����
А���������������ɰ�\0���\0\n�\r����\0\0��\r\t��
�\n\t\n��\n\0\0�\0�\n�\0
\n����\t\t��������\t�\0\0\0\0������������ې��
�\t����ۿ���鿼���\t\n���
\0��������\0��
\n\n����\0���\t\t\n\0\0�\t\0\0\0\0\t\0�\0\r�\t���۟\0\0\0\0\n\0\0\0�\0\r\t��������
�\t\t
�\t����ۿۻ������\0�\t\0����\0\t\0�����\0\0����\n����\0�\t�\0\0\0\n\t�\0\0\0\0\0�\n����
�����\0\0\0�\0\0\0\0\0�������������\0\0\n��
�˽�����������\t\0�\t���\0\n\0�����\0\n��

���\0�ʚ\t�\0\t\0\0\0\0\0\0\0\0\0\0\0\t\t\t۟��\t\0\0\0\0\0\0\0\0\0\t�ڛ�����
\0\0\0������������������\t\0\t\t����\0�\0
\0���\0\t�
頩\n�\0��\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�������\0\0\0\0\0\0\0\0�\t��۟\t��\0\0�\0\0\0\0
�\r������������\0\0����
�\0\0\0\0\t����\0��\0\0�\0�\0\0\0\n\0\0\0\0\0\0\0\0\0\0\n�\0
\0\0\0����ې���\0\0\0\0\0\t\t��٭����\0�\0
\0\0\0\t\0\0��\t���������ې\t
\t��ర\0\0\0\n���\0\t��������\0\n��\0�\0\0\0\0\0\0\0\0\0\0\0
\0\0\0\0������

\t\r��\t\0�\0\t����\t�
��\0\0\0\0\0\0\0\0\0\0���뿿�������������\0\0\t�\0����\0\0��\0\t\0�\0�\t\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0���
�����\0�\n\t�����Й���\t\t\0\0\0\0\0\0\0\0\0������۽�˚�������\n��\0\0\0\0���\0���\n\n\0��\0\t\n\0�\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�����\t�\t�\t�\0��\t\t��
��\t\t\0��\t\0\0\0\0\0\0\0�\t�۹���۽�������\t�
�\0\0\0\0\0����\0�
\0�
��\t�\0�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r���\t���ڐ�
\0\0�\0���\0\t�\t���\0�������\t��
�ۛۿ�����
����鬐�\0\0\0����\0\0�\0�\0���\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������\r
\t
\t���
\t\t\t
�ڐ�����\n���\t\t
��
���������
�\t�\t
�\0\0\0\0\0
���\0\0�
\n


��\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\t\0\t���
\t\n\0\t\t\0��\t�����\t\0\t\t\t\t�
���\t��鼛�����\nА��\0�����\0\n\0\0����\0�\n��\0���\0\t\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��\0\0\0\0\0\0\0\0��\t�\0���
�����
\0����\t\t���
�ۿ���\t����\t�\t\t���\0
\0\n����\0\0\0𬰠���\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t��\0\0\0\0\0\0\0\0\0\t����\t��\t�\t\0��\t
\t\t���
��۝���\0�\n�\0\0
��\t�\0\0�\0����\0\n\t�������\0\0\t\0\0��\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0���\0\0\0\0\0\0\0\0\0��
����Л
\t\n\t\n������
�����鿺����\0�\t�\0���\t�\n\0�
���\0\t�����
�\0�\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\0\0\0\0\0\0\0\0\0
й
˛����а�\t\0���

�魙�������\0\0\0\0\0���\0�
\0\0�\0\0����\0�
\n\n\0��\0\0�\t\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0���\0\0\0\0\0\0\0\0\t\t
���П��\t�\t\0�
\n���𐚐��ٻ�ۚ�\0\0\0\0\0\t��
��\0\0�
����\0\0����


�\0\0\0\0\0\0\0\0\0\t\0\0\0\0\n\0\0\0\0\0\0\0���\0\0\0\0\0\t\0�����������
\0�\t\0\t




\t
\t������\0\0\0\0\0\0\0\t\0\0�\r\0�\0\0\0����\0��\n�\0�\n�𠐩\n���\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0���\t\0\0\0\0�\t����ٽ��

��\0\0\0\0\0\t\0�\0\0\0\0������\0\0\0\0\0\0\0\0\0����\0\0\0\0���\0\0����\n���\t\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���ښ�
��������ڛ����\0\0\0\0\0\0\0\0\0\0\0\t������\0\0\0\0\0\0\0\0\t�О\0\0\0�\0����\0\n\n\0��\0�\n�\n\0�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����������۩�����
��\0\0\0\0\0\0\0\0\0\0\0�����\t\0\0\0\0\0\0\0\0\0\nɫ�\0\0\0\0
����\0\0�����\0��\0\0�\t��\t\n\0\0\n�\n\0�\t\0\0\0\0\0\0\0���ڞ�������ۭ��������\0\0\0\0\0\0\0\0������\r�\0\0\0\0\0\0\0\0\0\0��
\0\0\0\0\0����\0�頠\n
�\n�\0��\0�\0�\0\0�\0\0\0\0�\0\n\0\0\0\0\0\0\0\t����������������۟
�ڛ��\0�\t\0\0\0\0\0�������\0\0\0\0\0\0\0\0\0\0����\0\0\0\0���\0\0\n\0�����\n\0\0\0���\n\0\0\t\0\0\t\0�\0\0\0\0\0\0\0\0���
����������߻˽���۟
\0\0\0�\0
�������\0\0\0\0\0\0\0\0\0\0\0���\0\0\n\0\0����\0\0�\0�\0�\n�\0\n��\n\0\0\0�\0�\t
\0\0�\t\0\0\0\0\0\0\0����
���������������
���˝\t��\0\t������\0\0\0\0\0\0\0\0\0\0\0\t�
\0\0\0\0\t����\0�\0���ڐ��\t\t\0\t\t\0\n\t\0\0\0�\0\0\n\0\0\0\0\0\0\0\t
�\t��ڿ����������������������������\0\0\0\0\0\0\0\0\0\0\0\0\nڞ\t�\0\0\0\0����\0��\n�\n\0���\n\0�\0
�\n\0\0\0\t\n\0\0�\t\0\0\0\0\0\0\0\0�����������������˞�������������
ڹ��\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0���\0\n\0�
��\n\0�\0�\0�\0\t\t\t\0\n\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������
�����۹�������������������\0\0\0\0\0\0\0\0\0\0\0\0\0���\0\0\0\0����\0\0�\t������\0\t\0���\n
\t\0�\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����
���
���ۻ۹����������ڟ�˚�\0\0\0\0\0\0\0\0\0\0\0\0

\n\0\0\0\0�����\0��\n\0\0�\0�𠠠\0\0\t\t\0\0\0��\0\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\t�����ɩ�����ɩ۟��������������\t\0\0\0\0\0\0\0\0\0\0\0\0\0���\0\n\0\0\0����\0\t\0�����\n�\t\t\0���\0\t\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
�������
\t�������������ۛ�˰��\0\0\0\0\0\0\0\0\0\0\0\0\n
\n�\0\0\0\0���\0��\0\t\0\t
��\0\0�\0\0\0�\n\t����\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\t\t\n
\t\0���
ɛ�����ڹ���˹��ڐ\0\0\0\0\0\0\0\0\0\0\0\0��\nа\0\0\0\0����\0\0�
\n\n\0\n�
\n�\0

\0��\0
\t\t�\n\0\0\0\0\0\0\0\0\0\0\0�\0\0\0���\0\0\0���ڐ�ٹ������������۩�\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0
����\0��
�\t�\0��\0�\0�\0\0�\0\n\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\t�\0\0\0\0\0
\t\t�٫�ٰ������������ې\0\0\0\0\0\0\0\0\0\0\0\0\0��\n�\0\0\0\0\0����\0\0\0�\r�

��\0��\0��\t
\t\t\0�ڐ\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\t\0�����۹��ۛ������������\0\0\0\0\0\0\0\0\0\0\0\0�
��\0\0\0\0����\0��\n\0\n\0\0\0�\t\0\t\0\0\t�\0\n\0\n\n\0\n\t\0�\0\0\0\0\0\0\0\0\0\0\t\0��\0\0\0�\0\0\0��

�\t˙��ڽ��������\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0����\0
\t��\r\n��
\0�\0�\0������\t\0\0\0\0\0\0\0\0\0\0\0\0\t\n\t\0\0\0\0\0\0\0\0�
������
���۹����ۚ��\0\0\0\0\0\0\0\0\0\0\0\0
�\n��\0\0\0
����

\n\0�����\t\0\0\0�\0\0\0\0\0\0\n\t��\0
\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0�\t����\t����ۻۛ����\t\t�\0\0\0\0\0\0\0\0\0\0\0\0\0��ښ�\0\0�\0����\0\0�\t�\0��\0�\n\0�\n\0�������\n�\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0�\0�\0�\0���

�

�۽��������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0
�\t�
\0\t�����\0���
ʠ�\n�\t\t\0\0��\0\0\0\0��\n�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0����\0\t\0\0\t
��ٹ�����˟������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�ʞ���\0����\0�����\n��\n
\t�
\0���\t\t\n\t\0\0�\0\0\0\0\0\0\0\0\0\0\t\n\0�\0\0\0\0\0\0\0\n�ښ����˟����랛
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����ʐ����\0\0\n��\n������
\0
\0�\0\0\t\n\n\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0��\0\0\0��\t����齺���ٽ�鹭��\0\0\0\0\0\0\0\0\0\0\0\0\0\0������
�����\n�������\0��\t\0�
\t�\0\t\t\n��\0\0�\0\0\0\0\0\0\0\0\0\0\0\t
\t
\t�\0�\0\0\t��������𿟿������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\n����ʜ����\0\t��������\0\0�\t\t\0\n\0�\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
\t�\0\0\0�\t\t\t������۹������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
����ڟ�����\0\n����
�𠩩\0�\n�\t\0�\n��\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\t\0\0\0\0\0�\t���������
���\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������\0
��������\t�\0�\0�����\0���\0�
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\n�\0\0\0\0\t\0������������\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\n
����������\0��������\t�
\0�
\t\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\n\t��������鰩\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�����������\0���������\0\0\0�\t\0\0\0�\0�\0�\0�\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\n\t
����
���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��
��������\0
��������
\0�\0\0\0
\0\0�\t\0�\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t�\0���\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t��������\0\n�������\0�\0\0��\0
\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����
\t�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�
\0���������\0�ϯ�����\0\0\0��\0\0\0\0\0\0\t\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��
�\n���\r����\t����������
\t��\0\t\t
�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�\t����\n����\0
뮞�������\t����𰿐���\n��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�𿭠���\0\0���������������������\r����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������\n
���\0\0\n�����������߿��������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n��
\n��ސ�����\n��
���������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0

\0�������\0\0\n���ڭ����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��
\0���������\0\t�ʞ����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
����޾������\0\n\n
�������
�
\0�����驩����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\t����������\0�������
\0�\0\0�
\t�
\0���
\t���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���
˭������\0\0���������\0\0\0\n�\0\0\0\0\0\0\0\0\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0


����ν������\t
���˭��\0�\0\n\0\t\0�\0\t�\t\t\t��\n\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��
�Κ\nʿ���\0\n��������\0�\0�\0\t\0�\n\t�\t\n\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�

�ੰ��
����\0��������\0\n\0\t\0�\t\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����
��\n�����\0\0������𐐐\t\0\0\t\0\0\0\0\0\0�\n\0�\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
\n�а�𼿟���\0\n���Ͼ����\0\n\0\0\n\0\0\0\t\0�
\0\n\t\t\t\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\n\n�\n������\0\0�������

\0�\0\0�\0\n\0\0\t\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t�
����ˬ������\t���������\0\0�\0\0\0�\0\0\n\0\0\0\0\t\t\t\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\t�\0�\0���
\t�����\0��������\0�\0\0\0\0\0\t\0\0\0\0�
\n\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t��\0��\0�����\0\n˟�۟�˞�\0\0�\t\n\0\0\0\0�\t\0�\0\t\t\t�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t��\nʐ
���\0����\0\t�ବ�����\t\0\t�\0\0\t\n\0\0\0�\0\0\0\n���\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\n\t\0\n���\0������\0�����ښ��\n\t\0\0\0��\0��\0\0\0�
\t\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�
\0\t\n\0�\n�\t\n\0���\0\n
�������\0�\0\t\0\0\0\0\0\0�\t\0\n\0\0����\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
���\0\t\0�\0\0�\0����\0\0�\t�\n����\0\t�\n\0�\t\0��\0�\0���\0\t\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\n�\0\0\0�
\0\0�����\0
\n�\n���
\0�
\t�\0�\0\0�\n\0\0\0\0\0\0�\t
\0\0��
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0��\n�\0��\0\n\0������\0���������\0\0\t\t\0�\0\0�\0��\0�\0��\0
\0\0\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\0�\0\0\0�\t\0\0�\0���\0
���\n�\0�\0����\0\t\0\0\t\0
\0\n�\0\t�\0\t\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\n\n�
\0�\n\0\0\0�\0\n\n����\0\n
\t頚
���魐�������ɭ���
������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\t��
��\n����\0\n\0\0���\0\t\0�\0��ୠ�������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\n��\0������\t\n�\r\n��������\r��\n�������������������������������\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\t頰��
�鮚\t��
��ʟ���\0\0�\n
\0�༭����������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�\0\0\0\0��\n��������\nڐ물�����\0\0����
ʚ���������������������������\n��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n���\t\n������ڞ��\n����������\0

�\n����������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��
�\t�\n�
�ϯ�������\n�Ϟ�����\0ʞ����\n�����������������������������
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r������\0���ڞ�����\n��������\0\0�˩��˭�������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n
\n����ﾼ������
\n����������\0��޾���
���������������������������

�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0

���ྭ�������ک������������\0\0��齮�����������������������������\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\n�\t������������

��������\0��������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�����龞��������ښ\0\0\0\0�������\0\0���������������߿����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������������ʚ�������\0

�ʟ������������������������������߿���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
\n������������������\n�����ڿ���\0\0�����Ʞ��������������������������������ﾾ��\0\0�\0\0\0\0\0\0\0\0\n�\t�\n�����������������\0�\t�������\0�����������ߟ��������������������������������\0�\0�\t�\0��\n�
\r\n
\n���
������ڟ�믭��
����������\0��ښ��\0���������������������������������������\t\0��\t����ɬ\0����������������������랟����\0\n
��
\0��
�����������������������������������������\n���\0�\0�\t��\0����������������
����
���������\0\0��\n�������������������������������\t��޿��������������
\t�\0\0�
\0����������������߼����\0�����
��������������������������������������ۭ��������\n\0\n\0\0𰼯\r������������
�\r��齾�����\0
�����������������������������������Ͻ��ﾾ�������������
\t\n�\0\n\0�\n���\n཯��������������\0�������ʞ�����������������������������������߭�˼������
�\n\0�\n��\n������������ɩ���������\0\n�������������������������������������������ڼ����ϼ��𰐰������\n
\t\n\0������

�\n�
�޿�����\0�����������������������������������������������ڽ龛�޿��
��ɩ�
�

\t\0\t
��\n\n˩���\r���������\0\n
��������������������������������������������޻�������𼰚��������చ\0���ښЩ������������\n
��������������������������������������߾������ޚ���
���\r���
��\n��\0�\0���\0�\0�\0�\n���������\0�����������������������������������������������\nڼ�������𼰼��\t�����
�\n�\n��
\0���\n�\0�����\0\0��������������������������������\r������������
\r�˽����������ڼ�ڞ����\n��
\t\0\0\t����\0�����\0\n��������������ߞ��������������������������޿���ˮ�������\0�������
�ʞ����
��\n\n\0\0\0\0\n\0

����\0��\nڼ���������������������������������������������\t������ښ�������
�魭�
�\n���
\n\t\0\t\n\0\n����\0\t�魯��������������������������������������޼�������ڞ��頚������������𼽠��\0�\0\n\0\t\0�����\0\n\n\nʚ��������������������������������������������\n��
˼��
��
�
�
����ʞ������\n\0�\0����\0��\r��������������������������������\0��������������������
��\0��𼼰��𼿭���驠\0\0\0\0\0\0\0\0����\0\0�\n\0�\n\n\n\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ԭ�','Michael is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986).  He has also taken the courses \"Multi-Cultural Selling\" and \"Time Management for the Sales Professional.\"  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.',5,'http://accweb/emmployees/davolio.bmp'),
  (7,'King','Robert','Sales Representative','Mr.','1960-05-29','1994-01-02','Edgeham Hollow\r\nWinchester Way','London',NULL,'RG1 9SP','UK','(71) 555-5598','465','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0 T\0\0BMT\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�S\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0��ͬ�������
�������������������������\0
\n

���Ο���������\0\0���
����������̬�����������������
��������������������������������\0\0
����������ϟ�����\0\0��ܬ����쬭�������������ެ������ܭ��������������������������������

������������������\0���������������
�����������������̯������Ξ���Ξ����������������������\0\0\r���������\t���������
�����������������������������������������������������������������������\r�Ξ�������޹\r���\0��������������μΞ��ެ���������������������������������������������\0\0

�������ߜ��������\0̬���̬�������έ�ΞΞ��������������
������������������������������������\0��޼��������Ξ\t�����\0��\0�̭�ޭ������������������Ϯ������������
������������ܮ���������������
߯���������\n��������\0
�����
�����������������������������

���������������������������������������������
А�����\0����
����������ά�����������������������������������������������������
������\t�����
�\r���\0��
���������
��Μ�������������\0�������ʜ����������������������������������ͼ����𚐹\t\r\t���ڐ���
��������������Ϯ�����������\0���������

�����������������������������О������ޟ����м\t���\0���
�ά����\r���������������������������������������������������������\r�����������\r�\t�
��
�����\r�������������̬��������\0�������������������������������������������\r\r�\t�\r\0����\0��
�����
��������쬬����������������������
������������������������Ｍ�\r��ߞ�\r���𜐟\r\t\0��
������Ξ��ά��������������\0��������Ξ����������������������������������������
�\0

�\0�����


����̬��
����������\0\0\0������������
�����������������������ʜ�����\r��\r�Л\r
��\0������
�����������������������\n\0\0��������������������������������������\r������������\t�
\0����

���������
�

��
������\0\0\0\0\0����������������������������������������޼�ߟ�����\n�
\t\0μ�����
����
����
��������\0\0\0\0\0������������������������������������\t\t�޽�������������\r\t\0\0
����
�ά���
�
����������\n\0�\0\0\0\0���������������\r���������������������������ޞ����Н
\r\0�\t\0\0������������������������\0�\0\0\0\0������������������������������������\0�����������������ڐА\0
�����
�����

������������\n\n\0\0\0\0\0�������������������������������������������߾ߞ��\t��\r\t�\0\0\0\0��������������̬���������\0\0\0\n\0\0\0\0\n��\0��Ϯ�����������������������������������߽�����ޝ�����\0\0μ���


��
��
���������ɠ��\0\n\0�\n��\n\0
��������������ެ����������������������������ͭ�
�\t\0\0
�����
��������������ʠ�\0\n\0\0\0\n\0��\0\0\r������������������������������\r���߼������ߟϟ���Й\0\0\0\0\0����

�̬�����������Ω���\0\0\0\n\0�\n�\0\0�����������������������������������߽�Ͻ����ݭ�\t�\0�\0\0
��έ
����ޞ��
����\0
�\0\0\0\0\0\0���
\0�\0�����������������������������\t����������߿���\r����\n���\0\n���

���
����̼����
\n\n\0�\0\0\0\0\0\0\0����\0�\0\n��������������������������
���������߭���������\t\0\0\0

������������Ξ������\t\0�\n\0\0\0\0\0\0�\0��\0\0�\0������������������������������������������й����\0\0\0��������ͬ���������\0\n\t\0�
\n\n\0��\0\0��\0�\0\0\0�����������������������������������������������\t\0�\0
�����������
������\n\n�\0\0\n\t�\0\0\0\0\0\0\0���\n\0\0\0\0����������������������������������������韞����\0\0
�������
���������\0\0\n�\0\n\n\n\0\n
\0�\n\t\0\0\0\0\0�����������������������\r�߯������������������

\0\0\0������������������\0�\0�\0\0\0�\0\0�\0\0�\0\t\0\0\0\0\0\0����������������������\0���������������������Кн���\0\0������
������
�\0\n���࠰�\0\0\0\0��\0\t\0\0\0\0\0\0\0\0��������������������\r�������������������������\t\0\0\0�
������������\0\0�\0\0�\n\n\0\0�\n\0\n\0\0\0\0\t�\0\0\0\0\0\0\0\0\0\0�������������������\0��޽������������������ͽ���\0\0����
��������\0\0\0\0\0\0\0�\0��\0\n\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\n�����������������ߜ������������������\t�
����\t�\0\0
����
�
�����\0\0\0\0\0\0\0\0\0\0\n
�\0\n�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0������������������\r��������������������͟����\0\0��������
�\0\0\0\n\n\0\0\0\0\0\0��\0\0��\n\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0���������������ڐ����������������������\r�����\0\0\0����
��\0\0\0\0�\0\0\0\0\0\0\0\0\0�\n\0\t�\0\n\0��\0\0\0\0\0\0\0\0\0\0\0\0\0��������������\r����������������������𜝬����\0\0\n��
�����\0\0\0\0\n\n\0\n\0\0\0\0\n\0�\n\t\n�\0\0\0\0\0�\0\0\0\0\0\0���\0\0\0\0\0��������������\r���������������������
ɛ\r����\0�����̬���\0\0\0\0
\t\n\0\0\0\0\0\0\0\0�\n�
��\0�\0�\0\0\0\0\0�\0\0\0\0\0\0\0\0������������\0������������������\t����霞���ʙ\0\0\0�����ϯ\0\0\0\0\0\0\0�\0\0\0�\0\0\0\n\n\0\0\n\0\0��\0\0�\0����\0\0\0\0\0\0\0\0
������������������������������������ɭ���\0\0��\r���\0\0\0\0\0\0�\0��\0\0\0\0\0\0\0\n\0\0\n\0�\0\0\0��\0\0\0\n\0�\0\0\0\0\0\0\0\n\0\0����������\0������������������������м���\t�\0��ά\0\0\0\0\0\0\0\n\n�\0�\0\0\0\0\0\n\0��\0\0\0\0\0\0�\0\0\0\n\0�\0\0\0\0\0\0\0\0\0\0\0
�������������������������������ڐ����ɐ���\0

�ޞ�\0\0\0\0\0\0\0\0\0\0��\0\0\n\0\n\0\0\0\0\n\0\0�\0\0��\0\0\0\0\0\0\0\0\0�\0\0\0
\n\0\0���������\r�����������������������\t\t

���\t\t\0\n�Π�\0\0\0\0\0\0\0\0\0��\0\0\n\n\0\n\0\0\0\n\0�\t\n\0\0\0\0�\0\0\n\n\n\0\0\0\0�\0�\0\n\n
\0\0��������
�����������������ߟ����К��٭����\0

��\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\n\t\0\0\0\0�\0\0\0\0\0\n\n\0\0\0\0\0\0\0\0�\0�
������˚����������������������
�\t
\0�
�ٰ\0����\0�\0\0\n\0\0\0\0\0���\0\0���\n\0\0\0\0\n\0�\n\0\0\0��\0\0\0\0\0\0\0\0\0�\0\0\0
\n
\0\0�������
�����������������������ɼ�������\t\0

��\0\0�\0\0\n\n\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0��\0\0\0\0\0�\0\0\0\0\n\0\0\n\0�\0\t����������������������������靹���٠����\0�\r����\0\0\0\n\0\0\0�\n\0\n\0\n\n\0\0\0\0\0\0\0\0\0\0�\0��\0\0\0\0\0\0\0\n\0\0\0\0\0\0��\0�������������������������������ޟ���ɞ�\n�
\n��\0
�ɬ��\n\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\n
\n�\0\0\0\0\0\0\0�\0\0\n\0\0\0\0�\0�����������������������ߟ����������\t
��\0
�
�\n
����\0\0\0\0\0\0�\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\n\0��\0\0\0\0\0\0\0\0\n\0\0\0\0\0\n\0��\t������������������������߿���������������ΰ\n\0�\0�\t����\0\0\0\0\n\0\0\0\0\0\0\n\0�\0\n\0\0\0\0��\0\0\0\0\0\0\0\0�\0��\0\0\0\0ʜ���������������������������������������\r
\0�\0\0\0\0\0\t�\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\n\0�\0\0\0\0\0\0\0\0\0��\0\0\0�\0��
���������������������������������������
�
�\0\0\0\0\0\0\0\n\0
\0\n\0\0\0\0\0\0\0\0\0\0\0\n\0�\n\0\0�\0\0�\0\0\0�\0\0\0\0\0\0\n\0\0\0��
\0�\0\0�����������������߽���������������۟�\t�̰\0\0�\0\n�\0\n\0�\0�\0\0\0�\0\0\n\0\n\0�\n\0\0\0\0\0\0��\0�\0�\0\0\0\0\0\0\n\n\0\0�\0���\0
������������������������������������𚚐\0\0\0\0�鬰\0\n\0�\0\0\0\0�\0\n\0\0\0\0\0\0\0\n\0\n\0\0��\0\0\0\0\0\0\0\0\0\n�\0\0��\n\0\0\0�\0��������������������������߿�������\r�\r\0\n\0\0\n
��\n\0�\n\0�\n\0�\0\0\0\0\0�\0
�\n\n\0\0\0\0\0�\0\0\n\0\0\0\0\0\0\n
\0�\n\0\0\0\0��\0\0���\r���������������������������������ۙ�\0\0\n\0\0\nʚ\0\0\0\0\0
�\n\0\0\n\0\0\n\0\0\n\0\0\0\0\n\0\0\0���\0\0\0\0\0\0\0\0��\n\0�\0\0\0\0\0\0\t���\0����������������������������������ڐ�\n\0\0\0\0\n��\n\0�\0�\0\0�\0\0\n\0\0\n\0\0�\0\0\0\0\0\0��\0\0\0\0\0\n\0\0\0\0\n\0���\0\0\0\0�\0�������������������������������������\r���\0\0\n\0\0�\0\0\0\0�\0��\0�\n\0\n\0�\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0\n\0\0\0\0\0
\0\0\0\0\0\0�\0����������������������������������������\0���\n\0\0�\0\0�\0�\n\0\0�\0�\0\0\n\0\n\0\0\0\0\0\0\0\0�\n\0\0\0\0��\0\0\0\0\0���\0\0\0�\0\0
��������������������������������������\t�\0\0\0�\0�\0\n\nʚ\n\0\n\n\n\n\0\n\0\0\n\0\0\0\0\0\0\0\0\0
�\0\0\0���\0\0\0\0\0\0\0\0\0�\n
\0�����������������������������������ۙ��\t\0\n\n\0�\0\0\0\0�\0�\0\0\0\0\n\0\0\n\0\0\0\n\0\0\n\0\0\0���\0\0\n�\0\n\n\0\0\0\0�\0�\0\t
\0\n\0��������������������������������������\t��\n\0\0\n�\n\n\0�\0\n\0\0���\n\0\0\0\0\n\0�\0\0\0\0\0\0\0�\0�\n\0\0\0�\0�\0\0\0\0\n\0\0\0\0\0�\n\0\0����������������������������������˛�ٽ���\0\n\0\0\0\0\0\0����\0\0\0�\0�\0\0\0\0\0\0\n\0\0\0\0�\n��\0\0�\0�\0\0\0\0\0\0\0�\t\0�\0\0\0\0���������������������������ߞ����ɹ���ڜ��\n\0\n\n\n\0�\0\0\0\0\0���\0\0\0\n\0\0\0\0\0\0�\0\0\0\0�\0\n���\0�
\n\0\0\0\0\0\0\0\0\0\0\0\0�\n�������������������������������ܹн��\tМ\0\0\0\0�\0\n\0���\0\0\n\0\0\n\0�\0\0\0\0�\0�\0\0\0�\0\0�\0\0\0\0\n�\0\0\0\0\0�\0\0\0\0\n\0\0\0\0������������������������������\tа�޽���𰠰�\0\0\n\n\0\0\0\0\n\0�\0\0\0\0\0\0\0\0\n\0\0�\0\0\0\0�\0\0\0�\0\0\n\0��\0\0\0
\0\0\n\0\0\0\0\0\0\0\0\0����������������������������ۙ�йڽ�����\0\0\n\0\0\0\0\0\0�\0\0\0\0\0\0��\0\0\0\0\0\0\0�\0\0\0�\0\n\0\0�\0\0\0�\t\0\0\0�\0\0�\0\0\n\0\0\0\n���������������������������
���
�����\n\0\0\0\0��\0\0\0\0\0\0\0\0\0\0
\n\0\0\0\0\0��\0\0\0\0�\0\n\0\0\0���\n\0\0�\0\n
\0�\0\0\0\0\0\t�������������������������������П\t럟\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�\0\0\0�\0\0\0�\n\0\0�\0\n\0�\0�\n\n\0\nΐ\0�����
\n\n\n��\0\0���������������������������ߝ�˙�������\n\n\0�\0\0�\n\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0\0\0���\0\0�\0��

\0�\0\0\0\n�����������������������������ː���ϐ��\0\0\0��\0\0\0\0�\0\0\0\0\n\0\0\0\n\0\0�\n\n\n\0\0\0�\0\0\0\0\0\0���\0�\n\0\0\0�\r\0�\0���\0�����������������������������\r�А�
۞���\t\n\n\0�\0\0��\0\0\0\0\0\0\0\0\n�\0\0�\0\0\0\0\n\0\0�\0\0\0\0\0\0\0\n\n\n\n\0�\0\0\0��\0��\t\0�\0\n�����������������������������\r�М�˟�\t��\0\0\0��\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0�\0\0�\0\0\0\0\0\0�\0�\0\0\0\0\0\0��\0�\0�\t���������������������ۙ��������\t\t齭����\n\n\0\0\0��\0\0\0\0\0\0\0\n\0��\0\0\0�\0�\r\n\0��\0\n\0\0\n\0\0\n\n\0�\0��\0\0\0\n\r�\0\0�\0������������������������������ߟ�\0�������\0\0\0�\n\0\0\0\0\0\n\0\0\0\0\0\0\0�\n\0\0\n
��\0\0�\0\0\0\0
��\0\0\n\n\n\0\0\0\0\n\0\n\0��\0�������������������������������랙\0\0�����\r��\0\0\0�\0�\0\0�\0\0\0\n\0���\0\0\0\0\0\n\0�\0�\n\0\0���\0\0\n\0\0\0���\0\0\0��\0
���������������������ߝ��������ۛ���\0\0\0�����\t\0\0\n\0\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0��\0\0�ڐ��\0\0\0\0��\n\0\0���\0\0\0\n\0\n\n\n\0\n���\n���������������������������\r\r\t\0��\0\0
����\n\n\0\n\0\n\0\0�\n\0��\0\0\n
�\n\0\0\0\0\0���\0��\0\0\0\0\0\0\0��\0\0������\0\0\0\0\0��\0������������������\t����\r������\t\t\t\0����А�\0\0\0\n\0\n\0\0\0\0\0\0\n\n\0\n\0�\0\0\0\0\n\0\nɠ�\0\0�\0\n\n\0\0\0�\n\n\0\n\0\0\n\0\0\0\0�
\t\0��������������ߐ���������ۜ�
АК�\0
�����\n\0�\0\n\0\0\0�\0����\0\0���\0�\0\0\0�\n\0���\n\0\0�\0\0\0\0\0\n\0\0��\0\n\0\0\0\0\n\0\0�����������������\0\0������������ۛ��ٜ�����\0\0\0�\0�\0�\0�
\0\0�\0\n\0
�\0��\0\0\0\0��\0�\0\0\0\0�\n\0�\t�\0\n�\t\n\0\0�\0�\n���������������ۙ���������������ɭ����ٰ��\n\0\0\0\0\0\0\0\0\0\n\n\0\n\n\0\n\0��
\n\0�\0\0\0�ΰ�\0\0�\0�
�\n\0��\0\n\0
\0\0�\0\0������������������������������۟�۝�������\0\0�\0\0\0\0\0\0\0�\0\n\0\0\0\0\n
��\0�\0\0��
\n��\0\0�\0��\0�\0�\n\0
\0\n\0�\n��������������������������������ܰ��ː����\0�\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\n�\t��\0\0\0�\r��\n�\0�\n�\0��\0\n\n\t�\0\0\n\0�
\t\0���������������������������ٰ�際�����\r��\0\0\n\0\0\0\n\0\0\0\0\0��\n\0\0\0\0\0\0��\n\0\0\0ޠ\0\n��\0\0\0\n\0\0�\0�\0\0���\0�\0������������������
���������������\t��ۛ�ٰ�\r�\0\0\n\t\0\0\0\0\0�\0\0\0\0\n\n\0�\n\t�\t\n\0\0�\0\0\0\n��\0��
\0\0\0\0\0\n\n�\0\t���\0\0���������������������������ۜ�\0��\t�Й���\0\0\0\n\0��\0\0\0\0\0\0\0
\0\0\0\0\n\0�\0\0\0�\0�\0�\t�\0\0��\0\0\0\0\n\t��\n\n���\0���������������ߙ������������
��\t������\t�\0\n\0���\0\0\n�\0\n\n\0�\n\0\0\0�\0\0\0\0\0�\0�\t\0�\0\0\0�\n\t�\0\0\0��\n\0\0�\0\0
��������������������߽�������\t�\t\t\t������\t\0\0\0\0\0��\n\0\n�\t\0\0\n\0\t\0\0\0��\n\0\0��
\0\0��\0\0\nɠ\0�\0\0\0\0�\0���\0������������������������ٹ����ۜ�\r�������а�\n\n\0\n�\0\n\0\0���
��\t\0�\0\0\0
��\0\0
\0\0
�\0\t\n\0�\0����\0\0
���\0��������������������������������ɐ������\0\0�\0\n\0\0��\n\n\0�\0\n\t\0\n\0\0\0\n\0

���\0\0\nڐ\0\n\0��\0\0\t\0頠\n������������������ߟ��������������ټ��\t韛���٩�\0\0\0\n\n\0\0�\0\0ࠠ�\n�
��\n\n\n��\0\0��\0�\0\0\0\0���\n\n\n
\n�\t\0\0������������������������������������ٿ�۝���ޝ��\0\0\0��\0\0�\0\0\0�\0���\0
\t��\0\0��\0\n�
��\0\0
��\0\0\0�\t���\0\0\n۝�����������������������������߽����\r���ٽ�ܽ�\0�\0\n\0\0\0�\0\n\0\n\0\n\n�\0���\0\0\n��\0\r��\n�\t\n���\n\0�\n\n\0\0\0�\0�����������������������������������ۿ��ϟ޿�ޛ�\0�\0\n\0\0��\0�\0\0��\0���\0\0�\0\n
��\n\n�\0�\0�\n�����\0�\0\0�����������������������������������������\r�˛ݰ���\0\0�\0��\0\0\0��\0\0\n
��\0�\0\0\n�\r\0\0�\0\0\n�\n
\n��\0�\0\0
���������������������������������������������ߟڟ\0\0\0\0�\0��\0\0\0\n\0\0
��\0\0\0\0\0\0����\0�\n\0\0�\0\t魭頬���\0������������������������߽����������������۟ޟ����\0\0\0\n\0\0\0\0\n\0�\t\0\0\n���\0\0\0\0\0�\0\0\0\n\0\r
\n\n�\0\0\0��\0
\n�\0�������������������������߿���������������������\0\0\0\n\0\n\n\n\n\0\0\0�\n\0\0���\0�\0\0�\n�\0�\n������\0���\0\0
��\n
�����������������������������������߽�����ߟ�����Р\0\0\0�\0\0\0\0\0\0\0\0\0\n\0\0���\0�\0��\0\0\0���\0�\0\t\0\0\n\0�������������������������������������������\t������������\n\n\0�\n\0\0\t\0�\t\0�\n�\0��\0\n\0\0\0\0������
\n\0��\0�\n\0\0\0�������������������������������������������������������\n\0\n\0��\0�\n\n\0���ɠ\0\0\0���\0\0\0��\0\t
\0��\0�\0\n\n��
��������������������������������������ڞ��ۜ�������\t��\0�\n\0\0\0���\t\0�\0\n\t�\0�\0\n\0\0𩠠�\0�\0\0\n\n\0�\0\n\0
����������������������������������������������������\t�
\0\n\0��\0\n
\0��\n\0\0�\n\0\0\0�\0\0��\0\0\0\n�\t\0\0\0\0\0\0\n\0\0�\0\0\n���������������������������������������\t���\r�����ڐ\0\n\0�\0\0�\t\0\0�����\0\0\n\0\0\0\0�\n���\n\0\n\0\0�\0\0\0\0\0\n\0\n\n\0\0���������������������������������������������\t�������\0�\n�\t\n\n
\n\0\0\0\0\0\0\0\0\0\0\n\0�\t\0\0\0�ښ\0\0\0\0\0\0\0\0\0\0\n\t����������������������������������������\t\t\t\r����ټ�\0\0\tࠠ�\0
\t\0��\0\0\0\0\0\0\0\n\0\0\n�\0\0�\r�\r\0\0\0\0\0\0\n\n\0\n\0
����������������������߹�������������ٰ�
�м�����
ɩ��\0\0\0ڰ�����\n\0\0\0\0\0\0\0\0���\t�\0\0����\0�\0\0\0\0\0\n\0\0���������������������������������������й\t����������

�\n\0\n\0���ڐ\0\0\0\0\0\n\0\0�\0\0\0�\0\0\0\0\0\0\0\0�\0\n\0\0\0\0\0\0�
���������������������۝��\t�����������\0�\t���К��\t�\0��\0\n\0�\0
����\0\0\0\0\0\0\0\0�\0��\0�\0\0\0�\n\0\0\n\0\0\0��\0\n\0��������\t�����������������ɹ\t��������������
��\t���Ϭ�\0\0\0����\0\0�\0\0\0�\0\0\0\0\0\0�\n\0\0\0\0\0\0\0\n\0\0\0\0\0
��
������������������������۟�Й��������\t���������\t�
\n\n\0\n\0\0\0\0\0\0\0�\0\0\0\0\n\0\0\0\0\0\0\n\t\n\0\0\0\n\n\n\0\n\0\0\0��\0���������ߛ\t��������������������\t��������\t��鐐�\0\t\t\0О�\0\0\n\0\0\0�\n\0�\0\0��\0\n\0\0\n\n\n\0�\0��\0\0\0\0\0\0\0�\0\0\0�\0\n\n\n
������\t\0�������������������\t���������\0\n�\0\0\0\0�\0\0��\t\t��\0\0�\0\0\0\0\0�\0\0\n\0\0\0\n\0\0\0\0\0��\0\0\0\0����\0�\n\0\0�\0\0\0���������������������������������������\t\r\0\0\0\0\0\0\0�\t\t�\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\n\0\0\n\n\n\0\0�\0�\0\0\0\0\0\n\n\0�\0\0\0�\n\r���������\n������������������А����������\0\0\0�\0\0���\r\0\0\0\n\0\n\n\0\0\0\0\n\0�\0\n\0�\0\0\n\0\0\0\n\0�\0\0\0\0\0\0��\0�\0��\0\0\0����������\r������������\0�\0\0\0\0�\t\t\r�����\t\0��\0\0\0\t\t�\t\t
�\0\0\0\n\0\0\n\n\0\0\0�\n\0\0\0\0�\0���\0\0�\0\0\0\0\0�\0\n\0\0\0\0\0\0\0�������\0\t\0�������������\t\0\0\0\0\t
\t
��������\0\t�\t���\t\0����\0\0\0��\0\0\0\0\0\n\0
�\0\0\0\0\0\0\0\n\0\0�\0\0\0\0\0\0\n\0\0\0��\0\0\0\0\0�������\t\t\0\r�������������А
\0����Ͽ�����\t\t\0\t��\t\0���\t�\0\0\0\0\0\n\n\0\0\n\n
\n\n\0��\0\n\0��\0\n\0\0\0\0\0\0\0\0\0\n\n\n\0\0\0\0\0\0\nߟ��\r\t\0�\0\0�������������������\t\t\t��߿����\t\0\t\t\t\t��\t\t�\0\0\0\n\0�\0\0\0\0
\0�\0\0\0\0\n\0\0\0\0�\0\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���ِ\0�\0\0\0
���������������߹�\t\t���ߟ�ې�\0���\t������\t\0\0\0\0�\0�\0\n\0\0�\0\0\n\0\0\0\0\0��\n\n\0�\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0���\0\t\0\0\t��������������
\tɐ\t�����������\0\t\t\t�����\t\0�\0\0\0\n\0\0�\0\0�\n\n\n\0\n\n\0\n\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����\t�\0\0�����������������������\t�����\r�\0\0\0\t\t��\0�\0\0\0\0\0\0\n\0\0\0�\0
\0\0\0\0\0\0\0\n\n\n\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0齜����\0\0\0
�����������������ڙ�П
���������\0\0\0\0\0\0\t\0\0�\0\0\0\0\0\n\0�\0����\n\0\0\0\0\0\0\0\n\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ߞ��ߞ�\0\0\0\t���������������ڐ�\0\t����������\r�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\n\n\0�\n\n\0�ʰ\0\0�\0\0\0\0\0\0\0\0\0\0\n\0\0\0��߿�\0\t\0\0\0���������߭����\t\0\t\t\r����߽�������\0\0\0\0\0\t\t�\0\0\0\0\0\0\0\n\n\n\n\n\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\0�\0\0\0\0����������ڝ\t\0�\t\0\0\0�������߿�����\t�\0\0�\0��\0\0\0\0\0\0\0\0�\0\0\0\0\0�\0\n\n\0\n\n\0����\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0�����\0\0\0\0\t����������\t\0�\t�𼞟��������߽�
��������\n�\0\0\0\0\0\0\0\0\0\0\0�\0\0��\0\0\0\0\n\0\0\0�\0�\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\t����������ߟ�۽���ߟ�������������
ɩ\0�\0�\0\0\0\0\0\0\0\0\0\n\0�\0�\0\0\n\n\n\0\n\0\n\n\0�\0\0��\0�\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������������������������
\0���\0\0\0\0\0\0\0\0\0\0\0�\0��\0\0\0\n\0�\0\0\0�\n\0\0\0\n\0\0��\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\t\0\0\0\r�������������������������������ۜ����\t\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\n\0\0���\0\0\0��\0�\0\n\0\0�\0�\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������������������������\t�\t\0��\0�\0\0\0\0\0\0\0\0\0\0\0\n\n\0\0�\0\0\0\0\0�\0\0��\n\0��\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������������������\t𐐐�\0�\0�\0\0\0\0\0\0\0\0\0\n\0\t��\0���\0\0\0�\0\0�\0\0\0\0��\n\n\0\0\0\0�\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\t���������������������������������\t��\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\n\0\0\0\0�\0\0\0\0\0�\0�\n\n\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������������߿�������������\0\t\0�\0\0\0\0\0\0\0\0\0\0\0�\n\n\0\n\n\n\0\0\n\0\0\0\0�\0\0\0\0\0�\0\0\n\n\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0������������������������������\r��\r�\0\t
\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\n\0\0\0\0\0\0\n\0\0���\0��\0\0�
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������������\t�\t�\tЙ\0��\0\0\0\0\0\0\0\0\0\0\0\0\n\0��\n\0�\0\n\0\0\n\0��\0�\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\n�����������������������������\0�К��\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0�\0�\0\0�\0\0\0\n\0\0\0\0\n\0\0\0\0���\0\0\0\r\0\t\0\0\0\0\0\0\0\0\0\0\0������������������������������\r�ې���\t\t\t\0\0\0\0\0\0\0\0\0\0\0\0��\n\0\n\0\n\0\0�\0\0\0��\0\n\n\n\0\0\n\0\n\n\t\0\0\0\t\0\t\0\0\0\0�\0\0\0\0\0�\t\tڝ���������������������������ۜ�\0ِ��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\0\0�\0\0\n\n��\0\0\0\0\0\n\0\n\0\0\n\t\0�\0\t\0\0\0�\0\0\0\0\0\0\0\0���������������������������������ڙ��\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\n\n\0\0\0\0\0�\0\0\n�\n\0\0\0\0\0\0\0\n\n\0�\0\0\0\0\0��\0\0\0\0\0\0\0\0
\t\t����������������������������
��\0����\0\t\0\0\0\0\0\0\0\0\0\0\0\0�\0\0
\0\n\0�\n\0\0\0\n\0�\0\n\n\n\0�\n\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0�\t\0������������������������������🜹\t�\t\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\n\n�\0\0\0�\0�\0\0�\0\0\0\0\0\0\0\0
\n\n\0\0�\0\0\0\0\0\0\0\0�\0\0\0\0��\t���������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0��\0\n\t�\0\0�\n�\0\0\0\0\0\0\0\n\0\t\0\t\0\0\0\0\0\0\t\0\0\0\0\t\0\0\0\t\0����������������������������\t�ڜ���\t���\0\0\0\0\0\0\0\0\0\0\0\0\t\n\0�
��
\t�\0\0\0\n\0\0\0\0\0\n\n\0�\n\0�\0\0\0\0�\t\0\0\0\0\0\0\0\0\0
\t����������������������������н���\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\r����\n\0\0\0�\0\n\0�\0\0\0\n\0�\n\0�\0\0\t\0\0\0\0\0\0\0\0�\0\0К���������������������������ߜ�������\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0������\0\n\n�\0\n\n\0�\0\0\0\0\0�\n\0\n\t��\0�\0\0\0�\0�\0\0\0\0\0\0\0\0�\0���������������������������
��ۛ���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\n�\0�\0\0\0�\0\n�\n\0\0\0\0\0\0�\0\n�\0\0\0�\0�\0\0\0\0\0\0\0\0\0�\t\t\t�����������������������������\t\t\r�\t\0��\0\0\0\0\0\0\0\0\0\0\0\0\0���బ��\0\0��\0\n\0�\0\n\n\n\0\n\0\0\0\0��\0\0\t
\0\0\0\0\0\0\0\0\0�\0\0\0�\r����������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\0
\0�\0\0\n\0\0\0�\0\0\0\0\0\0\0\0\0��\0\0\0\0\t\t\0\0\0\0\0\0\0\0\0\0\0\t\0��������������������������ߟ����\t���\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\n\n\n\0\n\n\t\n\t\n\0\n\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\t\0\r����������������������������\r����\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0����\n\0�\0\0\0\0��\n\0�\0\0\n\0\n\0\0\0\0\0\0�\0\0\0\0\0\0\t\0\0\0\0\0�\t\t\0\0\0�����������������������������\t�\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��\0\0\0\0�\n�\t�\n��\0��\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0��������������������������������\t�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0Κ\0���\n

�\0\0���\0�\0\0\0\n\0\0\0\n\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0�\0�\0\0����������������������������\t��\t\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\t��\n\0\0\0�\n\n�ʐښ\n�\0�\t\n\0\0\0\n\0\n\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�\0\0��������������������������߯�
\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n
\t���\n\0��
\0\n�\n\0��\0\0\0�\0\n\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\t\0\0��������������������������ٙ\t�\t\t\0�\0\0\0\0\0\t\0\0\0\0\0\0\0\0
��\0\0\n\0�\0\0��\t��\n�\0\0�\0�\0\0\0\0\0\0�\t\0\0\0\t\0\0\0\0\0\0\0�\0\0\0\t\0�����������������������������\0\0\0\0\0\t\0�\0\0\t\0\0\0\0\0\0�
\n��\0�\n\n\0\n��\0�\0��\0\0\0�\n\0\0\0\0\n\0\0\n\0\0\t
\t\t\t\0\0\0\0\0\0\0\0\0\t\r�������������������������𚙭\t\0�\0\t\0�\0\0\0\0\0\0\0\0\0\0\t\0��\n\0��\0\0\0�
\0�頠\0�\0\n��\n\0\n\0�\n\0\0�\0\0\0���\0��\0\0\0\0\t\n���������������������������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0����
\0�\0�\n\t�\n��\0\0�\0�\0\n�\0\n�\n\n�\0\0\0\0\0\t\t\0��\0\0\0\0\0\0\0�����������������������������\t�\t\0\0�\0\0\0\0�\t\0\0\0\0\0\0\0\0��\0\0��\t�\0\t�\0���頰\0\0�
\0���\0\0��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0����������������������������\t\0��\0\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�\0\0\t�\t�
�
�\0\0ࠠ
��\0�\0��\0\0\0\0\0\0��\0\0\t\0\0\0\0\0\0�\t

�����������������������ِ���\t\0\0\t\t\0\t��\0\0\0\0\0\0\0\0\t
\n\n\0

\0\n
�
\n��\nˠ
\0\n\0\0\0\0�\0\0\0\0\0\0\0\0�ʐ\0\0\t\0\0\0\0\0\0\0

�����������������������\t�\t\0��\0�\0\0\0\0
\0��\0\0\0\0\0\0\0\0\0\0\n\0\0�\0�

�\0�\n
��\n�\0\n�\n\0\0\0\0�\n�\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0���������������������������\0\t\0\0�\t\t\0\t\t\0\r��\0\0\0\0\0\0��\n\n
\n\0���\0�\n�\0\0�\n�\0�\n�\0\0\n\0\n\0\0\0\t\t\0\0\0\t\t\t\0\0\0\0\0\0\0\0�\0\0����������������������
\0\t\t\0\t\0\0\0\0\t\0\0�\0�\t\0�\0\0\0\0\0\n\0���\0�\0��Э��\n\0�\0�\n\n\0�
\0\0\0\0�\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\t\0��������������������\tЙ\0\0\t\0\0\0���\0\0\0\0\0\0\t\0\0\0\0\0����
�\t��ʬ
���\0�\0\0\0\0\0�\0\0\0\n\t��\t\0\0\0\0\0\0\0\0\0\0\0\0\r\0��ɼ������������������٩\0\t\0\0\0\t\t\0\0\0\0\t\0�\t\0\0�\0\0\0��
��\n����
�\0���\t\0�\0\0\0�\0\0�\0�\0\0\t
\t�\0\0\0\t
�\t\0\0\0\0\0\0\0�
���\r��������������
�\t��\t\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\t\0\0�\t\n\n�����\0�\nʮ�ࠚ\0\0�\0\0\0\0�\0\0\0\0���\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t���������\r����\t���\t\t\0�\0\0\0\0\t\0\0\0\0�\t\t\0\0\0\0�\0\0\0�\0஺����఩�����\n��\0\0\0\0\0\0\0\0\0\0\n\0\0\t�\0�\0�\t\0\0\0\0\0\0\0\t\0���
Э
К���˜�\t��\0�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t
\t����
��\0�\0���\n�\n�\0\0\0\0\0\0�\0\0\n�\n\n����\0\0\t\0\0\0\0\0\0\0\0\0\0\0�\0��\t��\t\0�\t\0�\0\0\t\0�\t\0\t\0�\0\0�\0\0\0\0\0\0�\0\t\0\0\0\0\t\0\0\n�\t�������\0�̬�����\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\t�\r\0�\0�\0\0\0\0\t\0\0\0\0�\t\t\0\0��\0�\t\t\0�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\0\0\0\0\0\0\t\t���������\n\0���\0�\0\0\0\0\0\0\n\0\0\n\0\0��\0���\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\0\t\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t�\0�\0\0\0�\0������������\0����ɠ��\0\0\0\0\0\0\0\0\0���\0\0��\t\r\r��\t\0\0\0\0\0\0\0\0\0\0�\t\0\t\0�\t\0\0��\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t��\0�
�\r\r��������\0��\n
���\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�ښ\0�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0��\0����\0�������\0୬�
����\0\0\0\0\0\0\0\0��\n\0�\n��\r\r�\t�\0\t\0\0\0\0\0\0\0\0\0\0\t\0�\0�\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\t�\0\0�\t\r\t
\r\t
\tﮮ����\n��\0�\0\0\0\n\0\0\0\0\0\0\0�\0�\0\0\0�\0�\r��\t
��
\t\0\0\0\0\0\0\t\0\0\0\0\0�\0�\t\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\t\0\0\0\0\t\0���\0\0\t�\t
�\0���������
���\n�\0\0�\0\0\0\0\0\0\0\0\n\0\0\0\n\n\n��\r\r��
\r�\0\t\t\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\t
�\0\0\0\0\0�����\0�쮼����
��\n��\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\n\0���\0\t��\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\0\0\0\t\0\0\0\0\0�\t\0\0\0\0\t\0�\t\t\t\0\0\0���ɩ�\n���������\n\n\0\0�\0\0\0\0\0\0\n\0\0\n\0\0\0�\n\0\0\0�����\t�\r�\0\0\t\0\0�\0\0\t\0�\0\0\0\0\0\0\t\0�\0\0�\0\0\0\0\0��\0\0\0\t\0��\0\0\0М\t���\n\0����ϯ�������\0\0
\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n����\t\r��\t\0\0\0\0\t\0\0\0\0\0\t\t�\t\0��\0\0�\0\0�\0�\t\0\0\0\0\0\r\0�А\0��\0\t�\r��\0\0������
����\n\0�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\t\r���������\0\0\0\t\0\t\0\0\0\0�\0��\0\0\0��\0�\0\0�\0\0\0\0\0��\n\t
\0\0��\t
�\t����\t���������\0��\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\n\n�М����ڝ\0\t\0\0�\t\0\0\0\t
\0�\t�\t\t\t\0\0�\0�\t�\0\0���\0\0��А
\0\t\0\0˟\t�\0��ά������\0\0�\n\0�\n���\0\0\0\0\0\0\0�\0\0\0\0\0\0\n\0\0\0\t
�\r��\t��\0�\0\0�\t\0\0\0���А\0\0��\t\r\t\0\t\0�\0\0\0\0\0\r\t\0\t\0\t\0�ۜ������������������\0
\0\0\0\0\0�\0�\0\0\0\n\0\n\n\0\n\0\0\0\0\0���\0�����\0��\0\0\0\t�
\t\0�\0\t�\t�\t\r\t\t\0\0
�\0\0\0\t\0\0�\t
\0�\0���
\r�
���ڞ����������\n\n\0�\n\0�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������\t\t\0К���\0\0�

\0�𐞞�
\t\n��\t\0\t\t\0��\t\0\n\t���А���������������\0\0\0\0�
\0��\0\0\n\0\0�\n\0�\n\0\0\0\0\0�����\r\0���˚���\t���\0\t\0�\0����\r\nА�\0��
�\0\0��\t\t�\0�\t��\t�\t����������
\0�\0�
\0\n\0��\0\n\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n��
���\r\t�\t\0\t
�\0���\0\t\t���\t\t�\n�\t\t\r\t\t��
\0�\0�����������������������\0�\0��\0��\n\n\0\0\0\n\n\0\0����\n\n\0\0���\0�˛���ڜ������Щ�\t\t\0���\t\0�\t\0�\t
�А�\0��\t\r�
����\t�������\n�����

�\0�\0\n\0�\0�\0\0���\0\0�\0\0\0\0\0\0\0�\0\0��й��ɭ\n��\r\t����

��\t�\t�\t�ِ\t\0\t\0�ɐ���\t���\n��\r���
����������\0��\0�
�\0\n\0\n�\0�\0�\0\0�\0\0�\n\0�\0\0\0
�\n\n�
�ޞ�٩Аа\r˜����\0�О����\nА�\t�����ݺ����𼼺�����\n\n

�����
\0�\0�\0�\0\n\0�\0\0\n\0\n\0\0\0�\n\0\0\0\0�\n\0\r�\0
\0魹�٠�
�\t\r

�������\0\t\n
ޟ�\t\r����
ٚ�\r�
��\r�
�\n̬�\r
����������\0\n\0\n
\0�\0\0\0\n\0\n\0�\0�\0\0\0\0\0\0���
�\0��ɼ����������\tɭ�������ڐ�ɜ������ڝ����������\0�\n\0\0\n�����\n\0
�\0\n�\0��\0\0\0\0\0\0\n\0���\0\0\n\0�\0��\0\0\0�\0����
���
�ٞ���ɠ�\0��\0�˼��
��\r�˙��\t��ʬ
��\0\0\n\0��������\n\n\0�\0\0�\0�\0\n\0���\0\0\0\0\0\0\n\t\n\0\0�����\0�\n\0�ٜ�\t��\t����\tЭ��\r\t�\0���\tɼ�ߛ�������������Ь\t\0\n�\0\n\n������\0�\0\0\0�\n���\0\0\0
\0\0�\0�\0\0\0\0�\t\0�\0\0�\0\n\n\0\0\0\0
�\nа�\r
�������
���\r�\t��\0����������
��
��\n\n\0\0\n�
�����\0\n\n\0\0\0\0�\0\0���\0\0�\0��\0\0\0�\0\0\n\n\0\0\0\n\0\n\0�
�\r\r\r\t�\t��\t�\0���\t\t\0\t��\t�\r�����\r��\nܺ���\0�\0\0\n\0�\n\0������\n\0
\0��\n\0�\n\0�\0\0�\0\0\0\0\0�\n
\t\0\0�\0\0\n\0��\n\0\0
�
������н���\t\r�\0���\t������ښ��������\0�\n\n\n\0\n\n\0\n������\0\0\n\n\0

�ΐ\0\n\n\0�\0\0\0\0\0�\0\0
\n\0�\0��\0\0\0\0\0\0\n\n���ܜ\0��\nн���ڐ��\t����������
�������\0\0\0�\0\0\0����������\0\n\n\n�\0\0��\0\n\0\0\0�\n\0\n�\0\0\0\0\0\0�\n\n��\0\0��\tɩ�\t\0�ݞ����\r�О��ɽ����
۞�������\n���\n�\n\n\0\n
�\0�����\0�\0
\n������\n\n\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0��\n\0������\n�������ڟ��\t鿙�����
����\0�
\0\0\0\0\0\n\0�\n\n�������\n\0�����\0�\n\0�\0\n\0\0
\n\0\0\n\0\n\0�\n\0\0\0�
�\n\0\0�\n\t\r���\r�����������ߟ\t\n�����
��ɬ\n
\n\n\0��\0
\0\0�����������������\n\n\0\0\0\n\0\n\0�\0\0��\0\0\0\0\0\0\0\n��\n\0\0\n\0�\0��˩\t��
����ɩ��ߙ���\t魰
\r������\n\0�\0�\0\0\0�\n\0�\n�����\n\nμ������\0\0\0\0\n\0\0\0\0\0\0\0\0\t\n\0�\0\0\n\n\0����\n\0�\0
�\t���𐛐�۝����������ښ�μ��\n�

�\n��\r�
\n\0\0\n\0\0��
����\0���������

\n\0�\0\n\n\r��\0\0\0\0\0\n\n\0\0\0\0\0\0��\0\0�\0��\t�\0\n\0\n\0�\t\0�������\tＰ��\t��ɠ�
��\0�
\0\n\n\0�\n\0�\0�\0\n��������������\0\0\0\0\n\0�\n\0\0�\0\0\n\0�\0\0�\0����\0���
\0\0�\0�\0
\t\t
\n\0\tఛ\t�����ϼ��������������\n
\0\0��\0����
���������������ࠠ�\n\0\0��
\0\0\0\n\0
�\0\0\0��
\0���\0
�
�\0\0\0��\0��\t\n�\t��

�\t������ﭭ�������\n\0�\0���\0��\0\0
����������������\0�\0\0\0�\0\n\0\0\0\0\0\0�\0�\0\0\0\0���\0������\0\0\0���\0\n\0\0\n

��ڼ�����������������
�
�\0�\0�\0\n\n�����������������\n\n�\0�\0\0\0\n\n\0�\n\0\0�\t�\0\0\0\0�\n\0\0����\0\0�\t�\0��
\0����𰰼�\t�����������������\n\0
\n\n
\0�
\0�\0�����������������\0\0
\0��\n�\0\0\0\0��\0�\0�\n\n\0\0\0\n\n\n��\0�\0\0\0���\0\0���\n���
�������������������

\0\0\n\n\0��\0����������������\t�\0�\0\0\0\0\n\0\n\0\0����\0\0\0�\n\0
\0���\n��\0�\n\t\0��\0\n\n���
����������������������\n\0��
\n\0
�����������������\0�\0\n\0\0�\0\n\0\0��ʐ\r�\0\0\0\0\n\0\n�\n\n\0\0��\0����\n\n\0\0��\t�����������������������\0�
\0\n\0������������������ʩ\0�\0�\0\n\0\0�\0\0�\0��\n\0
\0\n\n\0\0\0��\0\0�\0\0��\0\0\0�\t\0\0��\n\n��
����������������������\n\0଼��������������ں\0\0�\0\0\0�\0\0\0\0\0
\0\n\0��\n\0\n\0\0\0\n\n����\0��\n\0�
\n\0�\n\n
��\0\n�������������켿��������\r�\0\0����������������
\n�\0\n\n\0\0\0\n\n\0�\0\0\0\0\0\0\0�\t\0\n
\0\0\n\0\0\0�\t\0�\t\t\0\t\0�\0�
\t\0\n�������������
���������
�\t����������������\0�\0��
�\n\0\0�\0�\0\0\0\n�
\0�\0\0\n\0�\0\0\0������\0��\0�����\n�\n\0\n��
���������������������\0��\n���������������שׂ��\n���
\0\n\0\0�\0\0\t\0\0�\0\0\0�\n\0\0\0�\0\0\0\0\0\0\0\n�\0\0\0\0\t\0\n\0\0\t\n\t\0�����������������������
\r\n�������������������
\0����𠠠�\0\0��������\0\0\0���\0��������������������\n�����������������������୮����������������\nʠ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0p��','Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company.  After completing a course entitled \"Selling in Europe,\" he was transferred to the London office in March 1993.',5,'http://accweb/emmployees/davolio.bmp'),
  (8,'Callahan','Laura','Inside Sales Coordinator','Ms.','1958-01-09','1994-03-05','4726 - 11th Ave. N.E.','Seattle','WA','98105','USA','(206) 555-1189','2344','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0 T\0\0BMT\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�S\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0�\t\0\0\0\0\0\0\t\t�\0\t\0\0\0�\0\0\0��������������������������������������������������\0�����\0\0�\0�\0А\t\0�\0\0\0\0\0\0\0��\0\0\0\t\0\0�\t�\0\0\0\t\0\0��\0\0������������������������������������������������
\r\t\0����\0\t\0���\0\0\0\0�\0\t\t\0\0\0�
\0\0\0\0\0\0�\0\0�\0\0\0\0\t\t\0\0\t\t�������������������������������������������������А
\0\0��\t\0\t\0����\0�\0\t\0\0\t\0����\0\0\0\0\0\t�\0\0�\0\0\t\0\0\t\0\0\0�������������������������������������������������鬐\0�\t\t
�\0\t�\0����\0\0\0\0�\0�\0�\0\0\0\0\0\0\0\0��\t\0\0\0�\t\t\0\0����������������������������������������������������\t\0\0\0\0�\t\0\0�\0\t\t\t�\0���\0\0\t\0�\0\0�\0\0\0\0\0\t�\0�\0\0\0\0\0\0\t\t����������������������������������������������������\t\t\t\t\t\0\t\0���\0\t��\0\0\0\0\0���\0\0\0\0\0\0\0\0\t\t�\0�\0\t\0\0�\0���������������������������������������������������˿\0\0\0\0\0\0�\0��\0\0\0�\0\t\0���а\0\0\0\0\0\0\0\0\0\t��\0\t\0\0�\0�\0\0�����������������������������������������������������\0\0\t\t\0\0\0\t�\0\0\0��\t\0�\0
�\0�\0\0\0\t\t�\0\0\0\0\t\0\0\0\0\0\0�
�\t������������������������������������������������������\0\0\0��\t\0\t�
\t\t�\0\0\0��\t\0�\0\0\0\0\0�\0\0\0\0\0\0�\0\t\0\0\0\t\0\0����������������������������������������������������\0\t\0\t\0\0\0\0\0��\0�\t\t\0\0\t�\0�\0\0\0\t\0\0�\0\0\0\0\0\0\0\0\0\t\0\0�\0����������������������������������������������������\0�\0\0\t\0\0\0\0\t\r��А\0\t\0��\0�\0\0\0\0\t\0\t\0\0\0\0\0\0\0\0\0\0\0��������������������������������������������������������\0\0\0\0\0\0\0\0\t\0\0�\0\0\0\0\0\0\t\0\0�\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\t\0\t����������������������������������������������������\t\t\t\t\0�\0\0\0\0\0\t\0\t\0\t\0\0\0\0\0�\t\0\0\0\0\t\0\n\0\0\0\0\0\0\0\0�\0\t\0\t\0�����������������������������������������������߿���\0\0\0\0\0\0\0\0��\t\0\0�\0\0\0��\t��\0\0\0\0�\0\t\t\0\0\0\0\0\0\0\t\0��\0�\t�����������������������������������������������������\0�\t\0\0\0\0\0\0\0\0\t\0\t\0\t������\0\0\0�\0\0\0\0\0\0\0\0\0�\t\0�\0\0\t�����������������������������������������������������\0\t\0����\0\0\0\0\0\0\0\t�����\0\t�\t\0\0���\0\0\0\0\0\0\0\t\r�\0\0��������������������������������������������������\0\0\0����\0\0\t\0\0���\0�\t\0��\t\t\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t\0������������������������������������������������������\0�\0������\0\0\0\t
а�\0����\0����\0\0\0\0\0\0\0\t�\0\t\0\0\t���������������������������������������������������߼�\0\0����\r��\0\0�\r\n�\0\0𽠚�\0�\0\t\0\0\0\0\0\0\0\0��\0�\t\0�������������������������������������������������߯����\0\0����\t��\0\0���\0\0\0�\0�\t��\t\0\0��\t\0\0\0\0\0\0�\0\0\0\0
����������������������������������������������߭�������\t�\0����\0\t�\0\0\0\0��\0��\0\0\t\0\0\0\0\0\0\0\0\0\0\t\t�\0\0\t����������������������������������������럟�����������\0������\0\0\0\0\0\0\0\0\0�
\t\0\0�\0\0\t\t\0\0\0�\0\0\0\0\0\0\0\0�������������������������������������������������������\0\0\t\r���\0\0\0\0\0\0\0\0\0\0��\t�\0\0\0\0\0\0\0\0\n�\0\0\0\0\0\t\0
������������������������������������������������������\0\t\0\0\0���\t\0\0\0\0\0\0\0\0��\0��\t\0�\0\0��\t\0�\t\0\0\0\0\0\0\0\t�����������������������������������������
������������\0�\0�\0\0\0\0\0\0\0\0\0\0�\0��
\0�\0\0\0\0\0�\t\t��\0\0\0\0\0\0��۞������������������������������������������������߼����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������\0\0�\0�\0�\0\0\0\0\0\0\0\0��ɛ;����������������������������Ͽ��������
������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t
\0��\0�\0\0\0\0�\0�\0�\0\0\0\0\0\0\0\0\0�������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0�����\t\t\0\t\t\0��\0
����\0\0\0\0\0\0\0\0�����������������������������������߿߭�������������\t��\0\0\0\0\0\0\0\0\0\0\0\0�\t�\n�\0\t\0�\t\0\0��\0\n�\0\0\0\0\0\0\0\0\0\0�����������������������������߭���߿����������������\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0��\t\0��\0\0�\t\t
\0\t\t\0\0\0�\0\0\0\0\t\0\t�������������������������������߾���龛��������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\n�\t\0\0\t\t\t�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0
������������������������߿��������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
��\0�\0\0\0\0�����\0�\0\0\0�\0\0\0\0\0\0�齿��ߟ����������������������ﭽ�������������������А\0\0\0\0\0\0\0\0\0\0\0�\0�����\0�\0��\t�\0\0\0\t\0\t\0\0\0\0\0\0\0\0\0\t��������������������������ڿ�߹�������
��ߟ�����\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
\r�\t\0\0\0\0\t\0\0�\t\0\0\0\0\0\0\0\0\0�\0\0\0\t������������������������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0𜰚а\0\0\0\0��\t\0\0\0\0\0�\0\0\0�\0�\0\0\0����������������������������������˟����
���
\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\t\t\t\t\0�\0\0\0\t\0�\t\0\0\0\0\0\0\0\0\0�\0\0�������������������������\r�����ۛ�˝������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
\0��\t\0�\t\0�\t\0��\0\0\t\0\0\t\t\0\0\0\0\0\0���������������������������ڟ\r������������\t���\t�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t\t��\0\0\0\t\0\0\t\0\0�\0\0\0\0�\0\0\0\0�\0\t����\t�߿������������������������
����ɽ����\0���\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0����\t\0�\t\0\0�\0\0\t�\0\0\0�\0\0��\0\t\0\t\r������������������������������\t����\t���ڝ���
�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\t��
\0�\0\0\t\0\0�\0\0\t\0\0\0\0\0\0\0\0�\0�\0\0�������߿��������������߽�����������Н������\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t��А\0\0\t\t\0\t\0��\0\0\t\0\0\0\0\0\0\t\0\0\0\t�����������������������������
��


ڛ��\r�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\r�
\0\t�\0\0��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���\t�������������������\r����������ɽ�\r\t��\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\t
\0�\0\0\0\t\t\0\0\0��\0\0\0�\0\0\0\0\0\0\0\0\0\0\t\t��������������������������\r

���\0�����\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\t����\t\0\0�\0\0\0\0\0\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\t\0����������������߿�����ϟ����������\tа\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t�

\0\0\t\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t������������������ڛ�˹��\t�
�
�\tɬ��\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����\0\t\0\0
\0\0\0�\t\0��\0�\0\0\0\0\0\0\0\0\0\0\0\0\t\t
������������������\r�ޟ���������\t��\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t\t\0\t�\t����\0\0\t\0�\0\0\0\0\0\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\t
�����������������й�ڟ
���\t�������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0�\0��\t�\0\0\0�\n�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������߭�����������\r��٩\0
\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0��\0��\0\0\t\t\0�\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���������������
��\r��
�魩\nЛ\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0\0����
\0\0\t��\0\0\0\t\t\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�����������������ۭ\r������\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\0\0\0\0\0\0�\t�\t
��\0\0\0���\t\0\0\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������\t��

�

ۭ
��\t����\0
\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0��ڐ���\0\0�\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������������\r��𜐜������\t\tɹ�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\0\0\0\0\t\0\0�\0��\0��
\0\0��\t\0\t\0\0\0\t\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������\t���\r\t魩��

��ښ��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\0\0���\t\t����\0\t\0\0\0\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�����������ɭ����\t�м�ɭ\t�\t\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�\0\0\0\0\0�\0���
�\t\n\t\0\0\0�\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������
�\r\r
��
\t�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\0��\t


\0�\0\0\0\0\0�\t\t\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����٩�\r\t\r
Щ�
\t���\t���М���\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0𐰽��\t
�\t\0\0\0\0\0��\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������ۛۛ
�
А��\t\n��ɭ������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0��\r
˚����\t\0\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������˙\0�����\0ڛ\t\tɩ\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0��\t
��\0\t\0\0\0\0\t\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��������������\t�
\t\0�\t
��𼐰
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0����𾐚��\0\0\0\0\t\t\0
\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������߿韟\t
�ڜ��\t�����\t��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\0������\t\r�\t\0\0\0\0\0\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��������ߟ��\t\t\t\t\t\0�\t�ɬ�а�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\0����
���\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���������������\n����\t���\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t��������\n����\0\0\0\0�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������������
��\r\t\t\t\0��
��\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0���\t\t��˜\0��\0\0\0\0\0\t\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0
����������������
\n����\0��\t�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�𭐠������
��\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������ڞ���\t\0�
\t\t\n\t\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0��\n�\0�˟\0��\0\0\0\0\0\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���������ߟ�������\t�\0���\r�\t
\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\n�\n�\0���\t�\t\0\t\0\0\0\0\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������߭��\t��
\0�\t�\t�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\t��
К���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������۰�����\t\0\t\0\t\n��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\t\t\0𠠚��\t��\t��\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0
������������۞߼��\r
�\r�������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0��\t\t����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������߽����ۚ���۽��\t�\n\t\0\t\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\0����\0�\0���
\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������ڛ\n�����ڛɰ�����\t\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
�\t
�\t���\r\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���������������\r��
˽��ڜ\0
\t\n\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\n��\n\0��а��ڐ\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0����������\r��\t���\r���ڟ\r�\t
\t\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\0��\t\n����\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������\t���\t���˭�𚐞��\t\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�м𠩪�\t���\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�����������𐜐�й����\t�\t\0\0�
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0

\t�\t\0�м\tː�\0\0\0\0\t\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0
������߼��ِ�
\t
��\t���ڐ���\t\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\n\n

ɩ���\0\0\0��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������۟������А�ڙ����
�\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0��\0�\0\t
\0
\0���\0\0\0\0\0�\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\t������ߟ�������\t��ɰа��ۜ���\t\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n
\t\0\t�\0\n��\0�\t��\0\0\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��������������ې\tɩɭ\tɟ���\t��\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\t
�\n\0�\0���
��\0\0\0\t\n\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�����������\0���������������м�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t���\n��\t�\t��А\0\0\0\t\t\0\t�\0\0\0\0\0\0\0\0\0\0\t�����������٩�\t�\t\r�\t\t�\t\t��
�\r��\0\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0�ˠ\0\0\0���
\t\t\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��������ɟ�����\t\0������ڛϝ\t

\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t
\t��\n\0�

\t����\0\0\0\0�\0\t\t\0\0\0\0\0\0\0\0\0\0�����������������\0�\r\t\t\t��\t�\t\t\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0
�\0\n\n\0\0��
����\t\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0���ڟ��п�����������\t����ߐ��ښ\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t\t\t\0�\0��\n

\0��
\t��\0\0\t\0\0�\0\0\0\0\0\0\0\0\0\t������
�������
�ڟ\0�\0��\t�
�\t\t�
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\n\0��\0\0\n\0\0
˞��ɩ\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0����
��������\t������\t�\0������н�\t\t\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\t
��\n\0\n
\0�
\t���\0\0\0\0\t\0�\0\0\0\0\0\0\0\0\0�������\t������\0\t\t\t���\t�\0\t\r��ߩ�ڞ�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0��\0\0�\0\0���К��\0\0\0\0\0��\0\0\0\0\0\0\0�����\t\t\0����齛
���\t\t\0��\t\0����
\t\t\t\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0�\0��\0
\0\0\0\n�
\t���\0\0\0\0\0\t\0\0\0\0\0\0\0\0\t��\t\tК��������\r�\t
\t���\0\0\0\t
\0߽��ڜ�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�˰\n\0\n\0\n��О����\t\0\0\t\0���\0\0\0\0\0\0������������������\n�������\t�\0\t�\t\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0���\0\n\0�\0\0���\n�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��\t�����������\tڛ��\t��������К�\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0�\t��\0\0�\0\n\0�
�٭�\0��\0\t\t\t\t\0\0\0\0\0\0\0�ߙ\0��������ߟ��\t𽭩����\r\t�����
\t�\r\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\n�\n\0\0�\0\0

��ښ�\t�\0\0\0\0\0\0\0\0\0\0\0\0���������������К\t\t��\t�����\t\t\0���\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\n
\t�\0\n�\0\0��\t����\t\0\0\0\t\0\t\t\0\0\0\0\0\0
��ɐ����������\r
�������О�\t�\t�К\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t
�\0\n�\0\0\0\0\0\0\0���\r\t��\t\0\0\0\0\0\0\0\0\0\0\0����
��������ʐ��\t���
й


\t��
�


��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�����\0�\0�
\0\0\0��ڐ�\0�\0\0\0\0�\0\0\0\0\0
���ٹ���������\t���
��\r����
А�\0��\0�\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�
�\0\n�\0\0\0\0\n�
а���\0\0\0\0\t\0\0\0\0\0\0�����\tП������\0�\0\t
���������й頽�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t��\n\0�\0\0\n\0\0��\t\0�
\r�\0\0\0\0\0\0\0\0\0\0\0\t�����۩�������\t\0��\t�\r�\t����ڐ��\t�\t\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\t\0����
\0\0\0\0\n\0�
�����\0\0\0\0\t\t\0\0\0\0\0��������������ɼ�\tɰ\t���������\r�������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\n

\n�\0\0�\0\0\0\0\0����\t�\t\0\0\0\0\0\0\0\0\0\0\t��������������\r�����\t���˟����А\t\0\t\0\0\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0���\n��\0\n\0\0\0\n\0���
����\0\0\0\0\0\t\0\0\0\0
�����������������\t�����ｽ��驹��\t\0��\0\t\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\n��\0\t\0\0\0\0\0\n
\t���\0\0\0\0\0�\0\0\0\0\t���������������
\t�\0������������М�\t\0\0\t\0
\t\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\t��𠠠\0\0\0\n\t\0\n����\t\0\0\0\0\0\0��\0\0�������������߭��
��٩����������ɩ�����\t\0\0���\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\n�\n\0�\0\n�\0\0\0\0������\n�\0\0\0\0\0\0\0\0\0\0����������������\r������������۟���\r���\t\0\0�\t�
\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n���
\0��\0\t�\n\n\0\0\0\t\0����\0�\0\0\0\0\t\0\0\0\0
���������������ۚ��������������ޞ��
\t�\t\0\0���\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t࠰
\n��\n\n\t\t\0\n�\n
\t����\0\0\0\0\0\0\0\0��������������߼����\r
�����������˙\n��\0�\t\t����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
�
\0���\0
\0��\0\0\0\0\0��
�\0�\0\0\0\0\0�\0\0\0
���������������ސ�\t�������ߚ����𼞝�\0�\0\0\0�\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\n��\n\0��\0��\0\0\0�\0\t
��\t�\r�\0\0\0\0\0\0\0\0�������������������������������\t�\t�\t\t\0\0\t�
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\t
\0��\0

\n\n\n\n\0\n\n\n\t����\t\0\0\0\0\0\0\0\0
�������������ߟ�
Й\t����������𞐼����\n\0\t\t\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��
\n\0
\0�\0��\0\0\0\0\0\0\0������\0\0\0\0\0\0\0\0����������������н
����������
�
٩\t\t\t\t\t\0\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\t�\t\0��\0\n�\0\0\0\0\0\n\0\n\0\0�\0��\t\t
\0\0\0\t\0\0\0\0�������������������������޽�������ښ��\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t���\0���\0\0\0��\0\n\0\0�\n��\r\0���\0\0\0\0\0\0\0���������������\t�\tЙ��������۟����\t�А\t\t\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0�\n\0�\0��\0\0\0\0\0�\0\n\0\0\0\0���\0
\0\0\0\0\0\0\0\0�����������������\t��驭�����������
�٩\t�\0\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\n�\n\0���\0\0\n\n\0�\0�\0\0

���\0��\0\0\t\0\0\0\0������������������\nА�����˟�۟������\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0�\0�\n\0\0�\n\n\t\0\0\0\n�\0�\0������\n\0\0\0\0\0\0\t�����������������\0�
�������ٽ�߭�\t��\t\t\r�\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�����\0����\0\0\n\0\0�\0��\0\0��\t\0��\0\t\t\0\0\0
�������������������\t������޽����\t���\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�

\0\n\n\0\n\0�\0\0�\0\n\0
\n\0\0�
�
\0��\0\0\0\0\0\0\0\0�����˛
�������\tА������������ɭ
��М�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t��
\0\0\n�\n��
\0\0�\0��\0�\0�\0��\0�\t\0\0\t\t\0\0\0�������ٛ�������
�
�ɩ�����

��ڛڽ
����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\n����\n\0\n\0\0\0\0��\0\n\n��\r\0�\0\0\0\0\0\0\0\0����������������\t\t�\t�\t�\r\r\t������ڽ\t��\r
\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0����\t
\0��\0�\0\0�\0\0��\0\t�\0���\n��\t\0\t\0\0\0
����������������
����а�����ɩ��������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t��
\0\n\0��\0\0\n\0\0�\n\0�\n\0����\t�\0\0\0�\0\0\0�����������������\t�
\t
���\0���й����\t
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\r�������\n�\0\n\0�\0\0��\0\0�\0\t��
�\n\0\0\t\0\0\0\0�������\t\t������ٜ���ɼ������������ِ���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0���\t�\0\0�\n\0�\0\0\0\0\0\0�\0\0\n\0\0�����\t\0\0\0\0\0\0\0\t�����\0\0\0\t�������\t\0\t�\t\t���\0\t
�\t\t�\t��\t�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0

�
\n\t
\n\0\0\0���\n\0\0\0\n\0\0\0\n\0\0\0��\0\0\0\0\0\0
��\t
�\0\0\0\0\t������\0
\t
��\0\0\t\0�\0\0�����ڐ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t���������\0\0\0\0\0\n\0\0\0\0\0\0\n���
\t�\0\t\0\0\0\0\t��\0\t�\t\0\0\0��������\0
�\0�
�\0\0\0\0�\0������
\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\t\0�\t�
\0��\0\0�\0\0�\0\0\0\0\0\0\n\0\n\t��\0\0\0\0\0\0\0���\0�\0\0\0������ɠ�\0�\0�\0��\t\0\0\0\0\0\t\tА٩\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�ɰ\n������\0�\0�\0\0\0\0\0\0�\0\n�����\0\t\t\0\0\0���ڐ\0\0\t\0\0���������\t\t\n�\0\0\0\0\0\0\t��
\t��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\t�
�\n\0
\0\n\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0���\0�\0\0�\0\0\n����
\t\0���\t������\t\0А\t\t\0\0\0\0\0�\0�
\t霩\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0
\0����\0����\0\0\0\0\0\0\0\0\n\0\0\0\0�����\0\0\0�\0\0�������𩚜����������\0���\0�\0\t\t\t\t
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
а���\0\n��\0�\n\0\0\0\0\0\0\0\0\n\0\0\n\0����\t\0\0\0\0\0\0
���������۽�����
�\t�\t\0\t\tʙ\0ٜ��й
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\n
\n�ʰ�\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\n���\0\0\t\0\t\0\0����ߟ������������\0�\0�����ʙ\n\t\tɩʐ�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����\n�\0\n\0\0\0�\0\n\0\0\0\0\0\0\0\0\0\0\0��\0\t\0��\0\0\0\0\0\t��魠��\t��������
�
\t\t
�
�˙

\0��
\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r\n�
\0
\0���\0��\0\0\0\0\0\0\0\0\0\0\0\n\n\t�\n�\0\0�\0\0�\0������\0\0�ٹ����������\0\0������П\t�К�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�������\n\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0�\n\0\t\0\t\t\0\0\0\0\0\t���\0\0\t\t���߿�����\t\0\0\t\t\t�\t�����\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�
\n�\0�\n\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\n\n\0
\0\t\0\0��\0��
����۟��ߟ�������\t\t\0\0\0���\t\0\t\t\t\t���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t��\0�\0�\0\0\0\0\0�\n\0\0\0\0\0\0\0\0\0\0\0\0��\0\0�\0\n\t\0\0\t\t������������������\n\0\0\0\0\0\t���\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���렚\n\0\0\0\0�\0\0�\0\0\0\0\0\0\0\0\0
\0\0��\t
\t\t\0\0\0\0
����������������������\t\0�\r\0�\t\t\t\t\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\n���\n�\0\0\n\0\0��\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0�\t�\0\t\0\0\0���������������������
\0�\t\0�\t\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����\0�\0\0\0\0�\n\0\0\0\0\0\0\0\0\0\0\0
�\0�\t\0�\t\0\t\0\t\t������������������������\t����\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0���\0\t\0\0�\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\t\0��\0\t\0��������������������������\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\t\0��\n\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0
\n\0�\0\0��\t\t��\t������������������������\0\0��\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��
\n��\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0��\0\0\n�\0����\n�������������������������\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0
\t�\t\n\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\r\t\t\t\0�����������������������\0�\t\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\r�
\n\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\0\0�����������������������ސ\t\0��\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\n�����\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t�\r
\0\t�����������������������\0ڐ�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
�\n\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�����\t
���������������������\0
\t\0\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0���\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��А\0\t����������������������\t\0���\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\n\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�ڐ�\0�����������������������\0��
\t\0\t\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\n��\t\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t
�А\0��������������������ۚ\t\r\0�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0��\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���
\0��������������������������\t\0\0\t\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0���\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\t\t�\t��

������������������\t�ڐ\0�\t\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0�\0�\0\0\0\0\0\0\n\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����\0��������������������\t\0�\0�\0\0��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\n�����\t�����������������ڟ��\0\t�\0\t\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\0\0�\t��\n\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r
�\r�\t
����������������\t��\0����\t\0�\t\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����\n\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������������\t���\0\t\0\t\0\0\t\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����\t\t��������������������\0��\0�\t\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\t�\n�\n\t�\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������������ڐ��\0\t\0\0\t\t\0��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\t�\0\n\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0����
��������������������\0\0���\0��\0\t\t\0\t\0\0\0\0\0\0\0�\0\0\0\0\0\0�\0\0\0\t\0����\t\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\t��������������������\0���\t�\0��\0\t\t\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\t��\0�\n\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
\t������
�ڿ������������ސ\r\0\t\0�\0\0\0��\0���\t\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0�\0���\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0�����\t�\t���������������\t�\t\0
\0\t\t\0\0\t\t\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\t\0\0\0
\nа�\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������ڛ��˟�������������
�\0�\t\0��\0��\n\t�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\t
\r���\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\0\0\0\0\0�\0\0\0\0\0\0\n\0\0\0\0\t��\t�鰰������������������\0��\0\0�\0\0��\0\t\0\0\0�\0\0\t�\t\0\0\0\0\0\0\0\0\0
ڜ�\0\n\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0
ʜ�����\r��������������\t�\t\0�\t\0�\0��\0\t\t\0\0\0\0\0\0\0\0�\0\t\0\0\0\0�\0\0
\0\t���\t�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\n\0\0\n\0\0\0\0\0\t
������˚����߿�����：�\0\0\t\0\t\0\0\0\0��\0\0�\0�\0\0�\0\0\0\0\0\0\0�\0\0\0����\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\n\0\0�\0���
����߽�����������\t
\t\0���\t\t\t\t\0\n�\0\0\0\0��\0�\0\0�\0\0\t\0\0\0\t��\0��\0\0\0�\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0����\t\r�����������������\0\0\0\t\n\0\0\0\0\0\0\0�\0�\0\0�\0�\t\0\0\0\0\0\0
�\0\t\0����\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\n\0\n\0\0\0\0\n\0\0\0�\t���ݩ�ڟ�����߯���\0�\0\0��\t\0\0\t\0�\t\0\0\t\0\0��\0\0\t\0\0\0\t\n\0\0\0\t���\0��\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\n\0\n\0\0\0\0\0�\0\0\0\0�\t\0\n���������������ۜ\t\0�\t\0\0�\0\t\0\0\0\0\0\0\0\t\t\0\0\t\0�\0�\0\0\t\0\0\0\n��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\t������ڞ��������ۚ���\0\0\0\0\0�\0\0\0\0\t\t\0�\0�\0�\0\0\0\0\0\t\0\0\0�\0\0\0�
\t�\0�\0\0�\0\n\0\0\0\n\0\0\0\0\0\0\0�\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\n\0\0\0
\0��
���\t��魻￟���\0\0�\0\t\0\0\0\0\0\t\0\0\0\0\0\0��\0\0��\0\0\0\0�\0\0�
�Р\n\0\0\n\0\0\0\0\0\n\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0\0\0\0\n\0\0�\0\0\0\0\0�\0
\0\t
���������ߟ����
��\0\0\0\0�\t\0\0\0\0\0\0\0\0�
\0���\0\0\0�\0\0\t\0\0\0���
\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\n\0�\n\0\0\0\0\0�\0\0\0\0\n�\tట���\t���\t��������\t\t\0\0\0\0\0\0\0\0\0\t\0\0�\0�
\0\0\0�\0�\0\0\t\0\0\t\0�\t\0�
\0\0\0\n\0\0\0�\0\0\0\0\0\0\n\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\n\0\0\0�\t\t��\t������\r��������\0\0\0�\0\0\0\0\t\0\0\0�\0�\0А\t��\0\0\0�\0��\r��
\t�\0
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\0\0�\0�\0\n\n\0�\0�\t\0�\0�����\0\t\t
ɰ��\t\r��\0\0\0\0\0\0\0\0\0\0\0\0\0���\t\n\n�\0\0\0\0\0\0\0\0�

\0�\0\n\0\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0�\0��\0\0\0\0\0\0�\0�\0�
\0���

��\0���
ɭ��\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\0�\0��\t\0\0\0\t\0\t\0�

\0�\0\0\t\0�\0�\0�\0\0\0\0\0\n\0\n\0�\0\0\0\0\0\n\0\0�\0\0��\0�\0\0\n\0\0\0\0�
\0\0�����\0��\t����\t\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0���
�\0\0�\0\0\0�\0\0\0�\0�\0�\n\n\0\t\0\0\0\0\0\0\n\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\n\0\0\0\0\0\0�\t��
\r\n�\n�\0\t\t�\t\0\0�\0\0\0\0\0\0\0\0\0\0\0��\r��\0\0\0\t�\0\0�\n\0��

�\n���\n\t\0\n\0�\0\0\0\0\n\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\n\0\0�\0\0\0�\0\0\0�\0�\0\0\0�\t
������\0\t\0\0\t�\0\0\0\0\0\0\t\0\t\0\0\0\t\t\t\0��\0��\t�\0\0\0���\t���\0���\0\0\n\0\0\0\0\0\n\0\0\0�\0\0\t\n\0\0�\0\0\0\0\0\0\0\0\0�\0\0�\0�\0\0\0�\0\0\n\0\0
\0�����\0\n�\0\0\t\0�\0\0\0\0\t\0\0\r\0�\t\0\n\0а\t
��\0�\0\0\0\t\0\0\r�\n�ʚ
\t\0\n�\0\n\0�\0\0\0\0\0\0��\0\0\0\0\0�\0\0\0\0\0�\0\0\n\t\0\n\0\n\0\n\0\0\0�\0\0�\0\0\0\t\0�\r�\t�\0\0\0\0�\0\0\0\0\0\0\0��\0\0\0\t\t\t�\r��\t\0\t\0\0\0�\0\0��������
\0\0\t\0�\0�\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0\0\0\0�\n�\n\n\0\0\0\0\0\0��\0\0\0\n\0\0������\0\0\0\0\0�\0��\0\0�ɠ\0
\0������\0\0\0\0\0\t\0�\0\0�
\r\n
\0��\0�\0��\n\0�\0\0�\0\0\0\0\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\n�\0\0\t�\n\0\0\0\0\0\0\n\t�\0\0\t\t
\r�\0�\0\0�\0�\0\t\0�\0�\t\t\0\t\0��\t�\0\0\0\0\0\0\0��\0�
���ښ\t\0�\t�\0\0\0�\n\n\0\0\0\0\n\0�\0\0\0\0\0\0�\0\0\0\0\n\0\0\0\0\n\0�\0\0\0\0�\0�\0\0\0\0\0�\0\0\0\r���\0\t�\0ɭ\t\t��\0\0\0\0���\0
�\0\0\0�\0\0\t\0�\0\0驩��\0\0��\n\0\n
\n\0\0\t\0\0\0\0\0\0\0\0\0\0\0\n\0\0�\0\0\0�\0\0�\0\n\0�\0�\n\t���\0\n\0\0\0\n�\0\0��
�
���Ь�\t��\r\r
�\0
�\t\0\0�\0\0\0�\r\0\t\t\0�ڛ\0��\n\0����\0�\0�\0�\0\0\0\0\0\0\0\0\n\0\0\0�\0\0\0\0\0\0\0�\0\0\n\0\0\0\0\0\0\0�\0\0\0\0\0\n\n\0\n\t\0���\t��
�����\0����\t\r�\t\0\0\0\0\0\t\0�\0\0�����
�\0\0�\0\0�\n\0��\0�\0\n\0\0�\n\0\n\0\0\0\0\0�\0\0�\0\n\0\0\0\0\n\0�\0�\n\0\n\0\0\0\0\0\0\0\0\0
\t\0����\t��ɠ�����\0�\0\n�\0\0
\0�\0\0\n\0\r\0\0\t�\0�������\n��
\0�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0�
\0\0\t\0�\0\t\n\0\0\0\0\0\n\0\0\0\0\0\n\0\n
گ\n\0���\r��\0\0�\0\n�\0\0\0�\0\0\0\0\t\t�\t
\0��\t��\0\n
\0\0\0\0\0�\n\0��\n\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0�\0
\0\0\n�\n\0\0\0�\0\0\n\0\0\t\0\0\0\0\0\0\0�\t\0���Н\t�
��\0\0\t\0\0\t\0\0\0\0\0�\0\0\0��\t\n
��
�\t\0���
\n
\n\0\n\0\n\0\0\0
\n\0\n\0\n\n\n\0\0\0\0�\0\0\0\0\n\0\0�\0\0\0\0\0�\0\0\0\0\0\0�\0\0\0\0\0\0\n\0��\0����
�\n��\0\0\0\0\t\0\0\0\0��\0\0\t\t�\t\0�\t���\t
\n
\0\t��\t\0\0�\0\t�\n\n\0\0\0\0\0\0\0\0�\0\0\0\0�\0\0\0\0\0\n\0\0���\n\0\0\0�\n\t\n\0\0\0\0�\0\0\0\0\0��������\t��\0�\0\0\0\t\0\0\0\0\0\0\0\0\0\n�\0\0м��\t
\n\0\t\0��\0�\n\n�\0\t�\n\t\0�\0\0\0\0\0\0��\0\0\0\0�\0\0\0\0\0\0�\0\n\0
\0\0\0\t\0\0\n\0\0\0\n\0\0\0�\0\0\0\0\0\0����
��\0��\n\0\0\0\0\0\0\0\0
�\t\t\0�\t
������\0\0�\0��\0�\0
\t��\0\0\n\0\0\0\0\0�\0�\0\0�\0\0\0\0\0��\0\0�\0\0\0�\n\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\t\t�����\0\t�\0��Р\0\0\0\t�\0\0������а��\t\0��\0��\0��\n\0\n\t\0�\n\0\0\0\0\0��\0\0\0\0�\0\0\0\0�\0\0\n��\0\n\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n\n
��
\t�\0�\0\0\0�\0\0��\0��\tɩ
�\n

\t\n\n\0\0���\0�\0\0\t\0�\0�\0\0\0\0\0\0
\0\0\0\0\0��\0\0\0\0\0��\0\0\0\n\0
\0�\0\0\0\0�\n\0�\n\0\0\0\0\0\0\0\0\0\0\0\t\0\r��ଐ��\0\0\0\0���\t�а����\t�\0\n\0\0\n�\0\n\0��\n\t��\t\0\0\0\0\0\0\0\0\0\0��\0\0��\0\0\0\0\0\0\t\0����\0\0\0�\t\0�\0\0\0\0\0\n\0�\0\0\0\n\0\0\0\0\0



А\0\n��\t\t\r���ʞ�����
����\0\0\0\0\n\t��
\n��\0\0��\0�\0\0�\0�\0\0�\0\0�\0�\0\0\0\0\0\0\n\n\t\t�\0��\0\0�\0\0\t�\0\0\0\0\0\0\0�\0\0\0�\n\0\0�\0\0\0���\r�������ٽ�����\0\0\0\0\0�\0\0\0\0\0\n
\0�\n\0��\0\0\0\0\0�\0\0\0\0\n\0\0\0\0\n�\0\0\0\0\0\0�\0\0\n\n�\0\0�\0\0�\t�\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0����\r\r�����\r��཭�
\t�\0\0
\n\0��\0�\0\0�������\0\0�\0\0\0\0\0\0\0\0\n\0\n\0\0\t��\0\0\0\0\n\0��\n��\0
\0\t\n�\0\0\0\0��\0\0\n\0\0\0\0\0�\0\t\n\0\t\0\0\0\0��\r\tɬ������\n�������\0\0�\t\0\0\0��\0\0�\n�\n\0�\n\n\0�\0�\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\0\0�\0\0\0��\0�\n\0\n�\n\0\0\0�\0\0\0\0�\n\0\0\0\0\n\0\0\n\0���\n\t��\0�\0\0\r\t\n\0�\0�\0\0\0\0\t��\n\n
\0\0\0���\n�\t\0�\0�\0\0\0\0\0
\0\0\0\0���\0\0\0�\0\0\0\0\0\0\0�\0�\0��\0\0\t�\0�\0�\0\0\0�\0�\0\0\0\0\0\n\0\0\0\0\0\0�\0�\n\t��\n�\0�\n\t\n\n�\0\t\n\0�\0\0�\0\0\0\0���\0\0�\n\n\0��\n�\t\0\0��\n\0\n\0�\0\0\0\n\0�\0\0\0\0\0�\0\0�\0��\0\t��\n\n\0�\0\0\0\0\0�\n\0\0\0\0\0\0\0\0�\0\0\t�����\n\0�\0���\0�\t�\n\n\t\0\t�\0\0\0��
\0\0\0�
\0�����\t\0\n\n\t\0\0�\0\0\n��\0\n\0\0�\0\0\0\0\0\0�\0\0��
\0�\0\n��\0\0\t\n\0�\0\0\0\n\0\0\0\0\0\n\0\0�\n\0\t\t\0\0�\t\0\0\0��\0���
\0�\0�\0\0
\0�\0\0\0�\n\n\0\0�����\t�
\0\0\0�
��\0\0\0�\0\0
\0�\0\0\0\0\0\0\0\0\0�\n\0�

\0���\0�\0\0\0\0\0\0�\n\0\0�\0\0\0�\0\t\n\n\0
\t\n\0
\0\0\0��\n

\0���\t�\0\0\t\0����\0���\n\0\0\t\t��\0\n�\0�\0�\0\0\0�\0\0\0\0\0�\0\0\0\0\0\0\0\n\n\0\t
\n\0\0
\t\0\0�\0\0�\0\n\0�\0\0\0\0\0\0\0�\n\t\0�\0\n\0\n\0\n\0

\0�\0\t\0\0
\0�\0�\0�\0\n\0\0\t\0����
\t

\n\n\t��\t\n\n\0\0�\0\n\0\0\0\0\0\n\0�\0\0\0\0\0\0\0\0\t\0��\t\n
\0\0�\n\0��\0�\0\0\0\n\0\0�\0\0\n\0\0\n\n\0\0\0�\0�\0\n\0\0\n\n�\0���\0\n��\0\0\n\0\0\t��\0�\t�\0\n\0\0\t\0�
�\n\0\t\0\0\0�\0\0\0�\0\n\0\0�\0\0\0\0\0\0\0\0��\0
\n\t\0��\n\t\0�\0\n\0\0\t\0\t\0\0�\0\n�\0\0�\t\0�\n\t�\0��\0�\0�\0\0\0\0\n\n�\0\0��\0���\0\0\n\n\n\n����������\0\0�\0�\0\0\n\0��\0\t��\0\0\0\0\0\0\0\0\0\0�\0\t\n\0\0\0\0�\0\0\t\0\0\0�\n\n\0\0\0\n\0\0\0\n\0�\0\0\0\0\0�\0�\t\0\0\n\0\0\0\0���\n\0\0�\0��\0\0\0\0��\0\0��\0\0\0��\0����\0\n�\0\0\n\0\0\0�\0�\0\0\0\0\0\0\0\0\0�\0���
\0\0�\0�\n\0\0\n\0\0\0�\n\0\n\0\0�\0�\0��\n\t�\0\0�\0\0\0�\0\0�\0\n\n\0\t�\n\n\0�\0\0\n\t�����

����\n\t�\0\0\0�\0�\0\0\0�\0\0\0\t��\0\0\0\0\0\0\0\0\0\0�\0\0�\0
\0\0�\0\0\n\0�\0\t�\0\0�\0\0�\0�\0\n\0\0\0\0\0�\0\n\0\n\0\0\t\0\0\0�\t\0�\0\t\0\0\0��\0\0\0\n\0����\t\0\0���\0���\0���\0\0\0\n\0\0\n\0�\0\0\0\0\0\0\0\0\0\0\n��\0�\0�\0\n\0�\0\n\0\0�\0\n\0\0\0\0�\0�\0��\n\t�\0�\n\0
\0\0\0\0�\n\0\0\n\n\0\0\n\0\0\0\0
\0\n\n\0��\n�
���\0���\0\t\0��\t�\0�\n\0\0\0\0\0�\0\0\0\0\0\0\0\0\0��\0��\n�
\0\0\0\0\0\0\0�\0\n�\n\0��\0�\n\n\0\0\t\0\t�\0\0\0\0\0�\0�\0\0
\0\0\t\n�\0�\0\n
\0�\t\t\0�\0����\n
\t\n�\n
\n\0\0����\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0�\0�\t�\n\0\n\0\0\0�\0\0\0\t�\0�\n\0\0\0�\t\0\0�\n\n\0\0\n��\0�\0\0\0\0\t\0\n�\0�\0�\0\n�\0�����\0����\n�\0\n\t��\0\0
\0\0\n�\0\0\0�\0\0\n\0�\0\0\0\0\0\0\0\0\0\0\0���\0��\0\0\n\0\0�\n\0�\0\n\0�\0\0\n\0�\0\n\0�\t\n\0\0\0\0
\0�\0\0\n\n\0\0\n
\t\n\0\0\0\0���\0�\t��\n�\t\t���
\0\n\t�\n\t���\0\n\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0�\0��\n\0\0\0\0\0\0\0\0\0\0�\n\0�\n�\0\0\n�\0\0\0\0���\n\0\t\0\0�\t\0�
\0\0\n��\0\0��
\0�\n\0\n\n\t�\t���\n\t�
\t��\t�\0\0��\0\0�\n\0\0�\0\0\0\0\0\0\0\0\0\0����\0\t\0\0�\0\n\0\0\0\0�\n\0\0\0\0\0\n\t\n\0\n�\n\n\0\0\0�\t\n\n\n\0\0\0\0\0\0\0���\t�\0�\n���\t�����\n�\0����\0�\n
\0\0���
\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\t�\0��\0\0\0\0\0\0\0\n\0�\0\n�\0\0�\t\n\0�\0\0\t\0�\n\0\0�\t\0\t
\0����
\0���\0�\0\0\0��\n\0�\n������������\n��\0��\0�\0\0�\0�\0\0\0\0\0\0\0\0\0�\n�\0�\0\0\0�\0\0\0\0�\0\0\0�\0\n\t�\t\n\0\0\n�\n\0�\n�\n\0��
\0�\t\0\0\0�\0\n�\0\0\0\0����\n�\0\0�\n����\n�\n\t�\n\0\n\0\0\0��\0�\0\n\0\0
�\0\0\0\0\0\0\0�\0\t\0\0�\0�\n\0\0\0\0\0\0\0\0\n\t\0�\0�\0\n\0\0�\0\n\t\t\0\0\n\t��\0\0�\0\n\0���������\t\0\0\0�����\n������
\t�
\t\n\0\t����\0\0\0\t�\0\0�\0\0\0\0\0\0\0\0\0\0��\n\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0���\0
\t\0�\t\n\n\t�\t\0\0\t
\0\t�\0\0\0\n\0\0\0�\0\0\0�\0\0�\t\n\0\0\n���\0\0\t���
\0�\t\0\n\t\n\0���\0\0\0\0\n�\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\n\0��\n\0\0�\0\0\n\0�����
\n\0����


\t��
\0�\n\0�����

\t���
�\t\0
\0�������\0\n
\n\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\n\0\0\0\0\0\0\0\0\0\0
\0��\n\0\n\0�\0���\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0߭�','Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.',2,'http://accweb/emmployees/davolio.bmp'),
  (9,'Dodsworth','Anne','Sales Representative','Ms.','1966-01-27','1994-11-15','7 Houndstooth Rd.','London',NULL,'WG2 7LT','UK','(71) 555-4444','452','/\0\0\0\0\r\0\0\0!\0����Bitmap Image\0Paint.Picture\0\0\0\0\0\0 \0\0\0PBrush\0\0\0\0\0\0\0\0\0 T\0\0BMT\0\0\0\0\0\0v\0\0\0(\0\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0�S\0\0�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0���\0\0\0�\0\0�\0\0\0��\0�\0\0\0�\0�\0��\0\0���\0ٙٙ�����������ٝ���ٙ����������������۟��������������۝����������ٽ���ٙ���������������ٝ�ٙٝ��ۙٙ�����ٙ����ٟ����������������������������������ߝ�����ݝ��ݽ����ٝ��������ݙ���������ݙ���ٝ�ٙٙٽ������ݝ�ٙ����������������ߙ�ߟ�������������ߝ�ߝ�������������ٝ���������������ٛٙ�����ٙ��������ٛ�����ٙ�ٟ��ݝ���������ߟ��������������ߙ���������ݝ����ٟ���������ٝ���������ٙ��ٝ�����ٝ���������۝�����ݹ���������ٝ�����������������۝���������������ٙ��ٝ�������������ݟ����������������ٝ�����������ݝ��������������������������������������������������������������ٹٙ��ٝ���������ٝ��ٝ����������ߝ��������۝�������������������������ٽ�������������������������������������ٽ���ٝ��ٝ�ٙ���������������ٝ�ߝ��������������������ݝ���������ٙ����������������ٝ������ٙ�������ݝ�����ٙ��ݝ��������������ݽ������������������������������������ٝ���������������ٙ��������ۙ���ٝ��۝���ݹ�����������������ߟ������������ݝ�����ݝ�����������ٝ��������������۝���������ߝ��ٝ��ݹ��ٝ�������۟������������������������������������ٟ���������ٙ����������������ٙ��ٙٝ�۝�������ٝ��������ߝݝ�ٽ������������������������ݽ�����ߟ������������ٛ�������ݝ��ٟ����������������������ٝ��ٹٙ�������������ݝ��������������ٽ�������������۝���ٝ�ٟ�������������ۙ�����������������ٙ�����ݽ��������������������������������ݝ����ߝ���������������������ݝ���ݙ�ٝ�����������ٝ�������������������������ߟ�����������������������������ݝ����������������۝����������������������ٙ���������ݝ�ٝ��������������������������ݝ����ݝ�������۝��ٝ������ߝ��������ٙٙ�������������ߝ���ݛٙݝ�����������������������������ݝ��۟���������ݹݙ���ٙ�������������������������������ٙ�����ݙߙ�ߝ�����������������������������ݝ����ݝ������ٟ��ݙ����������ݝ�����ٙٝ�����������ٽ��ٽ��ٙ����������������������������������۟���������������������������ۛ۝����ݙ��������������ٙٽ��ٽ��ٟ�����������������������������������ݝ����������������ٙ����ݝݝ������ٝ����ٝ�ݽ��ٽ�������ٙ�ߝ�������ݟ��ߟ�����������������������������������ٙ��ٽݝ�������ߛ��ٝ���ߝ�������ٽ�ٝ����ٽ�ݙ�������ٛ���ٝ����������������������ݝ���������ݝ�����ٹ����ݝݽ�ݝ���ٙ�����������ݝ�ٛ�ݽ�ٙ۝����ݝ��ݟ���������������������������������������������ݝ�����������۝��ٝ����������۝�����ٝ�����۝���ٛ���ݝ������������������������ݝ�������ݹ���ٝ��������ݽ��������ߝ������������������������������������������������������ٝ������ݝ��ݝ�����ݽ����ݝ������������ٽ���������ٝ������ٽ��ٙ������������������������������������������ٟ��������ٽ��ݹ������ߝ������ݽ�����������������ٙ��ߝ����������۟������������������������������ٝ���������۝������������ٝ���ߝ�ݝ����ٝ��������ٙ���ٝ����۝���������������������������������ٙ����������������������ݟ����ߝ���۟�����ٝ�����۝��ٝ������������������������������������������ߝ���ߝ����ݽ���������ٽ������ߝ�����ݝ�����ٝ���ٙٛ�ٝ��������ߝ�����������������������������ۙ�ٙٝ�ݟ��������ݝ�ݝ���������ߝ����������������������ٝ�������ٟ������������������������������ݟ�ݹ۝�����ٝ�����ݹ����������������ݝ���������ٽ���ٝ���ݝ����������������������������ݝ�������ٝ����ߟ�����������ݝ�����������������������ٝ����ٙ��ٙٽ�����ٽ������������������������������ߝ��ٟٝ����������ٟ���ݟ��ݽ�����ݝ��ݝ��������ٝ���ٝ�۝���ٽ����������������������������۟����ٝ��ٝ������۟�ݝ����ߛݝ�������������������۝�����ٙ������ٽݽ����������������������������ݝ�����ٝ�ٟ����ٙٝ����������ߝ�����������ٝ������ٙ����ݝ������ٹ�����������������������ߝ���ٙ���ٝ��ٝ�ٟ�������������ݽ����������ߝ����������ٟ����ٹ��ٹ�ݹ�����������������������������ߝ����ߙ�ٹ�ٝ�������ߙ���������ߝ�����ݽ���ݙٽ������ٝ���ݹ��ٝ��۟����������������������������ٝ����ߙ���ٙ����ٝ����������ݽ�����ߝ���۟۝�ݽ��ٟ��ٙ�����ٙ���������������������������������������ٝ�ٙ�������ٝ����������ݽ��������ߝٝٝ���ݝ��۝�������ٝ��ٟ���������������������������������ٟ۝��ٙٝ�������������������\0��ߟߝ���ߝ�����������ٝ������������������������������������ݽ��������ٝ���������ݝ������ߟ������ߟߝ�����۝��ٝ��ٝ�������۝�����������������������������ݝ�������ݙٝ���۝���ٟ������ߟ������\t�����������ߝ��ٝ��ٝ�������ٝ����������������������������۝�������۝�ٙٝ��ߟ����������ݟ������ٙ�������ٝ��ٝ����������������������������������������������ٝ���ٙ�ٽ������������������������
\0Л������ߟ�����ٝ����ٹ��ٝ��ٝ�ߝ�����������������������ݽ�����ٟ����������ٝ���������ߟ�������\t�\t����ݙٝ�����ٙ����ٙ��ۙ��ٝ��������������������������ݹ��ٝ������ٽ���۝��ٽ����ݽ���ߟ������\0��ߝ�������ٽ���������������ٟ������������������������������ٙ�ٝ���ٙ���ٙ����������������\0�\t��\t����ٝ�۝��ٝ�ٙٙ���ٝ���ٟ������������������������������ٽ����ݝ����۝�ݹ�����������������ڝ\t\0\t��������ٹ����ٙٙ���������ٟ�����������������������������ٙ�ٙ���ٽ���ٝ����������������\0˙\t��\0\0��������ٙٝ�������������ٹ���������������������������������������ٝ�ٽ�ߝ����������������\0�\0\0�����ٟ���ٙ���������������������������������������������ٙ�����ٙٝ���ٟ����������������ڐ����\0\t\t\t����������������������������������������������������ٙ��ٙٙ���������ٝ���������������\t\0\t\t\t\0�\0�\0���ٙ����������\t�������������������������������������ٙۙ��ٙ�ٙ�����������ߟ��������������\0\0\0�\0���������\t�����\t���ٙ�������������������������������������������ٙ�ٙ����ݽ�����������\0\0
�
\t\0�\0\0\0�����������\t\t\t������������������������������������������������ٙٙ�������ݿ����������\0\t�\0�\0\0\0\0\0\0\0\0\0\t����������������������������������������������������������������ٽ�������������������\0��\0\0\0\0\0\0\0\0\t�\t\t\t�\0\t\t��������������������������������������������������������������������ܝ\t\0��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0���\0\t\0����������������ߟ��������������������ٙ������\t����������ٽ���������ɩ��\t\t\n\t�\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t����������������������������������������������\t����ٛߟ���������\t�����
\t\0\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0����\t\t������������������������������ٝ�����\t��������������ٽ�����\t������\t\0
\t\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t\t\t������������������������������������ٙ\t����\t\t\t\t������������\t\t\0\t
�����\0�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\t�\t�����������۽��������������������������������������������\0\t\0��\r
\t\t\r\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t��\t�\t���������������۽�������������������\t�\0�\t����ٙ�����ِ\t\0\t\0\t\t������ڐ�
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t����
�������������������������������\t���\t�����������ٙ��\0\0�����\t\t�\t�\0�\0\0\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��\t��������������������������������������������\t������\t\0\0�\0\t\0\0�
��\t\t�
�\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�������
�����������������������������\t��\t\t\t���������\0\0\0\0\0\0\0��\0�\0�ِ�\0
�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t����\t\t�������������������۟��������\t�\t\t���������\0\0\0\0\0\0\0\0\0\t\t�\t\t����\0\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t����������������������������\t��\t����\t\t�����\t\0\0\0\0\t\t\t\0�\0\0�А�\0��\t�\t\t
�\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���\t\0������߿�������������������\t�\t\t\t���\t�\t���\0\0\0\0\0\0\0\0\0\0\t\t��\t��ː�\0\0�
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0����������������������ۛ��\t\t�\t���\t\t����\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\t\t���\t\t\t\t��\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\t\t\t���߽�������ߟ��߿����������\t\t��\t\t�\t\0\0\0\0\0\0\0\0\0\0\0��\0\0��\t����К\0\0\t\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������\t\0\t\t\t�������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\n��\0�\r��\0�
\0�\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\t
�����������۟�����������\t\t���\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\0�\r����������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������������\t\t\0\0�\t\t\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\0\0�\t
��
�\t��\t�\0�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������ٟ����ۛ�۟����\t\t\0�\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\n����ː��\0��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\r����۹����������߽���\t\t\0\0�\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\t\n��
������\t\0\t\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������ٛ�ۛ������������\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��\t\t\r��\0����\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
������ٹ��������������\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\t���˝�
\0�\0�\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������ۛ���ߛ���������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\t\t\t�\t���\t\0������\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����ٹ����������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t�����\t\t\0�\t\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
�ۛ�������߿����ۛ�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\n�Кٟ����\0�\t��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�۽��ۛ����������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\t\0\0�\t
�������\t��\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��ۛ�����߿������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0��
����
\t\t
\r
\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�۹�۟�������������۹��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\t\0\t����
��\n���\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t������������������߽�ۛ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�\t\n�\0����������\t�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�����������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0��\0\n�\0�\0����\t��\0�\n���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0���\t������������������ې\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0��
\0\0��\t\t\t���\t�\t\0\t\0�\t
\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0\0\0\0\0
���ٿ������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0�\t\n\t�����ٛ����\0\n��\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0������߿����������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0�
\t\t����\0�
�\0�\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0������������������������\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��\0��\0К����\0���\t\0\0�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n���\0\0\0�������������������߿����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0�\0\0\t\t\0\t�����鐟

\t\0�\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t���\0\0\t�ٹ������߿��������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�\0\t\t\0\0\t
��ޟ��������\tʐ�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\0\0��۟���������������������\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0��\0����ɽ��\t\t
\n�\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t����\0\0\t������߿������������߿����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\t\0��\0\0\t�
������А���\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0��\0\0��������������۟����߿�����\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0�������˜����ښ\t�\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����\0\0\t�����������ۙ�������������\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0����
\t
��ݿ�����
��\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\0\0�������߿�ۙ�ۛ������������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0�\t\0�������\t��\t�����\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0�������������߽�������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t\0�\t\t���������
���\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0���������������۽�����������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��\0�\t
��������\0���\t��\t\n�\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t
��ɼ���������ڰ\t���\t�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0
߿�������ۙ������������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\n��
��\n���ߟ�ߛ�\r���\t��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������\t�\t������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\t\t�
йɝ�������
����\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
���������������������\0\t�������\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0������
�����𐻰����\t
\t�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���������\0�����������\0\0�������\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t�
й
�
\r������
�\t\t������\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0������ۙ\0\t
����ٹ��������������\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t
Щ�ڐ���\t��\t��\n��\0�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������\0\0���������������������\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0�
�\t����������
��\t�ۚ���\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0���������������������߿���������\0\0\0\0\0\0\0\0\0\0\t\0\0\t\n���
��������\t�\t��������
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����۽����۟��������߿߿��������\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\0�\r���

��˫���
\0�����\t����\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t���۽�����������\t���������������\0\0\0\0\0\0\0\0\0\0\0\0\n�\0���\t�������\t
�\t��\t\t�\0���\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0
��������������𙟛�����������߿��\0\0\0\0\0\0\0\0\0\0\0�\0\0\t�𽯟\t������\n���\0\0\t
����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0������������������������ۙ��������\0\0\0\0\0\0\0\0\0�\t\0\t\t�\t������
\t�ߚ������\t�\0�
\0�\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������ۛ��������������������ߟ���\0\0\0\0\0\0\0\0\0\t\0\t\0\0
����𐐐ڼ����\0\0\0���\0\0\0���\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�����ۛ�����������������������������\0\0\0\0\0\0\0\0\0\0\0\0�\0����\0�\0��������\0\0\t��\0\t\0\0\0\n\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������������������������\0\0\0\0\0\0\0\0\0\0\t\0\0\t�\t\t������������\0\t��\0\0\0\0\0�\t\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����ߟ�����ߟ�������������������������\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0��\t\t\t\t
��ٙ���\0\0\0\t\0\0�\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��߽����������������������������������\0\0\0\0\0\0\0\0\0\0\0\t\0��\t�\0\0�\t�\r������\0\0�\0\0\t\0\0\n\0\t���\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0����������������۟��������������������\0\0\0\0\0\0\0\0\0\0\t\0\0\0韞���\r��
�
ۿ\0�\0�\t�\0\t�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0\t\0���\t��ۙ\r\t�٭�\0\0��\0\t\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������������������������������������ߐ\0\0\0\0\0\0\0\0\t\0\t\0\t
�ޞ���\0������\0\0\t\t��\0\n\0\0\0��\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0
��ۛ�����������������������������������\0\0\0\0\0\0\0\0\0\t\0\0
�����\tߛ\0�
��\0�\t�\0\0�\t\0\t\0\0\0�\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���������������������������������������\0\0\0\0\0\0\0\0\0\0\0\0�
\t\t

����\t����\0\0
\t\0\0\t�\0\0\t\t\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0�߹�������������������������������������\0\0\0\0\0\0\0\0\0��\t\t�
\r��\t���
\t\t\t\t�\0\0�\n\t\0��\0\0�\n\t\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0��ۛ�������������������������������������\0\0\0\0\0\0\0\0\0\0��\t��\t�����\t\t\t�\t\0\0\t\t\0�\0\t\0��\t\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������������������������������\0\0\0\0\0\0\0\t\0\t\t��
\tې���\n�������\0�\0�

\0�\t�\0����\0\0\0\0\0\0\0\0\0\0\0\t�����������������������������������������\0\0\0\0\0\0�\0\t\n��\t��ܽ�����
\t���\0��\0\t��
\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����������������������������������������\0\0\0\0\0\0\0\0\0\t\n��\t���\r���ۚ��


\0��\t���ʐ\t\0���\0\0\0\0\0\0\0\0\0\0\0�������ߟ���������ߟ���������������������\0\0\0\0\0\0\0\t\0�����
\r�������\r���\0\t�\t\t\n�\t
\t\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\t�������������������������������������\0\0\0\0\0\0\0\0\t\0��\0���\r�����\r�ۛ���\0\0�\t�\n���
\t\t\0\0\0\0\0\0\0\0\0\0\0\0���\t�\t��������߹�����߽�����������������ٰ\0\0\0\0\0\0\0\t\0�\t����ɹ\r�����ٝ��\0\0�\t\t˩
���\t�\n\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\t\t\0������������������������ٹ�����������\0\0\0\0\0\0\t\0\t���
\r��\0���ߝ\t����\n�
�۩�\n�����\0\0\0\0\0\0\0\0\0\0\0
��\0����������������\t�����������ٽ���������\0\0\0\0\0\0\0\0�\t�ٰ����ٝ��\t��\t��\0\0������������\0\0\0\0\0\0\0\0\0\0\0\t���\0\0
����߽������\t�������ߙ���
����������\0\0\0\0\0\0\0�\t
\t�
\t�\t\0�������\t�\0��

����\0�
��\n\0\0\0\0\0\0\0\0\0\0\0\0�\r\t\t\0��������\t�������������𐟰�\t
������
�\0\0\0\0\0\0�\0�����������\t\r��\rߠ����
����\0�
\0�\0\0\0\0\0\0\0\0\0\0\0\t����\0
��������\t\t\t��\t������ۛ��\t\0\0\t\0\r�����\t\0\0\0\0\0\0\0\0\t�\t\t됰��\t���\0�����\t��
\0���\n\0\0��\0\0\0\0\0\0\0\0\0\0\0\0�����\0��ߟ��\0\0\0\0\0\0�\0\t\t�ۿ���\t\t
\0\0�\0\0�����\0\0\0\0\0\0\0\0\0����\t������\0\t��\t
\n\t\0��
���

��\0\0\0\0\0\0\0\0\0\0\0����\0\0�������\0\0\0\0\0
�\0��������\t\0\0\0\0\0\r�����\0\0\0\0\0\0\0\0�\0��
�\t�����н�
�ۙ���\0�\n������ϩ���\0\0\0\0\0\0\0\0\0\0\0���\t\0\0\r�������\0\0\0\0\0\0�\t˛����А��\0\0��\t�����\0\0\0\0\0\t\0
��\tй\r\t\t�ə��\0������\0\n\0������������\0\0\0\0\0\0\0\0\0\0\t�\0\0\0\0
���������\0\0\0�\0����ߟ���\t����\0�����\0\0\0\0\0\0\0\0�\0����а�����\t�����ڐ
\t
���\0�������\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0�٫۹��\t�\0�\t\0\0�������ۙ
\0\0�\0\0������\0\0\0\0\0\0�\t\0�\t\t��\0\t
�
��������\t\0����\0�\0\t\t�����\0�\0\0\0\0\0\0\0\0\0��\0\0\0\0\t�ٹ\t\t\t�\t�\t\0�\t��������ۙ��\0�������\0\0\0\0\0\0\0\0�\0����\t���\t���ߚ�\t��\t��黩�
\0�\0�\0�
����\0\0\0\0\0\0\0\0
�\0\0\0\0\0���\0\0\0\0����\t���ۙ���۟���\0\t\0���
���\0\0\0\0\0\0\t\0���\t�\t���\t�߽��𐝐����ɭ
\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\0\0\0\0��\0\0�\t\0\t\0\0\0\0�\t�\t���������\0�\0\t\t\t
���\0\0\0\0\0\0\0�\t�\r�����ߐ�ߟߟ���\t\t
���
���\0\0\0�\t\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0��\0\t\0\0\0\0\0\0���۟���۽�\t\t\0\t\0\0�����\0\0\0\0\0\0\t\0��
\t������������������\0\n��\0\0\0\0\0\t�\n\0\t\n\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�

�\0\0\0\0\0\0\0\t\t��������ٚ��\n\0�\t����\0\0\0\0\t\0\0�\n�а\t\t���\r���ɜ����\t�\0\0\0\0
\0�\0\0\t\0�\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t���\0\0\0\0\t\0����ۛ�������������齽��\0\0\0\0\0\0
\0���\t������ٰ
�
����
�\0\0\0\0\0\0\0\0\n\0\0��\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����\t\t��\t��\t���ۛ����
����ې��
�\0\0\0\0\0\0
\0�\t
\t���\t����\t�\t\t
�А\0\0\0\0\0\0\0\0\0\0\0\0���\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t��\0\0�\0��\t����������������
�\t�\0\0\0\0\0\0\0�\r\t���ə
���\0
м��Й�\t\t\0\0\0\0�\0\0\0\0\0\0�����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��
�\0\0�����\t\t�����\0�����\t\t��\t�\0�\0\0\0\0\0\0\0��\0�龞�

\t�������\0
��\0\0\0\0\n\0\0\0\0\0\0������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t��\0\0\t
��\0\0�\t
���\0
\0����\0
\t\t
�\0\0\0\0\0\0\0\t���\t���鐐��\t�\r����\0��\0\0\0��\0\0\0\0\0\n������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\0\0�\0����\0\0����\0�\t��
ِ\0�����\0\0\0\0\0\0\t\0\0\t\r�𽟞\n����ڙ\t������\0\0
\0\0\0\0\0\0
\t���޿\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0�\t�\0\t\0���\t\0�\t
��\t\0�\t\t\t\0�\0\0\0\0\0\0\t\t�
\t\tЩ��
�\t�\tН��К��\0\0\0�\0\0\0\0\0\0�\0�
��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t�\0���\0\t\t��\t
��\t������\0\0�\0\0\0\0\0\0\0�\t\t\t��\t�
ڟ�
\t��
��
\t�\t\0\0\n
\0\0\0\0\0
\0\0\0\0
�\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0�\0�\t�\0��ڐ�\t��\0��\t\t�\0��\0\0\0\0\0\0\0\0\t����ڐ�������\r�������\0\0\0\0\0\0\0\0\0�\0\0�\t��\t�\0\r\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\0\t���\t\0���\0�۹\t�\0����\0\0\t\0\0\0\0\0\0\0\0�����\r�������\t������\0\0\0\0�\0�\0\0\0\0
�\n\t\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t�\0���\0\0\t\t\t\0\t���������\0\0\t\0\0\0\0\0\0\0\0��
\t�����ߙߟ�������
\0\0�\0�\0�\0\0\0\0\0���\0
�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\t�\0\0\0\0��\0\t��\t�\t��\0\0\0\0\0\0\0\0\0\0\0\0\0�\t����������
\t����\0\0�\0\0�
\0\0\0\0\0�\0\0�\0\t�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t\t\t\0��\t\0\0\t\t
\0\0\0\0���\0��\0\0\0\0\0\0\0\0\0\0\0\0\t\0
�����Й\t
��ۙ


���\0\0\0\0\0\0�\0\0\0\0�\0\0\0\0\t���
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t
\0
\0\0�\0�\0\t\t����\t�\0\0\t\0\0\0\0\0\0\0\0\t\0\0\t\t��������
\t\t�����\t�ɽ\0\0
\0\0
\0\0\0\0�\0\0\0\0\0\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����\t�\0\t\0���\0\t�\t\0\0\0�\t\0�\0\0\0\0\0\0\0\0\0\t\0�\0
�������\0��
���\r��\0\0�\0\n\0\0\0\0�
\0\0\0\0\0\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\t\0\0\t\0\0�\0\0\0\0\0����\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0���������\n�\t�������ɰ\0\0\n�\0\0\0\0\0
\0\0\0\0\0�\0�ɼ��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\0\0\0\0\t\0\0\t\0�\0\0�\t\0\0\t\t\0\0\0\0\0\0\0\0\0\0\0\t\0\0
�ސ�����\0���ڙ�����\0�\t\n\t\0\0\0\0\0\0\0\0\0\0�\0\t���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\0�\0\0\0\0\0\0\0\0��\0�\0\0\0\0\0\0�\0\0\0\0\0\0\0\0�\t\t\0��
����������������\0\0���\0\0\0\0\0\0\0\0\0
\0�\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0��\0\t\n�\0\t\t�\0\0\t\0\0\0\0\0\0\t\0\0\t\0\0\0\0\0�\t\0�\0\t��
������ߝ��\t�
���\0\0\0\0�\0\0\0\0\0\0\0\n\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\t\t\0�Й\0�\t�\t\0\t\0\0\0\0\0\0\0\0\n�\0\0\0\0\0�\0���\t�������߹��\r������\0��\n\0\0\0\0\0\0\0\0\t\t\0��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0��\t
\t�\0�ɐ��\0�\0\0\0\0\0\0\0\0\0\0\0\t\0��\0\t\t\0�������ۙ����\t��\0\0\0��\0\0\0\0\0\0\0\0��\0��\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�����\t���\0�\0\0\0\0\0\0\0\t\0\0�\0\0\0\0\n�\n\0\0�����������������\0\0�\0�\0\0\n\0\0\0\0\n���\t\0�
\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t��\t�\t��\t�\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0��\0������\tۙ��
�\t��\0\0
\0\0\0\0\0\0��\0\0\0\0\0\0��\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\0\t���\0�\t\t\0�\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\t��\0\0����ٝ�����������\0�\0\0\0\0\0\0\0

\0\0\0���\t\t\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\t
\0�\0����\0\0\0\0\0\0\0\0\0\0\0�\t\0\t\0��\t���������\t����\t\0�\0\0�\0�\0\0����\0\0\n\0\0�\0\0
\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0
\t\t\n��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\t
��\0���Л�����\t�ː�\t\0
\0��\0\0\t��\0\0\0\0��\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��\t\0\t\t\0\0�\0\0\0\0\0\0\0\0\0\0\0\0��\0\0��\n�\0�\0
��������
���\0\0��\0\0\0\n\0\0\0\0\0\0\0�\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\0\0���\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\t\t
\0���\t�\0����\t��\t���\0\0\0��\0\0\0�\0\n\0\0\0�\n���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0���\t\0��������м���\0�\0�\0\0\0\0\0���\0\0�\t\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\t\t\0�\0�\t���
����\tߙ\t����\0\0\0�\0\0\0���\n\0\0\0\0\0\0����\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\t�\0���\t
������\t����������\0\0\0\0\n�\0\0\0
�\0\0\0\0��\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\t\t�\r����������
\0�𿽿��\0\0\0
\0\0

\t��\n\0\0�\0\t�\0\0\t\0\0\0\0\0\0\0\0\0\t\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0�\0�\0��������\t��\t�߹\r�\t�\0\0��\0\0�\0�\t\0\0\t�\0\0�\0
\0\0�\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�
����������������鿭�\0\0\t��
�
\0\0\0\0\n\0\0\t\t\n��\0\0\0\0\0\0\0\0\0�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���
������ߐ������������\0\n�\0\t��\0\0\n\0\0\0��\0��
��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0

\t�������������\t������\0\0\0\0\0\t\0\0\n\t\n�\0�\0��
߼\0\0\0\0\0\0\0\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���鰟������\t�������\t\0�\0\0\t���\0\0\0\t\0\0\0\0�\0\t�\0��٩\0\0\0\0\0\0\0\0�\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0
�
������𛚞�\t�\0��\n�\t\n\0\n\0\n\0\0\n\n\0\n\0\n\0��
��\n\0\0\0\0\0\0\0\0�\0\t\0\0\t\0\0\0\0\t\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\tɰ\t\0\0��������\t�ٽ��

�ٚ\n\0�\t\0\0���\0�\t
\0����\0���\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0\t\0\n��������٭��А�\t\0\0
�\0\0���\t\n\n\0��\0\0
\t�\t�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\t
�������
ې�
ڻ\t��\0\0��\0\0�����\0�\0\0\0\0�\n\t�\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\t\0��\t\0\0\t������\t�����\tм��\0\t��\0\0�\t�\t\0
\0��\0\n\0\t���\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0�\0��\0��
������\n��
\r


��\0\n\0\0\0�\0���\t��\0\n
\0��\t�\0\0\t\0�\0\0\0\0\0\0\0\0\0\0\0\0
\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t\0�\0\0�\0\t\0\t��\n\0\0\t��\0����ː�\t\0\0\0\0\0�\0\0\n�\t�\t\0�\0\t��\0\0\0\0\0\0\0\0\0\0\0�\0�\0\0\0\0\t\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0
\t\0\0\0\0��\0\0\n\t\0�
��
��\n\0�\n\0\n
�\0\0��\n\t\0�\n
\n\t\t\0��\0\0\0\0\0�\0�\n\t\0\0\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\t�\n\0\0\0��\0\0\0\0\0\0\0\0�������
\0\0\0\0\0\0��\0�\0\0���\t�\t�\0\0\0\0\0�\0\0\0\0\0\0\0\t\0
\0�\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t�\n�\0\t\0\0��\0\0\0\0�\0\0\0�
�
��������\0\0\0\0��\n\0\t���
\n���\t\0
\0\0�\0\0\0\0\0\0\0\0\0\t\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�\t�\t��\0\0\0\0�\n\0\0�\t\t\0���
��\t\0��\0���\n\0
\n��

\t��\0\0�\0\0\0\0\0\0\0\0\0\0\n\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0��\0�����\0\0\0\0\0�\n\0\t\t��������\n
\0\t����
\0���\t�\n���\0��\0\0�\0\0\0\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0�����\t
\0\t�\0\0\0\0\n\n���\t\0\t�
�\t
\0���
����
��������\n\0��\0\0�\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n
\0����\0А�\t\0\0\0\0\0�\0�\t����\0����\t����\t��
�����������\0\0���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\n�����\t�\t
��\0\0\0\n

\t�\t�\0�\0������\t�
���\0�������\0\0\0�\0\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\0\0\0\0�\0\0\0\0\0\0\0\0�\t\0�����\0����\0\0\0\0\0\0\0�\t��\0\0\t�\r�\t�\n��
����������\t\n��\n�\t\0\0\t\0\0\t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0

\0\0\0\0\0\0�\0\0\0\0\0\0\0\0\0\0\0\0


\t
\r\t�\0�\0\0\0\0\0\t�\0��\t��\0\0�����
���\n�������
�\n�\0\0\n\t\0\0\0\t\0�\0\0\t\0\0\0\0\0\0\0\0\t�\0\0\0\0�\0\0\0\t�
\0\0\t\0\0\0\r\0��\0\t\0���А���\t\t
\0\0\0\0\0�\0
\n\n��\0\0\t�
�ڟ
���
\t��������\t�\n\t\t\t\0\0����\t\0\0\0\t\0\0\0\t\0\0\0\0\n���\0\n�\0\n\0�\t�\0\0�\0\0\n\0�\0\t\t\n�\t����\t�\r�\n\t\n\0\0\0\0\0
\0��\n��\0\0
�������������������ڐ\0\n\0��\0\n\0\t\0�\0�\0\0\0\0\0\0\0\0\0�\0\0\t\0�
\0\r�\0���\0\0\0\0\0�\t�\n�
\0���������\n��\0\0\0\t����\t\0\t
\0\0۞�������
�������\t���\t�\n\0\0\0�\t��\0\0\0���\0\0\0\0\0\0\0\0\0\0
\n���������
\tʐ\n�\t\t���\t
\t
�ې\t�\0�\0\0�\0\0�
�\t�\0���\0
�������\n\0�˹����\0��
\0�\0\0\0\0�\0�\0��
\0\0\0\0\0\0\t\0\0\0\0\t\0\0
\r\n
�������
��\t��й��\0\r��\0���\t\0\t�\0�\0���\n\0�\t�\0\0������\0\t

�
\t�
\t�\0\0��\n\0\0\t\0\t�\0�\n\t\0���\0\0\0\0\0\0\0\0\0�\t\0�
��Р\0�\t�\n
\0��\t\t\t�\0�\t���\0\t�\n\t\0�
\0\t�\n�\0����ɰ\t\0\0\n
����\0\0�����������\t\0\0\0\0��\0\0�\n�\n������\0\0\n\0\t\0\0\t\n\t\0���
ɩ\0\0\0���\0��𰚚ɠ\t\t隐�\t\n��\0�\0�\t��\n�\0���\0��\t\0�\n�\0�\n����\0����\0\0\n
\t\0�\0\0\0\0�\0\0�\0�\0�\0\0\t\0�\0\0\0\0
���\t\t���\0\0\0\0��

\t
\r�\t
\t����\t�\0\t\0\n��\t\0����
\t�\0�\0��\n���\0\0\n�
\t�\0\n�\0\0\0��\n\0\0\0\0\n��\0\0\0\0\n\t���\0\0\0�������
\n���\0\0\n����\0��������\t�٠�\t\0\n\t\0\t����������\0�\t\n���\n
\0�\0\0\0��\t\0�
\0\0\0\0\n��\n��\0\0\0\0\0\0
\t�\t\0��\0��\0�\t\tɩ����\0\0�\0\0�\n�\t��
����\t\n�\t\n٩\0\n\0���\t\0��驭�\t\0�\t\n��\n���\0���


\n

\0\0\0�
\n\0\0�\0\0\0\0\0\0�\0\0�����\0\0\t\t\n���\n����ڐ�\0\t\0����\n�
����а������\t\t
�\0�\t�������н
\0\0�
\0��\0�\0���\0������
\0\0\t
\n\0�\0\0\0\0\0\0\n\t\t�\t\0����
\t��н�
����
\t\n\0\0�
ɩ���\tｫ�\0��\0��������
˺��\n��
\t����\0\0���\0�\n�\n
�
��\0������\t\0���\n\0���\n\n\0�\t��\0\0��\n�����


�\0��\t�������
�޽�
ۙ�
\t��������
ڰ�����
\0\0�\0
\t\t\0����\0���������\0�
\n\0�\t\t\0\n\0�\n�\t�
\n������\0���������\n�\0��\t���
��������\0������

���
�
���\0\0�\0���\0��\n\n
������
\0�\n���
\n\n\0\0�\n��\0\0\0���\0\n��\0�
���


\t���
\n����\n�������\t�
����ɽ����
�����
ڛ\t��\0\0�


\0�\0���������
\0�

鰰���\0��\0\0



\0�\t���\0�����𰠾�렰�\n�
���
��������\r���������\n�

\0����\0�\n\t������
\n���𩪐��
\n��
�\n\t�\n
\0�\0���������\t�

����𰙩��
�\0���\n���������
��ۿ���������\n������\t
\0��ۚ�\n���������\t�
��\n���\n
\t\0����
�
\n\0\n�
\n��������
\n�������\t\n����������������������\t\0

\0\0\0\n�������\0\t\t����������
��\n����ʚ���\t�������������������������
\n����
����������\t�\t�빹��
�\0\0\0\0�\t\0\t�
\0\0������
�������۩��\0���\n���됫���\n���\n
�Щ�����������ښ����������������\0\n���������\0\0\0\0\0\n\0\0\0�

���\n\0\t����������\0\0\0頬\n����\n�\t���\0����
�
�
�����������\t��ڟ����������\0\t

ښ��

��\0\0\0\0\0\t\t\0\0�����\t��\n���������\0�\0\0\0

\0�\0
\n��\n��\t\0\0𰰠����������\n\t\n���������������\0\0�����\n���\0\0\0\0\0\0\0\0\0\0\0��
\0\0�ϰ����������\n\0�\n
\0�
�\0Щʐ\t
\n\0\0\t���
��
˹������ڐ�\nɬ���������������\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\n
�\0\0������������\0\0\0\0\n\0�\n
�\n���\0\0\0\0���
����
�������ࠠ\n��������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���\0\0������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0
\0�\n��\0\n��������\0\0\0\0\0��������������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0���','Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.',5,'http://accweb/emmployees/davolio.bmp');

COMMIT;

#
# Data for the `Region` table  (LIMIT 0,500)
#

INSERT INTO `Region` (`RegionID`, `RegionDescription`) VALUES 
  (1,'Eastern'),
  (2,'Western'),
  (3,'Northern'),
  (4,'Southern');

COMMIT;

#
# Data for the `Territories` table  (LIMIT 0,500)
#

INSERT INTO `Territories` (`TerritoryID`, `TerritoryDescription`, `RegionID`) VALUES 
  ('01581','Westboro',1),
  ('01730','Bedford',1),
  ('01833','Georgetow',1),
  ('02116','Boston',1),
  ('02139','Cambridge',1),
  ('02184','Braintree',1),
  ('02903','Providence',1),
  ('03049','Hollis',3),
  ('03801','Portsmouth',3),
  ('06897','Wilton',1),
  ('07960','Morristown',1),
  ('08837','Edison',1),
  ('10019','New York',1),
  ('10038','New York',1),
  ('11747','Mellvile',1),
  ('14450','Fairport',1),
  ('19428','Philadelphia',3),
  ('19713','Neward',1),
  ('20852','Rockville',1),
  ('27403','Greensboro',1),
  ('27511','Cary',1),
  ('29202','Columbia',4),
  ('30346','Atlanta',4),
  ('31406','Savannah',4),
  ('32859','Orlando',4),
  ('33607','Tampa',4),
  ('40222','Louisville',1),
  ('44122','Beachwood',3),
  ('45839','Findlay',3),
  ('48075','Southfield',3),
  ('48084','Troy',3),
  ('48304','Bloomfield Hills',3),
  ('53404','Racine',3),
  ('55113','Roseville',3),
  ('55439','Minneapolis',3),
  ('60179','Hoffman Estates',2),
  ('60601','Chicago',2),
  ('72716','Bentonville',4),
  ('75234','Dallas',4),
  ('78759','Austin',4),
  ('80202','Denver',2),
  ('80909','Colorado Springs',2),
  ('85014','Phoenix',2),
  ('85251','Scottsdale',2),
  ('90405','Santa Monica',2),
  ('94025','Menlo Park',2),
  ('94105','San Francisco',2),
  ('95008','Campbell',2),
  ('95054','Santa Clara',2),
  ('95060','Santa Cruz',2),
  ('98004','Bellevue',2),
  ('98052','Redmond',2),
  ('98104','Seattle',2);

COMMIT;

#
# Data for the `EmployeeTerritories` table  (LIMIT 0,500)
#

INSERT INTO `EmployeeTerritories` (`EmployeeID`, `TerritoryID`) VALUES 
  (2,'01581'),
  (2,'01730'),
  (2,'01833'),
  (2,'02116'),
  (2,'02139'),
  (2,'02184'),
  (5,'02903'),
  (9,'03049'),
  (9,'03801'),
  (1,'06897'),
  (5,'07960'),
  (5,'08837'),
  (5,'10019'),
  (5,'10038'),
  (5,'11747'),
  (5,'14450'),
  (8,'19428'),
  (1,'19713'),
  (4,'20852'),
  (4,'27403'),
  (4,'27511'),
  (3,'30346'),
  (3,'31406'),
  (3,'32859'),
  (3,'33607'),
  (2,'40222'),
  (8,'44122'),
  (8,'45839'),
  (9,'48075'),
  (9,'48084'),
  (9,'48304'),
  (8,'53404'),
  (9,'55113'),
  (9,'55439'),
  (7,'60179'),
  (7,'60601'),
  (7,'80202'),
  (7,'80909'),
  (6,'85014'),
  (6,'85251'),
  (7,'90405'),
  (7,'94025'),
  (7,'94105'),
  (7,'95008'),
  (7,'95054'),
  (7,'95060'),
  (6,'98004'),
  (6,'98052'),
  (6,'98104');

COMMIT;

#
# Data for the `Shippers` table  (LIMIT 0,500)
#

INSERT INTO `Shippers` (`ShipperID`, `CompanyName`, `Phone`) VALUES 
  (1,'Speedy Express','(503) 555-9831'),
  (2,'United Package','(503) 555-3199'),
  (3,'Federal Shipping','(503) 555-9931');

COMMIT;

#
# Data for the `Orders` table  (LIMIT 0,500)
#

INSERT INTO `Orders` (`OrderID`, `CustomerID`, `EmployeeID`, `OrderDate`, `RequiredDate`, `ShippedDate`, `ShipVia`, `Freight`, `ShipName`, `ShipAddress`, `ShipCity`, `ShipRegion`, `ShipPostalCode`, `ShipCountry`) VALUES 
  (10248,'VINET',5,'1996-07-04','1996-08-01','1996-07-16',3,32.38,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',NULL,'51100','France'),
  (10249,'TOMSP',6,'1996-07-05','1996-08-16','1996-07-10',1,11.61,'Toms Spezialit�ten','Luisenstr. 48','M�nster',NULL,'44087','Germany'),
  (10250,'HANAR',4,'1996-07-08','1996-08-05','1996-07-12',2,65.83,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10251,'VICTE',3,'1996-07-08','1996-08-05','1996-07-15',1,41.34,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10252,'SUPRD',4,'1996-07-09','1996-08-06','1996-07-11',2,51.3,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10253,'HANAR',3,'1996-07-10','1996-07-24','1996-07-16',2,58.17,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10254,'CHOPS',5,'1996-07-11','1996-08-08','1996-07-23',2,22.98,'Chop-suey Chinese','Hauptstr. 31','Bern',NULL,'3012','Switzerland'),
  (10255,'RICSU',9,'1996-07-12','1996-08-09','1996-07-15',3,148.33,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (10256,'WELLI',3,'1996-07-15','1996-08-12','1996-07-17',2,13.97,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10257,'HILAA',4,'1996-07-16','1996-08-13','1996-07-22',3,81.91,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10258,'ERNSH',1,'1996-07-17','1996-08-14','1996-07-23',1,140.51,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10259,'CENTC',4,'1996-07-18','1996-08-15','1996-07-25',3,3.25,'Centro comercial Moctezuma','Sierras de Granada 9993','M�xico D.F.',NULL,'05022','Mexico'),
  (10260,'OTTIK',4,'1996-07-19','1996-08-16','1996-07-29',1,55.09,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (10261,'QUEDE',4,'1996-07-19','1996-08-16','1996-07-30',2,3.05,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10262,'RATTC',8,'1996-07-22','1996-08-19','1996-07-25',3,48.29,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10263,'ERNSH',9,'1996-07-23','1996-08-20','1996-07-31',3,146.06,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10264,'FOLKO',6,'1996-07-24','1996-08-21','1996-08-23',3,3.67,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10265,'BLONP',2,'1996-07-25','1996-08-22','1996-08-12',1,55.28,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10266,'WARTH',3,'1996-07-26','1996-09-06','1996-07-31',3,25.73,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10267,'FRANK',4,'1996-07-29','1996-08-26','1996-08-06',1,208.58,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10268,'GROSR',8,'1996-07-30','1996-08-27','1996-08-02',3,66.29,'GROSELLA-Restaurante','5� Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela'),
  (10269,'WHITC',5,'1996-07-31','1996-08-14','1996-08-09',1,4.56,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10270,'WARTH',1,'1996-08-01','1996-08-29','1996-08-02',1,136.54,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10271,'SPLIR',6,'1996-08-01','1996-08-29','1996-08-30',2,4.54,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10272,'RATTC',6,'1996-08-02','1996-08-30','1996-08-06',2,98.03,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10273,'QUICK',3,'1996-08-05','1996-09-02','1996-08-12',3,76.07,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10274,'VINET',6,'1996-08-06','1996-09-03','1996-08-16',1,6.01,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',NULL,'51100','France'),
  (10275,'MAGAA',1,'1996-08-07','1996-09-04','1996-08-09',1,26.93,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10276,'TORTU',8,'1996-08-08','1996-08-22','1996-08-14',3,13.84,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10277,'MORGK',2,'1996-08-09','1996-09-06','1996-08-13',3,125.77,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',NULL,'04179','Germany'),
  (10278,'BERGS',8,'1996-08-12','1996-09-09','1996-08-16',2,92.69,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10279,'LEHMS',8,'1996-08-13','1996-09-10','1996-08-16',2,25.83,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10280,'BERGS',2,'1996-08-14','1996-09-11','1996-09-12',1,8.98,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10281,'ROMEY',4,'1996-08-14','1996-08-28','1996-08-21',1,2.94,'Romero y tomillo','Gran V�a, 1','Madrid',NULL,'28001','Spain'),
  (10282,'ROMEY',4,'1996-08-15','1996-09-12','1996-08-21',1,12.69,'Romero y tomillo','Gran V�a, 1','Madrid',NULL,'28001','Spain'),
  (10283,'LILAS',3,'1996-08-16','1996-09-13','1996-08-23',3,84.81,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10284,'LEHMS',4,'1996-08-19','1996-09-16','1996-08-27',1,76.56,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10285,'QUICK',1,'1996-08-20','1996-09-17','1996-08-26',2,76.83,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10286,'QUICK',8,'1996-08-21','1996-09-18','1996-08-30',3,229.24,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10287,'RICAR',8,'1996-08-22','1996-09-19','1996-08-28',3,12.76,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10288,'REGGC',4,'1996-08-23','1996-09-20','1996-09-03',1,7.45,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10289,'BSBEV',7,'1996-08-26','1996-09-23','1996-08-28',3,22.77,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10290,'COMMI',8,'1996-08-27','1996-09-24','1996-09-03',1,79.7,'Com�rcio Mineiro','Av. dos Lus�adas, 23','Sao Paulo','SP','05432-043','Brazil'),
  (10291,'QUEDE',6,'1996-08-27','1996-09-24','1996-09-04',2,6.4,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10292,'TRADH',1,'1996-08-28','1996-09-25','1996-09-02',2,1.35,'Tradi�ao Hipermercados','Av. In�s de Castro, 414','Sao Paulo','SP','05634-030','Brazil'),
  (10293,'TORTU',1,'1996-08-29','1996-09-26','1996-09-11',3,21.18,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10294,'RATTC',4,'1996-08-30','1996-09-27','1996-09-05',2,147.26,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10295,'VINET',2,'1996-09-02','1996-09-30','1996-09-10',2,1.15,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',NULL,'51100','France'),
  (10296,'LILAS',6,'1996-09-03','1996-10-01','1996-09-11',1,0.12,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10297,'BLONP',5,'1996-09-04','1996-10-16','1996-09-10',2,5.74,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10298,'HUNGO',6,'1996-09-05','1996-10-03','1996-09-11',2,168.22,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10299,'RICAR',4,'1996-09-06','1996-10-04','1996-09-13',2,29.76,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10300,'MAGAA',2,'1996-09-09','1996-10-07','1996-09-18',2,17.68,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10301,'WANDK',8,'1996-09-09','1996-10-07','1996-09-17',2,45.08,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10302,'SUPRD',4,'1996-09-10','1996-10-08','1996-10-09',2,6.27,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10303,'GODOS',7,'1996-09-11','1996-10-09','1996-09-18',2,107.83,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (10304,'TORTU',1,'1996-09-12','1996-10-10','1996-09-17',2,63.79,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10305,'OLDWO',8,'1996-09-13','1996-10-11','1996-10-09',3,257.62,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10306,'ROMEY',1,'1996-09-16','1996-10-14','1996-09-23',3,7.56,'Romero y tomillo','Gran V�a, 1','Madrid',NULL,'28001','Spain'),
  (10307,'LONEP',2,'1996-09-17','1996-10-15','1996-09-25',2,0.56,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA'),
  (10308,'ANATR',7,'1996-09-18','1996-10-16','1996-09-24',3,1.61,'Ana Trujillo Emparedados y helados','Avda. de la Constituci�n 2222','M�xico D.F.',NULL,'05021','Mexico'),
  (10309,'HUNGO',3,'1996-09-19','1996-10-17','1996-10-23',1,47.3,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10310,'THEBI',8,'1996-09-20','1996-10-18','1996-09-27',2,17.52,'The Big Cheese','89 Jefferson Way Suite 2','Portland','OR','97201','USA'),
  (10311,'DUMON',1,'1996-09-20','1996-10-04','1996-09-26',3,24.69,'Du monde entier','67, rue des Cinquante Otages','Nantes',NULL,'44000','France'),
  (10312,'WANDK',2,'1996-09-23','1996-10-21','1996-10-03',2,40.26,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10313,'QUICK',2,'1996-09-24','1996-10-22','1996-10-04',2,1.96,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10314,'RATTC',1,'1996-09-25','1996-10-23','1996-10-04',2,74.16,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10315,'ISLAT',4,'1996-09-26','1996-10-24','1996-10-03',2,41.76,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10316,'RATTC',1,'1996-09-27','1996-10-25','1996-10-08',3,150.15,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10317,'LONEP',6,'1996-09-30','1996-10-28','1996-10-10',1,12.69,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA'),
  (10318,'ISLAT',8,'1996-10-01','1996-10-29','1996-10-04',2,4.73,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10319,'TORTU',7,'1996-10-02','1996-10-30','1996-10-11',3,64.5,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10320,'WARTH',5,'1996-10-03','1996-10-17','1996-10-18',3,34.57,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10321,'ISLAT',3,'1996-10-03','1996-10-31','1996-10-11',2,3.43,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10322,'PERIC',7,'1996-10-04','1996-11-01','1996-10-23',3,0.4,'Pericles Comidas cl�sicas','Calle Dr. Jorge Cash 321','M�xico D.F.',NULL,'05033','Mexico'),
  (10323,'KOENE',4,'1996-10-07','1996-11-04','1996-10-14',1,4.88,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10324,'SAVEA',9,'1996-10-08','1996-11-05','1996-10-10',1,214.27,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10325,'KOENE',1,'1996-10-09','1996-10-23','1996-10-14',3,64.86,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10326,'BOLID',4,'1996-10-10','1996-11-07','1996-10-14',2,77.92,'B�lido Comidas preparadas','C/ Araquil, 67','Madrid',NULL,'28023','Spain'),
  (10327,'FOLKO',2,'1996-10-11','1996-11-08','1996-10-14',1,63.36,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10328,'FURIB',4,'1996-10-14','1996-11-11','1996-10-17',3,87.03,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal'),
  (10329,'SPLIR',4,'1996-10-15','1996-11-26','1996-10-23',2,191.67,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10330,'LILAS',3,'1996-10-16','1996-11-13','1996-10-28',1,12.75,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10331,'BONAP',9,'1996-10-16','1996-11-27','1996-10-21',1,10.19,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10332,'MEREP',3,'1996-10-17','1996-11-28','1996-10-21',2,52.84,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10333,'WARTH',5,'1996-10-18','1996-11-15','1996-10-25',3,0.59,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10334,'VICTE',8,'1996-10-21','1996-11-18','1996-10-28',2,8.56,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10335,'HUNGO',7,'1996-10-22','1996-11-19','1996-10-24',2,42.11,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10336,'PRINI',7,'1996-10-23','1996-11-20','1996-10-25',2,15.51,'Princesa Isabel Vinhos','Estrada da sa�de n. 58','Lisboa',NULL,'1756','Portugal'),
  (10337,'FRANK',4,'1996-10-24','1996-11-21','1996-10-29',3,108.26,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10338,'OLDWO',4,'1996-10-25','1996-11-22','1996-10-29',3,84.21,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10339,'MEREP',2,'1996-10-28','1996-11-25','1996-11-04',2,15.66,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10340,'BONAP',1,'1996-10-29','1996-11-26','1996-11-08',3,166.31,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10341,'SIMOB',7,'1996-10-29','1996-11-26','1996-11-05',3,26.78,'Simons bistro','Vinb�ltet 34','Kobenhavn',NULL,'1734','Denmark'),
  (10342,'FRANK',4,'1996-10-30','1996-11-13','1996-11-04',2,54.83,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10343,'LEHMS',4,'1996-10-31','1996-11-28','1996-11-06',1,110.37,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10344,'WHITC',4,'1996-11-01','1996-11-29','1996-11-05',2,23.29,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10345,'QUICK',2,'1996-11-04','1996-12-02','1996-11-11',2,249.06,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10346,'RATTC',3,'1996-11-05','1996-12-17','1996-11-08',3,142.08,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10347,'FAMIA',4,'1996-11-06','1996-12-04','1996-11-08',3,3.1,'Familia Arquibaldo','Rua Or�s, 92','Sao Paulo','SP','05442-030','Brazil'),
  (10348,'WANDK',4,'1996-11-07','1996-12-05','1996-11-15',2,0.78,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10349,'SPLIR',7,'1996-11-08','1996-12-06','1996-11-15',1,8.63,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10350,'LAMAI',6,'1996-11-11','1996-12-09','1996-12-03',2,64.19,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10351,'ERNSH',1,'1996-11-11','1996-12-09','1996-11-20',1,162.33,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10352,'FURIB',3,'1996-11-12','1996-11-26','1996-11-18',3,1.3,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal'),
  (10353,'PICCO',7,'1996-11-13','1996-12-11','1996-11-25',3,360.63,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (10354,'PERIC',8,'1996-11-14','1996-12-12','1996-11-20',3,53.8,'Pericles Comidas cl�sicas','Calle Dr. Jorge Cash 321','M�xico D.F.',NULL,'05033','Mexico'),
  (10355,'AROUT',6,'1996-11-15','1996-12-13','1996-11-20',1,41.95,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10356,'WANDK',6,'1996-11-18','1996-12-16','1996-11-27',2,36.71,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10357,'LILAS',1,'1996-11-19','1996-12-17','1996-12-02',3,34.88,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10358,'LAMAI',5,'1996-11-20','1996-12-18','1996-11-27',1,19.64,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10359,'SEVES',5,'1996-11-21','1996-12-19','1996-11-26',3,288.43,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10360,'BLONP',4,'1996-11-22','1996-12-20','1996-12-02',3,131.7,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10361,'QUICK',1,'1996-11-22','1996-12-20','1996-12-03',2,183.17,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10362,'BONAP',3,'1996-11-25','1996-12-23','1996-11-28',1,96.04,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10363,'DRACD',4,'1996-11-26','1996-12-24','1996-12-04',3,30.54,'Drachenblut Delikatessen','Walserweg 21','Aachen',NULL,'52066','Germany'),
  (10364,'EASTC',1,'1996-11-26','1997-01-07','1996-12-04',1,71.97,'Eastern Connection','35 King George','London',NULL,'WX3 6FW','UK'),
  (10365,'ANTON',3,'1996-11-27','1996-12-25','1996-12-02',2,22,'Antonio Moreno Taquer�a','Mataderos  2312','M�xico D.F.',NULL,'05023','Mexico'),
  (10366,'GALED',8,'1996-11-28','1997-01-09','1996-12-30',2,10.14,'Galer�a del gastron�mo','Rambla de Catalu�a, 23','Barcelona',NULL,'8022','Spain'),
  (10367,'VAFFE',7,'1996-11-28','1996-12-26','1996-12-02',3,13.55,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10368,'ERNSH',2,'1996-11-29','1996-12-27','1996-12-02',2,101.95,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10369,'SPLIR',8,'1996-12-02','1996-12-30','1996-12-09',2,195.68,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10370,'CHOPS',6,'1996-12-03','1996-12-31','1996-12-27',2,1.17,'Chop-suey Chinese','Hauptstr. 31','Bern',NULL,'3012','Switzerland'),
  (10371,'LAMAI',1,'1996-12-03','1996-12-31','1996-12-24',1,0.45,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10372,'QUEEN',5,'1996-12-04','1997-01-01','1996-12-09',2,890.78,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10373,'HUNGO',4,'1996-12-05','1997-01-02','1996-12-11',3,124.12,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10374,'WOLZA',1,'1996-12-05','1997-01-02','1996-12-09',3,3.94,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',NULL,'01-012','Poland'),
  (10375,'HUNGC',3,'1996-12-06','1997-01-03','1996-12-09',2,20.12,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA'),
  (10376,'MEREP',1,'1996-12-09','1997-01-06','1996-12-13',2,20.39,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10377,'SEVES',1,'1996-12-09','1997-01-06','1996-12-13',3,22.21,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10378,'FOLKO',5,'1996-12-10','1997-01-07','1996-12-19',3,5.44,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10379,'QUEDE',2,'1996-12-11','1997-01-08','1996-12-13',1,45.03,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10380,'HUNGO',8,'1996-12-12','1997-01-09','1997-01-16',3,35.03,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10381,'LILAS',3,'1996-12-12','1997-01-09','1996-12-13',3,7.99,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10382,'ERNSH',4,'1996-12-13','1997-01-10','1996-12-16',1,94.77,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10383,'AROUT',8,'1996-12-16','1997-01-13','1996-12-18',3,34.24,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10384,'BERGS',3,'1996-12-16','1997-01-13','1996-12-20',3,168.64,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10385,'SPLIR',1,'1996-12-17','1997-01-14','1996-12-23',2,30.96,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10386,'FAMIA',9,'1996-12-18','1997-01-01','1996-12-25',3,13.99,'Familia Arquibaldo','Rua Or�s, 92','Sao Paulo','SP','05442-030','Brazil'),
  (10387,'SANTG',1,'1996-12-18','1997-01-15','1996-12-20',2,93.63,'Sant� Gourmet','Erling Skakkes gate 78','Stavern',NULL,'4110','Norway'),
  (10388,'SEVES',2,'1996-12-19','1997-01-16','1996-12-20',1,34.86,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10389,'BOTTM',4,'1996-12-20','1997-01-17','1996-12-24',2,47.42,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10390,'ERNSH',6,'1996-12-23','1997-01-20','1996-12-26',1,126.38,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10391,'DRACD',3,'1996-12-23','1997-01-20','1996-12-31',3,5.45,'Drachenblut Delikatessen','Walserweg 21','Aachen',NULL,'52066','Germany'),
  (10392,'PICCO',2,'1996-12-24','1997-01-21','1997-01-01',3,122.46,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (10393,'SAVEA',1,'1996-12-25','1997-01-22','1997-01-03',3,126.56,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10394,'HUNGC',1,'1996-12-25','1997-01-22','1997-01-03',3,30.34,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA'),
  (10395,'HILAA',6,'1996-12-26','1997-01-23','1997-01-03',1,184.41,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10396,'FRANK',1,'1996-12-27','1997-01-10','1997-01-06',3,135.35,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10397,'PRINI',5,'1996-12-27','1997-01-24','1997-01-02',1,60.26,'Princesa Isabel Vinhos','Estrada da sa�de n. 58','Lisboa',NULL,'1756','Portugal'),
  (10398,'SAVEA',2,'1996-12-30','1997-01-27','1997-01-09',3,89.16,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10399,'VAFFE',8,'1996-12-31','1997-01-14','1997-01-08',3,27.36,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10400,'EASTC',1,'1997-01-01','1997-01-29','1997-01-16',3,83.93,'Eastern Connection','35 King George','London',NULL,'WX3 6FW','UK'),
  (10401,'RATTC',1,'1997-01-01','1997-01-29','1997-01-10',1,12.51,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10402,'ERNSH',8,'1997-01-02','1997-02-13','1997-01-10',2,67.88,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10403,'ERNSH',4,'1997-01-03','1997-01-31','1997-01-09',3,73.79,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10404,'MAGAA',2,'1997-01-03','1997-01-31','1997-01-08',1,155.97,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10405,'LINOD',1,'1997-01-06','1997-02-03','1997-01-22',1,34.82,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10406,'QUEEN',7,'1997-01-07','1997-02-18','1997-01-13',1,108.04,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10407,'OTTIK',2,'1997-01-07','1997-02-04','1997-01-30',2,91.48,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (10408,'FOLIG',8,'1997-01-08','1997-02-05','1997-01-14',1,11.26,'Folies gourmandes','184, chauss�e de Tournai','Lille',NULL,'59000','France'),
  (10409,'OCEAN',3,'1997-01-09','1997-02-06','1997-01-14',1,29.83,'Oc�ano Atl�ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',NULL,'1010','Argentina'),
  (10410,'BOTTM',3,'1997-01-10','1997-02-07','1997-01-15',3,2.4,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10411,'BOTTM',9,'1997-01-10','1997-02-07','1997-01-21',3,23.65,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10412,'WARTH',8,'1997-01-13','1997-02-10','1997-01-15',2,3.77,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10413,'LAMAI',3,'1997-01-14','1997-02-11','1997-01-16',2,95.66,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10414,'FAMIA',2,'1997-01-14','1997-02-11','1997-01-17',3,21.48,'Familia Arquibaldo','Rua Or�s, 92','Sao Paulo','SP','05442-030','Brazil'),
  (10415,'HUNGC',3,'1997-01-15','1997-02-12','1997-01-24',1,0.2,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA'),
  (10416,'WARTH',8,'1997-01-16','1997-02-13','1997-01-27',3,22.72,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10417,'SIMOB',4,'1997-01-16','1997-02-13','1997-01-28',3,70.29,'Simons bistro','Vinb�ltet 34','Kobenhavn',NULL,'1734','Denmark'),
  (10418,'QUICK',4,'1997-01-17','1997-02-14','1997-01-24',1,17.55,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10419,'RICSU',4,'1997-01-20','1997-02-17','1997-01-30',2,137.35,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (10420,'WELLI',3,'1997-01-21','1997-02-18','1997-01-27',1,44.12,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10421,'QUEDE',8,'1997-01-21','1997-03-04','1997-01-27',1,99.23,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10422,'FRANS',2,'1997-01-22','1997-02-19','1997-01-31',1,3.02,'Franchi S.p.A.','Via Monte Bianco 34','Torino',NULL,'10100','Italy'),
  (10423,'GOURL',6,'1997-01-23','1997-02-06','1997-02-24',3,24.5,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (10424,'MEREP',7,'1997-01-23','1997-02-20','1997-01-27',2,370.61,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10425,'LAMAI',6,'1997-01-24','1997-02-21','1997-02-14',2,7.93,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10426,'GALED',4,'1997-01-27','1997-02-24','1997-02-06',1,18.69,'Galer�a del gastron�mo','Rambla de Catalu�a, 23','Barcelona',NULL,'8022','Spain'),
  (10427,'PICCO',4,'1997-01-27','1997-02-24','1997-03-03',2,31.29,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (10428,'REGGC',7,'1997-01-28','1997-02-25','1997-02-04',1,11.09,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10429,'HUNGO',3,'1997-01-29','1997-03-12','1997-02-07',2,56.63,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10430,'ERNSH',4,'1997-01-30','1997-02-13','1997-02-03',1,458.78,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10431,'BOTTM',4,'1997-01-30','1997-02-13','1997-02-07',2,44.17,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10432,'SPLIR',3,'1997-01-31','1997-02-14','1997-02-07',2,4.34,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10433,'PRINI',3,'1997-02-03','1997-03-03','1997-03-04',3,73.83,'Princesa Isabel Vinhos','Estrada da sa�de n. 58','Lisboa',NULL,'1756','Portugal'),
  (10434,'FOLKO',3,'1997-02-03','1997-03-03','1997-02-13',2,17.92,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10435,'CONSH',8,'1997-02-04','1997-03-18','1997-02-07',2,9.21,'Consolidated Holdings','Berkeley Gardens 12  Brewery','London',NULL,'WX1 6LT','UK'),
  (10436,'BLONP',3,'1997-02-05','1997-03-05','1997-02-11',2,156.66,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10437,'WARTH',8,'1997-02-05','1997-03-05','1997-02-12',1,19.97,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10438,'TOMSP',3,'1997-02-06','1997-03-06','1997-02-14',2,8.24,'Toms Spezialit�ten','Luisenstr. 48','M�nster',NULL,'44087','Germany'),
  (10439,'MEREP',6,'1997-02-07','1997-03-07','1997-02-10',3,4.07,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10440,'SAVEA',4,'1997-02-10','1997-03-10','1997-02-28',2,86.53,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10441,'OLDWO',3,'1997-02-10','1997-03-24','1997-03-14',2,73.02,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10442,'ERNSH',3,'1997-02-11','1997-03-11','1997-02-18',2,47.94,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10443,'REGGC',8,'1997-02-12','1997-03-12','1997-02-14',1,13.95,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10444,'BERGS',3,'1997-02-12','1997-03-12','1997-02-21',3,3.5,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10445,'BERGS',3,'1997-02-13','1997-03-13','1997-02-20',1,9.3,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10446,'TOMSP',6,'1997-02-14','1997-03-14','1997-02-19',1,14.68,'Toms Spezialit�ten','Luisenstr. 48','M�nster',NULL,'44087','Germany'),
  (10447,'RICAR',4,'1997-02-14','1997-03-14','1997-03-07',2,68.66,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10448,'RANCH',4,'1997-02-17','1997-03-17','1997-02-24',2,38.82,'Rancho grande','Av. del Libertador 900','Buenos Aires',NULL,'1010','Argentina'),
  (10449,'BLONP',3,'1997-02-18','1997-03-18','1997-02-27',2,53.3,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10450,'VICTE',8,'1997-02-19','1997-03-19','1997-03-11',2,7.23,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10451,'QUICK',4,'1997-02-19','1997-03-05','1997-03-12',3,189.09,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10452,'SAVEA',8,'1997-02-20','1997-03-20','1997-02-26',1,140.26,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10453,'AROUT',1,'1997-02-21','1997-03-21','1997-02-26',2,25.36,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10454,'LAMAI',4,'1997-02-21','1997-03-21','1997-02-25',3,2.74,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10455,'WARTH',8,'1997-02-24','1997-04-07','1997-03-03',2,180.45,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10456,'KOENE',8,'1997-02-25','1997-04-08','1997-02-28',2,8.12,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10457,'KOENE',2,'1997-02-25','1997-03-25','1997-03-03',1,11.57,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10458,'SUPRD',7,'1997-02-26','1997-03-26','1997-03-04',3,147.06,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10459,'VICTE',4,'1997-02-27','1997-03-27','1997-02-28',2,25.09,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10460,'FOLKO',8,'1997-02-28','1997-03-28','1997-03-03',1,16.27,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10461,'LILAS',1,'1997-02-28','1997-03-28','1997-03-05',3,148.61,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10462,'CONSH',2,'1997-03-03','1997-03-31','1997-03-18',1,6.17,'Consolidated Holdings','Berkeley Gardens 12  Brewery','London',NULL,'WX1 6LT','UK'),
  (10463,'SUPRD',5,'1997-03-04','1997-04-01','1997-03-06',3,14.78,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10464,'FURIB',4,'1997-03-04','1997-04-01','1997-03-14',2,89,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal'),
  (10465,'VAFFE',1,'1997-03-05','1997-04-02','1997-03-14',3,145.04,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10466,'COMMI',4,'1997-03-06','1997-04-03','1997-03-13',1,11.93,'Com�rcio Mineiro','Av. dos Lus�adas, 23','Sao Paulo','SP','05432-043','Brazil'),
  (10467,'MAGAA',8,'1997-03-06','1997-04-03','1997-03-11',2,4.93,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10468,'KOENE',3,'1997-03-07','1997-04-04','1997-03-12',3,44.12,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10469,'WHITC',1,'1997-03-10','1997-04-07','1997-03-14',1,60.18,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10470,'BONAP',4,'1997-03-11','1997-04-08','1997-03-14',2,64.56,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10471,'BSBEV',2,'1997-03-11','1997-04-08','1997-03-18',3,45.59,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10472,'SEVES',8,'1997-03-12','1997-04-09','1997-03-19',1,4.2,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10473,'ISLAT',1,'1997-03-13','1997-03-27','1997-03-21',3,16.37,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10474,'PERIC',5,'1997-03-13','1997-04-10','1997-03-21',2,83.49,'Pericles Comidas cl�sicas','Calle Dr. Jorge Cash 321','M�xico D.F.',NULL,'05033','Mexico'),
  (10475,'SUPRD',9,'1997-03-14','1997-04-11','1997-04-04',1,68.52,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10476,'HILAA',8,'1997-03-17','1997-04-14','1997-03-24',3,4.41,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10477,'PRINI',5,'1997-03-17','1997-04-14','1997-03-25',2,13.02,'Princesa Isabel Vinhos','Estrada da sa�de n. 58','Lisboa',NULL,'1756','Portugal'),
  (10478,'VICTE',2,'1997-03-18','1997-04-01','1997-03-26',3,4.81,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10479,'RATTC',3,'1997-03-19','1997-04-16','1997-03-21',3,708.95,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10480,'FOLIG',6,'1997-03-20','1997-04-17','1997-03-24',2,1.35,'Folies gourmandes','184, chauss�e de Tournai','Lille',NULL,'59000','France'),
  (10481,'RICAR',8,'1997-03-20','1997-04-17','1997-03-25',2,64.33,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10482,'LAZYK',1,'1997-03-21','1997-04-18','1997-04-10',3,7.48,'Lazy K Kountry Store','12 Orchestra Terrace','Walla Walla','WA','99362','USA'),
  (10483,'WHITC',7,'1997-03-24','1997-04-21','1997-04-25',2,15.28,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10484,'BSBEV',3,'1997-03-24','1997-04-21','1997-04-01',3,6.88,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10485,'LINOD',4,'1997-03-25','1997-04-08','1997-03-31',2,64.45,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10486,'HILAA',1,'1997-03-26','1997-04-23','1997-04-02',2,30.53,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10487,'QUEEN',2,'1997-03-26','1997-04-23','1997-03-28',2,71.07,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10488,'FRANK',8,'1997-03-27','1997-04-24','1997-04-02',2,4.93,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10489,'PICCO',6,'1997-03-28','1997-04-25','1997-04-09',2,5.29,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (10490,'HILAA',7,'1997-03-31','1997-04-28','1997-04-03',2,210.19,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10491,'FURIB',8,'1997-03-31','1997-04-28','1997-04-08',3,16.96,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal'),
  (10492,'BOTTM',3,'1997-04-01','1997-04-29','1997-04-11',1,62.89,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10493,'LAMAI',4,'1997-04-02','1997-04-30','1997-04-10',3,10.64,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10494,'COMMI',4,'1997-04-02','1997-04-30','1997-04-09',2,65.99,'Com�rcio Mineiro','Av. dos Lus�adas, 23','Sao Paulo','SP','05432-043','Brazil'),
  (10495,'LAUGB',3,'1997-04-03','1997-05-01','1997-04-11',3,4.65,'Laughing Bacchus Wine Cellars','2319 Elm St.','Vancouver','BC','V3F 2K1','Canada'),
  (10496,'TRADH',7,'1997-04-04','1997-05-02','1997-04-07',2,46.77,'Tradi�ao Hipermercados','Av. In�s de Castro, 414','Sao Paulo','SP','05634-030','Brazil'),
  (10497,'LEHMS',7,'1997-04-04','1997-05-02','1997-04-07',1,36.21,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10498,'HILAA',8,'1997-04-07','1997-05-05','1997-04-11',2,29.75,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10499,'LILAS',4,'1997-04-08','1997-05-06','1997-04-16',2,102.02,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10500,'LAMAI',6,'1997-04-09','1997-05-07','1997-04-17',1,42.68,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10501,'BLAUS',9,'1997-04-09','1997-05-07','1997-04-16',3,8.85,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',NULL,'68306','Germany'),
  (10502,'PERIC',2,'1997-04-10','1997-05-08','1997-04-29',1,69.32,'Pericles Comidas cl�sicas','Calle Dr. Jorge Cash 321','M�xico D.F.',NULL,'05033','Mexico'),
  (10503,'HUNGO',6,'1997-04-11','1997-05-09','1997-04-16',2,16.74,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10504,'WHITC',4,'1997-04-11','1997-05-09','1997-04-18',3,59.13,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10505,'MEREP',3,'1997-04-14','1997-05-12','1997-04-21',3,7.13,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10506,'KOENE',9,'1997-04-15','1997-05-13','1997-05-02',2,21.19,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10507,'ANTON',7,'1997-04-15','1997-05-13','1997-04-22',1,47.45,'Antonio Moreno Taquer�a','Mataderos  2312','M�xico D.F.',NULL,'05023','Mexico'),
  (10508,'OTTIK',1,'1997-04-16','1997-05-14','1997-05-13',2,4.99,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (10509,'BLAUS',4,'1997-04-17','1997-05-15','1997-04-29',1,0.15,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',NULL,'68306','Germany'),
  (10510,'SAVEA',6,'1997-04-18','1997-05-16','1997-04-28',3,367.63,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10511,'BONAP',4,'1997-04-18','1997-05-16','1997-04-21',3,350.64,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10512,'FAMIA',7,'1997-04-21','1997-05-19','1997-04-24',2,3.53,'Familia Arquibaldo','Rua Or�s, 92','Sao Paulo','SP','05442-030','Brazil'),
  (10513,'WANDK',7,'1997-04-22','1997-06-03','1997-04-28',1,105.65,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10514,'ERNSH',3,'1997-04-22','1997-05-20','1997-05-16',2,789.95,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10515,'QUICK',2,'1997-04-23','1997-05-07','1997-05-23',1,204.47,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10516,'HUNGO',2,'1997-04-24','1997-05-22','1997-05-01',3,62.78,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10517,'NORTS',3,'1997-04-24','1997-05-22','1997-04-29',3,32.07,'North/South','South House 300 Queensbridge','London',NULL,'SW7 1RZ','UK'),
  (10518,'TORTU',4,'1997-04-25','1997-05-09','1997-05-05',2,218.15,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10519,'CHOPS',6,'1997-04-28','1997-05-26','1997-05-01',3,91.76,'Chop-suey Chinese','Hauptstr. 31','Bern',NULL,'3012','Switzerland'),
  (10520,'SANTG',7,'1997-04-29','1997-05-27','1997-05-01',1,13.37,'Sant� Gourmet','Erling Skakkes gate 78','Stavern',NULL,'4110','Norway'),
  (10521,'CACTU',8,'1997-04-29','1997-05-27','1997-05-02',2,17.22,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',NULL,'1010','Argentina'),
  (10522,'LEHMS',4,'1997-04-30','1997-05-28','1997-05-06',1,45.33,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10523,'SEVES',7,'1997-05-01','1997-05-29','1997-05-30',2,77.63,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10524,'BERGS',1,'1997-05-01','1997-05-29','1997-05-07',2,244.79,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10525,'BONAP',1,'1997-05-02','1997-05-30','1997-05-23',2,11.06,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10526,'WARTH',4,'1997-05-05','1997-06-02','1997-05-15',2,58.59,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10527,'QUICK',7,'1997-05-05','1997-06-02','1997-05-07',1,41.9,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10528,'GREAL',6,'1997-05-06','1997-05-20','1997-05-09',2,3.35,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (10529,'MAISD',5,'1997-05-07','1997-06-04','1997-05-09',2,66.69,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',NULL,'B-1180','Belgium'),
  (10530,'PICCO',3,'1997-05-08','1997-06-05','1997-05-12',2,339.22,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (10531,'OCEAN',7,'1997-05-08','1997-06-05','1997-05-19',1,8.12,'Oc�ano Atl�ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',NULL,'1010','Argentina'),
  (10532,'EASTC',7,'1997-05-09','1997-06-06','1997-05-12',3,74.46,'Eastern Connection','35 King George','London',NULL,'WX3 6FW','UK'),
  (10533,'FOLKO',8,'1997-05-12','1997-06-09','1997-05-22',1,188.04,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10534,'LEHMS',8,'1997-05-12','1997-06-09','1997-05-14',2,27.94,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10535,'ANTON',4,'1997-05-13','1997-06-10','1997-05-21',1,15.64,'Antonio Moreno Taquer�a','Mataderos  2312','M�xico D.F.',NULL,'05023','Mexico'),
  (10536,'LEHMS',3,'1997-05-14','1997-06-11','1997-06-06',2,58.88,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10537,'RICSU',1,'1997-05-14','1997-05-28','1997-05-19',1,78.85,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (10538,'BSBEV',9,'1997-05-15','1997-06-12','1997-05-16',3,4.87,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10539,'BSBEV',6,'1997-05-16','1997-06-13','1997-05-23',3,12.36,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10540,'QUICK',3,'1997-05-19','1997-06-16','1997-06-13',3,1007.64,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10541,'HANAR',2,'1997-05-19','1997-06-16','1997-05-29',1,68.65,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10542,'KOENE',1,'1997-05-20','1997-06-17','1997-05-26',3,10.95,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10543,'LILAS',8,'1997-05-21','1997-06-18','1997-05-23',2,48.17,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10544,'LONEP',4,'1997-05-21','1997-06-18','1997-05-30',1,24.91,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA'),
  (10545,'LAZYK',8,'1997-05-22','1997-06-19','1997-06-26',2,11.92,'Lazy K Kountry Store','12 Orchestra Terrace','Walla Walla','WA','99362','USA'),
  (10546,'VICTE',1,'1997-05-23','1997-06-20','1997-05-27',3,194.72,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10547,'SEVES',3,'1997-05-23','1997-06-20','1997-06-02',2,178.43,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10548,'TOMSP',3,'1997-05-26','1997-06-23','1997-06-02',2,1.43,'Toms Spezialit�ten','Luisenstr. 48','M�nster',NULL,'44087','Germany'),
  (10549,'QUICK',5,'1997-05-27','1997-06-10','1997-05-30',1,171.24,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10550,'GODOS',7,'1997-05-28','1997-06-25','1997-06-06',3,4.32,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (10551,'FURIB',4,'1997-05-28','1997-07-09','1997-06-06',3,72.95,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal'),
  (10552,'HILAA',2,'1997-05-29','1997-06-26','1997-06-05',1,83.22,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10553,'WARTH',2,'1997-05-30','1997-06-27','1997-06-03',2,149.49,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10554,'OTTIK',4,'1997-05-30','1997-06-27','1997-06-05',3,120.97,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (10555,'SAVEA',6,'1997-06-02','1997-06-30','1997-06-04',3,252.49,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10556,'SIMOB',2,'1997-06-03','1997-07-15','1997-06-13',1,9.8,'Simons bistro','Vinb�ltet 34','Kobenhavn',NULL,'1734','Denmark'),
  (10557,'LEHMS',9,'1997-06-03','1997-06-17','1997-06-06',2,96.72,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10558,'AROUT',1,'1997-06-04','1997-07-02','1997-06-10',2,72.97,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10559,'BLONP',6,'1997-06-05','1997-07-03','1997-06-13',1,8.05,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10560,'FRANK',8,'1997-06-06','1997-07-04','1997-06-09',1,36.65,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10561,'FOLKO',2,'1997-06-06','1997-07-04','1997-06-09',2,242.21,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10562,'REGGC',1,'1997-06-09','1997-07-07','1997-06-12',1,22.95,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10563,'RICAR',2,'1997-06-10','1997-07-22','1997-06-24',2,60.43,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10564,'RATTC',4,'1997-06-10','1997-07-08','1997-06-16',3,13.75,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10565,'MEREP',8,'1997-06-11','1997-07-09','1997-06-18',2,7.15,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10566,'BLONP',9,'1997-06-12','1997-07-10','1997-06-18',1,88.4,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10567,'HUNGO',1,'1997-06-12','1997-07-10','1997-06-17',1,33.97,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10568,'GALED',3,'1997-06-13','1997-07-11','1997-07-09',3,6.54,'Galer�a del gastron�mo','Rambla de Catalu�a, 23','Barcelona',NULL,'8022','Spain'),
  (10569,'RATTC',5,'1997-06-16','1997-07-14','1997-07-11',1,58.98,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10570,'MEREP',3,'1997-06-17','1997-07-15','1997-06-19',3,188.99,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10571,'ERNSH',8,'1997-06-17','1997-07-29','1997-07-04',3,26.06,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10572,'BERGS',3,'1997-06-18','1997-07-16','1997-06-25',2,116.43,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10573,'ANTON',7,'1997-06-19','1997-07-17','1997-06-20',3,84.84,'Antonio Moreno Taquer�a','Mataderos  2312','M�xico D.F.',NULL,'05023','Mexico'),
  (10574,'TRAIH',4,'1997-06-19','1997-07-17','1997-06-30',2,37.6,'Trail''s Head Gourmet Provisioners','722 DaVinci Blvd.','Kirkland','WA','98034','USA'),
  (10575,'MORGK',5,'1997-06-20','1997-07-04','1997-06-30',1,127.34,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',NULL,'04179','Germany'),
  (10576,'TORTU',3,'1997-06-23','1997-07-07','1997-06-30',3,18.56,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10577,'TRAIH',9,'1997-06-23','1997-08-04','1997-06-30',2,25.41,'Trail''s Head Gourmet Provisioners','722 DaVinci Blvd.','Kirkland','WA','98034','USA'),
  (10578,'BSBEV',4,'1997-06-24','1997-07-22','1997-07-25',3,29.6,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10579,'LETSS',1,'1997-06-25','1997-07-23','1997-07-04',2,13.73,'Let''s Stop N Shop','87 Polk St. Suite 5','San Francisco','CA','94117','USA'),
  (10580,'OTTIK',4,'1997-06-26','1997-07-24','1997-07-01',3,75.89,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (10581,'FAMIA',3,'1997-06-26','1997-07-24','1997-07-02',1,3.01,'Familia Arquibaldo','Rua Or�s, 92','Sao Paulo','SP','05442-030','Brazil'),
  (10582,'BLAUS',3,'1997-06-27','1997-07-25','1997-07-14',2,27.71,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',NULL,'68306','Germany'),
  (10583,'WARTH',2,'1997-06-30','1997-07-28','1997-07-04',2,7.28,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10584,'BLONP',4,'1997-06-30','1997-07-28','1997-07-04',1,59.14,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10585,'WELLI',7,'1997-07-01','1997-07-29','1997-07-10',1,13.41,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10586,'REGGC',9,'1997-07-02','1997-07-30','1997-07-09',1,0.48,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10587,'QUEDE',1,'1997-07-02','1997-07-30','1997-07-09',1,62.52,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10588,'QUICK',2,'1997-07-03','1997-07-31','1997-07-10',3,194.67,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10589,'GREAL',8,'1997-07-04','1997-08-01','1997-07-14',2,4.42,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (10590,'MEREP',4,'1997-07-07','1997-08-04','1997-07-14',3,44.77,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10591,'VAFFE',1,'1997-07-07','1997-07-21','1997-07-16',1,55.92,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10592,'LEHMS',3,'1997-07-08','1997-08-05','1997-07-16',1,32.1,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10593,'LEHMS',7,'1997-07-09','1997-08-06','1997-08-13',2,174.2,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10594,'OLDWO',3,'1997-07-09','1997-08-06','1997-07-16',2,5.24,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10595,'ERNSH',2,'1997-07-10','1997-08-07','1997-07-14',1,96.78,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10596,'WHITC',8,'1997-07-11','1997-08-08','1997-08-12',1,16.34,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10597,'PICCO',7,'1997-07-11','1997-08-08','1997-07-18',3,35.12,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (10598,'RATTC',1,'1997-07-14','1997-08-11','1997-07-18',3,44.42,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10599,'BSBEV',6,'1997-07-15','1997-08-26','1997-07-21',3,29.98,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10600,'HUNGC',4,'1997-07-16','1997-08-13','1997-07-21',1,45.13,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA'),
  (10601,'HILAA',7,'1997-07-16','1997-08-27','1997-07-22',1,58.3,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10602,'VAFFE',8,'1997-07-17','1997-08-14','1997-07-22',2,2.92,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10603,'SAVEA',8,'1997-07-18','1997-08-15','1997-08-08',2,48.77,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10604,'FURIB',1,'1997-07-18','1997-08-15','1997-07-29',1,7.46,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal'),
  (10605,'MEREP',1,'1997-07-21','1997-08-18','1997-07-29',2,379.13,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10606,'TRADH',4,'1997-07-22','1997-08-19','1997-07-31',3,79.4,'Tradi�ao Hipermercados','Av. In�s de Castro, 414','Sao Paulo','SP','05634-030','Brazil'),
  (10607,'SAVEA',5,'1997-07-22','1997-08-19','1997-07-25',1,200.24,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10608,'TOMSP',4,'1997-07-23','1997-08-20','1997-08-01',2,27.79,'Toms Spezialit�ten','Luisenstr. 48','M�nster',NULL,'44087','Germany'),
  (10609,'DUMON',7,'1997-07-24','1997-08-21','1997-07-30',2,1.85,'Du monde entier','67, rue des Cinquante Otages','Nantes',NULL,'44000','France'),
  (10610,'LAMAI',8,'1997-07-25','1997-08-22','1997-08-06',1,26.78,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10611,'WOLZA',6,'1997-07-25','1997-08-22','1997-08-01',2,80.65,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',NULL,'01-012','Poland'),
  (10612,'SAVEA',1,'1997-07-28','1997-08-25','1997-08-01',2,544.08,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10613,'HILAA',4,'1997-07-29','1997-08-26','1997-08-01',2,8.11,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10614,'BLAUS',8,'1997-07-29','1997-08-26','1997-08-01',3,1.93,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',NULL,'68306','Germany'),
  (10615,'WILMK',2,'1997-07-30','1997-08-27','1997-08-06',3,0.75,'Wilman Kala','Keskuskatu 45','Helsinki',NULL,'21240','Finland'),
  (10616,'GREAL',1,'1997-07-31','1997-08-28','1997-08-05',2,116.53,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (10617,'GREAL',4,'1997-07-31','1997-08-28','1997-08-04',2,18.53,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (10618,'MEREP',1,'1997-08-01','1997-09-12','1997-08-08',1,154.68,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10619,'MEREP',3,'1997-08-04','1997-09-01','1997-08-07',3,91.05,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10620,'LAUGB',2,'1997-08-05','1997-09-02','1997-08-14',3,0.94,'Laughing Bacchus Wine Cellars','2319 Elm St.','Vancouver','BC','V3F 2K1','Canada'),
  (10621,'ISLAT',4,'1997-08-05','1997-09-02','1997-08-11',2,23.73,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10622,'RICAR',4,'1997-08-06','1997-09-03','1997-08-11',3,50.97,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10623,'FRANK',8,'1997-08-07','1997-09-04','1997-08-12',2,97.18,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10624,'THECR',4,'1997-08-07','1997-09-04','1997-08-19',2,94.8,'The Cracker Box','55 Grizzly Peak Rd.','Butte','MT','59801','USA'),
  (10625,'ANATR',3,'1997-08-08','1997-09-05','1997-08-14',1,43.9,'Ana Trujillo Emparedados y helados','Avda. de la Constituci�n 2222','M�xico D.F.',NULL,'05021','Mexico'),
  (10626,'BERGS',1,'1997-08-11','1997-09-08','1997-08-20',2,138.69,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10627,'SAVEA',8,'1997-08-11','1997-09-22','1997-08-21',3,107.46,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10628,'BLONP',4,'1997-08-12','1997-09-09','1997-08-20',3,30.36,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10629,'GODOS',4,'1997-08-12','1997-09-09','1997-08-20',3,85.46,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (10630,'KOENE',1,'1997-08-13','1997-09-10','1997-08-19',2,32.35,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10631,'LAMAI',8,'1997-08-14','1997-09-11','1997-08-15',1,0.87,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10632,'WANDK',8,'1997-08-14','1997-09-11','1997-08-19',1,41.38,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10633,'ERNSH',7,'1997-08-15','1997-09-12','1997-08-18',3,477.9,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10634,'FOLIG',4,'1997-08-15','1997-09-12','1997-08-21',3,487.38,'Folies gourmandes','184, chauss�e de Tournai','Lille',NULL,'59000','France'),
  (10635,'MAGAA',8,'1997-08-18','1997-09-15','1997-08-21',3,47.46,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10636,'WARTH',4,'1997-08-19','1997-09-16','1997-08-26',1,1.15,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10637,'QUEEN',6,'1997-08-19','1997-09-16','1997-08-26',1,201.29,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10638,'LINOD',3,'1997-08-20','1997-09-17','1997-09-01',1,158.44,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10639,'SANTG',7,'1997-08-20','1997-09-17','1997-08-27',3,38.64,'Sant� Gourmet','Erling Skakkes gate 78','Stavern',NULL,'4110','Norway'),
  (10640,'WANDK',4,'1997-08-21','1997-09-18','1997-08-28',1,23.55,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10641,'HILAA',4,'1997-08-22','1997-09-19','1997-08-26',2,179.61,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10642,'SIMOB',7,'1997-08-22','1997-09-19','1997-09-05',3,41.89,'Simons bistro','Vinb�ltet 34','Kobenhavn',NULL,'1734','Denmark'),
  (10643,'ALFKI',6,'1997-08-25','1997-09-22','1997-09-02',1,29.46,'Alfreds Futterkiste','Obere Str. 57','Berlin',NULL,'12209','Germany'),
  (10644,'WELLI',3,'1997-08-25','1997-09-22','1997-09-01',2,0.14,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10645,'HANAR',4,'1997-08-26','1997-09-23','1997-09-02',1,12.41,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10646,'HUNGO',9,'1997-08-27','1997-10-08','1997-09-03',3,142.33,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10647,'QUEDE',4,'1997-08-27','1997-09-10','1997-09-03',2,45.54,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10648,'RICAR',5,'1997-08-28','1997-10-09','1997-09-09',2,14.25,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10649,'MAISD',5,'1997-08-28','1997-09-25','1997-08-29',3,6.2,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',NULL,'B-1180','Belgium'),
  (10650,'FAMIA',5,'1997-08-29','1997-09-26','1997-09-03',3,176.81,'Familia Arquibaldo','Rua Or�s, 92','Sao Paulo','SP','05442-030','Brazil'),
  (10651,'WANDK',8,'1997-09-01','1997-09-29','1997-09-11',2,20.6,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10652,'GOURL',4,'1997-09-01','1997-09-29','1997-09-08',2,7.14,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (10653,'FRANK',1,'1997-09-02','1997-09-30','1997-09-19',1,93.25,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10654,'BERGS',5,'1997-09-02','1997-09-30','1997-09-11',1,55.26,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10655,'REGGC',1,'1997-09-03','1997-10-01','1997-09-11',2,4.41,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10656,'GREAL',6,'1997-09-04','1997-10-02','1997-09-10',1,57.15,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (10657,'SAVEA',2,'1997-09-04','1997-10-02','1997-09-15',2,352.69,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10658,'QUICK',4,'1997-09-05','1997-10-03','1997-09-08',1,364.15,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10659,'QUEEN',7,'1997-09-05','1997-10-03','1997-09-10',2,105.81,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10660,'HUNGC',8,'1997-09-08','1997-10-06','1997-10-15',1,111.29,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA'),
  (10661,'HUNGO',7,'1997-09-09','1997-10-07','1997-09-15',3,17.55,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10662,'LONEP',3,'1997-09-09','1997-10-07','1997-09-18',2,1.28,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA'),
  (10663,'BONAP',2,'1997-09-10','1997-09-24','1997-10-03',2,113.15,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10664,'FURIB',1,'1997-09-10','1997-10-08','1997-09-19',3,1.27,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal'),
  (10665,'LONEP',1,'1997-09-11','1997-10-09','1997-09-17',2,26.31,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA'),
  (10666,'RICSU',7,'1997-09-12','1997-10-10','1997-09-22',2,232.42,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (10667,'ERNSH',7,'1997-09-12','1997-10-10','1997-09-19',1,78.09,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10668,'WANDK',1,'1997-09-15','1997-10-13','1997-09-23',2,47.22,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (10669,'SIMOB',2,'1997-09-15','1997-10-13','1997-09-22',1,24.39,'Simons bistro','Vinb�ltet 34','Kobenhavn',NULL,'1734','Denmark'),
  (10670,'FRANK',4,'1997-09-16','1997-10-14','1997-09-18',1,203.48,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10671,'FRANR',1,'1997-09-17','1997-10-15','1997-09-24',1,30.34,'France restauration','54, rue Royale','Nantes',NULL,'44000','France'),
  (10672,'BERGS',9,'1997-09-17','1997-10-01','1997-09-26',2,95.75,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10673,'WILMK',2,'1997-09-18','1997-10-16','1997-09-19',1,22.76,'Wilman Kala','Keskuskatu 45','Helsinki',NULL,'21240','Finland'),
  (10674,'ISLAT',4,'1997-09-18','1997-10-16','1997-09-30',2,0.9,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10675,'FRANK',5,'1997-09-19','1997-10-17','1997-09-23',2,31.85,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10676,'TORTU',2,'1997-09-22','1997-10-20','1997-09-29',2,2.01,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10677,'ANTON',1,'1997-09-22','1997-10-20','1997-09-26',3,4.03,'Antonio Moreno Taquer�a','Mataderos  2312','M�xico D.F.',NULL,'05023','Mexico'),
  (10678,'SAVEA',7,'1997-09-23','1997-10-21','1997-10-16',3,388.98,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10679,'BLONP',8,'1997-09-23','1997-10-21','1997-09-30',3,27.94,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10680,'OLDWO',1,'1997-09-24','1997-10-22','1997-09-26',1,26.61,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10681,'GREAL',3,'1997-09-25','1997-10-23','1997-09-30',3,76.13,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (10682,'ANTON',3,'1997-09-25','1997-10-23','1997-10-01',2,36.13,'Antonio Moreno Taquer�a','Mataderos  2312','M�xico D.F.',NULL,'05023','Mexico'),
  (10683,'DUMON',2,'1997-09-26','1997-10-24','1997-10-01',1,4.4,'Du monde entier','67, rue des Cinquante Otages','Nantes',NULL,'44000','France'),
  (10684,'OTTIK',3,'1997-09-26','1997-10-24','1997-09-30',1,145.63,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (10685,'GOURL',4,'1997-09-29','1997-10-13','1997-10-03',2,33.75,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (10686,'PICCO',2,'1997-09-30','1997-10-28','1997-10-08',1,96.5,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (10687,'HUNGO',9,'1997-09-30','1997-10-28','1997-10-30',2,296.43,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10688,'VAFFE',4,'1997-10-01','1997-10-15','1997-10-07',2,299.09,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10689,'BERGS',1,'1997-10-01','1997-10-29','1997-10-07',2,13.42,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10690,'HANAR',1,'1997-10-02','1997-10-30','1997-10-03',1,15.8,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10691,'QUICK',2,'1997-10-03','1997-11-14','1997-10-22',2,810.05,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10692,'ALFKI',4,'1997-10-03','1997-10-31','1997-10-13',2,61.02,'Alfred''s Futterkiste','Obere Str. 57','Berlin',NULL,'12209','Germany'),
  (10693,'WHITC',3,'1997-10-06','1997-10-20','1997-10-10',3,139.34,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10694,'QUICK',8,'1997-10-06','1997-11-03','1997-10-09',3,398.36,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10695,'WILMK',7,'1997-10-07','1997-11-18','1997-10-14',1,16.72,'Wilman Kala','Keskuskatu 45','Helsinki',NULL,'21240','Finland'),
  (10696,'WHITC',8,'1997-10-08','1997-11-19','1997-10-14',3,102.55,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10697,'LINOD',3,'1997-10-08','1997-11-05','1997-10-14',1,45.52,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10698,'ERNSH',4,'1997-10-09','1997-11-06','1997-10-17',1,272.47,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10699,'MORGK',3,'1997-10-09','1997-11-06','1997-10-13',3,0.58,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',NULL,'04179','Germany'),
  (10700,'SAVEA',3,'1997-10-10','1997-11-07','1997-10-16',1,65.1,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10701,'HUNGO',6,'1997-10-13','1997-10-27','1997-10-15',3,220.31,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10702,'ALFKI',4,'1997-10-13','1997-11-24','1997-10-21',1,23.94,'Alfred''s Futterkiste','Obere Str. 57','Berlin',NULL,'12209','Germany'),
  (10703,'FOLKO',6,'1997-10-14','1997-11-11','1997-10-20',2,152.3,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10704,'QUEEN',6,'1997-10-14','1997-11-11','1997-11-07',1,4.78,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10705,'HILAA',9,'1997-10-15','1997-11-12','1997-11-18',2,3.52,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10706,'OLDWO',8,'1997-10-16','1997-11-13','1997-10-21',3,135.63,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10707,'AROUT',4,'1997-10-16','1997-10-30','1997-10-23',3,21.74,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10708,'THEBI',6,'1997-10-17','1997-11-28','1997-11-05',2,2.96,'The Big Cheese','89 Jefferson Way Suite 2','Portland','OR','97201','USA'),
  (10709,'GOURL',1,'1997-10-17','1997-11-14','1997-11-20',3,210.8,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (10710,'FRANS',1,'1997-10-20','1997-11-17','1997-10-23',1,4.98,'Franchi S.p.A.','Via Monte Bianco 34','Torino',NULL,'10100','Italy'),
  (10711,'SAVEA',5,'1997-10-21','1997-12-02','1997-10-29',2,52.41,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10712,'HUNGO',3,'1997-10-21','1997-11-18','1997-10-31',1,89.93,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10713,'SAVEA',1,'1997-10-22','1997-11-19','1997-10-24',1,167.05,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10714,'SAVEA',5,'1997-10-22','1997-11-19','1997-10-27',3,24.49,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10715,'BONAP',3,'1997-10-23','1997-11-06','1997-10-29',1,63.2,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10716,'RANCH',4,'1997-10-24','1997-11-21','1997-10-27',2,22.57,'Rancho grande','Av. del Libertador 900','Buenos Aires',NULL,'1010','Argentina'),
  (10717,'FRANK',1,'1997-10-24','1997-11-21','1997-10-29',2,59.25,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10718,'KOENE',1,'1997-10-27','1997-11-24','1997-10-29',3,170.88,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10719,'LETSS',8,'1997-10-27','1997-11-24','1997-11-05',2,51.44,'Let''s Stop N Shop','87 Polk St. Suite 5','San Francisco','CA','94117','USA'),
  (10720,'QUEDE',8,'1997-10-28','1997-11-11','1997-11-05',2,9.53,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10721,'QUICK',5,'1997-10-29','1997-11-26','1997-10-31',3,48.92,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10722,'SAVEA',8,'1997-10-29','1997-12-10','1997-11-04',1,74.58,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10723,'WHITC',3,'1997-10-30','1997-11-27','1997-11-25',1,21.72,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10724,'MEREP',8,'1997-10-30','1997-12-11','1997-11-05',2,57.75,'M�re Paillarde','43 rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada'),
  (10725,'FAMIA',4,'1997-10-31','1997-11-28','1997-11-05',3,10.83,'Familia Arquibaldo','Rua Or�s, 92','Sao Paulo','SP','05442-030','Brazil'),
  (10726,'EASTC',4,'1997-11-03','1997-11-17','1997-12-05',1,16.56,'Eastern Connection','35 King George','London',NULL,'WX3 6FW','UK'),
  (10727,'REGGC',2,'1997-11-03','1997-12-01','1997-12-05',1,89.9,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10728,'QUEEN',4,'1997-11-04','1997-12-02','1997-11-11',2,58.33,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10729,'LINOD',8,'1997-11-04','1997-12-16','1997-11-14',3,141.06,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10730,'BONAP',5,'1997-11-05','1997-12-03','1997-11-14',1,20.12,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10731,'CHOPS',7,'1997-11-06','1997-12-04','1997-11-14',1,96.65,'Chop-suey Chinese','Hauptstr. 31','Bern',NULL,'3012','Switzerland'),
  (10732,'BONAP',3,'1997-11-06','1997-12-04','1997-11-07',1,16.97,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10733,'BERGS',1,'1997-11-07','1997-12-05','1997-11-10',3,110.11,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10734,'GOURL',2,'1997-11-07','1997-12-05','1997-11-12',3,1.63,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (10735,'LETSS',6,'1997-11-10','1997-12-08','1997-11-21',2,45.97,'Let''s Stop N Shop','87 Polk St. Suite 5','San Francisco','CA','94117','USA'),
  (10736,'HUNGO',9,'1997-11-11','1997-12-09','1997-11-21',2,44.1,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10737,'VINET',2,'1997-11-11','1997-12-09','1997-11-18',2,7.79,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',NULL,'51100','France'),
  (10738,'SPECD',2,'1997-11-12','1997-12-10','1997-11-18',1,2.91,'Sp�cialit�s du monde','25, rue Lauriston','Paris',NULL,'75016','France'),
  (10739,'VINET',3,'1997-11-12','1997-12-10','1997-11-17',3,11.08,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',NULL,'51100','France'),
  (10740,'WHITC',4,'1997-11-13','1997-12-11','1997-11-25',2,81.88,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10741,'AROUT',4,'1997-11-14','1997-11-28','1997-11-18',3,10.96,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10742,'BOTTM',3,'1997-11-14','1997-12-12','1997-11-18',3,243.73,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10743,'AROUT',1,'1997-11-17','1997-12-15','1997-11-21',2,23.72,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10744,'VAFFE',6,'1997-11-17','1997-12-15','1997-11-24',1,69.19,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10745,'QUICK',9,'1997-11-18','1997-12-16','1997-11-27',1,3.52,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10746,'CHOPS',1,'1997-11-19','1997-12-17','1997-11-21',3,31.43,'Chop-suey Chinese','Hauptstr. 31','Bern',NULL,'3012','Switzerland'),
  (10747,'PICCO',6,'1997-11-19','1997-12-17','1997-11-26',1,117.33,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria');

COMMIT;

#
# Data for the `Orders` table  (LIMIT 500,500)
#

INSERT INTO `Orders` (`OrderID`, `CustomerID`, `EmployeeID`, `OrderDate`, `RequiredDate`, `ShippedDate`, `ShipVia`, `Freight`, `ShipName`, `ShipAddress`, `ShipCity`, `ShipRegion`, `ShipPostalCode`, `ShipCountry`) VALUES 
  (10748,'SAVEA',3,'1997-11-20','1997-12-18','1997-11-28',1,232.55,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10749,'ISLAT',4,'1997-11-20','1997-12-18','1997-12-19',2,61.53,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10750,'WARTH',9,'1997-11-21','1997-12-19','1997-11-24',1,79.3,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10751,'RICSU',3,'1997-11-24','1997-12-22','1997-12-03',3,130.79,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (10752,'NORTS',2,'1997-11-24','1997-12-22','1997-11-28',3,1.39,'North/South','South House 300 Queensbridge','London',NULL,'SW7 1RZ','UK'),
  (10753,'FRANS',3,'1997-11-25','1997-12-23','1997-11-27',1,7.7,'Franchi S.p.A.','Via Monte Bianco 34','Torino',NULL,'10100','Italy'),
  (10754,'MAGAA',6,'1997-11-25','1997-12-23','1997-11-27',3,2.38,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10755,'BONAP',4,'1997-11-26','1997-12-24','1997-11-28',2,16.71,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10756,'SPLIR',8,'1997-11-27','1997-12-25','1997-12-02',2,73.21,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10757,'SAVEA',6,'1997-11-27','1997-12-25','1997-12-15',1,8.19,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10758,'RICSU',3,'1997-11-28','1997-12-26','1997-12-04',3,138.17,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (10759,'ANATR',3,'1997-11-28','1997-12-26','1997-12-12',3,11.99,'Ana Trujillo Emparedados y helados','Avda. de la Constituci�n 2222','M�xico D.F.',NULL,'05021','Mexico'),
  (10760,'MAISD',4,'1997-12-01','1997-12-29','1997-12-10',1,155.64,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',NULL,'B-1180','Belgium'),
  (10761,'RATTC',5,'1997-12-02','1997-12-30','1997-12-08',2,18.66,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10762,'FOLKO',3,'1997-12-02','1997-12-30','1997-12-09',1,328.74,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10763,'FOLIG',3,'1997-12-03','1997-12-31','1997-12-08',3,37.35,'Folies gourmandes','184, chauss�e de Tournai','Lille',NULL,'59000','France'),
  (10764,'ERNSH',6,'1997-12-03','1997-12-31','1997-12-08',3,145.45,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10765,'QUICK',3,'1997-12-04','1998-01-01','1997-12-09',3,42.74,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10766,'OTTIK',4,'1997-12-05','1998-01-02','1997-12-09',1,157.55,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (10767,'SUPRD',4,'1997-12-05','1998-01-02','1997-12-15',3,1.59,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10768,'AROUT',3,'1997-12-08','1998-01-05','1997-12-15',2,146.32,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10769,'VAFFE',3,'1997-12-08','1998-01-05','1997-12-12',1,65.06,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10770,'HANAR',8,'1997-12-09','1998-01-06','1997-12-17',3,5.32,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10771,'ERNSH',9,'1997-12-10','1998-01-07','1998-01-02',2,11.19,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10772,'LEHMS',3,'1997-12-10','1998-01-07','1997-12-19',2,91.28,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10773,'ERNSH',1,'1997-12-11','1998-01-08','1997-12-16',3,96.43,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10774,'FOLKO',4,'1997-12-11','1997-12-25','1997-12-12',1,48.2,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10775,'THECR',7,'1997-12-12','1998-01-09','1997-12-26',1,20.25,'The Cracker Box','55 Grizzly Peak Rd.','Butte','MT','59801','USA'),
  (10776,'ERNSH',1,'1997-12-15','1998-01-12','1997-12-18',3,351.53,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10777,'GOURL',7,'1997-12-15','1997-12-29','1998-01-21',2,3.01,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (10778,'BERGS',3,'1997-12-16','1998-01-13','1997-12-24',1,6.79,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10779,'MORGK',3,'1997-12-16','1998-01-13','1998-01-14',2,58.13,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',NULL,'04179','Germany'),
  (10780,'LILAS',2,'1997-12-16','1997-12-30','1997-12-25',1,42.13,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10781,'WARTH',2,'1997-12-17','1998-01-14','1997-12-19',3,73.16,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (10782,'CACTU',9,'1997-12-17','1998-01-14','1997-12-22',3,1.1,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',NULL,'1010','Argentina'),
  (10783,'HANAR',4,'1997-12-18','1998-01-15','1997-12-19',2,124.98,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10784,'MAGAA',4,'1997-12-18','1998-01-15','1997-12-22',3,70.09,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10785,'GROSR',1,'1997-12-18','1998-01-15','1997-12-24',3,1.51,'GROSELLA-Restaurante','5� Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela'),
  (10786,'QUEEN',8,'1997-12-19','1998-01-16','1997-12-23',1,110.87,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10787,'LAMAI',2,'1997-12-19','1998-01-02','1997-12-26',1,249.93,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10788,'QUICK',1,'1997-12-22','1998-01-19','1998-01-19',2,42.7,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10789,'FOLIG',1,'1997-12-22','1998-01-19','1997-12-31',2,100.6,'Folies gourmandes','184, chauss�e de Tournai','Lille',NULL,'59000','France'),
  (10790,'GOURL',6,'1997-12-22','1998-01-19','1997-12-26',1,28.23,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (10791,'FRANK',6,'1997-12-23','1998-01-20','1998-01-01',2,16.85,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10792,'WOLZA',1,'1997-12-23','1998-01-20','1997-12-31',3,23.79,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',NULL,'01-012','Poland'),
  (10793,'AROUT',3,'1997-12-24','1998-01-21','1998-01-08',3,4.52,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10794,'QUEDE',6,'1997-12-24','1998-01-21','1998-01-02',1,21.49,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10795,'ERNSH',8,'1997-12-24','1998-01-21','1998-01-20',2,126.66,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10796,'HILAA',3,'1997-12-25','1998-01-22','1998-01-14',1,26.52,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10797,'DRACD',7,'1997-12-25','1998-01-22','1998-01-05',2,33.35,'Drachenblut Delikatessen','Walserweg 21','Aachen',NULL,'52066','Germany'),
  (10798,'ISLAT',2,'1997-12-26','1998-01-23','1998-01-05',1,2.33,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10799,'KOENE',9,'1997-12-26','1998-02-06','1998-01-05',3,30.76,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10800,'SEVES',1,'1997-12-26','1998-01-23','1998-01-05',3,137.44,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10801,'BOLID',4,'1997-12-29','1998-01-26','1997-12-31',2,97.09,'B�lido Comidas preparadas','C/ Araquil, 67','Madrid',NULL,'28023','Spain'),
  (10802,'SIMOB',4,'1997-12-29','1998-01-26','1998-01-02',2,257.26,'Simons bistro','Vinb�ltet 34','Kobenhavn',NULL,'1734','Denmark'),
  (10803,'WELLI',4,'1997-12-30','1998-01-27','1998-01-06',1,55.23,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10804,'SEVES',6,'1997-12-30','1998-01-27','1998-01-07',2,27.33,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10805,'THEBI',2,'1997-12-30','1998-01-27','1998-01-09',3,237.34,'The Big Cheese','89 Jefferson Way Suite 2','Portland','OR','97201','USA'),
  (10806,'VICTE',3,'1997-12-31','1998-01-28','1998-01-05',2,22.11,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10807,'FRANS',4,'1997-12-31','1998-01-28','1998-01-30',1,1.36,'Franchi S.p.A.','Via Monte Bianco 34','Torino',NULL,'10100','Italy'),
  (10808,'OLDWO',2,'1998-01-01','1998-01-29','1998-01-09',3,45.53,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10809,'WELLI',7,'1998-01-01','1998-01-29','1998-01-07',1,4.87,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10810,'LAUGB',2,'1998-01-01','1998-01-29','1998-01-07',3,4.33,'Laughing Bacchus Wine Cellars','2319 Elm St.','Vancouver','BC','V3F 2K1','Canada'),
  (10811,'LINOD',8,'1998-01-02','1998-01-30','1998-01-08',1,31.22,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10812,'REGGC',5,'1998-01-02','1998-01-30','1998-01-12',1,59.78,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10813,'RICAR',1,'1998-01-05','1998-02-02','1998-01-09',1,47.38,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10814,'VICTE',3,'1998-01-05','1998-02-02','1998-01-14',3,130.94,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10815,'SAVEA',2,'1998-01-05','1998-02-02','1998-01-14',3,14.62,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10816,'GREAL',4,'1998-01-06','1998-02-03','1998-02-04',2,719.78,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (10817,'KOENE',3,'1998-01-06','1998-01-20','1998-01-13',2,306.07,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10818,'MAGAA',7,'1998-01-07','1998-02-04','1998-01-12',3,65.48,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10819,'CACTU',2,'1998-01-07','1998-02-04','1998-01-16',3,19.76,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',NULL,'1010','Argentina'),
  (10820,'RATTC',3,'1998-01-07','1998-02-04','1998-01-13',2,37.52,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10821,'SPLIR',1,'1998-01-08','1998-02-05','1998-01-15',1,36.68,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10822,'TRAIH',6,'1998-01-08','1998-02-05','1998-01-16',3,7,'Trail''s Head Gourmet Provisioners','722 DaVinci Blvd.','Kirkland','WA','98034','USA'),
  (10823,'LILAS',5,'1998-01-09','1998-02-06','1998-01-13',2,163.97,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10824,'FOLKO',8,'1998-01-09','1998-02-06','1998-01-30',1,1.23,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10825,'DRACD',1,'1998-01-09','1998-02-06','1998-01-14',1,79.25,'Drachenblut Delikatessen','Walserweg 21','Aachen',NULL,'52066','Germany'),
  (10826,'BLONP',6,'1998-01-12','1998-02-09','1998-02-06',1,7.09,'Blondel p�re et fils','24, place Kl�ber','Strasbourg',NULL,'67000','France'),
  (10827,'BONAP',1,'1998-01-12','1998-01-26','1998-02-06',2,63.54,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10828,'RANCH',9,'1998-01-13','1998-01-27','1998-02-04',1,90.85,'Rancho grande','Av. del Libertador 900','Buenos Aires',NULL,'1010','Argentina'),
  (10829,'ISLAT',9,'1998-01-13','1998-02-10','1998-01-23',1,154.72,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10830,'TRADH',4,'1998-01-13','1998-02-24','1998-01-21',2,81.83,'Tradi�ao Hipermercados','Av. In�s de Castro, 414','Sao Paulo','SP','05634-030','Brazil'),
  (10831,'SANTG',3,'1998-01-14','1998-02-11','1998-01-23',2,72.19,'Sant� Gourmet','Erling Skakkes gate 78','Stavern',NULL,'4110','Norway'),
  (10832,'LAMAI',2,'1998-01-14','1998-02-11','1998-01-19',2,43.26,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10833,'OTTIK',6,'1998-01-15','1998-02-12','1998-01-23',2,71.49,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (10834,'TRADH',1,'1998-01-15','1998-02-12','1998-01-19',3,29.78,'Tradi�ao Hipermercados','Av. In�s de Castro, 414','Sao Paulo','SP','05634-030','Brazil'),
  (10835,'ALFKI',1,'1998-01-15','1998-02-12','1998-01-21',3,69.53,'Alfred''s Futterkiste','Obere Str. 57','Berlin',NULL,'12209','Germany'),
  (10836,'ERNSH',7,'1998-01-16','1998-02-13','1998-01-21',1,411.88,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10837,'BERGS',9,'1998-01-16','1998-02-13','1998-01-23',3,13.32,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10838,'LINOD',3,'1998-01-19','1998-02-16','1998-01-23',3,59.28,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10839,'TRADH',3,'1998-01-19','1998-02-16','1998-01-22',3,35.43,'Tradi�ao Hipermercados','Av. In�s de Castro, 414','Sao Paulo','SP','05634-030','Brazil'),
  (10840,'LINOD',4,'1998-01-19','1998-03-02','1998-02-16',2,2.71,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10841,'SUPRD',5,'1998-01-20','1998-02-17','1998-01-29',2,424.3,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10842,'TORTU',1,'1998-01-20','1998-02-17','1998-01-29',3,54.42,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10843,'VICTE',4,'1998-01-21','1998-02-18','1998-01-26',2,9.26,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10844,'PICCO',8,'1998-01-21','1998-02-18','1998-01-26',2,25.22,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (10845,'QUICK',8,'1998-01-21','1998-02-04','1998-01-30',1,212.98,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10846,'SUPRD',2,'1998-01-22','1998-03-05','1998-01-23',3,56.46,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10847,'SAVEA',4,'1998-01-22','1998-02-05','1998-02-10',3,487.57,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10848,'CONSH',7,'1998-01-23','1998-02-20','1998-01-29',2,38.24,'Consolidated Holdings','Berkeley Gardens 12  Brewery','London',NULL,'WX1 6LT','UK'),
  (10849,'KOENE',9,'1998-01-23','1998-02-20','1998-01-30',2,0.56,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10850,'VICTE',1,'1998-01-23','1998-03-06','1998-01-30',1,49.19,'Victuailles en stock','2, rue du Commerce','Lyon',NULL,'69004','France'),
  (10851,'RICAR',5,'1998-01-26','1998-02-23','1998-02-02',1,160.55,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10852,'RATTC',8,'1998-01-26','1998-02-09','1998-01-30',1,174.05,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10853,'BLAUS',9,'1998-01-27','1998-02-24','1998-02-03',2,53.83,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',NULL,'68306','Germany'),
  (10854,'ERNSH',3,'1998-01-27','1998-02-24','1998-02-05',2,100.22,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10855,'OLDWO',3,'1998-01-27','1998-02-24','1998-02-04',1,170.97,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10856,'ANTON',3,'1998-01-28','1998-02-25','1998-02-10',2,58.43,'Antonio Moreno Taquer�a','Mataderos  2312','M�xico D.F.',NULL,'05023','Mexico'),
  (10857,'BERGS',8,'1998-01-28','1998-02-25','1998-02-06',2,188.85,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10858,'LACOR',2,'1998-01-29','1998-02-26','1998-02-03',1,52.51,'La corne d''abondance','67, avenue de l''Europe','Versailles',NULL,'78000','France'),
  (10859,'FRANK',1,'1998-01-29','1998-02-26','1998-02-02',2,76.1,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10860,'FRANR',3,'1998-01-29','1998-02-26','1998-02-04',3,19.26,'France restauration','54, rue Royale','Nantes',NULL,'44000','France'),
  (10861,'WHITC',4,'1998-01-30','1998-02-27','1998-02-17',2,14.93,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10862,'LEHMS',8,'1998-01-30','1998-03-13','1998-02-02',2,53.23,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10863,'HILAA',4,'1998-02-02','1998-03-02','1998-02-17',2,30.26,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10864,'AROUT',4,'1998-02-02','1998-03-02','1998-02-09',2,3.04,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10865,'QUICK',2,'1998-02-02','1998-02-16','1998-02-12',1,348.14,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10866,'BERGS',5,'1998-02-03','1998-03-03','1998-02-12',1,109.11,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10867,'LONEP',6,'1998-02-03','1998-03-17','1998-02-11',1,1.93,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA'),
  (10868,'QUEEN',7,'1998-02-04','1998-03-04','1998-02-23',2,191.27,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10869,'SEVES',5,'1998-02-04','1998-03-04','1998-02-09',1,143.28,'Seven Seas Imports','90 Wadhurst Rd.','London',NULL,'OX15 4NB','UK'),
  (10870,'WOLZA',5,'1998-02-04','1998-03-04','1998-02-13',3,12.04,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',NULL,'01-012','Poland'),
  (10871,'BONAP',9,'1998-02-05','1998-03-05','1998-02-10',2,112.27,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10872,'GODOS',5,'1998-02-05','1998-03-05','1998-02-09',2,175.32,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (10873,'WILMK',4,'1998-02-06','1998-03-06','1998-02-09',1,0.82,'Wilman Kala','Keskuskatu 45','Helsinki',NULL,'21240','Finland'),
  (10874,'GODOS',5,'1998-02-06','1998-03-06','1998-02-11',2,19.58,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (10875,'BERGS',4,'1998-02-06','1998-03-06','1998-03-03',2,32.37,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10876,'BONAP',7,'1998-02-09','1998-03-09','1998-02-12',3,60.42,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10877,'RICAR',1,'1998-02-09','1998-03-09','1998-02-19',1,38.06,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (10878,'QUICK',4,'1998-02-10','1998-03-10','1998-02-12',1,46.69,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10879,'WILMK',3,'1998-02-10','1998-03-10','1998-02-12',3,8.5,'Wilman Kala','Keskuskatu 45','Helsinki',NULL,'21240','Finland'),
  (10880,'FOLKO',7,'1998-02-10','1998-03-24','1998-02-18',1,88.01,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10881,'CACTU',4,'1998-02-11','1998-03-11','1998-02-18',1,2.84,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',NULL,'1010','Argentina'),
  (10882,'SAVEA',4,'1998-02-11','1998-03-11','1998-02-20',3,23.1,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10883,'LONEP',8,'1998-02-12','1998-03-12','1998-02-20',3,0.53,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA'),
  (10884,'LETSS',4,'1998-02-12','1998-03-12','1998-02-13',2,90.97,'Let''s Stop N Shop','87 Polk St. Suite 5','San Francisco','CA','94117','USA'),
  (10885,'SUPRD',6,'1998-02-12','1998-03-12','1998-02-18',3,5.64,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10886,'HANAR',1,'1998-02-13','1998-03-13','1998-03-02',1,4.99,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10887,'GALED',8,'1998-02-13','1998-03-13','1998-02-16',3,1.25,'Galer�a del gastron�mo','Rambla de Catalu�a, 23','Barcelona',NULL,'8022','Spain'),
  (10888,'GODOS',1,'1998-02-16','1998-03-16','1998-02-23',2,51.87,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (10889,'RATTC',9,'1998-02-16','1998-03-16','1998-02-23',3,280.61,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10890,'DUMON',7,'1998-02-16','1998-03-16','1998-02-18',1,32.76,'Du monde entier','67, rue des Cinquante Otages','Nantes',NULL,'44000','France'),
  (10891,'LEHMS',7,'1998-02-17','1998-03-17','1998-02-19',2,20.37,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10892,'MAISD',4,'1998-02-17','1998-03-17','1998-02-19',2,120.27,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',NULL,'B-1180','Belgium'),
  (10893,'KOENE',9,'1998-02-18','1998-03-18','1998-02-20',2,77.78,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (10894,'SAVEA',1,'1998-02-18','1998-03-18','1998-02-20',1,116.13,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10895,'ERNSH',3,'1998-02-18','1998-03-18','1998-02-23',1,162.75,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10896,'MAISD',7,'1998-02-19','1998-03-19','1998-02-27',3,32.45,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',NULL,'B-1180','Belgium'),
  (10897,'HUNGO',3,'1998-02-19','1998-03-19','1998-02-25',2,603.54,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10898,'OCEAN',4,'1998-02-20','1998-03-20','1998-03-06',2,1.27,'Oc�ano Atl�ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',NULL,'1010','Argentina'),
  (10899,'LILAS',5,'1998-02-20','1998-03-20','1998-02-26',3,1.21,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10900,'WELLI',1,'1998-02-20','1998-03-20','1998-03-04',2,1.66,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10901,'HILAA',4,'1998-02-23','1998-03-23','1998-02-26',1,62.09,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10902,'FOLKO',1,'1998-02-23','1998-03-23','1998-03-03',1,44.15,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10903,'HANAR',3,'1998-02-24','1998-03-24','1998-03-04',3,36.71,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10904,'WHITC',3,'1998-02-24','1998-03-24','1998-02-27',3,162.95,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (10905,'WELLI',9,'1998-02-24','1998-03-24','1998-03-06',2,13.72,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10906,'WOLZA',4,'1998-02-25','1998-03-11','1998-03-03',3,26.29,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',NULL,'01-012','Poland'),
  (10907,'SPECD',6,'1998-02-25','1998-03-25','1998-02-27',3,9.19,'Sp�cialit�s du monde','25, rue Lauriston','Paris',NULL,'75016','France'),
  (10908,'REGGC',4,'1998-02-26','1998-03-26','1998-03-06',2,32.96,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10909,'SANTG',1,'1998-02-26','1998-03-26','1998-03-10',2,53.05,'Sant� Gourmet','Erling Skakkes gate 78','Stavern',NULL,'4110','Norway'),
  (10910,'WILMK',1,'1998-02-26','1998-03-26','1998-03-04',3,38.11,'Wilman Kala','Keskuskatu 45','Helsinki',NULL,'21240','Finland'),
  (10911,'GODOS',3,'1998-02-26','1998-03-26','1998-03-05',1,38.19,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (10912,'HUNGO',2,'1998-02-26','1998-03-26','1998-03-18',2,580.91,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10913,'QUEEN',4,'1998-02-26','1998-03-26','1998-03-04',1,33.05,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10914,'QUEEN',6,'1998-02-27','1998-03-27','1998-03-02',1,21.19,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10915,'TORTU',2,'1998-02-27','1998-03-27','1998-03-02',2,3.51,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (10916,'RANCH',1,'1998-02-27','1998-03-27','1998-03-09',2,63.77,'Rancho grande','Av. del Libertador 900','Buenos Aires',NULL,'1010','Argentina'),
  (10917,'ROMEY',4,'1998-03-02','1998-03-30','1998-03-11',2,8.29,'Romero y tomillo','Gran V�a, 1','Madrid',NULL,'28001','Spain'),
  (10918,'BOTTM',3,'1998-03-02','1998-03-30','1998-03-11',3,48.83,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10919,'LINOD',2,'1998-03-02','1998-03-30','1998-03-04',2,19.8,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10920,'AROUT',4,'1998-03-03','1998-03-31','1998-03-09',2,29.61,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10921,'VAFFE',1,'1998-03-03','1998-04-14','1998-03-09',1,176.48,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10922,'HANAR',5,'1998-03-03','1998-03-31','1998-03-05',3,62.74,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10923,'LAMAI',7,'1998-03-03','1998-04-14','1998-03-13',3,68.26,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (10924,'BERGS',3,'1998-03-04','1998-04-01','1998-04-08',2,151.52,'Berglunds snabbk�p','Berguvsv�gen  8','Lule�',NULL,'S-958 22','Sweden'),
  (10925,'HANAR',3,'1998-03-04','1998-04-01','1998-03-13',1,2.27,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10926,'ANATR',4,'1998-03-04','1998-04-01','1998-03-11',3,39.92,'Ana Trujillo Emparedados y helados','Avda. de la Constituci�n 2222','M�xico D.F.',NULL,'05021','Mexico'),
  (10927,'LACOR',4,'1998-03-05','1998-04-02','1998-04-08',1,19.79,'La corne d''abondance','67, avenue de l''Europe','Versailles',NULL,'78000','France'),
  (10928,'GALED',1,'1998-03-05','1998-04-02','1998-03-18',1,1.36,'Galer�a del gastron�mo','Rambla de Catalu�a, 23','Barcelona',NULL,'8022','Spain'),
  (10929,'FRANK',6,'1998-03-05','1998-04-02','1998-03-12',1,33.93,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (10930,'SUPRD',4,'1998-03-06','1998-04-17','1998-03-18',3,15.55,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (10931,'RICSU',4,'1998-03-06','1998-03-20','1998-03-19',2,13.6,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (10932,'BONAP',8,'1998-03-06','1998-04-03','1998-03-24',1,134.64,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10933,'ISLAT',6,'1998-03-06','1998-04-03','1998-03-16',3,54.15,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK'),
  (10934,'LEHMS',3,'1998-03-09','1998-04-06','1998-03-12',3,32.01,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (10935,'WELLI',4,'1998-03-09','1998-04-06','1998-03-18',3,47.59,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil'),
  (10936,'GREAL',3,'1998-03-09','1998-04-06','1998-03-18',2,33.68,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (10937,'CACTU',7,'1998-03-10','1998-03-24','1998-03-13',3,31.51,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',NULL,'1010','Argentina'),
  (10938,'QUICK',3,'1998-03-10','1998-04-07','1998-03-16',2,31.89,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10939,'MAGAA',2,'1998-03-10','1998-04-07','1998-03-13',2,76.33,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10940,'BONAP',8,'1998-03-11','1998-04-08','1998-03-23',3,19.77,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (10941,'SAVEA',7,'1998-03-11','1998-04-08','1998-03-20',2,400.81,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10942,'REGGC',9,'1998-03-11','1998-04-08','1998-03-18',3,17.95,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (10943,'BSBEV',4,'1998-03-11','1998-04-08','1998-03-19',2,2.17,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10944,'BOTTM',6,'1998-03-12','1998-03-26','1998-03-13',3,52.92,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10945,'MORGK',4,'1998-03-12','1998-04-09','1998-03-18',1,10.22,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',NULL,'04179','Germany'),
  (10946,'VAFFE',1,'1998-03-12','1998-04-09','1998-03-19',2,27.2,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10947,'BSBEV',3,'1998-03-13','1998-04-10','1998-03-16',2,3.26,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (10948,'GODOS',3,'1998-03-13','1998-04-10','1998-03-19',3,23.39,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (10949,'BOTTM',2,'1998-03-13','1998-04-10','1998-03-17',3,74.44,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10950,'MAGAA',1,'1998-03-16','1998-04-13','1998-03-23',2,2.5,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',NULL,'24100','Italy'),
  (10951,'RICSU',9,'1998-03-16','1998-04-27','1998-04-07',2,30.85,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (10952,'ALFKI',1,'1998-03-16','1998-04-27','1998-03-24',1,40.42,'Alfred''s Futterkiste','Obere Str. 57','Berlin',NULL,'12209','Germany'),
  (10953,'AROUT',9,'1998-03-16','1998-03-30','1998-03-25',2,23.72,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (10954,'LINOD',5,'1998-03-17','1998-04-28','1998-03-20',1,27.91,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (10955,'FOLKO',8,'1998-03-17','1998-04-14','1998-03-20',2,3.26,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10956,'BLAUS',6,'1998-03-17','1998-04-28','1998-03-20',2,44.65,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',NULL,'68306','Germany'),
  (10957,'HILAA',8,'1998-03-18','1998-04-15','1998-03-27',3,105.36,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10958,'OCEAN',7,'1998-03-18','1998-04-15','1998-03-27',2,49.56,'Oc�ano Atl�ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',NULL,'1010','Argentina'),
  (10959,'GOURL',6,'1998-03-18','1998-04-29','1998-03-23',2,4.98,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (10960,'HILAA',3,'1998-03-19','1998-04-02','1998-04-08',1,2.08,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10961,'QUEEN',8,'1998-03-19','1998-04-16','1998-03-30',1,104.47,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (10962,'QUICK',8,'1998-03-19','1998-04-16','1998-03-23',2,275.79,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10963,'FURIB',9,'1998-03-19','1998-04-16','1998-03-26',3,2.7,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',NULL,'1675','Portugal'),
  (10964,'SPECD',3,'1998-03-20','1998-04-17','1998-03-24',2,87.38,'Sp�cialit�s du monde','25, rue Lauriston','Paris',NULL,'75016','France'),
  (10965,'OLDWO',6,'1998-03-20','1998-04-17','1998-03-30',3,144.38,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (10966,'CHOPS',4,'1998-03-20','1998-04-17','1998-04-08',1,27.19,'Chop-suey Chinese','Hauptstr. 31','Bern',NULL,'3012','Switzerland'),
  (10967,'TOMSP',2,'1998-03-23','1998-04-20','1998-04-02',2,62.22,'Toms Spezialit�ten','Luisenstr. 48','M�nster',NULL,'44087','Germany'),
  (10968,'ERNSH',1,'1998-03-23','1998-04-20','1998-04-01',3,74.6,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10969,'COMMI',1,'1998-03-23','1998-04-20','1998-03-30',2,0.21,'Com�rcio Mineiro','Av. dos Lus�adas, 23','Sao Paulo','SP','05432-043','Brazil'),
  (10970,'BOLID',9,'1998-03-24','1998-04-07','1998-04-24',1,16.16,'B�lido Comidas preparadas','C/ Araquil, 67','Madrid',NULL,'28023','Spain'),
  (10971,'FRANR',2,'1998-03-24','1998-04-21','1998-04-02',2,121.82,'France restauration','54, rue Royale','Nantes',NULL,'44000','France'),
  (10972,'LACOR',4,'1998-03-24','1998-04-21','1998-03-26',2,0.02,'La corne d''abondance','67, avenue de l''Europe','Versailles',NULL,'78000','France'),
  (10973,'LACOR',6,'1998-03-24','1998-04-21','1998-03-27',2,15.17,'La corne d''abondance','67, avenue de l''Europe','Versailles',NULL,'78000','France'),
  (10974,'SPLIR',3,'1998-03-25','1998-04-08','1998-04-03',3,12.96,'Split Rail Beer & Ale','P.O. Box 555','Lander','WY','82520','USA'),
  (10975,'BOTTM',1,'1998-03-25','1998-04-22','1998-03-27',3,32.27,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10976,'HILAA',1,'1998-03-25','1998-05-06','1998-04-03',1,37.97,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (10977,'FOLKO',8,'1998-03-26','1998-04-23','1998-04-10',3,208.5,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10978,'MAISD',9,'1998-03-26','1998-04-23','1998-04-23',2,32.82,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',NULL,'B-1180','Belgium'),
  (10979,'ERNSH',8,'1998-03-26','1998-04-23','1998-03-31',2,353.07,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10980,'FOLKO',4,'1998-03-27','1998-05-08','1998-04-17',1,1.26,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10981,'HANAR',1,'1998-03-27','1998-04-24','1998-04-02',2,193.37,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (10982,'BOTTM',2,'1998-03-27','1998-04-24','1998-04-08',1,14.01,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (10983,'SAVEA',2,'1998-03-27','1998-04-24','1998-04-06',2,657.54,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10984,'SAVEA',1,'1998-03-30','1998-04-27','1998-04-03',3,211.22,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (10985,'HUNGO',2,'1998-03-30','1998-04-27','1998-04-02',1,91.51,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (10986,'OCEAN',8,'1998-03-30','1998-04-27','1998-04-21',2,217.86,'Oc�ano Atl�ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',NULL,'1010','Argentina'),
  (10987,'EASTC',8,'1998-03-31','1998-04-28','1998-04-06',1,185.48,'Eastern Connection','35 King George','London',NULL,'WX3 6FW','UK'),
  (10988,'RATTC',3,'1998-03-31','1998-04-28','1998-04-10',2,61.14,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (10989,'QUEDE',2,'1998-03-31','1998-04-28','1998-04-02',1,34.76,'Que Del�cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil'),
  (10990,'ERNSH',2,'1998-04-01','1998-05-13','1998-04-07',3,117.61,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (10991,'QUICK',1,'1998-04-01','1998-04-29','1998-04-07',1,38.51,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10992,'THEBI',1,'1998-04-01','1998-04-29','1998-04-03',3,4.27,'The Big Cheese','89 Jefferson Way Suite 2','Portland','OR','97201','USA'),
  (10993,'FOLKO',7,'1998-04-01','1998-04-29','1998-04-10',3,8.81,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (10994,'VAFFE',2,'1998-04-02','1998-04-16','1998-04-09',3,65.53,'Vaffeljernet','Smagsloget 45','�rhus',NULL,'8200','Denmark'),
  (10995,'PERIC',1,'1998-04-02','1998-04-30','1998-04-06',3,46,'Pericles Comidas cl�sicas','Calle Dr. Jorge Cash 321','M�xico D.F.',NULL,'05033','Mexico'),
  (10996,'QUICK',4,'1998-04-02','1998-04-30','1998-04-10',2,1.12,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (10997,'LILAS',8,'1998-04-03','1998-05-15','1998-04-13',2,73.91,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (10998,'WOLZA',8,'1998-04-03','1998-04-17','1998-04-17',2,20.31,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',NULL,'01-012','Poland'),
  (10999,'OTTIK',6,'1998-04-03','1998-05-01','1998-04-10',2,96.35,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (11000,'RATTC',2,'1998-04-06','1998-05-04','1998-04-14',3,55.12,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA'),
  (11001,'FOLKO',2,'1998-04-06','1998-05-04','1998-04-14',2,197.3,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (11002,'SAVEA',4,'1998-04-06','1998-05-04','1998-04-16',1,141.16,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (11003,'THECR',3,'1998-04-06','1998-05-04','1998-04-08',3,14.91,'The Cracker Box','55 Grizzly Peak Rd.','Butte','MT','59801','USA'),
  (11004,'MAISD',3,'1998-04-07','1998-05-05','1998-04-20',1,44.84,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',NULL,'B-1180','Belgium'),
  (11005,'WILMK',2,'1998-04-07','1998-05-05','1998-04-10',1,0.75,'Wilman Kala','Keskuskatu 45','Helsinki',NULL,'21240','Finland'),
  (11006,'GREAL',3,'1998-04-07','1998-05-05','1998-04-15',2,25.19,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (11007,'PRINI',8,'1998-04-08','1998-05-06','1998-04-13',2,202.24,'Princesa Isabel Vinhos','Estrada da sa�de n. 58','Lisboa',NULL,'1756','Portugal'),
  (11008,'ERNSH',7,'1998-04-08','1998-05-06',NULL,3,79.46,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (11009,'GODOS',2,'1998-04-08','1998-05-06','1998-04-10',1,59.11,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (11010,'REGGC',2,'1998-04-09','1998-05-07','1998-04-21',2,28.71,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (11011,'ALFKI',3,'1998-04-09','1998-05-07','1998-04-13',1,1.21,'Alfred''s Futterkiste','Obere Str. 57','Berlin',NULL,'12209','Germany'),
  (11012,'FRANK',1,'1998-04-09','1998-04-23','1998-04-17',3,242.95,'Frankenversand','Berliner Platz 43','M�nchen',NULL,'80805','Germany'),
  (11013,'ROMEY',2,'1998-04-09','1998-05-07','1998-04-10',1,32.99,'Romero y tomillo','Gran V�a, 1','Madrid',NULL,'28001','Spain'),
  (11014,'LINOD',2,'1998-04-10','1998-05-08','1998-04-15',3,23.6,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (11015,'SANTG',2,'1998-04-10','1998-04-24','1998-04-20',2,4.62,'Sant� Gourmet','Erling Skakkes gate 78','Stavern',NULL,'4110','Norway'),
  (11016,'AROUT',9,'1998-04-10','1998-05-08','1998-04-13',2,33.8,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK'),
  (11017,'ERNSH',9,'1998-04-13','1998-05-11','1998-04-20',2,754.26,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (11018,'LONEP',4,'1998-04-13','1998-05-11','1998-04-16',2,11.65,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA'),
  (11019,'RANCH',6,'1998-04-13','1998-05-11',NULL,3,3.17,'Rancho grande','Av. del Libertador 900','Buenos Aires',NULL,'1010','Argentina'),
  (11020,'OTTIK',2,'1998-04-14','1998-05-12','1998-04-16',2,43.3,'Ottilies K�seladen','Mehrheimerstr. 369','K�ln',NULL,'50739','Germany'),
  (11021,'QUICK',3,'1998-04-14','1998-05-12','1998-04-21',1,297.18,'QUICK-Stop','Taucherstra�e 10','Cunewalde',NULL,'01307','Germany'),
  (11022,'HANAR',9,'1998-04-14','1998-05-12','1998-05-04',2,6.27,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (11023,'BSBEV',1,'1998-04-14','1998-04-28','1998-04-24',2,123.83,'B''s Beverages','Fauntleroy Circus','London',NULL,'EC2 5NT','UK'),
  (11024,'EASTC',4,'1998-04-15','1998-05-13','1998-04-20',1,74.36,'Eastern Connection','35 King George','London',NULL,'WX3 6FW','UK'),
  (11025,'WARTH',6,'1998-04-15','1998-05-13','1998-04-24',3,29.17,'Wartian Herkku','Torikatu 38','Oulu',NULL,'90110','Finland'),
  (11026,'FRANS',4,'1998-04-15','1998-05-13','1998-04-28',1,47.09,'Franchi S.p.A.','Via Monte Bianco 34','Torino',NULL,'10100','Italy'),
  (11027,'BOTTM',1,'1998-04-16','1998-05-14','1998-04-20',1,52.52,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (11028,'KOENE',2,'1998-04-16','1998-05-14','1998-04-22',1,29.59,'K�niglich Essen','Maubelstr. 90','Brandenburg',NULL,'14776','Germany'),
  (11029,'CHOPS',4,'1998-04-16','1998-05-14','1998-04-27',1,47.84,'Chop-suey Chinese','Hauptstr. 31','Bern',NULL,'3012','Switzerland'),
  (11030,'SAVEA',7,'1998-04-17','1998-05-15','1998-04-27',2,830.75,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (11031,'SAVEA',6,'1998-04-17','1998-05-15','1998-04-24',2,227.22,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (11032,'WHITC',2,'1998-04-17','1998-05-15','1998-04-23',3,606.19,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (11033,'RICSU',7,'1998-04-17','1998-05-15','1998-04-23',3,84.74,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (11034,'OLDWO',8,'1998-04-20','1998-06-01','1998-04-27',1,40.32,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA'),
  (11035,'SUPRD',2,'1998-04-20','1998-05-18','1998-04-24',2,0.17,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (11036,'DRACD',8,'1998-04-20','1998-05-18','1998-04-22',3,149.47,'Drachenblut Delikatessen','Walserweg 21','Aachen',NULL,'52066','Germany'),
  (11037,'GODOS',7,'1998-04-21','1998-05-19','1998-04-27',1,3.2,'Godos Cocina T�pica','C/ Romero, 33','Sevilla',NULL,'41101','Spain'),
  (11038,'SUPRD',1,'1998-04-21','1998-05-19','1998-04-30',2,29.59,'Supr�mes d�lices','Boulevard Tirou, 255','Charleroi',NULL,'B-6000','Belgium'),
  (11039,'LINOD',1,'1998-04-21','1998-05-19',NULL,2,65,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela'),
  (11040,'GREAL',4,'1998-04-22','1998-05-20',NULL,3,18.84,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (11041,'CHOPS',3,'1998-04-22','1998-05-20','1998-04-28',2,48.22,'Chop-suey Chinese','Hauptstr. 31','Bern',NULL,'3012','Switzerland'),
  (11042,'COMMI',2,'1998-04-22','1998-05-06','1998-05-01',1,29.99,'Com�rcio Mineiro','Av. dos Lus�adas, 23','Sao Paulo','SP','05432-043','Brazil'),
  (11043,'SPECD',5,'1998-04-22','1998-05-20','1998-04-29',2,8.8,'Sp�cialit�s du monde','25, rue Lauriston','Paris',NULL,'75016','France'),
  (11044,'WOLZA',4,'1998-04-23','1998-05-21','1998-05-01',1,8.72,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',NULL,'01-012','Poland'),
  (11045,'BOTTM',6,'1998-04-23','1998-05-21',NULL,2,70.58,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (11046,'WANDK',8,'1998-04-23','1998-05-21','1998-04-24',2,71.64,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',NULL,'70563','Germany'),
  (11047,'EASTC',7,'1998-04-24','1998-05-22','1998-05-01',3,46.62,'Eastern Connection','35 King George','London',NULL,'WX3 6FW','UK'),
  (11048,'BOTTM',7,'1998-04-24','1998-05-22','1998-04-30',3,24.12,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada'),
  (11049,'GOURL',3,'1998-04-24','1998-05-22','1998-05-04',1,8.34,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil'),
  (11050,'FOLKO',8,'1998-04-27','1998-05-25','1998-05-05',2,59.41,'Folk och f� HB','�kergatan 24','Br�cke',NULL,'S-844 67','Sweden'),
  (11051,'LAMAI',7,'1998-04-27','1998-05-25',NULL,3,2.79,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',NULL,'31000','France'),
  (11052,'HANAR',3,'1998-04-27','1998-05-25','1998-05-01',1,67.26,'Hanari Carnes','Rua do Pa�o, 67','Rio de Janeiro','RJ','05454-876','Brazil'),
  (11053,'PICCO',2,'1998-04-27','1998-05-25','1998-04-29',2,53.05,'Piccolo und mehr','Geislweg 14','Salzburg',NULL,'5020','Austria'),
  (11054,'CACTU',8,'1998-04-28','1998-05-26',NULL,1,0.33,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',NULL,'1010','Argentina'),
  (11055,'HILAA',7,'1998-04-28','1998-05-26','1998-05-05',2,120.92,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist�bal','T�chira','5022','Venezuela'),
  (11056,'EASTC',8,'1998-04-28','1998-05-12','1998-05-01',2,278.96,'Eastern Connection','35 King George','London',NULL,'WX3 6FW','UK'),
  (11057,'NORTS',3,'1998-04-29','1998-05-27','1998-05-01',3,4.13,'North/South','South House 300 Queensbridge','London',NULL,'SW7 1RZ','UK'),
  (11058,'BLAUS',9,'1998-04-29','1998-05-27',NULL,3,31.14,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',NULL,'68306','Germany'),
  (11059,'RICAR',2,'1998-04-29','1998-06-10',NULL,2,85.8,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil'),
  (11060,'FRANS',2,'1998-04-30','1998-05-28','1998-05-04',2,10.98,'Franchi S.p.A.','Via Monte Bianco 34','Torino',NULL,'10100','Italy'),
  (11061,'GREAL',4,'1998-04-30','1998-06-11',NULL,3,14.01,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA'),
  (11062,'REGGC',4,'1998-04-30','1998-05-28',NULL,2,29.93,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',NULL,'42100','Italy'),
  (11063,'HUNGO',3,'1998-04-30','1998-05-28','1998-05-06',2,81.73,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',NULL,'Ireland'),
  (11064,'SAVEA',1,'1998-05-01','1998-05-29','1998-05-04',1,30.09,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA'),
  (11065,'LILAS',8,'1998-05-01','1998-05-29',NULL,1,12.91,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (11066,'WHITC',7,'1998-05-01','1998-05-29','1998-05-04',2,44.72,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA'),
  (11067,'DRACD',1,'1998-05-04','1998-05-18','1998-05-06',2,7.98,'Drachenblut Delikatessen','Walserweg 21','Aachen',NULL,'52066','Germany'),
  (11068,'QUEEN',8,'1998-05-04','1998-06-01',NULL,2,81.75,'Queen Cozinha','Alameda dos Can�rios, 891','Sao Paulo','SP','05487-020','Brazil'),
  (11069,'TORTU',1,'1998-05-04','1998-06-01','1998-05-06',2,15.67,'Tortuga Restaurante','Avda. Azteca 123','M�xico D.F.',NULL,'05033','Mexico'),
  (11070,'LEHMS',2,'1998-05-05','1998-06-02',NULL,1,136,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',NULL,'60528','Germany'),
  (11071,'LILAS',1,'1998-05-05','1998-06-02',NULL,1,0.93,'LILA-Supermercado','Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela'),
  (11072,'ERNSH',4,'1998-05-05','1998-06-02',NULL,2,258.64,'Ernst Handel','Kirchgasse 6','Graz',NULL,'8010','Austria'),
  (11073,'PERIC',2,'1998-05-05','1998-06-02',NULL,2,24.95,'Pericles Comidas cl�sicas','Calle Dr. Jorge Cash 321','M�xico D.F.',NULL,'05033','Mexico'),
  (11074,'SIMOB',7,'1998-05-06','1998-06-03',NULL,2,18.44,'Simons bistro','Vinb�ltet 34','Kobenhavn',NULL,'1734','Denmark'),
  (11075,'RICSU',8,'1998-05-06','1998-06-03',NULL,2,6.19,'Richter Supermarkt','Starenweg 5','Gen�ve',NULL,'1204','Switzerland'),
  (11076,'BONAP',4,'1998-05-06','1998-06-03',NULL,2,38.28,'Bon app''','12, rue des Bouchers','Marseille',NULL,'13008','France'),
  (11077,'RATTC',1,'1998-05-06','1998-06-03',NULL,2,8.53,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');

COMMIT;

#
# Data for the `Suppliers` table  (LIMIT 0,500)
#

INSERT INTO `Suppliers` (`SupplierID`, `CompanyName`, `ContactName`, `ContactTitle`, `Address`, `City`, `Region`, `PostalCode`, `Country`, `Phone`, `Fax`, `HomePage`) VALUES 
  (1,'Exotic Liquids','Charlotte Cooper','Purchasing Manager','49 Gilbert St.','London',NULL,'EC1 4SD','UK','(171) 555-2222',NULL,NULL),
  (2,'New Orleans Cajun Delights','Shelley Burke','Order Administrator','P.O. Box 78934','New Orleans','LA','70117','USA','(100) 555-4822',NULL,'#CAJUN.HTM#'),
  (3,'Grandma Kelly''s Homestead','Regina Murphy','Sales Representative','707 Oxford Rd.','Ann Arbor','MI','48104','USA','(313) 555-5735','(313) 555-3349',NULL),
  (4,'Tokyo Traders','Yoshi Nagase','Marketing Manager','9-8 Sekimai Musashino-shi','Tokyo',NULL,'100','Japan','(03) 3555-5011',NULL,NULL),
  (5,'Cooperativa de Quesos ''Las Cabras''','Antonio del Valle Saavedra','Export Administrator','Calle del Rosal 4','Oviedo','Asturias','33007','Spain','(98) 598 76 54',NULL,NULL),
  (6,'Mayumi''s','Mayumi Ohno','Marketing Representative','92 Setsuko Chuo-ku','Osaka',NULL,'545','Japan','(06) 431-7877',NULL,'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#'),
  (7,'Pavlova, Ltd.','Ian Devling','Marketing Manager','74 Rose St. Moonie Ponds','Melbourne','Victoria','3058','Australia','(03) 444-2343','(03) 444-6588',NULL),
  (8,'Specialty Biscuits, Ltd.','Peter Wilson','Sales Representative','29 King''s Way','Manchester',NULL,'M14 GSD','UK','(161) 555-4448',NULL,NULL),
  (9,'PB Kn�ckebr�d AB','Lars Peterson','Sales Agent','Kaloadagatan 13','G�teborg',NULL,'S-345 67','Sweden','031-987 65 43','031-987 65 91',NULL),
  (10,'Refrescos Americanas LTDA','Carlos Diaz','Marketing Manager','Av. das Americanas 12.890','Sao Paulo',NULL,'5442','Brazil','(11) 555 4640',NULL,NULL),
  (11,'Heli S��waren GmbH & Co. KG','Petra Winkler','Sales Manager','Tiergartenstra�e 5','Berlin',NULL,'10785','Germany','(010) 9984510',NULL,NULL),
  (12,'Plutzer Lebensmittelgro�m�rkte AG','Martin Bein','International Marketing Mgr.','Bogenallee 51','Frankfurt',NULL,'60439','Germany','(069) 992755',NULL,'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#'),
  (13,'Nord-Ost-Fisch Handelsgesellschaft mbH','Sven Petersen','Coordinator Foreign Markets','Frahmredder 112a','Cuxhaven',NULL,'27478','Germany','(04721) 8713','(04721) 8714',NULL),
  (14,'Formaggi Fortini s.r.l.','Elio Rossi','Sales Representative','Viale Dante, 75','Ravenna',NULL,'48100','Italy','(0544) 60323','(0544) 60603','#FORMAGGI.HTM#'),
  (15,'Norske Meierier','Beate Vileid','Marketing Manager','Hatlevegen 5','Sandvika',NULL,'1320','Norway','(0)2-953010',NULL,NULL),
  (16,'Bigfoot Breweries','Cheryl Saylor','Regional Account Rep.','3400 - 8th Avenue Suite 210','Bend','OR','97101','USA','(503) 555-9931',NULL,NULL),
  (17,'Svensk Sj�f�da AB','Michael Bj�rn','Sales Representative','Brovallav�gen 231','Stockholm',NULL,'S-123 45','Sweden','08-123 45 67',NULL,NULL),
  (18,'Aux joyeux eccl�siastiques','Guyl�ne Nodier','Sales Manager','203, Rue des Francs-Bourgeois','Paris',NULL,'75004','France','(1) 03.83.00.68','(1) 03.83.00.62',NULL),
  (19,'New England Seafood Cannery','Robb Merchant','Wholesale Account Agent','Order Processing Dept. 2100 Paul Revere Blvd.','Boston','MA','02134','USA','(617) 555-3267','(617) 555-3389',NULL),
  (20,'Leka Trading','Chandra Leka','Owner','471 Serangoon Loop, Suite #402','Singapore',NULL,'0512','Singapore','555-8787',NULL,NULL),
  (21,'Lyngbysild','Niels Petersen','Sales Manager','Lyngbysild Fiskebakken 10','Lyngby',NULL,'2800','Denmark','43844108','43844115',NULL),
  (22,'Zaanse Snoepfabriek','Dirk Luchte','Accounting Manager','Verkoop Rijnweg 22','Zaandam',NULL,'9999 ZZ','Netherlands','(12345) 1212','(12345) 1210',NULL),
  (23,'Karkki Oy','Anne Heikkonen','Product Manager','Valtakatu 12','Lappeenranta',NULL,'53120','Finland','(953) 10956',NULL,NULL),
  (24,'G''day, Mate','Wendy Mackenzie','Sales Representative','170 Prince Edward Parade Hunter''s Hill','Sydney','NSW','2042','Australia','(02) 555-5914','(02) 555-4873','G''day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#'),
  (25,'Ma Maison','Jean-Guy Lauzon','Marketing Manager','2960 Rue St. Laurent','Montr�al','Qu�bec','H1J 1C3','Canada','(514) 555-9022',NULL,NULL),
  (26,'Pasta Buttini s.r.l.','Giovanni Giudici','Order Administrator','Via dei Gelsomini, 153','Salerno',NULL,'84100','Italy','(089) 6547665','(089) 6547667',NULL),
  (27,'Escargots Nouveaux','Marie Delamare','Sales Manager','22, rue H. Voiron','Montceau',NULL,'71300','France','85.57.00.07',NULL,NULL),
  (28,'Gai p�turage','Eliane Noz','Sales Representative','Bat. B 3, rue des Alpes','Annecy',NULL,'74000','France','38.76.98.06','38.76.98.58',NULL),
  (29,'For�ts d''�rables','Chantal Goulet','Accounting Manager','148 rue Chasseur','Ste-Hyacinthe','Qu�bec','J2S 7S8','Canada','(514) 555-2955','(514) 555-2921',NULL);

COMMIT;

#
# Data for the `Products` table  (LIMIT 0,500)
#

INSERT INTO `Products` (`ProductID`, `ProductName`, `SupplierID`, `CategoryID`, `QuantityPerUnit`, `UnitPrice`, `UnitsInStock`, `UnitsOnOrder`, `ReorderLevel`, `Discontinued`) VALUES 
  (1,'Chai',1,1,'10 boxes x 20 bags',18,39,0,10,0),
  (2,'Chang',1,1,'24 - 12 oz bottles',19,17,40,25,0),
  (3,'Aniseed Syrup',1,2,'12 - 550 ml bottles',10,13,70,25,0),
  (4,'Chef Anton''s Cajun Seasoning',2,2,'48 - 6 oz jars',22,53,0,0,0),
  (5,'Chef Anton''s Gumbo Mix',2,2,'36 boxes',21.35,0,0,0,1),
  (6,'Grandma''s Boysenberry Spread',3,2,'12 - 8 oz jars',25,120,0,25,0),
  (7,'Uncle Bob''s Organic Dried Pears',3,7,'12 - 1 lb pkgs.',30,15,0,10,0),
  (8,'Northwoods Cranberry Sauce',3,2,'12 - 12 oz jars',40,6,0,0,0),
  (9,'Mishi Kobe Niku',4,6,'18 - 500 g pkgs.',97,29,0,0,1),
  (10,'Ikura',4,8,'12 - 200 ml jars',31,31,0,0,0),
  (11,'Queso Cabrales',5,4,'1 kg pkg.',21,22,30,30,0),
  (12,'Queso Manchego La Pastora',5,4,'10 - 500 g pkgs.',38,86,0,0,0),
  (13,'Konbu',6,8,'2 kg box',6,24,0,5,0),
  (14,'Tofu',6,7,'40 - 100 g pkgs.',23.25,35,0,0,0),
  (15,'Genen Shouyu',6,2,'24 - 250 ml bottles',15.5,39,0,5,0),
  (16,'Pavlova',7,3,'32 - 500 g boxes',17.45,29,0,10,0),
  (17,'Alice Mutton',7,6,'20 - 1 kg tins',39,0,0,0,1),
  (18,'Carnarvon Tigers',7,8,'16 kg pkg.',62.5,42,0,0,0),
  (19,'Teatime Chocolate Biscuits',8,3,'10 boxes x 12 pieces',9.2,25,0,5,0),
  (20,'Sir Rodney''s Marmalade',8,3,'30 gift boxes',81,40,0,0,0),
  (21,'Sir Rodney''s Scones',8,3,'24 pkgs. x 4 pieces',10,3,40,5,0),
  (22,'Gustaf''s Kn�ckebr�d',9,5,'24 - 500 g pkgs.',21,104,0,25,0),
  (23,'Tunnbr�d',9,5,'12 - 250 g pkgs.',9,61,0,25,0),
  (24,'Guaran� Fant�stica',10,1,'12 - 355 ml cans',4.5,20,0,0,1),
  (25,'NuNuCa Nu�-Nougat-Creme',11,3,'20 - 450 g glasses',14,76,0,30,0),
  (26,'Gumb�r Gummib�rchen',11,3,'100 - 250 g bags',31.23,15,0,0,0),
  (27,'Schoggi Schokolade',11,3,'100 - 100 g pieces',43.9,49,0,30,0),
  (28,'R�ssle Sauerkraut',12,7,'25 - 825 g cans',45.6,26,0,0,1),
  (29,'Th�ringer Rostbratwurst',12,6,'50 bags x 30 sausgs.',123.79,0,0,0,1),
  (30,'Nord-Ost Matjeshering',13,8,'10 - 200 g glasses',25.89,10,0,15,0),
  (31,'Gorgonzola Telino',14,4,'12 - 100 g pkgs',12.5,0,70,20,0),
  (32,'Mascarpone Fabioli',14,4,'24 - 200 g pkgs.',32,9,40,25,0),
  (33,'Geitost',15,4,'500 g',2.5,112,0,20,0),
  (34,'Sasquatch Ale',16,1,'24 - 12 oz bottles',14,111,0,15,0),
  (35,'Steeleye Stout',16,1,'24 - 12 oz bottles',18,20,0,15,0),
  (36,'Inlagd Sill',17,8,'24 - 250 g  jars',19,112,0,20,0),
  (37,'Gravad lax',17,8,'12 - 500 g pkgs.',26,11,50,25,0),
  (38,'C�te de Blaye',18,1,'12 - 75 cl bottles',263.5,17,0,15,0),
  (39,'Chartreuse verte',18,1,'750 cc per bottle',18,69,0,5,0),
  (40,'Boston Crab Meat',19,8,'24 - 4 oz tins',18.4,123,0,30,0),
  (41,'Jack''s New England Clam Chowder',19,8,'12 - 12 oz cans',9.65,85,0,10,0),
  (42,'Singaporean Hokkien Fried Mee',20,5,'32 - 1 kg pkgs.',14,26,0,0,1),
  (43,'Ipoh Coffee',20,1,'16 - 500 g tins',46,17,10,25,0),
  (44,'Gula Malacca',20,2,'20 - 2 kg bags',19.45,27,0,15,0),
  (45,'Rogede sild',21,8,'1k pkg.',9.5,5,70,15,0),
  (46,'Spegesild',21,8,'4 - 450 g glasses',12,95,0,0,0),
  (47,'Zaanse koeken',22,3,'10 - 4 oz boxes',9.5,36,0,0,0),
  (48,'Chocolade',22,3,'10 pkgs.',12.75,15,70,25,0),
  (49,'Maxilaku',23,3,'24 - 50 g pkgs.',20,10,60,15,0),
  (50,'Valkoinen suklaa',23,3,'12 - 100 g bars',16.25,65,0,30,0),
  (51,'Manjimup Dried Apples',24,7,'50 - 300 g pkgs.',53,20,0,10,0),
  (52,'Filo Mix',24,5,'16 - 2 kg boxes',7,38,0,25,0),
  (53,'Perth Pasties',24,6,'48 pieces',32.8,0,0,0,1),
  (54,'Tourti�re',25,6,'16 pies',7.45,21,0,10,0),
  (55,'P�t� chinois',25,6,'24 boxes x 2 pies',24,115,0,20,0),
  (56,'Gnocchi di nonna Alice',26,5,'24 - 250 g pkgs.',38,21,10,30,0),
  (57,'Ravioli Angelo',26,5,'24 - 250 g pkgs.',19.5,36,0,20,0),
  (58,'Escargots de Bourgogne',27,8,'24 pieces',13.25,62,0,20,0),
  (59,'Raclette Courdavault',28,4,'5 kg pkg.',55,79,0,0,0),
  (60,'Camembert Pierrot',28,4,'15 - 300 g rounds',34,19,0,0,0),
  (61,'Sirop d''�rable',29,2,'24 - 500 ml bottles',28.5,113,0,25,0),
  (62,'Tarte au sucre',29,3,'48 pies',49.3,17,0,0,0),
  (63,'Vegie-spread',7,2,'15 - 625 g jars',43.9,24,0,5,0),
  (64,'Wimmers gute Semmelkn�del',12,5,'20 bags x 4 pieces',33.25,22,80,30,0),
  (65,'Louisiana Fiery Hot Pepper Sauce',2,2,'32 - 8 oz bottles',21.05,76,0,0,0),
  (66,'Louisiana Hot Spiced Okra',2,2,'24 - 8 oz jars',17,4,100,20,0),
  (67,'Laughing Lumberjack Lager',16,1,'24 - 12 oz bottles',14,52,0,10,0),
  (68,'Scottish Longbreads',8,3,'10 boxes x 8 pieces',12.5,6,10,15,0),
  (69,'Gudbrandsdalsost',15,4,'10 kg pkg.',36,26,0,15,0),
  (70,'Outback Lager',7,1,'24 - 355 ml bottles',15,15,10,30,0),
  (71,'Flotemysost',15,4,'10 - 500 g pkgs.',21.5,26,0,0,0),
  (72,'Mozzarella di Giovanni',14,4,'24 - 200 g pkgs.',34.8,14,0,0,0),
  (73,'R�d Kaviar',17,8,'24 - 150 g jars',15,101,0,5,0),
  (74,'Longlife Tofu',4,7,'5 kg pkg.',10,4,20,5,0),
  (75,'Rh�nbr�u Klosterbier',12,1,'24 - 0.5 l bottles',7.75,125,0,25,0),
  (76,'Lakkalik��ri',23,1,'500 ml',18,57,0,20,0),
  (77,'Original Frankfurter gr�ne So�e',12,2,'12 boxes',13,32,0,15,0);

COMMIT;

#
# Data for the `Order Details` table  (LIMIT 0,500)
#

INSERT INTO `Order Details` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES 
  (10248,11,14,12,0),
  (10248,42,9.8,10,0),
  (10248,72,34.8,5,0),
  (10249,14,18.6,9,0),
  (10249,51,42.4,40,0),
  (10250,41,7.7,10,0),
  (10250,51,42.4,35,0.15),
  (10250,65,16.8,15,0.15),
  (10251,22,16.8,6,0.05),
  (10251,57,15.6,15,0.05),
  (10251,65,16.8,20,0),
  (10252,20,64.8,40,0.05),
  (10252,33,2,25,0.05),
  (10252,60,27.2,40,0),
  (10253,31,10,20,0),
  (10253,39,14.4,42,0),
  (10253,49,16,40,0),
  (10254,24,3.6,15,0.15),
  (10254,55,19.2,21,0.15),
  (10254,74,8,21,0),
  (10255,2,15.2,20,0),
  (10255,16,13.9,35,0),
  (10255,36,15.2,25,0),
  (10255,59,44,30,0),
  (10256,53,26.2,15,0),
  (10256,77,10.4,12,0),
  (10257,27,35.1,25,0),
  (10257,39,14.4,6,0),
  (10257,77,10.4,15,0),
  (10258,2,15.2,50,0.2),
  (10258,5,17,65,0.2),
  (10258,32,25.6,6,0.2),
  (10259,21,8,10,0),
  (10259,37,20.8,1,0),
  (10260,41,7.7,16,0.25),
  (10260,57,15.6,50,0),
  (10260,62,39.4,15,0.25),
  (10260,70,12,21,0.25),
  (10261,21,8,20,0),
  (10261,35,14.4,20,0),
  (10262,5,17,12,0.2),
  (10262,7,24,15,0),
  (10262,56,30.4,2,0),
  (10263,16,13.9,60,0.25),
  (10263,24,3.6,28,0),
  (10263,30,20.7,60,0.25),
  (10263,74,8,36,0.25),
  (10264,2,15.2,35,0),
  (10264,41,7.7,25,0.15),
  (10265,17,31.2,30,0),
  (10265,70,12,20,0),
  (10266,12,30.4,12,0.05),
  (10267,40,14.7,50,0),
  (10267,59,44,70,0.15),
  (10267,76,14.4,15,0.15),
  (10268,29,99,10,0),
  (10268,72,27.8,4,0),
  (10269,33,2,60,0.05),
  (10269,72,27.8,20,0.05),
  (10270,36,15.2,30,0),
  (10270,43,36.8,25,0),
  (10271,33,2,24,0),
  (10272,20,64.8,6,0),
  (10272,31,10,40,0),
  (10272,72,27.8,24,0),
  (10273,10,24.8,24,0.05),
  (10273,31,10,15,0.05),
  (10273,33,2,20,0),
  (10273,40,14.7,60,0.05),
  (10273,76,14.4,33,0.05),
  (10274,71,17.2,20,0),
  (10274,72,27.8,7,0),
  (10275,24,3.6,12,0.05),
  (10275,59,44,6,0.05),
  (10276,10,24.8,15,0),
  (10276,13,4.8,10,0),
  (10277,28,36.4,20,0),
  (10277,62,39.4,12,0),
  (10278,44,15.5,16,0),
  (10278,59,44,15,0),
  (10278,63,35.1,8,0),
  (10278,73,12,25,0),
  (10279,17,31.2,15,0.25),
  (10280,24,3.6,12,0),
  (10280,55,19.2,20,0),
  (10280,75,6.2,30,0),
  (10281,19,7.3,1,0),
  (10281,24,3.6,6,0),
  (10281,35,14.4,4,0),
  (10282,30,20.7,6,0),
  (10282,57,15.6,2,0),
  (10283,15,12.4,20,0),
  (10283,19,7.3,18,0),
  (10283,60,27.2,35,0),
  (10283,72,27.8,3,0),
  (10284,27,35.1,15,0.25),
  (10284,44,15.5,21,0),
  (10284,60,27.2,20,0.25),
  (10284,67,11.2,5,0.25),
  (10285,1,14.4,45,0.2),
  (10285,40,14.7,40,0.2),
  (10285,53,26.2,36,0.2),
  (10286,35,14.4,100,0),
  (10286,62,39.4,40,0),
  (10287,16,13.9,40,0.15),
  (10287,34,11.2,20,0),
  (10287,46,9.6,15,0.15),
  (10288,54,5.9,10,0.1),
  (10288,68,10,3,0.1),
  (10289,3,8,30,0),
  (10289,64,26.6,9,0),
  (10290,5,17,20,0),
  (10290,29,99,15,0),
  (10290,49,16,15,0),
  (10290,77,10.4,10,0),
  (10291,13,4.8,20,0.1),
  (10291,44,15.5,24,0.1),
  (10291,51,42.4,2,0.1),
  (10292,20,64.8,20,0),
  (10293,18,50,12,0),
  (10293,24,3.6,10,0),
  (10293,63,35.1,5,0),
  (10293,75,6.2,6,0),
  (10294,1,14.4,18,0),
  (10294,17,31.2,15,0),
  (10294,43,36.8,15,0),
  (10294,60,27.2,21,0),
  (10294,75,6.2,6,0),
  (10295,56,30.4,4,0),
  (10296,11,16.8,12,0),
  (10296,16,13.9,30,0),
  (10296,69,28.8,15,0),
  (10297,39,14.4,60,0),
  (10297,72,27.8,20,0),
  (10298,2,15.2,40,0),
  (10298,36,15.2,40,0.25),
  (10298,59,44,30,0.25),
  (10298,62,39.4,15,0),
  (10299,19,7.3,15,0),
  (10299,70,12,20,0),
  (10300,66,13.6,30,0),
  (10300,68,10,20,0),
  (10301,40,14.7,10,0),
  (10301,56,30.4,20,0),
  (10302,17,31.2,40,0),
  (10302,28,36.4,28,0),
  (10302,43,36.8,12,0),
  (10303,40,14.7,40,0.1),
  (10303,65,16.8,30,0.1),
  (10303,68,10,15,0.1),
  (10304,49,16,30,0),
  (10304,59,44,10,0),
  (10304,71,17.2,2,0),
  (10305,18,50,25,0.1),
  (10305,29,99,25,0.1),
  (10305,39,14.4,30,0.1),
  (10306,30,20.7,10,0),
  (10306,53,26.2,10,0),
  (10306,54,5.9,5,0),
  (10307,62,39.4,10,0),
  (10307,68,10,3,0),
  (10308,69,28.8,1,0),
  (10308,70,12,5,0),
  (10309,4,17.6,20,0),
  (10309,6,20,30,0),
  (10309,42,11.2,2,0),
  (10309,43,36.8,20,0),
  (10309,71,17.2,3,0),
  (10310,16,13.9,10,0),
  (10310,62,39.4,5,0),
  (10311,42,11.2,6,0),
  (10311,69,28.8,7,0),
  (10312,28,36.4,4,0),
  (10312,43,36.8,24,0),
  (10312,53,26.2,20,0),
  (10312,75,6.2,10,0),
  (10313,36,15.2,12,0),
  (10314,32,25.6,40,0.1),
  (10314,58,10.6,30,0.1),
  (10314,62,39.4,25,0.1),
  (10315,34,11.2,14,0),
  (10315,70,12,30,0),
  (10316,41,7.7,10,0),
  (10316,62,39.4,70,0),
  (10317,1,14.4,20,0),
  (10318,41,7.7,20,0),
  (10318,76,14.4,6,0),
  (10319,17,31.2,8,0),
  (10319,28,36.4,14,0),
  (10319,76,14.4,30,0),
  (10320,71,17.2,30,0),
  (10321,35,14.4,10,0),
  (10322,52,5.6,20,0),
  (10323,15,12.4,5,0),
  (10323,25,11.2,4,0),
  (10323,39,14.4,4,0),
  (10324,16,13.9,21,0.15),
  (10324,35,14.4,70,0.15),
  (10324,46,9.6,30,0),
  (10324,59,44,40,0.15),
  (10324,63,35.1,80,0.15),
  (10325,6,20,6,0),
  (10325,13,4.8,12,0),
  (10325,14,18.6,9,0),
  (10325,31,10,4,0),
  (10325,72,27.8,40,0),
  (10326,4,17.6,24,0),
  (10326,57,15.6,16,0),
  (10326,75,6.2,50,0),
  (10327,2,15.2,25,0.2),
  (10327,11,16.8,50,0.2),
  (10327,30,20.7,35,0.2),
  (10327,58,10.6,30,0.2),
  (10328,59,44,9,0),
  (10328,65,16.8,40,0),
  (10328,68,10,10,0),
  (10329,19,7.3,10,0.05),
  (10329,30,20.7,8,0.05),
  (10329,38,210.8,20,0.05),
  (10329,56,30.4,12,0.05),
  (10330,26,24.9,50,0.15),
  (10330,72,27.8,25,0.15),
  (10331,54,5.9,15,0),
  (10332,18,50,40,0.2),
  (10332,42,11.2,10,0.2),
  (10332,47,7.6,16,0.2),
  (10333,14,18.6,10,0),
  (10333,21,8,10,0.1),
  (10333,71,17.2,40,0.1),
  (10334,52,5.6,8,0),
  (10334,68,10,10,0),
  (10335,2,15.2,7,0.2),
  (10335,31,10,25,0.2),
  (10335,32,25.6,6,0.2),
  (10335,51,42.4,48,0.2),
  (10336,4,17.6,18,0.1),
  (10337,23,7.2,40,0),
  (10337,26,24.9,24,0),
  (10337,36,15.2,20,0),
  (10337,37,20.8,28,0),
  (10337,72,27.8,25,0),
  (10338,17,31.2,20,0),
  (10338,30,20.7,15,0),
  (10339,4,17.6,10,0),
  (10339,17,31.2,70,0.05),
  (10339,62,39.4,28,0),
  (10340,18,50,20,0.05),
  (10340,41,7.7,12,0.05),
  (10340,43,36.8,40,0.05),
  (10341,33,2,8,0),
  (10341,59,44,9,0.15),
  (10342,2,15.2,24,0.2),
  (10342,31,10,56,0.2),
  (10342,36,15.2,40,0.2),
  (10342,55,19.2,40,0.2),
  (10343,64,26.6,50,0),
  (10343,68,10,4,0.05),
  (10343,76,14.4,15,0),
  (10344,4,17.6,35,0),
  (10344,8,32,70,0.25),
  (10345,8,32,70,0),
  (10345,19,7.3,80,0),
  (10345,42,11.2,9,0),
  (10346,17,31.2,36,0.1),
  (10346,56,30.4,20,0),
  (10347,25,11.2,10,0),
  (10347,39,14.4,50,0.15),
  (10347,40,14.7,4,0),
  (10347,75,6.2,6,0.15),
  (10348,1,14.4,15,0.15),
  (10348,23,7.2,25,0),
  (10349,54,5.9,24,0),
  (10350,50,13,15,0.1),
  (10350,69,28.8,18,0.1),
  (10351,38,210.8,20,0.05),
  (10351,41,7.7,13,0),
  (10351,44,15.5,77,0.05),
  (10351,65,16.8,10,0.05),
  (10352,24,3.6,10,0),
  (10352,54,5.9,20,0.15),
  (10353,11,16.8,12,0.2),
  (10353,38,210.8,50,0.2),
  (10354,1,14.4,12,0),
  (10354,29,99,4,0),
  (10355,24,3.6,25,0),
  (10355,57,15.6,25,0),
  (10356,31,10,30,0),
  (10356,55,19.2,12,0),
  (10356,69,28.8,20,0),
  (10357,10,24.8,30,0.2),
  (10357,26,24.9,16,0),
  (10357,60,27.2,8,0.2),
  (10358,24,3.6,10,0.05),
  (10358,34,11.2,10,0.05),
  (10358,36,15.2,20,0.05),
  (10359,16,13.9,56,0.05),
  (10359,31,10,70,0.05),
  (10359,60,27.2,80,0.05),
  (10360,28,36.4,30,0),
  (10360,29,99,35,0),
  (10360,38,210.8,10,0),
  (10360,49,16,35,0),
  (10360,54,5.9,28,0),
  (10361,39,14.4,54,0.1),
  (10361,60,27.2,55,0.1),
  (10362,25,11.2,50,0),
  (10362,51,42.4,20,0),
  (10362,54,5.9,24,0),
  (10363,31,10,20,0),
  (10363,75,6.2,12,0),
  (10363,76,14.4,12,0),
  (10364,69,28.8,30,0),
  (10364,71,17.2,5,0),
  (10365,11,16.8,24,0),
  (10366,65,16.8,5,0),
  (10366,77,10.4,5,0),
  (10367,34,11.2,36,0),
  (10367,54,5.9,18,0),
  (10367,65,16.8,15,0),
  (10367,77,10.4,7,0),
  (10368,21,8,5,0.1),
  (10368,28,36.4,13,0.1),
  (10368,57,15.6,25,0),
  (10368,64,26.6,35,0.1),
  (10369,29,99,20,0),
  (10369,56,30.4,18,0.25),
  (10370,1,14.4,15,0.15),
  (10370,64,26.6,30,0),
  (10370,74,8,20,0.15),
  (10371,36,15.2,6,0.2),
  (10372,20,64.8,12,0.25),
  (10372,38,210.8,40,0.25),
  (10372,60,27.2,70,0.25),
  (10372,72,27.8,42,0.25),
  (10373,58,10.6,80,0.2),
  (10373,71,17.2,50,0.2),
  (10374,31,10,30,0),
  (10374,58,10.6,15,0),
  (10375,14,18.6,15,0),
  (10375,54,5.9,10,0),
  (10376,31,10,42,0.05),
  (10377,28,36.4,20,0.15),
  (10377,39,14.4,20,0.15),
  (10378,71,17.2,6,0),
  (10379,41,7.7,8,0.1),
  (10379,63,35.1,16,0.1),
  (10379,65,16.8,20,0.1),
  (10380,30,20.7,18,0.1),
  (10380,53,26.2,20,0.1),
  (10380,60,27.2,6,0.1),
  (10380,70,12,30,0),
  (10381,74,8,14,0),
  (10382,5,17,32,0),
  (10382,18,50,9,0),
  (10382,29,99,14,0),
  (10382,33,2,60,0),
  (10382,74,8,50,0),
  (10383,13,4.8,20,0),
  (10383,50,13,15,0),
  (10383,56,30.4,20,0),
  (10384,20,64.8,28,0),
  (10384,60,27.2,15,0),
  (10385,7,24,10,0.2),
  (10385,60,27.2,20,0.2),
  (10385,68,10,8,0.2),
  (10386,24,3.6,15,0),
  (10386,34,11.2,10,0),
  (10387,24,3.6,15,0),
  (10387,28,36.4,6,0),
  (10387,59,44,12,0),
  (10387,71,17.2,15,0),
  (10388,45,7.6,15,0.2),
  (10388,52,5.6,20,0.2),
  (10388,53,26.2,40,0),
  (10389,10,24.8,16,0),
  (10389,55,19.2,15,0),
  (10389,62,39.4,20,0),
  (10389,70,12,30,0),
  (10390,31,10,60,0.1),
  (10390,35,14.4,40,0.1),
  (10390,46,9.6,45,0),
  (10390,72,27.8,24,0.1),
  (10391,13,4.8,18,0),
  (10392,69,28.8,50,0),
  (10393,2,15.2,25,0.25),
  (10393,14,18.6,42,0.25),
  (10393,25,11.2,7,0.25),
  (10393,26,24.9,70,0.25),
  (10393,31,10,32,0),
  (10394,13,4.8,10,0),
  (10394,62,39.4,10,0),
  (10395,46,9.6,28,0.1),
  (10395,53,26.2,70,0.1),
  (10395,69,28.8,8,0),
  (10396,23,7.2,40,0),
  (10396,71,17.2,60,0),
  (10396,72,27.8,21,0),
  (10397,21,8,10,0.15),
  (10397,51,42.4,18,0.15),
  (10398,35,14.4,30,0),
  (10398,55,19.2,120,0.1),
  (10399,68,10,60,0),
  (10399,71,17.2,30,0),
  (10399,76,14.4,35,0),
  (10399,77,10.4,14,0),
  (10400,29,99,21,0),
  (10400,35,14.4,35,0),
  (10400,49,16,30,0),
  (10401,30,20.7,18,0),
  (10401,56,30.4,70,0),
  (10401,65,16.8,20,0),
  (10401,71,17.2,60,0),
  (10402,23,7.2,60,0),
  (10402,63,35.1,65,0),
  (10403,16,13.9,21,0.15),
  (10403,48,10.2,70,0.15),
  (10404,26,24.9,30,0.05),
  (10404,42,11.2,40,0.05),
  (10404,49,16,30,0.05),
  (10405,3,8,50,0),
  (10406,1,14.4,10,0),
  (10406,21,8,30,0.1),
  (10406,28,36.4,42,0.1),
  (10406,36,15.2,5,0.1),
  (10406,40,14.7,2,0.1),
  (10407,11,16.8,30,0),
  (10407,69,28.8,15,0),
  (10407,71,17.2,15,0),
  (10408,37,20.8,10,0),
  (10408,54,5.9,6,0),
  (10408,62,39.4,35,0),
  (10409,14,18.6,12,0),
  (10409,21,8,12,0),
  (10410,33,2,49,0),
  (10410,59,44,16,0),
  (10411,41,7.7,25,0.2),
  (10411,44,15.5,40,0.2),
  (10411,59,44,9,0.2),
  (10412,14,18.6,20,0.1),
  (10413,1,14.4,24,0),
  (10413,62,39.4,40,0),
  (10413,76,14.4,14,0),
  (10414,19,7.3,18,0.05),
  (10414,33,2,50,0),
  (10415,17,31.2,2,0),
  (10415,33,2,20,0),
  (10416,19,7.3,20,0),
  (10416,53,26.2,10,0),
  (10416,57,15.6,20,0),
  (10417,38,210.8,50,0),
  (10417,46,9.6,2,0.25),
  (10417,68,10,36,0.25),
  (10417,77,10.4,35,0),
  (10418,2,15.2,60,0),
  (10418,47,7.6,55,0),
  (10418,61,22.8,16,0),
  (10418,74,8,15,0),
  (10419,60,27.2,60,0.05),
  (10419,69,28.8,20,0.05),
  (10420,9,77.6,20,0.1),
  (10420,13,4.8,2,0.1),
  (10420,70,12,8,0.1),
  (10420,73,12,20,0.1),
  (10421,19,7.3,4,0.15),
  (10421,26,24.9,30,0),
  (10421,53,26.2,15,0.15),
  (10421,77,10.4,10,0.15),
  (10422,26,24.9,2,0),
  (10423,31,10,14,0),
  (10423,59,44,20,0),
  (10424,35,14.4,60,0.2),
  (10424,38,210.8,49,0.2),
  (10424,68,10,30,0.2),
  (10425,55,19.2,10,0.25),
  (10425,76,14.4,20,0.25),
  (10426,56,30.4,5,0),
  (10426,64,26.6,7,0),
  (10427,14,18.6,35,0),
  (10428,46,9.6,20,0),
  (10429,50,13,40,0),
  (10429,63,35.1,35,0.25),
  (10430,17,31.2,45,0.2),
  (10430,21,8,50,0),
  (10430,56,30.4,30,0),
  (10430,59,44,70,0.2),
  (10431,17,31.2,50,0.25),
  (10431,40,14.7,50,0.25),
  (10431,47,7.6,30,0.25),
  (10432,26,24.9,10,0),
  (10432,54,5.9,40,0),
  (10433,56,30.4,28,0),
  (10434,11,16.8,6,0),
  (10434,76,14.4,18,0.15),
  (10435,2,15.2,10,0),
  (10435,22,16.8,12,0),
  (10435,72,27.8,10,0),
  (10436,46,9.6,5,0),
  (10436,56,30.4,40,0.1),
  (10436,64,26.6,30,0.1),
  (10436,75,6.2,24,0.1);

COMMIT;

#
# Data for the `Order Details` table  (LIMIT 500,500)
#

INSERT INTO `Order Details` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES 
  (10437,53,26.2,15,0),
  (10438,19,7.3,15,0.2),
  (10438,34,11.2,20,0.2),
  (10438,57,15.6,15,0.2),
  (10439,12,30.4,15,0),
  (10439,16,13.9,16,0),
  (10439,64,26.6,6,0),
  (10439,74,8,30,0),
  (10440,2,15.2,45,0.15),
  (10440,16,13.9,49,0.15),
  (10440,29,99,24,0.15),
  (10440,61,22.8,90,0.15),
  (10441,27,35.1,50,0),
  (10442,11,16.8,30,0),
  (10442,54,5.9,80,0),
  (10442,66,13.6,60,0),
  (10443,11,16.8,6,0.2),
  (10443,28,36.4,12,0),
  (10444,17,31.2,10,0),
  (10444,26,24.9,15,0),
  (10444,35,14.4,8,0),
  (10444,41,7.7,30,0),
  (10445,39,14.4,6,0),
  (10445,54,5.9,15,0),
  (10446,19,7.3,12,0.1),
  (10446,24,3.6,20,0.1),
  (10446,31,10,3,0.1),
  (10446,52,5.6,15,0.1),
  (10447,19,7.3,40,0),
  (10447,65,16.8,35,0),
  (10447,71,17.2,2,0),
  (10448,26,24.9,6,0),
  (10448,40,14.7,20,0),
  (10449,10,24.8,14,0),
  (10449,52,5.6,20,0),
  (10449,62,39.4,35,0),
  (10450,10,24.8,20,0.2),
  (10450,54,5.9,6,0.2),
  (10451,55,19.2,120,0.1),
  (10451,64,26.6,35,0.1),
  (10451,65,16.8,28,0.1),
  (10451,77,10.4,55,0.1),
  (10452,28,36.4,15,0),
  (10452,44,15.5,100,0.05),
  (10453,48,10.2,15,0.1),
  (10453,70,12,25,0.1),
  (10454,16,13.9,20,0.2),
  (10454,33,2,20,0.2),
  (10454,46,9.6,10,0.2),
  (10455,39,14.4,20,0),
  (10455,53,26.2,50,0),
  (10455,61,22.8,25,0),
  (10455,71,17.2,30,0),
  (10456,21,8,40,0.15),
  (10456,49,16,21,0.15),
  (10457,59,44,36,0),
  (10458,26,24.9,30,0),
  (10458,28,36.4,30,0),
  (10458,43,36.8,20,0),
  (10458,56,30.4,15,0),
  (10458,71,17.2,50,0),
  (10459,7,24,16,0.05),
  (10459,46,9.6,20,0.05),
  (10459,72,27.8,40,0),
  (10460,68,10,21,0.25),
  (10460,75,6.2,4,0.25),
  (10461,21,8,40,0.25),
  (10461,30,20.7,28,0.25),
  (10461,55,19.2,60,0.25),
  (10462,13,4.8,1,0),
  (10462,23,7.2,21,0),
  (10463,19,7.3,21,0),
  (10463,42,11.2,50,0),
  (10464,4,17.6,16,0.2),
  (10464,43,36.8,3,0),
  (10464,56,30.4,30,0.2),
  (10464,60,27.2,20,0),
  (10465,24,3.6,25,0),
  (10465,29,99,18,0.1),
  (10465,40,14.7,20,0),
  (10465,45,7.6,30,0.1),
  (10465,50,13,25,0),
  (10466,11,16.8,10,0),
  (10466,46,9.6,5,0),
  (10467,24,3.6,28,0),
  (10467,25,11.2,12,0),
  (10468,30,20.7,8,0),
  (10468,43,36.8,15,0),
  (10469,2,15.2,40,0.15),
  (10469,16,13.9,35,0.15),
  (10469,44,15.5,2,0.15),
  (10470,18,50,30,0),
  (10470,23,7.2,15,0),
  (10470,64,26.6,8,0),
  (10471,7,24,30,0),
  (10471,56,30.4,20,0),
  (10472,24,3.6,80,0.05),
  (10472,51,42.4,18,0),
  (10473,33,2,12,0),
  (10473,71,17.2,12,0),
  (10474,14,18.6,12,0),
  (10474,28,36.4,18,0),
  (10474,40,14.7,21,0),
  (10474,75,6.2,10,0),
  (10475,31,10,35,0.15),
  (10475,66,13.6,60,0.15),
  (10475,76,14.4,42,0.15),
  (10476,55,19.2,2,0.05),
  (10476,70,12,12,0),
  (10477,1,14.4,15,0),
  (10477,21,8,21,0.25),
  (10477,39,14.4,20,0.25),
  (10478,10,24.8,20,0.05),
  (10479,38,210.8,30,0),
  (10479,53,26.2,28,0),
  (10479,59,44,60,0),
  (10479,64,26.6,30,0),
  (10480,47,7.6,30,0),
  (10480,59,44,12,0),
  (10481,49,16,24,0),
  (10481,60,27.2,40,0),
  (10482,40,14.7,10,0),
  (10483,34,11.2,35,0.05),
  (10483,77,10.4,30,0.05),
  (10484,21,8,14,0),
  (10484,40,14.7,10,0),
  (10484,51,42.4,3,0),
  (10485,2,15.2,20,0.1),
  (10485,3,8,20,0.1),
  (10485,55,19.2,30,0.1),
  (10485,70,12,60,0.1),
  (10486,11,16.8,5,0),
  (10486,51,42.4,25,0),
  (10486,74,8,16,0),
  (10487,19,7.3,5,0),
  (10487,26,24.9,30,0),
  (10487,54,5.9,24,0.25),
  (10488,59,44,30,0),
  (10488,73,12,20,0.2),
  (10489,11,16.8,15,0.25),
  (10489,16,13.9,18,0),
  (10490,59,44,60,0),
  (10490,68,10,30,0),
  (10490,75,6.2,36,0),
  (10491,44,15.5,15,0.15),
  (10491,77,10.4,7,0.15),
  (10492,25,11.2,60,0.05),
  (10492,42,11.2,20,0.05),
  (10493,65,16.8,15,0.1),
  (10493,66,13.6,10,0.1),
  (10493,69,28.8,10,0.1),
  (10494,56,30.4,30,0),
  (10495,23,7.2,10,0),
  (10495,41,7.7,20,0),
  (10495,77,10.4,5,0),
  (10496,31,10,20,0.05),
  (10497,56,30.4,14,0),
  (10497,72,27.8,25,0),
  (10497,77,10.4,25,0),
  (10498,24,4.5,14,0),
  (10498,40,18.4,5,0),
  (10498,42,14,30,0),
  (10499,28,45.6,20,0),
  (10499,49,20,25,0),
  (10500,15,15.5,12,0.05),
  (10500,28,45.6,8,0.05),
  (10501,54,7.45,20,0),
  (10502,45,9.5,21,0),
  (10502,53,32.8,6,0),
  (10502,67,14,30,0),
  (10503,14,23.25,70,0),
  (10503,65,21.05,20,0),
  (10504,2,19,12,0),
  (10504,21,10,12,0),
  (10504,53,32.8,10,0),
  (10504,61,28.5,25,0),
  (10505,62,49.3,3,0),
  (10506,25,14,18,0.1),
  (10506,70,15,14,0.1),
  (10507,43,46,15,0.15),
  (10507,48,12.75,15,0.15),
  (10508,13,6,10,0),
  (10508,39,18,10,0),
  (10509,28,45.6,3,0),
  (10510,29,123.79,36,0),
  (10510,75,7.75,36,0.1),
  (10511,4,22,50,0.15),
  (10511,7,30,50,0.15),
  (10511,8,40,10,0.15),
  (10512,24,4.5,10,0.15),
  (10512,46,12,9,0.15),
  (10512,47,9.5,6,0.15),
  (10512,60,34,12,0.15),
  (10513,21,10,40,0.2),
  (10513,32,32,50,0.2),
  (10513,61,28.5,15,0.2),
  (10514,20,81,39,0),
  (10514,28,45.6,35,0),
  (10514,56,38,70,0),
  (10514,65,21.05,39,0),
  (10514,75,7.75,50,0),
  (10515,9,97,16,0.15),
  (10515,16,17.45,50,0),
  (10515,27,43.9,120,0),
  (10515,33,2.5,16,0.15),
  (10515,60,34,84,0.15),
  (10516,18,62.5,25,0.1),
  (10516,41,9.65,80,0.1),
  (10516,42,14,20,0),
  (10517,52,7,6,0),
  (10517,59,55,4,0),
  (10517,70,15,6,0),
  (10518,24,4.5,5,0),
  (10518,38,263.5,15,0),
  (10518,44,19.45,9,0),
  (10519,10,31,16,0.05),
  (10519,56,38,40,0),
  (10519,60,34,10,0.05),
  (10520,24,4.5,8,0),
  (10520,53,32.8,5,0),
  (10521,35,18,3,0),
  (10521,41,9.65,10,0),
  (10521,68,12.5,6,0),
  (10522,1,18,40,0.2),
  (10522,8,40,24,0),
  (10522,30,25.89,20,0.2),
  (10522,40,18.4,25,0.2),
  (10523,17,39,25,0.1),
  (10523,20,81,15,0.1),
  (10523,37,26,18,0.1),
  (10523,41,9.65,6,0.1),
  (10524,10,31,2,0),
  (10524,30,25.89,10,0),
  (10524,43,46,60,0),
  (10524,54,7.45,15,0),
  (10525,36,19,30,0),
  (10525,40,18.4,15,0.1),
  (10526,1,18,8,0.15),
  (10526,13,6,10,0),
  (10526,56,38,30,0.15),
  (10527,4,22,50,0.1),
  (10527,36,19,30,0.1),
  (10528,11,21,3,0),
  (10528,33,2.5,8,0.2),
  (10528,72,34.8,9,0),
  (10529,55,24,14,0),
  (10529,68,12.5,20,0),
  (10529,69,36,10,0),
  (10530,17,39,40,0),
  (10530,43,46,25,0),
  (10530,61,28.5,20,0),
  (10530,76,18,50,0),
  (10531,59,55,2,0),
  (10532,30,25.89,15,0),
  (10532,66,17,24,0),
  (10533,4,22,50,0.05),
  (10533,72,34.8,24,0),
  (10533,73,15,24,0.05),
  (10534,30,25.89,10,0),
  (10534,40,18.4,10,0.2),
  (10534,54,7.45,10,0.2),
  (10535,11,21,50,0.1),
  (10535,40,18.4,10,0.1),
  (10535,57,19.5,5,0.1),
  (10535,59,55,15,0.1),
  (10536,12,38,15,0.25),
  (10536,31,12.5,20,0),
  (10536,33,2.5,30,0),
  (10536,60,34,35,0.25),
  (10537,31,12.5,30,0),
  (10537,51,53,6,0),
  (10537,58,13.25,20,0),
  (10537,72,34.8,21,0),
  (10537,73,15,9,0),
  (10538,70,15,7,0),
  (10538,72,34.8,1,0),
  (10539,13,6,8,0),
  (10539,21,10,15,0),
  (10539,33,2.5,15,0),
  (10539,49,20,6,0),
  (10540,3,10,60,0),
  (10540,26,31.23,40,0),
  (10540,38,263.5,30,0),
  (10540,68,12.5,35,0),
  (10541,24,4.5,35,0.1),
  (10541,38,263.5,4,0.1),
  (10541,65,21.05,36,0.1),
  (10541,71,21.5,9,0.1),
  (10542,11,21,15,0.05),
  (10542,54,7.45,24,0.05),
  (10543,12,38,30,0.15),
  (10543,23,9,70,0.15),
  (10544,28,45.6,7,0),
  (10544,67,14,7,0),
  (10545,11,21,10,0),
  (10546,7,30,10,0),
  (10546,35,18,30,0),
  (10546,62,49.3,40,0),
  (10547,32,32,24,0.15),
  (10547,36,19,60,0),
  (10548,34,14,10,0.25),
  (10548,41,9.65,14,0),
  (10549,31,12.5,55,0.15),
  (10549,45,9.5,100,0.15),
  (10549,51,53,48,0.15),
  (10550,17,39,8,0.1),
  (10550,19,9.2,10,0),
  (10550,21,10,6,0.1),
  (10550,61,28.5,10,0.1),
  (10551,16,17.45,40,0.15),
  (10551,35,18,20,0.15),
  (10551,44,19.45,40,0),
  (10552,69,36,18,0),
  (10552,75,7.75,30,0),
  (10553,11,21,15,0),
  (10553,16,17.45,14,0),
  (10553,22,21,24,0),
  (10553,31,12.5,30,0),
  (10553,35,18,6,0),
  (10554,16,17.45,30,0.05),
  (10554,23,9,20,0.05),
  (10554,62,49.3,20,0.05),
  (10554,77,13,10,0.05),
  (10555,14,23.25,30,0.2),
  (10555,19,9.2,35,0.2),
  (10555,24,4.5,18,0.2),
  (10555,51,53,20,0.2),
  (10555,56,38,40,0.2),
  (10556,72,34.8,24,0),
  (10557,64,33.25,30,0),
  (10557,75,7.75,20,0),
  (10558,47,9.5,25,0),
  (10558,51,53,20,0),
  (10558,52,7,30,0),
  (10558,53,32.8,18,0),
  (10558,73,15,3,0),
  (10559,41,9.65,12,0.05),
  (10559,55,24,18,0.05),
  (10560,30,25.89,20,0),
  (10560,62,49.3,15,0.25),
  (10561,44,19.45,10,0),
  (10561,51,53,50,0),
  (10562,33,2.5,20,0.1),
  (10562,62,49.3,10,0.1),
  (10563,36,19,25,0),
  (10563,52,7,70,0),
  (10564,17,39,16,0.05),
  (10564,31,12.5,6,0.05),
  (10564,55,24,25,0.05),
  (10565,24,4.5,25,0.1),
  (10565,64,33.25,18,0.1),
  (10566,11,21,35,0.15),
  (10566,18,62.5,18,0.15),
  (10566,76,18,10,0),
  (10567,31,12.5,60,0.2),
  (10567,51,53,3,0),
  (10567,59,55,40,0.2),
  (10568,10,31,5,0),
  (10569,31,12.5,35,0.2),
  (10569,76,18,30,0),
  (10570,11,21,15,0.05),
  (10570,56,38,60,0.05),
  (10571,14,23.25,11,0.15),
  (10571,42,14,28,0.15),
  (10572,16,17.45,12,0.1),
  (10572,32,32,10,0.1),
  (10572,40,18.4,50,0),
  (10572,75,7.75,15,0.1),
  (10573,17,39,18,0),
  (10573,34,14,40,0),
  (10573,53,32.8,25,0),
  (10574,33,2.5,14,0),
  (10574,40,18.4,2,0),
  (10574,62,49.3,10,0),
  (10574,64,33.25,6,0),
  (10575,59,55,12,0),
  (10575,63,43.9,6,0),
  (10575,72,34.8,30,0),
  (10575,76,18,10,0),
  (10576,1,18,10,0),
  (10576,31,12.5,20,0),
  (10576,44,19.45,21,0),
  (10577,39,18,10,0),
  (10577,75,7.75,20,0),
  (10577,77,13,18,0),
  (10578,35,18,20,0),
  (10578,57,19.5,6,0),
  (10579,15,15.5,10,0),
  (10579,75,7.75,21,0),
  (10580,14,23.25,15,0.05),
  (10580,41,9.65,9,0.05),
  (10580,65,21.05,30,0.05),
  (10581,75,7.75,50,0.2),
  (10582,57,19.5,4,0),
  (10582,76,18,14,0),
  (10583,29,123.79,10,0),
  (10583,60,34,24,0.15),
  (10583,69,36,10,0.15),
  (10584,31,12.5,50,0.05),
  (10585,47,9.5,15,0),
  (10586,52,7,4,0.15),
  (10587,26,31.23,6,0),
  (10587,35,18,20,0),
  (10587,77,13,20,0),
  (10588,18,62.5,40,0.2),
  (10588,42,14,100,0.2),
  (10589,35,18,4,0),
  (10590,1,18,20,0),
  (10590,77,13,60,0.05),
  (10591,3,10,14,0),
  (10591,7,30,10,0),
  (10591,54,7.45,50,0),
  (10592,15,15.5,25,0.05),
  (10592,26,31.23,5,0.05),
  (10593,20,81,21,0.2),
  (10593,69,36,20,0.2),
  (10593,76,18,4,0.2),
  (10594,52,7,24,0),
  (10594,58,13.25,30,0),
  (10595,35,18,30,0.25),
  (10595,61,28.5,120,0.25),
  (10595,69,36,65,0.25),
  (10596,56,38,5,0.2),
  (10596,63,43.9,24,0.2),
  (10596,75,7.75,30,0.2),
  (10597,24,4.5,35,0.2),
  (10597,57,19.5,20,0),
  (10597,65,21.05,12,0.2),
  (10598,27,43.9,50,0),
  (10598,71,21.5,9,0),
  (10599,62,49.3,10,0),
  (10600,54,7.45,4,0),
  (10600,73,15,30,0),
  (10601,13,6,60,0),
  (10601,59,55,35,0),
  (10602,77,13,5,0.25),
  (10603,22,21,48,0),
  (10603,49,20,25,0.05),
  (10604,48,12.75,6,0.1),
  (10604,76,18,10,0.1),
  (10605,16,17.45,30,0.05),
  (10605,59,55,20,0.05),
  (10605,60,34,70,0.05),
  (10605,71,21.5,15,0.05),
  (10606,4,22,20,0.2),
  (10606,55,24,20,0.2),
  (10606,62,49.3,10,0.2),
  (10607,7,30,45,0),
  (10607,17,39,100,0),
  (10607,33,2.5,14,0),
  (10607,40,18.4,42,0),
  (10607,72,34.8,12,0),
  (10608,56,38,28,0),
  (10609,1,18,3,0),
  (10609,10,31,10,0),
  (10609,21,10,6,0),
  (10610,36,19,21,0.25),
  (10611,1,18,6,0),
  (10611,2,19,10,0),
  (10611,60,34,15,0),
  (10612,10,31,70,0),
  (10612,36,19,55,0),
  (10612,49,20,18,0),
  (10612,60,34,40,0),
  (10612,76,18,80,0),
  (10613,13,6,8,0.1),
  (10613,75,7.75,40,0),
  (10614,11,21,14,0),
  (10614,21,10,8,0),
  (10614,39,18,5,0),
  (10615,55,24,5,0),
  (10616,38,263.5,15,0.05),
  (10616,56,38,14,0),
  (10616,70,15,15,0.05),
  (10616,71,21.5,15,0.05),
  (10617,59,55,30,0.15),
  (10618,6,25,70,0),
  (10618,56,38,20,0),
  (10618,68,12.5,15,0),
  (10619,21,10,42,0),
  (10619,22,21,40,0),
  (10620,24,4.5,5,0),
  (10620,52,7,5,0),
  (10621,19,9.2,5,0),
  (10621,23,9,10,0),
  (10621,70,15,20,0),
  (10621,71,21.5,15,0),
  (10622,2,19,20,0),
  (10622,68,12.5,18,0.2),
  (10623,14,23.25,21,0),
  (10623,19,9.2,15,0.1),
  (10623,21,10,25,0.1),
  (10623,24,4.5,3,0),
  (10623,35,18,30,0.1),
  (10624,28,45.6,10,0),
  (10624,29,123.79,6,0),
  (10624,44,19.45,10,0),
  (10625,14,23.25,3,0),
  (10625,42,14,5,0),
  (10625,60,34,10,0);

COMMIT;

#
# Data for the `Order Details` table  (LIMIT 1000,500)
#

INSERT INTO `Order Details` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES 
  (10626,53,32.8,12,0),
  (10626,60,34,20,0),
  (10626,71,21.5,20,0),
  (10627,62,49.3,15,0),
  (10627,73,15,35,0.15),
  (10628,1,18,25,0),
  (10629,29,123.79,20,0),
  (10629,64,33.25,9,0),
  (10630,55,24,12,0.05),
  (10630,76,18,35,0),
  (10631,75,7.75,8,0.1),
  (10632,2,19,30,0.05),
  (10632,33,2.5,20,0.05),
  (10633,12,38,36,0.15),
  (10633,13,6,13,0.15),
  (10633,26,31.23,35,0.15),
  (10633,62,49.3,80,0.15),
  (10634,7,30,35,0),
  (10634,18,62.5,50,0),
  (10634,51,53,15,0),
  (10634,75,7.75,2,0),
  (10635,4,22,10,0.1),
  (10635,5,21.35,15,0.1),
  (10635,22,21,40,0),
  (10636,4,22,25,0),
  (10636,58,13.25,6,0),
  (10637,11,21,10,0),
  (10637,50,16.25,25,0.05),
  (10637,56,38,60,0.05),
  (10638,45,9.5,20,0),
  (10638,65,21.05,21,0),
  (10638,72,34.8,60,0),
  (10639,18,62.5,8,0),
  (10640,69,36,20,0.25),
  (10640,70,15,15,0.25),
  (10641,2,19,50,0),
  (10641,40,18.4,60,0),
  (10642,21,10,30,0.2),
  (10642,61,28.5,20,0.2),
  (10643,28,45.6,15,0.25),
  (10643,39,18,21,0.25),
  (10643,46,12,2,0.25),
  (10644,18,62.5,4,0.1),
  (10644,43,46,20,0),
  (10644,46,12,21,0.1),
  (10645,18,62.5,20,0),
  (10645,36,19,15,0),
  (10646,1,18,15,0.25),
  (10646,10,31,18,0.25),
  (10646,71,21.5,30,0.25),
  (10646,77,13,35,0.25),
  (10647,19,9.2,30,0),
  (10647,39,18,20,0),
  (10648,22,21,15,0),
  (10648,24,4.5,15,0.15),
  (10649,28,45.6,20,0),
  (10649,72,34.8,15,0),
  (10650,30,25.89,30,0),
  (10650,53,32.8,25,0.05),
  (10650,54,7.45,30,0),
  (10651,19,9.2,12,0.25),
  (10651,22,21,20,0.25),
  (10652,30,25.89,2,0.25),
  (10652,42,14,20,0),
  (10653,16,17.45,30,0.1),
  (10653,60,34,20,0.1),
  (10654,4,22,12,0.1),
  (10654,39,18,20,0.1),
  (10654,54,7.45,6,0.1),
  (10655,41,9.65,20,0.2),
  (10656,14,23.25,3,0.1),
  (10656,44,19.45,28,0.1),
  (10656,47,9.5,6,0.1),
  (10657,15,15.5,50,0),
  (10657,41,9.65,24,0),
  (10657,46,12,45,0),
  (10657,47,9.5,10,0),
  (10657,56,38,45,0),
  (10657,60,34,30,0),
  (10658,21,10,60,0),
  (10658,40,18.4,70,0.05),
  (10658,60,34,55,0.05),
  (10658,77,13,70,0.05),
  (10659,31,12.5,20,0.05),
  (10659,40,18.4,24,0.05),
  (10659,70,15,40,0.05),
  (10660,20,81,21,0),
  (10661,39,18,3,0.2),
  (10661,58,13.25,49,0.2),
  (10662,68,12.5,10,0),
  (10663,40,18.4,30,0.05),
  (10663,42,14,30,0.05),
  (10663,51,53,20,0.05),
  (10664,10,31,24,0.15),
  (10664,56,38,12,0.15),
  (10664,65,21.05,15,0.15),
  (10665,51,53,20,0),
  (10665,59,55,1,0),
  (10665,76,18,10,0),
  (10666,29,123.79,36,0),
  (10666,65,21.05,10,0),
  (10667,69,36,45,0.2),
  (10667,71,21.5,14,0.2),
  (10668,31,12.5,8,0.1),
  (10668,55,24,4,0.1),
  (10668,64,33.25,15,0.1),
  (10669,36,19,30,0),
  (10670,23,9,32,0),
  (10670,46,12,60,0),
  (10670,67,14,25,0),
  (10670,73,15,50,0),
  (10670,75,7.75,25,0),
  (10671,16,17.45,10,0),
  (10671,62,49.3,10,0),
  (10671,65,21.05,12,0),
  (10672,38,263.5,15,0.1),
  (10672,71,21.5,12,0),
  (10673,16,17.45,3,0),
  (10673,42,14,6,0),
  (10673,43,46,6,0),
  (10674,23,9,5,0),
  (10675,14,23.25,30,0),
  (10675,53,32.8,10,0),
  (10675,58,13.25,30,0),
  (10676,10,31,2,0),
  (10676,19,9.2,7,0),
  (10676,44,19.45,21,0),
  (10677,26,31.23,30,0.15),
  (10677,33,2.5,8,0.15),
  (10678,12,38,100,0),
  (10678,33,2.5,30,0),
  (10678,41,9.65,120,0),
  (10678,54,7.45,30,0),
  (10679,59,55,12,0),
  (10680,16,17.45,50,0.25),
  (10680,31,12.5,20,0.25),
  (10680,42,14,40,0.25),
  (10681,19,9.2,30,0.1),
  (10681,21,10,12,0.1),
  (10681,64,33.25,28,0),
  (10682,33,2.5,30,0),
  (10682,66,17,4,0),
  (10682,75,7.75,30,0),
  (10683,52,7,9,0),
  (10684,40,18.4,20,0),
  (10684,47,9.5,40,0),
  (10684,60,34,30,0),
  (10685,10,31,20,0),
  (10685,41,9.65,4,0),
  (10685,47,9.5,15,0),
  (10686,17,39,30,0.2),
  (10686,26,31.23,15,0),
  (10687,9,97,50,0.25),
  (10687,29,123.79,10,0),
  (10687,36,19,6,0.25),
  (10688,10,31,18,0.1),
  (10688,28,45.6,60,0.1),
  (10688,34,14,14,0),
  (10689,1,18,35,0.25),
  (10690,56,38,20,0.25),
  (10690,77,13,30,0.25),
  (10691,1,18,30,0),
  (10691,29,123.79,40,0),
  (10691,43,46,40,0),
  (10691,44,19.45,24,0),
  (10691,62,49.3,48,0),
  (10692,63,43.9,20,0),
  (10693,9,97,6,0),
  (10693,54,7.45,60,0.15),
  (10693,69,36,30,0.15),
  (10693,73,15,15,0.15),
  (10694,7,30,90,0),
  (10694,59,55,25,0),
  (10694,70,15,50,0),
  (10695,8,40,10,0),
  (10695,12,38,4,0),
  (10695,24,4.5,20,0),
  (10696,17,39,20,0),
  (10696,46,12,18,0),
  (10697,19,9.2,7,0.25),
  (10697,35,18,9,0.25),
  (10697,58,13.25,30,0.25),
  (10697,70,15,30,0.25),
  (10698,11,21,15,0),
  (10698,17,39,8,0.05),
  (10698,29,123.79,12,0.05),
  (10698,65,21.05,65,0.05),
  (10698,70,15,8,0.05),
  (10699,47,9.5,12,0),
  (10700,1,18,5,0.2),
  (10700,34,14,12,0.2),
  (10700,68,12.5,40,0.2),
  (10700,71,21.5,60,0.2),
  (10701,59,55,42,0.15),
  (10701,71,21.5,20,0.15),
  (10701,76,18,35,0.15),
  (10702,3,10,6,0),
  (10702,76,18,15,0),
  (10703,2,19,5,0),
  (10703,59,55,35,0),
  (10703,73,15,35,0),
  (10704,4,22,6,0),
  (10704,24,4.5,35,0),
  (10704,48,12.75,24,0),
  (10705,31,12.5,20,0),
  (10705,32,32,4,0),
  (10706,16,17.45,20,0),
  (10706,43,46,24,0),
  (10706,59,55,8,0),
  (10707,55,24,21,0),
  (10707,57,19.5,40,0),
  (10707,70,15,28,0.15),
  (10708,5,21.35,4,0),
  (10708,36,19,5,0),
  (10709,8,40,40,0),
  (10709,51,53,28,0),
  (10709,60,34,10,0),
  (10710,19,9.2,5,0),
  (10710,47,9.5,5,0),
  (10711,19,9.2,12,0),
  (10711,41,9.65,42,0),
  (10711,53,32.8,120,0),
  (10712,53,32.8,3,0.05),
  (10712,56,38,30,0),
  (10713,10,31,18,0),
  (10713,26,31.23,30,0),
  (10713,45,9.5,110,0),
  (10713,46,12,24,0),
  (10714,2,19,30,0.25),
  (10714,17,39,27,0.25),
  (10714,47,9.5,50,0.25),
  (10714,56,38,18,0.25),
  (10714,58,13.25,12,0.25),
  (10715,10,31,21,0),
  (10715,71,21.5,30,0),
  (10716,21,10,5,0),
  (10716,51,53,7,0),
  (10716,61,28.5,10,0),
  (10717,21,10,32,0.05),
  (10717,54,7.45,15,0),
  (10717,69,36,25,0.05),
  (10718,12,38,36,0),
  (10718,16,17.45,20,0),
  (10718,36,19,40,0),
  (10718,62,49.3,20,0),
  (10719,18,62.5,12,0.25),
  (10719,30,25.89,3,0.25),
  (10719,54,7.45,40,0.25),
  (10720,35,18,21,0),
  (10720,71,21.5,8,0),
  (10721,44,19.45,50,0.05),
  (10722,2,19,3,0),
  (10722,31,12.5,50,0),
  (10722,68,12.5,45,0),
  (10722,75,7.75,42,0),
  (10723,26,31.23,15,0),
  (10724,10,31,16,0),
  (10724,61,28.5,5,0),
  (10725,41,9.65,12,0),
  (10725,52,7,4,0),
  (10725,55,24,6,0),
  (10726,4,22,25,0),
  (10726,11,21,5,0),
  (10727,17,39,20,0.05),
  (10727,56,38,10,0.05),
  (10727,59,55,10,0.05),
  (10728,30,25.89,15,0),
  (10728,40,18.4,6,0),
  (10728,55,24,12,0),
  (10728,60,34,15,0),
  (10729,1,18,50,0),
  (10729,21,10,30,0),
  (10729,50,16.25,40,0),
  (10730,16,17.45,15,0.05),
  (10730,31,12.5,3,0.05),
  (10730,65,21.05,10,0.05),
  (10731,21,10,40,0.05),
  (10731,51,53,30,0.05),
  (10732,76,18,20,0),
  (10733,14,23.25,16,0),
  (10733,28,45.6,20,0),
  (10733,52,7,25,0),
  (10734,6,25,30,0),
  (10734,30,25.89,15,0),
  (10734,76,18,20,0),
  (10735,61,28.5,20,0.1),
  (10735,77,13,2,0.1),
  (10736,65,21.05,40,0),
  (10736,75,7.75,20,0),
  (10737,13,6,4,0),
  (10737,41,9.65,12,0),
  (10738,16,17.45,3,0),
  (10739,36,19,6,0),
  (10739,52,7,18,0),
  (10740,28,45.6,5,0.2),
  (10740,35,18,35,0.2),
  (10740,45,9.5,40,0.2),
  (10740,56,38,14,0.2),
  (10741,2,19,15,0.2),
  (10742,3,10,20,0),
  (10742,60,34,50,0),
  (10742,72,34.8,35,0),
  (10743,46,12,28,0.05),
  (10744,40,18.4,50,0.2),
  (10745,18,62.5,24,0),
  (10745,44,19.45,16,0),
  (10745,59,55,45,0),
  (10745,72,34.8,7,0),
  (10746,13,6,6,0),
  (10746,42,14,28,0),
  (10746,62,49.3,9,0),
  (10746,69,36,40,0),
  (10747,31,12.5,8,0),
  (10747,41,9.65,35,0),
  (10747,63,43.9,9,0),
  (10747,69,36,30,0),
  (10748,23,9,44,0),
  (10748,40,18.4,40,0),
  (10748,56,38,28,0),
  (10749,56,38,15,0),
  (10749,59,55,6,0),
  (10749,76,18,10,0),
  (10750,14,23.25,5,0.15),
  (10750,45,9.5,40,0.15),
  (10750,59,55,25,0.15),
  (10751,26,31.23,12,0.1),
  (10751,30,25.89,30,0),
  (10751,50,16.25,20,0.1),
  (10751,73,15,15,0),
  (10752,1,18,8,0),
  (10752,69,36,3,0),
  (10753,45,9.5,4,0),
  (10753,74,10,5,0),
  (10754,40,18.4,3,0),
  (10755,47,9.5,30,0.25),
  (10755,56,38,30,0.25),
  (10755,57,19.5,14,0.25),
  (10755,69,36,25,0.25),
  (10756,18,62.5,21,0.2),
  (10756,36,19,20,0.2),
  (10756,68,12.5,6,0.2),
  (10756,69,36,20,0.2),
  (10757,34,14,30,0),
  (10757,59,55,7,0),
  (10757,62,49.3,30,0),
  (10757,64,33.25,24,0),
  (10758,26,31.23,20,0),
  (10758,52,7,60,0),
  (10758,70,15,40,0),
  (10759,32,32,10,0),
  (10760,25,14,12,0.25),
  (10760,27,43.9,40,0),
  (10760,43,46,30,0.25),
  (10761,25,14,35,0.25),
  (10761,75,7.75,18,0),
  (10762,39,18,16,0),
  (10762,47,9.5,30,0),
  (10762,51,53,28,0),
  (10762,56,38,60,0),
  (10763,21,10,40,0),
  (10763,22,21,6,0),
  (10763,24,4.5,20,0),
  (10764,3,10,20,0.1),
  (10764,39,18,130,0.1),
  (10765,65,21.05,80,0.1),
  (10766,2,19,40,0),
  (10766,7,30,35,0),
  (10766,68,12.5,40,0),
  (10767,42,14,2,0),
  (10768,22,21,4,0),
  (10768,31,12.5,50,0),
  (10768,60,34,15,0),
  (10768,71,21.5,12,0),
  (10769,41,9.65,30,0.05),
  (10769,52,7,15,0.05),
  (10769,61,28.5,20,0),
  (10769,62,49.3,15,0),
  (10770,11,21,15,0.25),
  (10771,71,21.5,16,0),
  (10772,29,123.79,18,0),
  (10772,59,55,25,0),
  (10773,17,39,33,0),
  (10773,31,12.5,70,0.2),
  (10773,75,7.75,7,0.2),
  (10774,31,12.5,2,0.25),
  (10774,66,17,50,0),
  (10775,10,31,6,0),
  (10775,67,14,3,0),
  (10776,31,12.5,16,0.05),
  (10776,42,14,12,0.05),
  (10776,45,9.5,27,0.05),
  (10776,51,53,120,0.05),
  (10777,42,14,20,0.2),
  (10778,41,9.65,10,0),
  (10779,16,17.45,20,0),
  (10779,62,49.3,20,0),
  (10780,70,15,35,0),
  (10780,77,13,15,0),
  (10781,54,7.45,3,0.2),
  (10781,56,38,20,0.2),
  (10781,74,10,35,0),
  (10782,31,12.5,1,0),
  (10783,31,12.5,10,0),
  (10783,38,263.5,5,0),
  (10784,36,19,30,0),
  (10784,39,18,2,0.15),
  (10784,72,34.8,30,0.15),
  (10785,10,31,10,0),
  (10785,75,7.75,10,0),
  (10786,8,40,30,0.2),
  (10786,30,25.89,15,0.2),
  (10786,75,7.75,42,0.2),
  (10787,2,19,15,0.05),
  (10787,29,123.79,20,0.05),
  (10788,19,9.2,50,0.05),
  (10788,75,7.75,40,0.05),
  (10789,18,62.5,30,0),
  (10789,35,18,15,0),
  (10789,63,43.9,30,0),
  (10789,68,12.5,18,0),
  (10790,7,30,3,0.15),
  (10790,56,38,20,0.15),
  (10791,29,123.79,14,0.05),
  (10791,41,9.65,20,0.05),
  (10792,2,19,10,0),
  (10792,54,7.45,3,0),
  (10792,68,12.5,15,0),
  (10793,41,9.65,14,0),
  (10793,52,7,8,0),
  (10794,14,23.25,15,0.2),
  (10794,54,7.45,6,0.2),
  (10795,16,17.45,65,0),
  (10795,17,39,35,0.25),
  (10796,26,31.23,21,0.2),
  (10796,44,19.45,10,0),
  (10796,64,33.25,35,0.2),
  (10796,69,36,24,0.2),
  (10797,11,21,20,0),
  (10798,62,49.3,2,0),
  (10798,72,34.8,10,0),
  (10799,13,6,20,0.15),
  (10799,24,4.5,20,0.15),
  (10799,59,55,25,0),
  (10800,11,21,50,0.1),
  (10800,51,53,10,0.1),
  (10800,54,7.45,7,0.1),
  (10801,17,39,40,0.25),
  (10801,29,123.79,20,0.25),
  (10802,30,25.89,25,0.25),
  (10802,51,53,30,0.25),
  (10802,55,24,60,0.25),
  (10802,62,49.3,5,0.25),
  (10803,19,9.2,24,0.05),
  (10803,25,14,15,0.05),
  (10803,59,55,15,0.05),
  (10804,10,31,36,0),
  (10804,28,45.6,24,0),
  (10804,49,20,4,0.15),
  (10805,34,14,10,0),
  (10805,38,263.5,10,0),
  (10806,2,19,20,0.25),
  (10806,65,21.05,2,0),
  (10806,74,10,15,0.25),
  (10807,40,18.4,1,0),
  (10808,56,38,20,0.15),
  (10808,76,18,50,0.15),
  (10809,52,7,20,0),
  (10810,13,6,7,0),
  (10810,25,14,5,0),
  (10810,70,15,5,0),
  (10811,19,9.2,15,0),
  (10811,23,9,18,0),
  (10811,40,18.4,30,0),
  (10812,31,12.5,16,0.1),
  (10812,72,34.8,40,0.1),
  (10812,77,13,20,0),
  (10813,2,19,12,0.2),
  (10813,46,12,35,0),
  (10814,41,9.65,20,0),
  (10814,43,46,20,0.15),
  (10814,48,12.75,8,0.15),
  (10814,61,28.5,30,0.15),
  (10815,33,2.5,16,0),
  (10816,38,263.5,30,0.05),
  (10816,62,49.3,20,0.05),
  (10817,26,31.23,40,0.15),
  (10817,38,263.5,30,0),
  (10817,40,18.4,60,0.15),
  (10817,62,49.3,25,0.15),
  (10818,32,32,20,0),
  (10818,41,9.65,20,0),
  (10819,43,46,7,0),
  (10819,75,7.75,20,0),
  (10820,56,38,30,0),
  (10821,35,18,20,0),
  (10821,51,53,6,0),
  (10822,62,49.3,3,0),
  (10822,70,15,6,0),
  (10823,11,21,20,0.1),
  (10823,57,19.5,15,0);

COMMIT;

#
# Data for the `Order Details` table  (LIMIT 1500,500)
#

INSERT INTO `Order Details` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES 
  (10823,59,55,40,0.1),
  (10823,77,13,15,0.1),
  (10824,41,9.65,12,0),
  (10824,70,15,9,0),
  (10825,26,31.23,12,0),
  (10825,53,32.8,20,0),
  (10826,31,12.5,35,0),
  (10826,57,19.5,15,0),
  (10827,10,31,15,0),
  (10827,39,18,21,0),
  (10828,20,81,5,0),
  (10828,38,263.5,2,0),
  (10829,2,19,10,0),
  (10829,8,40,20,0),
  (10829,13,6,10,0),
  (10829,60,34,21,0),
  (10830,6,25,6,0),
  (10830,39,18,28,0),
  (10830,60,34,30,0),
  (10830,68,12.5,24,0),
  (10831,19,9.2,2,0),
  (10831,35,18,8,0),
  (10831,38,263.5,8,0),
  (10831,43,46,9,0),
  (10832,13,6,3,0.2),
  (10832,25,14,10,0.2),
  (10832,44,19.45,16,0.2),
  (10832,64,33.25,3,0),
  (10833,7,30,20,0.1),
  (10833,31,12.5,9,0.1),
  (10833,53,32.8,9,0.1),
  (10834,29,123.79,8,0.05),
  (10834,30,25.89,20,0.05),
  (10835,59,55,15,0),
  (10835,77,13,2,0.2),
  (10836,22,21,52,0),
  (10836,35,18,6,0),
  (10836,57,19.5,24,0),
  (10836,60,34,60,0),
  (10836,64,33.25,30,0),
  (10837,13,6,6,0),
  (10837,40,18.4,25,0),
  (10837,47,9.5,40,0.25),
  (10837,76,18,21,0.25),
  (10838,1,18,4,0.25),
  (10838,18,62.5,25,0.25),
  (10838,36,19,50,0.25),
  (10839,58,13.25,30,0.1),
  (10839,72,34.8,15,0.1),
  (10840,25,14,6,0.2),
  (10840,39,18,10,0.2),
  (10841,10,31,16,0),
  (10841,56,38,30,0),
  (10841,59,55,50,0),
  (10841,77,13,15,0),
  (10842,11,21,15,0),
  (10842,43,46,5,0),
  (10842,68,12.5,20,0),
  (10842,70,15,12,0),
  (10843,51,53,4,0.25),
  (10844,22,21,35,0),
  (10845,23,9,70,0.1),
  (10845,35,18,25,0.1),
  (10845,42,14,42,0.1),
  (10845,58,13.25,60,0.1),
  (10845,64,33.25,48,0),
  (10846,4,22,21,0),
  (10846,70,15,30,0),
  (10846,74,10,20,0),
  (10847,1,18,80,0.2),
  (10847,19,9.2,12,0.2),
  (10847,37,26,60,0.2),
  (10847,45,9.5,36,0.2),
  (10847,60,34,45,0.2),
  (10847,71,21.5,55,0.2),
  (10848,5,21.35,30,0),
  (10848,9,97,3,0),
  (10849,3,10,49,0),
  (10849,26,31.23,18,0.15),
  (10850,25,14,20,0.15),
  (10850,33,2.5,4,0.15),
  (10850,70,15,30,0.15),
  (10851,2,19,5,0.05),
  (10851,25,14,10,0.05),
  (10851,57,19.5,10,0.05),
  (10851,59,55,42,0.05),
  (10852,2,19,15,0),
  (10852,17,39,6,0),
  (10852,62,49.3,50,0),
  (10853,18,62.5,10,0),
  (10854,10,31,100,0.15),
  (10854,13,6,65,0.15),
  (10855,16,17.45,50,0),
  (10855,31,12.5,14,0),
  (10855,56,38,24,0),
  (10855,65,21.05,15,0.15),
  (10856,2,19,20,0),
  (10856,42,14,20,0),
  (10857,3,10,30,0),
  (10857,26,31.23,35,0.25),
  (10857,29,123.79,10,0.25),
  (10858,7,30,5,0),
  (10858,27,43.9,10,0),
  (10858,70,15,4,0),
  (10859,24,4.5,40,0.25),
  (10859,54,7.45,35,0.25),
  (10859,64,33.25,30,0.25),
  (10860,51,53,3,0),
  (10860,76,18,20,0),
  (10861,17,39,42,0),
  (10861,18,62.5,20,0),
  (10861,21,10,40,0),
  (10861,33,2.5,35,0),
  (10861,62,49.3,3,0),
  (10862,11,21,25,0),
  (10862,52,7,8,0),
  (10863,1,18,20,0.15),
  (10863,58,13.25,12,0.15),
  (10864,35,18,4,0),
  (10864,67,14,15,0),
  (10865,38,263.5,60,0.05),
  (10865,39,18,80,0.05),
  (10866,2,19,21,0.25),
  (10866,24,4.5,6,0.25),
  (10866,30,25.89,40,0.25),
  (10867,53,32.8,3,0),
  (10868,26,31.23,20,0),
  (10868,35,18,30,0),
  (10868,49,20,42,0.1),
  (10869,1,18,40,0),
  (10869,11,21,10,0),
  (10869,23,9,50,0),
  (10869,68,12.5,20,0),
  (10870,35,18,3,0),
  (10870,51,53,2,0),
  (10871,6,25,50,0.05),
  (10871,16,17.45,12,0.05),
  (10871,17,39,16,0.05),
  (10872,55,24,10,0.05),
  (10872,62,49.3,20,0.05),
  (10872,64,33.25,15,0.05),
  (10872,65,21.05,21,0.05),
  (10873,21,10,20,0),
  (10873,28,45.6,3,0),
  (10874,10,31,10,0),
  (10875,19,9.2,25,0),
  (10875,47,9.5,21,0.1),
  (10875,49,20,15,0),
  (10876,46,12,21,0),
  (10876,64,33.25,20,0),
  (10877,16,17.45,30,0.25),
  (10877,18,62.5,25,0),
  (10878,20,81,20,0.05),
  (10879,40,18.4,12,0),
  (10879,65,21.05,10,0),
  (10879,76,18,10,0),
  (10880,23,9,30,0.2),
  (10880,61,28.5,30,0.2),
  (10880,70,15,50,0.2),
  (10881,73,15,10,0),
  (10882,42,14,25,0),
  (10882,49,20,20,0.15),
  (10882,54,7.45,32,0.15),
  (10883,24,4.5,8,0),
  (10884,21,10,40,0.05),
  (10884,56,38,21,0.05),
  (10884,65,21.05,12,0.05),
  (10885,2,19,20,0),
  (10885,24,4.5,12,0),
  (10885,70,15,30,0),
  (10885,77,13,25,0),
  (10886,10,31,70,0),
  (10886,31,12.5,35,0),
  (10886,77,13,40,0),
  (10887,25,14,5,0),
  (10888,2,19,20,0),
  (10888,68,12.5,18,0),
  (10889,11,21,40,0),
  (10889,38,263.5,40,0),
  (10890,17,39,15,0),
  (10890,34,14,10,0),
  (10890,41,9.65,14,0),
  (10891,30,25.89,15,0.05),
  (10892,59,55,40,0.05),
  (10893,8,40,30,0),
  (10893,24,4.5,10,0),
  (10893,29,123.79,24,0),
  (10893,30,25.89,35,0),
  (10893,36,19,20,0),
  (10894,13,6,28,0.05),
  (10894,69,36,50,0.05),
  (10894,75,7.75,120,0.05),
  (10895,24,4.5,110,0),
  (10895,39,18,45,0),
  (10895,40,18.4,91,0),
  (10895,60,34,100,0),
  (10896,45,9.5,15,0),
  (10896,56,38,16,0),
  (10897,29,123.79,80,0),
  (10897,30,25.89,36,0),
  (10898,13,6,5,0),
  (10899,39,18,8,0.15),
  (10900,70,15,3,0.25),
  (10901,41,9.65,30,0),
  (10901,71,21.5,30,0),
  (10902,55,24,30,0.15),
  (10902,62,49.3,6,0.15),
  (10903,13,6,40,0),
  (10903,65,21.05,21,0),
  (10903,68,12.5,20,0),
  (10904,58,13.25,15,0),
  (10904,62,49.3,35,0),
  (10905,1,18,20,0.05),
  (10906,61,28.5,15,0),
  (10907,75,7.75,14,0),
  (10908,7,30,20,0.05),
  (10908,52,7,14,0.05),
  (10909,7,30,12,0),
  (10909,16,17.45,15,0),
  (10909,41,9.65,5,0),
  (10910,19,9.2,12,0),
  (10910,49,20,10,0),
  (10910,61,28.5,5,0),
  (10911,1,18,10,0),
  (10911,17,39,12,0),
  (10911,67,14,15,0),
  (10912,11,21,40,0.25),
  (10912,29,123.79,60,0.25),
  (10913,4,22,30,0.25),
  (10913,33,2.5,40,0.25),
  (10913,58,13.25,15,0),
  (10914,71,21.5,25,0),
  (10915,17,39,10,0),
  (10915,33,2.5,30,0),
  (10915,54,7.45,10,0),
  (10916,16,17.45,6,0),
  (10916,32,32,6,0),
  (10916,57,19.5,20,0),
  (10917,30,25.89,1,0),
  (10917,60,34,10,0),
  (10918,1,18,60,0.25),
  (10918,60,34,25,0.25),
  (10919,16,17.45,24,0),
  (10919,25,14,24,0),
  (10919,40,18.4,20,0),
  (10920,50,16.25,24,0),
  (10921,35,18,10,0),
  (10921,63,43.9,40,0),
  (10922,17,39,15,0),
  (10922,24,4.5,35,0),
  (10923,42,14,10,0.2),
  (10923,43,46,10,0.2),
  (10923,67,14,24,0.2),
  (10924,10,31,20,0.1),
  (10924,28,45.6,30,0.1),
  (10924,75,7.75,6,0),
  (10925,36,19,25,0.15),
  (10925,52,7,12,0.15),
  (10926,11,21,2,0),
  (10926,13,6,10,0),
  (10926,19,9.2,7,0),
  (10926,72,34.8,10,0),
  (10927,20,81,5,0),
  (10927,52,7,5,0),
  (10927,76,18,20,0),
  (10928,47,9.5,5,0),
  (10928,76,18,5,0),
  (10929,21,10,60,0),
  (10929,75,7.75,49,0),
  (10929,77,13,15,0),
  (10930,21,10,36,0),
  (10930,27,43.9,25,0),
  (10930,55,24,25,0.2),
  (10930,58,13.25,30,0.2),
  (10931,13,6,42,0.15),
  (10931,57,19.5,30,0),
  (10932,16,17.45,30,0.1),
  (10932,62,49.3,14,0.1),
  (10932,72,34.8,16,0),
  (10932,75,7.75,20,0.1),
  (10933,53,32.8,2,0),
  (10933,61,28.5,30,0),
  (10934,6,25,20,0),
  (10935,1,18,21,0),
  (10935,18,62.5,4,0.25),
  (10935,23,9,8,0.25),
  (10936,36,19,30,0.2),
  (10937,28,45.6,8,0),
  (10937,34,14,20,0),
  (10938,13,6,20,0.25),
  (10938,43,46,24,0.25),
  (10938,60,34,49,0.25),
  (10938,71,21.5,35,0.25),
  (10939,2,19,10,0.15),
  (10939,67,14,40,0.15),
  (10940,7,30,8,0),
  (10940,13,6,20,0),
  (10941,31,12.5,44,0.25),
  (10941,62,49.3,30,0.25),
  (10941,68,12.5,80,0.25),
  (10941,72,34.8,50,0),
  (10942,49,20,28,0),
  (10943,13,6,15,0),
  (10943,22,21,21,0),
  (10943,46,12,15,0),
  (10944,11,21,5,0.25),
  (10944,44,19.45,18,0.25),
  (10944,56,38,18,0),
  (10945,13,6,20,0),
  (10945,31,12.5,10,0),
  (10946,10,31,25,0),
  (10946,24,4.5,25,0),
  (10946,77,13,40,0),
  (10947,59,55,4,0),
  (10948,50,16.25,9,0),
  (10948,51,53,40,0),
  (10948,55,24,4,0),
  (10949,6,25,12,0),
  (10949,10,31,30,0),
  (10949,17,39,6,0),
  (10949,62,49.3,60,0),
  (10950,4,22,5,0),
  (10951,33,2.5,15,0.05),
  (10951,41,9.65,6,0.05),
  (10951,75,7.75,50,0.05),
  (10952,6,25,16,0.05),
  (10952,28,45.6,2,0),
  (10953,20,81,50,0.05),
  (10953,31,12.5,50,0.05),
  (10954,16,17.45,28,0.15),
  (10954,31,12.5,25,0.15),
  (10954,45,9.5,30,0),
  (10954,60,34,24,0.15),
  (10955,75,7.75,12,0.2),
  (10956,21,10,12,0),
  (10956,47,9.5,14,0),
  (10956,51,53,8,0),
  (10957,30,25.89,30,0),
  (10957,35,18,40,0),
  (10957,64,33.25,8,0),
  (10958,5,21.35,20,0),
  (10958,7,30,6,0),
  (10958,72,34.8,5,0),
  (10959,75,7.75,20,0.15),
  (10960,24,4.5,10,0.25),
  (10960,41,9.65,24,0),
  (10961,52,7,6,0.05),
  (10961,76,18,60,0),
  (10962,7,30,45,0),
  (10962,13,6,77,0),
  (10962,53,32.8,20,0),
  (10962,69,36,9,0),
  (10962,76,18,44,0),
  (10963,60,34,2,0.15),
  (10964,18,62.5,6,0),
  (10964,38,263.5,5,0),
  (10964,69,36,10,0),
  (10965,51,53,16,0),
  (10966,37,26,8,0),
  (10966,56,38,12,0.15),
  (10966,62,49.3,12,0.15),
  (10967,19,9.2,12,0),
  (10967,49,20,40,0),
  (10968,12,38,30,0),
  (10968,24,4.5,30,0),
  (10968,64,33.25,4,0),
  (10969,46,12,9,0),
  (10970,52,7,40,0.2),
  (10971,29,123.79,14,0),
  (10972,17,39,6,0),
  (10972,33,2.5,7,0),
  (10973,26,31.23,5,0),
  (10973,41,9.65,6,0),
  (10973,75,7.75,10,0),
  (10974,63,43.9,10,0),
  (10975,8,40,16,0),
  (10975,75,7.75,10,0),
  (10976,28,45.6,20,0),
  (10977,39,18,30,0),
  (10977,47,9.5,30,0),
  (10977,51,53,10,0),
  (10977,63,43.9,20,0),
  (10978,8,40,20,0.15),
  (10978,21,10,40,0.15),
  (10978,40,18.4,10,0),
  (10978,44,19.45,6,0.15),
  (10979,7,30,18,0),
  (10979,12,38,20,0),
  (10979,24,4.5,80,0),
  (10979,27,43.9,30,0),
  (10979,31,12.5,24,0),
  (10979,63,43.9,35,0),
  (10980,75,7.75,40,0.2),
  (10981,38,263.5,60,0),
  (10982,7,30,20,0),
  (10982,43,46,9,0),
  (10983,13,6,84,0.15),
  (10983,57,19.5,15,0),
  (10984,16,17.45,55,0),
  (10984,24,4.5,20,0),
  (10984,36,19,40,0),
  (10985,16,17.45,36,0.1),
  (10985,18,62.5,8,0.1),
  (10985,32,32,35,0.1),
  (10986,11,21,30,0),
  (10986,20,81,15,0),
  (10986,76,18,10,0),
  (10986,77,13,15,0),
  (10987,7,30,60,0),
  (10987,43,46,6,0),
  (10987,72,34.8,20,0),
  (10988,7,30,60,0),
  (10988,62,49.3,40,0.1),
  (10989,6,25,40,0),
  (10989,11,21,15,0),
  (10989,41,9.65,4,0),
  (10990,21,10,65,0),
  (10990,34,14,60,0.15),
  (10990,55,24,65,0.15),
  (10990,61,28.5,66,0.15),
  (10991,2,19,50,0.2),
  (10991,70,15,20,0.2),
  (10991,76,18,90,0.2),
  (10992,72,34.8,2,0),
  (10993,29,123.79,50,0.25),
  (10993,41,9.65,35,0.25),
  (10994,59,55,18,0.05),
  (10995,51,53,20,0),
  (10995,60,34,4,0),
  (10996,42,14,40,0),
  (10997,32,32,50,0),
  (10997,46,12,20,0.25),
  (10997,52,7,20,0.25),
  (10998,24,4.5,12,0),
  (10998,61,28.5,7,0),
  (10998,74,10,20,0),
  (10998,75,7.75,30,0),
  (10999,41,9.65,20,0.05),
  (10999,51,53,15,0.05),
  (10999,77,13,21,0.05),
  (11000,4,22,25,0.25),
  (11000,24,4.5,30,0.25),
  (11000,77,13,30,0),
  (11001,7,30,60,0),
  (11001,22,21,25,0),
  (11001,46,12,25,0),
  (11001,55,24,6,0),
  (11002,13,6,56,0),
  (11002,35,18,15,0.15),
  (11002,42,14,24,0.15),
  (11002,55,24,40,0),
  (11003,1,18,4,0),
  (11003,40,18.4,10,0),
  (11003,52,7,10,0),
  (11004,26,31.23,6,0),
  (11004,76,18,6,0),
  (11005,1,18,2,0),
  (11005,59,55,10,0),
  (11006,1,18,8,0),
  (11006,29,123.79,2,0.25),
  (11007,8,40,30,0),
  (11007,29,123.79,10,0),
  (11007,42,14,14,0),
  (11008,28,45.6,70,0.05),
  (11008,34,14,90,0.05),
  (11008,71,21.5,21,0),
  (11009,24,4.5,12,0),
  (11009,36,19,18,0.25),
  (11009,60,34,9,0),
  (11010,7,30,20,0),
  (11010,24,4.5,10,0),
  (11011,58,13.25,40,0.05),
  (11011,71,21.5,20,0),
  (11012,19,9.2,50,0.05),
  (11012,60,34,36,0.05),
  (11012,71,21.5,60,0.05),
  (11013,23,9,10,0),
  (11013,42,14,4,0),
  (11013,45,9.5,20,0),
  (11013,68,12.5,2,0),
  (11014,41,9.65,28,0.1),
  (11015,30,25.89,15,0),
  (11015,77,13,18,0),
  (11016,31,12.5,15,0),
  (11016,36,19,16,0),
  (11017,3,10,25,0),
  (11017,59,55,110,0),
  (11017,70,15,30,0),
  (11018,12,38,20,0),
  (11018,18,62.5,10,0),
  (11018,56,38,5,0),
  (11019,46,12,3,0),
  (11019,49,20,2,0),
  (11020,10,31,24,0.15),
  (11021,2,19,11,0.25),
  (11021,20,81,15,0),
  (11021,26,31.23,63,0),
  (11021,51,53,44,0.25),
  (11021,72,34.8,35,0),
  (11022,19,9.2,35,0);

COMMIT;

#
# Data for the `Order Details` table  (LIMIT 2000,500)
#

INSERT INTO `Order Details` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`, `Discount`) VALUES 
  (11022,69,36,30,0),
  (11023,7,30,4,0),
  (11023,43,46,30,0),
  (11024,26,31.23,12,0),
  (11024,33,2.5,30,0),
  (11024,65,21.05,21,0),
  (11024,71,21.5,50,0),
  (11025,1,18,10,0.1),
  (11025,13,6,20,0.1),
  (11026,18,62.5,8,0),
  (11026,51,53,10,0),
  (11027,24,4.5,30,0.25),
  (11027,62,49.3,21,0.25),
  (11028,55,24,35,0),
  (11028,59,55,24,0),
  (11029,56,38,20,0),
  (11029,63,43.9,12,0),
  (11030,2,19,100,0.25),
  (11030,5,21.35,70,0),
  (11030,29,123.79,60,0.25),
  (11030,59,55,100,0.25),
  (11031,1,18,45,0),
  (11031,13,6,80,0),
  (11031,24,4.5,21,0),
  (11031,64,33.25,20,0),
  (11031,71,21.5,16,0),
  (11032,36,19,35,0),
  (11032,38,263.5,25,0),
  (11032,59,55,30,0),
  (11033,53,32.8,70,0.1),
  (11033,69,36,36,0.1),
  (11034,21,10,15,0.1),
  (11034,44,19.45,12,0),
  (11034,61,28.5,6,0),
  (11035,1,18,10,0),
  (11035,35,18,60,0),
  (11035,42,14,30,0),
  (11035,54,7.45,10,0),
  (11036,13,6,7,0),
  (11036,59,55,30,0),
  (11037,70,15,4,0),
  (11038,40,18.4,5,0.2),
  (11038,52,7,2,0),
  (11038,71,21.5,30,0),
  (11039,28,45.6,20,0),
  (11039,35,18,24,0),
  (11039,49,20,60,0),
  (11039,57,19.5,28,0),
  (11040,21,10,20,0),
  (11041,2,19,30,0.2),
  (11041,63,43.9,30,0),
  (11042,44,19.45,15,0),
  (11042,61,28.5,4,0),
  (11043,11,21,10,0),
  (11044,62,49.3,12,0),
  (11045,33,2.5,15,0),
  (11045,51,53,24,0),
  (11046,12,38,20,0.05),
  (11046,32,32,15,0.05),
  (11046,35,18,18,0.05),
  (11047,1,18,25,0.25),
  (11047,5,21.35,30,0.25),
  (11048,68,12.5,42,0),
  (11049,2,19,10,0.2),
  (11049,12,38,4,0.2),
  (11050,76,18,50,0.1),
  (11051,24,4.5,10,0.2),
  (11052,43,46,30,0.2),
  (11052,61,28.5,10,0.2),
  (11053,18,62.5,35,0.2),
  (11053,32,32,20,0),
  (11053,64,33.25,25,0.2),
  (11054,33,2.5,10,0),
  (11054,67,14,20,0),
  (11055,24,4.5,15,0),
  (11055,25,14,15,0),
  (11055,51,53,20,0),
  (11055,57,19.5,20,0),
  (11056,7,30,40,0),
  (11056,55,24,35,0),
  (11056,60,34,50,0),
  (11057,70,15,3,0),
  (11058,21,10,3,0),
  (11058,60,34,21,0),
  (11058,61,28.5,4,0),
  (11059,13,6,30,0),
  (11059,17,39,12,0),
  (11059,60,34,35,0),
  (11060,60,34,4,0),
  (11060,77,13,10,0),
  (11061,60,34,15,0),
  (11062,53,32.8,10,0.2),
  (11062,70,15,12,0.2),
  (11063,34,14,30,0),
  (11063,40,18.4,40,0.1),
  (11063,41,9.65,30,0.1),
  (11064,17,39,77,0.1),
  (11064,41,9.65,12,0),
  (11064,53,32.8,25,0.1),
  (11064,55,24,4,0.1),
  (11064,68,12.5,55,0),
  (11065,30,25.89,4,0.25),
  (11065,54,7.45,20,0.25),
  (11066,16,17.45,3,0),
  (11066,19,9.2,42,0),
  (11066,34,14,35,0),
  (11067,41,9.65,9,0),
  (11068,28,45.6,8,0.15),
  (11068,43,46,36,0.15),
  (11068,77,13,28,0.15),
  (11069,39,18,20,0),
  (11070,1,18,40,0.15),
  (11070,2,19,20,0.15),
  (11070,16,17.45,30,0.15),
  (11070,31,12.5,20,0),
  (11071,7,30,15,0.05),
  (11071,13,6,10,0.05),
  (11072,2,19,8,0),
  (11072,41,9.65,40,0),
  (11072,50,16.25,22,0),
  (11072,64,33.25,130,0),
  (11073,11,21,10,0),
  (11073,24,4.5,20,0),
  (11074,16,17.45,14,0.05),
  (11075,2,19,10,0.15),
  (11075,46,12,30,0.15),
  (11075,76,18,2,0.15),
  (11076,6,25,20,0.25),
  (11076,14,23.25,20,0.25),
  (11076,19,9.2,10,0.25),
  (11077,2,19,24,0.2),
  (11077,3,10,4,0),
  (11077,4,22,1,0),
  (11077,6,25,1,0.02),
  (11077,7,30,1,0.05),
  (11077,8,40,2,0.1),
  (11077,10,31,1,0),
  (11077,12,38,2,0.05),
  (11077,13,6,4,0),
  (11077,14,23.25,1,0.03),
  (11077,16,17.45,2,0.03),
  (11077,20,81,1,0.04),
  (11077,23,9,2,0),
  (11077,32,32,1,0),
  (11077,39,18,2,0.05),
  (11077,41,9.65,3,0),
  (11077,46,12,3,0.02),
  (11077,52,7,2,0),
  (11077,55,24,2,0),
  (11077,60,34,2,0.06),
  (11077,64,33.25,2,0.03),
  (11077,66,17,1,0),
  (11077,73,15,2,0.01),
  (11077,75,7.75,4,0),
  (11077,77,13,2,0);

COMMIT;