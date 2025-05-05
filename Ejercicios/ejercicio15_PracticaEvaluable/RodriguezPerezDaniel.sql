DROP FUNCTION IF EXISTS potencia;

DELIMITER //
/*
Crea una función
que tome dos parámetros la base y el exponente, deberá devolver la potencia,
base^exponente=base x base x … x base (exponente veces). No se podrá utilizar las funciones pow o power. Es
necesario hacer uso de sentencias iterativas (bucles).
*/
CREATE FUNCTION potencia (base int, exponente int)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE resultado INT DEFAULT 1;
    
    IF exponente = 0 THEN
    RETURN resultado;
    END IF;

    
    WHILE exponente >= 1 DO
        SET resultado = resultado*base;
        SET exponente = exponente - 1;
    END WHILE;

    RETURN resultado;
END;
//
DELIMITER ;

SELECT potencia(2,10);
SELECT potencia(2,1);
SELECT potencia(2,0);