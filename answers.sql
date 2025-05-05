-- Question 1  Achieving 1NF (First Normal Form)
-- Transform ProductDetail table so each row contains a single product per order
-- Using SQL Server's STRING_SPLIT to split comma-separated Products
SELECT
    OrderID,                          -- Order identifier
    CustomerName,                     -- Name of the customer
    LTRIM(RTRIM(value)) AS Product   -- Individual product name (trimmed)
FROM
    ProductDetail
CROSS APPLY
    STRING_SPLIT(Products, ',');      -- Splits 'Products' column into rows

-- Question 2  Achieving 2NF (Second Normal Form)
-- Remove partial dependency by splitting into Orders and OrderItems tables

-- 2A: Create and populate Orders table (OrderID and CustomerName)
CREATE TABLE Orders AS
SELECT DISTINCT
    OrderID,
    CustomerName
FROM
    OrderDetails;

-- 2B: Create and populate OrderItems table (OrderID, Product, Quantity)
CREATE TABLE OrderItems AS
SELECT
    OrderID,
    Product,
    Quantity
FROM
    OrderDetails;
