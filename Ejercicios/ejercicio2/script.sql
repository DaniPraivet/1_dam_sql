-- Creamos la base de datos
CREATE DATABASE empresa
CHARACTER SET latin1
COLLATE latin1_spanish_ci;

-- Usamos la base de datos
USE empresa;

-- Creamos la tabla EMPLEADOS
CREATE TABLE empleados(
dni CHAR(9) PRIMARY KEY,
nombre VARCHAR(10) NOT NULL,
apellido1 VARCHAR(15) NOT NULL,
apellido2 VARCHAR(15),
direcc1 VARCHAR(25) NOT NULL,
direcc2 VARCHAR(20),
ciudad VARCHAR(20) NOT NULL,
provincia VARCHAR(20) NOT NULL,
cod_postal CHAR(5) NOT NULL,
SEXO CHAR(1) NOT NULL,
FECHA_NAC DATE() NOT NULL,
CONSTRAINT CK_EMPLEADOS_SEXO CHECK (SEXO IN('H','M'))
);

-- Creamos la tabla DEPARTAMENTOS
CREATE TABLE departamentos(
dpto_cod SMALLINT() UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre_dpto VARCHAR(30) NOT NULL,
dpto_padre SMALLINT

);
