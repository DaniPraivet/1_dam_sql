USE mepico;

/*
Crea una función llamada calcula_numero_de_ventas que recibe como
parámetro el título de un juego y que devuelva la cantidad de unidades
vendidas de ese juego en la plataforma. Deberás hacer lo siguiente: (3.0
puntos)

o Consulta el id del juego y almacénalo en una variable.
o Consulta el numero de unidades totales de dicho juego que se han vendido y
almacénalo en otra variable que será la que devuelva la función
o Una vez hecho prueba la ejecución de la función indicando el código utilizado
o Por último, utiliza la función en una consulta que muestre el id_juego, el título
y el precio del junto con el numero de ventas de cada juego, deberás hacer uso
de la función aquí.
*/

DELIMITER ;

DROP FUNCTION IF EXISTS calcula_numero_de_ventas;

DELIMITER //

CREATE FUNCTION calcula_numero_de_ventas (p_titulo VARCHAR(200))
RETURNS INT NOT DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE p_id_juego_rodriguez SMALLINT;
    DECLARE p_unidades_vendidas_juego_rodriguez INT;
    
	SELECT id_juego INTO p_id_juego_rodriguez FROM juegos WHERE p_titulo=titulo;
    
    SELECT sum(dp.cantidad) INTO p_unidades_vendidas_juego_rodriguez FROM juegos j
    JOIN detallespedido dp ON dp.id_juego=j.id_juego
    WHERE dp.id_juego=p_id_juego_rodriguez;
    
    RETURN p_unidades_vendidas_juego_rodriguez;
END;
//


DELIMITER ;

-- Para usar esta función tendremos que usar SELECT
SELECT titulo FROM juegos ORDER BY id_juego;

SELECT calcula_numero_de_ventas('Elden Ring');

SELECT calcula_numero_de_ventas(titulo) FROM juegos;





/*
Crea un procedimiento, denominado descuento_desarrollador_semana, que
reciba como parámetro el nombre de un desarrollador y que mediante el uso
de cursores realice un descuento en el precio de los juegos de dicho
desarrollador de la siguiente manera (4.0 puntos):
o Si el juego es anterior al año 2020 se le hará un descuento del 50%
o Si el juego se lanzó entre el año 2020 y 2021 se la hará un descuento de 40%
o Si se lanzó entre el 2022 y el 2024 el descuento es del 20%
o Si es más moderno el juego no tendrá descuento.
*/

DROP PROCEDURE IF EXISTS descuento_desarrollador_semana;

DELIMITER //

CREATE PROCEDURE descuento_desarrollador_semana	(p_desarrollador VARCHAR(200))
MODIFIES SQL DATA
BEGIN
	DECLARE v_hay_registros_rodriguez BOOLEAN DEFAULT TRUE;
    DECLARE v_id_juego_rodriguez SMALLINT;
    DECLARE v_precio_rodriguez DOUBLE;
    DECLARE v_fecha_lanzamiento_rodriguez DATE;
    
    DECLARE c_juegos_por_desarrollador CURSOR FOR 
    SELECT id_juego, precio, fecha_lanzamiento 
    FROM juegos
    WHERE p_desarrollador=desarrollador;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_hay_registros_rodriguez=FALSE;
    
    OPEN c_juegos_por_desarrollador;
    FETCH c_juegos_por_desarrollador 
		INTO v_id_juego_rodriguez, v_precio_rodriguez, v_fecha_lanzamiento_rodriguez;
    WHILE v_hay_registros_rodriguez DO
    IF YEAR(v_fecha_lanzamiento_rodriguez)<2020 THEN
		SET v_precio_rodriguez=v_precio_rodriguez*0.5;
	ELSEIF YEAR(v_fecha_lanzamiento_rodriguez) BETWEEN 2020 AND 2021 THEN
		SET v_precio_rodriguez=v_precio_rodriguez*0.6;
    ELSEIF YEAR(v_fecha_lanzamiento_rodriguez) BETWEEN 2022 AND 2024 THEN
		SET v_precio_rodriguez=v_precio_rodriguez*0.8;
	END IF;
    
    UPDATE juegos SET precio=v_precio_rodriguez
    WHERE id_juego=v_id_juego_rodriguez;
    
    FETCH c_juegos_por_desarrollador 
		INTO v_id_juego_rodriguez, v_precio_rodriguez, v_fecha_lanzamiento_rodriguez;
	END WHILE;
    
    CLOSE c_juegos_por_desarrollador;
END;
//

DELIMITER ;
SELECT * FROM juegos WHERE desarrollador='Nintendo';

CALL descuento_desarrollador_semana('Nintendo');





/*
Crea un trigger denominado crea_registro_horas_jugadas que se active
cuando se realiza una inserción sobre la tabla detallespedido, de tal manera
que cuando un cliente compra un juego se cree un nuevo registro en la tabla
horasjugadas con el id_usuario que ha realizado el pedido, el id_juego del
detalle_pedido, el número de horas a 0 y la fecha con el valor de la fecha
actual. (3.0 puntos).
o Deberás buscar los datos que te hagan falta para la inserción del registro en
horasjugadas previamente.
*/

DROP TRIGGER IF EXISTS crea_registro_horas_jugadas;

SELECT * FROM horasjugadas;
DESC detallespedido;

DELIMITER //

CREATE TRIGGER crea_registro_horas_jugadas
AFTER INSERT ON detallespedido FOR EACH ROW
BEGIN
	DECLARE v_id_usuario_rodriguez SMALLINT;
    SELECT id_usuario INTO v_id_usuario_rodriguez
    FROM pedidos WHERE id_pedido=NEW.id_pedido;
    
    INSERT INTO horasjugadas (`id_usuario`, `id_juego`, `horas`, `fecha`)
	VALUES (v_id_usuario_rodriguez, NEW.id_juego, 0, current_date());
END;
//

DELIMITER ;

SELECT * FROM usuarios;

SELECT * FROM pedidos;

SELECT * FROM detallespedido;

INSERT INTO pedidos (`id_usuario`,`fecha_pedido`,`metodo_pago`,`estado`)
VALUES(26,curdate(),'PAYPAL','Cancelado');

SELECT * FROM pedidos;

INSERT INTO detallespedido (`id_pedido`,`id_juego`,`cantidad`,`precio_unitario`)
VALUES (77,1,1,1);

SELECT * FROM horasjugadas;



