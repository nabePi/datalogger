-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2017 at 05:54 AM
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
  `_color` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dashboard`
--

INSERT INTO `dashboard` (`id`, `users_id`, `_group`, `_sensor`, `_color`) VALUES
(2, 2, 3, 53, ''),
(3, 1, 1, 63, ''),
(5, 2, 1, 34, ''),
(6, 2, 3, 48, ''),
(7, 2, 1, 63, ''),
(10, 2, 6, 35, ''),
(11, 2, 6, 34, '');

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
(1, 'POMPA Baru', 'Group pompa '),
(2, 'COLD_STORAGE', 'Group cold storage'),
(3, 'Group Testing', 'Testing group'),
(5, 'TESTING_EDIT', 'Testing edit'),
(6, 'Group Baru', 'lorem');

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
(2, 'admin', '$2a$10$SBsXsT6P69XGKFQM8ZAIy.ZQs30uIzp9NqW8S.QUOW0N/7bJX.mTO', 2);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
