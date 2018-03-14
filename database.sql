-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 14, 2018 at 08:23 PM
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
-- Database: `database`
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
  `loginPassword` varchar(64) NOT NULL,
  `loginUsername` varchar(50) NOT NULL,
  `loginDisabled` tinyint(1) DEFAULT NULL,
  `loginColourBlind` tinyint(1) DEFAULT NULL,
  `loginNeedLageText` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`loginEmail`),
  UNIQUE KEY `loginUsername` (`loginUsername`),
  KEY `loginPassword` (`loginPassword`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=latin1;

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
(18, NULL, 2, NULL, 1, '250,270,250,295,340,295,340,180,375,180,375,150,320,150,320,120,285,120,285,82,255,82,255,65'),
(19, 4, NULL, 1, NULL, '125,60,163,60,163,76,236,76,236,72'),
(20, 4, NULL, NULL, 1, '125,60,163,60,163,76,236,76,236,72'),
(21, 5, NULL, 1, NULL, '125,60,163,60,163,76,193,76,193,82'),
(22, 5, NULL, NULL, 1, '125,60,163,60,163,76,193,76,193,82'),
(23, 6, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,210,133'),
(24, 6, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,210,133'),
(25, 7, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,210,133'),
(26, 7, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,210,133'),
(27, 8, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,192,210,192'),
(28, 8, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,192,210,192'),
(29, 9, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,220,210,220'),
(30, 9, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,220,210,220'),
(31, 10, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,248,210,248'),
(32, 10, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,248,210,248'),
(33, 11, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,278,210,278'),
(34, 11, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,278,210,278'),
(35, 12, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,302,218,302,218,311'),
(36, 12, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,302,218,302,218,311'),
(37, 13, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,302,232,302'),
(38, 13, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,302,232,302'),
(39, 14, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,303,256,303,256,327,315,327'),
(40, 14, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,303,256,303,256,327,315,327'),
(41, 15, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,254,259,254'),
(42, 15, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,254,259,254'),
(43, 16, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,279,243,279'),
(44, 16, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,279,243,279'),
(45, 17, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,160,243,160'),
(46, 17, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,160,243,160'),
(47, 19, NULL, 1, NULL, '125, 60, 163, 60, 163, 75, 280, 75, 280, 109, 309, 109'),
(48, 19, NULL, NULL, 1, '125, 60, 163, 60, 163, 75, 280, 75, 280, 109, 309, 109'),
(49, 20, NULL, 1, NULL, '125, 60, 163, 60, 163, 75, 303, 75, 303, 83, 308, 83'),
(50, 20, NULL, NULL, 1, '125, 60, 163, 60, 163, 75, 303, 75, 303, 83, 308, 83'),
(51, 21, NULL, 1, NULL, '125, 60, 163, 60, 163, 75, 309, 75'),
(52, 21, NULL, NULL, 1, '125, 60, 163, 60, 163, 75, 309, 75'),
(53, 22, NULL, 1, NULL, '125,60,163,60,163,76,225,76,225,133,225,250,254,250,254,220,268,220'),
(54, 22, NULL, NULL, 1, '125,60,163,60,163,76,225,76,225,133,225,250,254,250,254,220,268,220'),
(55, 4, NULL, 2, NULL, '125, 303, 225, 303, 225, 80, 236, 80,236,70'),
(56, 5, NULL, 2, NULL, '125, 303, 225, 303, 225, 77,195,77,195,82'),
(57, 6, NULL, 2, NULL, '125, 303, 225, 303, 225, 133,212,133'),
(58, 7, NULL, 2, NULL, '125, 303, 225, 303, 225, 163,212,163'),
(59, 8, NULL, 2, NULL, '125, 303, 225, 303, 225, 192,211,192'),
(60, 9, NULL, 2, NULL, '125, 303, 225, 303, 225, 218,212,218'),
(61, 10, NULL, 2, NULL, '25, 303, 225, 303, 225, 248,212,248'),
(62, 11, NULL, 2, NULL, '125, 303, 225, 303, 225, 278,212,278'),
(63, 12, NULL, 2, NULL, '125, 303, 218, 303, 218, 310'),
(64, 13, NULL, 2, NULL, '125, 303, 234, 303'),
(65, 14, NULL, 2, NULL, '125, 300, 300, 300, 300, 325, 315, 325'),
(66, 15, NULL, 2, NULL, '125, 303, 225, 303, 225, 254, 259, 254'),
(67, 16, NULL, 2, NULL, '125, 303, 225, 303, 225, 279, 244, 279'),
(68, 17, NULL, 2, NULL, '125, 303, 225, 303, 225, 160, 242, 160'),
(69, 19, NULL, 2, NULL, '125, 303, 225, 303, 225, 80, 300, 80, 300, 109, 308, 109'),
(70, 20, NULL, 2, NULL, '125, 303, 225, 303, 225, 80, 309, 80'),
(71, 21, NULL, 2, NULL, '125, 303, 225, 303, 225, 80, 300, 80, 300, 74, 308, 74'),
(72, 22, NULL, 2, NULL, '125, 303, 225, 303, 225, 250, 254, 250, 254, 220, 268, 220'),
(109, 23, NULL, 1, NULL, '120,58,221,58,221,131,203,131'),
(110, 23, NULL, NULL, 1, '120,58,221,58,221,131,203,131'),
(111, 24, NULL, 1, NULL, '120,58,221,58,221,170,203,170'),
(112, 24, NULL, NULL, 1, '120,58,221,58,221,170,203,170'),
(113, 25, NULL, 1, NULL, '120,58,221,58,221,227,205,227'),
(114, 25, NULL, NULL, 1, '120,58,221,58,221,227,205,227'),
(115, 26, NULL, 1, NULL, '120,58,229,58,229,49'),
(116, 26, NULL, NULL, 1, '120,58,229,58,229,49'),
(117, 27, NULL, 1, NULL, '120,58,221,58,221,82,237,82'),
(118, 27, NULL, NULL, 1, '120,58,221,58,221,82,237,82'),
(119, 28, NULL, 1, NULL, '120,58,221,58,221,131,238,131'),
(120, 28, NULL, NULL, 1, '120,58,221,58,221,131,238,131'),
(121, 29, NULL, 1, NULL, '120,58,221,58,221,219,238,219'),
(122, 29, NULL, NULL, 1, '120,58,221,58,221,219,238,219'),
(123, 30, NULL, 1, NULL, '120,58,221,58,221,300,237,300'),
(124, 30, NULL, NULL, 1, '120,58,221,58,221,300,237,300'),
(125, 31, NULL, 1, NULL, '120,58,221,58,221,237,237,237'),
(126, 31, NULL, NULL, 1, '120,58,221,58,221,237,237,237'),
(127, 23, NULL, 2, NULL, '123,300, 217,300, 217, 228, 205, 228'),
(128, 24, NULL, 2, NULL, '123,300, 217,300, 217, 170, 205, 170'),
(129, 25, NULL, 2, NULL, '123,300, 217,300, 217, 131, 205, 131'),
(130, 26, NULL, 2, NULL, '123,300, 217,300, 217, 82, 230, 82, 230, 50'),
(131, 27, NULL, 2, NULL, '123, 300, 217, 300, 217, 82, 237, 82'),
(132, 28, NULL, 2, NULL, '123, 300, 217, 300, 217, 131, 237, 131'),
(133, 29, NULL, 2, NULL, '123, 300, 217, 300, 217, 222, 237, 222'),
(134, 30, NULL, 2, NULL, '123, 300, 236, 300'),
(135, 31, NULL, 2, NULL, '123, 300, 217, 300, 217, 237, 237, 237');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `roomID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `roomName` varchar(10) NOT NULL,
  PRIMARY KEY (`roomID`),
  KEY `RoomFK01` (`floorID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`roomID`, `floorID`, `roomName`) VALUES
(1, 2, '0b14b'),
(2, 2, '0.14a'),
(3, 2, '0.07'),
(4, 3, '1.39'),
(5, 3, '1.43a'),
(6, 3, '1.43b'),
(7, 3, '1.44'),
(8, 3, '1.45'),
(9, 3, '1.46'),
(10, 3, '1.47'),
(11, 3, '1.48'),
(12, 3, '1.07'),
(13, 3, '1.08'),
(14, 3, '1.09'),
(15, 3, '1.10'),
(16, 3, '1.12'),
(17, 3, '1.25'),
(19, 3, '1.34'),
(20, 3, '1.33'),
(21, 3, '1.36'),
(22, 3, '1.22'),
(23, 4, '2.01'),
(24, 4, '2.02'),
(25, 4, '2.03'),
(26, 4, '2.04'),
(27, 4, '2.04a'),
(28, 4, '2.04b'),
(29, 4, '2.04c'),
(30, 4, '2.05'),
(31, 4, '2.06');

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
