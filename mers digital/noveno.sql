CREATE DATABASE viajes
USE viajes

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Viaje (
    id_viaje INT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE Destino (
    id_destino INT PRIMARY KEY,
    nombre VARCHAR(100),
    país VARCHAR(100)
);

CREATE TABLE Guía (
    id_guía INT PRIMARY KEY,
    nombre VARCHAR(100),
    idioma VARCHAR(50)
);

CREATE TABLE Transporte (
    id_transporte INT PRIMARY KEY,
    tipo VARCHAR(50),
    capacidad INT
);

CREATE TABLE ReservaViaje (
    id_cliente INT,
    id_viaje INT,
    PRIMARY KEY (id_cliente, id_viaje),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_viaje) REFERENCES Viaje(id_viaje)
);

CREATE TABLE ViajeGuía (
    id_viaje INT,
    id_guía INT,
    PRIMARY KEY (id_viaje, id_guía),
    FOREIGN KEY (id_viaje) REFERENCES Viaje(id_viaje),
    FOREIGN KEY (id_guía) REFERENCES Guía(id_guía)
);

INSERT INTO Cliente VALUES (1, 'Carlos Jiménez', '3011234567');
INSERT INTO Cliente VALUES (2, 'Ana Morales', '3029876543');

INSERT INTO Viaje VALUES (1, 'Tour Europa', '2025-08-01', '2025-08-20');
INSERT INTO Viaje VALUES (2, 'Ruta Andina', '2025-09-05', '2025-09-15');

INSERT INTO Destino VALUES (1, 'París', 'Francia');
INSERT INTO Destino VALUES (2, 'Lima', 'Perú');

INSERT INTO Guía VALUES (1, 'Sofía Torres', 'Español');
INSERT INTO Guía VALUES (2, 'Luca Moretti', 'Italiano');

INSERT INTO Transporte VALUES (1, 'Bus', 50);
INSERT INTO Transporte VALUES (2, 'Avión', 180);

INSERT INTO ReservaViaje VALUES (1, 1);
INSERT INTO ReservaViaje VALUES (2, 2);

INSERT INTO ViajeGuía VALUES (1, 1);
INSERT INTO ViajeGuía VALUES (2, 2);

UPDATE Viaje SET nombre = 'Tour Europa Clásico' WHERE id_viaje = 1;
UPDATE Cliente SET telefono = '3005558888' WHERE id_cliente = 2;

DELETE FROM ViajeGuía WHERE id_viaje = 2 AND id_guía = 2;
DELETE FROM ReservaViaje WHERE id_cliente = 2 AND id_viaje = 2;

ALTER TABLE Cliente ADD correo VARCHAR(100);
ALTER TABLE Viaje ADD precio DECIMAL(10,2);

ALTER TABLE Guía ALTER COLUMN idioma VARCHAR(80);
ALTER TABLE Transporte ALTER COLUMN tipo VARCHAR(100);

ALTER TABLE Cliente DROP COLUMN correo;
ALTER TABLE Viaje DROP COLUMN precio;



-- Guías que hablan español
SELECT nombre FROM Guía
WHERE id_guía IN (
    SELECT id_guía FROM ViajeGuía
    WHERE id_viaje IN (
        SELECT id_viaje FROM Viaje
        WHERE MONTH(fecha_inicio) = 8
    )
);


-- Guías asignados a cada viaje
SELECT v.nombre AS viaje, g.nombre AS guía, g.idioma
FROM ViajeGuía vg
JOIN Viaje v ON vg.id_viaje = v.id_viaje
JOIN Guía g ON vg.id_guía = g.id_guía;

-- Promedio de capacidad de transportes
SELECT AVG(capacidad) AS promedio_capacidad FROM Transporte;
