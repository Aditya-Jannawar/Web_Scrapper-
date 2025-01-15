-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 10, 2024 at 01:56 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flipkart_scraper_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `data_points`
--

CREATE TABLE `data_points` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `data_points`
--

INSERT INTO `data_points` (`id`, `name`) VALUES
(2, 'price'),
(1, 'product_name'),
(3, 'rating');

-- --------------------------------------------------------

--
-- Table structure for table `scraped_data`
--

CREATE TABLE `scraped_data` (
  `id` int(11) NOT NULL,
  `website_id` int(11) NOT NULL,
  `scraped_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scraped_data`
--

INSERT INTO `scraped_data` (`id`, `website_id`, `scraped_at`) VALUES
(1, 1, '2024-10-10 16:30:20'),
(2, 1, '2024-10-10 16:30:21'),
(3, 1, '2024-10-10 16:32:50'),
(4, 1, '2024-10-10 16:34:53'),
(5, 1, '2024-10-10 16:36:14'),
(6, 1, '2024-10-10 16:36:47'),
(7, 1, '2024-10-10 16:53:09');

-- --------------------------------------------------------

--
-- Table structure for table `scraped_values`
--

CREATE TABLE `scraped_values` (
  `id` int(11) NOT NULL,
  `scraped_data_id` int(11) NOT NULL,
  `data_point_id` int(11) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scraped_values`
--

INSERT INTO `scraped_values` (`id`, `scraped_data_id`, `data_point_id`, `value`) VALUES
(1, 7, 1, 'Vmd Bamboo basket with Handle Best for Picnic Basket, K...'),
(2, 7, 2, '₹1,199'),
(3, 7, 3, '4.8'),
(4, 7, 1, 'Vmd OVEL 12\" BROWN BASKET WITH HANDLE FOR FRUIT STORAGE...'),
(5, 7, 2, '₹799'),
(6, 7, 3, '4'),
(7, 7, 1, 'SHRUSTAM hexagon 5\" PINK BASKET USE FOR FRUIT STORAGE ,...'),
(8, 7, 2, '₹457'),
(9, 7, 3, '3.7'),
(10, 7, 1, 'Vmd Ro. 10\" BROWN BASKET FOR FRUIT STORAGE , HEMPAR , G...'),
(11, 7, 2, '₹448'),
(12, 7, 3, 'No rating'),
(13, 7, 1, 'Vmd 9\" white Bamboo Basket for Home, Kitchen, Gift Deco...'),
(14, 7, 2, '₹449'),
(15, 7, 3, 'No rating'),
(16, 7, 1, 'Aleena creations Full Oval Deep Wicker Baskets, Gift Ha...'),
(17, 7, 2, '₹699'),
(18, 7, 3, 'No rating'),
(19, 7, 1, 'Aleena creations Oval Deep Cane Flower/Gift Hamper/Stor...'),
(20, 7, 2, '₹599'),
(21, 7, 3, 'No rating'),
(22, 7, 1, 'Aleena creations Square Shape Cane Flower/Gift/ Kitchen...'),
(23, 7, 2, '₹699'),
(24, 7, 3, 'No rating'),
(25, 7, 1, 'Vmd RO. 6\" BLUE Glitter Poms BASKET USE FOR, DECORATION...'),
(26, 7, 2, '₹499'),
(27, 7, 3, 'No rating'),
(28, 7, 1, 'Vmd Bamboo Fruit & Vegetable Basket'),
(29, 7, 2, '₹471'),
(30, 7, 3, '2.7'),
(31, 7, 1, 'WB Products Bamboo Fruit & Vegetable Basket'),
(32, 7, 2, '₹699'),
(33, 7, 3, 'No rating'),
(34, 7, 1, 'HADIYAL Glass Cookie Jar  - 1050 ml'),
(35, 7, 2, '₹716'),
(36, 7, 3, '4'),
(37, 7, 1, 'Jahap Creation Glass, Wooden Utility Container  - 700 m...'),
(38, 7, 2, '₹779'),
(39, 7, 3, '4.8'),
(40, 7, 1, 'Vmd RO. 6\" YELLOW Glitter Poms BASKET USE FOR, DECORATI...'),
(41, 7, 2, '₹499'),
(42, 7, 3, 'No rating'),
(43, 7, 1, 'Vmd RO. 6\" BLACK Glitter Poms BASKET USE FOR, DECORATIO...'),
(44, 7, 2, '₹499'),
(45, 7, 3, 'No rating'),
(46, 7, 1, 'Vmd RO. 6\" PINK Glitter Poms BASKET USE FOR, DECORATION...'),
(47, 7, 2, '₹449'),
(48, 7, 3, 'No rating'),
(49, 7, 1, 'MBA TOKRI VALA Round Handmade Asam Bamboo Basket For Ve...'),
(50, 7, 2, '₹799'),
(51, 7, 3, '3'),
(52, 7, 1, 'Aleena creations Oval Deep Jali Cane Flower/Gift/ Kitch...'),
(53, 7, 2, '₹639'),
(54, 7, 3, 'No rating'),
(55, 7, 1, 'Aleena creations Round Jali Flower/Gift Hamper/Storage ...'),
(56, 7, 2, '₹469'),
(57, 7, 3, 'No rating'),
(58, 7, 1, 'Aleena creations Round Bunai Cane Wicker Basket Flower/...'),
(59, 7, 2, '₹345'),
(60, 7, 3, 'No rating'),
(61, 7, 1, 'SMILERY Salt & Pepper Set Ceramic, Bamboo'),
(62, 7, 2, '₹999'),
(63, 7, 3, 'No rating'),
(64, 7, 1, 'Aleena creations Round Bunai Cane Wicker Basket Flower/...'),
(65, 7, 2, '₹369'),
(66, 7, 3, 'No rating'),
(67, 7, 1, 'Aleena creations Round Kangri Model Chocolate Hamper Mu...'),
(68, 7, 2, '₹499'),
(69, 7, 3, 'No rating'),
(70, 7, 1, 'TINSUHG Wooden Grocery Container  - 220 ml'),
(71, 7, 2, '₹499'),
(72, 7, 3, 'No rating'),
(73, 7, 1, 'Jahap Creation Glass, Wooden Utility Container  - 700 m...'),
(74, 7, 2, '₹260'),
(75, 7, 3, '4.8'),
(76, 7, 1, 'Akway Wooden Casserole | Roti | Chapati | Paratha | Dry...'),
(77, 7, 2, '₹1,349'),
(78, 7, 3, '3.9'),
(79, 7, 1, 'Nature House Storage Basket Kitchen Vegetables and Frui...'),
(80, 7, 2, '₹699'),
(81, 7, 3, 'No rating'),
(82, 7, 1, 'casakrafts Eco-Friendly Small size Two multipurpose bas...'),
(83, 7, 2, '₹591'),
(84, 7, 3, 'No rating'),
(85, 7, 1, 'Sathiya Bamboo Products Salt & Pepper Set Bamboo'),
(86, 7, 2, '₹1,199'),
(87, 7, 3, 'No rating'),
(88, 7, 1, 'Jahap Creation Glass, Wooden Utility Container  - 700 m...'),
(89, 7, 2, '₹939'),
(90, 7, 3, '4.8'),
(91, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 260 ml, 8...'),
(92, 7, 2, '₹3,085'),
(93, 7, 3, 'No rating'),
(94, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 260 ml, 8...'),
(95, 7, 2, '₹3,085'),
(96, 7, 3, 'No rating'),
(97, 7, 1, 'tyche enterprise Glass Grocery Container  - 500 ml'),
(98, 7, 2, '₹479'),
(99, 7, 3, '3.6'),
(100, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 400 ml'),
(101, 7, 2, '₹619'),
(102, 7, 3, 'No rating'),
(103, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 500 ml, 7...'),
(104, 7, 2, '₹2,710'),
(105, 7, 3, 'No rating'),
(106, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 635 ml'),
(107, 7, 2, '₹749'),
(108, 7, 3, 'No rating'),
(109, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 620 ml'),
(110, 7, 2, '₹676'),
(111, 7, 3, 'No rating'),
(112, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 680 ml'),
(113, 7, 2, '₹749'),
(114, 7, 3, 'No rating'),
(115, 7, 1, 'Massive Reckon Glass Utility Container  - 1000 ml'),
(116, 7, 2, '₹1,399'),
(117, 7, 3, 'No rating'),
(118, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 260 ml'),
(119, 7, 2, '₹635'),
(120, 7, 3, 'No rating'),
(121, 7, 1, 'Essences Of Life O Basket Wooden Fruit & Vegetable Bask...'),
(122, 7, 2, '₹4,599'),
(123, 7, 3, 'No rating'),
(124, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 400 ml'),
(125, 7, 2, '₹619'),
(126, 7, 3, 'No rating'),
(127, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 680 ml'),
(128, 7, 2, '₹676'),
(129, 7, 3, 'No rating'),
(130, 7, 1, 'Avresta Glass, Wooden Cookie Jar  - 700 ml, 1000 ml, 14...'),
(131, 7, 2, '₹899'),
(132, 7, 3, 'No rating'),
(133, 7, 1, 'DHANSAL Salt & Pepper Set Ceramic'),
(134, 7, 2, '₹460'),
(135, 7, 3, 'No rating'),
(136, 7, 1, 'MBA TOKRI VALA Round Handmade Asam Bamboo Basket For Ve...'),
(137, 7, 2, '₹284'),
(138, 7, 3, 'No rating'),
(139, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 500 ml'),
(140, 7, 2, '₹730'),
(141, 7, 3, 'No rating'),
(142, 7, 1, 'Avresta Glass Grocery Container  - 700 ml'),
(143, 7, 2, '₹899'),
(144, 7, 3, 'No rating'),
(145, 7, 1, 'Diyansh Glass Tea Coffee & Sugar Container  - 300 ml'),
(146, 7, 2, '₹1,279'),
(147, 7, 3, 'No rating'),
(148, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 260 ml'),
(149, 7, 2, '₹635'),
(150, 7, 3, 'No rating'),
(151, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 800 ml'),
(152, 7, 2, '₹1,111'),
(153, 7, 3, 'No rating'),
(154, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 800 ml'),
(155, 7, 2, '₹1,055'),
(156, 7, 3, 'No rating'),
(157, 7, 1, 'Jahap Creation Glass, Wooden Utility Container  - 700 m...'),
(158, 7, 2, '₹489'),
(159, 7, 3, '4.8'),
(160, 7, 1, 'Risello Glass Grocery Container  - 1400 ml'),
(161, 7, 2, '₹652'),
(162, 7, 3, '4.8'),
(163, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 500 ml'),
(164, 7, 2, '₹723'),
(165, 7, 3, 'No rating'),
(166, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 400 ml'),
(167, 7, 2, '₹619'),
(168, 7, 3, 'No rating'),
(169, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 1000 ml'),
(170, 7, 2, '₹1,232'),
(171, 7, 3, 'No rating'),
(172, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 530 ml'),
(173, 7, 2, '₹639'),
(174, 7, 3, 'No rating'),
(175, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 500 ml'),
(176, 7, 2, '₹730'),
(177, 7, 3, 'No rating'),
(178, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 1000 ml'),
(179, 7, 2, '₹1,403'),
(180, 7, 3, 'No rating'),
(181, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 260 ml'),
(182, 7, 2, '₹635'),
(183, 7, 3, 'No rating'),
(184, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 950 ml'),
(185, 7, 2, '₹819'),
(186, 7, 3, 'No rating'),
(187, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 350 ml'),
(188, 7, 2, '₹566'),
(189, 7, 3, 'No rating'),
(190, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 850 ml'),
(191, 7, 2, '₹1,111'),
(192, 7, 3, 'No rating'),
(193, 7, 1, 'Diyansh Glass Tea Coffee & Sugar Container  - 300 ml'),
(194, 7, 2, '₹1,849'),
(195, 7, 3, 'No rating'),
(196, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 1000 ml'),
(197, 7, 2, '₹1,232'),
(198, 7, 3, 'No rating'),
(199, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 1000 ml'),
(200, 7, 2, '₹1,403'),
(201, 7, 3, 'No rating'),
(202, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 400 ml'),
(203, 7, 2, '₹619'),
(204, 7, 3, 'No rating'),
(205, 7, 1, 'KUBER INDUSTRIES Glass Utility Container  - 820 ml'),
(206, 7, 2, '₹723'),
(207, 7, 3, 'No rating'),
(208, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 1000 ml'),
(209, 7, 2, '₹1,403'),
(210, 7, 3, 'No rating'),
(211, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 500 ml'),
(212, 7, 2, '₹730'),
(213, 7, 3, 'No rating'),
(214, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 1000 ml'),
(215, 7, 2, '₹1,232'),
(216, 7, 3, 'No rating'),
(217, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 800 ml'),
(218, 7, 2, '₹1,055'),
(219, 7, 3, 'No rating'),
(220, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 850 ml'),
(221, 7, 2, '₹1,111'),
(222, 7, 3, 'No rating'),
(223, 7, 1, 'Coozico Glass Grocery Container  - 220 ml'),
(224, 7, 2, '₹699'),
(225, 7, 3, 'No rating'),
(226, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 1000 ml'),
(227, 7, 2, '₹1,403'),
(228, 7, 3, 'No rating'),
(229, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 800 ml'),
(230, 7, 2, '₹1,111'),
(231, 7, 3, 'No rating'),
(232, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 800 ml'),
(233, 7, 2, '₹1,111'),
(234, 7, 3, 'No rating'),
(235, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 700 ml'),
(236, 7, 2, '₹1,031'),
(237, 7, 3, 'No rating'),
(238, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 800 ml'),
(239, 7, 2, '₹1,055'),
(240, 7, 3, 'No rating'),
(241, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 850 ml'),
(242, 7, 2, '₹1,111'),
(243, 7, 3, 'No rating'),
(244, 7, 1, 'Star Work Glass Cookie Jar  - 500 ml'),
(245, 7, 2, '₹699'),
(246, 7, 3, 'No rating'),
(247, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 800 ml'),
(248, 7, 2, '₹1,212'),
(249, 7, 3, 'No rating'),
(250, 7, 1, 'MANTRAA SALES Glass Grocery Container  - 320 ml'),
(251, 7, 2, '₹999'),
(252, 7, 3, 'No rating'),
(253, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 700 ml'),
(254, 7, 2, '₹1,031'),
(255, 7, 3, 'No rating'),
(256, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 500 ml, 7...'),
(257, 7, 2, '₹2,710'),
(258, 7, 3, 'No rating'),
(259, 7, 1, 'TINSUHG Wooden Grocery Container  - 220 ml'),
(260, 7, 2, '₹362'),
(261, 7, 3, 'No rating'),
(262, 7, 1, 'TINSUHG Glass Utility Container  - 385 ml'),
(263, 7, 2, '₹588'),
(264, 7, 3, 'No rating'),
(265, 7, 1, 'UMAI Ceramic Cereal Dispenser  - 400 ml'),
(266, 7, 2, '₹569'),
(267, 7, 3, 'No rating'),
(268, 7, 1, 'SkyKey Glass Cookie Jar  - 220 ml'),
(269, 7, 2, '₹499'),
(270, 7, 3, 'No rating'),
(271, 7, 1, 'Anaya AfroZ Spice Set Wooden'),
(272, 7, 2, '₹645'),
(273, 7, 3, '3.3'),
(274, 7, 1, 'Massive Reckon Glass Utility Container  - 1000 ml'),
(275, 7, 2, '₹1,299'),
(276, 7, 3, 'No rating'),
(277, 7, 1, 'Hatanu Mall Glass, Wooden Grocery Container  - 1580 ml'),
(278, 7, 2, '₹1,149'),
(279, 7, 3, 'No rating'),
(280, 7, 1, 'KUBER INDUSTRIES Ceramic Utility Container  - 700 ml'),
(281, 7, 2, '₹1,031'),
(282, 7, 3, 'No rating'),
(283, 7, 1, 'UMAI Ceramic Tea Coffee & Sugar Container  - 800 ml'),
(284, 7, 2, '₹909'),
(285, 7, 3, 'No rating'),
(286, 7, 1, 'NAVPATH Glass, Wooden Cookie Jar  - 700 ml, 1000 ml, 14...'),
(287, 7, 2, '₹899'),
(288, 7, 3, 'No rating'),
(289, 7, 1, 'UMAI Ceramic Cereal Dispenser  - 1000 ml'),
(290, 7, 2, '₹2,039'),
(291, 7, 3, 'No rating'),
(292, 7, 1, 'UMAI Ceramic Cereal Dispenser  - 800 ml'),
(293, 7, 2, '₹1,699'),
(294, 7, 3, 'No rating'),
(295, 7, 1, 'IRA Roti Basket Bamboo Fruit & Vegetable Basket'),
(296, 7, 2, '₹1,290'),
(297, 7, 3, 'No rating'),
(298, 7, 1, 'Flickers and Flame Hoop Cane Basket Bamboo Fruit & Vege...'),
(299, 7, 2, '₹599'),
(300, 7, 3, 'No rating');

-- --------------------------------------------------------

--
-- Table structure for table `websites`
--

CREATE TABLE `websites` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `websites`
--

INSERT INTO `websites` (`id`, `name`) VALUES
(1, 'Flipkart');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_points`
--
ALTER TABLE `data_points`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `scraped_data`
--
ALTER TABLE `scraped_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `scraped_values`
--
ALTER TABLE `scraped_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `scraped_data_id` (`scraped_data_id`),
  ADD KEY `data_point_id` (`data_point_id`);

--
-- Indexes for table `websites`
--
ALTER TABLE `websites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_points`
--
ALTER TABLE `data_points`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `scraped_data`
--
ALTER TABLE `scraped_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `scraped_values`
--
ALTER TABLE `scraped_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

--
-- AUTO_INCREMENT for table `websites`
--
ALTER TABLE `websites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `scraped_data`
--
ALTER TABLE `scraped_data`
  ADD CONSTRAINT `scraped_data_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `scraped_values`
--
ALTER TABLE `scraped_values`
  ADD CONSTRAINT `scraped_values_ibfk_1` FOREIGN KEY (`scraped_data_id`) REFERENCES `scraped_data` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `scraped_values_ibfk_2` FOREIGN KEY (`data_point_id`) REFERENCES `data_points` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
