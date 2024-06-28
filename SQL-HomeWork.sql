/*
1. Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

DROP FUNCTION IF EXISTS `proc_datetime`;
DELIMITER //
CREATE FUNCTION proc_datetime(num INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(50) DEFAULT "";
	DECLARE sec INT DEFAULT 0;
    DECLARE count INT DEFAULT 0;
    
    WHILE  count < 2 DO
		SET sec = num % 60;
        SET count = count + 1;
        
        IF count = 1 THEN
			SET result = concat(sec, " seconds", result);
        ELSE
			SET result = concat(sec, " minutes ", result);
		END IF;
        
        SET num = (num - sec) / 60;
    END WHILE;
    
    IF count = 2 AND num > 0 THEN 
		SET count = count + 1;
		SET sec = num % 24;
		SET result = concat(sec, " hours " , result);
        SET num = (num - sec) / 24;
    END IF;
    
	IF count = 3 AND num > 0 THEN 
		SET result = concat(num, " days " , result);
    END IF;
    
    RETURN result;

END //
DELIMITER ;

SELECT proc_datetime(123456);



/*
2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

DROP PROCEDURE IF EXISTS `proc_even_num`;
DELIMITER //
CREATE PROCEDURE proc_even_num()
BEGIN
	DECLARE result VARCHAR(50) DEFAULT "";
	DECLARE count INT DEFAULT 0;
    
    WHILE  count < 10 DO
        SET count = count + 2;
        
        IF count < 10 THEN
			SET result = concat(result, count, ", ");
		ELSE
			SET result = concat(result, count);
		END IF;            
	END WHILE;
	
    SELECT result as `Even numbers`;
END //
DELIMITER ;

call proc_even_num();