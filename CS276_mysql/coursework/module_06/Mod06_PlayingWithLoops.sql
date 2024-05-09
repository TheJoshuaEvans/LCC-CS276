USE AP;

DROP FUNCTION IF EXISTS loopTest;

DELIMITER //
CREATE FUNCTION loopTest (value INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE count INT;
    SET count = 0;
    label: WHILE count < value DO
        SET count = count + 1;
        IF count > 10 THEN
            LEAVE label;
        END IF;
    END WHILE label;
    RETURN count;
END;
DELIMITER ;

SELECT loopTest(20);
