-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2025 at 10:29 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fuel_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `fuel_prices`
--

CREATE TABLE `fuel_prices` (
  `fuel_type` varchar(20) NOT NULL,
  `price_per_liter` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fuel_prices`
--

INSERT INTO `fuel_prices` (`fuel_type`, `price_per_liter`) VALUES
('DIESEL', 1.00),
('PETROL', 1.20);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `fuel_type` varchar(20) NOT NULL,
  `volume` decimal(8,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `transaction_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `user_id`, `fuel_type`, `volume`, `cost`, `transaction_time`) VALUES
(1, 7, 'PETROL', 2.00, 2.40, '2025-11-26 00:29:24'),
(2, 7, 'PETROL', 2.00, 2.40, '2025-11-26 00:30:06'),
(3, 7, 'PETROL', 2.00, 2.40, '2025-11-26 00:30:11'),
(4, 7, 'PETROL', 2.00, 2.40, '2025-11-26 00:30:15'),
(5, 8, 'PETROL', 2.00, 2.40, '2025-11-26 00:32:57'),
(6, 8, 'PETROL', 2.00, 2.40, '2025-11-26 00:33:04'),
(7, 8, 'PETROL', 1.10, 1.32, '2025-11-26 00:37:41'),
(8, 8, 'PETROL', 1.10, 1.32, '2025-11-26 00:37:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `pin_code` varchar(6) NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `card_number`, `pin_code`, `balance`) VALUES
(1, 'Test User', '1234567890123456', '1234', 100.00),
(2, '567765sdf', '123456', '12345', 0.00),
(3, 'nibishaka cedrick', '123456789', '1111', 0.00),
(4, '2345', '12345', '12345', 0.00),
(5, 'yes', '1234556', '2222', 0.00),
(6, 'ee', '2222', '2222', 0.00),
(7, 'tt', '5555', '5555', -9.60),
(8, 'tttttt', '22226', '1111', -7.44),
(9, 'tttt', '22221', '1111', 0.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fuel_prices`
--
ALTER TABLE `fuel_prices`
  ADD PRIMARY KEY (`fuel_type`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `card_number` (`card_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
