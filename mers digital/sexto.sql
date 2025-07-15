CREATE DATABASE comercio
USE comercio

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100)
);

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(8,2)
);

CREATE TABLE Carrito (
    id_carrito INT PRIMARY KEY,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    id_usuario INT,
    fecha DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Categoría (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(60)
);

CREATE TABLE CarritoProducto (
    id_carrito INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_carrito, id_producto),
    FOREIGN KEY (id_carrito) REFERENCES Carrito(id_carrito),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE PedidoProducto (
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

INSERT INTO Usuario VALUES (1, 'Laura Sánchez', 'laura@email.com');
INSERT INTO Usuario VALUES (2, 'David Torres', 'david@email.com');

INSERT INTO Producto VALUES (1, 'Mouse Inalámbrico', 45000);
INSERT INTO Producto VALUES (2, 'Teclado Mecánico', 95000);

INSERT INTO Carrito VALUES (1, 1);
INSERT INTO Carrito VALUES (2, 2);

INSERT INTO Pedido VALUES (1, 1, '2025-07-01');
INSERT INTO Pedido VALUES (2, 2, '2025-07-02');

INSERT INTO Categoría VALUES (1, 'Tecnología');
INSERT INTO Categoría VALUES (2, 'Hogar');

INSERT INTO CarritoProducto VALUES (1, 1, 2);
INSERT INTO CarritoProducto VALUES (2, 2, 1);

INSERT INTO PedidoProducto VALUES (1, 1, 1);
INSERT INTO PedidoProducto VALUES (2, 2, 2);

UPDATE Producto SET precio = 47000 WHERE id_producto = 1;
UPDATE Usuario SET correo = 'laura_sanchez@email.com' WHERE id_usuario = 1;

DELETE FROM CarritoProducto WHERE id_carrito = 2 AND id_producto = 2;
DELETE FROM PedidoProducto WHERE id_pedido = 1 AND id_producto = 1;

ALTER TABLE Producto ADD descripcion VARCHAR(200);
ALTER TABLE Pedido ADD estado VARCHAR(50);

ALTER TABLE Usuario ALTER COLUMN nombre VARCHAR(120);
ALTER TABLE Producto ALTER COLUMN nombre VARCHAR(150);

ALTER TABLE Producto DROP COLUMN descripcion;
ALTER TABLE Pedido DROP COLUMN estado;


-- Productos agregados a más de un carrito
SELECT nombre FROM Producto
WHERE id_producto IN (
    SELECT id_producto FROM CarritoProducto
    GROUP BY id_producto
    HAVING COUNT(*) > 1
);

-- Detalle de pedidos con productos
SELECT u.nombre AS usuario, pr.nombre AS producto, pp.cantidad
FROM Pedido p
JOIN Usuario u ON p.id_usuario = u.id_usuario
JOIN PedidoProducto pp ON p.id_pedido = pp.id_pedido
JOIN Producto pr ON pp.id_producto = pr.id_producto;


-- Abreviatura de nombre de producto
SELECT nombre, LEFT(nombre, 6) AS abreviado FROM Producto;

-- Longitud del nombre del usuario
SELECT nombre, LEN(nombre) AS longitud FROM Usuario;