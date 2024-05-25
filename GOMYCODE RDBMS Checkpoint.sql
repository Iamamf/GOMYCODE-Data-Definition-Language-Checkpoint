--Create RDBMS Database 
CREATE DATABASE RDBMS
GO

--Access The New RDBMS Database
USE RDBMS
GO

--After successfully converting given entity-relationship diagram into a relational model.
--Producer (NumP, FirstName, LastName, Region)
--Wine (NumW, Category, Year, Degree)
-- Harvest (NumP, NumW, Quantity)

--Implement the relational model using SQL.

-- Create the Wine table
CREATE TABLE Wine (
    NumW INT PRIMARY KEY,
    Category VARCHAR(50),
    Year INT,
    Degree DECIMAL(4, 2)
);

-- Create the Producer table
CREATE TABLE Producer (
    NumP INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Region VARCHAR(50)
);

-- Create the Harvest table
CREATE TABLE Harvest (
    NumP INT,
    NumW INT,
    Quantity INT,
    PRIMARY KEY (NumP, NumW),
    FOREIGN KEY (NumP) REFERENCES Producer(NumP),
    FOREIGN KEY (NumW) REFERENCES Wine(NumW)
);

--Insert data into the database tables.

-- Insert data into the Wine table
INSERT INTO Wine (NumW, Category, Year, Degree)
VALUES
(10, 'Red', 2020, 12.5),
(11, 'White', 2021, 11.0),
(12, 'Rose', 2022, 13.0),
(13, 'Sparkling', 2019, 11.5),
(14, 'Dessert', 2018, 14.0),
(15, 'Red', 2020, 13.5),
(16, 'White', 2021, 12.0),
(17, 'Rose', 2022, 12.8);
GO

-- Insert data into the Producer table
INSERT INTO Producer (NumP, FirstName, LastName, Region)
VALUES
(1, 'John', 'Doe', 'Sousse'),
(2, 'Jane', 'Smith', 'Sousse'),
(3, 'Michael', 'Brown', 'Tunis'),
(4, 'Alice', 'Johnson', 'Sousse'),
(5, 'Bob', 'Williams', 'Monastir'),
(6, 'Charlie', 'Davis', 'Tunis'),
(7, 'Diana', 'Miller', 'Nabeul'),
(8, 'Eve', 'Wilson', 'Sfax');
GO


-- Insert data into the Harvest table
INSERT INTO Harvest (NumP, NumW, Quantity)
VALUES
(1, 10, 500),
(2, 11, 600),
(3, 12, 700),
(1, 13, 450),
(2, 14, 300),
(3, 15, 750),
(4, 16, 200),
(5, 17, 350),
(6, 10, 500),
(7, 11, 400),
(8, 12, 600),
(1, 15, 500),
(2, 16, 550),
(3, 17, 450),
(4, 10, 300),
(5, 11, 250),
(6, 12, 700),
(7, 13, 350),
(8, 14, 400);
GO

--Give the list the producers.
SELECT * FROM Producer;

--Give the list of producers sorted by name.
SELECT * FROM Producer ORDER BY LastName, FirstName;

--Give the list the producers of Sousse.
SELECT * FROM Producer WHERE Region = 'Sousse';

--Calculate the total quantity of wine produced having the number 12.
SELECT SUM(Quantity) AS TotalQuantity
FROM Harvest
WHERE NumW = 12;

--Calculate the quantity of wine produced by category.
SELECT Wine.Category, SUM(Harvest.Quantity) AS Total_Quantity
FROM Wine
JOIN Harvest ON Wine.NumW = Harvest.NumW
GROUP BY Wine.Category;

--Which producers in the Sousse region have harvested at least one wine in quantities greater than 300 liters? We want the names and first names of the producers, sorted in alphabetical order.
SELECT DISTINCT Producer.FirstName, Producer.LastName
FROM Producer
JOIN Harvest ON Producer.NumP = Harvest.NumP
WHERE Producer.Region = 'Sousse' AND Harvest.Quantity > 300
ORDER BY Producer.LastName ASC, Producer.FirstName ASC;

--List the wine numbers that have a degree greater than 12 and that have been produced by producer number 24.
SELECT Wine.NumW
FROM Wine
JOIN Harvest ON Wine.NumW = Harvest.NumW
WHERE Wine.Degree > 12 AND Harvest.NumP = 24;
