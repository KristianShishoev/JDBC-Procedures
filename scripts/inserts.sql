USE furniture;

INSERT INTO furniture.products (`product_name`, `product_desc`, `weight`, `barcode`, `price`) VALUES 
	('Chair', 'For office', 10.80, '385637453723', 122.80),
	('Table DA43', 'Wooden', 30.4, '34534234546', 366.00),
	('Desk Ergo', 'Lifting mechanism', 97.80, '546456434535', 172.33),
	('Sofa UU-34', 'Brown leather', 386.76, '4354326235', 892.99),
	('Sofa ERT-183', 'Basic', 268.00, '435437457812', 344.10),
	('Chair GDN-11', 'For garden', 7.80, '385637456623', 52.00),
	('Armchair UU-32', 'Brown leather', 47.86, '38563324564', 192.35),
	('Desk T-14', 'For kids', 77.90, '385633453452', 152.99);
                    
INSERT INTO furniture.customers (`company_name`, `address`, `bulstrad`, `reg_dds`, `mol`) VALUES
	('IKAR', 'River Str. 55', '43534GF34', 1, 'Grogor Rusev'),
    ('RDT', 'Mountain Str. 258', 'MHT34234', 0, 'Gabriela Todorova');
    
INSERT INTO furniture.sales (`purchase_date`, `quantity`, `delivery_note_num`, `total_price`, `product_id`, `customer_id`) VALUES
	(CURDATE(), 3, 'TR45343456235334352', 516.99, 3, 1),
    (CURDATE(), 1, 'TR45343455467472123', 122.80, 1, 1),
    (CURDATE(), 4, 'TR45345476457357347', 769.40, 7, 2),
    (CURDATE(), 5, 'TR45345685634743665', 1830, 2, 1),
    (CURDATE(), 2, 'TR45345476443563255', 536, 5, 2),
    (CURDATE(), 1, 'TR45979686123443323', 97.80, 3, 2),
    (CURDATE(), 1, 'TR45979686800033453', 892.99, 4, 2);