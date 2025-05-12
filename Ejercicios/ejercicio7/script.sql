USE empleados;
-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
SELECT e.*, d.nombre NombreDepartamento, d.presupuesto PresupuestoDepartamento, d.gastos GastosDepartamento
FROM empleado e JOIN departamento d ON e.id_departamento=d.id;
-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
SELECT *
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id
order by d.nombre asc, apellido1, apellido2, e.nombre;
-- Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
SELECT distinct d.id,d.nombre
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id;
-- Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).
SELECT distinct d.id, d.nombre, d.presupuesto-gastos "Presupuesto actual"
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id;
-- Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
SELECT distinct d.nombre
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id
WHERE e.nif="38382980M";
-- Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
SELECT distinct d.nombre
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id
WHERE e.nombre='Pepe' AND apellido1='Ruiz' AND apellido2='Santana';
-- Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
SELECT distinct e.*
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id
WHERE d.nombre='I+D';
-- Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
SELECT distinct e.*
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id
WHERE d.nombre IN('I+D','Contabilidad', 'Sistemas')
ORDER BY apellido1,apellido2,e.nombre;
-- Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
SELECT distinct e.nombre
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id
WHERE presupuesto NOT BETWEEN 100000 AND 200000;
-- Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
SELECT distinct d.nombre
FROM empleado e 
JOIN departamento d ON e.id_departamento=d.id
WHERE e.apellido2 IS NULL;