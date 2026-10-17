CREATE DATABASE biblioteca_db;
USE biblioteca_db;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni CHAR(8) UNIQUE NOT NULL,
    correo VARCHAR(100) UNIQUE,
    telefono VARCHAR(15),
    direccion VARCHAR(200),
    fecha_registro DATE NOT NULL DEFAULT (CURRENT_DATE),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo'
);

-- Tabla de autores
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    nacionalidad VARCHAR(100)
);

-- Tabla de libros
CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    id_autor INT,
    editorial VARCHAR(100),
    anio_publicacion YEAR,
    categoria VARCHAR(100),
    cantidad_total INT NOT NULL DEFAULT 1,
    cantidad_disponible INT NOT NULL DEFAULT 1,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',

    FOREIGN KEY (id_autor)
        REFERENCES autores(id_autor),

    CHECK (cantidad_total >= 0),
    CHECK (cantidad_disponible >= 0),
    CHECK (cantidad_disponible <= cantidad_total)
);

-- Tabla de préstamos
CREATE TABLE prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_devolucion_prevista DATE NOT NULL,
    fecha_devolucion_real DATE,
    estado ENUM('prestado', 'devuelto', 'atrasado')
        NOT NULL DEFAULT 'prestado',

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_libro)
        REFERENCES libros(id_libro),

    CHECK (fecha_devolucion_prevista >= fecha_prestamo),
    CHECK (
        fecha_devolucion_real IS NULL
        OR fecha_devolucion_real >= fecha_prestamo
    )
);
