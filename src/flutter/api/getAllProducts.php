<?php
  header('Content-Type: application/json');
  header("Access-Control-Allow-Origin: *");

  include "connection-pdo.php";

  $sql = "SELECT p.*, c.description 
FROM product p
JOIN category c ON p.category_id = c.category_id
ORDER BY p.product_id;
";
  $stmt = $conn->prepare($sql);
  $stmt->execute();
  $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
  echo json_encode($products);
?>