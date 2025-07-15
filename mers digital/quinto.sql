CREATE DATABASE eventos 
USE eventos

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100)
);

CREATE TABLE Evento (
    id_evento INT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha DATE,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Lugar (
    id_lugar INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(200)
);

CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(100),
    servicio_ofrecido VARCHAR(100)
);

CREATE TABLE Servicio (
    id_servicio INT PRIMARY KEY,
    nombre VARCHAR(100),
    costo DECIMAL(8,2)
);

CREATE TABLE ContratoProveedor (
    id_evento INT,
    id_proveedor INT,
    PRIMARY KEY (id_evento, id_proveedor),
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

CREATE TABLE ParticipanteEvento (
    id_evento INT,
    id_cliente INT,
    PRIMARY KEY (id_evento, id_cliente),
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

INSERT INTO Cliente VALUES (1, 'Sofía Márquez', 'sofia@eventos.com');
INSERT INTO Cliente VALUES (2, 'Carlos Niño', 'carlos@eventos.com');

INSERT INTO Evento VALUES (1, 'Boda Real', '2025-09-15', 1);
INSERT INTO Evento VALUES (2, 'Concierto Rock', '2025-10-20', 2);

INSERT INTO Lugar VALUES (1, 'Salón Dorado', 'Cra 10 #12-34');
INSERT INTO Lugar VALUES (2, 'Auditorio Central', 'Av. 5 #45-20');

INSERT INTO Proveedor VALUES (1, 'Sonido Plus', 'Audio');
INSERT INTO Proveedor VALUES (2, 'Catering Express', 'Catering');

INSERT INTO Servicio VALUES (1, 'DJ Profesional', 150000.00);
INSERT INTO Servicio VALUES (2, 'Buffet Internacional', 300000.00);

INSERT INTO ContratoProveedor VALUES (1, 1);
INSERT INTO ContratoProveedor VALUES (2, 2);

INSERT INTO ParticipanteEvento VALUES (1, 2);
INSERT INTO ParticipanteEvento VALUES (2, 1);

UPDATE Evento SET nombre = 'Boda Real de Sofía' WHERE id_evento = 1;
UPDATE Proveedor SET servicio_ofrecido = 'Banquetes' WHERE id_proveedor = 2;

DELETE FROM ParticipanteEvento WHERE id_evento = 2 AND id_cliente = 1;
DELETE FROM ContratoProveedor WHERE id_evento = 1 AND id_proveedor = 1;

ALTER TABLE Cliente ADD telefono VARCHAR(20);
ALTER TABLE Evento ADD descripcion TEXT;

ALTER TABLE Proveedor ALTER COLUMN nombre VARCHAR(150);
ALTER TABLE Lugar ALTER COLUMN direccion VARCHAR(250);

ALTER TABLE Cliente DROP COLUMN telefono;
ALTER TABLE Evento DROP COLUMN descripcion;



-- Costo máximo de servicios
SELECT MAX(costo) AS costo_mas_alto FROM Servicio;

-- Promedio de costo de servicios
SELECT AVG(costo) AS promedio_costo FROM Servicio;

-- Eventos con más de un proveedor
SELECT nombre FROM Evento
WHERE id_evento IN (
    SELECT id_evento
    FROM ContratoProveedor
    GROUP BY id_evento
    HAVING COUNT(*) > 1
);

-- Eventos y nombre del cliente organizador
SELECT e.nombre AS evento, c.nombre AS organizador, e.fecha
FROM Evento e
JOIN Cliente c ON e.id_cliente = c.id_cliente;
