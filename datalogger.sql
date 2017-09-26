-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 22, 2017 at 03:05 AM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
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
(1, 'sensor_group', '[\'POMPA\', \'COLD STORAGE\', \'TEMPERATURE RUANG\']'),
(2, 'sensor_type_color', '{\'level\' : \'#16a086\', \'pressure\' : \'#2a80b9\', \'temperature\' : \'#f49c14\', \'flow\' : \'#8f44ad\', \'h2s\' : \'#c1392b\', \'rpm\' : \'#2d3e50\', \'gas\' : \'#808b8d\'}');

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
  `_color` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dashboard`
--

INSERT INTO `dashboard` (`id`, `users_id`, `_group`, `_sensor`, `is_calc`, `_color`) VALUES
(1, 2, 1, 5, 0, ''),
(2, 2, 1, 13, 0, ''),
(3, 2, 1, 23, 0, ''),
(4, 2, 1, 22, 0, ''),
(5, 2, 1, 21, 0, ''),
(6, 2, 1, 15, 0, ''),
(7, 2, 1, 6, 0, ''),
(8, 2, 1, 35, 0, ''),
(9, 2, 1, 33, 0, ''),
(10, 2, 1, 32, 0, ''),
(11, 2, 1, 31, 0, ''),
(12, 2, 1, 25, 0, ''),
(13, 2, 1, 8, 0, ''),
(14, 2, 1, 16, 0, ''),
(15, 2, 1, 39, 0, ''),
(16, 2, 1, 38, 0, ''),
(17, 2, 1, 37, 0, ''),
(18, 2, 1, 34, 0, ''),
(19, 2, 1, 11, 0, ''),
(20, 2, 1, 14, 0, ''),
(21, 2, 1, 45, 0, ''),
(22, 2, 1, 44, 0, ''),
(23, 2, 1, 43, 0, ''),
(24, 2, 1, 42, 0, ''),
(25, 2, 1, 9, 0, ''),
(26, 2, 1, 24, 0, ''),
(27, 2, 1, 28, 0, ''),
(28, 2, 1, 29, 0, ''),
(29, 2, 1, 36, 0, ''),
(30, 2, 1, 17, 0, ''),
(31, 2, 1, 7, 0, ''),
(32, 2, 1, 20, 0, ''),
(33, 2, 1, 27, 0, ''),
(34, 2, 1, 41, 0, ''),
(35, 2, 1, 10, 0, ''),
(36, 2, 1, 3, 0, '');

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
(2, 'oke', '{\"level_water_ro\":1}', '{\"foov\":500}', 'level_water_ro + foov'),
(3, 'oke lagi', '{\"level_water_ro\":1}', '{\"good\":400}', 'level_water_ro + good'),
(5, 'Total NH3', '{\"level_intercoler\":3,\"level_separator\":25,\"level_receiver\":3}', '{}', 'level_intercoler + level_separator + level_receiver');

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
  `low_ma_calibration` float NOT NULL,
  `high_ma_calibration` float NOT NULL,
  `value_min_calibration` float NOT NULL,
  `value_max_calibration` float NOT NULL,
  `linearity` float NOT NULL,
  `offset` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sensors_raw`
--

INSERT INTO `sensors_raw` (`id`, `name`, `source`, `chanel`, `type`, `low_ma`, `high_ma`, `value_min`, `value_max`, `unit`, `low_ma_calibration`, `high_ma_calibration`, `value_min_calibration`, `value_max_calibration`, `linearity`, `offset`) VALUES
(1, 'DEFROST', 1, 2, 2, 4, 20, -50, 100, 'c', 9.5916, 11.1073, 0, 16.8, 0.0902202, 0),
(2, 'OIL DIFF 37', 1, 7, 1, 4, 20, 0, 147, 'psi', 5.3572, 13.3249, 0, 58, 0.137374, 0),
(3, 'GAS NH3 PROD A', 1, 28, 4, 4, 20, 0, 1000, 'ppm', 3.624, 20, 0, 1000, 0.016376, 0),
(4, 'LEVEL RECEIVER', 1, 3, 0, 4, 20, 0, 620, 'mm', 14.224, 16.158, 200, 260, 0.0322333, 0),
(5, 'CS A', 1, 29, 2, 0, 0, -50, 200, 'C', 8.2577, 6.7076, 29.9, -7, 0.0420081, 0),
(6, 'CS B1', 1, 12, 2, 0, 0, -50, 200, 'C', 9.0321, 7.3828, 28.6, -0.5, 0.056677, 0),
(7, 'ABF 3', 1, 13, 2, 0, 0, -50, 200, 'C', 8.9825, 5.4576, 30.8, -39.6, 0.0500696, 0),
(8, 'CS B2', 1, 11, 2, 0, 0, -50, 200, 'C', 9.383, 6.2333, 29.5, -16.9, 0.0678815, 0),
(9, 'ABF 2', 1, 14, 2, 0, 0, -50, 200, 'C', 9.7581, 6.349, 24, -22, 0.0741109, 0),
(10, 'GAS NH3 TE', 1, 22, 4, 0, 0, 0, 1000, 'ppm', 3.6329, 20, 0, 1000, 0.0163671, 0),
(11, 'ABF 1', 1, 4, 2, 0, 0, -50, 200, 'C', 4, 20, -50, 200, 0.064, 0),
(12, 'RECEIVER', 1, 23, 1, 0, 0, 0, 100, 'bar', 3.9991, 6.3071, 0, 14.5, 0.159172, 0.2),
(13, 'PUMP NH3', 1, 24, 1, 0, 0, 0, 29.42, 'bar', 5.3915, 6.0159, 0.5, 2.5, 0.3122, 0),
(14, 'SEPARATOR', 1, 30, 1, 0, 0, -1, 4, 'bar', 8.4573, 20, 0.4, 4, 3.20631, 0),
(15, 'COMP 39', 3, 3, 5, 0, 0, 0, 1000, 'rpm', 0, 0, 0, 0, 0, 0),
(16, 'RECEIVING', 1, 19, 2, 0, 0, -50, 100, 'C', 9.6742, 12.6243, 0.5, 21.6, 0.139815, 0),
(17, 'DEFROST', 1, 2, 2, 0, 0, -50, 100, 'C', 9.5916, 11.1073, 0, 16.8, 0.0902202, 0),
(18, 'DEHEADING', 1, 20, 2, 0, 0, -50, 100, 'C', 14.2163, 16.0576, 0, 17.3, 0.106434, 0),
(19, 'PACKING', 1, 17, 2, 0, 0, -50, 100, 'C', 9.3996, 11.2739, 0, 17.1, 0.109608, 0),
(20, 'LEVEL WATER RO', 2, 1, 0, 0, 0, 0, 2500, 'mm', 0, 0, 0, 0, 0, 0),
(21, 'COMP 38', 3, 4, 5, 0, 0, 0, 1000, 'rpm', 0, 0, 0, 0, 0, 0),
(22, 'COMP 37', 3, 1, 5, 0, 0, 0, 1000, 'rpm', 0, 0, 0, 0, 0, 0),
(23, 'COMP 36', 3, 2, 5, 0, 0, 0, 1000, 'rpm', 0, 0, 0, 0, 0, 0),
(24, 'LEVEL SEPARATOR', 1, 25, 0, 0, 0, 0, 92.5, 'cm', 3.9991, 19.9575, 0, 88, 0.181345, 0),
(25, 'OIL DIFF 39', 1, 5, 1, 0, 0, 0, 147, 'psi', 3.7906, 20, 0, 147, 0.110268, 0),
(26, 'GAS NH3 PROD A', 1, 28, 4, 0, 0, 0, 1000, 'ppm', 3.624, 20, 0, 1000, 0.016376, 0),
(27, 'ICE MAKER', 3, 6, 5, 0, 0, 0, 50, 'rpm', 0, 0, 0, 0, 0, 0),
(28, 'LEVEL RECEIVER', 1, 3, 0, 0, 0, 0, 620, 'mm', 14.224, 16.158, 200, 260, 0.0322333, 0),
(29, 'LEVEL INTERCOLER', 2, 3, 0, 0, 0, 0, 2430, 'mm', 0, 0, 0, 0, 0, 0),
(30, 'TEMPERATURE', 1, 38, 2, 0, 0, -50, 200, 'C', 10.2083, 8.9748, 31.8, 1.5, 0.0407096, 0),
(31, 'OIL DIFF 38', 1, 6, 1, 0, 0, 0, 147, 'psi', 3.816, 20, 0, 147, 0.110095, 0),
(32, 'OIL DIFF 37', 1, 7, 1, 0, 0, 0, 147, 'psi', 5.3572, 13.3249, 0, 58, 0.137374, 0),
(33, 'OIL DIFF 36', 1, 8, 1, 0, 0, 0, 147, 'psi', 5.0571, 20, 0, 147, 0.101652, 0),
(34, 'DISCHARGE 39', 1, 10, 1, 0, 0, -14.7, 497.81, 'psi', 8.9914, 20, 10, 497.81, 0.0225674, 0),
(35, 'TEMP SEPARATOR', 1, 31, 2, 0, 0, -50, 100, 'C', 7.3739, 20, -35, 100, 0.0935267, 0),
(36, 'RPM DEFROST ', 3, 5, 5, 0, 0, 0, 2900, 'rpm', 0, 0, 0, 0, 0, 0),
(37, 'DISCHARGE 38', 1, 21, 1, 0, 0, -14.7, 497.81, 'psi', 4.8905, 20, 0, 497.81, 0.0303519, 0),
(38, 'DISCHARGE 37', 1, 16, 1, 0, 0, -14.7, 497.81, 'psi', 4, 20, -14.7, 497.81, 0.0312189, 0),
(39, 'DISCHARGE 36', 1, 27, 1, 0, 0, -14.7, 497.81, 'psi', 4, 20, -14.7, 497.81, 0.0312189, 0),
(40, 'TEMP GAS SEP', 1, 1, 2, 0, 0, 0, 100, 'C', 0, 0, 0, 0, 0, 0),
(41, 'PRESS INTERCOOLER', 1, 50, 1, 0, 0, 0, 30, 'bar', 0, 0, 0, 0, 0, 0),
(42, 'SUCTION 39', 1, 9, 1, 0, 0, -14.7, 497.817, 'psi', 4, 20, -14.7, 497.817, 0.0312185, 0),
(43, 'SUCTION 38', 1, 15, 1, 0, 0, -14.7, 497.817, 'psi', 4, 20, -14.7, 497.817, 0.0312185, 0),
(44, 'SUCTION 37', 1, 32, 1, 0, 0, -14.7, 497.817, 'psi', 4, 20, -14.7, 497.817, 0.0312185, 0),
(45, 'SUCTION 36', 1, 26, 1, 0, 0, -14.7, 497.817, 'psi', 4, 20, -14.7, 497.817, 0.0312185, 0);

-- --------------------------------------------------------

--
-- Table structure for table `unit_flow`
--

CREATE TABLE `unit_flow` (
  `id_unit_flow` int(11) NOT NULL,
  `sumber` varchar(5) NOT NULL,
  `lt` float NOT NULL,
  `bbl` float NOT NULL,
  `gal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_flow`
--

INSERT INTO `unit_flow` (`id_unit_flow`, `sumber`, `lt`, `bbl`, `gal`) VALUES
(1, 'lt', 1, 1, 1),
(2, 'bbl', 1, 1, 1),
(3, 'gal', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `unit_gas`
--

CREATE TABLE `unit_gas` (
  `id_unit_gas` int(11) NOT NULL,
  `sumber` varchar(5) NOT NULL,
  `mm` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_gas`
--

INSERT INTO `unit_gas` (`id_unit_gas`, `sumber`, `mm`) VALUES
(1, 'mm', 1);

-- --------------------------------------------------------

--
-- Table structure for table `unit_h2s`
--

CREATE TABLE `unit_h2s` (
  `id_unit_h2s` int(11) NOT NULL,
  `sumber` varchar(5) NOT NULL,
  `ppm` float NOT NULL,
  `%` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_h2s`
--

INSERT INTO `unit_h2s` (`id_unit_h2s`, `sumber`, `ppm`, `%`) VALUES
(1, 'ppm', 1, 1),
(2, '%', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `unit_level`
--

CREATE TABLE `unit_level` (
  `id_unit_level` int(11) NOT NULL,
  `sumber` varchar(5) NOT NULL,
  `m3` float NOT NULL,
  `bbl` float NOT NULL,
  `gal` float NOT NULL,
  `Ltr` float NOT NULL,
  `cm` float NOT NULL,
  `mm` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_level`
--

INSERT INTO `unit_level` (`id_unit_level`, `sumber`, `m3`, `bbl`, `gal`, `Ltr`, `cm`, `mm`) VALUES
(1, 'm3', 1, 6.2898, 264.172, 1000, 0, 0),
(2, 'bbl', 0.15899, 1, 42, 158.99, 0, 0),
(3, 'ltr', 0.001, 0.0063, 0.264172, 1, 0, 0),
(4, 'gal', 0.00379, 0.0238, 1, 3.7854, 0, 0),
(5, 'cm', 0.00379, 0.0238, 1, 3.7854, 1, 10),
(6, 'mm', 0.00379, 0.0238, 1, 3.7854, 0.1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `unit_pressure`
--

CREATE TABLE `unit_pressure` (
  `id_unit_pressure` int(11) NOT NULL,
  `sumber` varchar(10) NOT NULL,
  `psi` float NOT NULL DEFAULT '0',
  `bar` float NOT NULL DEFAULT '0',
  `pascal` float NOT NULL DEFAULT '0',
  `kpascal` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_pressure`
--

INSERT INTO `unit_pressure` (`id_unit_pressure`, `sumber`, `psi`, `bar`, `pascal`, `kpascal`) VALUES
(1, 'psi', 1, 0.0689476, 6894.8, 6.89476),
(2, 'bar', 14.5038, 1, 100000, 100),
(3, 'pascal', 0.0001, 0.00001, 1, 0.001),
(4, 'kpascal', 0.145, 0.01, 1000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `unit_rpm`
--

CREATE TABLE `unit_rpm` (
  `id_unit_flow` int(11) NOT NULL,
  `sumber` varchar(5) NOT NULL,
  `rpm` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_rpm`
--

INSERT INTO `unit_rpm` (`id_unit_flow`, `sumber`, `rpm`) VALUES
(1, 'rpm', 1);

-- --------------------------------------------------------

--
-- Table structure for table `unit_temperature`
--

CREATE TABLE `unit_temperature` (
  `id_unit_temperature` int(11) NOT NULL,
  `sumber` varchar(5) NOT NULL,
  `C` float NOT NULL DEFAULT '0',
  `F` float NOT NULL DEFAULT '0',
  `K` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_temperature`
--

INSERT INTO `unit_temperature` (`id_unit_temperature`, `sumber`, `C`, `F`, `K`) VALUES
(1, 'C', 1, 33.8, 274.15),
(2, 'F', -17.2222, 1, 255.928),
(3, 'K', -272.15, -457.87, 1);

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
-- Indexes for table `unit_flow`
--
ALTER TABLE `unit_flow`
  ADD PRIMARY KEY (`id_unit_flow`);

--
-- Indexes for table `unit_gas`
--
ALTER TABLE `unit_gas`
  ADD PRIMARY KEY (`id_unit_gas`);

--
-- Indexes for table `unit_h2s`
--
ALTER TABLE `unit_h2s`
  ADD PRIMARY KEY (`id_unit_h2s`);

--
-- Indexes for table `unit_level`
--
ALTER TABLE `unit_level`
  ADD PRIMARY KEY (`id_unit_level`);

--
-- Indexes for table `unit_pressure`
--
ALTER TABLE `unit_pressure`
  ADD PRIMARY KEY (`id_unit_pressure`);

--
-- Indexes for table `unit_rpm`
--
ALTER TABLE `unit_rpm`
  ADD PRIMARY KEY (`id_unit_flow`);

--
-- Indexes for table `unit_temperature`
--
ALTER TABLE `unit_temperature`
  ADD PRIMARY KEY (`id_unit_temperature`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `sensors_calc`
--
ALTER TABLE `sensors_calc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `sensors_raw`
--
ALTER TABLE `sensors_raw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
--
-- AUTO_INCREMENT for table `unit_flow`
--
ALTER TABLE `unit_flow`
  MODIFY `id_unit_flow` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `unit_gas`
--
ALTER TABLE `unit_gas`
  MODIFY `id_unit_gas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `unit_h2s`
--
ALTER TABLE `unit_h2s`
  MODIFY `id_unit_h2s` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `unit_level`
--
ALTER TABLE `unit_level`
  MODIFY `id_unit_level` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `unit_pressure`
--
ALTER TABLE `unit_pressure`
  MODIFY `id_unit_pressure` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `unit_rpm`
--
ALTER TABLE `unit_rpm`
  MODIFY `id_unit_flow` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `unit_temperature`
--
ALTER TABLE `unit_temperature`
  MODIFY `id_unit_temperature` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
