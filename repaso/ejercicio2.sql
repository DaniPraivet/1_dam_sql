-- Active: 1747297143236@@127.0.0.1@3306@jardineria
/*
Crea un procedimiento que reciba como argumento el código_cliente de un
cliente y un año, y escriba en pantalla las gamas de productos de los que ha
comprado algún articulo durante el año pasado como parámetro.
*/

DROP PROCEDURE IF EXISTS compras_cliente_en_anio;
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS compras_cliente_en_anio (p_codigo_cliente INT(11), p_anio INT)
NOT DETERMINISTIC READS SQL DATA
BEGIN
    SELECT pr.gama FROM cliente cl
    JOIN pedido pe ON pe.codigo_cliente=cl.codigo_cliente
    JOIN detalle_pedido dp ON dp.codigo_pedido=pe.codigo_pedido
    JOIN producto pr ON pr.codigo_producto=dp.codigo_producto
    WHERE cl.codigo_cliente=p_codigo_cliente AND YEAR(pe.fecha_pedido)=p_anio;
END;
//

DELIMITER ;
CALL compras_cliente_en_anio(30,2009);

SELECT pr.gama FROM cliente cl
    JOIN pedido pe ON pe.codigo_cliente=cl.codigo_cliente
    JOIN detalle_pedido dp ON dp.codigo_pedido=pe.codigo_pedido
    JOIN producto pr ON pr.codigo_producto=dp.codigo_producto
WHERE cl.codigo_cliente=30 AND YEAR(pe.fecha_pedido)=2009;

SELECT * FROM pedido;