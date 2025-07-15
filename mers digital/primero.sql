
CREATE DATABASE plataformaCursos
USE plataformaCursos

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100) UNIQUE
);

CREATE TABLE Profesor (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100),
    especialidad VARCHAR(100)
);

CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,
    titulo VARCHAR(100),
    descripcion TEXT,
    id_profesor INT,
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);

CREATE TABLE Categoría (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE Video (
    id_video INT PRIMARY KEY,
    titulo VARCHAR(100),
    duracion INT,
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Inscripción (
    id_usuario INT,
    id_curso INT,
    fecha_inscripcion DATE,
    PRIMARY KEY (id_usuario, id_curso),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Evaluación (
    id_usuario INT,
    id_curso INT,
    calificacion DECIMAL(3,1),
    comentarios TEXT,
    PRIMARY KEY (id_usuario, id_curso),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

-- Usuario
INSERT INTO Usuario VALUES (1, 'Carlos Pérez', 'carlos@gmail.com');
INSERT INTO Usuario VALUES (2, 'Laura Gómez', 'laura@gmail.com');

-- Profesor
INSERT INTO Profesor VALUES (1, 'Dr. Ramírez', 'Matemáticas');
INSERT INTO Profesor VALUES (2, 'Mtra. López', 'Historia');

-- Curso
INSERT INTO Curso VALUES (1, 'Álgebra Básica', 'Curso de álgebra', 1);
INSERT INTO Curso VALUES (2, 'Historia Moderna', 'Desde el siglo XVIII', 2);

-- Categoría
INSERT INTO Categoría VALUES (1, 'Ciencia');
INSERT INTO Categoría VALUES (2, 'Humanidades');

-- Video
INSERT INTO Video VALUES (1, 'Introducción al Álgebra', 15, 1);
INSERT INTO Video VALUES (2, 'Revolución Francesa', 20, 2);

-- Inscripción
INSERT INTO Inscripción VALUES (1, 1, '2025-07-01');
INSERT INTO Inscripción VALUES (2, 2, '2025-07-02');

-- Evaluación
INSERT INTO Evaluación VALUES (1, 1, 8.5, 'Buen curso.');
INSERT INTO Evaluación VALUES (2, 2, 9.0, 'Muy interesante.');

UPDATE Usuario SET nombre = 'Carlos A. Pérez' WHERE id_usuario = 1;
UPDATE Evaluación SET calificacion = 9.5 WHERE id_usuario = 2 AND id_curso = 2;

DELETE FROM Inscripción WHERE id_usuario = 2 AND id_curso = 2;
DELETE FROM Video WHERE id_video = 2;

ALTER TABLE Usuario ADD fecha_registro DATE;
ALTER TABLE Curso ADD nivel VARCHAR(50);

ALTER TABLE Usuario ALTER COLUMN nombre VARCHAR(150);
ALTER TABLE Curso ALTER COLUMN descripcion VARCHAR(500);

ALTER TABLE Usuario DROP COLUMN fecha_registro;
ALTER TABLE Curso DROP COLUMN nivel;

-- 1. Promedio general de calificaciones (AVG)
SELECT AVG(calificacion) AS promedio_general
FROM Evaluación;

-- 2. Suma total de duración de todos los videos (SUM)
SELECT SUM(duracion) AS duracion_total_videos
FROM Video;

-- 3. Calificación más alta (MAX)
SELECT MAX(calificacion) AS calificacion_maxima
FROM Evaluación;

-- Usuarios con calificación mayor al promedio
SELECT nombre FROM Usuario
WHERE id_usuario IN (
    SELECT id_usuario FROM Evaluación
    WHERE calificacion > (SELECT AVG(calificacion) FROM Evaluación)
);

-- Cursos con más de un video
SELECT titulo FROM Curso
WHERE id_curso IN (
    SELECT id_curso FROM Video
    GROUP BY id_curso
    HAVING COUNT(*) > 1
);



-- Usuarios con sus cursos inscritos
SELECT u.nombre, c.titulo, i.fecha_inscripcion
FROM Usuario u
INNER JOIN Inscripción i ON u.id_usuario = i.id_usuario
INNER JOIN Curso c ON i.id_curso = c.id_curso;
