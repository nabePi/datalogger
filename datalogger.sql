-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 04, 2017 at 03:54 AM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `datalogger`
--

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `_key` varchar(255) NOT NULL,
  `_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `config`
--

INSERT INTO `config` (`id`, `_key`, `_value`) VALUES
(1, 'sensor_group', '[''POMPA'', ''COLD STORAGE'', ''TEMPERATURE RUANG'']'),
(2, 'sensor_type_color', '{''level'' : ''#16a086'', ''pressure'' : ''#2a80b9'', ''temperature'' : ''#f49c14'', ''flow'' : ''#8f44ad'', ''h2s'' : ''#c1392b'', ''rpm'' : ''#2d3e50'', ''gas'' : ''#808b8d''}');

-- --------------------------------------------------------

--
-- Table structure for table `dashboard`
--

CREATE TABLE `dashboard` (
  `id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `_group` int(11) NOT NULL,
  `_sensor` int(11) NOT NULL,
  `is_calc` int(11) NOT NULL DEFAULT '0',
  `_color` varchar(255) DEFAULT NULL,
  `_decimal` int(11) NOT NULL DEFAULT '0',
  `_settozero` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dashboard`
--

INSERT INTO `dashboard` (`id`, `users_id`, `_group`, `_sensor`, `is_calc`, `_color`, `_decimal`, `_settozero`) VALUES
(7, 2, 1, 2, 0, NULL, 1, 1),
(8, 2, 1, 3, 0, NULL, 2, 1),
(9, 2, 1, 1, 0, NULL, 2, 0),
(10, 2, 1, 2, 1, NULL, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'MAIN', 'Group Main'),
(2, 'OPERATOR', 'Group Operator'),
(3, 'SUPERVISOR', 'Group Supervisor'),
(5, 'LOGGER', 'Group Logger');

-- --------------------------------------------------------

--
-- Table structure for table `sensors_calc`
--

CREATE TABLE `sensors_calc` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `variable` text NOT NULL,
  `variable_customize` text NOT NULL,
  `formula` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sensors_calc`
--

INSERT INTO `sensors_calc` (`id`, `name`, `variable`, `variable_customize`, `formula`) VALUES
(2, 'TEMPERATURE', '{"temp_lab":2}', '{"MINUS_suhu":200}', 'temp_lab - MINUS_suhu');

-- --------------------------------------------------------

--
-- Table structure for table `sensors_raw`
--

CREATE TABLE `sensors_raw` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `source` int(11) NOT NULL,
  `chanel` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `low_ma` float NOT NULL,
  `high_ma` float NOT NULL,
  `value_min` float NOT NULL,
  `value_max` float NOT NULL,
  `unit` varchar(10) NOT NULL,
  `low_ma_calibration` float DEFAULT NULL,
  `high_ma_calibration` float DEFAULT NULL,
  `value_min_calibration` float DEFAULT NULL,
  `value_max_calibration` float DEFAULT NULL,
  `linearity` float DEFAULT NULL,
  `offset` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sensors_raw`
--

INSERT INTO `sensors_raw` (`id`, `name`, `source`, `chanel`, `type`, `low_ma`, `high_ma`, `value_min`, `value_max`, `unit`, `low_ma_calibration`, `high_ma_calibration`, `value_min_calibration`, `value_max_calibration`, `linearity`, `offset`) VALUES
(1, 'TEMP LAB', 1, 2, 2, 4, 20, 0, 100, 'c', NULL, NULL, NULL, NULL, 0.16, NULL),
(2, 'PRESSURE 1 LAB', 1, 3, 1, 4, 20, 0, 10, 'kpascal', 5.6077, 20, 0, 10, 1.6, NULL),
(3, 'PRESSURE 2 LAB', 1, 5, 1, 4, 20, 0, 20, 'bar', 5.4831, 20, 0, 10, 0.8, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_alarm`
--

CREATE TABLE `sensor_alarm` (
  `id` int(11) NOT NULL,
  `_sensor` int(11) NOT NULL,
  `is_calc` int(2) NOT NULL,
  `channel_LL` int(11) DEFAULT NULL,
  `channel_L` int(11) DEFAULT NULL,
  `channel_H` int(11) DEFAULT NULL,
  `channel_HH` int(11) DEFAULT NULL,
  `value_LL` float DEFAULT NULL,
  `value_L` float DEFAULT NULL,
  `value_H` float DEFAULT NULL,
  `value_HH` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sensor_alarm`
--

INSERT INTO `sensor_alarm` (`id`, `_sensor`, `is_calc`, `channel_LL`, `channel_L`, `channel_H`, `channel_HH`, `value_LL`, `value_L`, `value_H`, `value_HH`) VALUES
(1, 1, 0, 1, 1, 2, 2, 20, 22, 30, 35),
(2, 2, 1, 2, 2, 1, 1, 13, 14, 15, 16);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_type`
--

CREATE TABLE `sensor_type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sensor_unit`
--

CREATE TABLE `sensor_unit` (
  `id` int(11) NOT NULL,
  `sensor_type_id` int(11) NOT NULL,
  `unit_from` varchar(15) NOT NULL,
  `unit_to` varchar(15) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(5) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_group` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `id_group`) VALUES
(1, 'root', '$2a$10$Eqt0U0x32YWPLxJq1kSBfecTrE.mXUjV1sJAF6tSAfAx0hn0Gp4t2', 1),
(2, 'admin', '$2a$10$P92UoVP7YgZUkzZ9kOZI4u/6r3buIOZiwhQI.sILmtf8vCMzlJ7qu', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users_group`
--

CREATE TABLE `users_group` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_group`
--

INSERT INTO `users_group` (`id`, `name`, `description`) VALUES
(1, 'root', 'All of access'),
(2, 'administrator', 'part of access');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dashboard`
--
ALTER TABLE `dashboard`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`),
  ADD KEY `_group` (`_group`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensors_calc`
--
ALTER TABLE `sensors_calc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensors_raw`
--
ALTER TABLE `sensors_raw`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensor_alarm`
--
ALTER TABLE `sensor_alarm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensor_type`
--
ALTER TABLE `sensor_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensor_unit`
--
ALTER TABLE `sensor_unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_group` (`id_group`);

--
-- Indexes for table `users_group`
--
ALTER TABLE `users_group`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `dashboard`
--
ALTER TABLE `dashboard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sensors_calc`
--
ALTER TABLE `sensors_calc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sensors_raw`
--
ALTER TABLE `sensors_raw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sensor_alarm`
--
ALTER TABLE `sensor_alarm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sensor_type`
--
ALTER TABLE `sensor_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sensor_unit`
--
ALTER TABLE `sensor_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users_group`
--
ALTER TABLE `users_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `dashboard`
--
ALTER TABLE `dashboard`
  ADD CONSTRAINT `dashboard_ibfk_1` FOREIGN KEY (`_group`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_group`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
