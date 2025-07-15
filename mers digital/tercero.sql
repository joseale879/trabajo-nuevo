CREATE DATABASE deliveri
USE deliveri

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(200)
);

CREATE TABLE Restaurante (
    id_restaurante INT PRIMARY KEY,
    nombre VARCHAR(100),
    ubicacion VARCHAR(100)
);

CREATE TABLE Repartidor (
    id_repartidor INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(8,2)
);

CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    id_repartidor INT,
    fecha DATE,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_repartidor) REFERENCES Repartidor(id_repartidor)
);

CREATE TABLE DetallePedido (
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE MenúRestaurante (
    id_restaurante INT,
    id_producto INT,
    PRIMARY KEY (id_restaurante, id_producto),
    FOREIGN KEY (id_restaurante) REFERENCES Restaurante(id_restaurante),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

INSERT INTO Cliente VALUES (1, 'Carlos García', 'Calle 123');
INSERT INTO Cliente VALUES (2, 'Mariana Rojas', 'Avenida 45');

INSERT INTO Restaurante VALUES (1, 'Pizza Feliz', 'Centro');
INSERT INTO Restaurante VALUES (2, 'Sushi Ya', 'Norte');

INSERT INTO Repartidor VALUES (1, 'Pedro Ruiz', '3010000001');
INSERT INTO Repartidor VALUES (2, 'Luisa López', '3020000002');

INSERT INTO Producto VALUES (1, 'Pizza Pepperoni', 40000);
INSERT INTO Producto VALUES (2, 'Roll de Salmón', 25000);

INSERT INTO Pedido VALUES (1, 1, 1, '2025-07-01');
INSERT INTO Pedido VALUES (2, 2, 2, '2025-07-02');

INSERT INTO DetallePedido VALUES (1, 1, 2);
INSERT INTO DetallePedido VALUES (2, 2, 3);

INSERT INTO MenúRestaurante VALUES (1, 1);
INSERT INTO MenúRestaurante VALUES (2, 2);

UPDATE Cliente SET direccion = 'Calle 456' WHERE id_cliente = 1;
UPDATE Repartidor SET telefono = '3001234567' WHERE id_repartidor = 2;

DELETE FROM DetallePedido WHERE id_pedido = 2 AND id_producto = 2;
DELETE FROM MenúRestaurante WHERE id_restaurante = 1 AND id_producto = 1;

ALTER TABLE Producto ADD descripcion VARCHAR(150);
ALTER TABLE Pedido ADD estado VARCHAR(50);


ALTER TABLE Restaurante ALTER COLUMN nombre VARCHAR(150);
ALTER TABLE Cliente ALTER COLUMN direccion VARCHAR(250);

ALTER TABLE Producto DROP COLUMN descripcion;
ALTER TABLE Pedido DROP COLUMN estado;



-- Fecha del pedido con GETDATE
SELECT id_pedido, GETDATE() AS fecha_actual
FROM Pedido;



-- Restaurantes que ofrecen más de un producto
SELECT nombre FROM Restaurante
WHERE id_restaurante IN (
    SELECT id_restaurante
    FROM MenúRestaurante
    GROUP BY id_restaurante
    HAVING COUNT(*) > 1
);



-- Detalles de pedido con nombre de producto
SELECT dp.id_pedido, pr.nombre AS producto, dp.cantidad
FROM DetallePedido dp
JOIN Producto pr ON dp.id_producto = pr.id_producto;