<?php
  header('Content-Type: application/json');
  header("Access-Control-Allow-Origin: *");

  include "connection-pdo.php";

  $sql = "SELECT category_id, description FROM category
  ORDER BY category_id";
  $stmt = $conn->prepare($sql);
  $stmt->execute();
  $category = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  echo json_encode($category);
?>