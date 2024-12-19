<?php
  header('Content-Type: application/json');
  header("Access-Control-Allow-Origin: *");

  include "connection-pdo.php";

  $sql = "SELECT * FROM product
  ORDER BY product_name";
  $stmt = $conn->prepare($sql);
  $stmt->execute();
  $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  echo json_encode($products);
?>