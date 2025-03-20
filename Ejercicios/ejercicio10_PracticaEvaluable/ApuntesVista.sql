USE universidad;

CREATE OR REPLACE VIEW alumnos_con_asignaturas AS 
	SELECT pe.id idAlumno, nif, pe.nombre nombreAlumno, apellido1, apellido2, ciudad, direccion, fecha_nacimiento, sexo ,
    ag.nombre nombreAsignatura, curso, cuatrimestre, g.nombre nombreGrado
    FROM persona pe JOIN alumno_se_matricula_asignatura ama ON pe.id=ama.id_alumno
					JOIN asignatura ag ON ama.id_asignatura=ag.id
                    JOIN grado g ON g.id=ag.id_grado
	WHERE pe.tipo='alumno';
                    
                    
SELECT * from alumnos_con_asignaturas;

DROP VIEW IF EXISTS alumnos_con_asignaturas;