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
CREATE TABLE IF NOT EXISTS empleado (
  dni_empleado CHAR(9) PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  domicilio VARCHAR(50)
);

-- Creamos la tabla PUB
CREATE TABLE IF NOT EXISTS pub (
  cod_pub SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  licencia_fiscal CHAR(9) NOT NULL,
  domicilio VARCHAR(50),
  fecha_apertura DATE NOT NULL,
  horario ENUM('mañanas', 'tardes', 'noches') NOT NULL,
  cod_localidad SMALLINT UNSIGNED,
  FOREIGN KEY (cod_localidad) REFERENCES localidad(cod_localidad)
);

-- Creamos la tabla TITULAR
CREATE TABLE IF NOT EXISTS titular (
  dni_titular CHAR(9) PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  domicilio VARCHAR(50),
  cod_pub SMALLINT UNSIGNED NOT NULL,
  FOREIGN KEY (cod_pub) REFERENCES pub(cod_pub)
);

-- Creamos la tabla EXISTENCIAS
CREATE TABLE IF NOT EXISTS existencias (
  cod_articulo SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  cantidad INT UNSIGNED NOT NULL,
  precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),
  cod_pub SMALLINT UNSIGNED NOT NULL,
  FOREIGN KEY (cod_pub) REFERENCES pub(cod_pub)
);

-- Creamos la tabla PUB_EMPLEADO
CREATE TABLE IF NOT EXISTS pub_empleado (
  cod_pub SMALLINT UNSIGNED NOT NULL,
  dni_empleado CHAR(9) NOT NULL,
  funcion ENUM('CAMARERO', 'SEGURIDAD', 'LIMPIEZA') NOT NULL,
  PRIMARY KEY (cod_pub, dni_empleado, funcion),
  FOREIGN KEY (cod_pub) REFERENCES pub(cod_pub),
  FOREIGN KEY (dni_empleado) REFERENCES empleado(dni_empleado)
);
