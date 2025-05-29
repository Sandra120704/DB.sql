CREATE DATABASE Aprende_Peru;

USE Aprende_Peru;

/* Creacion de las tablas */
CREATE TABLE administrador(
	id_administrador INT PRIMARY KEY,
	nombre 	VARCHAR(100) NOT NULL,
    email 	VARCHAR(100) NOT NULL,
    contraseña CHAR(8) NOT NULL
)ENGINE = INNODB;

CREATE TABLE tipo(
	id_tipo	  INT PRIMARY KEY,
    nombre	  VARCHAR(100) NOT NULL
)ENGINE = INNODB;

CREATE TABLE evaluaciones(
	id_evaluaciones INT PRIMARY KEY,
    nombre 			VARCHAR(100) NOT NULL,
    id_tipo			INT,
    id_administrador INT,
    fecha_inicio	DATE NOT NULL,
    fecha_fin		DATE NOT NULL,
    duracion		INT,
    estado 			ENUM('Activo','Inactivo'),
    CONSTRAINT id_tipo_fk FOREIGN KEY (id_tipo) REFERENCES tipo (id_tipo),
    CONSTRAINT id_administrador_fk FOREIGN KEY (id_administrador) REFERENCES administrador (id_administrador)
)ENGINE = INNODB;

CREATE TABLE etudiantes(
	id_estudiantes 	INT PRIMARY KEY,
	nombre 			VARCHAR(100) NOT NULL,
    DNI				CHAR(8),
    gmail			VARCHAR(100) NOT NULL,
    contraseña		CHAR(10),
    id_evaluaciones	INT,
    CONSTRAINT id_evaluaciones_fk FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones (id_evaluaciones)
)ENGINE = INNODB;

CREATE TABLE asignacion (
	id_asignacion  INT PRIMARY KEY,
    id_estudiante  INT,
    id_administrador INT,
    id_evaluaciones INT,
    CONSTRAINT id_estudiante_fk FOREIGN KEY (id_estudiante)REFERENCES etudiantes (id_estudiantes),
    CONSTRAINT id_admi_fk FOREIGN KEY (id_administrador) REFERENCES administrador (id_administrador),
    CONSTRAINT id_evaluacion_fk FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones (id_evaluaciones)
)ENGINE= INNODB;

CREATE TABLE intento_evaluacion(
	id_intento INT PRIMARY KEY,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    puntaje NUMERIC,
    id_evaluaciones INT,
    id_estudiantes INT,
    CONSTRAINT fk_evaluacion FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones (id_evaluaciones),
    CONSTRAINT fk_estudiante FOREIGN KEY (id_estudiantes) REFERENCES etudiantes (id_estudiantes),
    CONSTRAINT unq_estudiante_evaluacion UNIQUE (id_estudiantes, id_evaluaciones)
) ENGINE=INNODB;

CREATE TABLE preguntas (
	id_preguntas INT PRIMARY KEY,
    puntaje 	INT,
    id_evaluaciones INT,
    CONSTRAINT fk_evaluaciones_id FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones (id_evaluaciones)
)ENGINE = INNODB;

CREATE TABLE alternativa (
    id_alternativa INT PRIMARY KEY,
    id_pregunta INT,
    texto VARCHAR(500),
    es_correcta BOOLEAN,
    CONSTRAINT id_pregunta_fk FOREIGN KEY (id_pregunta) REFERENCES preguntas (id_preguntas)
) ENGINE=INNODB;


CREATE TABLE registro_examen(
	id_registro INT PRIMARY KEY,
    id_intento INT,
    id_evaluaciones INT,
    id_alternativas INT,
    id_pregunta INT,
    CONSTRAINT fk_intento_id FOREIGN KEY (id_intento) REFERENCES intento_evaluacion (id_intento),
    CONSTRAINT fk_evaluacione_id FOREIGN KEY (id_evaluaciones) REFERENCES evaluaciones(id_evaluaciones),
    CONSTRAINT fk_alternativas_id FOREIGN KEY (id_alternativas) REFERENCES alternativa (id_alternativa),
    CONSTRAINT fk_pregunta_id FOREIGN KEY (id_pregunta) REFERENCES preguntas (id_preguntas)
)ENGINE = INNODB;

/* Registros incertados en la tabla estudiante*/
INSERT INTO etudiantes (id_estudiantes, nombre, DNI, gmail, contraseña, id_evaluaciones) VALUES
(1, 'Alumno 1', '12345678', 'alumno1@gmail.com', 'pass1234', NULL),
(2, 'Alumno 2', '12345679', 'alumno2@gmail.com', 'pass1234', NULL),
(3, 'Alumno 3', '12345680', 'alumno3@gmail.com', 'pass1234', NULL),
(4, 'Alumno 4', '12345681', 'alumno4@gmail.com', 'pass1234', NULL),
(5, 'Alumno 5', '12345682', 'alumno5@gmail.com', 'pass1234', NULL),
(6, 'Alumno 6', '12345683', 'alumno6@gmail.com', 'pass1234', NULL),
(7, 'Alumno 7', '12345684', 'alumno7@gmail.com', 'pass1234', NULL),
(8, 'Alumno 8', '12345685', 'alumno8@gmail.com', 'pass1234', NULL),
(9, 'Alumno 9', '12345686', 'alumno9@gmail.com', 'pass1234', NULL),
(10, 'Alumno 10', '12345687', 'alumno10@gmail.com', 'pass1234', NULL);

SELECT * FROM etudiantes;

/* Registros incertados en la tabla administrador*/
INSERT INTO administrador (id_administrador, nombre, email, contraseña) VALUES
(1, 'Admin 1', 'admin1@aprende.pe', 'admin123');
SELECT * FROM  administrador;

/* Registros incertados en la tabla tipos*/
INSERT INTO tipo (id_tipo, nombre) VALUES
(1, 'Matemáticas'),
(2, 'Lenguaje'),
(3, 'Ciencias'),
(4, 'Historia'),
(5, 'Geografía');

SELECT * FROM  tipo;

/* Registros incertados en la tabla evaluaciones*/
INSERT INTO evaluaciones (id_evaluaciones, nombre, id_tipo, id_administrador, fecha_inicio, fecha_fin, duracion, estado) VALUES
(1, 'Evaluación Matemáticas', 1, 1, '2025-06-01', '2025-06-10', 60, 'Activo'),
(2, 'Evaluación Lenguaje', 2, 1, '2025-06-05', '2025-06-15', 45, 'Activo'),
(3, 'Evaluación Ciencias', 3, 1, '2025-06-10', '2025-06-20', 50, 'Activo'),
(4, 'Evaluación Historia', 4, 1, '2025-06-15', '2025-06-25', 40, 'Activo'),
(5, 'Evaluación Geografía', 5, 1, '2025-06-20', '2025-06-30', 55, 'Activo');
SELECT * FROM  evaluaciones;


/* Registros incertados en la tabla preguntas y respuestas*/
-- Preguntas
INSERT INTO preguntas (id_preguntas, puntaje, id_evaluaciones) VALUES
(1, 4, 1),
(2, 4, 1),
(3, 4, 1),
(4, 4, 1),
(5, 4, 1);
SELECT * FROM preguntas;

-- Alternativas para cada pregunta (una correcta)
-- Pregunta 1
INSERT INTO alternativa (id_alternativa, id_pregunta, texto, es_correcta) VALUES
(1, 1, '5', TRUE),  -- correcta
(2, 1, '4', FALSE),
(3, 1, '6', FALSE),
(4, 1, '7', FALSE);

-- Pregunta 2
INSERT INTO alternativa (id_alternativa, id_pregunta, texto, es_correcta) VALUES
(5, 2, '8', TRUE),  -- correcta
(6, 2, '9', FALSE),
(7, 2, '7', FALSE),
(8, 2, '6', FALSE);

-- Pregunta 3
INSERT INTO alternativa (id_alternativa, id_pregunta, texto, es_correcta) VALUES
(9, 3, '3', TRUE),  -- correcta
(10, 3, '2', FALSE),
(11, 3, '4', FALSE),
(12, 3, '5', FALSE);

-- Pregunta 4
INSERT INTO alternativa (id_alternativa, id_pregunta, texto, es_correcta) VALUES
(13, 4, '12', TRUE),  -- correcta
(14, 4, '11', FALSE),
(15, 4, '10', FALSE),
(16, 4, '13', FALSE);

-- Pregunta 5
INSERT INTO alternativa (id_alternativa, id_pregunta, texto, es_correcta) VALUES
(17, 5, '20', TRUE),  -- correcta
(18, 5, '21', FALSE),
(19, 5, '22', FALSE),
(20, 5, '19', FALSE);

SELECT * FROM alternativa;

-- Asignaciones para alumnos 1 a 4 (3 evaluaciones cada uno)
INSERT INTO asignacion (id_asignacion, id_estudiante, id_administrador, id_evaluaciones) VALUES
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

-- Asignaciones para alumnos 5 a 7 (2 evaluaciones diferentes)
INSERT INTO asignacion (id_asignacion, id_estudiante, id_administrador, id_evaluaciones) VALUES
(13, 5, 1, 4),
(14, 5, 1, 5),
(15, 6, 1, 4),
(16, 6, 1, 5),
(17, 7, 1, 4),
(18, 7, 1, 5);

SELECT * FROM  asignacion;

-- Ejemplo intento de evaluación para Alumno 1 en Evaluación 1
-- Alumno 1 - evaluación 1
INSERT INTO intento_evaluacion (id_intento, fecha_inicio, fecha_fin, puntaje, id_evaluaciones, id_estudiantes) VALUES
(1, '2025-06-02 09:00:00', '2025-06-02 09:30:00', 16, 1, 1),
(2, '2025-06-03 10:00:00', '2025-06-03 10:30:00', 12, 2, 1), -- desaprobado
(3, '2025-06-04 11:00:00', '2025-06-04 11:40:00', 18, 3, 1),
(4, '2025-06-02 09:15:00', '2025-06-02 09:45:00', 19, 1, 2),
(5, '2025-06-03 10:15:00', '2025-06-03 10:45:00', 20, 2, 2),
(6, '2025-06-04 11:15:00', '2025-06-04 11:55:00', 20, 3, 2),
(7, '2025-06-02 09:20:00', '2025-06-02 09:50:00', 10, 1, 3), -- desaprobado
(8, '2025-06-03 10:20:00', '2025-06-03 10:50:00', 11, 2, 3), -- desaprobado
(9, '2025-06-04 11:20:00', '2025-06-04 11:55:00', 15, 3, 3),
(10, '2025-06-02 09:25:00', '2025-06-02 09:55:00', 18, 1, 4),
(11, '2025-06-03 10:25:00', '2025-06-03 10:55:00', 17, 2, 4),
(12, '2025-06-04 11:25:00', '2025-06-04 11:59:00', 20, 3, 4),
(13, '2025-06-05 09:00:00', '2025-06-05 09:40:00', 15, 4, 5),
(14, '2025-06-06 09:00:00', '2025-06-06 09:40:00', 18, 5, 5),
(15, '2025-06-05 09:10:00', '2025-06-05 09:50:00', 10, 4, 6), -- desaprobado
(16, '2025-06-06 09:10:00', '2025-06-06 09:50:00', 19, 5, 6),
(17, '2025-06-05 09:20:00', '2025-06-05 09:55:00', 17, 4, 7),
(18, '2025-06-06 09:20:00', '2025-06-06 09:55:00', 16, 5, 7);

DELETE FROM intento_evaluacion;

SELECT * FROM intento_evaluacion;

-- Ejemplo registro de respuestas para ese intento
INSERT INTO registro_examen (id_registro, id_intento, id_evaluaciones, id_alternativas, id_pregunta) VALUES
(1, 1, 1, 1, 1),  -- Pregunta 1, alternativa correcta
(2, 1, 1, 5, 2),  -- Pregunta 2, alternativa correcta
(3, 1, 1, 9, 3),  -- Pregunta 3, alternativa correcta
(4, 1, 1, 13, 4), -- Pregunta 4, alternativa correcta
(5, 1, 1, 17, 5); -- Pregunta 5, alternativa correcta

SELECT puntaje
FROM intento_evaluacion
WHERE id_estudiantes = 1 AND id_evaluaciones = 1;

/*. ¿Cuántos alumnos desaprobados tenemos en total? */
SELECT COUNT(DISTINCT id_estudiantes) AS total_desaprobados
FROM intento_evaluacion
WHERE puntaje < 14;

/*.¿Cuántos alumnos aprobados en un determinado curso tenemos? */
SELECT COUNT(DISTINCT id_estudiantes) AS total_aprobados
FROM intento_evaluacion
WHERE id_evaluaciones = 1 AND puntaje >= 14;

/* ¿A cuántos exámenes está inscrito un alumno y cuántos de ellos están resueltos y 
pendientes? */
SELECT 
    e.id_estudiantes,
    COUNT(DISTINCT a.id_evaluaciones) AS exámenes_inscritos,
    COUNT(DISTINCT i.id_evaluaciones) AS exámenes_resueltos,
    COUNT(DISTINCT a.id_evaluaciones) - COUNT(DISTINCT i.id_evaluaciones) AS exámenes_pendientes
FROM etudiantes e
JOIN asignacion a ON e.id_estudiantes = a.id_estudiante
LEFT JOIN intento_evaluacion i 
    ON i.id_estudiantes = e.id_estudiantes AND i.id_evaluaciones = a.id_evaluaciones
WHERE e.id_estudiantes = 1
GROUP BY e.id_estudiantes;


/*¿Cuál es la mejor y peor calificación de una determinada evaluación?  */
SELECT 
    MAX(puntaje) AS mejor_calificacion,
    MIN(puntaje) AS peor_calificacion
FROM intento_evaluacion
WHERE id_evaluaciones = 1;

/*e. ¿Cómo calcularíamos el promedio de calificaciones de un estudiante?  */
SELECT 
    id_estudiantes,
    AVG(puntaje) AS promedio_calificaciones
FROM intento_evaluacion
WHERE id_estudiantes = 1
GROUP BY id_estudiantes;





