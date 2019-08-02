-- Търсене на продукт по част от името
DROP PROCEDURE IF EXISTS by_name_part;

DELIMITER |
CREATE PROCEDURE by_name_part(IN name_part VARCHAR(32))
BEGIN
	DECLARE search_word VARCHAR(34);
	SET search_word = CONCAT('%', name_part, '%');
    
    SELECT * FROM furniture.products
    WHERE product_name LIKE search_word;
END |
DELIMITER ;

CALL by_name_part('Sofa');



-- ##################################################################################################



-- По зададен номер на фактура - продуктите, цените им и клиента, който ги е закупил
DROP PROCEDURE IF EXISTS by_delivery_note_num;

DELIMITER |
CREATE PROCEDURE by_delivery_note_num(IN note_num VARCHAR(64))
BEGIN
	SELECT p.product_name AS Product, p.price AS Price, c.company_name AS Buyer
	FROM products AS p JOIN customers AS c
	ON p.id IN (
		SELECT product_id
		FROM sales
		WHERE delivery_note_num = note_num AND customer_id = c.id
	);
END |
DELIMITER ;

CALL by_delivery_note_num('TR45343456235334352');



-- ##################################################################################################



-- По име на клиент - всички покупки от последния месец
DROP PROCEDURE IF EXISTS by_client;

DELIMITER |
CREATE PROCEDURE by_client(IN searched_company_name VARCHAR(64))
BEGIN
	DECLARE month_ago DATE;
    SET month_ago = DATE_SUB(NOW(), INTERVAL 1 MONTH);

	SELECT delivery_note_num AS Delivery_Note, purchase_date AS Date, total_price AS Price 
    FROM sales
	WHERE customer_id IN (
		SELECT id
		FROM customers
		WHERE company_name = searched_company_name
	) AND purchase_date > month_ago;
END |
DELIMITER ;

CALL by_Client('RDT');



-- ##################################################################################################



-- За всички продукти - по колко бройки са продавани през последния месец
DROP PROCEDURE IF EXISTS product_sales_count;

DELIMITER |
CREATE PROCEDURE product_sales_count()
BEGIN
	DECLARE month_ago DATE;
    SET month_ago = DATE_SUB(NOW(), INTERVAL 1 MONTH);
    
	SELECT products.product_name AS Product, SUM(quantity) AS Total
	FROM products LEFT JOIN sales
	ON products.id = sales.product_id
	WHERE purchase_date > month_ago
	GROUP BY Product;
END |
DELIMITER ;

CALL product_sales_count();



-- ##################################################################################################



-- Insert products with stored procedures using transactions
DROP PROCEDURE IF EXISTS insert_product;

DELIMITER |
CREATE PROCEDURE insert_product(IN product_name VARCHAR(255), IN product_desc TEXT, IN weight FLOAT(2), barcode VARCHAR(32), IN price FLOAT(2))
BEGIN
	DECLARE inserted_rows INT;

	START TRANSACTION;
    
		INSERT INTO products (`product_name`, `product_desc`, `weight`, `barcode`, `price`)
		VALUES (product_name, product_desc, weight, barcode, price);
        
        SELECT ROW_COUNT() INTO inserted_rows;
        
        IF inserted_rows > 0 AND LENGTH(barcode) >= 10 THEN
			COMMIT;
		ELSE  
			ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Barcode must be atleast 10 characters';
		END IF;
	
END |
DELIMITER ;

CALL insert_product('Table 546', 'White', '42.50', '6266624', 49.99);





