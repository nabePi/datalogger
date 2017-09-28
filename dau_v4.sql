-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 28, 2017 at 08:46 AM
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
-- Database: `dau_v4`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_address_sensor_485`
--

DROP TABLE IF EXISTS `app_address_sensor_485`;
CREATE TABLE IF NOT EXISTS `app_address_sensor_485` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_list_sensor` int(11) NOT NULL,
  `id_sensor` int(11) NOT NULL,
  `nama_address` varchar(30) NOT NULL,
  `address1` int(11) NOT NULL,
  `address2` int(11) NOT NULL,
  `type_data` int(11) NOT NULL COMMENT '1=STRING; 2=INT; 3=FLOAT',
  `quantity` int(11) NOT NULL,
  `status` int(11) NOT NULL COMMENT '0:DISABLE ; -1=ENABLE',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_address_sensor_485`
--

INSERT INTO `app_address_sensor_485` (`id`, `id_list_sensor`, `id_sensor`, `nama_address`, `address1`, `address2`, `type_data`, `quantity`, `status`) VALUES
(5, 2, 2, 'ID 2', 4103, 4106, 3, 2, -1),
(18, 1, 3, 'INTERCOLER', 4103, 4106, 3, 2, -1),
(19, 1, 4, 'test', 4103, 4106, 3, 2, -1);

-- --------------------------------------------------------

--
-- Table structure for table `app_addr_led_485`
--

DROP TABLE IF EXISTS `app_addr_led_485`;
CREATE TABLE IF NOT EXISTS `app_addr_led_485` (
  `id_app_adr_led_485` int(11) NOT NULL AUTO_INCREMENT,
  `nama_led` varchar(30) NOT NULL,
  `id_led` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `comport` int(11) NOT NULL,
  `used_stat` int(11) NOT NULL,
  `source_sensor` int(11) NOT NULL,
  `datana` varchar(255) NOT NULL,
  PRIMARY KEY (`id_app_adr_led_485`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_addr_led_485`
--

INSERT INTO `app_addr_led_485` (`id_app_adr_led_485`, `nama_led`, `id_led`, `status`, `comport`, `used_stat`, `source_sensor`, `datana`) VALUES
(2, 'TANKI 4', 1, 0, 7, 0, 31, '0 cm,0'),
(3, 'TANKI 3', 7, 0, 7, 0, 4, '8.3 cm,0'),
(4, 'TANKI 4', 8, 0, 7, 0, 7, '290 bbl,1');

-- --------------------------------------------------------

--
-- Table structure for table `app_addr_plc`
--

DROP TABLE IF EXISTS `app_addr_plc`;
CREATE TABLE IF NOT EXISTS `app_addr_plc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_record` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip_plc` varchar(20) DEFAULT NULL,
  `type_data` varchar(50) DEFAULT '0',
  `raw_data` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_addr_plc`
--

INSERT INTO `app_addr_plc` (`id`, `date_record`, `ip_plc`, `type_data`, `raw_data`) VALUES
(1, '2017-09-06 07:09:39', '192.168.3.211', 'Data(D)', '834,262,0,0,2010,0,0,0,0,0,0,0,0,0,0,0,0'),
(2, '2017-09-06 07:09:21', '192.168.3.211', 'DO(Y)', '0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,1,0,1,0,0,0'),
(3, '2017-09-06 06:42:54', '192.168.3.211', 'RLY(M)', '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0');

-- --------------------------------------------------------

--
-- Table structure for table `app_alarmlog`
--

DROP TABLE IF EXISTS `app_alarmlog`;
CREATE TABLE IF NOT EXISTS `app_alarmlog` (
  `id_alarm` int(11) NOT NULL AUTO_INCREMENT,
  `start_time` datetime NOT NULL,
  `stop_time` datetime NOT NULL,
  `nama_sensor` varchar(50) NOT NULL,
  `alarm_mode` varchar(20) NOT NULL,
  `nilai` float NOT NULL,
  `status` varchar(10) NOT NULL,
  `user_log` int(11) NOT NULL,
  PRIMARY KEY (`id_alarm`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `app_alarm_stat`
--

DROP TABLE IF EXISTS `app_alarm_stat`;
CREATE TABLE IF NOT EXISTS `app_alarm_stat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_alarm_stat`
--

INSERT INTO `app_alarm_stat` (`id`, `value`) VALUES
(2, '00000000');

-- --------------------------------------------------------

--
-- Table structure for table `app_config_group`
--

DROP TABLE IF EXISTS `app_config_group`;
CREATE TABLE IF NOT EXISTS `app_config_group` (
  `id_config` int(11) NOT NULL AUTO_INCREMENT,
  `id_group_sensor` int(11) DEFAULT NULL,
  `panel_sensor` varchar(20) NOT NULL,
  `id_setting_sensor` int(11) DEFAULT NULL,
  `posisi` int(11) NOT NULL DEFAULT '-1' COMMENT 'baris=0,kolom=1',
  PRIMARY KEY (`id_config`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `app_control_pulse`
--

DROP TABLE IF EXISTS `app_control_pulse`;
CREATE TABLE IF NOT EXISTS `app_control_pulse` (
  `kode_pulse` varchar(10) NOT NULL,
  `nama_pulse` varchar(40) NOT NULL,
  `bit_pulse` tinyint(2) NOT NULL,
  `com_pulse` tinyint(3) NOT NULL,
  `status_pulse` tinyint(2) NOT NULL,
  `com_status` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_control_pulse`
--

INSERT INTO `app_control_pulse` (`kode_pulse`, `nama_pulse`, `bit_pulse`, `com_pulse`, `status_pulse`, `com_status`) VALUES
('FR1', 'FLOW SEPARATOR', 13, 2, 0, -1),
('FR2', 'FLOW LOADING 1', 2, 2, 0, -1),
('FR3', 'FLOW LOADING 2', 3, 2, 0, -1);

-- --------------------------------------------------------

--
-- Table structure for table `app_control_sensor`
--

DROP TABLE IF EXISTS `app_control_sensor`;
CREATE TABLE IF NOT EXISTS `app_control_sensor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_profile` varchar(50) NOT NULL,
  `source_inp` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1:Analog, 2:=rs485, 3=pulse',
  `chanel` tinyint(4) NOT NULL,
  `type_inp` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=LEVEL, 1=PRESSURE, 2=TEMPERATURE, 3=FLOW, 4=H2S',
  `type_sensor_analog` tinyint(4) NOT NULL DEFAULT '0',
  `range_min` float NOT NULL,
  `range_max` float NOT NULL,
  `unit_sensor` varchar(10) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `alarm_L` float NOT NULL DEFAULT '0',
  `alarm_H` float NOT NULL DEFAULT '0',
  `linearitas` float NOT NULL DEFAULT '0',
  `alarm_LE` tinyint(2) NOT NULL DEFAULT '0',
  `alarm_HE` tinyint(2) NOT NULL DEFAULT '0',
  `decimal_places` int(11) NOT NULL DEFAULT '2',
  `coef_val` float NOT NULL DEFAULT '1',
  `coef_unit` varchar(15) DEFAULT NULL,
  `offset1` float NOT NULL,
  `low_ma` float NOT NULL,
  `high_ma` float NOT NULL,
  `low_value` float NOT NULL,
  `high_value` float NOT NULL,
  `out_L` tinyint(4) NOT NULL DEFAULT '-1',
  `out_H` tinyint(4) NOT NULL DEFAULT '-1',
  `alarm_LL` float NOT NULL,
  `alarm_HH` float NOT NULL,
  `alarm_LLE` tinyint(2) NOT NULL,
  `alarm_HHE` tinyint(2) NOT NULL,
  `out_LL` tinyint(4) NOT NULL,
  `out_HH` tinyint(4) NOT NULL,
  `offset2` float NOT NULL,
  `display_unit` varchar(15) DEFAULT NULL,
  `zero_onmin` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_control_sensor`
--

INSERT INTO `app_control_sensor` (`id`, `name_profile`, `source_inp`, `chanel`, `type_inp`, `type_sensor_analog`, `range_min`, `range_max`, `unit_sensor`, `status`, `alarm_L`, `alarm_H`, `linearitas`, `alarm_LE`, `alarm_HE`, `decimal_places`, `coef_val`, `coef_unit`, `offset1`, `low_ma`, `high_ma`, `low_value`, `high_value`, `out_L`, `out_H`, `alarm_LL`, `alarm_HH`, `alarm_LLE`, `alarm_HHE`, `out_LL`, `out_HH`, `offset2`, `display_unit`, `zero_onmin`) VALUES
(34, 'CS A', 1, 29, 2, 1, -50, 200, 'C', -1, -28, -18, 0.0358428, -1, -1, 0, 1, 'C', 0, 8.2577, 6.6161, 29.9, -15.9, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', 0),
(35, 'CS B1', 1, 12, 2, 1, -50, 200, 'C', -1, -22, -15, 0.056677, -1, -1, 0, 1, 'C', 0, 9.0321, 7.3828, 28.6, -0.5, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(38, 'ABF 3', 1, 13, 2, 1, -50, 200, 'C', -1, -35, 0, 0.0500696, 0, 0, 0, 1, 'C', 0, 8.9825, 5.4576, 30.8, -39.6, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(40, 'CS B2', 1, 11, 2, 1, -50, 200, 'C', -1, -22, -15, 0.0678815, -1, -1, 0, 1, 'C', 0, 9.383, 6.2333, 29.5, -16.9, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(43, 'ABF 2', 1, 14, 2, 1, -50, 200, 'C', -1, 0, 0, 0.0741109, 0, 0, 0, 1, 'C', 0, 9.7581, 6.349, 24, -22, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(44, 'GAS NH3 TE', 1, 22, 4, 1, 0, 1000, 'ppm', -1, 0, 25, 0.0163671, 0, 0, 0, 1, 'ppm', 0, 3.6329, 20, 0, 1000, -1, -1, 0, 50, 0, 0, -1, -1, 0, 'ppm', -1),
(46, 'ABF 1', 1, 4, 2, 1, -50, 200, 'C', -1, 0, 0, 0.064, 0, 0, 0, 1, 'C', 0, 4, 20, -50, 200, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(48, 'RECEIVER', 1, 23, 1, 1, 0, 100, 'bar', -1, 11, 15, 0.159172, 0, 0, 1, 1, 'bar', 0.2, 3.9991, 6.3071, 0, 14.5, -1, -1, 10, 17, 0, 0, -1, -1, 0, 'bar', 0),
(50, 'PUMP NH3', 1, 24, 1, 1, 0, 29.42, 'bar', -1, 0, 0, 0.3122, 0, 0, 1, 1, 'bar', 0, 5.3915, 6.0159, 0.5, 2.5, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'bar', NULL),
(51, 'SEPARATOR', 1, 30, 1, 1, -1, 4, 'bar', -1, -0.5, 7, 3.20631, 0, 0, 2, 1, 'bar', 0, 8.4573, 20, 0.4, 4, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'bar', NULL),
(53, 'COMP 39', 3, 3, 5, -1, 0, 1000, 'rpm', -1, 1, 0, 0, 0, 0, 0, 1, 'rpm', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'rpm', 0),
(54, 'RECEIVING', 1, 19, 2, 1, -50, 100, 'C', -1, 0, 0, 0.139815, 0, 0, 0, 1, 'C', 0, 9.6742, 12.6243, 0.5, 21.6, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(56, 'DEFROST', 1, 2, 2, 1, -50, 100, 'C', -1, 0, 0, 0.0902202, 0, 0, 0, 1, 'C', 0, 9.5916, 11.1073, 0, 16.8, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(57, 'DEHEADING', 1, 20, 2, 1, -50, 100, 'C', -1, 0, 0, 0.106434, 0, 0, 0, 1, 'C', 0, 14.2163, 16.0576, 0, 17.3, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(58, 'PACKING', 1, 17, 2, 1, -50, 100, 'C', -1, 0, 0, 0.109608, 0, 0, 0, 1, 'C', 0, 9.3996, 11.2739, 0, 17.1, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(59, 'LEVEL WATER RO', 2, 2, 0, -1, 0, 2500, 'mm', -1, 0, 0, 0, 0, 0, 0, 10.05, 'ltr', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 290, 'ltr', -1),
(60, 'COMP 38', 3, 4, 5, -1, 0, 1000, 'rpm', -1, 1, 0, 0, 0, 0, 0, 1, 'rpm', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'rpm', 0),
(63, 'COMP 37', 3, 1, 5, -1, 0, 1000, 'rpm', -1, 1, 0, 0, 0, 0, 0, 1, 'rpm', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'rpm', 0),
(65, 'COMP 36', 3, 2, 5, -1, 0, 1000, 'rpm', -1, 1, 0, 0, 0, 0, 0, 1, 'rpm', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'rpm', 0),
(66, 'LEVEL SEPARATOR', 1, 25, 0, 1, 0, 92.5, 'cm', -1, 0, 50, 0.181345, 0, 0, 1, 1, 'cm', 0, 3.9991, 19.9575, 0, 88, -1, 1, 0, 0, 0, 0, -1, -1, 0, 'cm', 0),
(67, 'OIL DIFF 39', 1, 5, 1, 1, 0, 147, 'psi', -1, 15, 60, 0.110268, 0, 0, 0, 1, 'psi', 0, 3.7906, 20, 0, 147, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'psi', -1),
(68, 'GAS NH3 PROD A', 1, 28, 4, 1, 0, 1000, 'ppm', -1, 0, 25, 0.016376, 0, 0, 0, 1, 'ppm', 0, 3.624, 20, 0, 1000, -1, -1, 0, 50, 0, 0, -1, -1, 0, 'ppm', -1),
(70, 'ICE MAKER', 3, 6, 5, -1, 0, 50, 'rpm', -1, 1, 0, 0, 0, 0, 0, 1, 'rpm', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'rpm', NULL),
(71, 'LEVEL RECEIVER', 1, 3, 0, 1, 0, 620, 'mm', -1, 25, 50, 0.0245174, 0, 0, 1, 0.1, 'cm', -30, 5.6992, 20.9, 0, 620, -1, 1, 20, 60, 0, 0, -1, -1, 0, 'cm', 0),
(72, 'LEVEL INTERCOLER', 2, 3, 0, -1, 0, 2430, 'mm', -1, 0, 0, 0, 0, 0, 1, 0.1, 'cm', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'cm', 0),
(74, 'TEMPERATURE', 1, 38, 2, 1, -50, 200, 'C', -1, 0, 0, 0.0407096, 0, 0, 1, 1, 'C', 0, 10.2083, 8.9748, 31.8, 1.5, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(75, 'OIL DIFF 38', 1, 6, 1, 1, 0, 147, 'psi', -1, 15, 60, 0.110095, 0, 0, 0, 1, 'psi', 0, 3.816, 20, 0, 147, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'psi', -1),
(76, 'OIL DIFF 37', 1, 7, 1, 1, 0, 147, 'psi', -1, 15, 60, 0.137374, 0, 0, 0, 1, 'psi', 0, 5.3572, 13.3249, 0, 58, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'psi', -1),
(77, 'OIL DIFF 36', 1, 8, 1, 1, 0, 147, 'psi', -1, 15, 100, 0.101652, 0, 0, 0, 1, 'psi', 0, 5.0571, 20, 0, 147, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'psi', -1),
(78, 'DISCHARGE 39', 1, 10, 1, 1, -14.7, 497.81, 'psi', -1, 0, 0, 0.0312189, 0, 0, 0, 1, 'psi', 0, 4, 20, -14.7, 497.81, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'psi', -1),
(79, 'TEMP SEPARATOR', 1, 31, 2, 1, -50, 100, 'C', -1, 0, 0, 0.0935267, 0, 0, 0, 1, 'C', 0, 7.3739, 20, -35, 100, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', 0),
(80, 'RPM DEFROST ', 3, 5, 5, -1, 0, 2900, 'rpm', -1, 0, 0, 0, 0, 0, 0, 1, 'rpm', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'rpm', NULL),
(81, 'DISCHARGE 38', 1, 21, 1, 1, -14.7, 497.81, 'psi', -1, 0, 0, 0.0303519, 0, 0, 0, 1, 'psi', 0, 4.8905, 20, 0, 497.81, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'psi', -1),
(82, 'DISCHARGE 37', 1, 16, 1, 1, -14.7, 497.81, 'psi', -1, 0, 0, 0.0312189, 0, 0, 0, 1, 'psi', 0, 4, 20, -14.7, 497.81, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'psi', -1),
(83, 'DISCHARGE 36', 1, 27, 1, 1, -14.7, 497.81, 'psi', -1, 0, 0, 0.0312189, 0, 0, 0, 1, 'psi', 0, 4, 20, -14.7, 497.81, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'psi', -1),
(84, 'TEMP GAS SEP', 1, 1, 2, 1, 0, 100, 'C', -1, 0, 0, 0, 0, 0, 0, 1, 'C', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'C', NULL),
(85, 'PRESS INTERCOOLER', 1, 50, 1, 1, 0, 30, 'bar', -1, 0, 0, 0, 0, 0, 1, 1, 'bar', 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'bar', NULL),
(86, 'SUCTION 39', 1, 9, 1, 1, -14.7, 497.817, 'psi', -1, 0, 0, 0.0312185, 0, 0, 2, 0.0689476, 'bar', 0, 4, 20, -14.7, 497.817, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'bar', 0),
(87, 'SUCTION 38', 1, 15, 1, 1, -14.7, 497.817, 'psi', -1, 0, 0, 0.0312185, 0, 0, 2, 0.0689476, 'bar', 0, 4, 20, -14.7, 497.817, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'bar', 0),
(88, 'SUCTION 37', 1, 32, 1, 1, -14.7, 497.817, 'psi', -1, 0, 0, 0.0312185, 0, 0, 2, 0.0689476, 'bar', 0, 4, 20, -14.7, 497.817, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'bar', 0),
(89, 'SUCTION 36', 1, 26, 1, 1, -14.7, 497.817, 'psi', -1, 0, 0, 0.0312185, 0, 0, 2, 0.0689476, 'bar', 0, 4, 20, -14.7, 497.817, -1, -1, 0, 0, 0, 0, -1, -1, 0, 'bar', 0);

-- --------------------------------------------------------

--
-- Table structure for table `app_errorlog`
--

DROP TABLE IF EXISTS `app_errorlog`;
CREATE TABLE IF NOT EXISTS `app_errorlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tglerror` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `errornya` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=360 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `app_group_sensor`
--

DROP TABLE IF EXISTS `app_group_sensor`;
CREATE TABLE IF NOT EXISTS `app_group_sensor` (
  `id_group_sensor` int(11) NOT NULL AUTO_INCREMENT,
  `nama_group` varchar(50) NOT NULL,
  `baris` int(11) NOT NULL,
  `kolom` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `tgl_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_create` int(11) NOT NULL,
  PRIMARY KEY (`id_group_sensor`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_group_sensor`
--

INSERT INTO `app_group_sensor` (`id_group_sensor`, `nama_group`, `baris`, `kolom`, `type`, `tgl_create`, `user_create`) VALUES
(34, 'MAIN', 6, 6, 1, '2017-08-21 02:37:18', 3),
(36, 'OPERATOR', 6, 6, 1, '2017-08-29 06:09:00', 5),
(37, 'SUPERVISOR', 6, 6, 1, '2017-08-29 06:16:56', 4),
(38, 'MAIN', 6, 6, 1, '2017-08-31 06:33:52', 6),
(39, 'OPERATOR', 8, 6, 1, '2017-08-31 06:47:43', 8),
(40, 'MAIN', 6, 6, 1, '2017-08-31 06:50:33', 8);

-- --------------------------------------------------------

--
-- Table structure for table `app_info_control`
--

DROP TABLE IF EXISTS `app_info_control`;
CREATE TABLE IF NOT EXISTS `app_info_control` (
  `kode_info_control` varchar(20) NOT NULL,
  `nama_info_control` varchar(50) DEFAULT NULL,
  `ip_info_control` varchar(20) DEFAULT NULL,
  `id_info_control` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`kode_info_control`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_info_control`
--

INSERT INTO `app_info_control` (`kode_info_control`, `nama_info_control`, `ip_info_control`, `id_info_control`) VALUES
('ADAM5KTCP', 'ADAM 5000 TCP', '192.168.0.20', 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_list_sensor_485`
--

DROP TABLE IF EXISTS `app_list_sensor_485`;
CREATE TABLE IF NOT EXISTS `app_list_sensor_485` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_sensor` varchar(5) NOT NULL,
  `nama_sensor` varchar(30) NOT NULL,
  `fungsi_sensor` varchar(10) NOT NULL,
  `com_port` int(11) NOT NULL,
  `status` int(11) NOT NULL COMMENT '0 : DISABLE ; -1 : ENABLE',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_list_sensor_485`
--

INSERT INTO `app_list_sensor_485` (`id`, `kode_sensor`, `nama_sensor`, `fungsi_sensor`, `com_port`, `status`) VALUES
(1, 'MAG1', 'MAGNETOSTRICTIVE', 'LEVEL', 3, -1),
(2, 'MAG2', 'MAGNETOSTRICTIVE', 'LEVEL', 7, -1);

-- --------------------------------------------------------

--
-- Table structure for table `app_log`
--

DROP TABLE IF EXISTS `app_log`;
CREATE TABLE IF NOT EXISTS `app_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daterec` datetime NOT NULL,
  `34_1` float(6,2) NOT NULL DEFAULT '0.00',
  `34_2` varchar(5) NOT NULL,
  `35_1` float(6,2) NOT NULL DEFAULT '0.00',
  `35_2` varchar(5) NOT NULL,
  `38_1` float(6,2) NOT NULL DEFAULT '0.00',
  `38_2` varchar(5) NOT NULL,
  `40_1` float(6,2) NOT NULL DEFAULT '0.00',
  `40_2` varchar(5) NOT NULL,
  `44_1` float(6,2) NOT NULL DEFAULT '0.00',
  `44_2` varchar(5) NOT NULL,
  `43_1` float(6,2) NOT NULL DEFAULT '0.00',
  `43_2` varchar(5) NOT NULL,
  `46_1` float(6,2) NOT NULL DEFAULT '0.00',
  `46_2` varchar(5) NOT NULL,
  `48_1` float(6,2) NOT NULL DEFAULT '0.00',
  `48_2` varchar(5) NOT NULL,
  `50_1` float(6,2) NOT NULL DEFAULT '0.00',
  `50_2` varchar(5) NOT NULL,
  `51_1` float(6,2) NOT NULL DEFAULT '0.00',
  `51_2` varchar(5) NOT NULL,
  `53_1` float(6,2) NOT NULL DEFAULT '0.00',
  `53_2` varchar(5) NOT NULL,
  `54_1` float(6,2) NOT NULL DEFAULT '0.00',
  `54_2` varchar(5) NOT NULL,
  `56_1` float(6,2) NOT NULL DEFAULT '0.00',
  `56_2` varchar(5) NOT NULL,
  `57_1` float(6,2) NOT NULL DEFAULT '0.00',
  `57_2` varchar(5) NOT NULL,
  `58_1` float(6,2) NOT NULL DEFAULT '0.00',
  `58_2` varchar(5) NOT NULL,
  `59_1` float(6,2) NOT NULL DEFAULT '0.00',
  `59_2` varchar(5) NOT NULL,
  `60_1` float(6,2) NOT NULL DEFAULT '0.00',
  `60_2` varchar(5) NOT NULL,
  `63_1` float(6,2) NOT NULL DEFAULT '0.00',
  `63_2` varchar(5) NOT NULL,
  `70_1` float(6,2) NOT NULL DEFAULT '0.00',
  `70_2` varchar(5) NOT NULL,
  `65_1` float(6,2) NOT NULL DEFAULT '0.00',
  `65_2` varchar(5) NOT NULL,
  `66_1` float(6,2) NOT NULL DEFAULT '0.00',
  `66_2` varchar(5) NOT NULL,
  `67_1` float(6,2) NOT NULL DEFAULT '0.00',
  `67_2` varchar(5) NOT NULL,
  `68_1` float(6,2) NOT NULL DEFAULT '0.00',
  `68_2` varchar(5) NOT NULL,
  `71_1` float(6,2) NOT NULL DEFAULT '0.00',
  `71_2` varchar(5) NOT NULL,
  `72_1` float(6,2) NOT NULL DEFAULT '0.00',
  `72_2` varchar(5) NOT NULL,
  `74_1` float(6,2) NOT NULL DEFAULT '0.00',
  `74_2` varchar(5) NOT NULL,
  `75_1` float(6,2) NOT NULL DEFAULT '0.00',
  `75_2` varchar(5) NOT NULL,
  `76_1` float(6,2) NOT NULL DEFAULT '0.00',
  `76_2` varchar(5) NOT NULL,
  `77_1` float(6,2) NOT NULL DEFAULT '0.00',
  `77_2` varchar(5) NOT NULL,
  `78_1` float(6,2) NOT NULL DEFAULT '0.00',
  `78_2` varchar(5) NOT NULL,
  `79_1` float(6,2) NOT NULL DEFAULT '0.00',
  `79_2` varchar(5) NOT NULL,
  `80_1` float(6,2) NOT NULL DEFAULT '0.00',
  `80_2` varchar(5) NOT NULL,
  `81_1` float(6,2) NOT NULL DEFAULT '0.00',
  `81_2` varchar(5) NOT NULL,
  `82_1` float(6,2) NOT NULL DEFAULT '0.00',
  `82_2` varchar(5) NOT NULL,
  `83_1` float(6,2) NOT NULL DEFAULT '0.00',
  `83_2` varchar(5) NOT NULL,
  `84_1` float(6,2) NOT NULL DEFAULT '0.00',
  `84_2` varchar(5) NOT NULL,
  `85_1` float(6,2) NOT NULL DEFAULT '0.00',
  `85_2` varchar(5) NOT NULL,
  `86_1` float(6,2) NOT NULL DEFAULT '0.00',
  `86_2` varchar(5) NOT NULL,
  `87_1` float(6,2) NOT NULL DEFAULT '0.00',
  `87_2` varchar(5) NOT NULL,
  `88_1` float(6,2) NOT NULL DEFAULT '0.00',
  `88_2` varchar(5) NOT NULL,
  `89_1` float(6,2) NOT NULL DEFAULT '0.00',
  `89_2` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `daterec` (`daterec`)
) ENGINE=InnoDB AUTO_INCREMENT=6479639 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `app_raw_data`
--

DROP TABLE IF EXISTS `app_raw_data`;
CREATE TABLE IF NOT EXISTS `app_raw_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_record` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `s1` float NOT NULL DEFAULT '0',
  `s2` float NOT NULL DEFAULT '0',
  `s3` float NOT NULL DEFAULT '0',
  `s4` float NOT NULL DEFAULT '0',
  `s5` float NOT NULL DEFAULT '0',
  `s6` float NOT NULL DEFAULT '0',
  `s7` float NOT NULL DEFAULT '0',
  `s8` float NOT NULL DEFAULT '0',
  `s9` float NOT NULL DEFAULT '0',
  `s10` float NOT NULL DEFAULT '0',
  `s11` float NOT NULL DEFAULT '0',
  `s12` float NOT NULL DEFAULT '0',
  `s13` float NOT NULL DEFAULT '0',
  `s14` float NOT NULL DEFAULT '0',
  `s15` float NOT NULL DEFAULT '0',
  `s16` float NOT NULL DEFAULT '0',
  `s17` float NOT NULL DEFAULT '0',
  `s18` float NOT NULL DEFAULT '0',
  `s19` float NOT NULL DEFAULT '0',
  `s20` float NOT NULL DEFAULT '0',
  `s21` float NOT NULL DEFAULT '0',
  `s22` float NOT NULL DEFAULT '0',
  `s23` float NOT NULL DEFAULT '0',
  `s24` float NOT NULL DEFAULT '0',
  `s25` float NOT NULL DEFAULT '0',
  `s26` float NOT NULL DEFAULT '0',
  `s27` float NOT NULL DEFAULT '0',
  `s28` float NOT NULL DEFAULT '0',
  `s29` float NOT NULL DEFAULT '0',
  `s30` float NOT NULL DEFAULT '0',
  `s31` float NOT NULL DEFAULT '0',
  `s32` float NOT NULL DEFAULT '0',
  `s33` float NOT NULL DEFAULT '0',
  `s34` float NOT NULL DEFAULT '0',
  `s35` float NOT NULL DEFAULT '0',
  `s36` float NOT NULL DEFAULT '0',
  `s37` float NOT NULL DEFAULT '0',
  `s38` float NOT NULL DEFAULT '0',
  `s39` float NOT NULL DEFAULT '0',
  `s40` float NOT NULL DEFAULT '0',
  `s41` float NOT NULL DEFAULT '0',
  `s42` float NOT NULL DEFAULT '0',
  `s43` float NOT NULL DEFAULT '0',
  `s44` float NOT NULL DEFAULT '0',
  `s45` float NOT NULL DEFAULT '0',
  `s46` float NOT NULL DEFAULT '0',
  `s47` float NOT NULL DEFAULT '0',
  `s48` float NOT NULL DEFAULT '0',
  `s49` float NOT NULL DEFAULT '0',
  `s50` float NOT NULL DEFAULT '0',
  `s51` float NOT NULL DEFAULT '0',
  `s52` float NOT NULL DEFAULT '0',
  `s53` float NOT NULL DEFAULT '0',
  `s54` float NOT NULL DEFAULT '0',
  `s55` float NOT NULL DEFAULT '0',
  `s56` float NOT NULL DEFAULT '0',
  `s57` float NOT NULL DEFAULT '0',
  `s58` float NOT NULL DEFAULT '0',
  `s59` float NOT NULL DEFAULT '0',
  `s60` float NOT NULL DEFAULT '0',
  `s61` float NOT NULL DEFAULT '0',
  `s62` float NOT NULL DEFAULT '0',
  `s63` float NOT NULL DEFAULT '0',
  `s64` float NOT NULL DEFAULT '0',
  `source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_record` (`date_record`)
) ENGINE=InnoDB AUTO_INCREMENT=2046100 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_raw_data`
--

INSERT INTO `app_raw_data` (`id`, `date_record`, `s1`, `s2`, `s3`, `s4`, `s5`, `s6`, `s7`, `s8`, `s9`, `s10`, `s11`, `s12`, `s13`, `s14`, `s15`, `s16`, `s17`, `s18`, `s19`, `s20`, `s21`, `s22`, `s23`, `s24`, `s25`, `s26`, `s27`, `s28`, `s29`, `s30`, `s31`, `s32`, `s33`, `s34`, `s35`, `s36`, `s37`, `s38`, `s39`, `s40`, `s41`, `s42`, `s43`, `s44`, `s45`, `s46`, `s47`, `s48`, `s49`, `s50`, `s51`, `s52`, `s53`, `s54`, `s55`, `s56`, `s57`, `s58`, `s59`, `s60`, `s61`, `s62`, `s63`, `s64`, `source`) VALUES
(2046099, '2017-09-28 08:46:13', 0, 7.7656, 5.6077, 0, 5.4831, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ADAM5KTCP');

-- --------------------------------------------------------

--
-- Table structure for table `app_raw_flow`
--

DROP TABLE IF EXISTS `app_raw_flow`;
CREATE TABLE IF NOT EXISTS `app_raw_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_record` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `s1` int(11) NOT NULL DEFAULT '0',
  `s2` int(11) NOT NULL DEFAULT '0',
  `s3` int(11) NOT NULL DEFAULT '0',
  `s4` int(11) NOT NULL DEFAULT '0',
  `s5` int(11) NOT NULL DEFAULT '0',
  `s6` int(11) NOT NULL DEFAULT '0',
  `s7` int(11) NOT NULL DEFAULT '0',
  `s8` int(11) NOT NULL DEFAULT '0',
  `s9` int(11) NOT NULL DEFAULT '0',
  `s10` int(11) NOT NULL DEFAULT '0',
  `s11` int(11) NOT NULL DEFAULT '0',
  `s12` int(11) NOT NULL DEFAULT '0',
  `s13` int(11) NOT NULL DEFAULT '0',
  `s14` int(11) NOT NULL DEFAULT '0',
  `s15` int(11) NOT NULL DEFAULT '0',
  `s16` int(11) NOT NULL DEFAULT '0',
  `source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_record` (`date_record`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_raw_flow`
--

INSERT INTO `app_raw_flow` (`id`, `date_record`, `s1`, `s2`, `s3`, `s4`, `s5`, `s6`, `s7`, `s8`, `s9`, `s10`, `s11`, `s12`, `s13`, `s14`, `s15`, `s16`, `source`) VALUES
(1, '2017-09-28 06:23:45', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);

--
-- Triggers `app_raw_flow`
--
DROP TRIGGER IF EXISTS `jum_tot_flow`;
DELIMITER $$
CREATE TRIGGER `jum_tot_flow` AFTER UPDATE ON `app_raw_flow` FOR EACH ROW BEGIN
declare jum_s1 int;
declare jum_s2 int;
declare jum_s3 int;
declare jum_s4 int;
declare jum_s5 int;
declare jum_s6 int;
declare jum_s7 int;
declare jum_s8 int;
declare jum_s9 int;
declare jum_s10 int;
declare jum_s11 int;
declare jum_s12 int;
declare jum_s13 int;
declare jum_s14 int;
declare jum_s15 int;
declare jum_s16 int;

select sum(s1) into jum_s1 from app_raw_flow;
select sum(s2) into jum_s2 from app_raw_flow;
select sum(s3) into jum_s3 from app_raw_flow;
select sum(s4) into jum_s4 from app_raw_flow;
select sum(s5) into jum_s5 from app_raw_flow;
select sum(s6) into jum_s6 from app_raw_flow;
select sum(s7) into jum_s7 from app_raw_flow;
select sum(s8) into jum_s8 from app_raw_flow;
select sum(s9) into jum_s9 from app_raw_flow;
select sum(s10) into jum_s10 from app_raw_flow;
select sum(s11) into jum_s11 from app_raw_flow;
select sum(s12) into jum_s12 from app_raw_flow;
select sum(s13) into jum_s13 from app_raw_flow;
select sum(s14) into jum_s14 from app_raw_flow;
select sum(s15) into jum_s15 from app_raw_flow;
select sum(s16) into jum_s16 from app_raw_flow;




update app_raw_flow_tot set s1=s1+jum_s1,s2=s2+jum_s2,s3=s3+jum_s3,s4=s4+jum_s4,s5=s5+jum_s5,s6=s6+jum_s6,s7=s7+jum_s7,s8=s8+jum_s8,
s9=s9+jum_s9,s10=s10+jum_s10,s11=s11+jum_s11,s12=s12+jum_s12,s13=s13+jum_s13,s14=s14+jum_s14,s15=s15+jum_s15,s16=s16+jum_s16;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `app_raw_flow_tot`
--

DROP TABLE IF EXISTS `app_raw_flow_tot`;
CREATE TABLE IF NOT EXISTS `app_raw_flow_tot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_record` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `s1` int(11) NOT NULL DEFAULT '0',
  `s2` int(11) NOT NULL DEFAULT '0',
  `s3` int(11) NOT NULL DEFAULT '0',
  `s4` int(11) NOT NULL DEFAULT '0',
  `s5` int(11) NOT NULL DEFAULT '0',
  `s6` int(11) NOT NULL DEFAULT '0',
  `s7` int(11) NOT NULL DEFAULT '0',
  `s8` int(11) NOT NULL DEFAULT '0',
  `s9` int(11) NOT NULL DEFAULT '0',
  `s10` int(11) NOT NULL DEFAULT '0',
  `s11` int(11) NOT NULL DEFAULT '0',
  `s12` int(11) NOT NULL DEFAULT '0',
  `s13` int(11) NOT NULL DEFAULT '0',
  `s14` int(11) NOT NULL DEFAULT '0',
  `s15` int(11) NOT NULL DEFAULT '0',
  `s16` int(11) NOT NULL DEFAULT '0',
  `source` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_record` (`date_record`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_raw_flow_tot`
--

INSERT INTO `app_raw_flow_tot` (`id`, `date_record`, `s1`, `s2`, `s3`, `s4`, `s5`, `s6`, `s7`, `s8`, `s9`, `s10`, `s11`, `s12`, `s13`, `s14`, `s15`, `s16`, `source`) VALUES
(1, '2017-09-28 06:23:38', 9015282, 4188072, 10383549, 7771248, 1194979, 446106, 3467, 0, 876, 0, 2022, 0, 0, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_raw_rs485`
--

DROP TABLE IF EXISTS `app_raw_rs485`;
CREATE TABLE IF NOT EXISTS `app_raw_rs485` (
  `id_raw_485` int(11) NOT NULL AUTO_INCREMENT,
  `date_record` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `s2` varchar(20) NOT NULL,
  `s3` varchar(20) NOT NULL,
  `s4` varchar(20) NOT NULL,
  PRIMARY KEY (`id_raw_485`),
  KEY `date_record` (`date_record`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_raw_rs485`
--

INSERT INTO `app_raw_rs485` (`id_raw_485`, `date_record`, `s2`, `s3`, `s4`) VALUES
(1, '2017-09-27 07:18:47', '2/0/0', '3/0/0', '4/0/0');

-- --------------------------------------------------------

--
-- Table structure for table `app_rep_reading`
--

DROP TABLE IF EXISTS `app_rep_reading`;
CREATE TABLE IF NOT EXISTS `app_rep_reading` (
  `id_rep` int(11) NOT NULL AUTO_INCREMENT,
  `name_rep` varchar(20) NOT NULL,
  `type_rep` tinyint(4) NOT NULL,
  `sensor_temp` int(11) NOT NULL,
  `sensor_pressure` int(11) NOT NULL,
  `sensor_h2o` int(11) NOT NULL,
  `user_rep` int(11) NOT NULL,
  PRIMARY KEY (`id_rep`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_rep_reading`
--

INSERT INTO `app_rep_reading` (`id_rep`, `name_rep`, `type_rep`, `sensor_temp`, `sensor_pressure`, `sensor_h2o`, `user_rep`) VALUES
(2, 'Yahoo', 0, 24, 1, 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `app_sensor_user`
--

DROP TABLE IF EXISTS `app_sensor_user`;
CREATE TABLE IF NOT EXISTS `app_sensor_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_data` int(4) NOT NULL,
  `id_user` int(11) NOT NULL,
  `use_panel` int(11) NOT NULL,
  `nama_group_sensor` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=801 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_sensor_user`
--

INSERT INTO `app_sensor_user` (`id`, `source_data`, `id_user`, `use_panel`, `nama_group_sensor`) VALUES
(499, 78, 3, 5001, 'tes'),
(500, 57, 3, 5002, 'tes'),
(501, 34, 3, 5001, 'TEMPORARY'),
(502, 35, 3, 5002, 'TEMPORARY'),
(503, 40, 3, 5003, 'TEMPORARY'),
(504, 46, 3, 5004, 'TEMPORARY'),
(505, 43, 3, 5005, 'TEMPORARY'),
(506, 38, 3, 5006, 'TEMPORARY'),
(507, 50, 3, 5007, 'TEMPORARY'),
(508, 48, 3, 5008, 'TEMPORARY'),
(509, 79, 3, 5009, 'TEMPORARY'),
(510, 51, 3, 5010, 'TEMPORARY'),
(511, 66, 3, 5011, 'TEMPORARY'),
(512, 59, 3, 5012, 'TEMPORARY'),
(513, 65, 3, 5013, 'TEMPORARY'),
(514, 77, 3, 5014, 'TEMPORARY'),
(515, 83, 3, 5015, 'TEMPORARY'),
(516, 89, 3, 5016, 'TEMPORARY'),
(517, 71, 3, 5017, 'TEMPORARY'),
(518, 70, 3, 5018, 'TEMPORARY'),
(519, 63, 3, 5019, 'TEMPORARY'),
(520, 76, 3, 5020, 'TEMPORARY'),
(521, 82, 3, 5021, 'TEMPORARY'),
(522, 88, 3, 5022, 'TEMPORARY'),
(523, 72, 3, 5023, 'TEMPORARY'),
(524, 85, 3, 5024, 'TEMPORARY'),
(525, 60, 3, 5025, 'TEMPORARY'),
(526, 75, 3, 5026, 'TEMPORARY'),
(527, 81, 3, 5027, 'TEMPORARY'),
(528, 87, 3, 5028, 'TEMPORARY'),
(529, 80, 3, 5029, 'TEMPORARY'),
(530, 44, 3, 5030, 'TEMPORARY'),
(531, 53, 3, 5031, 'TEMPORARY'),
(532, 67, 3, 5032, 'TEMPORARY'),
(533, 78, 3, 5033, 'TEMPORARY'),
(534, 86, 3, 5034, 'TEMPORARY'),
(535, 56, 3, 5035, 'TEMPORARY'),
(536, 68, 3, 5036, 'TEMPORARY'),
(573, 34, 3, 1, 'main'),
(574, 35, 3, 2, 'main'),
(575, 40, 3, 3, 'main'),
(576, 46, 3, 4, 'main'),
(577, 43, 3, 5, 'main'),
(578, 38, 3, 6, 'main'),
(579, 50, 3, 7, 'main'),
(580, 48, 3, 8, 'main'),
(581, 79, 3, 9, 'main'),
(582, 51, 3, 10, 'main'),
(583, 66, 3, 11, 'main'),
(584, 59, 3, 12, 'main'),
(585, 65, 3, 13, 'main'),
(586, 63, 3, 19, 'main'),
(587, 60, 3, 25, 'main'),
(588, 53, 3, 31, 'main'),
(589, 77, 3, 14, 'main'),
(590, 76, 3, 20, 'main'),
(591, 75, 3, 26, 'main'),
(592, 67, 3, 32, 'main'),
(593, 83, 3, 15, 'main'),
(594, 82, 3, 21, 'main'),
(595, 81, 3, 27, 'main'),
(596, 78, 3, 33, 'main'),
(597, 89, 3, 16, 'main'),
(598, 88, 3, 22, 'main'),
(599, 87, 3, 28, 'main'),
(600, 86, 3, 34, 'main'),
(601, 71, 3, 17, 'main'),
(602, 72, 3, 23, 'main'),
(603, 80, 3, 29, 'main'),
(604, 56, 3, 35, 'main'),
(605, 70, 3, 18, 'main'),
(606, 85, 3, 24, 'main'),
(607, 44, 3, 30, 'main'),
(608, 68, 3, 36, 'main'),
(609, 34, 5, 1, 'OPERATOR'),
(610, 0, 5, 2, 'OPERATOR'),
(611, 0, 5, 3, 'OPERATOR'),
(612, 0, 5, 4, 'OPERATOR'),
(613, 0, 5, 5, 'OPERATOR'),
(614, 0, 5, 6, 'OPERATOR'),
(615, 0, 5, 7, 'OPERATOR'),
(616, 0, 5, 8, 'OPERATOR'),
(617, 0, 5, 9, 'OPERATOR'),
(618, 0, 5, 10, 'OPERATOR'),
(619, 0, 5, 11, 'OPERATOR'),
(620, 0, 5, 12, 'OPERATOR'),
(621, 0, 5, 13, 'OPERATOR'),
(622, 0, 5, 14, 'OPERATOR'),
(623, 0, 5, 15, 'OPERATOR'),
(624, 0, 5, 16, 'OPERATOR'),
(625, 0, 5, 17, 'OPERATOR'),
(626, 0, 5, 18, 'OPERATOR'),
(627, 0, 5, 19, 'OPERATOR'),
(628, 0, 5, 20, 'OPERATOR'),
(629, 0, 5, 21, 'OPERATOR'),
(630, 0, 5, 22, 'OPERATOR'),
(631, 0, 5, 23, 'OPERATOR'),
(632, 0, 5, 24, 'OPERATOR'),
(633, 0, 5, 25, 'OPERATOR'),
(634, 0, 5, 26, 'OPERATOR'),
(635, 0, 5, 27, 'OPERATOR'),
(636, 0, 5, 28, 'OPERATOR'),
(637, 0, 5, 29, 'OPERATOR'),
(638, 0, 5, 30, 'OPERATOR'),
(639, 0, 5, 31, 'OPERATOR'),
(640, 0, 5, 32, 'OPERATOR'),
(641, 0, 5, 33, 'OPERATOR'),
(642, 0, 5, 34, 'OPERATOR'),
(643, 0, 5, 35, 'OPERATOR'),
(644, 0, 5, 36, 'OPERATOR'),
(645, 0, 4, 1, 'SUPERVISOR'),
(646, 0, 4, 2, 'SUPERVISOR'),
(647, 0, 4, 3, 'SUPERVISOR'),
(648, 0, 4, 4, 'SUPERVISOR'),
(649, 0, 4, 5, 'SUPERVISOR'),
(650, 0, 4, 6, 'SUPERVISOR'),
(651, 0, 4, 7, 'SUPERVISOR'),
(652, 0, 4, 8, 'SUPERVISOR'),
(653, 0, 4, 9, 'SUPERVISOR'),
(654, 0, 4, 10, 'SUPERVISOR'),
(655, 0, 4, 11, 'SUPERVISOR'),
(656, 0, 4, 12, 'SUPERVISOR'),
(657, 0, 4, 13, 'SUPERVISOR'),
(658, 0, 4, 14, 'SUPERVISOR'),
(659, 0, 4, 15, 'SUPERVISOR'),
(660, 0, 4, 16, 'SUPERVISOR'),
(661, 0, 4, 17, 'SUPERVISOR'),
(662, 0, 4, 18, 'SUPERVISOR'),
(663, 0, 4, 19, 'SUPERVISOR'),
(664, 0, 4, 20, 'SUPERVISOR'),
(665, 0, 4, 21, 'SUPERVISOR'),
(666, 0, 4, 22, 'SUPERVISOR'),
(667, 0, 4, 23, 'SUPERVISOR'),
(668, 0, 4, 24, 'SUPERVISOR'),
(669, 0, 4, 25, 'SUPERVISOR'),
(670, 0, 4, 26, 'SUPERVISOR'),
(671, 0, 4, 27, 'SUPERVISOR'),
(672, 0, 4, 28, 'SUPERVISOR'),
(673, 0, 4, 29, 'SUPERVISOR'),
(674, 0, 4, 30, 'SUPERVISOR'),
(675, 0, 4, 31, 'SUPERVISOR'),
(676, 0, 4, 32, 'SUPERVISOR'),
(677, 0, 4, 33, 'SUPERVISOR'),
(678, 0, 4, 34, 'SUPERVISOR'),
(679, 0, 4, 35, 'SUPERVISOR'),
(680, 0, 4, 36, 'SUPERVISOR'),
(681, 0, 6, 1, 'MAIN'),
(682, 0, 6, 2, 'MAIN'),
(683, 0, 6, 3, 'MAIN'),
(684, 0, 6, 4, 'MAIN'),
(685, 0, 6, 5, 'MAIN'),
(686, 0, 6, 6, 'MAIN'),
(687, 0, 6, 7, 'MAIN'),
(688, 0, 6, 8, 'MAIN'),
(689, 0, 6, 9, 'MAIN'),
(690, 0, 6, 10, 'MAIN'),
(691, 0, 6, 11, 'MAIN'),
(692, 0, 6, 12, 'MAIN'),
(693, 0, 6, 13, 'MAIN'),
(694, 0, 6, 14, 'MAIN'),
(695, 0, 6, 15, 'MAIN'),
(696, 0, 6, 16, 'MAIN'),
(697, 0, 6, 17, 'MAIN'),
(698, 0, 6, 18, 'MAIN'),
(699, 0, 6, 19, 'MAIN'),
(700, 0, 6, 20, 'MAIN'),
(701, 0, 6, 21, 'MAIN'),
(702, 0, 6, 22, 'MAIN'),
(703, 0, 6, 23, 'MAIN'),
(704, 0, 6, 24, 'MAIN'),
(705, 0, 6, 25, 'MAIN'),
(706, 0, 6, 26, 'MAIN'),
(707, 0, 6, 27, 'MAIN'),
(708, 0, 6, 28, 'MAIN'),
(709, 0, 6, 29, 'MAIN'),
(710, 0, 6, 30, 'MAIN'),
(711, 0, 6, 31, 'MAIN'),
(712, 0, 6, 32, 'MAIN'),
(713, 0, 6, 33, 'MAIN'),
(714, 0, 6, 34, 'MAIN'),
(715, 0, 6, 35, 'MAIN'),
(716, 0, 6, 36, 'MAIN'),
(717, 34, 8, 1, 'OPERATOR'),
(718, 0, 8, 2, 'OPERATOR'),
(719, 0, 8, 3, 'OPERATOR'),
(720, 0, 8, 4, 'OPERATOR'),
(721, 0, 8, 5, 'OPERATOR'),
(722, 0, 8, 6, 'OPERATOR'),
(723, 0, 8, 7, 'OPERATOR'),
(724, 0, 8, 8, 'OPERATOR'),
(725, 0, 8, 9, 'OPERATOR'),
(726, 0, 8, 10, 'OPERATOR'),
(727, 0, 8, 11, 'OPERATOR'),
(728, 0, 8, 12, 'OPERATOR'),
(729, 0, 8, 13, 'OPERATOR'),
(730, 0, 8, 14, 'OPERATOR'),
(731, 0, 8, 15, 'OPERATOR'),
(732, 0, 8, 16, 'OPERATOR'),
(733, 0, 8, 17, 'OPERATOR'),
(734, 0, 8, 18, 'OPERATOR'),
(735, 0, 8, 19, 'OPERATOR'),
(736, 0, 8, 20, 'OPERATOR'),
(737, 0, 8, 21, 'OPERATOR'),
(738, 0, 8, 22, 'OPERATOR'),
(739, 0, 8, 23, 'OPERATOR'),
(740, 0, 8, 24, 'OPERATOR'),
(741, 0, 8, 25, 'OPERATOR'),
(742, 0, 8, 26, 'OPERATOR'),
(743, 0, 8, 27, 'OPERATOR'),
(744, 0, 8, 28, 'OPERATOR'),
(745, 0, 8, 29, 'OPERATOR'),
(746, 0, 8, 30, 'OPERATOR'),
(747, 0, 8, 31, 'OPERATOR'),
(748, 0, 8, 32, 'OPERATOR'),
(749, 0, 8, 33, 'OPERATOR'),
(750, 0, 8, 34, 'OPERATOR'),
(751, 0, 8, 35, 'OPERATOR'),
(752, 0, 8, 36, 'OPERATOR'),
(753, 0, 8, 37, 'OPERATOR'),
(754, 0, 8, 38, 'OPERATOR'),
(755, 0, 8, 39, 'OPERATOR'),
(756, 0, 8, 40, 'OPERATOR'),
(757, 0, 8, 41, 'OPERATOR'),
(758, 0, 8, 42, 'OPERATOR'),
(759, 0, 8, 43, 'OPERATOR'),
(760, 0, 8, 44, 'OPERATOR'),
(761, 0, 8, 45, 'OPERATOR'),
(762, 0, 8, 46, 'OPERATOR'),
(763, 0, 8, 47, 'OPERATOR'),
(764, 0, 8, 48, 'OPERATOR'),
(765, 34, 8, 1001, 'MAIN'),
(766, 0, 8, 1002, 'MAIN'),
(767, 0, 8, 1003, 'MAIN'),
(768, 0, 8, 1004, 'MAIN'),
(769, 0, 8, 1005, 'MAIN'),
(770, 0, 8, 1006, 'MAIN'),
(771, 0, 8, 1007, 'MAIN'),
(772, 0, 8, 1008, 'MAIN'),
(773, 0, 8, 1009, 'MAIN'),
(774, 0, 8, 1010, 'MAIN'),
(775, 0, 8, 1011, 'MAIN'),
(776, 0, 8, 1012, 'MAIN'),
(777, 0, 8, 1013, 'MAIN'),
(778, 0, 8, 1014, 'MAIN'),
(779, 0, 8, 1015, 'MAIN'),
(780, 0, 8, 1016, 'MAIN'),
(781, 0, 8, 1017, 'MAIN'),
(782, 0, 8, 1018, 'MAIN'),
(783, 0, 8, 1019, 'MAIN'),
(784, 0, 8, 1020, 'MAIN'),
(785, 0, 8, 1021, 'MAIN'),
(786, 0, 8, 1022, 'MAIN'),
(787, 0, 8, 1023, 'MAIN'),
(788, 0, 8, 1024, 'MAIN'),
(789, 0, 8, 1025, 'MAIN'),
(790, 0, 8, 1026, 'MAIN'),
(791, 0, 8, 1027, 'MAIN'),
(792, 0, 8, 1028, 'MAIN'),
(793, 0, 8, 1029, 'MAIN'),
(794, 0, 8, 1030, 'MAIN'),
(795, 0, 8, 1031, 'MAIN'),
(796, 0, 8, 1032, 'MAIN'),
(797, 0, 8, 1033, 'MAIN'),
(798, 0, 8, 1034, 'MAIN'),
(799, 0, 8, 1035, 'MAIN'),
(800, 0, 8, 1036, 'MAIN');

-- --------------------------------------------------------

--
-- Table structure for table `app_template_view`
--

DROP TABLE IF EXISTS `app_template_view`;
CREATE TABLE IF NOT EXISTS `app_template_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_template` varchar(50) DEFAULT NULL,
  `value_template` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_template_view`
--

INSERT INTO `app_template_view` (`id`, `name_template`, `value_template`) VALUES
(1, 'charsetdash', '2'),
(2, 'styledash', '100'),
(3, 'colordash', '16777215:65535:65535:255:255:0:0:16777215'),
(4, 'titlefontsize', '18');

-- --------------------------------------------------------

--
-- Table structure for table `app_type_sensor`
--

DROP TABLE IF EXISTS `app_type_sensor`;
CREATE TABLE IF NOT EXISTS `app_type_sensor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_type` varchar(50) DEFAULT NULL,
  `status` tinyint(2) DEFAULT NULL,
  `type_group` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_type_sensor`
--

INSERT INTO `app_type_sensor` (`id`, `name_type`, `status`, `type_group`) VALUES
(0, 'LEVEL', -1, 1),
(1, 'PRESSURE', -1, 1),
(2, 'TEMPERATURE', -1, 1),
(3, 'FLOW', -1, 1),
(4, 'H2S', -1, 1),
(5, 'RPM', -1, 1),
(6, 'GAS', -1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_flow`
--

DROP TABLE IF EXISTS `app_unit_flow`;
CREATE TABLE IF NOT EXISTS `app_unit_flow` (
  `id_unit_flow` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `lt` float NOT NULL,
  `bbl` float NOT NULL,
  `gal` float NOT NULL,
  PRIMARY KEY (`id_unit_flow`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_flow`
--

INSERT INTO `app_unit_flow` (`id_unit_flow`, `sumber`, `lt`, `bbl`, `gal`) VALUES
(1, 'lt', 1, 1, 1),
(2, 'bbl', 1, 1, 1),
(3, 'gal', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_gas`
--

DROP TABLE IF EXISTS `app_unit_gas`;
CREATE TABLE IF NOT EXISTS `app_unit_gas` (
  `id_unit_gas` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `mm` float NOT NULL,
  PRIMARY KEY (`id_unit_gas`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_gas`
--

INSERT INTO `app_unit_gas` (`id_unit_gas`, `sumber`, `mm`) VALUES
(1, 'mm', 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_h2s`
--

DROP TABLE IF EXISTS `app_unit_h2s`;
CREATE TABLE IF NOT EXISTS `app_unit_h2s` (
  `id_unit_h2s` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `ppm` float NOT NULL,
  `%` float NOT NULL,
  PRIMARY KEY (`id_unit_h2s`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_h2s`
--

INSERT INTO `app_unit_h2s` (`id_unit_h2s`, `sumber`, `ppm`, `%`) VALUES
(1, 'ppm', 1, 1),
(2, '%', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_level`
--

DROP TABLE IF EXISTS `app_unit_level`;
CREATE TABLE IF NOT EXISTS `app_unit_level` (
  `id_unit_level` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `m3` float NOT NULL,
  `bbl` float NOT NULL,
  `gal` float NOT NULL,
  `Ltr` float NOT NULL,
  `cm` float NOT NULL,
  `mm` float NOT NULL,
  `%` float NOT NULL,
  PRIMARY KEY (`id_unit_level`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_level`
--

INSERT INTO `app_unit_level` (`id_unit_level`, `sumber`, `m3`, `bbl`, `gal`, `Ltr`, `cm`, `mm`, `%`) VALUES
(1, 'm3', 1, 6.2898, 264.172, 1000, 0, 0, 0),
(2, 'bbl', 0.15899, 1, 42, 158.99, 0, 0, 0),
(3, 'ltr', 0.001, 0.0063, 0.264172, 1, 0, 0, 0),
(4, 'gal', 0.00379, 0.0238, 1, 3.7854, 0, 0, 0),
(5, 'cm', 0.00379, 0.0238, 1, 3.7854, 1, 10, 0),
(6, 'mm', 0.00379, 0.0238, 1, 3.7854, 0.1, 1, 0),
(7, '%', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_level_len`
--

DROP TABLE IF EXISTS `app_unit_level_len`;
CREATE TABLE IF NOT EXISTS `app_unit_level_len` (
  `id_unit_level` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `cm` float NOT NULL,
  `m` float NOT NULL,
  `inch` float NOT NULL,
  `feet` float NOT NULL,
  `%` float DEFAULT NULL,
  PRIMARY KEY (`id_unit_level`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_level_len`
--

INSERT INTO `app_unit_level_len` (`id_unit_level`, `sumber`, `cm`, `m`, `inch`, `feet`, `%`) VALUES
(1, 'cm', 1, 0.01, 0.3937, 0.03281, NULL),
(2, 'm', 100, 1, 39.37, 3.281, NULL),
(3, 'inch', 2.54, 0.0254, 1, 0.0833, NULL),
(4, 'feet', 30.48, 0.30479, 12, 1, NULL),
(5, '%', 0, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_pressure`
--

DROP TABLE IF EXISTS `app_unit_pressure`;
CREATE TABLE IF NOT EXISTS `app_unit_pressure` (
  `id_unit_pressure` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(10) NOT NULL,
  `psi` float NOT NULL DEFAULT '0',
  `bar` float NOT NULL DEFAULT '0',
  `pascal` float NOT NULL DEFAULT '0',
  `kpascal` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_unit_pressure`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_pressure`
--

INSERT INTO `app_unit_pressure` (`id_unit_pressure`, `sumber`, `psi`, `bar`, `pascal`, `kpascal`) VALUES
(1, 'psi', 1, 0.0689476, 6894.8, 6.89476),
(2, 'bar', 14.5038, 1, 100000, 100),
(3, 'pascal', 0.0001, 0.00001, 1, 0.001),
(4, 'kpascal', 0.145, 0.01, 1000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_rpm`
--

DROP TABLE IF EXISTS `app_unit_rpm`;
CREATE TABLE IF NOT EXISTS `app_unit_rpm` (
  `id_unit_flow` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `rpm` float NOT NULL,
  PRIMARY KEY (`id_unit_flow`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_rpm`
--

INSERT INTO `app_unit_rpm` (`id_unit_flow`, `sumber`, `rpm`) VALUES
(1, 'rpm', 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_sensor`
--

DROP TABLE IF EXISTS `app_unit_sensor`;
CREATE TABLE IF NOT EXISTS `app_unit_sensor` (
  `id_unit_sensor` int(11) NOT NULL AUTO_INCREMENT,
  `name_sensor` varchar(15) NOT NULL,
  `unit_sensor` varchar(10) NOT NULL,
  PRIMARY KEY (`id_unit_sensor`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_sensor`
--

INSERT INTO `app_unit_sensor` (`id_unit_sensor`, `name_sensor`, `unit_sensor`) VALUES
(1, 'level', 'mm'),
(2, 'level', 'cm'),
(3, 'level', 'inch'),
(4, 'level', 'feet'),
(5, 'pressure', 'bar'),
(6, 'pressure', 'psi'),
(7, 'temperature', 'C'),
(8, 'temperature', 'F'),
(9, 'temperature', 'K'),
(10, 'h2s', 'ppm'),
(11, 'h2s', '%'),
(12, 'flow', 'Lt'),
(13, 'flow', 'Bbl'),
(14, 'flow', 'Gal'),
(15, 'pressure', 'pascal'),
(16, 'pressure', 'Kpascal'),
(17, 'rpm', 'rpm'),
(18, 'gas', 'MM');

-- --------------------------------------------------------

--
-- Table structure for table `app_unit_temperature`
--

DROP TABLE IF EXISTS `app_unit_temperature`;
CREATE TABLE IF NOT EXISTS `app_unit_temperature` (
  `id_unit_temperature` int(11) NOT NULL AUTO_INCREMENT,
  `sumber` varchar(5) NOT NULL,
  `C` float NOT NULL DEFAULT '0',
  `F` float NOT NULL DEFAULT '0',
  `K` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_unit_temperature`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_unit_temperature`
--

INSERT INTO `app_unit_temperature` (`id_unit_temperature`, `sumber`, `C`, `F`, `K`) VALUES
(1, 'C', 1, 33.8, 274.15),
(2, 'F', -17.2222, 1, 255.928),
(3, 'K', -272.15, -457.87, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_user`
--

DROP TABLE IF EXISTS `app_user`;
CREATE TABLE IF NOT EXISTS `app_user` (
  `APP_USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `APP_FULL_NAME` varchar(80) DEFAULT NULL,
  `APP_USER_NAME` varchar(10) DEFAULT NULL,
  `APP_USER_PASSWORD` varchar(100) DEFAULT NULL,
  `ACTIVATE` tinyint(2) NOT NULL DEFAULT '0',
  `app_level_user` varchar(10) NOT NULL,
  `online_stat` tinyint(4) NOT NULL DEFAULT '0',
  `last_login` datetime NOT NULL,
  `ip_login` varchar(15) NOT NULL,
  PRIMARY KEY (`APP_USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_user`
--

INSERT INTO `app_user` (`APP_USER_ID`, `APP_FULL_NAME`, `APP_USER_NAME`, `APP_USER_PASSWORD`, `ACTIVATE`, `app_level_user`, `online_stat`, `last_login`, `ip_login`) VALUES
(3, 'PT. Vessel Freshfish Indomakmur', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, 'admin', -1, '2017-09-27 14:10:44', '192.168.0.101'),
(6, 'SUPERVISOR', 'supervisor', '09348c20a019be0318387c08df7a783d', 1, 'supervisor', -1, '2017-08-31 13:29:00', '192.168.0.101'),
(8, 'OPERATOR', 'operator', '4b583376b2767b923c3e1da60d10de59', 1, 'user', 0, '2017-08-31 13:50:51', '192.168.0.101');

-- --------------------------------------------------------

--
-- Table structure for table `art_sensor`
--

DROP TABLE IF EXISTS `art_sensor`;
CREATE TABLE IF NOT EXISTS `art_sensor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('pressure','temperature','diff') NOT NULL,
  `name` varchar(140) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `art_sensor_combination`
--

DROP TABLE IF EXISTS `art_sensor_combination`;
CREATE TABLE IF NOT EXISTS `art_sensor_combination` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `panel` int(11) NOT NULL,
  `pressure` int(11) NOT NULL,
  `temperature` int(11) NOT NULL,
  `diff` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `art_sensor_value`
--

DROP TABLE IF EXISTS `art_sensor_value`;
CREATE TABLE IF NOT EXISTS `art_sensor_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_combination` int(11) NOT NULL,
  `pressure` double NOT NULL,
  `temperature` double NOT NULL,
  `diff` double NOT NULL,
  `orifice` double NOT NULL,
  `gfr` double NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sensor_combination` (`sensor_combination`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `art_sensor_value`
--
ALTER TABLE `art_sensor_value`
  ADD CONSTRAINT `art_sensor_value_ibfk_1` FOREIGN KEY (`sensor_combination`) REFERENCES `art_sensor_combination` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
