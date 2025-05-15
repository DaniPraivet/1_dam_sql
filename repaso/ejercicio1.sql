-- Active: 1747297143236@@127.0.0.1@3306@jardineria
/*
Crea una función que reciba como argumento la forma de pago (Paypal,
Transferencia, ...) y devuelva como resultado el pago de máximo valor hecho
con ese modo de pago.
*/

DROP FUNCTION IF EXISTS max_pago;

DELIMITER //

CREATE FUNCTION IF NOT EXISTS max_pago (p_forma_pago VARCHAR(40))
RETURNS VARCHAR(40) NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(15,2);
    SELECT MAX(total) INTO v_total 
    FROM pago WHERE forma_pago=p_forma_pago;
    RETURN v_total;
END;
//

DELIMITER //

SELECT max_pago('Transferencia');

SELECT total FROM pago WHERE forma_pago='Transferencia';
SELECT DISTINCT forma_pago FROM pago;