/*1. Escribir un procedimiento que cuente el número de filas que hay en la tabla
productos (tienda), deposita el resultado en la variable v_num, y visualiza su
contenido*/
USE tienda;
DELIMITER //
CREATE PROCEDURE contar_numero_filas() 
BEGIN
    DECLARE v_num INT DEFAULT 0;

    SELECT CONCAT ("La variable es ",v_num);
END;
//
DELIMITER ;
CALL contar_numero_filas;





/*2. Escribir un procedimiento que reciba dos números y visualice su división.*/
USE tienda;
DELIMITER //
CREATE PROCEDURE contar_numero_filas() 
BEGIN
    SELECT 5 DIV 10;
END;
//
DELIMITER ;
CALL contar_numero_filas;
/*3. Escribe un procedimiento que consulte el máximo precio de la tabla
productos(tienda) e y lo muestre por pantalla.*/

/*4. Escribe un procedimiento que escriba el precio de un producto pasado como
parámetro (se pasará el nombre_producto).*/