CREATE DATABASE universidad
USE universidad 

CREATE TABLE Estudiante (
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100)
);

CREATE TABLE Profesor (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100)
);

CREATE TABLE Facultad (
    id_facultad INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Departamento (
    id_departamento INT PRIMARY KEY,
    nombre VARCHAR(100),
    id_facultad INT,
    FOREIGN KEY (id_facultad) REFERENCES Facultad(id_facultad)
);

CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,
    nombre VARCHAR(100),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

CREATE TABLE Matricula (
    id_estudiante INT,
    id_curso INT,
    semestre VARCHAR(10),
    PRIMARY KEY (id_estudiante, id_curso),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Asignación (
    id_profesor INT,
    id_curso INT,
    periodo VARCHAR(10),
    PRIMARY KEY (id_profesor, id_curso),
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

-- Estudiante
INSERT INTO Estudiante VALUES (1, 'Ana Torres', 'ana.torres@uni.edu');
INSERT INTO Estudiante VALUES (2, 'Luis Díaz', 'luis.diaz@uni.edu');

-- Profesor
INSERT INTO Profesor VALUES (1, 'Dra. Mejía', 'mejia@uni.edu');
INSERT INTO Profesor VALUES (2, 'Dr. Ríos', 'rios@uni.edu');

-- Facultad
INSERT INTO Facultad VALUES (1, 'Ingeniería');
INSERT INTO Facultad VALUES (2, 'Ciencias Sociales');

-- Departamento
INSERT INTO Departamento VALUES (1, 'Sistemas', 1);
INSERT INTO Departamento VALUES (2, 'Historia', 2);

-- Curso
INSERT INTO Curso VALUES (1, 'Base de Datos', 1);
INSERT INTO Curso VALUES (2, 'Historia Antigua', 2);

-- Matricula
INSERT INTO Matricula VALUES (1, 1, '2025-1');
INSERT INTO Matricula VALUES (2, 2, '2025-1');

-- Asignación
INSERT INTO Asignación VALUES (1, 1, '2025-1');
INSERT INTO Asignación VALUES (2, 2, '2025-1');

UPDATE Estudiante SET nombre = 'Ana M. Torres' WHERE id_estudiante = 1;
UPDATE Matricula SET semestre = '2025-2' WHERE id_estudiante = 2 AND id_curso = 2;

DELETE FROM Asignación WHERE id_profesor = 2 AND id_curso = 2;
DELETE FROM Matricula WHERE id_estudiante = 2 AND id_curso = 2;

ALTER TABLE Profesor ADD telefono VARCHAR(20);
ALTER TABLE Curso ADD creditos INT;

ALTER TABLE Facultad ALTER COLUMN nombre VARCHAR(150);
ALTER TABLE Curso ALTER COLUMN nombre VARCHAR(150);

ALTER TABLE Profesor DROP COLUMN telefono;
ALTER TABLE Curso DROP COLUMN creditos;

SELECT nombre, LEN(nombre) AS longitud_nombre
FROM Estudiante;

SELECT nombre, LEFT(nombre, 3) AS abreviatura
FROM Curso;



-- Facultades con más de un departamento
SELECT nombre FROM Facultad
WHERE id_facultad IN (
    SELECT id_facultad FROM Departamento
    GROUP BY id_facultad
    HAVING COUNT(*) > 1
);

-- Estudiantes y los cursos en los que están matriculados
SELECT e.nombre AS estudiante, c.nombre AS curso, m.semestre
FROM Estudiante e
JOIN Matricula m ON e.id_estudiante = m.id_estudiante
JOIN Curso c ON m.id_curso = c.id_curso;

