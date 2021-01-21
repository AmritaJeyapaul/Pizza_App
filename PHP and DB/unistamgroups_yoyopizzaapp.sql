-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 24, 2020 at 11:32 PM
-- Server version: 10.3.24-MariaDB-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `unistamgroups_yoyopizzaapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `autogen`
--

CREATE TABLE `autogen` (
  `ord_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `autogen`
--

INSERT INTO `autogen` (`ord_id`) VALUES
(3);

-- --------------------------------------------------------

--
-- Table structure for table `foods`
--

CREATE TABLE `foods` (
  `food_id` varchar(100) NOT NULL,
  `variety` varchar(200) NOT NULL,
  `food_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `foods`
--

INSERT INTO `foods` (`food_id`, `variety`, `food_name`) VALUES
('F001', 'Pizza', 'Margherita Pizza'),
('F002', 'Pizza', 'Pepperoni Pizza'),
('F003', 'Pizza', 'Hawaiian Pizza '),
('F004', 'Pizza', ' Spaghetti Pizza'),
('F005', 'Pizza', 'BBQ Chicken Pizza '),
('F006', 'Rice Bowl', ' Tuna Rice Bowl'),
('F007', 'Rice Bowl', ' Veggie Rice Bowl '),
('F008', 'Rice Bowl', ' Sesame Rice Bowl '),
('F009', 'Taco', 'Chicken Verde Taco'),
('F010', 'Taco', 'Steak Taco'),
('F011', 'Taco', 'Carnitas Taco'),
('F012', 'Ice Cream', 'Cookies & Cream'),
('F013', 'Ice Cream', 'Buttered Pecan'),
('F014', 'Ice Cream', 'Moose Tracks'),
('F015', 'Ice Cream', 'Banana Split');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `ord_id` varchar(200) NOT NULL,
  `ord_items` varchar(2000) NOT NULL,
  `ord_name` varchar(200) NOT NULL,
  `ord_address` varchar(500) NOT NULL,
  `ord_phone` varchar(100) NOT NULL,
  `ord_status` varchar(100) NOT NULL DEFAULT 'Order Placed',
  `ord_time` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `varieties`
--

CREATE TABLE `varieties` (
  `var_id` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `varieties`
--

INSERT INTO `varieties` (`var_id`, `name`) VALUES
('V001', 'Pizza'),
('V002', 'Rice Bowl'),
('V003', 'Taco'),
('V004', 'Ice Cream');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`food_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ord_id`);

--
-- Indexes for table `varieties`
--
ALTER TABLE `varieties`
  ADD PRIMARY KEY (`var_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
