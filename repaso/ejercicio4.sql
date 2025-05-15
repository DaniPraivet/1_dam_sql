-- Active: 1747297143236@@127.0.0.1@3306@jardineria
/*
Crea un procedimiento llamado descuento_por_rappel que reciba como argumento
el código_cliente y el código_pedido y que mediante el uso de cursores realice
un descuento en las líneas de detalle del pedido de la siguiente manera:
• unidades <= 5 → 0%
• 6 <= unidades <= 10 → 2%
• 11 <= unidades <= 25 → 4%
• unidades > 25 → 5%
*/

DROP PROCEDURE IF EXISTS descuento_por_rappel;

DELIMITER //

CREATE PROCEDURE IF NOT EXISTS descuento_por_rappel (
    p_codigo_cliente INT,
    p_codigo_pedido INT
)
MODIFIES SQL DATA
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_codigo_producto VARCHAR(15);
    DECLARE v_cantidad INT;
    DECLARE v_precio DECIMAL(15,2);
    DECLARE v_descuento DECIMAL(5,2);
    
    DECLARE cursor_detalle CURSOR FOR
        SELECT codigo_producto, cantidad, precio_unidad
        FROM detalle_pedido
        WHERE codigo_pedido = p_codigo_pedido;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor_detalle;
    bucle: LOOP
        FETCH cursor_detalle INTO v_codigo_producto, v_cantidad, v_precio;
        IF done THEN
            LEAVE bucle;
        END IF;

        IF v_cantidad <= 5 THEN
            SET v_descuento = 0;
        ELSEIF v_cantidad <= 10 THEN
            SET v_descuento = 0.02;
        ELSEIF v_cantidad <= 25 THEN
            SET v_descuento = 0.04;
        ELSE
            SET v_descuento = 0.05;
        END IF;

        UPDATE detalle_pedido
        SET precio_unidad = v_precio * (1 - v_descuento)
        WHERE codigo_pedido = p_codigo_pedido AND codigo_producto = v_codigo_producto;
    END LOOP;
    CLOSE cursor_detalle;
END;
//

DELIMITER ;

CALL descuento_por_rappel(30,10100);

SELECT * FROM detalle_pedido WHERE codigo_pedido=10100;