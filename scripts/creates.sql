DROP DATABASE IF EXISTS furniture;
CREATE DATABASE furniture;
USE furniture;

CREATE TABLE products (
	id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) UNIQUE NOT NULL,
    product_desc TEXT,
    weight FLOAT(2),
    barcode VARCHAR(32) UNIQUE NOT NULL,
    price FLOAT(2) NOT NULL
);

CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(64) UNIQUE NOT NULL,
    address VARCHAR(255) UNIQUE NOT NULL,
    bulstrad VARCHAR(64) UNIQUE NOT NULL,
	reg_dds BIT NOT NULL DEFAULT 0,
    mol VARCHAR(64) NOT NULL
);

CREATE TABLE sales (
	id INT PRIMARY KEY AUTO_INCREMENT,
    purchase_date DATE NOT NULL,
    quantity INT NOT NULL,
    delivery_note_num VARCHAR(64) UNIQUE NOT NULL,
    total_price FLOAT(2) NOT NULL,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    CONSTRAINT FK_product FOREIGN KEY (product_id) REFERENCES products (id) 
		ON UPDATE CASCADE,
	CONSTRAINT FK_customer FOREIGN KEY (customer_id) REFERENCES customers (id) 
		ON UPDATE CASCADE
);
