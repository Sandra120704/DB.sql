<?php
class Preguntas {
    private $conn;
    private $table = "preguntas";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Crear una pregunta
    public function create($puntaje, $id_evaluaciones) {
        $sql = "INSERT INTO $this->table (puntaje, id_evaluaciones) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("ii", $puntaje, $id_evaluaciones);
        return $stmt->execute();
    }

    // Obtener todas las preguntas
    public function getAll() {
        $sql = "SELECT * FROM $this->table";
        $result = $this->conn->query($sql);
        $preguntas = [];

        while ($row = $result->fetch_assoc()) {
            $preguntas[] = $row;
        }

        return $preguntas;
    }
}
?>