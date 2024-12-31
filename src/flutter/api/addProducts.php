<?php
  header('Content-Type: application/json');
  header("Access-Control-Allow-Origin: *");
  include "connection-pdo.php";

  $product_id = $_POST['product_id'];
  $name = $_POST['name'];
  $category_id = $_POST['category_id'];
  $price = $_POST['price'];
  $expired_date = $_POST['expired_date'];
  $barcode = $_POST['barcode'];
  $soldBy = $_POST['soldBy'];
  $unit = $_POST['unit'];
  $stock = $_POST['stock'];
  $location = $_POST['location'];
  $date_imported = $_POST['date_imported'];

  $sql = "INSERT INTO product(product_id, product_name, category_id, unit_price, expired_date, barcode, supplier_id, unit, stock, location, date_imported) ";
  $sql .= "VALUES (:product_id, :product_name, :category_id, :unit_price, :expired_date, :barcode, :supplier_id, :unit, :stock, :location, :date_imported) ";
  $stmt = $conn->prepare($sql);
  $stmt->bindParam(":product_id", $product_id);
  $stmt->bindParam(":product_name", $name);
  $stmt->bindParam(":category_id", $category_id);
  $stmt->bindParam(":unit_price", $price);
  $stmt->bindParam(":expired_date", $expired_date);
  $stmt->bindParam(":barcode", $barcode);
  $stmt->bindParam(":supplier_id", $soldBy);
  $stmt->bindParam(":unit", $unit);
  $stmt->bindParam(":stock", $stock);
  $stmt->bindParam(":location", $location);
  $stmt->bindParam(":date_imported", $date_imported);
  $stmt->execute();
  $returnValue = $stmt->rowCount() > 0 ? 1 : 0;
  
  echo json_encode($returnValue);
?>