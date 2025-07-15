CREATE DATABASE Gimnacio
use Gimnasio

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT
);

CREATE TABLE Entrenador (
    id_entrenador INT PRIMARY KEY,
    nombre VARCHAR(100),
    especialidad VARCHAR(100)
);

CREATE TABLE Plann (
    id_plan INT PRIMARY KEY,
    nombre VARCHAR(50),
    duracion_meses INT,
    precio DECIMAL(8,2)
);

CREATE TABLE Clase (
    id_clase INT PRIMARY KEY,
    nombre VARCHAR(100),
    cupo_maximo INT
);

CREATE TABLE Horario (
    id_horario INT PRIMARY KEY,
    dia VARCHAR(20),
    hora_inicio TIME,
    hora_fin TIME
);

CREATE TABLE InscripciónClase (
    id_cliente INT,
    id_clase INT,
    fecha_inscripcion DATE,
    PRIMARY KEY (id_cliente, id_clase),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_clase) REFERENCES Clase(id_clase)
);

CREATE TABLE EntrenadorClase (
    id_entrenador INT,
    id_clase INT,
    PRIMARY KEY (id_entrenador, id_clase),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenador(id_entrenador),
    FOREIGN KEY (id_clase) REFERENCES Clase(id_clase)
);


INSERT INTO Cliente VALUES (1, 'Laura Pérez', 28);
INSERT INTO Cliente VALUES (2, 'Diego Gómez', 35);

INSERT INTO Entrenador VALUES (1, 'Ana Torres', 'Yoga');
INSERT INTO Entrenador VALUES (2, 'Juan Ruiz', 'Pesas');

INSERT INTO Plann VALUES (1, 'Mensual', 1, 120000.00);
INSERT INTO Plann VALUES (2, 'Trimestral', 3, 320000.00);

INSERT INTO Clase VALUES (1, 'Yoga Avanzado', 15);
INSERT INTO Clase VALUES (2, 'CrossFit', 20);

INSERT INTO Horario VALUES (1, 'Lunes', '08:00', '09:00');
INSERT INTO Horario VALUES (2, 'Miércoles', '18:00', '19:00');

INSERT INTO InscripciónClase VALUES (1, 1, '2025-07-01');
INSERT INTO InscripciónClase VALUES (2, 2, '2025-07-02');

INSERT INTO EntrenadorClase VALUES (1, 1);
INSERT INTO EntrenadorClase VALUES (2, 2);

UPDATE Cliente SET edad = 29 WHERE id_cliente = 1;
UPDATE Clase SET cupo_maximo = 18 WHERE id_clase = 1;


DELETE FROM EntrenadorClase WHERE id_entrenador = 2 AND id_clase = 2;
DELETE FROM InscripciónClase WHERE id_cliente = 2 AND id_clase = 2;

ALTER TABLE Plann ADD descripcion VARCHAR(150);
ALTER TABLE Clase ADD nivel VARCHAR(50);

ALTER TABLE Cliente ALTER COLUMN nombre VARCHAR(120);
ALTER TABLE Entrenador ALTER COLUMN especialidad VARCHAR(150);

ALTER TABLE Clase DROP COLUMN nivel;
ALTER TABLE Plann DROP COLUMN descripcion;




-- Clases con más de un entrenador asignado
SELECT nombre FROM Clase
WHERE id_clase IN (
    SELECT id_clase FROM EntrenadorClase
    GROUP BY id_clase
    HAVING COUNT(*) > 1
);

-- Clientes y sus clases inscritas
SELECT c.nombre AS cliente, cl.nombre AS clase, i.fecha_inscripcion
FROM Cliente c
JOIN InscripciónClase i ON c.id_cliente = i.id_cliente
JOIN Clase cl ON i.id_clase = cl.id_clase;

-- Edad promedio de los clientes
SELECT AVG(edad) AS edad_promedio FROM Cliente;

-- Clase con el mayor cupo máximo
SELECT TOP 1 nombre, cupo_maximo
FROM Clase
ORDER BY cupo_maximo DESC;