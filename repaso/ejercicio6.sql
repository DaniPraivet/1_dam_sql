-- Active: 1747297143236@@127.0.0.1@3306@jardineria
/*
Modifica el trigger anterior para que cada cliente que tenga asignado el
vendedor se asigne a diferentes vendedores, eligiendo siempre el que menos
clientes tiene en ese momento.
*/

DROP TRIGGER IF EXISTS before_empleado_delete;

DELIMITER //

CREATE TRIGGER before_empleado_delete
BEFORE DELETE ON empleado
FOR EACH ROW
BEGIN
    DECLARE fin INT DEFAULT 0;
    DECLARE v_cliente INT;
    DECLARE v_nuevo_empleado INT;

    DECLARE c_clientes CURSOR FOR
        SELECT codigo_cliente
        FROM cliente
        WHERE codigo_empleado_rep_ventas = OLD.codigo_empleado;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN c_clientes;

    bucle_clientes: LOOP
        FETCH c_clientes INTO v_cliente;
        IF fin = 1 THEN
            LEAVE bucle_clientes;
        END IF;

        SELECT e.codigo_empleado
        INTO v_nuevo_empleado
        FROM empleado e
        LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
        WHERE e.codigo_empleado != OLD.codigo_empleado
        GROUP BY e.codigo_empleado
        ORDER BY COUNT(c.codigo_cliente) ASC
        LIMIT 1;

        UPDATE cliente
        SET codigo_empleado_rep_ventas = v_nuevo_empleado
        WHERE codigo_cliente = v_cliente;
    END LOOP;

    CLOSE c_clientes;
END;
//

DELIMITER ;