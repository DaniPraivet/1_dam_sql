-- Active: 1747297143236@@127.0.0.1@3306@jardineria
/*
Crea una función que dado el codigo_cliente de un cliente devuelva el teléfono
de la oficina del empleado de ventas que tiene asignado.
*/

DROP FUNCTION IF EXISTS telefono_oficina;

DELIMITER //

CREATE FUNCTION IF NOT EXISTS telefono_oficina (p_codigo_cliente INT)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE v_telefono VARCHAR(20);
    SELECT o.telefono INTO v_telefono
    FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
    WHERE c.codigo_cliente = p_codigo_cliente;
    RETURN v_telefono;
END;
//

DELIMITER ;

SELECT telefono_oficina(30);

SELECT o.telefono
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente = 30;