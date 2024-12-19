-- Creamos la base de datos
CREATE DATABASE IF NOT EXISTS empresa
CHARACTER SET latin1
COLLATE latin1_spanish_ci;

-- Usamos la base de datos
USE empresa;

-- Creamos la tabla EMPLEADOS
CREATE TABLE IF NOT EXISTS empleados (
    dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(10) NOT NULL,
    apellido1 VARCHAR(15) NOT NULL,
    apellido2 VARCHAR(15),
    direcc1 VARCHAR(25) NOT NULL,
    direcc2 VARCHAR(20),
    ciudad VARCHAR(20) NOT NULL,
    provincia VARCHAR(20) NOT NULL,
    cod_postal CHAR(5) NOT NULL,
    sexo CHAR(1) NOT NULL,
    fecha_nac DATE NOT NULL,
    CONSTRAINT CK_EMPLEADOS_SEXO CHECK (sexo IN ('H', 'M'))
);

-- Creamos la tabla DEPARTAMENTOS
CREATE TABLE IF NOT EXISTS departamentos (
    dpto_cod SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_dpto VARCHAR(30) NOT NULL,
    dpto_padre SMALLINT UNSIGNED DEFAULT NULL,
    presupuesto FLOAT NOT NULL,
    pres_actual FLOAT NOT NULL
);

-- Creamos la tabla ESTUDIOS
CREATE TABLE IF NOT EXISTS estudios (
    empleado_dni CHAR(9) PRIMARY KEY,
    universidad SMALLINT UNSIGNED NOT NULL,
    año YEAR NOT NULL,
    grado VARCHAR(3) UNIQUE NOT NULL,
    especialidad VARCHAR(20) NOT NULL
);

-- Creamos la tabla HISTORIAL_LABORAL
CREATE TABLE IF NOT EXISTS historial_laboral (
    empleado_dni CHAR(9),
    trabajo_cod SMALLINT UNSIGNED,
    fecha_inicio DATE,
    fecha_fin DATE NOT NULL,
    dpto_cod SMALLINT UNSIGNED NOT NULL,
    supervisor_dni CHAR(9),
    PRIMARY KEY (empleado_dni, trabajo_cod)
);

-- Creamos la tabla HISTORIAL_SALARIAL
CREATE TABLE IF NOT EXISTS historial_salarial (
    empleado_dni CHAR(9),
    salario FLOAT NOT NULL,
    fecha_comienzo DATE,
    fecha_fin DATE NOT NULL,
    PRIMARY KEY (empleado_dni, fecha_comienzo)
);

-- Creamos la tabla UNIVERSIDADES
CREATE TABLE IF NOT EXISTS universidades (
    univ_cod SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_univ VARCHAR(25) NOT NULL,
    ciudad VARCHAR(20) NOT NULL,
    municipio VARCHAR(20) NOT NULL,
    cod_postal CHAR(5) NOT NULL
);

-- Creamos la tabla TRABAJOS
CREATE TABLE IF NOT EXISTS trabajos (
    trabajo_cod SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_trab VARCHAR(20) NOT NULL,
    salario_min FLOAT NOT NULL,
    salario_max FLOAT NOT NULL
);

-- Añadimos las claves foráneas con ALTER TABLE

-- HISTORIAL_LABORAL (EMPLEADO_DNI) -> EMPLEADOS (DNI)
ALTER TABLE historial_laboral
ADD CONSTRAINT FK_historiallaboral_empleados_empleadodni
FOREIGN KEY (empleado_dni) REFERENCES empleados(dni);

-- HISTORIAL_LABORAL (SUPERVISOR_DNI) -> EMPLEADOS (DNI)
ALTER TABLE historial_laboral
ADD CONSTRAINT FK_historiallaboral_empleados_supervisordni
FOREIGN KEY (supervisor_dni) REFERENCES empleados(dni);

-- HISTORIAL_LABORAL (DPTO_COD) -> DEPARTAMENTOS (DPTO_COD)
ALTER TABLE historial_laboral
ADD CONSTRAINT FK_historiallaboral_departamentos_dptocod
FOREIGN KEY (dpto_cod) REFERENCES departamentos(dpto_cod);

-- HISTORIAL_LABORAL (TRABAJO_COD) -> TRABAJOS (TRABAJO_COD)
ALTER TABLE historial_laboral
ADD CONSTRAINT FK_historiallaboral_trabajos_trabajocod
FOREIGN KEY (trabajo_cod) REFERENCES trabajos(trabajo_cod);

-- HISTORIAL_SALARIAL (EMPLEADO_DNI) -> EMPLEADOS (DNI)
ALTER TABLE historial_salarial
ADD CONSTRAINT FK_historialsalarial_empleados_empleadodni
FOREIGN KEY (empleado_dni) REFERENCES empleados(dni);

-- ESTUDIOS (EMPLEADO_DNI) -> EMPLEADOS (DNI)
ALTER TABLE estudios
ADD CONSTRAINT FK_estudios_empleados_empleadodni
FOREIGN KEY (empleado_dni) REFERENCES empleados(dni);

-- ESTUDIOS (UNIVERSIDAD) -> UNIVERSIDADES (UNIV_COD)
ALTER TABLE estudios
ADD CONSTRAINT FK_estudios_universidades_univcod
FOREIGN KEY (universidad) REFERENCES universidades(univ_cod);

-- DEPARTAMENTOS (DPTO_PADRE) -> DEPARTAMENTOS (DPTO_COD)
ALTER TABLE departamentos
ADD CONSTRAINT FK_departamentos_departamentos_dptocod
FOREIGN KEY (dpto_padre) REFERENCES departamentos(dpto_cod);
