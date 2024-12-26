<?php
  include "headers.php";
  include "connection-pdo.php";

  $username = $_POST['username'];
  $password = $_POST['password'];
  $fullname = $_POST['fullname'];

  $sql = "INSERT INTO tblusers(usr_username, usr_password, usr_fullname) ";
  $sql .= "VALUES (:username, :password, :fullname) ";
  $stmt = $conn->prepare($sql);
  $stmt->bindParam(":username", $username);
  $stmt->bindParam(":password", $password);
  $stmt->bindParam(":fullname", $fullname);
  $stmt->execute();
  $returnValue = $stmt->rowCount() > 0 ? 1 : 0;
  
  echo json_encode($returnValue);
?>