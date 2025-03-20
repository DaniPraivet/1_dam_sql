 -- Devuelve el número total de alumnas que hay.
SELECT COUNT(*) FROM persona
WHERE tipo="alumno" AND sexo="M";
    -- Calcula cuántos alumnos nacieron en 1999.
SELECT COUNT(*) FROM persona
WHERE YEAR(fecha_nacimiento)=1999 AND tipo="alumno";
    /* Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, 
       una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. 
       El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado 
       de mayor a menor por el número de profesores. */
SELECT d.nombre "Nombre departamento", COUNT(p.id_profesor) "Profesores"
FROM profesor p JOIN departamento d ON p.id_departamento=d.id
GROUP BY d.nombre ORDER BY COUNT(p.id_profesor) DESC;
    /* Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. 
       Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos
       también tienen que aparecer en el listado. */
SELECT d.nombre "Nombre departamento", COUNT(p.id_profesor) "Profesores"
FROM profesor p RIGHT JOIN departamento d ON p.id_departamento=d.id
GROUP BY d.nombre;
    /* Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas 
       que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados
       también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número 
       de asignaturas.*/
SELECT gr.nombre, COUNT(ag.id_grado)
FROM grado gr LEFT JOIN asignatura ag ON gr.id=ag.id_grado
GROUP BY gr.id
ORDER BY COUNT(gr.nombre) DESC;

    /* Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas 
       que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas. */
SELECT gr.nombre, COUNT(ag.id_grado)
FROM grado gr LEFT JOIN asignatura ag ON gr.id=ag.id_grado
GROUP BY gr.id
HAVING(COUNT(ag.id_grado)>40);

    /* Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada 
       tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los 
       créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de 
       crédidos. */
SELECT gr.nombre, ag.tipo, SUM(ag.creditos) "Suma créditos"
FROM grado gr JOIN asignatura ag ON gr.id=ag.id_grado
GROUP BY gr.nombre, ag.tipo
ORDER BY SUM(ag.creditos) DESC;

    /* Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos 
       escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra 
       con el número de alumnos matriculados.*/
SELECT ce.anyo_inicio "Curso año inicio", COUNT(ama.id_alumno) "Alumnos"
FROM alumno_se_matricula_asignatura ama
RIGHT JOIN curso_escolar ce ON ama.id_curso_escolar=ce.id
GROUP BY ce.anyo_inicio;


    /* Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta 
       aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, 
       primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por 
       el número de asignaturas. */
SELECT pe.id, pe.nombre "Nombre profesor", pe.apellido1, pe.apellido2,COUNT(ag.id), COUNT(pe.id)
FROM asignatura ag
RIGHT JOIN profesor p ON ag.id_profesor=p.id_profesor
JOIN persona pe ON pe.id=p.id_profesor
GROUP BY (pe.id, pe.nombre, pe.apellido1, pe.apellido2, ag.id);