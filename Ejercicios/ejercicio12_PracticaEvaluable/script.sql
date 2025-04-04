CREATE USER 'rodriguez'@'localhost' IDENTIFIED BY 'letmein';
CREATE USER 'rodriguezconsultas'@'localhost' IDENTIFIED BY 'letmein';
CREATE USER 'rodriguezdml'@'localhost' IDENTIFIED BY 'letmein';

-- Permisos user: rodriguez
GRANT ALL PRIVILEGES ON jardineria.* TO 'rodriguez'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- Pruebas con usuario rodriguez
SELECT * FROM jardineria.clientes;


SHOW DATABASES; -- ERROR

INSERT INTO jardineria.

UPDATE jardineria.


-- Permisos user: rodriguezconsultas
GRANT SELECT ON jardineria.clientes TO 'rodriguezconsultas'@'localhost';
FLUSH PRIVILEGES;
GRANT INSERT, SELECT ON tienda.* TO 'rodriguezconsultas'@'localhost';


-- Permisos user: rodriguezdml
GRANT SELECT, INSERT, UPDATE, DELETE ON jardineria.* TO 'rodriguezdml'@'localhost';
FLUSH PRIVILEGES;


-- Pruebas con usuario rodriguezconsultas
SHOW TABLES FROM jardineria;
INSERT INTO jardineria.clientes


-- Pruebas con usuario rodriguezdml
DELETE FROM jardineria.clientes WHERE nombreCliente = 'NaturaJardin';
GRANT DELETE ON jardineria.clientes TO 'rodriguezconsultas'@'localhost'; -- ERROR