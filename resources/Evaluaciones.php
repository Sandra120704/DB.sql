<?php
class Evaluaciones {
    private $conn;
    private $table = "evaluaciones";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Crear una evaluación
    public function create($nombre, $id_tipo, $id_administrador, $fecha_inicio, $fecha_fin, $duracion, $estado) {
        $sql = "INSERT INTO $this->table (nombre, id_tipo, id_administrador, fecha_inicio, fecha_fin, duracion, estado)
                VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("siissis", $nombre, $id_tipo, $id_administrador, $fecha_inicio, $fecha_fin, $duracion, $estado);
        return $stmt->execute();
    }

    // Obtener todas las evaluaciones
    public function getAll() {
        $sql = "SELECT * FROM $this->table";
        $result = $this->conn->query($sql);
        $evaluaciones = [];

        while ($row = $result->fetch_assoc()) {
            $evaluaciones[] = $row;
        }

        return $evaluaciones;
    }
}
?>
