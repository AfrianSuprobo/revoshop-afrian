/*This file contains SQL queries to retrieve data from the RevoShop database.*/
/* The queries are designed to demonstrate various SQL operations, */
/* including filtering, sorting, and joining tables.*/

-- 1. Top expensive products in Electronics category
-- Combines WHERE, ORDER BY, and LIMIT
SELECT
    product_id,
    product_name,
    price,
    stock_quantity
FROM products
WHERE category_id = 1
ORDER BY price DESC
LIMIT 3;


-- 2. Find orders above $100
SELECT *
FROM orders
WHERE total_amount > 100
ORDER BY total_amount DESC
LIMIT 5;


-- 3. Search books ordered by name
SELECT *
FROM products
WHERE category_id = 2
ORDER BY product_name ASC
LIMIT 10;


-- 4. View order details with user and product names (JOIN query)
SELECT 
    orders.order_id,
    users.full_name,
    products.product_name,
    order_items.quantity,
    order_items.unit_price
FROM orders
JOIN users ON orders.user_id = users.user_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id;
