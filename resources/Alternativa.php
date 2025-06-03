<?php
class Alternativas {
    private $conn;
    private $table = "alternativa";

    public function __construct($db) {
        $this->conn = $db;
    }

    // Crear una alternativa
    public function create($id_preguntas, $texto, $es_correcta) {
        $sql = "INSERT INTO $this->table (id_preguntas, texto, es_correcta) VALUES (?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("isi", $id_preguntas, $texto, $es_correcta);
        return $stmt->execute();
    }

    // Obtener todas las alternativas
    public function getAll() {
        $sql = "SELECT * FROM $this->table";
        $result = $this->conn->query($sql);
        $alternativas = [];

        while ($row = $result->fetch_assoc()) {
            $alternativas[] = $row;
        }

        return $alternativas;
    }
}
?>