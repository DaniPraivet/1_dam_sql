-- Active: 1745421231241@@127.0.0.1@3306@tienda
USE tienda;

-- 1. Escribir un procedimiento que reciba un número e indique si es par o mayor

DROP PROCEDURE IF EXISTS par_o_mayor_que10;

DELIMITER //

CREATE PROCEDURE procedimiento__par_o_mayor_que10 (in numero int)
BEGIN
    IF (numero MOD 2 = 0 OR numero>10) THEN
        SELECT CONCAT("El número ", numero, "es par o mayor que 10");
    ELSE
        SELECT CONCAT("El número ", numero, " no es ni par ni mayor que 10");
    END IF;
END;
//

DELIMITER ;

CALL procedimiento__par_o_mayor_que10(2);
CALL procedimiento__par_o_mayor_que10(25);
CALL procedimiento__par_o_mayor_que10(7);

-- 2. Escribe un procedimiento que reciba un año e indique si es o no bisiesto
DROP PROCEDURE IF EXISTS procedimiento__anio_bisiesto;

DELIMITER //

CREATE PROCEDURE procedimiento__anio_bisiesto (in anio int)
BEGIN
    IF (((anio MOD 400) = 0) || ((anio MOD 4) = 0) && ((anio MOD 100) != 0)) THEN
        SELECT CONCAT("El año ", anio," es bisiesto");
    ELSE
        SELECT CONCAT("El año ", anio," no es bisiesto");
    END IF;
END;
//
DELIMITER ;

CALL procedimiento__anio_bisiesto(2006);
CALL procedimiento__anio_bisiesto(2004);
CALL procedimiento__anio_bisiesto(2100);



-- 3. Escribe un procedimiento que consulte el número de registros de la tabla
-- productos(tienda) e indique si el número de filas es superior o inferior a 10.
DROP PROCEDURE IF EXISTS procedimiento__n_registros_tabla_productos;

DELIMITER //

CREATE PROCEDURE procedimiento__n_registros_tabla_productos ()
BEGIN
    SELECT COUNT(*) FROM producto;
END;
//
DELIMITER ;

CALL procedimiento__n_registros_tabla_productos();

-- 4. Crea un procedimiento que tome tres parámetros numéricos y escriba en
-- pantalla si el primero de ellos se encuentra comprendido entre el segundo
-- y el tercero.
DROP PROCEDURE IF EXISTS procedimiento__primer_numero_en_medio;

DELIMITER //

CREATE PROCEDURE procedimiento__primer_numero_en_medio (in n1 int, in n2 int, in n3 int)
BEGIN
    IF ((n1<n2 && n1>n3)||(n1<n3 && n1>n2)) THEN
        SELECT CONCAT("El número está en medio.");
    ELSE
        SELECT CONCAT("El número no está en medio.");
    END IF;
END;
//
DELIMITER ;

CALL procedimiento__primer_numero_en_medio(1,2,3); -- Falso
CALL procedimiento__primer_numero_en_medio(2,1,3); -- Verdadero
CALL procedimiento__primer_numero_en_medio(2,3,1); -- Verdadero


-- 5. Crea un procedimiento que reciba tres parámetros numéricos y indique
-- cual es el menor de los tres.
DROP PROCEDURE IF EXISTS procedimiento__numero_menor;

DELIMITER //
CREATE PROCEDURE procedimiento__numero_menor (in n1 int, in n2 int, in n3 int)
BEGIN
    IF (n1<=n2 && n1<=n3) THEN
        SELECT CONCAT("El número primero es el pequeño.");
    ELSEIF (n2<=n1 && n2<=n3) THEN
        SELECT CONCAT("El número segundo es el pequeño.");
    ELSE
        SELECT CONCAT("El número tercer es el pequeño.");
    END IF;
END;
//
DELIMITER ;

CALL procedimiento__numero_menor(1,2,3); -- Primero
CALL procedimiento__numero_menor(2,1,3); -- Segundo
CALL procedimiento__numero_menor(2,3,1); -- Tercero

-- 6. Crea un procedimiento (base de datos empresa) al que se le pase como
-- parámetro el cod_departamento. El procedimiento deberá modificar el
-- presupuesto en base a lo siguiente, si el tipo_dir es P se incrementará en un
-- 5%, sino se disminuirá en un 3%.



-- 7. Dada la siguiente tabla de rangos:
-- Presupuesto Valor
-- Menos de 5 - Bajo
-- Entre 5 y 10 - Medio
-- Más de 10 - Alto
-- Crear un procedimiento al que se le pasa un parámetro con el valor del
-- presupuesto y escriba el valor correspondiente a la cantidad (Bajo, Medio,
-- Alto). Hazlo con IF.

-- 8. Crea una función que reciba como parámetro el número del día de la
-- semana. Deberá devolver el nombre del día (1- Lunes, 2-Martes, 3-
-- Miercoles...)