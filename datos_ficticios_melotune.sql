-- Datos Ficticios para la Base de Datos MeloTune
-- Ejecutar este archivo DESPUÉS de haber creado las tablas (melotune.sql)

USE melotune;

-- Limpiar tablas si ya tienen datos (Cuidado: esto borra todo)
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM likes_reviews_albumes;
DELETE FROM seguimientos;
DELETE FROM listas_albumes;
DELETE FROM listas;
DELETE FROM reviews_canciones;
DELETE FROM reviews_albumes;
DELETE FROM canciones;
DELETE FROM albumes;
DELETE FROM artistas;
DELETE FROM usuarios;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. USUARIOS
-- Contraseña simulada con un hash de bcrypt (ej. '$2y$10$abcdefghijklmnopqrstuvwxyz')
INSERT INTO usuarios (id, username, email, password, nombre, bio, foto_perfil) VALUES
(1, 'soundwaves_alex', 'alex@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Álex Soundwaves', 'Buscando el beat perfecto. Amante del indie y el R&B.', 'avatar1.jpg'),
(2, 'vinyl_dreams', 'vinyl@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Vinyl Dreams', 'Coleccionista de vinilos. Rock progresivo y alternativo.', 'avatar2.jpg'),
(3, 'crate_digger_mx', 'digger@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Crate Digger', 'Rap, Hip-Hop y todo lo que tenga buen flow.', 'avatar3.jpg'),
(4, 'melotune_fan', 'fan@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'MeloTune Fan', 'Escucho de todo un poco.', 'default.jpg');

-- 2. ARTISTAS (Basado en el mockup visual)
INSERT INTO artistas (id, nombre, biografia, genero, pais) VALUES
(1, 'MGMT', 'Banda de rock indie y pop psicodélico de Estados Unidos, formada en 2002.', 'Indie Pop / Psychedelic Rock', 'Estados Unidos'),
(2, 'The Neighbourhood', 'Banda de rock alternativo estadounidense conocida por su estética visual en blanco y negro.', 'Indie Rock / Alternative', 'Estados Unidos'),
(3, 'Drake', 'Rapero, cantante, compositor y actor canadiense.', 'Hip-Hop / R&B', 'Canadá'),
(4, 'Tame Impala', 'Proyecto musical de psicodelia creado por el multinstrumentista australiano Kevin Parker.', 'Psychedelic Pop / Neo-psychedelia', 'Australia'),
(5, 'Frank Ocean', 'Cantante, compositor y rapero estadounidense galardonado que mezcla R&B introspectivo.', 'R&B / Art Pop', 'Estados Unidos'),
(6, 'Kendrick Lamar', 'Aclamado rapero y compositor estadounidense conocido por sus letras complejas e impacto cultural.', 'Hip-Hop / Conscious Rap', 'Estados Unidos');

-- 3. ÁLBUMES
INSERT INTO albumes (id, titulo, artista_id, fecha_lanzamiento, genero, duracion, discografica, portada) VALUES
(1, 'Oracular Spectacular', 1, '2007-10-02', 'Indie Pop', 2419, 'Columbia Records', 'oracular.jpg'),
(2, 'I Love You.', 2, '2013-04-22', 'Indie Rock', 2745, 'Columbia Records', 'iloveyou.jpg'),
(3, 'Take Care', 3, '2011-11-15', 'Hip-Hop / R&B', 4814, 'Young Money', 'takecare.jpg'),
(4, 'Currents', 4, '2015-07-17', 'Psychedelic Pop', 3060, 'Modular Recordings', 'currents.jpg'),
(5, 'Blonde', 5, '2016-08-20', 'R&B / Art Pop', 3600, 'Boys Don''t Cry', 'blonde.jpg'),
(6, 'good kid, m.A.A.d city', 6, '2012-10-22', 'Conscious Rap', 4084, 'Top Dawg Entertainment', 'goodkid.jpg'),
(7, 'Little Dark Age', 1, '2018-02-09', 'Synth-pop', 2652, 'Columbia Records', 'ldk.jpg');

-- 4. CANCIONES (Algunas de muestra por álbum)
INSERT INTO canciones (titulo, album_id, artista_id, duracion, numero_pista) VALUES
('Time to Pretend', 1, 1, 261, 1),
('Kids', 1, 1, 302, 5),
('Sweater Weather', 2, 2, 240, 3),
('Marvins Room', 3, 3, 327, 7),
('Let It Happen', 4, 4, 467, 1),
('The Less I Know The Better', 4, 4, 216, 7),
('Nikes', 5, 5, 314, 1),
('Nights', 5, 5, 307, 9),
('Money Trees', 6, 6, 386, 5),
('m.A.A.d city', 6, 6, 350, 8);

-- 5. REVIEWS BÁSICAS DE ÁLBUMES (Con los textos de tu maqueta)
INSERT INTO reviews_albumes (id, usuario_id, album_id, calificacion, titulo, contenido, likes) VALUES
(1, 1, 4, 5.0, 'Una obra maestra de la psicodelia moderna', 'Currents es un disco que te envuelve completamente. Desde la obertura de Let It Happen hasta el cierre de New Person, Same Old Mistakes, Kevin Parker construye un universo sonoro que mezcla melancolía y euforia con una habilidad extraordinaria. Cada escucha revela nuevas capas.', 42),
(2, 2, 5, 4.8, 'Intimidad en forma de álbum', 'Blonde es incómodo, fragmentado y absolutamente genial. Frank Ocean construye momentos de una vulnerabilidad aplastante. Nights es quizás el punto más alto, pero el conjunto es más grande que la suma de sus partes. Un disco que cambia según cómo te encuentres el día que lo escuchas.', 67),
(3, 3, 6, 4.8, 'El mejor álbum conceptual de rap', 'Kendrick logró algo que pocos raperos consiguen: crear una película en audio. Cada transición, cada interludio de buzón de voz, cada beat cuenta parte de la historia. Money Trees sola vale el precio de entrada.', 89),
(4, 1, 1, 4.4, 'Un clásico Indie', 'Aún suena tan fresco como el día en que salió. Kids y Time to Pretend definieron a toda una generación.', 15);

-- 6. LIKES EN REVIEWS (Simulación de comunidad)
INSERT INTO likes_reviews_albumes (usuario_id, review_id) VALUES
(2, 1), (3, 1), (4, 1),
(1, 2), (3, 2),
(1, 3), (2, 3), (4, 3);

-- 7. SEGUIMIENTOS (Followers)
INSERT INTO seguimientos (seguidor_id, seguido_id) VALUES
(1, 2), -- Alex sigue a Vinyl Dreams
(1, 3), -- Alex sigue a Crate Digger
(2, 1), -- Vinyl Dreams sigue a Alex
(3, 1), -- Crate Digger sigue a Alex
(4, 1); -- Fan sigue a Alex

-- 8. LISTAS PÚBLICAS
INSERT INTO listas (id, usuario_id, nombre, descripcion, publica) VALUES
(1, 1, 'Top 2010s', 'Mis discos favoritos de la década de los 2010s', TRUE),
(2, 2, 'Joyas Ocultas del Indie', 'Discos que tienes que escuchar', TRUE);

-- 9. ÁLBUMES EN LISTAS
INSERT INTO listas_albumes (lista_id, album_id, orden) VALUES
(1, 4, 1), -- Currents
(1, 5, 2), -- Blonde
(1, 6, 3), -- good kid
(2, 1, 1), -- Oracular Spectacular
(2, 2, 2); -- I Love You.
