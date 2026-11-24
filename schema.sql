DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(100) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
	category_id INTEGER NOT NULL,
	product_name VARCHAR(150) NOT NULL,
	description TEXT,
	price DECIMAL(10,2) NOT NULL,
	stock_quantity INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_products_category
		FOREIGN KEY (category_id)
		REFERENCES categories(category_id)
);

CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	total_amount DECIMAL(10,2) NOT NULL,

	CONSTRAINT fk_orders_user
		FOREIGN KEY (user_id)
		REFERENCES users(user_id)
);

CREATE TABLE order_items (
	order_item_id SERIAL PRIMARY KEY,
	order_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	unit_price DECIMAL(10,2) NOT NULL,

	CONSTRAINT fk_order_items_order
		FOREIGN KEY (order_id)
		REFERENCES orders(order_id),

	CONSTRAINT fk_order_items_product
		FOREIGN KEY (product_id)
		REFERENCES products(product_id)
);
