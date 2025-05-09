/*
Implementa un trigger que compruebe que si se intenta dar de alta un nuevo
artista y se envía un nif_jefe que no exista, se cambie su valor por null.
*/
USE circo;
SELECT * FROM artistas;
DESC artistas;

DROP TRIGGER IF EXISTS comprobar_jefe;

DELIMITER //
CREATE TRIGGER comprobar_jefe
BEFORE INSERT ON artistas FOR EACH ROW
BEGIN
    declare v_nif char(9)
    IF NEW.nif_jefe IS NOT NULL
        SELECT COUNT(*) INTO v_nif FROM artistas
        WHERE nif = NEW.nif_jefe;
    
        IF v_nif IS NULL THEN
            SET NEW.nif_jefe=NULL;
        END IF;
    END IF;

END;
//

DELIMITER ;

SELECT * FROM artistas;

INSERT INTO artistas
VALUES('99999999Ñ', 'López Marin', 'Antonio', '22222222B');

INSERT INTO artistas
VALUES('99999999Ñ', 'López Marin', 'María', '55555555N');