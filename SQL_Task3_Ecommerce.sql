
-- CREATE TABLES
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- INSERT DATA
INSERT INTO Customers VALUES
(1, 'Alice', 'alice@example.com', 'USA'),
(2, 'Bob', 'bob@example.com', 'UK'),
(3, 'Charlie', 'charlie@example.com', 'India'),
(4, 'Diana', 'diana@example.com', 'USA');

INSERT INTO Products VALUES
(101, 'Laptop', 800.00),
(102, 'Smartphone', 500.00),
(103, 'Headphones', 100.00),
(104, 'Keyboard', 50.00);

INSERT INTO Orders VALUES
(1001, 1, 101, 1, '2024-12-01'),
(1002, 2, 103, 2, '2024-12-03'),
(1003, 3, 102, 1, '2024-12-05'),
(1004, 1, 104, 3, '2024-12-07'),
(1005, 4, 101, 1, '2024-12-10'),
(1006, 2, 102, 1, '2024-12-11');

-- SQL QUERIES

-- 1. Customers from USA
SELECT * FROM Customers
WHERE country = 'USA';

-- 2. Orders with customer and product details
SELECT o.order_id, c.customer_name, p.product_name, o.quantity, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
ORDER BY o.order_date;

-- 3. Total quantity per product
SELECT p.product_name, SUM(o.quantity) AS total_quantity
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.product_name;

-- 4. Customers who ordered more than 1 item
SELECT customer_id
FROM Orders
GROUP BY customer_id
HAVING SUM(quantity) > 1;

-- 5. Create view for order summary
CREATE VIEW OrderSummary AS
SELECT o.order_id, c.customer_name, p.product_name, o.quantity, p.price, 
       (o.quantity * p.price) AS total_price
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;

-- 6. View total price per order
SELECT * FROM OrderSummary;

-- 7. Average revenue per customer
SELECT c.customer_name, AVG(o.quantity * p.price) AS avg_revenue
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
GROUP BY c.customer_name;
