-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 17, 2020 at 02:38 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `optica`
--

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `cliente_id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `fecha_registro` date NOT NULL,
  `recomendado_de` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cristales`
--

CREATE TABLE `cristales` (
  `cristal_id` int(11) NOT NULL,
  `color_izq` varchar(50) NOT NULL,
  `color_der` varchar(50) NOT NULL,
  `graduacion_izq` int(11) NOT NULL,
  `graduacion_der` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `gafas`
--

CREATE TABLE `gafas` (
  `gafas_id` int(11) NOT NULL,
  `precio` double NOT NULL,
  `marca_id` int(11) NOT NULL,
  `montura_id` int(11) NOT NULL,
  `cristal_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `marca`
--

CREATE TABLE `marca` (
  `marca_id` int(11) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `proveedor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `montura`
--

CREATE TABLE `montura` (
  `montura_id` int(11) NOT NULL,
  `tipo` enum('flotante','pasta','metalica') NOT NULL,
  `color` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `proveedor_id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `calle` varchar(50) NOT NULL,
  `num` int(11) NOT NULL,
  `piso` int(11) NOT NULL,
  `puerta` varchar(50) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `codigo_postal` int(11) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `telefono` int(11) NOT NULL,
  `fax` int(11) NOT NULL,
  `NIF` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `venda`
--

CREATE TABLE `venda` (
  `venda_id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `gafas_id` int(11) NOT NULL,
  `empleado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cliente_id`),
  ADD KEY `recomendado_de` (`recomendado_de`);

--
-- Indexes for table `cristales`
--
ALTER TABLE `cristales`
  ADD PRIMARY KEY (`cristal_id`);

--
-- Indexes for table `gafas`
--
ALTER TABLE `gafas`
  ADD PRIMARY KEY (`gafas_id`),
  ADD UNIQUE KEY `cristal_id` (`cristal_id`),
  ADD KEY `marca_id` (`marca_id`),
  ADD KEY `montura_id` (`montura_id`);

--
-- Indexes for table `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`marca_id`,`proveedor_id`),
  ADD UNIQUE KEY `UNIQUE_proveedor_id` (`proveedor_id`);

--
-- Indexes for table `montura`
--
ALTER TABLE `montura`
  ADD PRIMARY KEY (`montura_id`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`proveedor_id`);

--
-- Indexes for table `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`venda_id`),
  ADD KEY `gafas_id` (`gafas_id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gafas`
--
ALTER TABLE `gafas`
  MODIFY `gafas_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `montura`
--
ALTER TABLE `montura`
  MODIFY `montura_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `proveedor_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `venda`
--
ALTER TABLE `venda`
  MODIFY `venda_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`recomendado_de`) REFERENCES `cliente` (`cliente_id`);

--
-- Constraints for table `gafas`
--
ALTER TABLE `gafas`
  ADD CONSTRAINT `gafas_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`marca_id`),
  ADD CONSTRAINT `gafas_ibfk_2` FOREIGN KEY (`montura_id`) REFERENCES `montura` (`montura_id`),
  ADD CONSTRAINT `gafas_ibfk_3` FOREIGN KEY (`cristal_id`) REFERENCES `cristales` (`cristal_id`);

--
-- Constraints for table `marca`
--
ALTER TABLE `marca`
  ADD CONSTRAINT `marca_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`proveedor_id`);

--
-- Constraints for table `venda`
--
ALTER TABLE `venda`
  ADD CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`gafas_id`) REFERENCES `gafas` (`gafas_id`),
  ADD CONSTRAINT `venda_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
