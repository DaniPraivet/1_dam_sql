USE jardineria;

/*
Crea un procedimiento que recorra la tabla producto y aumente el en un 10% el
precio_venta de aquellos artículos cuya cantidad_en_stock sea menor que 5
unidades. Muestra el nombre, el precio antiguo y el nuevo de los productos
actualizados.
*/
DROP PROCEDURE IF EXISTS aumentar_precio_productos;

DELIMITER //

CREATE PROCEDURE aumentar_precio_productos()
BEGIN
    DECLARE v_fin BOOLEAN DEFAULT FALSE;
    DECLARE v_codigo_producto VARCHAR(15);
    DECLARE v_nombre VARCHAR(70);
    DECLARE v_precio_anterior DECIMAL(15,2);
    DECLARE v_nuevo_precio DECIMAL(15,2);
    DECLARE v_stock SMALLINT(6);

    DECLARE c_productos CURSOR FOR
        SELECT codigo_producto, nombre, precio_venta, cantidad_en_stock 
        FROM producto;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;

    OPEN c_productos;

    bucle: LOOP
        FETCH c_productos INTO v_codigo_producto, v_nombre, v_precio_anterior, v_stock;
        IF v_fin THEN 
            LEAVE bucle;
        END IF;

        IF v_stock < 5 THEN
            SET v_nuevo_precio = v_precio_anterior * 1.10;

            UPDATE producto 
            SET precio_venta = v_nuevo_precio 
            WHERE codigo_producto = v_codigo_producto;

            SELECT v_nombre AS nombre, 
                   v_precio_anterior AS precio_anterior, 
                   v_nuevo_precio AS precio_nuevo;
        END IF;
    END LOOP;

    CLOSE c_productos;
END //

DELIMITER ;