create database customer_products
use customer_products
CREATE TABLE Customers_products (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(50)
);
INSERT INTO Customers_products(CustomerID, Name, Email)
VALUES
  (1, 'john doe','johndoe@example.com'),
  (2, 'Jane Smith','janesmith@example.com'),
  (3, 'Robert Johnson','robertjohnson@example.com'),
  (4, 'Emily Brown','emilybrown@example.com'),
  (5, 'Michael Davis','michaeldavis@example.com'),
  (6, 'Sarah Wilson','sarahwilson@example.com'),
  (7, 'David Thompson','davidthompson@example.com'),
  (8, 'Jessica Lee','jessicalee@example.com'),
  (9, 'William Turner','williamturner@example.com'),
  (10, 'Olivia Martinez','oliviamartinez@example.com');

  select *from Customers_products

  CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT
);

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1);

  select *from Orders

  CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99);

  select*from Products



 -- Task 1
-- 1.
SELECT *FROM Customers_products;

-- 2.
SELECT
  Name,
  Email
FROM
  Customers_products
WHERE
  Name LIKE 'J%';

-- 3.
SELECT
  OrderID,
  ProductName,
  Quantity
FROM
  Orders;

-- 4.
SELECT
  SUM(Quantity) AS TotalQuantity
FROM
  Orders;

-- 5.
SELECT DISTINCT
  Name
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID;

-- 6.
SELECT *FROM Products 
WHERE Price > 10.00;

-- 7.
SELECT
  Name,
  o.OrderDate
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
WHERE
  o.OrderDate >= '2023-07-05';

-- 8.
SELECT
  AVG(Price) AS [Average(Price)]
FROM
  Products;

-- 9.
SELECT
  Name,
  SUM(o.Quantity) AS TotalQuantityOrdered
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
GROUP BY
  Name;

-- 10.
SELECT
  *FROM
  Products
WHERE
  ProductID NOT IN (
    SELECT DISTINCT
      ProductID
    FROM
      Orders
  );

-- Task 2
-- 1.
SELECT
  Name,
  SUM(o.Quantity) AS TotalQuantityOrdered
FROM
  Customers_products
  JOIN Orders o ON Customers_products.CustomerID = o.CustomerID
GROUP BY
  Name
ORDER BY
  TotalQuantityOrdered DESC
OFFSET
  0 ROWS
FETCH NEXT
  5 ROWS ONLY;

-- 2.
SELECT
  p.ProductName,
  AVG(p.Price) AS AveragePrice
FROM
  Products p
GROUP BY
  p.ProductName;

-- 3.
SELECT
 NAME
FROM
  Customers_products
  LEFT JOIN Orders o ON o.CustomerID = o.CustomerID
WHERE
  o.OrderID IS NULL;

-- 4.
SELECT
  o.OrderID,
  o.ProductName,
  o.Quantity
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
WHERE
  Name LIKE 'M%';

-- 5.
SELECT
  SUM(Quantity * Price) AS TotalRevenue
FROM
  Orders
  JOIN Products ON Orders.ProductName = Products.ProductName;

-- 6.
SELECT
Name,
  SUM(o.Quantity * p.Price) AS TotalRevenue
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
  JOIN Products p ON o.ProductName = p.ProductName
GROUP BY
 Name;

-- 7.
SELECT
 Name
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
GROUP BY
 Name
HAVING
  COUNT(DISTINCT o.ProductName) = (
    SELECT
      COUNT(DISTINCT ProductName)
    FROM
      Products
  );

-- 8.
SELECT
  Name,
  SUM(o.Quantity * p.Price) AS TotalRevenue
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
  JOIN Products p ON o.ProductName = p.ProductName
WHERE
  o.OrderDate >= DATEADD (day, -30, GETDATE ())
GROUP BY
 Name;

-- 9.
SELECT
 Name
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
GROUP BY
  Name
HAVING
  COUNT(DISTINCT ProductName) >= 2;

-- 10.
SELECT
  Name,
  AVG(o.Quantity * p.Price) AS AverageRevenuePerOrder
FROM
  Customers_products
  JOIN Orders o ON  o.CustomerID = o.CustomerID
  JOIN Products p ON o.ProductName = p.ProductName
GROUP BY
  Name;

-- Task 3
-- 1.
SELECT
  Name 
  FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
GROUP BY
  Name
HAVING
  COUNT(DISTINCT o.ProductName) = (
    SELECT
      COUNT(DISTINCT ProductName)
    FROM
      Products
  );

-- 2.
SELECT
  p.ProductName
FROM
  Products p
  JOIN Orders o ON p.ProductName = o.ProductName
GROUP BY
  p.ProductName
HAVING
  COUNT(DISTINCT o.CustomerID) = (
    SELECT
      COUNT(*)
    FROM
      Customers_products
  );

-- 3.
SELECT
  DATEPART (month, OrderDate) AS Month,
  SUM(Quantity * Price) AS TotalRevenue
FROM
  Orders
  JOIN Products ON Orders.ProductName = Products.ProductName
GROUP BY
  DATEPART (month, OrderDate);

-- 4.
SELECT
  p.ProductName
FROM
  Products p
  JOIN Orders o ON p.ProductName = o.ProductName
GROUP BY
  p.ProductName
HAVING
  COUNT(DISTINCT o.CustomerID) > (
    SELECT
      COUNT(*) * 0.5
    FROM
      Customers_products
  );

-- 5.
SELECT
  Name,
  SUM(o.Quantity * p.Price) AS TotalSpent
FROM
  Customers_products
  JOIN Orders o ON Customers_products.CustomerID = o.CustomerID
  JOIN Products p ON o.ProductName = p.ProductName
GROUP BY
  Name
ORDER BY
  TotalSpent DESC
OFFSET
  0 ROWS
FETCH NEXT
  5 ROWS ONLY;

-- 6.
SELECT
  Name,
  o.Quantity,
  SUM(o.Quantity) OVER (
    PARTITION BY
      Customers_products.CustomerID
    ORDER BY
      o.OrderDate
  ) AS RunningTotal
FROM
  Customers_products
  JOIN Orders o ON Customers_products.CustomerID = o.CustomerID;
-- 7.
SELECT
  Name,
  o.OrderID,
  o.ProductName,
  o.Quantity
FROM
  Customers_products
  JOIN Orders o ON o.CustomerID = o.CustomerID
WHERE
  o.OrderID IN (
    SELECT
      TOP 3 OrderID
    FROM
      Orders
    WHERE
      CustomerID =o.CustomerID
    ORDER BY
      OrderDate DESC
  );

-- 8.
SELECT
  Name,
  SUM(o.Quantity * p.Price) AS TotalRevenue
FROM
  Customers_products
  JOIN Orders o ON O.CustomerID = o.CustomerID
  JOIN Products p ON o.ProductName = p.ProductName
WHERE
  o.OrderDate >= DATEADD (day, -30, GETDATE ())
GROUP BY
  Name;

-- 9.
SELECT
  Name
FROM
  Customers_products
  JOIN Orders o ON O.CustomerID = o.CustomerID
GROUP BY
  Name
HAVING
  COUNT(DISTINCT ProductName) >= 2;

-- 10.
SELECT
Name,
  AVG(o.Quantity * p.Price) AS AverageRevenuePerOrder
FROM
  Customers_products
  JOIN Orders o ON O.CustomerID = o.CustomerID
  JOIN Products p ON o.ProductName = p.ProductName
GROUP BY
 Name;

-- 11.
SELECT
  Name
FROM
  Customers_products
  JOIN Orders o ON O.CustomerID = o.CustomerID
WHERE
  DATEPART (year, o.OrderDate) = 2023
GROUP BY
 Name
HAVING
  COUNT(DISTINCT DATEPART (month, o.OrderDate)) = 12;

-- 12.
SELECT
 Name
FROM
  Customers_products
  JOIN Orders o ON O.CustomerID = o.CustomerID
WHERE
  EXISTS (
    SELECT
      1
    FROM
      Orders o2
    WHERE
      o2.CustomerID = o2.CUSTOMERID
      AND o2.ProductName = o.ProductName
      AND DATEDIFF (month, o2.OrderDate, o.OrderDate) = 1
  );

-- 13.
SELECT
  p.ProductName
FROM
  Products p
  JOIN Orders o ON p.ProductName = o.ProductName
GROUP BY
  p.ProductName
HAVING
  COUNT(DISTINCT o.CustomerID) >= 2;

