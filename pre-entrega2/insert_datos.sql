-- Seleccionar la base de datos
USE sistema_agendamiento;

-- Insertar datos de prueba en la tabla cliente
INSERT INTO cliente (nombre, email, telefono)
VALUES 
('María López', 'maria.lopez@example.com', '5551234567'),
('Laura Ramírez', 'laura.ramirez@example.com', '5559876543'),
('Sofía Gómez', 'sofia.gomez@example.com', '5556543210'),
('Carmen Torres', 'carmen.torres@example.com', '5553214567'),
('Isabel Hernández', 'isabel.hernandez@example.com', '5557896543'),
('Valentina Ruiz', 'valentina.ruiz@example.com', '5555678901'),
('Ana Fernández', 'ana.fernandez@example.com', '5554321789'),
('Elena García', 'elena.garcia@example.com', '5558765432'),
('Lucía Morales', 'lucia.morales@example.com', '5552345671'),
('Gabriela Pérez', 'gabriela.perez@example.com', '5556541234');

-- Insertar datos de prueba en la tabla servicio
INSERT INTO servicio (nombre, descripcion, duracion, precio)
VALUES 
('Uñas permanentes', 'Servicio completo de aplicación de uñas permanentes', 90, 50.00),
('Uñas semipermanentes', 'Aplicación de uñas semipermanentes con diseño a elección', 75, 40.00),
('Manicure básico', 'Manicure básico con limpieza y esmalte sencillo', 45, 25.00),
('Manicure con diseño', 'Manicure con diseño personalizado', 60, 35.00),
('Reparación de uñas', 'Reparación de uñas rotas o dañadas', 30, 15.00);

-- Insertar datos de prueba en la tabla estilista
INSERT INTO estilista (nombre, especialidad, email, telefono)
VALUES 
('Carla López', 'Uñas permanentes', 'carla.lopez@example.com', '5552345678'),
('Verónica Pérez', 'Uñas semipermanentes', 'veronica.perez@example.com', '5558765432'),
('Lucía Sánchez', 'Manicure básico', 'lucia.sanchez@example.com', '5553456789'),
('Diana Flores', 'Manicure con diseño', 'diana.flores@example.com', '5554567890'),
('Paola Torres', 'Reparación de uñas', 'paola.torres@example.com', '5556549871');

-- Insertar datos de prueba en la tabla disponibilidad
INSERT INTO disponibilidad (estilista_id, fecha, hora_inicio, hora_fin)
VALUES 
(1, '2024-09-20', '09:00:00', '13:00:00'),
(1, '2024-09-21', '14:00:00', '18:00:00'),
(2, '2024-09-20', '10:00:00', '13:00:00'),
(2, '2024-09-21', '09:00:00', '12:00:00'),
(3, '2024-09-20', '15:00:00', '18:00:00'),
(3, '2024-09-21', '11:00:00', '14:00:00'),
(4, '2024-09-20', '08:00:00', '12:00:00'),
(5, '2024-09-21', '13:00:00', '17:00:00');

-- Insertar datos de prueba en la tabla cita
INSERT INTO cita (cliente_id, servicio_id, fecha_hora, estado)
VALUES 
(1, 1, '2024-09-20 09:30:00', 'confirmada'),
(2, 2, '2024-09-20 10:30:00', 'pendiente'),
(3, 3, '2024-09-20 16:00:00', 'completada'),
(4, 4, '2024-09-20 17:00:00', 'confirmada'),
(5, 5, '2024-09-21 09:00:00', 'cancelada'),
(6, 1, '2024-09-21 14:30:00', 'completada'),
(7, 2, '2024-09-21 15:00:00', 'confirmada'),
(8, 3, '2024-09-21 16:00:00', 'pendiente'),
(9, 4, '2024-09-21 17:00:00', 'confirmada'),
(10, 5, '2024-09-21 17:30:00', 'pendiente');

-- Insertar datos de prueba en la tabla cita_estilista
INSERT INTO cita_estilista (cita_id, estilista_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5);
