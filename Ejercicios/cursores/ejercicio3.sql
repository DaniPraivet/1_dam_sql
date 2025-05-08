USE jardineria;

/*
Haz un procedimiento que detecte los clientes que no han hecho pedidos en el
último año. Muestra un listado de los clientes con su nombre y teléfono.
*/
DROP PROCEDURE IF EXISTS clientes_sin_pedidos_ultimo_anio;

DELIMITER //

CREATE PROCEDURE clientes_sin_pedidos_ultimo_anio()
    BEGIN
        DECLARE v_fin BOOLEAN DEFAULT FALSE;
        DECLARE v_codigo_cliente INT;
        DECLARE v_nombre_cliente VARCHAR(50);
        DECLARE v_telefono VARCHAR(15);
        DECLARE v_fecha_ultimo_pedido DATE;

        DECLARE c_clientes CURSOR FOR 
            SELECT codigo_cliente, nombre_cliente, telefono FROM cliente;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;

        OPEN c_clientes;

        bucle: LOOP
            FETCH c_clientes INTO v_codigo_cliente, v_nombre_cliente, v_telefono;
            IF v_fin THEN 
                LEAVE bucle;
            END IF;

            SELECT MAX(fecha_pedido) INTO v_fecha_ultimo_pedido 
            FROM pedido 
            WHERE codigo_cliente = v_codigo_cliente;

            IF v_fecha_ultimo_pedido IS NULL OR v_fecha_ultimo_pedido < (CURRENT_DATE - INTERVAL 1 YEAR) THEN
                SELECT v_nombre_cliente AS nombre, v_telefono AS telefono; 
            END IF;
        END LOOP;

        CLOSE c_clientes;
    END;
    //

    CALL clientes_sin_pedidos_ultimo_anio();