-- Creamos la base de datos Pubs
CREATE DATABASE IF NOT EXISTS pubs;

-- Usamos la base de datos
USE pubs;

-- Creamos la tabla LOCALIDAD
CREATE TABLE IF NOT EXISTS localidad (
  cod_localidad SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL
);

-- Creamos la tabla EMPLEADO
CREATE TABLE IF NOT EXISTS empleado(
  dni_empleado CHAR(9) PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  domicilio VARCHAR(50) NOT NULL
);

-- Creamos la tabla PUB
CREATE TABLE IF NOT EXISTS pub(
  cod_pub SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  licencia_fiscal CHAR(9) NOT NULL,
  domicilio VARCHAR(50) NOT NULL,
  fecha_apertura DATE NOT NULL,
  horario VARCHAR(20) CHECK( horario IN ('mañanas','tardes','noches')),
  cod_localidad 
);

-- Creamos la tabla TITULAR

-- Creamos la tabla EXISTENCIAS

-- Creamos la tabla PUB_EMPLEADO
