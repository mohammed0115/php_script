-- phpMyAdmin SQL Dump
-- version 4.6.6deb1+deb.cihar.com~trusty.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 16, 2022 at 05:09 PM
-- Server version: 5.6.33-0ubuntu0.14.04.1
-- PHP Version: 7.0.15-1+deb.sury.org~trusty+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `script`
--

-- --------------------------------------------------------

--
-- Table structure for table `Card`
--

CREATE TABLE `Card` (
  `id` int(11) NOT NULL,
  `key` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL,
  `subcategory` int(11) DEFAULT NULL,
  `serial` mediumtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `Card`
--

INSERT INTO `Card` (`id`, `key`, `state`, `createdAt`, `subcategory`, `serial`) VALUES
(121497, '29M9M-WHTJT-3D9VK-G446D-DR4GZ', 'Sold', '2020-09-16 09:46:51.042', 67, NULL),
(121498, 'T6734-FTGD2-MJDVH-PP93Q-RC6GZ', 'Sold', '2020-09-16 09:46:51.042', 67, NULL),
(121499, 'KPTWG-69Y9V-X743M-H6Y36-YFJ7Z', 'Sold', '2020-09-16 09:46:51.042', 67, NULL),
(121500, 'GMPR4-KYV74-D3JX6-VWHPQ-3R9JZ', 'Sold', '2020-09-16 09:46:51.042', 67, NULL),
(121501, '6K6GG-PRJMJ-YRD6J-KFGWM-3JTTZ', 'Sold', '2020-09-16 09:46:51.042', 67, NULL),
(121534, '4CDKM-WCQ29-MMVQY-XTMKG-PH2QZ', 'Sold', '2020-09-16 09:46:51.043', 67, NULL),
(121535, 'GG4FJ-34F3V-J4443-X7DQC-GRY7Z', 'Sold', '2020-09-16 09:46:51.043', 67, NULL),
(121536, 'MCJK9-WQ6MG-FPKPQ-D2HPX-PMMKZ', 'Available', '2020-09-16 09:46:51.043', 67, NULL),
(121543, '396H9-C663M-J2J4H-RXG3C-H7FFZ', 'Sold', '2020-09-16 09:46:51.043', 67, NULL),
(1240413, 'X68VD83VRTR2HQKL', 'Available', '2022-05-15 15:40:13.697', 67, NULL),
(1240502, '123123wwed', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240503, '121fr12r12', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240504, '154,000154', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240505, '155,000155', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240506, '156,000156', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240507, '410,000410', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240508, '411,000411', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240509, '412,000412', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240510, '666,000666', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL'),
(1240511, '667,000667', 'Available', '2022-05-16 13:56:31.000', 67, 'NULL');

-- --------------------------------------------------------

--
-- Table structure for table `Category`
--

CREATE TABLE `Category` (
  `id` int(11) NOT NULL,
  `name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `smallImage` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `hide` tinyint(1) NOT NULL,
  `createdAt` datetime(3) NOT NULL,
  `updatedAt` datetime(3) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `instruction` mediumtext COLLATE utf8mb4_unicode_ci,
  `urlInstruction` mediumtext COLLATE utf8mb4_unicode_ci,
  `sku` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `Category`
--

INSERT INTO `Category` (`id`, `name`, `image`, `smallImage`, `hide`, `createdAt`, `updatedAt`, `order`, `instruction`, `urlInstruction`, `sku`) VALUES
(7, 'XBOX', '/cards/xbox.png', '///uploads/2188f1e1-1cb1-49a2-a8a1-c25c2367ecc0.jpg', 0, '2019-11-22 15:01:11.478', '2021-04-13 12:05:29.066', 11, NULL, NULL, 427);

-- --------------------------------------------------------

--
-- Table structure for table `check_order`
--

CREATE TABLE `check_order` (
  `id` int(11) NOT NULL,
  `reference` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_sku` int(10) NOT NULL,
  `order_qty` int(10) NOT NULL,
  `status` int(11) NOT NULL,
  `order_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `check_order`
--

INSERT INTO `check_order` (`id`, `reference`, `product_sku`, `order_qty`, `status`, `order_date`) VALUES
(4, '06491859-577c-4dfd-8f1e-f43ddf2c2b7d', 427, 10, 1, '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `quantity_need`
--

CREATE TABLE `quantity_need` (
  `qty` int(11) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quantity_need`
--

INSERT INTO `quantity_need` (`qty`, `id`) VALUES
(5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `SubCategory`
--

CREATE TABLE `SubCategory` (
  `id` int(11) NOT NULL,
  `name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(65,30) NOT NULL,
  `hide` tinyint(1) NOT NULL,
  `createdAt` datetime(3) NOT NULL,
  `updatedAt` datetime(3) NOT NULL,
  `category` int(11) DEFAULT NULL,
  `buyPrice` decimal(65,30) DEFAULT NULL,
  `store` enum('usd','iqd') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'usd'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `SubCategory`
--

INSERT INTO `SubCategory` (`id`, `name`, `price`, `hide`, `createdAt`, `updatedAt`, `category`, `buyPrice`, `store`) VALUES
(67, 'Xbox Live 3 Month', '17.000000000000000000000000000000', 0, '2019-12-22 12:02:12.119', '2022-02-20 08:25:05.672', 7, '16.360000000000000000000000000000', 'usd');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Card`
--
ALTER TABLE `Card`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `subcategory` (`subcategory`) USING BTREE;

--
-- Indexes for table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `check_order`
--
ALTER TABLE `check_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quantity_need`
--
ALTER TABLE `quantity_need`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `SubCategory`
--
ALTER TABLE `SubCategory`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `category` (`category`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Card`
--
ALTER TABLE `Card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1240512;
--
-- AUTO_INCREMENT for table `Category`
--
ALTER TABLE `Category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;
--
-- AUTO_INCREMENT for table `check_order`
--
ALTER TABLE `check_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `quantity_need`
--
ALTER TABLE `quantity_need`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `SubCategory`
--
ALTER TABLE `SubCategory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=605;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Card`
--
ALTER TABLE `Card`
  ADD CONSTRAINT `Card_ibfk_1` FOREIGN KEY (`subcategory`) REFERENCES `SubCategory` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `SubCategory`
--
ALTER TABLE `SubCategory`
  ADD CONSTRAINT `SubCategory_ibfk_1` FOREIGN KEY (`category`) REFERENCES `Category` (`id`) ON DELETE SET NULL;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
