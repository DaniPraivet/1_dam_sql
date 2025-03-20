DROP DATABASE IF EXISTS vendedores;
CREATE DATABASE vendedores character set latin1 collate latin1_spanish_Ci;
use vendedores;

--
-- Tabla oficinas
--
DROP TABLE IF EXISTS oficinas;

CREATE TABLE oficinas (
  oficina smallint unsigned NOT NULL AUTO_INCREMENT,
  ciudad varchar(30),
  region varchar(30),
  PRIMARY KEY (oficina)
);

--
-- Tabla dptoficinas
--
DROP TABLE IF EXISTS dptoficinas;

CREATE TABLE dptoficinas (
  codigo smallint unsigned NOT NULL AUTO_INCREMENT,
  oficina smallint unsigned,
  deptno smallint unsigned,
  telefono char(9),
  PRIMARY KEY (codigo)
);

--
-- Tabla departamentos
--
DROP TABLE IF EXISTS departamentos;

CREATE TABLE departamentos (
  deptno smallint unsigned NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  PRIMARY KEY (deptno)
);



--
-- Tabla empleados
--
DROP TABLE IF EXISTS empleados;

CREATE TABLE empleados (
  num smallint unsigned NOT NULL AUTO_INCREMENT,
  nombre varchar(30),
  edad int unsigned,
  codigo smallint unsigned,
  categoria smallint unsigned,
  fecha_contrato date,
  PRIMARY KEY (num)
);

--
-- Tabla posiciones
--

DROP TABLE IF EXISTS posiciones;

CREATE TABLE posiciones (
	id_posicion SMALLINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(50) NOT NULL,
    sueldo_base INT UNSIGNED NOT NULL,
	complemento INT UNSIGNED,
    CONSTRAINT CK_sueldobase_mayor_complemento CHECK (sueldo_base>complemento)
);

insert into oficinas(oficina, ciudad, region)
values (11, 'Valencia', 'Este'),
       (12, 'Barcelona', 'Este'),
       (13, 'Alicante', 'Este'),
       (21, 'Madrid', 'Centro'),
       (22, 'Toledo', 'Centro');

insert into departamentos(deptno,nombre)
values (1, 'Dirección'),
       (2, 'Administración'),
       (3, 'Comercial'),
       (4, 'Almacén'),
       (5, 'Informática');

insert into dptoficinas( codigo, oficina,deptno, telefono)
values (100, 11, 1, '963981000'),
       (101, 11, 2, '963981100'),
       (102, 11, 3, '963981200'),
       (103, 11, 4, '963981300'),
       (104, 11, 5, '963981400'),
       (105, 12, 2, '933551000'),
       (106, 12, 3, '933551100'),
       (107, 12, 4, '933551200'),
       (108, 13, 3, '961671000'),
       (109, 21, 2, '913641000'),
       (110, 21, 3, '913641100'),
       (111, 21, 4, '913641200'),
       (112, 22, 3, '925871000');

insert into empleados (num, nombre, edad, codigo, categoria, fecha_contrato)
values 
       (1000, 'Antonio Gutierrez', 45, 100, 1, str_to_date('12/01/1999','%d/%m/%Y')),
       (1001, 'Paloma Blanco', 56, 100, 2, str_to_date('17/03/2002','%d/%m/%Y')),
       (1002, 'Antonio Pazos', 52, 100, 3, str_to_date('14/03/1996','%d/%m/%Y')),
       (1003, 'Ana Garcia', 27, 101, 2, str_to_date('23/10/2015','%d/%m/%Y')),
       (1006, 'Nieves Soler', 25, 105, 2, str_to_date('13/03/2006','%d/%m/%Y')),
       (1007, 'Juan Jose Velasco', 34, 105, 3, str_to_date('14/02/2012','%d/%m/%Y')),
       (1008, 'Isidro Perez', 22, 109, 2, str_to_date('06/05/2010','%d/%m/%Y')),
       (1009, 'Ignacio Lopez', 38, 109, 3, str_to_date('07/04/2000','%d/%m/%Y')),
       (1010, 'Vicente Salvador', 29, 109, 3, str_to_date('08/07/2005','%d/%m/%Y')),
       (1011, 'Carmen Hernandez', 44, 102, 2, str_to_date('16/07/2000','%d/%m/%Y')),
       (1012, 'Juan Pons', 50, 102, 4, str_to_date('14/04/2008','%d/%m/%Y')),
       (1013, 'Pedro Fernandez', 23, 102, 4, str_to_date('16/09/2009','%d/%m/%Y')),
       (1014, 'Silvia Blasco', 33, 102, 4, str_to_date('23/02/2014','%d/%m/%Y')),
       (1015, 'Jose Alegre', 26, 106, 2, str_to_date('26/08/2007','%d/%m/%Y')),
       (1016, 'Cristina Prats', 46, 106, 4, str_to_date('18/11/2004','%d/%m/%Y')),
       (1017, 'Carlos Gimenez', 35, 106, 4, str_to_date('15/05/2005','%d/%m/%Y')),
       (1018, 'Maria Gonzalez', 37, 108, 4, str_to_date('16/06/2006','%d/%m/%Y')),
       (1019, 'Manuel Torres', 24, 108, 4, str_to_date('19/01/2008','%d/%m/%Y')),
       (1020, 'Jose Perez', 28, 110, 2, str_to_date('22/03/2011','%d/%m/%Y')),
       (1021, 'Alejandro Martos', 34, 110, 4, str_to_date('17/10/2004','%d/%m/%Y')),
       (1022, 'Veronica Muelas', 25, 110, 4, str_to_date('05/07/2007','%d/%m/%Y')),
       (1023, 'Elena Lopez', 29, 112, 4, str_to_date('09/07/2004','%d/%m/%Y')),
       (1024, 'Isabel Fernandez', 22, 112, 4, str_to_date('12/10/2010','%d/%m/%Y')),
       (1025, 'Jose Mujica', 49, 103, 2, str_to_date('04/09/1997','%d/%m/%Y')),
       (1026, 'Pedro Bledos', 26, 103, 5, str_to_date('06/02/2008','%d/%m/%Y')),
       (1027, 'Pablo Costas', 35, 107, 5, str_to_date('03/07/2005','%d/%m/%Y')),
       (1028, 'Ester Castro', 27, 111, 2, str_to_date('18/07/2006','%d/%m/%Y')),
       (1029, 'Gregorio Mas', 33, 111, 5, str_to_date('14/03/2007','%d/%m/%Y')),
       (1030, 'Jose Medina', 34, 104, 2, str_to_date('14/06/2005','%d/%m/%Y')),
       (1031, 'Maria Utrillas', 27, 104, 3, str_to_date('19/08/2007','%d/%m/%Y')),
       (1032, 'Marina Gilabert', 24, 104, 3, str_to_date('01/12/2008','%d/%m/%Y'));
       
INSERT INTO posiciones (id_posicion, titulo, sueldo_base, complemento) 
VALUES
(1, 'Genrente', 55000, 1200),
(2, 'Supervisor', 42000, 900),
(3, 'Analista', 38000, 750),
(2, 'Supervisor', 32000, 600),
(1, 'Genrente', 26000, 500);

--
-- CLAVES FORÁNEAS
--

-- EMPLEADO (codigo) -> DPTOFICINAS (codigo)
ALTER TABLE empleado
ADD CONSTRAINT FK_empleado_codigo_dptoficinas_codigo
FOREIGN KEY (codigo) REFERENCES dptoficinas(codigo);

-- EMPLEADO (posicion) -> POSICIONES (id_posicion)
ALTER TABLE empleado
ADD CONSTRAINT FK_empleado_posicion_posiciones_posicion
FOREIGN KEY (posicion) REFERENCES posiciones(id_posicion);

-- DPTOFICINAS (oficina) -> OFICINAS (oficina)
ALTER TABLE dptoficinas
ADD CONSTRAINT FK_dptoficinas_posicion_posiciones_posicion
FOREIGN KEY (oficina) REFERENCES oficinas(oficina);

-- DPTOFICINAS (deptno) -> DEPARTAMENTOS (deptno) 
       