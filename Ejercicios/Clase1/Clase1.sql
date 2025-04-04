-- Creamos la tabla prueba
create database prueba character set latin1 collate latin1_spanish_ci;

-- Usamos la base de datos
use prueba;


-- Creamos la tabla producto
create table producto (
cod_producto SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(255) NOT NULL,
precio FLOAT NOT NULL CHECK(precio>0),
cantidad_stock SMALLINT UNSIGNED NOT NULL,
descripcion VARCHAR(255),
fecha_alta DATE
);

-- Mostramos los datos de la tabla
DESCRIBE producto;

-- Creamos la tabla cliente
create table cliente (
dni CHAR(9) PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido1 VARCHAR(30) NOT NULL,
apellido2 VARCHAR(30),
direccion VARCHAR(50),
tlf CHAR(9),
nombre_usuario VARCHAR(20) unique
);

-- Mostramos la tabla cliente
DESCRIBE cliente;

-- Creamos la tabla albarán
create table albaran (
num_albaran SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
fecha DATE NOT NULL,
dni_cliente CHAR(9) NOT NULL REFERENCES CLIENTE(dni)
);

-- Mostramos la tabla albarán
DESCRIBE albaran;



-- Creamos la tabla linea_detalle
create table linea_detalle (
num_albaran SMALLINT UNSIGNED, 
num_linea TINYINT UNSIGNED,
cod_producto SMALLINT UNSIGNED NOT NULL REFERENCES PRODUCTO(cod_producto),
cantidad TINYINT UNSIGNED CHECK(cantidad>0),
PRIMARY KEY(num_albaran,num_linea),
FOREIGN KEY(num_albaran) REFERENCES albaran(num_albaran)
);

-- Una manera más larga pero más descriptiva de las FK (Claves Foráneas) sería así
-- CONSTRAINT FK_linea_detalle_albaran_numalbaran

-- Mostramos la tabla linea_detalle
DESCRIBE linea_detalle;


-- Mostramos las tablas en uso de nuestra base de datos
SHOW TABLES;