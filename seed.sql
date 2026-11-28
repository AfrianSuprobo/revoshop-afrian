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
(1, 'iPad Pro M6 1TB', 'Apple tablet', 899.99, 10),
(2, 'Stand Up Comedy Indonesia', 'Theoretical stand-up comedy book', 24.99, 100),
(2, 'Pecahkan Vol.1', 'Best practices comedy book', 39.99, 80),
(3, 'Nike Running Shoes', 'Comfortable running shoes', 120.00, 50),
(4, 'Air Fryer', 'Digital air fryer', 89.99, 25),
(5, 'Basketball', 'Official size basketball', 29.99, 40);



INSERT INTO orders
(user_id, order_date, status, total_amount)
VALUES
(1, '2026-11-01 09:15:00+07', 'delivered', 1524.98),
(2, '2026-11-03 14:30:00+07', 'delivered', 149.99),
(3, '2026-11-05 18:45:00+07', 'shipped', 1339.98),
(4, '2026-11-10 11:20:00+07', 'cancelled', 89.99),
(1, '2026-11-15 20:05:00+07', 'pending', 79.97);



INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 1499.99), -- iPhone 18 Pro Max Burgundy 2TB
(1, 4, 1, 24.99),   -- Stand Up Comedy Indonesia

(2, 6, 1, 120.00),  -- Nike Running Shoes
(2, 8, 1, 29.99),   -- Basketball

(3, 2, 1, 1299.99), -- Samsung Galaxy Z Fold8
(3, 5, 1, 39.99),   -- Pecahkan Vol.1

(4, 7, 1, 89.99),   -- Air Fryer

(5, 4, 2, 24.99),   -- Stand Up Comedy Indonesia (x2)
(5, 8, 1, 29.99);   -- Basketball
