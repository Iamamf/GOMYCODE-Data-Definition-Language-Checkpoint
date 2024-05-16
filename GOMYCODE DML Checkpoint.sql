USE DDL 

--Write the appropriate SQL queries to insert all the provided records in their corresponding tables.
INSERT INTO Products (product_id, name, price) VALUES 
(1, 'cookies', 10),
(2, 'candy', 5.2);
GO

INSERT INTO Customers (customer_id, name, address) VALUES
(1, 'Ahmed', 'Tunisia'),
(2, 'Coulibaly', 'Senegal'),
(3, 'Hasan', 'Egypt');
GO

INSERT INTO Orders (customer_id, product_id, quantity, order_date) VALUES
(1,2,3,'2023-01-22'),
(2,1,10, '2023-04-14');
GO

--Update the quantity of the second order, the new value should be 6.
UPDATE Orders SET quantity = 6 WHERE customer_id = 2 AND product_id = 1;
GO

--Delete the third customer from the customers table.
DELETE FROM Customers WHERE customer_id = 3;
GO

--Delete the orders table content then drop the table.
DELETE FROM Orders;
DROP TABLE Orders;
GO

