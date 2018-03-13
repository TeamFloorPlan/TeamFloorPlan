-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 13, 2018 at 08:57 PM
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
-- Database: `floorplanv2`
--

-- --------------------------------------------------------

--
-- Table structure for table `array`
--

DROP TABLE IF EXISTS `array`;
CREATE TABLE IF NOT EXISTS `array` (
  `arrayID` int(6) NOT NULL AUTO_INCREMENT,
  `pathID` int(6) NOT NULL,
  `coordinates` varchar(256) NOT NULL,
  PRIMARY KEY (`arrayID`),
  KEY `arrayID` (`pathID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
CREATE TABLE IF NOT EXISTS `building` (
  `buildingName` varchar(30) NOT NULL,
  `buildingNumberOfEntrances` int(6) NOT NULL,
  `buildingNumberOfFloors` int(6) NOT NULL,
  PRIMARY KEY (`buildingName`),
  KEY `buildingNumberOfEntrances` (`buildingNumberOfEntrances`),
  KEY `buildingNumberOfFloors` (`buildingNumberOfFloors`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `building`
--

INSERT INTO `building` (`buildingName`, `buildingNumberOfEntrances`, `buildingNumberOfFloors`) VALUES
('a', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `elevator`
--

DROP TABLE IF EXISTS `elevator`;
CREATE TABLE IF NOT EXISTS `elevator` (
  `elevatorID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  PRIMARY KEY (`elevatorID`),
  KEY `elevatorFK01` (`floorID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entrance`
--

DROP TABLE IF EXISTS `entrance`;
CREATE TABLE IF NOT EXISTS `entrance` (
  `entranceID` int(6) NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `floorID` int(6) NOT NULL COMMENT 'foreign key',
  PRIMARY KEY (`entranceID`),
  KEY `EntranceFK01` (`floorID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
CREATE TABLE IF NOT EXISTS `floor` (
  `floorID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingName` varchar(30) NOT NULL,
  PRIMARY KEY (`floorID`),
  KEY `buildingName` (`buildingName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `floor`
--

INSERT INTO `floor` (`floorID`, `buildingName`) VALUES
(1, 'a');

-- --------------------------------------------------------

--
-- Table structure for table `logindetails`
--

DROP TABLE IF EXISTS `logindetails`;
CREATE TABLE IF NOT EXISTS `logindetails` (
  `loginEmail` varchar(50) NOT NULL,
  `loginPassword` varchar(50) NOT NULL,
  `loginUsername` varchar(50) NOT NULL,
  `loginDisabled` tinyint(1) DEFAULT NULL,
  `loginColourBlind` tinyint(1) DEFAULT NULL,
  `loginNeedLageText` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`loginEmail`),
  UNIQUE KEY `loginUsername` (`loginUsername`),
  KEY `loginPassword` (`loginPassword`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logindetails`
--

INSERT INTO `logindetails` (`loginEmail`, `loginPassword`, `loginUsername`, `loginDisabled`, `loginColourBlind`, `loginNeedLageText`) VALUES
('a@a.com', 'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9', 'aA', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `path`
--

DROP TABLE IF EXISTS `path`;
CREATE TABLE IF NOT EXISTS `path` (
  `pathID` int(6) NOT NULL AUTO_INCREMENT,
  `roomID` int(6) DEFAULT NULL,
  `entranceID` int(6) DEFAULT NULL,
  `stairID` int(6) DEFAULT NULL,
  `elevatorID` int(6) DEFAULT NULL,
  `ArrayID` int(6) DEFAULT NULL,
  PRIMARY KEY (`pathID`),
  KEY `stairID` (`stairID`),
  KEY `entranceID` (`entranceID`),
  KEY `pathFK01` (`roomID`,`entranceID`,`stairID`,`elevatorID`) USING BTREE,
  KEY `elevatorID` (`elevatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `roomID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `roomSize` int(6) NOT NULL,
  PRIMARY KEY (`roomID`),
  KEY `RoomFK01` (`floorID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stair`
--

DROP TABLE IF EXISTS `stair`;
CREATE TABLE IF NOT EXISTS `stair` (
  `stairsID` int(6) NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `floorID` int(6) NOT NULL COMMENT 'foreign key',
  PRIMARY KEY (`stairsID`),
  KEY `StairsFK01` (`floorID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `array`
--
ALTER TABLE `array`
  ADD CONSTRAINT `array_ibfk_1` FOREIGN KEY (`pathID`) REFERENCES `path` (`pathID`);

--
-- Constraints for table `elevator`
--
ALTER TABLE `elevator`
  ADD CONSTRAINT `elevator_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);

--
-- Constraints for table `entrance`
--
ALTER TABLE `entrance`
  ADD CONSTRAINT `entrance_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);

--
-- Constraints for table `floor`
--
ALTER TABLE `floor`
  ADD CONSTRAINT `floorPK01` FOREIGN KEY (`buildingName`) REFERENCES `building` (`buildingName`);

--
-- Constraints for table `path`
--
ALTER TABLE `path`
  ADD CONSTRAINT `path_ibfk_1` FOREIGN KEY (`roomID`) REFERENCES `room` (`roomID`),
  ADD CONSTRAINT `path_ibfk_2` FOREIGN KEY (`stairID`) REFERENCES `stair` (`stairsID`),
  ADD CONSTRAINT `path_ibfk_3` FOREIGN KEY (`entranceID`) REFERENCES `entrance` (`entranceID`),
  ADD CONSTRAINT `path_ibfk_4` FOREIGN KEY (`elevatorID`) REFERENCES `elevator` (`elevatorID`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);

--
-- Constraints for table `stair`
--
ALTER TABLE `stair`
  ADD CONSTRAINT `stair_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
