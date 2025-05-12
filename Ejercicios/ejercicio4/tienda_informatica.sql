CREATE DATABASE IF NOT EXISTS tienda_informatica
CHARACTER SET latin1
COLLATE latin1_spanish_ci;

USE tienda_informatica;

CREATE TABLE IF NOT EXISTS producto (
codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
precio DOUBLE NOT NULL,
codigo_fabricante INT UNSIGNED NOT NULL
);

CREATE TABLE IF NOT EXISTS fabricante (
codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100)
);

-- PRODUCTO(codigo_fabricante) -> FABRICANTE(codigo)
ALTER TABLE producto
ADD CONSTRAINT FK_producto_fabricante_codigofabricante
FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo);

-- Insertamos datos
INSERT INTO fabricante(codigo, nombre) VALUES(1, 'Asus');
INSERT INTO fabricante(codigo,nombre) VALUES(2, 'Lenovo');
INSERT INTO fabricante(codigo,nombre) VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante(codigo,nombre) VALUES(4, 'Samsung');
INSERT INTO fabricante(codigo,nombre) VALUES(5, 'Seagate');
INSERT INTO fabricante(codigo,nombre) VALUES(6, 'Crucial');
INSERT INTO fabricante(codigo,nombre) VALUES(7, 'Gigabyte');
INSERT INTO fabricante(codigo,nombre) VALUES(8, 'Huawei');
INSERT INTO fabricante(codigo,nombre) VALUES(9, 'Xiaomi');
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)

VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1. Inserta un nuevo fabricante indicando su código y su nombre.
INSERT INTO fabricante(codigo, nombre) VALUES(10, 'Nvidia');
-- 2. Inserta un nuevo fabricante indicando solamente su nombre.
INSERT INTO fabricante(nombre) VALUES('AMD');
-- 3. Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La
-- sentencia de inserción debe incluir: código, nombre, precio y
-- código_fabricante.
INSERT INTO producto(codigo,nombre, precio,codigo_fabricante)
VALUES(12, 'RTX 3060 Super', 399.99, 10);
-- 4. Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La
-- sentencia de inserción debe incluir: nombre, precio y código_fabricante.
INSERT INTO producto(nombre, precio,codigo_fabricante)
VALUES('Ryzen 5 5600x', 150, 11);
-- 6. Elimina el fabricante Asus. ¿Es posible eliminarlo? Si no fuese posible, ¿qué
-- cambios debería realizar para que fuese posible borrarlo? Argumentalo.
-- Solución (Crear un nuevo fabricante y asignarlo a todos los que tengan el código asus.)
INSERT INTO fabricante(nombre) VALUES('Sin Fabricante');
UPDATE producto
SET codigo_fabricante = 12
WHERE codigo_fabricante = 1;

DELETE FROM fabricante WHERE nombre='Asus'; 
-- No se puede porque está siendo afectado por la clave foránea

-- 7. Elimina el fabricante Xiaomi. ¿Es posible eliminarlo? Si no fuese posible, ¿qué
-- cambios debería realizar para que fuese posible borrarlo? Argumentalo.

DELETE FROM fabricante WHERE nombre='Xiaomi';
-- No se puede porque está siendo afectado por la clave foránea

-- 8. Actualiza el código del fabricante Lenovo y asígnale el valor 20. ¿Es posible
-- actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese
-- actualizarlo? Argumentalo.
UPDATE producto
SET codigo_fabricante = 20
WHERE codigo_fabricante = 8;
UPDATE fabricante
SET codigo = 20
WHERE codigo = 2;
-- 9. Actualiza el código del fabricante Huawei y asígnale el valor 30. ¿Es posible
-- actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese
-- actualizarlo? Argumentalo.
UPDATE producto
SET codigo_fabricante = 30
WHERE codigo_fabricante = 8;
UPDATE fabricante
SET codigo = 30
WHERE codigo = 8;
-- 10. Actualiza el precio de todos los productos sumándole 5 € al precio actual.
UPDATE producto
SET precio = precio + 5;
-- 11. Elimina todas las impresoras que tienen un precio menor de 200 €.
DELETE FROM producto WHERE nombre LIKE 'Impresora %' AND precio < 200;
-- 12. Añade una nueva columna a la tabla de productos denominada canon
ALTER TABLE producto
ADD canon DOUBLE(10, 2);
-- 13. Actualiza los valores de la columna canon para que los discos duros que existen
-- en la tabla tengan un valor de 3.5, el resto de campos déjalos a NULL
UPDATE producto
SET canon = 3.5
WHERE nombre LIKE 'Disco duro %';
-- 14. Modifica el campo nombre de la tabla productos para que pueda tener un
-- nombre de 100 caracteres en lugar de 50.
ALTER TABLE producto
MODIFY nombre VARCHAR(100);
-- 15. Elimina los artículos del fabricante 6 que valgan más de 500 €
DELETE FROM producto WHERE codigo_fabricante = 6 AND precio > 500;