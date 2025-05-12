/*
Crea un disparador que controle el evento de inserción en la tabla de animales,
de tal manera que si se intenta insertar un león con más de 20 años se impida
la inserción del animal. Esto se puede conseguir lanzando una excepción. Por
ejemplo:
*/

USE circo;
SELECT * FROM animales;
DESC animales;

DROP TRIGGER IF EXISTS bloquea_insert_animal;

DELIMITER //
CREATE TRIGGER bloquea_insert_animal
BEFORE INSERT ON animales FOR EACH ROW
BEGIN
    IF NEW.tipo = 'León' 
        AND NEW.anhos IS NOT NULL AND NEW.anhos>20 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT='El tipo león no puede tener más de 20 años';
    END IF;
END;
//

DELIMITER ;

INSERT INTO animales (nombre,tipo,anhos)
VALUES ('Rex', 'Mono', 8);

INSERT INTO animales (nombre,tipo,anhos)
VALUES ('Gustavo', 'León', 28);

INSERT INTO animales (nombre,tipo,anhos)
VALUES ('Eustakio', 'León', 8);