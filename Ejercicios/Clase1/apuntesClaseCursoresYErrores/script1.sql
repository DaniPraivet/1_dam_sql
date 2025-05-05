USE TIENDA;
DROP FUNCTION IF EXISTS cuenta_producto_fabricante;

DELIMITER //

CREATE FUNCTION cuenta_producto_fabricante (p_cod_fab INT UNSIGNED) 
RETURNS INT UNSIGNED NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_cuenta INT UNSIGNED DEFAULT 0;
    DECLARE v_hay_registros BOOLEAN DEFAULT TRUE;
    DECLARE v_cod_fab INT UNSIGNED;
    DECLARE c_productos CURSOR FOR
        SELECT id
        FROM producto;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_hay_registros = FALSE;
    

    -- Abrimos el CURSOR
    OPEN c_productos;

    -- Hacemos el bucle
    WHILE v_hay_registros DO
    -- Realizamos el fetch para recoger los datos de la Tabla
        FETCH c_productos INTO v_cod_fab;
        IF v_cod_fab = p_cod_fab THEN
        SET v_cod_fab = v_cod_fab+1;
        END IF;
    END WHILE;
    CLOSE c_productos;
    RETURN v_cuenta;
END;
//

DELIMITER ;
SELECT cuenta_producto_fabricante(1);