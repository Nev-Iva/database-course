use electronics;


-- Триггеры, предотвращающие внесение NULL значений.
DELIMITER //
DROP TRIGGER IF EXISTS check_users_value_insert//
CREATE TRIGGER check_users_value_insert before INSERT ON users
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.firstname is NULL) or (new.lastname is NULL) or (new.email is NULL) or (new.phone is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

INSERT INTO users (id, firstname, lastname, email, phone) VALUES ('151', 'Ivan', 'Ivanov', 'ivan@example.net', '8761436989');
INSERT INTO users (id, firstname, lastname, email, phone) VALUES ('152', NULL, 'Ivanov', 'ivan22@example.net', '8761436089');
INSERT INTO users (id, firstname, lastname, email, phone) VALUES ('152', 'IVAN', NULL, 'ivan22@example.net', '8761436089');


DELIMITER //
DROP TRIGGER IF EXISTS check_accounts_value_insert//
CREATE TRIGGER check_accounts_value_insert before INSERT ON accounts
FOR EACH ROW
BEGIN
	IF (new.user_id is NULL) or (new.gender is NULL) or (new.hometown is NULL) or (new.birthday is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

INSERT INTO accounts (user_id, gender, birthday, hometown) VALUES (151, 'M', '1998-08-06', 'Moscow');
INSERT INTO accounts (user_id, gender, birthday, hometown) VALUES (49, NULL, '1998-08-06', 'Moscow');
INSERT INTO accounts (user_id, gender, birthday, hometown) VALUES (49, 'M', NULL, 'Moscow');

DELIMITER //
DROP TRIGGER IF EXISTS check_cardholders_value_insert//
CREATE TRIGGER check_cardholders_value_insert before INSERT ON cardholders
FOR EACH ROW
BEGIN
	IF (new.card_id is NULL) or (new.acc_id is NULL) or (new.card_number is NULL) or (new.purchase_amount is NULL) or (new.accumulation_amount is NULL) or (new.last_purchase is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_catalogs_value_insert//
CREATE TRIGGER check_catalogs_value_insert before INSERT ON catalogs
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.name is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_delivery_value_insert//
CREATE TRIGGER check_delivery_value_insert before INSERT ON delivery
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.order_id is NULL) or (new.address is NULL) or (new.price_fror_delivery is NULL) or (new.delivered_at is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_discounts_value_insert//
CREATE TRIGGER check_discounts_value_insert before INSERT ON discounts
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.goods_id is NULL) or (new.discount is NULL) or (new.started_at is NULL) or (new.finished_at is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_goods_value_insert//
CREATE TRIGGER check_goods_value_insert before INSERT ON goods
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.name is NULL) or (new.datasheet is NULL) or (new.description_prod is NULL) or (new.price is NULL) or (new.catalog_id is NULL) or (new.manufacturer_id is NULL) or (new.type_goods_id is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_manufacturer_value_insert//
CREATE TRIGGER check_manufacturer_value_insert before INSERT ON manufacturer
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.name is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_orders_value_insert//
CREATE TRIGGER check_orders_value_insert before INSERT ON orders
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.user_id is NULL) or (new.price is NULL) or (new.created_at is NULL) or (new.received_at is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_projects_value_insert//
CREATE TRIGGER check_projects_value_insert before INSERT ON projects
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.name is NULL) or (new.goods_id is NULL) or (new.goods_list is NULL) or (new.description_proj is NULL) or (new.complexity is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_radio_analog_value_insert//
CREATE TRIGGER check_radio_analog_value_insert before INSERT ON radio_analog
FOR EACH ROW
BEGIN
	IF (new.original_id is NULL) or (new.original_name is NULL) or (new.analog_id is NULL) or (new.analog_name is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_reviews_value_insert//
CREATE TRIGGER check_reviews_value_insert before INSERT ON reviews
FOR EACH ROW
BEGIN
	IF (new.user_id is NULL) or (new.goods_id is NULL) or (new.like_dislike is NULL) or (new.review_text is NULL) or (new.created_at is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//

DELIMITER //
DROP TRIGGER IF EXISTS check_type_goods_value_insert//
CREATE TRIGGER check_type_goods_value_insert before INSERT ON type_goods
FOR EACH ROW
BEGIN
	IF (new.id is NULL) or (new.name is NULL) or (new.catalog_id is NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert canceled (null value)';
	END IF;
END//





-- Процедура вставки значения в каталог/тип/товар/скидку.
DELIMITER //
DROP PROCEDURE IF EXISTS insert_to_catalog//
CREATE PROCEDURE insert_to_catalog (IN id INT, IN name VARCHAR(255))
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
  INSERT INTO catalogs VALUES(id, name);
  IF @error IS NOT NULL THEN
    SELECT @error;
  END IF;
END//
DELIMITER ;

SELECT * FROM catalogs;

CALL insert_to_catalog(12, 'Корпуса');

DELIMITER //
DROP PROCEDURE IF EXISTS insert_to_type_goods//
CREATE PROCEDURE insert_to_type_goods (IN id INT, IN name VARCHAR(255), IN catalog_id INT)
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
  INSERT INTO type_goods VALUES(id, name, catalog_id);
  IF @error IS NOT NULL THEN
    SELECT @error;
  END IF;
END//
DELIMITER ;

SELECT * FROM type_goods;

CALL insert_to_type_goods(25, 'Алюминиевые корпуса', 12);
CALL insert_to_type_goods(26, 'Пластиковые корпуса', 12);


DELIMITER //
DROP PROCEDURE IF EXISTS insert_to_goods//
CREATE PROCEDURE insert_to_goods (IN id INT, IN name VARCHAR(255), IN datasheet TEXT, IN description_prod TEXT, IN price INT, IN catalog_id INT, IN manufacturer_id int, IN type_goods_id INT)
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
  INSERT INTO goods VALUES(id, name, datasheet, description_prod, price, catalog_id, manufacturer_id, type_goods_id);
  IF @error IS NOT NULL THEN
    SELECT @error;
  END IF;
END//
DELIMITER ;

SELECT * FROM goods;

call insert_to_goods(100, 'B011', '222x146x55мм', 'Корпус для РЭА, металл', 1470, 12, 1, 25);
call insert_to_goods(101, 'DABP081206G', '80х120х56мм', 'Корпус для РЭА, пластик ABS, серый', 430, 12, 1, 26);
call insert_to_goods(102, 'DABP162412G', '160х240х121мм', 'Корпус для РЭА, пластик ABS, серый', 1400, 12, 1, 26);

DELIMITER //
DROP PROCEDURE IF EXISTS insert_to_discounts//
CREATE PROCEDURE insert_to_discounts (IN id INT, IN goods_id INT, IN discount FLOAT, IN started_at datetime, IN finished_at datetime)
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @error = 'Ошибка вставки значения';
  INSERT INTO discounts VALUES(id, goods_id, discount, started_at, finished_at);
  IF @error IS NOT NULL THEN
    SELECT @error;
  END IF;
END//
DELIMITER ;

call insert_to_discounts(6, 33, 0.5, NOW(), '2021-02-26 08:45:43');



-- Процедура расчета скидки на товар и внесение изменений на цену в таблицу goods.
DELIMITER //
DROP PROCEDURE IF EXISTS discount_goods//
CREATE PROCEDURE discount_goods (IN discount_id INT)
BEGIN
	declare disco FLOAT;    
    declare old_price INT;
    declare new_price INT;    
	SET disco := 1 - (select discount from discounts where id = discount_id);
    set old_price := (select price from goods where id = (select goods_id from discounts where id = discount_id));
    set new_price := old_price * disco;
    UPDATE goods SET price=new_price WHERE id = (select goods_id from discounts where id = discount_id);
END//

select price from goods where id = 33;
call discount_goods(6);



-- Процедура по расчету стоимости проекта.
DELIMITER //
DROP PROCEDURE IF EXISTS project_price//
CREATE PROCEDURE project_price (IN id_proj INT)
BEGIN
	declare count_el varchar(255);
    declare good_price int;
    declare good_count int;
    declare good_str VARCHAR(255);
    declare good_price_sum INT;
    declare i int;
    set good_str := (select goods_list from projects where id = id_proj);
    set good_count := (char_length(good_str) - char_length(REPLACE(good_str,',',''))) div char_length(',') + 1;
    set good_price_sum := 0;
    set i := 1;
    WHILE i != (good_count + 1) DO
		set count_el :=  SUBSTRING_INDEX((select goods_list from projects where id = id_proj), ',', i);
        SET count_el := CONCAT(SUBSTRING_INDEX(count_el, ', ', -1));
        -- select count_el;
        set good_price_sum = good_price_sum + (select price from goods where name = count_el);  
        
		SET i = i + 1;
    END WHILE;
    select good_price_sum;
END//
DELIMITER ;

call project_price(1);
call project_price(2);
call project_price(3);
call project_price(4);
call project_price(5);



-- Сравним аналог и оригинал. Что дешевле?
DELIMITER //
DROP PROCEDURE IF EXISTS cheap_analog//
CREATE PROCEDURE cheap_analog (IN or_name Varchar(255))
BEGIN
	declare an_id int;
    declare or_id int;
    declare or_price INT;
    declare an_price INT;
    set or_id = (select id from goods where id = (select original_id from radio_analog where original_name = or_name));
    set an_id = (select id from goods where id = (select analog_id from radio_analog where original_name = or_name));
    set or_price = (select price from goods where id = or_id);
	set an_price = (select price from goods where id = an_id);
    IF or_price > an_price THEN (Select name, price from goods where id = an_id); 
    ELSEIF or_price = an_price THEN (Select 'Цена на аналог и оригинал равна'); 
    ELSE (Select name, price from goods where id = or_id);
    END IF; 

END//

call cheap_analog('J113');


-- Чего больше поставили лайков или дислайков?
DELIMITER //
DROP PROCEDURE IF EXISTS reviews_count//
CREATE PROCEDURE reviews_count ()
BEGIN
	declare count_like int;
    declare count_dislike int;
    set count_like = (select count(id) from reviews where like_dislike = '+');
	set count_dislike = (select count(id) from reviews where like_dislike = '-');
    IF count_like > count_dislike THEN (Select 'Лайков больше'); 
    ELSEIF count_like = count_dislike THEN (Select 'Количество лайков и дислайков одинаково'); 
    ELSE (Select 'Дислайков больше');
    END IF; 
END//

call reviews_count();



