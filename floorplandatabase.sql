-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 07, 2018 at 05:25 PM
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
-- Database: `floorplan`
--

-- --------------------------------------------------------

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
CREATE TABLE IF NOT EXISTS `building` (
  `builingID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingName` varchar(50) NOT NULL,
  `buildingNumberOfEntrances` int(6) NOT NULL,
  `buildingNumberOfFloors` int(6) NOT NULL,
  PRIMARY KEY (`builingID`),
  KEY `Index` (`buildingName`,`buildingNumberOfEntrances`,`buildingNumberOfFloors`)
) ENGINE=InnoDB AUTO_INCREMENT=23464 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `building`
--

INSERT INTO `building` (`builingID`, `buildingName`, `buildingNumberOfEntrances`, `buildingNumberOfFloors`) VALUES
(23462, 'Buckingham', 3, 2),
(23463, 'Dennis', 2, 2),
(23461, 'Liongate', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `elevator`
--

DROP TABLE IF EXISTS `elevator`;
CREATE TABLE IF NOT EXISTS `elevator` (
  `entranceID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `elevatorCapacity` int(6) NOT NULL,
  `elevatorLatitude` int(100) NOT NULL,
  `elevatorLongitude` int(100) NOT NULL,
  PRIMARY KEY (`entranceID`),
  KEY `ElevatorFK01` (`floorID`) USING BTREE,
  KEY `Index` (`elevatorCapacity`,`elevatorLatitude`,`elevatorLongitude`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entrances`
--

DROP TABLE IF EXISTS `entrances`;
CREATE TABLE IF NOT EXISTS `entrances` (
  `entranceID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingID` int(6) NOT NULL,
  `entranceLatitude` float NOT NULL,
  `entranceLongitude` float NOT NULL,
  `entranceDisabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`entranceID`),
  KEY `EntranceFK01` (`buildingID`) USING BTREE,
  KEY `Index` (`entranceLatitude`,`entranceLongitude`,`entranceDisabled`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entrances`
--

INSERT INTO `entrances` (`entranceID`, `buildingID`, `entranceLatitude`, `entranceLongitude`, `entranceDisabled`) VALUES
(17, 23461, 50.799, -1.09846, 1),
(18, 23461, 50.7989, -1.09808, 0);

-- --------------------------------------------------------

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
CREATE TABLE IF NOT EXISTS `floor` (
  `floorID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingID` int(6) NOT NULL,
  PRIMARY KEY (`floorID`) USING BTREE,
  KEY `FloorFK01` (`buildingID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logindetails`
--

DROP TABLE IF EXISTS `logindetails`;
CREATE TABLE IF NOT EXISTS `logindetails` (
  `loginEmail` varchar(50) NOT NULL,
  `loginUsername` varchar(50) NOT NULL,
  `loginPassword` varchar(50) NOT NULL,
  PRIMARY KEY (`loginEmail`) USING BTREE,
  KEY `loginUsername` (`loginUsername`,`loginPassword`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `roomID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `roomLatitude` decimal(10,10) NOT NULL,
  `roomLongitude` decimal(10,10) NOT NULL,
  `roomSize` int(6) NOT NULL,
  PRIMARY KEY (`roomID`),
  KEY `RoomFK01` (`floorID`) USING BTREE,
  KEY `Index` (`roomLatitude`,`roomLongitude`,`roomSize`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stairs`
--

DROP TABLE IF EXISTS `stairs`;
CREATE TABLE IF NOT EXISTS `stairs` (
  `stairsID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `stairsLatitude` decimal(10,10) NOT NULL,
  `stairsLongitude` decimal(10,10) NOT NULL,
  PRIMARY KEY (`stairsID`) USING BTREE,
  KEY `StairsFK01` (`floorID`) USING BTREE,
  KEY `Index` (`stairsLatitude`,`stairsLongitude`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `elevator`
--
ALTER TABLE `elevator`
  ADD CONSTRAINT `elevator_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);

--
-- Constraints for table `entrances`
--
ALTER TABLE `entrances`
  ADD CONSTRAINT `entrances_ibfk_1` FOREIGN KEY (`buildingID`) REFERENCES `building` (`builingID`);

--
-- Constraints for table `floor`
--
ALTER TABLE `floor`
  ADD CONSTRAINT `floor_ibfk_1` FOREIGN KEY (`buildingID`) REFERENCES `building` (`builingID`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);

--
-- Constraints for table `stairs`
--
ALTER TABLE `stairs`
  ADD CONSTRAINT `stairs_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
