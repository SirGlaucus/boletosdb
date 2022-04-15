-- Una línea aérea quiere implementar un sistema para la venta de boletos de avión
-- Cada boleto de avión cuesta 100 mil pesos

-- Cada vuelo de avión tiene:
-- 200 asientos
-- Nombre de Ruta
-- Horario de despegue y aterrizaje

-- Los pasajeros se registran con su RUT, nombre y apellido

-- Cada Boleto registra:
-- El vuelo del avión y el pasajero

CREATE DATABASE boletos_db;

CREATE TABLE pasajeros (
	rut VARCHAR (10) PRIMARY KEY,
	nombre VARCHAR(25), 
	apellido VARCHAR(25));

CREATE TABLE vuelos (
	id SERIAL PRIMARY KEY, 
	costo INT,
	asientos SMALLINT CHECK (asientos >= 0), 
	nombre_ruta VARCHAR(50), 
	hora_despegue TIME, 
	hora_aterrizaje TIME);

CREATE TABLE boletos (
	id SERIAL PRIMARY KEY, 
	pasajeros_rut_fk VARCHAR(10), 
	vuelos_fk INT, 
	FOREIGN KEY (pasajeros_rut_fk) REFERENCES pasajeros(rut), 
	FOREIGN KEY (vuelos_fk) REFERENCES vuelos(id));

-- Agregar 5 vuelos
-- Agregar 5 pasajeros
BEGIN TRANSACTION;
INSERT INTO pasajeros (rut, nombre, apellido) VALUES ('23456789-1', 'Josefa', 'Gutierrez');
INSERT INTO pasajeros (rut, nombre, apellido) VALUES ('34567890-2', 'Pablo', 'Smith');
INSERT INTO pasajeros (rut, nombre, apellido) VALUES ('11223345-3', 'Pedro', 'Kasparov');
INSERT INTO pasajeros (rut, nombre, apellido) VALUES ('90234567-4', 'Juan', 'Maestro');
INSERT INTO pasajeros (rut, nombre, apellido) VALUES ('87612345-5', 'Iskander', 'Martinez');
COMMIT;

BEGIN TRANSACTION;
INSERT INTO vuelos (costo, asientos, nombre_ruta, hora_despegue, hora_aterrizaje) VALUES (100000, 200, 'Alemania - Chile', '01:00:00', '11:00:00');
INSERT INTO vuelos (costo, asientos, nombre_ruta, hora_despegue, hora_aterrizaje) VALUES (100000, 200, 'Dinamarca - Brasil', '02:00:00', '13:00:00');
INSERT INTO vuelos (costo, asientos, nombre_ruta, hora_despegue, hora_aterrizaje) VALUES (100000, 200, 'Brasil - Marruecos', '03:00:00', '15:00:00');
INSERT INTO vuelos (costo, asientos, nombre_ruta, hora_despegue, hora_aterrizaje) VALUES (100000, 200, 'Marruecos - Papua Nueva Guinea', '17:00:00', '00:00:00');
INSERT INTO vuelos (costo, asientos, nombre_ruta, hora_despegue, hora_aterrizaje) VALUES (100000, 200, 'Papua Nueva Guinea - Chile', '04:00:00', '19:00:00');
COMMIT;


-- - Cada compra de vuelo debe restar 1 a los asientos disponibles en el avión
-- - Con transacción comprar un boleto (vuelo 1) a su nombre (pasajero 1)
BEGIN TRANSACTION;
INSERT INTO boletos (pasajeros_rut_fk, vuelos_fk) VALUES ('23456789-1', 1);
UPDATE vuelos SET asientos = asientos - 1 WHERE id = 1;
COMMIT;

-- - luego cambiar de vuelo (vuelo 3)
-- - mostrar que el vuelo inicial vuelva a quedar con la cantidad de asientos disponibles
BEGIN TRANSACTION
UPDATE boletos SET vuelos_fk = 3 WHERE id = 3;
UPDATE vuelos SET asientos = asientos + 1 WHERE id = 1;
UPDATE vuelos SET asientos = asientos - 1 WHERE id = 3;
SELECT * FROM vuelos;
COMMIT;

-- - comprar 5 vuelos más y mostrar el total que ha ganado la aerolínea
BEGIN TRANSACTION;
INSERT INTO boletos (pasajeros_rut_fk, vuelos_fk) VALUES ('34567890-2', 4);
UPDATE vuelos SET asientos = asientos - 1 WHERE id = 4;
COMMIT;

BEGIN TRANSACTION;
INSERT INTO boletos (pasajeros_rut_fk, vuelos_fk) VALUES ('11223345-3', 2);
UPDATE vuelos SET asientos = asientos - 1 WHERE id = 2;
COMMIT;

BEGIN TRANSACTION;
INSERT INTO boletos (pasajeros_rut_fk, vuelos_fk) VALUES ('11223345-3', 3);
UPDATE vuelos SET asientos = asientos - 1 WHERE id = 3;
COMMIT;

BEGIN TRANSACTION;
INSERT INTO boletos (pasajeros_rut_fk, vuelos_fk) VALUES ('87612345-5', 2);
UPDATE vuelos SET asientos = asientos - 1 WHERE id = 2;
COMMIT;

BEGIN TRANSACTION;
INSERT INTO boletos (pasajeros_rut_fk, vuelos_fk) VALUES ('90234567-4', 2);
UPDATE vuelos SET asientos = asientos - 1 WHERE id = 2;
COMMIT;

BEGIN TRANSACTION;
INSERT INTO boletos (pasajeros_rut_fk, vuelos_fk) VALUES ('90234567-4', 1);
UPDATE vuelos SET asientos = asientos - 1 WHERE id = 1;
COMMIT;

SELECT COUNT(id) * 100000 as ganancias FROM boletos;
SELECT SUM(vuelo.costo) as ganancias FROM (SELECT id, costo FROM vuelos) AS vuelo INNER JOIN boletos ON vuelo.id = boletos.vuelos_fk;

-- - mostrar que vuelo tiene más asientos disponibles

SELECT * FROM vuelos WHERE asientos = (SELECT MAX(asientos) FROM vuelos);

-- - mostrar que vuelo tiene menos asientos disponibles

SELECT * FROM vuelos WHERE asientos = (SELECT MIN(asientos) FROM vuelos);
