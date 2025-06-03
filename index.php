<?php
// Incluimos la conexión
include 'conexion.php';

// Verificamos si hay error de conexión 
if ($conexion->connect_error) {
    echo "No se pudo conectar a la base de datos: " . $conexion->connect_error;
} else {
    // Consulta SELECT para traer datos de ejemplo }
    $sql = "SELECT id, nombre, edad FROM tabla_ejemplo";
    $resultado = $conexion->query($sql);

    if ($resultado) {
        if ($resultado->num_rows > 0) {
            echo "<h2>Listado de registros:</h2>";
            echo "<ul>";
            while ($fila = $resultado->fetch_assoc()) {
                echo "<li>ID: " . $fila['id'] . " - Nombre: " . $fila['nombre'] . " - Edad: " . $fila['edad'] . "</li>";
            }
            echo "</ul>";
        } else {
            echo "No se encontraron registros.";
        }
        $resultado->free();  // Liberar memoria
    } else {
        echo "Error en la consulta: " . $conexion->error;
    }

    // Cerrar conexión
    $conexion->close();
}
?>
