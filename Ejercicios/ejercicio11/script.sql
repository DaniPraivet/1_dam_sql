-- Con operadores básicos de comparación
/* 1.	Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT * FROM producto p 
WHERE id_fabricante=(SELECT id FROM fabricante p WHERE nombre='Lenovo');
/* 2.	Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del 
fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT * FROM producto p 
WHERE id_fabricante=(SELECT id FROM fabricante p WHERE nombre='Lenovo');
/* 3.	Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT * FROM producto p
ORDER BY precio DESC LIMIT 1;
/* 4.	Lista el nombre del producto más barato del fabricante Hewlett-Packard.*/
SELECT p.nombre FROM producto p
WHERE id_fabricante=(SELECT id FROM fabricante f WHERE nombre='Hewlett-Packard') LIMIT 1;
/* 5.	Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto 
más caro del fabricante Lenovo.*/
SELECT * FROM producto p 
WHERE (SELECT precio FROM producto p WHERE id_fabricante=(SELECT id FROM fabricante p WHERE nombre='Lenovo') ORDER BY precio DESC LIMIT 1) <= precio;
/* 6.	Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de 
todos sus productos.*/
SELECT * FROM producto
WHERE (SELECT AVG(precio) FROM producto WHERE id_fabricante=(SELECT id FROM fabricante f WHERE nombre='Asus')) < precio;
/* Subconsultas con ALL y ANY*/
/* 7.	Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni 
LIMIT.*/

SELECT * FROM producto WHERE precio >= ALL (SELECT precio FROM producto); 
/* 8.	Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni 
LIMIT.*/
SELECT * FROM producto WHERE precio <= ALL (SELECT precio FROM producto);
/* 9.	Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT nombre FROM fabricante WHERE id= ANY (SELECT id_fabricante from producto); 
/* 10.	Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).*/
SELECT nombre FROM fabricante WHERE id != ALL (SELECT id_fabricante from producto); 

/* Subconsultas con IN y NOT IN*/
/* 11.	Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT nombre FROM fabricante WHERE id IN (SELECT id_fabricante from producto); 
/* 12.	Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).*/
SELECT nombre FROM fabricante WHERE id NOT IN (SELECT id_fabricante from producto); 

/* Subconsultas con EXISTS y NOT EXISTS*/
/* 13.	Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o 
NOT EXISTS).*/

/* 14.	Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o 
NOT EXISTS).*/


/* Subconsultas correlacionadas*/
/* 15.	Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.*/
SELECT f.nombre, 
       p.nombre, 
       p.precio
FROM fabricante f
JOIN producto p ON f.id = p.id_fabricante
WHERE (p.id_fabricante, p.precio) IN (
    SELECT id_fabricante, MAX(precio)
    FROM producto
    GROUP BY id_fabricante
)
ORDER BY f.nombre;
/* 16.	Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los 
productos de su mismo fabricante.*/
SELECT * FROM producto p
WHERE precio >= (SELECT AVG(precio) FROM producto p2 WHERE p.id_fabricante=p2.id_fabricante) ORDER BY id_fabricante;
/* 17.	Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT nombre FROM producto p
WHERE (id_fabricante, precio) in (SELECT id, MAX(precio) FROM producto p JOIN fabricante f ON p.id_fabricante=f.id GROUP BY id)
/* 18.	Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos 
que el fabricante Lenovo.*/