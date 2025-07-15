CREATE DATABASE cine
USE cine

CREATE TABLE Pel�cula (
    id_pelicula INT PRIMARY KEY,
    titulo VARCHAR(100),
    duraci�n INT
);

CREATE TABLE Sala (
    id_sala INT PRIMARY KEY,
    nombre VARCHAR(50),
    capacidad INT
);

CREATE TABLE Funci�n (
    id_funcion INT PRIMARY KEY,
    id_pelicula INT,
    id_sala INT,
    fecha DATE,
    hora TIME,
    FOREIGN KEY (id_pelicula) REFERENCES Pel�cula(id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Reserva (
    id_reserva INT PRIMARY KEY,
    id_usuario INT,
    id_funcion INT,
    fecha DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_funcion) REFERENCES Funci�n(id_funcion)
);

CREATE TABLE Actuaci�n (
    id_pelicula INT,
    actor VARCHAR(100),
    rol VARCHAR(50),
    PRIMARY KEY (id_pelicula, actor),
    FOREIGN KEY (id_pelicula) REFERENCES Pel�cula(id_pelicula)
);

CREATE TABLE ReservaAsiento (
    id_reserva INT,
    asiento VARCHAR(10),
    PRIMARY KEY (id_reserva, asiento),
    FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva)
);

INSERT INTO Pel�cula VALUES (1, 'Inception', 148);
INSERT INTO Pel�cula VALUES (2, 'The Matrix', 136);

INSERT INTO Sala VALUES (1, 'Sala A', 100);
INSERT INTO Sala VALUES (2, 'Sala B', 80);

INSERT INTO Funci�n VALUES (1, 1, 1, '2025-07-20', '19:00');
INSERT INTO Funci�n VALUES (2, 2, 2, '2025-07-21', '21:00');

INSERT INTO Usuario VALUES (1, 'Mar�a L�pez');
INSERT INTO Usuario VALUES (2, 'Luis Herrera');

INSERT INTO Reserva VALUES (1, 1, 1, '2025-07-18');
INSERT INTO Reserva VALUES (2, 2, 2, '2025-07-19');

INSERT INTO Actuaci�n VALUES (1, 'Leonardo DiCaprio', 'Cobb');
INSERT INTO Actuaci�n VALUES (2, 'Keanu Reeves', 'Neo');

INSERT INTO ReservaAsiento VALUES (1, 'A10');
INSERT INTO ReservaAsiento VALUES (2, 'B5');

UPDATE Pel�cula SET duraci�n = 150 WHERE id_pelicula = 1;
UPDATE Sala SET capacidad = 120 WHERE id_sala = 1;

DELETE FROM ReservaAsiento WHERE id_reserva = 2 AND asiento = 'B5';
DELETE FROM Actuaci�n WHERE id_pelicula = 2 AND actor = 'Keanu Reeves';

ALTER TABLE Usuario ADD correo VARCHAR(100);
ALTER TABLE Pel�cula ADD clasificaci�n VARCHAR(10);

ALTER TABLE Sala ALTER COLUMN nombre VARCHAR(100);
ALTER TABLE Actuaci�n ALTER COLUMN rol VARCHAR(100);

ALTER TABLE Pel�cula DROP COLUMN clasificaci�n;
ALTER TABLE Usuario DROP COLUMN correo;



-- Pel�culas con m�s de un actor registrado
SELECT titulo FROM Pel�cula
WHERE id_pelicula IN (
    SELECT id_pelicula FROM Actuaci�n
    GROUP BY id_pelicula
    HAVING COUNT(*) > 1
);

-- Detalle de reservas por usuario
SELECT u.nombre AS usuario, p.titulo AS pel�cula, f.fecha, f.hora
FROM Reserva r
JOIN Usuario u ON r.id_usuario = u.id_usuario
JOIN Funci�n f ON r.id_funcion = f.id_funcion
JOIN Pel�cula p ON f.id_pelicula = p.id_pelicula;


-- Duraci�n promedio de pel�culas
SELECT AVG(duraci�n) AS duracion_promedio FROM Pel�cula;

-- Funci�n con mayor n�mero de reservas
SELECT TOP 1 id_funcion, COUNT(*) AS total_reservas
FROM Reserva
GROUP BY id_funcion
ORDER BY total_reservas DESC;