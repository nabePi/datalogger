-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 28, 2017 at 08:47 AM
-- Server version: 5.7.19
-- PHP Version: 5.6.31

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

DROP TABLE IF EXISTS `config`;
CREATE TABLE IF NOT EXISTS `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_key` varchar(255) NOT NULL,
  `_value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `dashboard`;
CREATE TABLE IF NOT EXISTS `dashboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `_group` int(11) NOT NULL,
  `_sensor` int(11) NOT NULL,
  `is_calc` int(11) NOT NULL DEFAULT '0',
  `_color` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_id` (`users_id`),
  KEY `_group` (`_group`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dashboard`
--

INSERT INTO `dashboard` (`id`, `users_id`, `_group`, `_sensor`, `is_calc`, `_color`) VALUES
(7, 2, 1, 2, 0, NULL),
(8, 2, 1, 3, 0, NULL),
(9, 2, 1, 1, 0, NULL),
(10, 2, 1, 2, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `sensors_calc`;
CREATE TABLE IF NOT EXISTS `sensors_calc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `variable` text NOT NULL,
  `variable_customize` text NOT NULL,
  `formula` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sensors_calc`
--

INSERT INTO `sensors_calc` (`id`, `name`, `variable`, `variable_customize`, `formula`) VALUES
(2, 'TEMPERATURE', '{\"temp_lab\":2}', '{\"KENAIKAN_SUHU\":10}', 'temp_lab + KENAIKAN_SUHU');

-- --------------------------------------------------------

--
-- Table structure for table `sensors_raw`
--

DROP TABLE IF EXISTS `sensors_raw`;
CREATE TABLE IF NOT EXISTS `sensors_raw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `offset` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sensors_raw`
--

INSERT INTO `sensors_raw` (`id`, `name`, `source`, `chanel`, `type`, `low_ma`, `high_ma`, `value_min`, `value_max`, `unit`, `low_ma_calibration`, `high_ma_calibration`, `value_min_calibration`, `value_max_calibration`, `linearity`, `offset`) VALUES
(1, 'TEMP LAB', 1, 2, 2, 4, 20, 0, 100, 'c', NULL, NULL, NULL, NULL, 0.16, NULL),
(2, 'PRESSURE 1 LAB', 1, 3, 1, 4, 20, 0, 10, 'bar', 5.6077, 20, 0, 10, 1.6, NULL),
(3, 'PRESSURE 2 LAB', 1, 5, 1, 4, 20, 0, 20, 'bar', 5.4831, 20, 0, 10, 0.8, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `unit_flow`
--

DROP TABLE IF EXISTS `unit_flow`;
CREATE TABLE IF NOT EXISTS `unit_flow` (
  `id_unit_flow` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `lt` float NOT NULL,
  `bbl` float NOT NULL,
  `gal` float NOT NULL,
  PRIMARY KEY (`id_unit_flow`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `unit_gas`;
CREATE TABLE IF NOT EXISTS `unit_gas` (
  `id_unit_gas` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `mm` float NOT NULL,
  PRIMARY KEY (`id_unit_gas`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_gas`
--

INSERT INTO `unit_gas` (`id_unit_gas`, `sumber`, `mm`) VALUES
(1, 'mm', 1);

-- --------------------------------------------------------

--
-- Table structure for table `unit_h2s`
--

DROP TABLE IF EXISTS `unit_h2s`;
CREATE TABLE IF NOT EXISTS `unit_h2s` (
  `id_unit_h2s` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `ppm` float NOT NULL,
  `%` float NOT NULL,
  PRIMARY KEY (`id_unit_h2s`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `unit_level`;
CREATE TABLE IF NOT EXISTS `unit_level` (
  `id_unit_level` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `m3` float NOT NULL,
  `bbl` float NOT NULL,
  `gal` float NOT NULL,
  `Ltr` float NOT NULL,
  `cm` float NOT NULL,
  `mm` float NOT NULL,
  PRIMARY KEY (`id_unit_level`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `unit_pressure`;
CREATE TABLE IF NOT EXISTS `unit_pressure` (
  `id_unit_pressure` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(10) NOT NULL,
  `psi` float NOT NULL DEFAULT '0',
  `bar` float NOT NULL DEFAULT '0',
  `pascal` float NOT NULL DEFAULT '0',
  `kpascal` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_unit_pressure`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `unit_rpm`;
CREATE TABLE IF NOT EXISTS `unit_rpm` (
  `id_unit_flow` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `rpm` float NOT NULL,
  PRIMARY KEY (`id_unit_flow`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_rpm`
--

INSERT INTO `unit_rpm` (`id_unit_flow`, `sumber`, `rpm`) VALUES
(1, 'rpm', 1);

-- --------------------------------------------------------

--
-- Table structure for table `unit_temperature`
--

DROP TABLE IF EXISTS `unit_temperature`;
CREATE TABLE IF NOT EXISTS `unit_temperature` (
  `id_unit_temperature` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `C` float NOT NULL DEFAULT '0',
  `F` float NOT NULL DEFAULT '0',
  `K` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_unit_temperature`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_group` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_group` (`id_group`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `users_group`;
CREATE TABLE IF NOT EXISTS `users_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_group`
--

INSERT INTO `users_group` (`id`, `name`, `description`) VALUES
(1, 'root', 'All of access'),
(2, 'administrator', 'part of access');

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
