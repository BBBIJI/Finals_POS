CREATE DATABASE  IF NOT EXISTS `finals_pos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `finals_pos`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: finals_pos
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `description` varchar(100) NOT NULL,
  `picture` longblob,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `description`, `picture`) VALUES
(1, 'Beverages', NULL),
(2, 'Condiments', NULL),
(3, 'Dairy Products', NULL),
(4, 'Grains/Cereals', NULL),
(5, 'Meat/Poultry', NULL),
(6, 'Produce', NULL),
(7, 'Seafood', NULL),
(8, 'Snacks', NULL),
(9, 'Frozen Foods', NULL),
(10, 'Baking Goods', NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_order`
--

DROP TABLE IF EXISTS `customer_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_order` (
  `customer_order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `payment_type` varchar(45) NOT NULL,
  `item_quantity` int NOT NULL,
  `total_cost` double NOT NULL,
  PRIMARY KEY (`customer_order_id`),
  KEY `product_id_idx` (`product_id`),
  CONSTRAINT `fk_customer_order_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_order`
--

LOCK TABLES `customer_order` WRITE;
/*!40000 ALTER TABLE `customer_order` DISABLE KEYS */;
INSERT INTO `customer_order` (`customer_order_id`, `product_id`, `payment_type`, `item_quantity`, `total_cost`) VALUES
(1, 1, 'Credit Card', 2, 3.0),
(2, 5, 'Cash', 3, 15.0),
(3, 7, 'Credit Card', 5, 4.0),
(4, 9, 'Mobile Payment', 1, 1.8),
(5, 6, 'Cash', 2, 14.0);

/*!40000 ALTER TABLE `customer_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `product_name` varchar(45) NOT NULL,
  `unit_price` double NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id_idx` (`category_id`),
  KEY `supplier_id_idx` (`supplier_id`),
  CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`product_id`, `category_id`, `supplier_id`, `product_name`, `unit_price`) VALUES
(1, 1, 1, 'Cola', 1.5),
(2, 1, 1, 'Orange Juice', 2.0),
(3, 3, 3, 'Cheddar Cheese', 3.0),
(4, 3, 3, 'Yogurt', 1.0),
(5, 5, 4, 'Chicken Breast', 5.0),
(6, 7, 5, 'Salmon', 7.0),
(7, 4, 2, 'Rice', 0.8),
(8, 2, 2, 'Ketchup', 1.2),
(9, 8, 1, 'Potato Chips', 1.8),
(10, 9, 1, 'Frozen Pizza', 4.0);

/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `birthday` date NOT NULL,
  `admin` int NOT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` (`staff_id`, `username`, `password`, `first_name`, `last_name`, `birthday`, `admin`) VALUES
(1, 'admin1', 'pass123', 'Alice', 'Smith', '1990-05-15', 1),
(2, 'cashier1', 'cashier123', 'Bob', 'Jones', '1995-07-22', 0),
(3, 'cashier2', 'cashier456', 'Charlie', 'Brown', '1998-03-10', 0),
(4, 'manager1', 'manager123', 'David', 'White', '1988-11-30', 1);

/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage`
--

DROP TABLE IF EXISTS `storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage` (
  `storage_id` int NOT NULL,
  `product_id` int NOT NULL,
  `exp_date` date NOT NULL,
  `item_quantity` int NOT NULL,
  PRIMARY KEY (`storage_id`),
  KEY `product_id_idx` (`product_id`),
  CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage`
--

LOCK TABLES `storage` WRITE;
/*!40000 ALTER TABLE `storage` DISABLE KEYS */;
INSERT INTO `storage` (`storage_id`, `product_id`, `exp_date`, `item_quantity`) VALUES
(1, 1, '2024-12-31', 100),
(2, 3, '2024-11-15', 50),
(3, 5, '2024-10-10', 200),
(4, 7, '2025-01-01', 300),
(5, 9, '2024-09-20', 150);

/*!40000 ALTER TABLE `storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplier_id` int NOT NULL,
  `company_name` varchar(45) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `emial` varchar(45) NOT NULL,
  `company_address` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `postal_code` varchar(45) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` (`supplier_id`, `company_name`, `phone_number`, `emial`, `company_address`, `city`, `state`, `country`, `postal_code`) VALUES
(1, 'Fresh Foods Co.', '123-456-7890', 'contact@freshfoods.com', '123 Green St', 'Los Angeles', 'CA', 'USA', '90001'),
(2, 'Global Spices', '234-567-8901', 'info@globalspices.com', '456 Spice Lane', 'Chicago', 'IL', 'USA', '60605'),
(3, 'Dairy World', '345-678-9012', 'sales@dairyworld.com', '789 Dairy Ave', 'Madison', 'WI', 'USA', '53703'),
(4, 'Meat Market', '456-789-0123', 'support@meatmarket.com', '321 Meat St', 'Houston', 'TX', 'USA', '77002'),
(5, 'Seafood Delights', '567-890-1234', 'customer_orders@seafoodd.com', '654 Ocean Blvd', 'Seattle', 'WA', 'USA', '98101');

/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-21 22:55:11
