-- Create DQL Checkpoint
CREATE DATABASE DQL Checkpoint;
GO

--Access the new DQL database;
USE DQL Checkpoint
GO

--Create Table for Customers
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50) NOT NULL,
  customer_tel VARCHAR(50) NOT NULL);
  GO

--Create Table for Products
CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50) NOT NULL,
  category VARCHAR(50) NOT NULL,
  price INT NOT NULL);
  GO

  --Create Table For Orders
 CREATE TABLE Orders (
  customer_id INT FOREIGN KEY (customer_id) REFERENCES Customers (customer_id) NOT NULL,
  product_id INT FOREIGN KEY (product_id) REFERENCES Products (product_id) NOT NULL,
  order_date DATE NOT NULL,
  quantity INT NOT NULL,
  total_amount INT NOT NULL);
  GO

--Inserting records in Customers tables.
INSERT INTO Customers (customer_id, customer_name, customer_tel) VALUES
(1, 'Leye', '9028303930'),
(2, 'Emeka', '8126389048'),
(3, 'Dami', '9123874909'),
(4, 'Amerrah', '8123098475'),
(5, 'Sultan', '9123800909'),
(6, 'FG', '9129389849'),
(7, 'Mariam', '9125634909');
GO

--Inserting records in Products tables.
INSERT INTO Products (product_id, product_name, category, price) VALUES
(1, 'Widget', 'Tools', 10),
(2, 'Gadget', 'Electronics', 15),
(3, 'doohickey', 'Misc', 20),
(4, 'Fan', 'Electronics', 25),
(5, 'TV', 'Electronics', 10);
GO

--Inserting records in Orders tables.
INSERT INTO Orders (customer_id, product_id, order_date, quantity, total_amount) VALUES
(1, 1, '2024-05-01', 5, 50),  -- Leye ordered 5 Widgets
(1, 2, '2024-05-02', 3, 45),  -- Leye ordered 3 Gadgets
(1, 1, '2024-05-03', 2, 20),  -- Leye ordered 2 Widgets
(2, 2, '2024-05-04', 4, 60),  -- Emeka ordered 4 Gadgets
(2, 3, '2024-05-05', 1, 20),  -- Emeka ordered 1 Doohickey
(3, 1, '2024-05-06', 1, 10),  -- Dami ordered 1 Widget
(3, 3, '2024-05-07', 2, 40),  -- Dami ordered 2 Doohickey
(4, 3, '2024-05-10', 5, 100), -- Amerrah ordered 5 Doohickey
(5, 1, '2024-05-10', 5, 50), -- Sultan ordered 5 Widget
(6, 3, '2024-05-10', 5, 100), -- FG ordered 5 Doohickey
(7, 5, '2024-05-10', 2, 20); -- Mariam ordered 2 TV
GO

--Retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, along with the total cost of the widgets and gadgets ordered by each customer. The cost of each item should be calculated by multiplying the quantity by the price of the product.
SELECT Customers.customer_id, Customers.customer_name, 
    SUM(CASE WHEN Products.category = 'Tools' THEN Orders.total_amount ELSE 0 END) AS Total_Widget_Cost, 
    SUM(CASE WHEN Products.category = 'Electronics' AND Products.product_name = 'Gadget' THEN Orders.total_amount ELSE 0 END) AS Total_Gadget_Cost
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
INNER JOIN Products ON Orders.product_id = Products.product_id
WHERE Products.category IN ('Tools', 'Electronics') AND Products.product_name IN ('Widget', 'Gadget')
GROUP BY Customers.customer_id, Customers.customer_name
HAVING 
    SUM(CASE WHEN Products.category = 'Tools' THEN 1 ELSE 0 END) > 0 
    AND SUM(CASE WHEN Products.category = 'Electronics' AND Products.product_name = 'Gadget' THEN 1 ELSE 0 END) > 0;

--Write a query to retrieve the names of the customers who have placed an order for at least one widget, along with the total cost of the widgets ordered by each customer.
SELECT 
    Customers.customer_name, 
    SUM(Orders.quantity * Products.price) AS Total_Widget_Cost
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
INNER JOIN Products ON Orders.product_id = Products.product_id
WHERE Products.product_name = 'Widget'
GROUP BY Customers.customer_name;

--Write a query to retrieve the names of the customers who have placed an order for at least one gadget, along with the total cost of the gadgets ordered by each customer.
SELECT 
    Customers.customer_name, 
    SUM(Orders.quantity * Products.price) AS Total_Gadget_Cost
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
INNER JOIN Products ON Orders.product_id = Products.product_id
WHERE Products.product_name = 'Gadget'
GROUP BY Customers.customer_name;

-- Write a query to retrieve the names of the customers who have placed an order for at least one doohickey, along with the total cost of the doohickeys ordered by each customer.
SELECT 
    Customers.customer_name, 
    SUM(Orders.quantity * Products.price) AS TotalDoohickeyCost
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
INNER JOIN Products ON Orders.product_id = Products.product_id
WHERE Products.product_name = 'Doohickey'
GROUP BY Customers.customer_name;

--Write a query to retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.
SELECT 
    Customers.customer_name, 
    SUM(CASE WHEN Products.product_name = 'Widget' THEN Orders.quantity ELSE 0 END) AS Total_Widgets,
    SUM(CASE WHEN Products.product_name = 'Gadget' THEN Orders.quantity ELSE 0 END) AS Total_Gadgets,
    SUM(Orders.quantity * Products.price) AS Total_Cost
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
INNER JOIN Products ON Orders.product_id = Products.product_id
WHERE Products.product_name IN ('Widget', 'Gadget')
GROUP BY Customers.customer_name;

--Write a query to retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered.
SELECT Products.product_name, 
    SUM(Orders.quantity) AS Total_Quantity
FROM 
    Products
INNER JOIN Orders ON Products.product_id = Orders.product_id
GROUP BY Products.product_name
HAVING 
    SUM(Orders.quantity) > 0;

--Write a query to retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.
SELECT Customers.customer_name,
    COUNT(*) AS TotalOrders
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
GROUP BY Customers.customer_name
ORDER BY TotalOrders DESC;

--Write a query to retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.
SELECT 
    Products.product_name,
    SUM(Orders.quantity) AS Total_Quantity
FROM Products
INNER JOIN Orders ON Products.product_id = Orders.product_id
GROUP BY Products.product_name
ORDER BY Total_Quantity DESC;

--Write a query to retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer.
SELECT Customers.customer_name,
    COUNT(*) AS Total_Orders
FROM Customers
INNER JOIN Orders ON Customers.customer_id = Orders.customer_id
WHERE Customers.customer_id IN 
		(SELECT customer_id
        FROM Orders
        GROUP BY customer_id
        HAVING COUNT(DISTINCT DATEPART(weekday, order_date)) = 7)
GROUP BY Customers.customer_name
ORDER BY Total_Orders DESC;

