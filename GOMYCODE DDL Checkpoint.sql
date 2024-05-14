-- Create DDL Checkpoint
CREATE DATABASE DDL Checkpoint;
GO

--Access the new DDL database;
USE DDL Checkpoint
GO

--Create Table for Customers
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  address VARCHAR(50) NOT NULL);

--Create Table for Products
CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price DECIMAL (10,2) CHECK (Price > 0) NOT NULL);

  --Create Table For Orders
 CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT FOREIGN KEY (customer_id) REFERENCES Customers (customer_id) NOT NULL,
  product_id INT FOREIGN KEY (product_id) REFERENCES Products (product_id) NOT NULL,
  quantity INT NOT NULL,
  order_date DATE NOT NULL);
