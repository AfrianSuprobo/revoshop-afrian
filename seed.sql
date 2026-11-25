/*This file contains SQL statements to populate the RevoShop database with initial data.*/
/*The seed data includes users, categories, products, orders, and order items.*/
/* This data is used for testing and development purposes.*/

INSERT INTO users
(full_name, email, password_hash)
VALUES
('Abdur Arsyad', 'abdur_a@example.com', 'hashed_pw_001'),
('Bintang Emon', 'bintang_e@example.com', 'hashed_pw_002'),
('Cing Abdel', 'cing_a@example.com', 'hashed_pw_003'),
('Dodit Mulyanto', 'dodit_m@example.com', 'hashed_pw_004'),
('Ebel Cobra', 'ebel_c@example.com', 'hashed_pw_005');



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
(1, 'iPhone 18 Pro Max Burgundy 2TB', 'Apple smartphone', 1499.99, 20),
(1, 'Samsung Galaxy Z Fold8', 'Android smartphone', 1299.99, 15),
(2, 'Stand Up Comedy Indonesia', 'Theoretical stand-up comedy book', 24.99, 100),
(2, 'Pecahkan Vol.1', 'Best practices comedy book', 39.99, 80),
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
