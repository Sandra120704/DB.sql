<?php
$host = "localhost";
$user = "root";
$password = "";
$db = "Aprende_Peru";

$conexion = new mysqli($host, $user, $password, $db);

if ($conexion->connect_error) {
  echo "No se pudo conectar a la base de datos.";

  // Registrar el error en el log del servidor
  error_log("Error de conexión: " . $conexion->connect_error);
}
?>
