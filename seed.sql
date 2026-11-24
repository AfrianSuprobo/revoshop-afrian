INSERT INTO users
(full_name, email, password_hash)
VALUES
('John Doe', 'john@example.com', 'hashed_pw_001'),
('Sarah Johnson', 'sarah@example.com', 'hashed_pw_002'),
('Michael Smith', 'michael@example.com', 'hashed_pw_003'),
('Emma Brown', 'emma@example.com', 'hashed_pw_004'),
('David Wilson', 'david@example.com', 'hashed_pw_005');



INSERT INTO categories
(category_name)
VALUES
('Electronics'),
('Books'),
('Fashion'),
('Home Appliances'),
('Sports');



INSERT INTO products
(category_id, product_name, description, price, stock_quantity)
VALUES
(1, 'iPhone 15', 'Apple smartphone', 1499.99, 20),
(1, 'Samsung Galaxy S25', 'Android smartphone', 1299.99, 15),
(2, 'Atomic Habits', 'Self improvement book', 24.99, 100),
(2, 'Clean Code', 'Programming best practices', 39.99, 80),
(3, 'Nike Running Shoes', 'Comfortable running shoes', 120.00, 50),
(4, 'Air Fryer', 'Digital air fryer', 89.99, 25),
(5, 'Basketball', 'Official size basketball', 29.99, 40);



INSERT INTO orders
(user_id, total_amount)
VALUES
(1, 1524.98),
(2, 149.99),
(3, 1339.98),
(4, 89.99),
(1, 79.97);



INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 1499.99),
(1, 3, 1, 24.99),

(2, 5, 1, 120.00),
(2, 7, 1, 29.99),

(3, 2, 1, 1299.99),
(3, 4, 1, 39.99),

(4, 6, 1, 89.99),

(5, 3, 2, 24.99),
(5, 7, 1, 29.99);
