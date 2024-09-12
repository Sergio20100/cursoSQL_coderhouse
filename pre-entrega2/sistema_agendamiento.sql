CREATE DATABASE IF NOT EXISTS sistema_agendamiento
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE sistema_agendamiento;

CREATE TABLE cliente (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  telefono VARCHAR(15),
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE servicio (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  descripcion VARCHAR(255),
  duracion INT,
  precio DECIMAL(10, 2)
);

CREATE TABLE cita (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT,
  servicio_id INT,
  fecha_hora TIMESTAMP,
  estado VARCHAR(20),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id),
  FOREIGN KEY (servicio_id) REFERENCES servicio(id)
);

CREATE TABLE estilista (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  especialidad VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  telefono VARCHAR(15)
);

CREATE TABLE disponibilidad (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  estilista_id INT,
  fecha DATE,
  hora_inicio TIME,
  hora_fin TIME,
  FOREIGN KEY (estilista_id) REFERENCES estilista(id)
);

CREATE TABLE cita_estilista (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cita_id INT,
  estilista_id INT,
  FOREIGN KEY (cita_id) REFERENCES cita(id),
  FOREIGN KEY (estilista_id) REFERENCES estilista(id)
);
-- PRE-ENTREGA 2 --

create view vista_citas as
select
  c.id as cita_id,
  cl.nombre as cliente_nombre,
  cl.email as cliente_email,
  s.nombre as servicio_nombre,
  s.precio as servicio_precio,
  e.nombre as estilista_nombre,
  c.fecha_hora,
  c.estado
from
  cita c
  join cliente cl on c.cliente_id = cl.id
  join servicio s on c.servicio_id = s.id
  join cita_estilista ce on c.id = ce.cita_id
  join estilista e on ce.estilista_id = e.id;


create view vista_disponibilidad_estilista as
select
  e.id as estilista_id,
  e.nombre as estilista_nombre,
  e.especialidad,
  d.fecha,
  d.hora_inicio,
  d.hora_fin
from
  estilista e
  join disponibilidad d on e.id = d.estilista_id;
  
  
DELIMITER $$

CREATE OR REPLACE FUNCTION obtener_numero_citas_estilista (
    estilista_id_param BIGINT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numero_citas INT;

    SELECT COUNT(*)
    INTO numero_citas
    FROM cita_estilista
    WHERE estilista_id = estilista_id_param;

    RETURN numero_citas;
END $$

DELIMITER ;

DELIMITER $$

CREATE OR REPLACE FUNCTION obtener_precio_total_cliente (
    cliente_id_param BIGINT
) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE precio_total DECIMAL(10, 2) DEFAULT 0;

    SELECT SUM(s.precio)
    INTO precio_total
    FROM cita c
    JOIN servicio s ON c.servicio_id = s.id
    WHERE c.cliente_id = cliente_id_param;

    RETURN IFNULL(precio_total, 0); -- En caso de que el resultado sea NULL, devolver 0
END $$

DELIMITER ;



DELIMITER $$

CREATE OR REPLACE PROCEDURE obtener_citas_en_rango (
    IN fecha_inicio TIMESTAMP,
    IN fecha_fin TIMESTAMP
)
BEGIN
    SELECT 
        c.id AS cita_id, 
        cl.nombre AS cliente_nombre, 
        s.nombre AS servicio_nombre, 
        e.nombre AS estilista_nombre, 
        c.fecha_hora, 
        c.estado
    FROM 
        cita c
    JOIN 
        cliente cl ON c.cliente_id = cl.id
    JOIN 
        servicio s ON c.servicio_id = s.id
    JOIN 
        cita_estilista ce ON c.id = ce.cita_id
    JOIN 
        estilista e ON ce.estilista_id = e.id
    WHERE 
        c.fecha_hora BETWEEN fecha_inicio AND fecha_fin;
END $$

DELIMITER ;


DELIMITER $$

CREATE OR REPLACE PROCEDURE cancelar_cita (
    IN cita_id_param BIGINT
)
BEGIN
    -- Marcar la cita como cancelada
    UPDATE cita
    SET estado = 'cancelado'
    WHERE id = cita_id_param;

    -- Eliminar registros de cita_estilista relacionados
    DELETE FROM cita_estilista
    WHERE cita_id = cita_id_param;

    -- Eliminar registros de disponibilidad relacionados
    DELETE FROM disponibilidad
    WHERE estilista_id IN (
        SELECT estilista_id
        FROM cita_estilista
        WHERE cita_id = cita_id_param
    );
END $$

DELIMITER ;