DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;
CREATE TABLE departamento (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL,
 presupuesto DOUBLE UNSIGNED NOT NULL,
 gastos DOUBLE UNSIGNED NOT NULL
);
CREATE TABLE empleado (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nif VARCHAR(9) NOT NULL UNIQUE,
 nombre VARCHAR(100) NOT NULL,
 apellido1 VARCHAR(100) NOT NULL,
 apellido2 VARCHAR(100),
 id_departamento INT UNSIGNED,
 FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);
INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);
INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores',
NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez',
'Guerrero', NULL);

-- 1. Lista el primer apellido de todos los empleados.
SELECT apellido1 FROM empleado;

-- 2. Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.
SELECT DISTINCT apellido1 FROM empleado;

-- 3. Lista todas las columnas de la tabla empleado.
SELECT * FROM empleado;

-- 4. Lista el nombre y los apellidos de todos los empleados.
SELECT nombre, apellido1, apellido2 FROM empleado;

-- 5. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.
SELECT id_departamento FROM empleado;

-- 6. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los identificadores que aparecen repetidos.
SELECT DISTINCT id_departamento FROM empleado;

-- 7. Lista el nombre y apellidos de los empleados en una única columna.
SELECT CONCAT(nombre, ' ', apellido1, ' ', IFNULL(apellido2, '')) AS nombre_completo FROM empleado;

-- 8. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
SELECT UPPER(CONCAT(nombre, ' ', apellido1, ' ', IFNULL(apellido2, ''))) AS nombre_completo FROM empleado;

-- 9. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
SELECT LOWER(CONCAT(nombre, ' ', apellido1, ' ', IFNULL(apellido2, ''))) AS nombre_completo FROM empleado;

-- 10. Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.
SELECT id, LEFT(nif, LENGTH(nif)-1) AS digitos, RIGHT(nif, 1) AS letra FROM empleado;

-- 11. Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone.
SELECT nombre, (presupuesto - gastos) AS presupuesto_actual FROM departamento;

-- 12. Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
SELECT nombre, (presupuesto - gastos) AS presupuesto_actual FROM departamento ORDER BY presupuesto_actual ASC;

-- 13. Lista el nombre de todos los departamentos ordenados de forma ascendente.
SELECT nombre FROM departamento ORDER BY nombre ASC;

-- 14. Lista el nombre de todos los departamentos ordenados de forma descendente.
SELECT nombre FROM departamento ORDER BY nombre DESC;

-- 15. Lista los apellidos y el nombre de todos los empleados, ordenados alfabéticamente por apellidos y luego por nombre.
SELECT apellido1, apellido2, nombre FROM empleado ORDER BY apellido1, apellido2, nombre;

-- 16. Devuelve una lista con el nombre y el presupuesto de los 3 departamentos con mayor presupuesto.
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto DESC LIMIT 3;

-- 17. Devuelve una lista con el nombre y el presupuesto de los 3 departamentos con menor presupuesto.
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto ASC LIMIT 3;

-- 18. Devuelve una lista con el nombre y el gasto de los 2 departamentos con mayor gasto.
SELECT nombre, gastos FROM departamento ORDER BY gastos DESC LIMIT 2;

-- 19. Devuelve una lista con el nombre y el gasto de los 2 departamentos con menor gasto.
SELECT nombre, gastos FROM departamento ORDER BY gastos ASC LIMIT 2;

-- 20. Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado (incluir tercera fila).
SELECT * FROM empleado LIMIT 5 OFFSET 2;

-- 21. Devuelve los departamentos con un presupuesto mayor o igual a 150000 euros.
SELECT nombre, presupuesto FROM departamento WHERE presupuesto >= 150000;

-- 22. Devuelve los departamentos con menos de 5000 euros de gastos.
SELECT nombre, gastos FROM departamento WHERE gastos < 5000;

-- 23. Devuelve los departamentos con un presupuesto entre 100000 y 200000 euros, sin usar BETWEEN.
SELECT nombre, presupuesto FROM departamento WHERE presupuesto >= 100000 AND presupuesto <= 200000;

-- 24. Devuelve los departamentos cuyo presupuesto NO está entre 100000 y 200000 euros, sin usar BETWEEN.
SELECT nombre FROM departamento WHERE presupuesto < 100000 OR presupuesto > 200000;

-- 25. Devuelve los departamentos con un presupuesto entre 100000 y 200000 euros, usando BETWEEN.
SELECT nombre, presupuesto FROM departamento WHERE presupuesto BETWEEN 100000 AND 200000;

-- 26. Devuelve los departamentos cuyo presupuesto NO está entre 100000 y 200000 euros, usando BETWEEN.
SELECT nombre FROM departamento WHERE presupuesto NOT BETWEEN 100000 AND 200000;

-- 27. Devuelve los departamentos donde los gastos son mayores que el presupuesto.
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos > presupuesto;

-- 28. Devuelve los departamentos donde los gastos son menores que el presupuesto.
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos < presupuesto;

-- 29. Devuelve los departamentos donde los gastos son iguales al presupuesto.
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos = presupuesto;

-- 30. Lista todos los datos de los empleados cuyo segundo apellido sea NULL.
SELECT * FROM empleado WHERE apellido2 IS NULL;

-- 31. Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.
SELECT * FROM empleado WHERE apellido2 IS NOT NULL;

-- 32. Lista todos los datos de los empleados cuyo segundo apellido sea 'López'.
SELECT * FROM empleado WHERE apellido2 = 'López';

-- 33. Lista todos los datos de los empleados cuyo segundo apellido sea 'Díaz' o 'Moreno', sin usar IN.
SELECT * FROM empleado WHERE apellido2 = 'Díaz' OR apellido2 = 'Moreno';

-- 34. Lista todos los datos de los empleados cuyo segundo apellido sea 'Díaz' o 'Moreno', usando IN.
SELECT * FROM empleado WHERE apellido2 IN ('Díaz', 'Moreno');

-- 35. Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.
SELECT nombre, apellido1, apellido2, nif FROM empleado WHERE id_departamento = 3;

-- 36. Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.
SELECT nombre, apellido1, apellido2, nif FROM empleado WHERE id_departamento IN (2, 4, 5);
