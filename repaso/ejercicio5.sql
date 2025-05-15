-- Active: 1747297143236@@127.0.0.1@3306@jardineria
/*
Crea un trigger que se dispare cuando se borre un empleado de la tabla de
empleados, de manera que antes de que se realice el borrado se sustituya a
todos los clientes que atendía ese empleado con el código del empleado que
tenga menos clientes asociados.
*/

DROP TRIGGER IF EXISTS before_empleado_delete;

DELIMITER //

CREATE TRIGGER before_empleado_delete
BEFORE DELETE ON empleado
FOR EACH ROW
BEGIN
    DECLARE v_nuevo_empleado INT;

    -- Buscar el código del empleado con menos clientes (distinto al que se borra)
    SELECT codigo_empleado INTO v_nuevo_empleado
    FROM empleado
    WHERE codigo_empleado != OLD.codigo_empleado
    ORDER BY (
        SELECT COUNT(*) FROM cliente 
        WHERE codigo_empleado_rep_ventas = empleado.codigo_empleado
    ) ASC
    LIMIT 1;

    -- Reasignar los clientes del empleado que se va a borrar
    UPDATE cliente
    SET codigo_empleado_rep_ventas = v_nuevo_empleado
    WHERE codigo_empleado_rep_ventas = OLD.codigo_empleado;
END;
//

DELIMITER ;