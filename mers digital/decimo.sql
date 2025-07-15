CREATE DATABASE hospital
USE hospital


CREATE TABLE Paciente (
    id_paciente INT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT
);

CREATE TABLE Doctor (
    id_doctor INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Especialidad (
    id_especialidad INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Cita (
    id_cita INT PRIMARY KEY,
    id_paciente INT,
    id_doctor INT,
    fecha DATE,
    hora TIME,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_doctor) REFERENCES Doctor(id_doctor)
);

CREATE TABLE Medicamento (
    id_medicamento INT PRIMARY KEY,
    nombre VARCHAR(100),
    dosis VARCHAR(50)
);

CREATE TABLE Receta (
    id_cita INT,
    id_medicamento INT,
    cantidad INT,
    PRIMARY KEY (id_cita, id_medicamento),
    FOREIGN KEY (id_cita) REFERENCES Cita(id_cita),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento)
);

CREATE TABLE DoctorEspecialidad (
    id_doctor INT,
    id_especialidad INT,
    PRIMARY KEY (id_doctor, id_especialidad),
    FOREIGN KEY (id_doctor) REFERENCES Doctor(id_doctor),
    FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad)
);

INSERT INTO Paciente VALUES (1, 'Laura Rojas', 28);
INSERT INTO Paciente VALUES (2, 'José Díaz', 45);

INSERT INTO Doctor VALUES (1, 'Dra. Camila Torres');
INSERT INTO Doctor VALUES (2, 'Dr. Andrés Vargas');

INSERT INTO Especialidad VALUES (1, 'Pediatría');
INSERT INTO Especialidad VALUES (2, 'Cardiología');

INSERT INTO Cita VALUES (1, 1, 1, '2025-07-15', '09:00');
INSERT INTO Cita VALUES (2, 2, 2, '2025-07-16', '11:30');

INSERT INTO Medicamento VALUES (1, 'Ibuprofeno', '200mg');
INSERT INTO Medicamento VALUES (2, 'Amoxicilina', '500mg');

INSERT INTO Receta VALUES (1, 1, 2);
INSERT INTO Receta VALUES (2, 2, 1);

INSERT INTO DoctorEspecialidad VALUES (1, 1);
INSERT INTO DoctorEspecialidad VALUES (2, 2);

UPDATE Paciente SET edad = 29 WHERE id_paciente = 1;
UPDATE Medicamento SET dosis = '400mg' WHERE id_medicamento = 1;

DELETE FROM Receta WHERE id_cita = 2 AND id_medicamento = 2;
DELETE FROM DoctorEspecialidad WHERE id_doctor = 1 AND id_especialidad = 1;

ALTER TABLE Paciente ADD correo VARCHAR(100);
ALTER TABLE Cita ADD motivo_consulta VARCHAR(200);

ALTER TABLE Medicamento ALTER COLUMN dosis VARCHAR(100);
ALTER TABLE Especialidad ALTER COLUMN nombre VARCHAR(150);

ALTER TABLE Paciente DROP COLUMN correo;
ALTER TABLE Cita DROP COLUMN motivo_consulta;

-- Doctores con citas después del 2025-07-15
SELECT nombre FROM Doctor
WHERE id_doctor IN (
    SELECT id_doctor FROM Cita
    WHERE fecha > '2025-07-15'
);

-- Recetas detalladas
SELECT r.id_cita, m.nombre AS medicamento, m.dosis, r.cantidad
FROM Receta r
JOIN Medicamento m ON r.id_medicamento = m.id_medicamento;


-- Edad promedio de pacientes
SELECT AVG(edad) AS edad_promedio FROM Paciente;