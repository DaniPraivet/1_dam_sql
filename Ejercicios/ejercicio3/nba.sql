CREATE DATABASE IF NOT EXISTS nba
CHARACTER SET latin1
COLLATE latin1_spanish_ci;

USE nba;

CREATE TABLE IF NOT EXISTS equipos (
nombre VARCHAR(20) PRIMARY KEY,
ciudad VARCHAR(20) NOT NULL,
conferencia ENUM('Este', 'Oeste') NOT NULL,
division VARCHAR(9)
);

CREATE TABLE IF NOT EXISTS partidos (
codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
equipo_local VARCHAR(20) NOT NULL,
equipo_visitante VARCHAR(20) NOT NULL,
puntos_local SMALLINT UNSIGNED NOT NULL,
puntos_visitante SMALLINT UNSIGNED NOT NULL,
temporada VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS jugadores (
codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
altura FLOAT NOT NULL,
peso INT NOT NULL,
posicion VARCHAR(5) NOT NULL,
nombre_equipo VARCHAR(20),
CONSTRAINT CK_jugadores_altura_positiva
CHECK(altura>=0),
CONSTRAINT CK_jugadores_peso_positivo
CHECK(peso>=0)
);

CREATE TABLE IF NOT EXISTS estadisticas (
temporada VARCHAR(5) NOT NULL,
jugador INT UNSIGNED NOT NULL,
puntos_por_partido FLOAT DEFAULT '0',
asistencias_por_partido FLOAT DEFAULT '0',
tapones_por_partido FLOAT DEFAULT '0',
rebotes_por_partido FLOAT DEFAULT '0',
PRIMARY KEY (temporada,jugador)
);

-- Comprobamos que los siguientes valores sean positivos
ALTER TABLE estadisticas
ADD CONSTRAINT CK_estadisticas_puntos_positivo
CHECK(puntos_por_partido>=0),
ADD CONSTRAINT CK_estadisticas_asistencias_positivo
CHECK(asistencias_por_partido>=0),
ADD CONSTRAINT CK_estadisticas_tapones_positivo
CHECK(tapones_por_partido>=0),
ADD CONSTRAINT CK_estadisticas_rebotes_positivo
CHECK(rebotes_por_partido>=0);

-- Relaciones

-- JUGADORES(nombre_equipo) -> EQUPOS(nombre)
ALTER TABLE jugadores
ADD CONSTRAINT FK_jugadores_nombreequipo_nombre
FOREIGN KEY (nombre_equipo) REFERENCES equipos(nombre);
-- PARTIDOS(equipo_local) -> EQUIPOS(nombre)
ALTER TABLE partidos
ADD CONSTRAINT FK_partidos_equipolocal_nombre
FOREIGN KEY (equipo_local) REFERENCES equipos(nombre);
-- PARTIDOS(equipo_visitante) -> EQUIPOS(nombre)
ALTER TABLE partidos
ADD CONSTRAINT FK_partidos_equipovisitante_nombre
FOREIGN KEY (equipo_visitante) REFERENCES equipos(nombre);
-- ESTADISTICAS(jugador) -> JUGADORES(codigo)
ALTER TABLE estadisticas
ADD CONSTRAINT FK_estadisticas_jugador_jugador
FOREIGN KEY (jugador) REFERENCES jugadores(codigo);

-- Insertamos datos
USE NBA;
INSERT INTO jugadores (nombre,altura,peso,posicion,nombre_equipo)
VALUES ('Andres', 174, 63, 'Alero','Celtics'),
       ('Alvaro', 192, 65, 'Base','Celtics');
       
-- Consultas
USE NBA;
SELECT * FROM jugadores;       
