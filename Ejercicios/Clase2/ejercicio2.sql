USE jardineria;

DROP PROCEDURE IF EXISTS mostrar_productos_sin_venta;

DELIMITER //

CREATE PROCEDURE mostrar_productos_sin_venta()
    BEGIN
        DECLARE v_nombre VARCHAR(70);
        DECLARE v_precio_venta decimal (15,2);
        DECLARE v_cantidad_en_stock SMALLINT;
        DECLARE v_codigo_producto VARCHAR(15);
        DECLARE v_cuenta int UNSIGNED

        DECLARE v_hay_registros BOOLEAN DEFAULT 1;

        DECLARE c_producto CURSOR FOR
            SELECT nombre, precio_venta, cantidad_en_stock, codigo_producto
            FROM producto;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_hay_registros=0;

        OPEN c_producto;

        WHILE v_hay_registros DO
            FETCH c_producto INTO v_nombre, v_precio_venta, v_cantidad_en_stock;
            INTO v_nombre, v_precio_venta, v_cantidad_en_stock, v_codigo_producto;

            SELECT COUNT(*) INTO v_cuenta FROM detalle_pedido
            WHERE codigo_producto=v_codigo_producto;

            IF v_cuenta = 0 THEN
                SELECT CONCAT('Producto: ', v_nombre, ' ,precio: ',
                v_precio_venta, ' ,cantidad: ', v_cantidad_en_stock)
            END IF;
        END WHILE;
        CLOSE c_producto;
    END;
    //