/*
Haz un tigger que actualice el campo ganancias de la tabla atracciones cuando
se inserten, borren o modifiquen datos en la tabla ATRACCION_DIA, sumando o
restando la ganancia del día.

Si al añadir una celebración nueva (ATRACCION_DIA) la fecha_inicio en
ATRACCIONES es NULL, se debe de actualizar con la fecha actual.

Nota: Debéis de tener en cuenta que tanto la fecha como las ganancias en
ATRACCIONES pueden tener valores nulos. Podéishacer uso de la función IFNULL
para dar un valor a esas columnas cuando sean null (recordar que si sumamos
una columna con valor null siempre devolverá null).
*/

USE circo;

DROP TRIGGER IF EXISTS inserta_atraccion_dia;

DESC atracciones;
DELIMITER //
CREATE TRIGGER inserta_atraccion_dia
AFTER INSERT ON atraccion_dia FOR EACH ROW
BEGIN
    UPDATE atracciones set fecha_inicio=IFNULL(fecha_inicio, CURDATE()),
    ganancias = IF NULL(ganancias,0) + IFNULL(NEW.ganancias.0)
    WHERE nombre=NEW.nombre_atraccion;
END;
//

DROP TRIGGER IF EXISTS actualiza_atraccion_dia;

DESC atracciones;
DELIMITER //
CREATE TRIGGER actualiza_atraccion_dia
AFTER UPDATE ON atraccion_dia FOR EACH ROW
BEGIN
    UPDATE atracciones 
    set ganancias = IFNULL(ganancias,0) +
    (IFNULL(NEW.ganancias) - IFNULL(OLD.ganancias,0))
    WHERE nombre=NEW.nombre_atraccion;
END;
//

DROP TRIGGER IF EXISTS eliminar_atraccion_dia;

DESC atracciones;
DELIMITER //
CREATE TRIGGER eliminar_atraccion_dia
AFTER DELETE ON atraccion_dia FOR EACH ROW
BEGIN
    UPDATE atracciones 
    set ganancias = IFNULL(ganancias,0) - IFNULL(OLD.ganancias,0)
    WHERE nombre=OLD.nombre_atraccion;
END;
//

DELIMITER ;

SELECT * FROM atracciones;
SELECT * FROM atraccion_dia;

INSERT INTO atraccion_dia
VALUES ('La espectacular', CURRENT_DATE(), 200, 2000);

