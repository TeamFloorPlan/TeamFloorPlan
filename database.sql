-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 14, 2018 at 03:36 PM
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
('Buckingham', 3, 2),
('Liongate', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `elevator`
--

DROP TABLE IF EXISTS `elevator`;
CREATE TABLE IF NOT EXISTS `elevator` (
  `elevatorID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `elevatorStartFloor` int(6) NOT NULL,
  `elevatorEndFloor` int(6) NOT NULL,
  PRIMARY KEY (`elevatorID`),
  KEY `elevatorFK01` (`floorID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `elevator`
--

INSERT INTO `elevator` (`elevatorID`, `floorID`, `elevatorStartFloor`, `elevatorEndFloor`) VALUES
(1, 2, 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `entrance`
--

DROP TABLE IF EXISTS `entrance`;
CREATE TABLE IF NOT EXISTS `entrance` (
  `entranceID` int(6) NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `floorID` int(6) NOT NULL COMMENT 'foreign key',
  `entranceDisabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`entranceID`),
  KEY `EntranceFK01` (`floorID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entrance`
--

INSERT INTO `entrance` (`entranceID`, `floorID`, `entranceDisabled`) VALUES
(1, 2, 1),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
CREATE TABLE IF NOT EXISTS `floor` (
  `floorID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingName` varchar(30) NOT NULL,
  `floorNumber` int(6) NOT NULL,
  PRIMARY KEY (`floorID`),
  KEY `buildingName` (`buildingName`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `floor`
--

INSERT INTO `floor` (`floorID`, `buildingName`, `floorNumber`) VALUES
(2, 'Liongate', 0),
(3, 'Liongate', 1),
(4, 'Liongate', 2),
(5, 'Buckingham', 0),
(6, 'Buckingham', 1),
(7, 'Buckingham', 2);

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
  `pathCoordinates` varchar(256) NOT NULL,
  PRIMARY KEY (`pathID`),
  KEY `stairID` (`stairID`),
  KEY `entranceID` (`entranceID`),
  KEY `pathFK01` (`roomID`,`entranceID`,`stairID`,`elevatorID`) USING BTREE,
  KEY `elevatorID` (`elevatorID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `path`
--

INSERT INTO `path` (`pathID`, `roomID`, `entranceID`, `stairID`, `elevatorID`, `pathCoordinates`) VALUES
(7, 3, 1, NULL, NULL, '285,130,285,120,320,120,320,150,375,150,375,180,340,180,340,295,360,295'),
(8, 3, 2, NULL, NULL, '250,270,250,295,360,295'),
(9, 2, 1, NULL, NULL, '285,130,285,82,210,82'),
(10, 2, 2, NULL, NULL, '250,270,250,295,340,295,340,180,375,180,375,150,320,150,320,120,285,120,285,82,210,82'),
(11, 1, 1, NULL, NULL, '285,130,285,82,200,82,200,120,100,120'),
(12, 1, 2, NULL, NULL, '250,270,250,295,340,295,340,180,375,180,375,150,320,150,320,120,285,120,285,82,200,82,200,120,100,120'),
(13, NULL, 1, 1, NULL, '285,130,285,60'),
(14, NULL, 1, 2, NULL, '250,320,250,295,340,295,340,180,375,180,375,150,320,150,320,120,285,120,285,130'),
(15, NULL, 1, NULL, 1, '285,130,285,82,255,82,255,65'),
(16, NULL, 2, 1, NULL, '250,270,250,295,340,295,340,180,375,180,375,150,320,150,320,120,285,120,285,60'),
(17, NULL, 2, 2, NULL, '250,270,250,320'),
(18, NULL, 2, NULL, 1, '250,270,250,295,340,295,340,180,375,180,375,150,320,150,320,120,285,120,285,82,255,82,255,65');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `roomID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `roomSize` int(6) NOT NULL,
  `roomName` varchar(10) NOT NULL,
  PRIMARY KEY (`roomID`),
  KEY `RoomFK01` (`floorID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`roomID`, `floorID`, `roomSize`, `roomName`) VALUES
(1, 2, 48, '0b14b'),
(2, 2, 24, '0.14a'),
(3, 2, 48, '0.07');

-- --------------------------------------------------------

--
-- Table structure for table `stair`
--

DROP TABLE IF EXISTS `stair`;
CREATE TABLE IF NOT EXISTS `stair` (
  `stairsID` int(6) NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `floorID` int(6) NOT NULL COMMENT 'foreign key',
  `stairStartFloor` int(6) NOT NULL,
  `stairEndFloor` int(6) NOT NULL,
  PRIMARY KEY (`stairsID`),
  KEY `StairsFK01` (`floorID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stair`
--

INSERT INTO `stair` (`stairsID`, `floorID`, `stairStartFloor`, `stairEndFloor`) VALUES
(1, 2, 0, 2),
(2, 2, 0, 2);

--
-- Constraints for dumped tables
--

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
