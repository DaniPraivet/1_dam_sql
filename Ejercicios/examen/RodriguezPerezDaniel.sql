USE mepico;


-- 1 . Crear la tabla reseñas
CREATE TABLE IF NOT EXISTS resenas(
id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario SMALLINT UNSIGNED NOT NULL,
id_juego SMALLINT UNSIGNED NOT NULL,
valoracion VARCHAR(500),
fecha_resena DATE,
puntos TINYINT UNSIGNED
);



-- 2 . Realizar las foráneas

-- RESENAS (id_usuario) -> USUARIOS (id_usuario)
ALTER TABLE resenas
ADD CONSTRAINT FK_resenas_idusuario__usuarios_idusuario
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);

-- RESENAS (id_juego) -> JUEGOS (id_juego)
ALTER TABLE resenas
ADD CONSTRAINT FK_resenas_idjuego__juegos_idjuego
FOREIGN KEY (id_juego) REFERENCES juegos(id_juego);


-- 3 . Actualizar los precios de todos los juegos de los desarrolladores
-- Capcom y Square Enix.
UPDATE juegos
SET precio=precio*0.5
WHERE desarrollador IN ("Capcom", "Square Enix");

-- 4 . Insertar un juego
INSERT INTO Juegos (Titulo, id_Categoria, Precio, Desarrollador, Fecha_Lanzamiento) VALUES
('Resident Evil 3 Remake', 9, 59.99, 'Capcom', '2025-03-18');

-- 5 . Borrar campos
DELETE FROM juegos
WHERE precio BETWEEN 10 AND 20;

-- No se puede eliminar o actualizar una fila padre, porque sino falla la clave foránea

-- CONSULTAS

-- 6 . Muestra los datos de los usuarios de Irlanda, Francia y Alemania que se han registrado
-- a partir del 15 de marzo de 2023 ordena los resultados en orden descendente por
-- fecha_nacimiento.

SELECT *
FROM usuarios
WHERE pais IN ('Irlanda' , 'Francia', 'Alemania') AND fecha_registro>'2023-03-15'
ORDER BY fecha_nacimiento DESC;

-- 7 . Muestra el nombre y el email de los usuarios junto con el id del pedido, la fecha y el
-- método de pago ordénalo en primer lugar por el nombre del usuario ascendente y en
-- segundo lugar por la fecha del pedido descendente

SELECT u.nombre, u.email, p.id_pedido, p.fecha_pedido, p.metodo_pago FROM usuarios u
JOIN pedidos p ON u.id_usuario=p.id_usuario
ORDER BY nombre ASC, p.fecha_pedido DESC;

-- 8 . Muestra el id del pedido, del usuario que lo realiza y la fecha junto con la cantidad y el
-- precio unitario de cada juego. Calcula también el subtotal (cantidad por precio
-- unitario) con el alias subtotal, y el IVA de la columna subtotal y ponle el alias IVA, de las
-- líneas de pedido que tienen el precio unitario mayor que cero. Órdenalo por el
-- id_pedido ascendente y el subtotal descendente.

SELECT p.id_pedido, u.nombre, d.cantidad, d.precio_unitario, 
(d.cantidad*d.precio_unitario) AS subtotal, (d.cantidad*d.precio_unitario)*0.21 AS IVA
FROM pedidos p
JOIN usuarios u ON p.id_usuario=u.id_usuario
JOIN detallespedido d ON p.id_pedido=d.id_pedido
WHERE d.precio_unitario>0
ORDER BY p.id_pedido ASC, d.cantidad*d.precio_unitario DESC;

-- 9 . Haz un listado de los juegos que no tienen registro de horas jugado y valen menos de
-- 20 euros.

SELECT *
FROM juegos j
LEFT JOIN horasjugadas h ON j.id_juego=h.id_juego
WHERE precio<20 AND h.horas IS NULL;


-- 10 . Muestra el total de dinero gastado por cada cliente. Para ello deberás sumar los
-- subtotales (precio unitario por cantidad) de todas las líneas de detalle. Deberás
-- mostrar el nombre y el correo de los usuarios junto con el total gastado.

SELECT u.nombre, u.email, (d.precio_unitario*d.cantidad)'Total Gastado' FROM usuarios u
JOIN pedidos p ON u.id_usuario=p.id_usuario
JOIN detallespedido d ON p.id_pedido=d.id_pedido;

-- 11 . Crea una vista llamada horas_jugadas_españa_jul_2023 que contenga la información
-- de las horas que han jugado los usuarios españoles que se registraron en el mes de
-- julio de 2023. La vista contendrá el nombre de usuario, el email, el título del juego, la
-- fecha de registro del usuario y el número de horas jugadas junto a la categoría del
-- juego.

CREATE VIEW horas_jugadas_espana_jul_2023 AS
SELECT u.nombre "Nombre usuario", u.email, j.titulo, u.fecha_registro, h.horas, c.nombre "Nombre categoria"
FROM usuarios u
JOIN horasjugadas h ON u.id_usuario=h.id_usuario
JOIN juegos j ON h.id_juego=j.id_juego
JOIN categorias c ON j.id_categoria=c.id_categoria
WHERE u.fecha_registro>'2023-07-31';


-- 12 . Utiliza la vista horas_jugadas_españa_jul_2023 el total horas jugadas por cada
-- usuario. La consulta sólo debe mostrar el nombre del usuario junto con la suma de
-- horas jugadas en total en todos sus juegos.
SELECT u.nombre, SUM(h.horas) FROM horas_jugadas_espana_jul_2023, usuarios u
LEFT JOIN horasjugadas h ON u.id_usuario=h.id_usuario
GROUP BY u.nombre;
