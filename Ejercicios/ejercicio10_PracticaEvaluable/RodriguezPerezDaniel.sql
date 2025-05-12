--
-- Tabla categorias
--
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
  categoria SMALLINT UNSIGNED AUTO_INCREMENT,
  titulo VARCHAR(50) NOT NULL,
  salario INT UNSIGNED NOT NULL,
  trienio INT UNSIGNED,
  PRIMARY KEY (categoria),
  CONSTRAINT CK_salario_mayor_trienio CHECK (salario>trienio)
);

INSERT INTO categorias (categoria,titulo, salario, trienio) 
VALUES
(1, 'Director', 50000, 1000),
(2, 'Jefe Sección', 40000, 800),
(3, 'Administrativo', 35000, 700),
(4, 'Comercial', 35000, 700),
(5, 'Emp. Almacén', 25000, 500);

--
-- CLAVES FORÁNEAS
--
       
-- EMPLEADOS (codigo) -> DPTOFICINAS (codigo)
ALTER TABLE empleados
ADD CONSTRAINT FK_empleados_codigo_dptoficinas_codigo
FOREIGN KEY (codigo) REFERENCES dptoficinas(codigo);

-- EMPLEADO (categoria) -> CATEGORIAS (categoria)
ALTER TABLE empleados
ADD CONSTRAINT FK_empleados_categoria_categorias_categoria
FOREIGN KEY (categoria) REFERENCES categorias(categoria);

-- DPTOFICINAS (oficina) -> OFICINAS (oficina)
ALTER TABLE dptoficinas
ADD CONSTRAINT FK_dptoficinas_posicion_posiciones_posicion
FOREIGN KEY (oficina) REFERENCES oficinas(oficina);

-- DPTOFICINAS (deptno) -> DEPARTAMENTOS (deptno)
ALTER TABLE dptoficinas
ADD CONSTRAINT FK_dptoficinas_deptno_departamentos
FOREIGN KEY (deptno) REFERENCES departamentos(deptno);

--
-- CONSULTAS
--


-- o Muestre el nombre, la edad y la fecha de los empleados que tengan más
-- de 50 años o que entraron en la empresa antes del año 2002.
SELECT nombre, fecha_contrato, edad FROM empleados
WHERE (edad>50) OR (YEAR(fecha_contrato)<2002);

-- o Cuenta cuantos empleados hay en la empresa que tienen entre 30 y 40
-- años.
SELECT COUNT(*) FROM empleados
WHERE edad BETWEEN 30 AND 40;
-- o Muestra el nombre de los empleados la edad, la fecha_contrato junto
-- con el salario y el trienio que le corresponde.
SELECT nombre, fecha_contrato, c.salario, trienio FROM empleados e 
JOIN categorias c ON e.categoria=c.categoria;
-- o Realiza una consulta que muestre cuantos empleados hay en cada
-- categoría, mostrando además la suma de salarios. Ordénala por el
-- número de empleados descendente.
SELECT c.titulo, SUM(c.salario) FROM categorias c 
JOIN empleados e ON c.categoria=e.categoria
GROUP BY c.categoria
ORDER BY COUNT(e.nombre) DESC;
-- o Actualiza el sueldo y el trienio de los directores y jefes de sección en un
-- 2.5%.
UPDATE categorias
SET salario=salario*1.025, trienio=trienio*1.025
WHERE titulo='Director' OR titulo='Jefe Sección';
-- o Crea una consulta que muestre el nombre y la edad de cada empleado
-- junto con su categoría (título), su salario, el trienio, la suma del salario y
-- trienio en orden descendente por salario y ascendente por nombre.
SELECT e.nombre, c.titulo, c.salario, c.trienio, (c.salario+c.trienio) "SUMA Salario y Trienio" FROM empleados e
JOIN categorias c ON e.categoria=c.categoria
ORDER BY c.salario DESC, e.nombre;
-- o Muestra el nombre de los departamentos, los números de teléfono de
-- sus oficinas, la ciudad en la que se ubican de aquellas oficinas que se
-- encuentran en la zona Este.
SELECT d.nombre, dof.telefono, o.ciudad FROM departamentos d
JOIN dptoficinas dof ON d.deptno=dof.deptno
JOIN oficinas o ON o.oficina=dof.oficina
WHERE region='Este';