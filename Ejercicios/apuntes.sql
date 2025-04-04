USE empleados;

SELECT * FROM departamento;
SELECT * FROM empleado;

SELECT COUNT(*) FROM departamento;
SELECT COUNT(*) FROM empleado;

-- Cuantos empleados hay por departamento
SELECT id_departamento, COUNT(*)
FROM empleado
GROUP BY id_departamento;

SELECT IFNULL(d.nombre, "Sin departamento") NombreDepartamento, COUNT(*)
FROM empleado e JOIN departamento d ON e.id_departamento=departamento.id
GROUP BY d.nombre;



USE universidad;
SELECT g.nombre, curso, tipo, COUNT(*)
FROM asignatura ag JOIN grado g ON ag.id_grado=g.id
GROUP BY g.nombre, curso, tipo;