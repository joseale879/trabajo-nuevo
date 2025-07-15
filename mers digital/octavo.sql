CREATE DATABASE transporte
USE transporte

CREATE TABLE Pasajero (
    id_pasajero INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Ruta (
    id_ruta INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Bus (
    id_bus INT PRIMARY KEY,
    placa VARCHAR(20),
    capacidad INT
);

CREATE TABLE Parada (
    id_parada INT PRIMARY KEY,
    nombre VARCHAR(100),
    ubicacion VARCHAR(200)
);

CREATE TABLE Boleto (
    id_boleto INT PRIMARY KEY,
    id_pasajero INT,
    fecha DATE,
    FOREIGN KEY (id_pasajero) REFERENCES Pasajero(id_pasajero)
);

CREATE TABLE RutaParada (
    id_ruta INT,
    id_parada INT,
    orden INT,
    PRIMARY KEY (id_ruta, id_parada),
    FOREIGN KEY (id_ruta) REFERENCES Ruta(id_ruta),
    FOREIGN KEY (id_parada) REFERENCES Parada(id_parada)
);

CREATE TABLE BoletoRuta (
    id_boleto INT,
    id_ruta INT,
    PRIMARY KEY (id_boleto, id_ruta),
    FOREIGN KEY (id_boleto) REFERENCES Boleto(id_boleto),
    FOREIGN KEY (id_ruta) REFERENCES Ruta(id_ruta)
);

INSERT INTO Pasajero VALUES (1, 'Andrés García');
INSERT INTO Pasajero VALUES (2, 'Lucía Pérez');

INSERT INTO Ruta VALUES (1, 'Ruta Norte');
INSERT INTO Ruta VALUES (2, 'Ruta Sur');

INSERT INTO Bus VALUES (1, 'ABC123', 45);
INSERT INTO Bus VALUES (2, 'XYZ789', 30);

INSERT INTO Parada VALUES (1, 'Parque Central', 'Cra 10 #20-30');
INSERT INTO Parada VALUES (2, 'Terminal Norte', 'Av 1 #50-60');

INSERT INTO Boleto VALUES (1, 1, '2025-07-08');
INSERT INTO Boleto VALUES (2, 2, '2025-07-09');

INSERT INTO RutaParada VALUES (1, 1, 1);
INSERT INTO RutaParada VALUES (1, 2, 2);

INSERT INTO BoletoRuta VALUES (1, 1);
INSERT INTO BoletoRuta VALUES (2, 2);

UPDATE Ruta SET nombre = 'Ruta Norte Exprés' WHERE id_ruta = 1;
UPDATE Bus SET capacidad = 50 WHERE id_bus = 2;

DELETE FROM BoletoRuta WHERE id_boleto = 2 AND id_ruta = 2;
DELETE FROM RutaParada WHERE id_ruta = 1 AND id_parada = 2;

ALTER TABLE Bus ADD tipo VARCHAR(50);
ALTER TABLE Boleto ADD precio DECIMAL(8,2);

ALTER TABLE Ruta ALTER COLUMN nombre VARCHAR(150);
ALTER TABLE Parada ALTER COLUMN ubicacion VARCHAR(250);

ALTER TABLE Boleto DROP COLUMN precio;
ALTER TABLE Bus DROP COLUMN tipo;


-- Rutas con paradas ubicadas en la 'Cra 10'
SELECT nombre FROM Ruta
WHERE id_ruta IN (
    SELECT id_ruta FROM RutaParada
    WHERE id_parada IN (
        SELECT id_parada FROM Parada
        WHERE ubicacion LIKE '%Cra 10%'
    )
);

-- Detalles de boletos por pasajero y ruta
SELECT p.nombre AS pasajero, r.nombre AS ruta, b.fecha
FROM Boleto b
JOIN Pasajero p ON b.id_pasajero = p.id_pasajero
JOIN BoletoRuta br ON b.id_boleto = br.id_boleto
JOIN Ruta r ON br.id_ruta = r.id_ruta;

-- Capacidad promedio de buses
SELECT AVG(capacidad) AS capacidad_promedio FROM Bus;
