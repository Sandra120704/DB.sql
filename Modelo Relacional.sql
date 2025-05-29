CREATE DATABASE Aprende_Peru;
USE Aprende_Peru;

/* Creacion de las tablas */

CREATE TABLE administrador (
    id_administrador INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    contraseña CHAR(8) NOT NULL
) ENGINE = INNODB;

CREATE TABLE tipo_evaluacion (
    id_tipo INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) ENGINE = INNODB;

CREATE TABLE evaluaciones (
    id_evaluaciones INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_tipo INT,
    id_administrador INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    duracion INT,
    estado ENUM('Activo', 'Inactivo'),
    CONSTRAINT fk_tipo_evaluacion FOREIGN KEY (id_tipo) REFERENCES tipo_evaluacion(id_tipo),
    CONSTRAINT fk_administrador FOREIGN KEY (id_administrador) REFERENCES administrador(id_administrador)
) ENGINE = INNODB;

CREATE TABLE estudiantes (
    id_estudiantes INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    DNI CHAR(8),
    gmail VARCHAR(100) NOT NULL,
    contraseña CHAR(10)
) ENGINE = INNODB;

CREATE TABLE asignacion (
    id_asignacion INT PRIMARY KEY,
    id_estudiantes INT,
    id_administrador INT,
    id_evaluaciones INT,
    CONSTRAINT fk_asignacion_estudiantes FOREIGN KEY (id_estudiantes) REFERENCES estudiantes(id_estudiantes),
    CONSTRAINT fk_asignacion_administrador FOREIGN KEY (id_administrador) REFERENCES administrador(id_administrador),
    CONSTRAINT fk_asignacion_evaluaciones FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones(id_evaluaciones)
) ENGINE=INNODB;

CREATE TABLE intento_evaluacion (
    id_intento INT PRIMARY KEY,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    puntaje NUMERIC,
    id_evaluaciones INT,
    id_estudiantes INT,
    CONSTRAINT fk_intento_evaluacion FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones(id_evaluaciones),
    CONSTRAINT fk_intento_estudiantes FOREIGN KEY (id_estudiantes) REFERENCES estudiantes(id_estudiantes),
    CONSTRAINT unq_estudiante_evaluacion UNIQUE (id_estudiantes, id_evaluaciones)
) ENGINE=INNODB;

CREATE TABLE preguntas (
    id_preguntas INT PRIMARY KEY,
    puntaje INT,
    id_evaluaciones INT,
    CONSTRAINT fk_preguntas_evaluaciones FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones(id_evaluaciones)
) ENGINE = INNODB;

CREATE TABLE alternativa (
    id_alternativa INT PRIMARY KEY,
    id_preguntas INT,
    texto VARCHAR(500),
    es_correcta BOOLEAN,
    CONSTRAINT fk_alternativa_preguntas FOREIGN KEY (id_preguntas) REFERENCES preguntas(id_preguntas)
) ENGINE=INNODB;

CREATE TABLE registro_examen (
    id_registro INT PRIMARY KEY,
    id_intento INT,
    id_evaluaciones INT,
    id_alternativa INT,
    id_preguntas INT,
    CONSTRAINT fk_registro_intento FOREIGN KEY (id_intento) REFERENCES intento_evaluacion(id_intento),
    CONSTRAINT fk_registro_evaluacion FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones(id_evaluaciones),
    CONSTRAINT fk_registro_alternativa FOREIGN KEY (id_alternativa) REFERENCES alternativa(id_alternativa),
    CONSTRAINT fk_registro_pregunta FOREIGN KEY (id_preguntas) REFERENCES preguntas(id_preguntas)
) ENGINE=INNODB;

                                 /* Insertando datos ejemplo */

                      /* Tabla Estudiantes */
INSERT INTO estudiantes (id_estudiantes, nombre, DNI, gmail, contraseña) VALUES
(1, 'Carlos Ramírez', '12345678', 'carlos.ramirez@gmail.com', 'pass1234'),
(2, 'María López', '12345679', 'maria.lopez@gmail.com', 'pass1234'),
(3, 'Juan Pérez', '12345680', 'juan.perez@gmail.com', 'pass1234'),
(4, 'Ana Gómez', '12345681', 'ana.gomez@gmail.com', 'pass1234'),
(5, 'Luis Fernández', '12345682', 'luis.fernandez@gmail.com', 'pass1234'),

(6, 'Sofía Martínez', '12345683', 'sofia.martinez@gmail.com', 'pass1234'),
(7, 'Diego Torres', '12345684', 'diego.torres@gmail.com', 'pass1234'),
(8, 'Valentina Cruz', '12345685', 'valentina.cruz@gmail.com', 'pass1234'),
(9, 'Miguel Castillo', '12345686', 'miguel.castillo@gmail.com', 'pass1234'),
(10, 'Camila Rojas', '12345687', 'camila.rojas@gmail.com', 'pass1234');


/* Tabla Administrador */
INSERT INTO administrador (id_administrador, nombre, correo, contraseña) VALUES
(1, 'Admin 1', 'admin1@aprende.pe', 'admin123');

/* tabla Tipos de evaluación */
INSERT INTO tipo_evaluacion (id_tipo, nombre) VALUES
(1, 'Matemáticas'),
(2, 'Lenguaje'),
(3, 'Ciencias'),
(4, 'Historia'),
(5, 'Geografía');

/*Tabla Evaluaciones */
INSERT INTO evaluaciones (id_evaluaciones, nombre, id_tipo, id_administrador, fecha_inicio, fecha_fin, duracion, estado) VALUES
(1, 'Evaluación Matemáticas', 1, 1, '2025-06-01', '2025-06-10', 60, 'Activo'),
(2, 'Evaluación Lenguaje', 2, 1, '2025-06-05', '2025-06-15', 45, 'Activo'),
(3, 'Evaluación Ciencias', 3, 1, '2025-06-10', '2025-06-20', 50, 'Activo'),
(4, 'Evaluación Historia', 4, 1, '2025-06-15', '2025-06-25', 40, 'Activo'),
(5, 'Evaluación Geografía', 5, 1, '2025-06-20', '2025-06-30', 55, 'Activo');

/*Tabla Preguntas */
INSERT INTO preguntas (id_preguntas, puntaje, id_evaluaciones) VALUES
(1, 4, 1),
(2, 4, 1),
(3, 4, 1),
(4, 4, 1),
(5, 4, 1);

/*Tabla Alternativas */
INSERT INTO alternativa (id_alternativa, id_preguntas, texto, es_correcta) VALUES
(1, 1, '5', TRUE), (2, 1, '4', FALSE), (3, 1, '6', FALSE), (4, 1, '7', FALSE),
(5, 2, '8', TRUE), (6, 2, '9', FALSE), (7, 2, '7', FALSE), (8, 2, '6', FALSE),
(9, 3, '3', TRUE), (10, 3, '2', FALSE), (11, 3, '4', FALSE), (12, 3, '5', FALSE),
(13, 4, '12', TRUE), (14, 4, '11', FALSE), (15, 4, '10', FALSE), (16, 4, '13', FALSE),
(17, 5, '20', TRUE), (18, 5, '21', FALSE), (19, 5, '22', FALSE), (20, 5, '19', FALSE);

/* Asignaciones */

/* 4 alumnos con 3 evaluaciones */
INSERT INTO asignacion (id_asignacion, id_estudiantes, id_administrador, id_evaluaciones) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 1, 1, 3),

(4, 2, 1, 1),
(5, 2, 1, 2),
(6, 2, 1, 3),

(7, 3, 1, 1),
(8, 3, 1, 2),
(9, 3, 1, 3),

(10, 4, 1, 1),
(11, 4, 1, 2),
(12, 4, 1, 3);

/* 3 alumnos con 2 evaluaciones diferentes */
INSERT INTO asignacion (id_asignacion, id_estudiantes, id_administrador, id_evaluaciones) VALUES
(13, 5, 1, 4),
(14, 5, 1, 5),

(15, 6, 1, 4),
(16, 6, 1, 5),

(17, 7, 1, 4),
(18, 7, 1, 5);

/* Los alumnos 8,9,10 sin asignaciones */

/* Intentos */

/* Alumno 1: 3 evaluaciones, aprobó las dos primeras, desaprobó la tercera */
INSERT INTO intento_evaluacion (id_intento, fecha_inicio, fecha_fin, puntaje, id_evaluaciones, id_estudiantes) VALUES
(1, '2025-06-01 10:00', '2025-06-01 10:50', 18, 1, 1),  -- aprobado
(2, '2025-06-02 10:00', '2025-06-02 10:45', 15, 2, 1),  -- aprobado
(3, '2025-06-03 10:00', '2025-06-03 10:40', 10, 3, 1);  -- desaprobado

/* Alumno 2: aprueba todas */
INSERT INTO intento_evaluacion (id_intento, fecha_inicio, fecha_fin, puntaje, id_evaluaciones, id_estudiantes) VALUES
(4, '2025-06-01 11:00', '2025-06-01 11:50', 19, 1, 2),
(5, '2025-06-02 11:00', '2025-06-02 11:45', 17, 2, 2),
(6, '2025-06-03 11:00', '2025-06-03 11:40', 18, 3, 2);

/* Alumno 3: aprueba todas */
INSERT INTO intento_evaluacion (id_intento, fecha_inicio, fecha_fin, puntaje, id_evaluaciones, id_estudiantes) VALUES
(7, '2025-06-01 12:00', '2025-06-01 12:50', 20, 1, 3),
(8, '2025-06-02 12:00', '2025-06-02 12:45', 16, 2, 3),
(9, '2025-06-03 12:00', '2025-06-03 12:40', 17, 3, 3);

/* Alumno 4: desaprueba la evaluación 2 */
INSERT INTO intento_evaluacion (id_intento, fecha_inicio, fecha_fin, puntaje, id_evaluaciones, id_estudiantes) VALUES
(10, '2025-06-01 13:00', '2025-06-01 13:50', 18, 1, 4),
(11, '2025-06-02 13:00', '2025-06-02 13:45', 10, 2, 4),  -- desaprobado
(12, '2025-06-03 13:00', '2025-06-03 13:40', 16, 3, 4);

/* Alumno 5: 2 evaluaciones, desaprueba la primera */
INSERT INTO intento_evaluacion (id_intento, fecha_inicio, fecha_fin, puntaje, id_evaluaciones, id_estudiantes) VALUES
(13, '2025-06-04 10:00', '2025-06-04 10:50', 12, 4, 5), -- desaprobado
(14, '2025-06-05 10:00', '2025-06-05 10:45', 18, 5, 5);

/* Alumno 6: aprueba ambas */
INSERT INTO intento_evaluacion (id_intento, fecha_inicio, fecha_fin, puntaje, id_evaluaciones, id_estudiantes) VALUES
(15, '2025-06-04 11:00', '2025-06-04 11:50', 19, 4, 6),
(16, '2025-06-05 11:00', '2025-06-05 11:45', 17, 5, 6);

/* Alumno 7: aprueba ambas */
INSERT INTO intento_evaluacion (id_intento, fecha_inicio, fecha_fin, puntaje, id_evaluaciones, id_estudiantes) VALUES
(17, '2025-06-04 12:00', '2025-06-04 12:50', 18, 4, 7),
(18, '2025-06-05 12:00', '2025-06-05 12:45', 19, 5, 7);

/*Tabla Registro examen */
INSERT INTO registro_examen (id_registro, id_intento, id_evaluaciones, id_alternativa, id_preguntas) VALUES
(1, 1, 1, 1, 1),
(2, 1, 1, 5, 2);

