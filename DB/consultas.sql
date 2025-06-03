-- CONSULTAS Dela analisis Aprende_Peru

/* a) Cantidad total de alumnos desaprobados*/
SELECT COUNT(DISTINCT id_estudiantes) AS alumnos_desaprobados
FROM intento_evaluacion
WHERE puntaje < 12;

/* b) Cantidad de alumnos aprobados en un determinado curso */
SELECT COUNT(DISTINCT id_estudiantes) AS alumnos_aprobados
FROM intento_evaluacion
WHERE id_evaluaciones = 2 AND puntaje >= 11;

/*c) Número de exámenes inscritos, resueltos y pendientes para un alumno*/
SELECT 
  (SELECT COUNT(*) FROM asignacion WHERE id_estudiantes = 1) AS total_inscritos,
  (SELECT COUNT(*) FROM intento_evaluacion WHERE id_estudiantes = 1) AS resueltos,
  (SELECT COUNT(*) FROM asignacion WHERE id_estudiantes = 1) - 
  (SELECT COUNT(*) FROM intento_evaluacion WHERE id_estudiantes = 1) AS pendientes;

/*d) Mejor y peor calificación de una evaluación*/
SELECT 
  MAX(puntaje) AS mejor_calificacion,Ñ
  MIN(puntaje) AS peor_calificacion
FROM intento_evaluacion
WHERE id_evaluaciones = 1;

/*e) Promedio de calificaciones de un estudiante*/
SELECT AVG(puntaje) AS promedio_calificacion
FROM intento_evaluacion
WHERE id_estudiantes = 1;
