/*
This file contains SQL queries to retrieve data from the RevoShop database.
The queries are designed to demonstrate various SQL operations,
including filtering, sorting, and joining tables.*/

-- 1. Top 3 expensive products in Electronics category
-- Combines WHERE + ORDER BY +LIMIT.

SELECT
    p.product_id,
    p.product_name,
    p.price,
    p.stock_quantity
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics'
-- Filter products by category name: Electronics
ORDER BY p.price DESC
LIMIT 3;


-- 2. Find orders above $100
-- Combines WHERE +ORDER BY+LIMIT to find the top 5 orders with total_amount greater than $100.

SELECT * FROM orders
WHERE total_amount > 100
ORDER BY total_amount DESC
LIMIT 5;

-- 3. Search products ordered by name
-- Combines WHERE + ORDER BY + LIMIT to find the first 10 products in category_id 2, ordered by product_name.

SELECT * FROM products
WHERE category_id = 2
ORDER BY product_name ASC
LIMIT 10;


-- 4. JOIN products + categories
-- Relation : products.category_id -> categories.category_id
-- Purpose: Display product names along with their category names.

SELECT
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
ORDER BY p.product_name;


-- 5. JOIN users + orders
-- Relation: orders.user_id -> users.user_id
-- Purpose: Display customers who have placed orders.

SELECT
    u.full_name,
    u.email,
    o.order_id,
    o.order_date,
    o.total_amount
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
ORDER BY o.total_amount DESC;


-- 6. JOIN orders + order_items + products
-- Relation: order_items.order_id -> orders.order_id
--           order_items.product_id -> products.product_id
-- Purpose: Display details of products purchased in each order.

SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;


-- 7. JOIN ALL TABLES (users, orders, order_items, products, categories)
-- Relation: users -> orders -> order_items -> products -> categories
-- Purpose: Display complete transaction details.

SELECT
    u.full_name,
    u.email,
    o.order_id,
    c.category_name,
    p.product_name,
    p.price,
    oi.quantity,
    oi.unit_price,
    o.total_amount
FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY o.order_id;


-- 8.JOIN ALL TABLES & WHERE + ORDER BY + LIMIT
-- Relation: users -> orders -> order_items -> products -> categories
-- Purpose: Display the top 5 most expensive products purchased by customers.

SELECT
    u.full_name,
    p.product_name,
    c.category_name,
    p.price,
    oi.quantity,
    o.total_amount
FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN categories c
    ON p.category_id = c.category_id
WHERE p.price > 100
ORDER BY p.price DESC
LIMIT 5;


-- 9. Aggregate - Total sales amount per customer
-- GROUP BY example.

SELECT
    u.full_name,
    SUM(o.total_amount) AS total_spending
FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.full_name
ORDER BY total_spending DESC;


-- 10. LEFT JOIN + COALESCE + GROUP BY
-- Purpose: Display all users and their total spending.
-- LEFT JOIN: Show all users, including users with no orders.
-- COALESCE: Replace NULL with 0 for users who have never placed an order.

SELECT
    u.user_id,
    u.full_name,
    u.email,
    COALESCE(SUM(o.total_amount), 0) AS total_spending
FROM users u
LEFT JOIN orders o
    ON u.user_id = o.user_id
GROUP BY
    u.user_id,
    u.full_name,
    u.email
ORDER BY total_spending DESC;


-- 11. SUBQUERY - Calculates the average price of products
-- Purpose: Display products whose price is above the average price of all products.
-- The Subquery: SELECT AVG(price) FROM products calculates the average price first.
-- The Main query: Dsplays products with prices higher than the calculated average.
-- First, run the SELECT AVG(price) FROM products query to get the average price, example: 50.00
-- Then use 50.00 in the main query. by inputing it in the WHERE clause, like this: WHERE p.price > 50.00

SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products p
WHERE p.price > 
(
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;

-- 12. SUBQUERY + JOIN
-- Purpose: Display customers whose order amount is higher than the average order amount.
-- First, run the SELECT AVG(total_amount) FROM orders query to get the average order amount, example: 100.00
-- Then use 100.00 in the main query. by inputing it in the WHERE clause, like this: WHERE o.total_amount > 100.00

SELECT
    u.full_name,
    o.order_id,
    o.total_amount
FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id
WHERE o.total_amount >
(
    SELECT AVG(total_amount)
    FROM orders
)
ORDER BY o.total_amount DESC;


-- 13. SUBQUERY - Most expensive product
-- Purpose: Display the most expensive product.
-- First, run the SELECT MAX(price) FROM products query to get the maximum price, example: 200.00
-- Then use 200.00 in the main query. by inputing it in the WHERE clause, like this: WHERE p.price = 200.00


SELECT
    p.product_name,
    p.price
FROM products p
WHERE p.price =
(
    SELECT MAX(price)
    FROM products
);


-- 14. SUBQUERY + AGGREGATE
-- Purpose: Display the customer(s) with the highest total spending.

SELECT
    u.full_name,
    SUM(o.total_amount) AS total_spending
FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id
GROUP BY
    u.user_id,
    u.full_name
HAVING SUM(o.total_amount) =
(
    SELECT MAX(customer_total)
    FROM
    (
        SELECT
            SUM(o2.total_amount) AS customer_total
        FROM orders o2
        GROUP BY o2.user_id
    ) totals
);


-- 15. Recent orders sorted by order_date (WHERE + ORDER BY + LIMIT)
-- Purpose: Display the 3 most recent orders placed from November 2026 onward.

SELECT
    o.order_id,
    u.full_name,
    o.order_date,
    o.total_amount
FROM orders o
INNER JOIN users u
    ON o.user_id = u.user_id
WHERE o.order_date >= '2026-11-01 00:00:00+07'
ORDER BY o.order_date DESC
LIMIT 3;