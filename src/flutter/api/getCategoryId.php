<?php
  header('Content-Type: application/json');
  header("Access-Control-Allow-Origin: *");
  include "connection-pdo.php";

$description = $_POST['description'];

$sql = "SELECT category_id FROM category WHERE description = :description";
$stmt = $conn->prepare($sql);
$stmt->execute(['description' => $description]);

$result = $stmt->fetch(PDO::FETCH_ASSOC);
echo json_encode($result['category_id']);

?>