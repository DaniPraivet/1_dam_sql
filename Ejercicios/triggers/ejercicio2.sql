/*
Crea un trigger que se dispare cuando se borra un registro de la tabla
atracción_dia. El trigger deberá borrar toda la información relacionada con esa
atracción, restando las ganancias y borrando la atracción de la tabla
atracciones.
*/
USE circo;
SELECT * FROM animales;
DESC animales;

DROP TRIGGER IF EXISTS borrar_atraccion;

DELIMITER //
CREATE TRIGGER borrar_atraccion
AFTER DELETE ON atraccion_dia FOR EACH ROW
BEGIN
    IF OLD.ganancias IS NOT NULL THEN
        UPDATE atracciones set ganancias = ganancias - old.ganancias
        WHERE nombre = old.nombre_atraccion;
    END IF;
END;
//

DELIMITER ;

SELECT * FROM atracciones;

SELECT * FROM atraccion_dia
WHERE nombre_atraccion="Las jirafas"; -- 31000

DELETE FROM atraccion_dia
WHERE nombre_atraccion='Las jirafas'; 