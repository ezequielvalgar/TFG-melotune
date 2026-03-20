-- Base de datos MeloTune
-- Sistema de reviews musicales

CREATE DATABASE IF NOT EXISTS melotune CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE melotune;

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(100),
    bio TEXT,
    foto_perfil VARCHAR(255) DEFAULT 'default.jpg',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    INDEX idx_username (username),
    INDEX idx_email (email)
);

-- Tabla de artistas
CREATE TABLE artistas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    biografia TEXT,
    imagen VARCHAR(255),
    genero VARCHAR(100),
    pais VARCHAR(100),
    fecha_creacion DATE,
    INDEX idx_nombre (nombre)
);

-- Tabla de álbumes
CREATE TABLE albumes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    artista_id INT NOT NULL,
    fecha_lanzamiento DATE,
    genero VARCHAR(100),
    portada VARCHAR(255),
    duracion INT, -- en segundos
    discografica VARCHAR(100),
    descripcion TEXT,
    FOREIGN KEY (artista_id) REFERENCES artistas(id) ON DELETE CASCADE,
    INDEX idx_titulo (titulo),
    INDEX idx_artista (artista_id)
);

-- Tabla de canciones
CREATE TABLE canciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    album_id INT,
    artista_id INT NOT NULL,
    duracion INT, -- en segundos
    numero_pista INT,
    FOREIGN KEY (album_id) REFERENCES albumes(id) ON DELETE SET NULL,
    FOREIGN KEY (artista_id) REFERENCES artistas(id) ON DELETE CASCADE,
    INDEX idx_titulo (titulo),
    INDEX idx_album (album_id)
);

-- Tabla de reviews de álbumes
CREATE TABLE reviews_albumes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    album_id INT NOT NULL,
    calificacion DECIMAL(2,1) CHECK (calificacion >= 0.5 AND calificacion <= 5.0),
    titulo VARCHAR(200),
    contenido TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    likes INT DEFAULT 0,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES albumes(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_album (usuario_id, album_id),
    INDEX idx_usuario (usuario_id),
    INDEX idx_album (album_id),
    INDEX idx_calificacion (calificacion)
);

-- Tabla de reviews de canciones
CREATE TABLE reviews_canciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    cancion_id INT NOT NULL,
    calificacion DECIMAL(2,1) CHECK (calificacion >= 0.5 AND calificacion <= 5.0),
    comentario TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    likes INT DEFAULT 0,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (cancion_id) REFERENCES canciones(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_cancion (usuario_id, cancion_id),
    INDEX idx_usuario (usuario_id),
    INDEX idx_cancion (cancion_id)
);

-- Tabla de listas personalizadas
CREATE TABLE listas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    publica BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_usuario (usuario_id)
);

-- Tabla de álbumes en listas
CREATE TABLE listas_albumes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lista_id INT NOT NULL,
    album_id INT NOT NULL,
    orden INT DEFAULT 0,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (lista_id) REFERENCES listas(id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES albumes(id) ON DELETE CASCADE,
    UNIQUE KEY unique_lista_album (lista_id, album_id)
);

-- Tabla de seguimientos entre usuarios
CREATE TABLE seguimientos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seguidor_id INT NOT NULL,
    seguido_id INT NOT NULL,
    fecha_seguimiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (seguidor_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (seguido_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    UNIQUE KEY unique_seguimiento (seguidor_id, seguido_id),
    CHECK (seguidor_id != seguido_id)
);

-- Tabla de likes en reviews de álbumes
CREATE TABLE likes_reviews_albumes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    review_id INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (review_id) REFERENCES reviews_albumes(id) ON DELETE CASCADE,
    UNIQUE KEY unique_like (usuario_id, review_id)
);

-- Datos de ejemplo
INSERT INTO artistas (nombre, biografia, genero, pais) VALUES
('Radiohead', 'Banda británica de rock alternativo formada en 1985', 'Rock Alternativo', 'Reino Unido'),
('Kendrick Lamar', 'Rapero y compositor estadounidense', 'Hip Hop', 'Estados Unidos'),
('Pink Floyd', 'Banda inglesa de rock progresivo', 'Rock Progresivo', 'Reino Unido');

INSERT INTO albumes (titulo, artista_id, fecha_lanzamiento, genero, duracion) VALUES
('OK Computer', 1, '1997-05-21', 'Rock Alternativo', 3219),
('good kid, m.A.A.d city', 2, '2012-10-22', 'Hip Hop', 4084),
('The Dark Side of the Moon', 3, '1973-03-01', 'Rock Progresivo', 2583);

INSERT INTO usuarios (username, email, password, nombre) VALUES
('musiclover', 'musiclover@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz', 'Music Lover'),
('rockfan92', 'rockfan@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz', 'Rock Fan');
