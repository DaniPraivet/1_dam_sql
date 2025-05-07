USE jardineria;

/*
Cuando se inserte un pedido, eliminar la cantidad de ese producto a su cantidad en stock
*/

SELECT * FROM producto;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;

/* Trigger para insertar*/
DROP TRIGGER IF EXISTS actualizar_stock_insert;

DELIMITER //

CREATE TRIGGER actualizar_stock_insert
BEFORE INSERT ON detalle_pedido FOR EACH ROW
BEGIN
    UPDATE producto SET cantidad_en_stock=cantidad_en_stock-NEW.cantidad
    WHERE codigo_producto=NEW.codigo_producto;
END;
//

DELIMITER ;

SELECT * FROM PRODUCTO WHERE codigo_producto='FR-67';

/* Trigger para actualizar*/
DROP TRIGGER IF EXISTS actualizar_stock_update;

DELIMITER //
CREATE TRIGGER actualizar_stock_update
BEFORE UPDATE ON detalle_pedido FOR EACH ROW
BEGIN
    DECLARE v_diferencia INT;
    
    IF OLD.cantidad != NEW.cantidad THEN
        SET v_diferencia = OLD.cantidad-NEW.cantidad;
        UPDATE producto SET cantidad_en_stock=cantidad_en_stock+v_incremento
        WHERE codigo_producto=NEW.codigo_producto;
    END IF;
END;
//

DELIMITER ;


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