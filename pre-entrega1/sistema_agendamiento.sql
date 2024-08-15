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
