USE jardineria;

/*
Cuando se inserte un pedido, eliminar la cantidad de ese producto a su cantidad en stock
*/

SELECT * FROM producto;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;

DROP TRIGGER IF EXISTS actualizar_stock_insertar;

DELIMITER //

CREATE TRIGGER actualizar_stock_insertar
BEFORE INSERT ON detalle_pedido FOR EACH ROW
BEGIN
    UPDATE producto SET cantidad_en_stock=cantidad_en_stock-NEW.cantidad
    WHERE codigo_producto=NEW.codigo_producto;
END;
//

DELIMITER ;

SELECT * FROM PRODUCTO WHERE codigo_producto='FR-67';


INSERT INTO 
  pedido (
    codigo_pedido, 
    fecha_pedido, 
    fecha_esperada, 
    fecha_entrega, 
    estado, 
    comentarios, 
    codigo_cliente
  )
values
  (
    129, 
    NOW(), 
    '2025-05-09', 
    NULL, 
    'Pendiente', 
    NULL, 
    3
);
INSERT INTO 
    detalle_pedido(
        codigo_pedido, 
        codigo_producto, 
        cantidad, 
        precio_unidad, 
        numero_linea) 
VALUES (
    129,
    'FR-67', 
    4, 
    70, 
    1
);