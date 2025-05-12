-- • Devuelve un listado con los datos de todas las alumnos que se han matriculado alguna vez
-- en el Grado en Ingeniería Informática (Plan 2015).
SELECT * FROM grado gr JOIN asignatura ag ON gr.id=ag.id_grado
					   JOIN alumno_se_matricula_asignatura ama ON ag.id=ama.id_Asignatura
                       JOIN persona p ON ama.id_alumno=p.id
WHERE gr.nombre="Grado en Ingeniería Informática (Plan 2015)";
-- • Muestra un listado de todas las asignaturas y el grado al que pertenecen
SELECT * FROM grado gr JOIN asignatura ag ON gr.id=ag.id_grado;
-- • Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería
-- Informática (Plan 2015).
SELECT * FROM asignatura ag JOIN grado gr ON ag.id_grado=gr.id
WHERE gr.nombre="Grado en Ingeniería Informática (Plan 2015)";
-- • Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los
-- alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el
-- primer apellido, segundo apellido y nombre.
SELECT * FROM persona p JOIN alumno_se_matricula_asignatura ama ON p.id=ama.id_alumno
ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
-- • Devuelve un listado de los profesores junto con el nombre del departamento al que están
-- vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido,
-- nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de
-- menor a mayor por los apellidos y el nombre.
SELECT p.apellido1 "Primer apellido", p.apellido2 "Segundo apellido", p.nombre "Nombre profesor", d.nombre "Nombre departamento" FROM persona p JOIN profesor pf ON p.id=pf.id_profesor
                        JOIN departamento d ON pf.id_departamento=d.id
ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
                        
-- • Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso
-- escolar del alumno con nif 26902806M.
SELECT ag.nombre "Nombre asignatura", ce.anyo_inicio "Año inicio", ce.anyo_fin "Año fin" FROM asignatura ag JOIN alumno_se_matricula_asignatura ama ON ag.id=ama.id_asignatura
							 JOIN persona p ON ama.id_alumno=p.id
                             JOIN curso_escolar ce ON ama.id_curso_escolar=ce.id
WHERE p.nif="26902806M";
-- • Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura
-- durante el curso escolar 2018/2019.
SELECT * FROM alumno_se_matricula_asignatura ama JOIN asignatura ag ON ama.id_asignatura=ag.id
		 JOIN persona p ON ama.id_alumno=p.id
         JOIN curso_escolar ce ON ama.id_curso_escolar=ce.id
WHERE anyo_inicio=2018 AND anyo_fin=2019;
-- • Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el
-- tercer curso del grado que tiene el identificador 7.
SELECT * FROM asignatura
WHERE cuatrimestre=1 AND curso=3 AND id_grado=7;
-- • Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su
-- número de teléfono en la base de datos.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN alumno_se_matricula_asignatura ama ON p.id=ama.id_alumno
WHERE p.telefono IS NULL;
-- • Devuelve el listado de los alumnos que nacieron en 1999.
SELECT DISTINCT * FROM persona p JOIN alumno_se_matricula_asignatura ama ON p.id=ama.id_alumno
WHERE year(p.fecha_nacimiento)=1999;
-- • Muestra un listado de todas las asignaturas y los alumnos que están matriculados en ellas
-- ordenados en primer lugar por el nombre de la asignatura y en segundo lugar por el
-- nombre del alumno.
SELECT * FROM persona p JOIN alumno_se_matricula_asignatura ama ON p.id=ama.id_alumno
						JOIN asignatura ag ON ama.id_asignatura=ag.id
ORDER BY ag.nombre DESC, p.nombre DESC;
departamentoempleado
-- • Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso
-- escolar del alumno con nif 26902806M.
SELECT * FROM persona p JOIN alumno_se_matricula_asignatura ama ON p.id=ama.id_alumno
						JOIN asignatura ag ON ama.id_asignatura=ag.id
WHERE p.id="26902806M";

-- Lista el nombre y apellidos de los profesores junto con la asignatura que imparten, ordenado por
-- el nombre de la asignatura descendente. Deberan aparecer también los profesores que no imparten 
-- ninguna asignatura.
SELECT p.nombre "Nombre profesor", p.apellido1 "Primer apellido", p.apellido2 "Segundo apellido", ag.nombre "Nombre asignatura",p.tipo
FROM persona p JOIN profesor pf ON p.id=pf.id_profesor
			   LEFT JOIN asignatura ag ON pf.id_profesor=ag.id_profesor
ORDER BY ag.nombre DESC;