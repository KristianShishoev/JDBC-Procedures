DROP TABLE IF EXISTS product_tracker;

CREATE TABLE product_tracker (
	id INT PRIMARY KEY AUTO_INCREMENT,
	old_name VARCHAR(255),
    new_name VARCHAR(255),
    old_desc TEXT,
    new_desc TEXT,
    old_barcode VARCHAR(32),
    new_barcode VARCHAR(32),
    old_price FLOAT(2),
    new_price FLOAT(2)
);


DROP TRIGGER IF EXISTS before_product_update;

DELIMITER |
CREATE TRIGGER before_product_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	DECLARE new_name VARCHAR(255);
    DECLARE new_desc VARCHAR(255);
    DECLARE new_barcode VARCHAR(255);
    DECLARE new_price VARCHAR(255);
    
	IF OLD.product_name = NEW.product_name THEN
		SET new_name = NULL; 
    ELSE  
		SET new_name = NEW.product_name;
	END IF;
    
    IF OLD.product_desc = NEW.product_desc THEN
		SET new_desc = NULL; 
    ELSE  
		SET new_desc = NEW.product_desc;
	END IF;
    
    IF OLD.barcode = NEW.barcode THEN
		SET new_barcode = NULL; 
    ELSE  
		SET new_barcode = NEW.barcode;
	END IF;
    
    IF OLD.price = NEW.price THEN
		SET new_price = NULL; 
    ELSE  
		SET new_price = NEW.price;
	END IF;
    

	INSERT INTO product_tracker (old_name, new_name, old_desc, new_desc, old_barcode, new_barcode, old_price, new_price) VALUES
    (OLD.product_name, new_name, OLD.product_desc, new_desc, OLD.barcode, new_barcode, OLD.price, new_price);
END |
DELIMITER ; 

UPDATE products SET barcode = "435437457845", price = 47.50 WHERE id = 2; 



