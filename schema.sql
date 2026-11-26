/*Rebuilds the schema; this deletes existing table data.*/
/*So if any constraints unique add they can always updated.*/
/*(No role column yet in Checkpoint 1) */
DROP TABLE IF EXISTS order_items; 
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

/*Create Table users first and user_id as the primary key*/
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	created_at TIMESTAMPTZ DEFAULT NOW()
);

/*Create Table categories for kind of products users will buy*/
CREATE TABLE categories (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(100) UNIQUE NOT NULL,
	created_at TIMESTAMPTZ DEFAULT NOW()
);

/*Create Table products base on categories that shows products name, price and stock.*/
CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
	category_id INTEGER NOT NULL,
	product_name VARCHAR(150) NOT NULL,
	description TEXT,
	price DECIMAL(10,2) NOT NULL,
	stock_quantity INTEGER NOT NULL,
	created_at TIMESTAMPTZ DEFAULT NOW(),
	
	/*Constraint for foreign key relationship between categories and products*/
	CONSTRAINT fk_products_category
		FOREIGN KEY (category_id)
		REFERENCES categories(category_id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*Create Table orders for storing order information*/
CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	order_date TIMESTAMPTZ DEFAULT NOW(),
	total_amount DECIMAL(10,2) NOT NULL,
	
	/*Constraint for foreign key relationship between users and orders*/
	CONSTRAINT fk_orders_user
		FOREIGN KEY (user_id)
		REFERENCES users(user_id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
	
);
/*Create Table order_items for storing items in each order*/
CREATE TABLE order_items (
	order_item_id SERIAL PRIMARY KEY,
	order_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL CHECK (quantity > 0),
	unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),

/*Constraint for foreign key relationship between orders and order_items, and products and order_items*/
	CONSTRAINT fk_order_items_order
		FOREIGN KEY (order_id)
		REFERENCES orders(order_id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,

/*Constraint for foreign key relationship between products and order_items*/
	CONSTRAINT fk_order_items_product
		FOREIGN KEY (product_id)
		REFERENCES products(product_id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);
