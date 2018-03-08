-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 08, 2018 at 06:53 AM
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
  KEY `IndexbuildingName` (`buildingName`) USING BTREE,
  KEY `IndexbuildingNumberOfEntrances` (`buildingNumberOfEntrances`) USING BTREE,
  KEY `IndexbuildingNumberOfFloors` (`buildingNumberOfFloors`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23465 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `building`
--

INSERT INTO `building` (`builingID`, `buildingName`, `buildingNumberOfEntrances`, `buildingNumberOfFloors`) VALUES
(23463, 'Liongate', 2, 3),
(23464, 'Buckingham', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `elevator`
--

DROP TABLE IF EXISTS `elevator`;
CREATE TABLE IF NOT EXISTS `elevator` (
  `elevatorID` int(6) NOT NULL AUTO_INCREMENT,
  `nodeID` int(6) NOT NULL,
  `elevatorCapacity` int(6) NOT NULL,
  PRIMARY KEY (`elevatorID`),
  UNIQUE KEY `nodeID` (`nodeID`),
  KEY `IndexelevatorCapacity` (`elevatorCapacity`) USING BTREE,
  KEY `ElevatorFK01` (`nodeID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `elevator`
--

INSERT INTO `elevator` (`elevatorID`, `nodeID`, `elevatorCapacity`) VALUES
(3, 154, 5),
(4, 155, 5);

-- --------------------------------------------------------

--
-- Table structure for table `entrance`
--

DROP TABLE IF EXISTS `entrance`;
CREATE TABLE IF NOT EXISTS `entrance` (
  `entranceID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingID` int(6) NOT NULL,
  `nodeID` int(6) NOT NULL,
  `entranceDisabledAccess` tinyint(1) NOT NULL,
  PRIMARY KEY (`entranceID`),
  UNIQUE KEY `nodeID` (`nodeID`),
  KEY `EntranceFK01` (`buildingID`),
  KEY `EntranceFK02` (`nodeID`),
  KEY `IndexentranceDisabledAccess` (`entranceDisabledAccess`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entrance`
--

INSERT INTO `entrance` (`entranceID`, `buildingID`, `nodeID`, `entranceDisabledAccess`) VALUES
(1, 23463, 24, 1),
(2, 23463, 25, 0),
(3, 23464, 26, 1),
(4, 23464, 27, 1),
(5, 23464, 28, 1);

-- --------------------------------------------------------

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
CREATE TABLE IF NOT EXISTS `floor` (
  `floorID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingID` int(6) NOT NULL,
  `floorFloorNumber` int(6) NOT NULL,
  `floorNumberOfElevators` int(6) NOT NULL,
  `floorNumberOfStairs` int(6) NOT NULL,
  `floorNumberOfRooms` int(6) NOT NULL,
  PRIMARY KEY (`floorID`) USING BTREE,
  KEY `FloorFK01` (`buildingID`) USING BTREE,
  KEY `IndexfloorNumberOfElevators` (`floorNumberOfElevators`),
  KEY `IndexfloorNumberOfStairs` (`floorNumberOfStairs`),
  KEY `IndexfloorNumberOfRooms` (`floorNumberOfRooms`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `floor`
--

INSERT INTO `floor` (`floorID`, `buildingID`, `floorFloorNumber`, `floorNumberOfElevators`, `floorNumberOfStairs`, `floorNumberOfRooms`) VALUES
(15, 23463, 0, 1, 2, 10),
(16, 23463, 1, 1, 2, 10),
(17, 23463, 2, 1, 2, 10),
(18, 23464, 0, 1, 2, 10),
(19, 23464, 1, 1, 2, 10),
(20, 23464, 2, 1, 2, 10);

-- --------------------------------------------------------

--
-- Table structure for table `junction`
--

DROP TABLE IF EXISTS `junction`;
CREATE TABLE IF NOT EXISTS `junction` (
  `junctionID` int(11) NOT NULL AUTO_INCREMENT,
  `nodeID` int(11) NOT NULL,
  PRIMARY KEY (`junctionID`),
  UNIQUE KEY `nodeID` (`nodeID`),
  KEY `JuncionFK01` (`nodeID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `junction`
--

INSERT INTO `junction` (`junctionID`, `nodeID`) VALUES
(1, 124),
(2, 125),
(3, 126),
(4, 127),
(5, 128),
(6, 129),
(7, 130),
(8, 131),
(9, 132),
(10, 133),
(11, 134),
(12, 135),
(13, 136),
(14, 137),
(15, 138),
(16, 139),
(17, 140),
(18, 141),
(19, 142),
(20, 143),
(21, 144),
(22, 145),
(23, 146),
(24, 147),
(25, 148),
(26, 149),
(27, 150),
(28, 151),
(29, 152),
(30, 153);

-- --------------------------------------------------------

--
-- Table structure for table `logindetails`
--

DROP TABLE IF EXISTS `logindetails`;
CREATE TABLE IF NOT EXISTS `logindetails` (
  `loginEmail` varchar(100) NOT NULL,
  `loginUsername` varchar(100) NOT NULL,
  `loginPassword` varchar(100) NOT NULL,
  PRIMARY KEY (`loginEmail`) USING BTREE,
  KEY `IndexloginUsername` (`loginUsername`) USING BTREE,
  KEY `IndexloginPassword` (`loginPassword`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logindetails`
--

INSERT INTO `logindetails` (`loginEmail`, `loginUsername`, `loginPassword`) VALUES
('blah@blah', 'blah', 'blahblahblah'),
('test@test.com', 'test', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08');

-- --------------------------------------------------------

--
-- Table structure for table `nodes`
--

DROP TABLE IF EXISTS `nodes`;
CREATE TABLE IF NOT EXISTS `nodes` (
  `nodeID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `nodeYAxis` int(6) NOT NULL,
  `nodeXAxis` int(6) NOT NULL,
  `nodeNorthAdjacent` int(6) NOT NULL,
  `nodeEastAdjacent` int(6) NOT NULL,
  `nodeSouthAdjacent` int(6) NOT NULL,
  `nodeWestAdjacent` int(6) NOT NULL,
  PRIMARY KEY (`nodeID`),
  KEY `NodesFK01` (`floorID`),
  KEY `IndexnodeYAxis` (`nodeYAxis`),
  KEY `IndexnodeXAxis` (`nodeXAxis`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nodes`
--

INSERT INTO `nodes` (`nodeID`, `floorID`, `nodeYAxis`, `nodeXAxis`, `nodeNorthAdjacent`, `nodeEastAdjacent`, `nodeSouthAdjacent`, `nodeWestAdjacent`) VALUES
(24, 15, 5, 5, 1, 2, 3, 4),
(25, 15, 5, 5, 1, 2, 3, 4),
(26, 18, 5, 5, 1, 2, 3, 4),
(27, 18, 5, 5, 1, 2, 3, 4),
(28, 18, 5, 5, 1, 2, 3, 4),
(29, 15, 5, 5, 5, 5, 5, 5),
(30, 15, 5, 5, 5, 5, 5, 5),
(31, 18, 5, 5, 5, 5, 5, 5),
(32, 18, 5, 5, 5, 5, 5, 5),
(34, 15, 5, 5, 5, 5, 5, 5),
(35, 15, 5, 5, 5, 5, 5, 5),
(36, 15, 5, 5, 5, 5, 5, 5),
(37, 15, 5, 5, 5, 5, 5, 5),
(38, 15, 5, 5, 5, 5, 5, 5),
(39, 15, 5, 5, 5, 5, 5, 5),
(40, 15, 5, 5, 5, 5, 5, 5),
(41, 15, 5, 5, 5, 5, 5, 5),
(42, 15, 5, 5, 5, 5, 5, 5),
(43, 15, 5, 5, 5, 5, 5, 5),
(44, 16, 5, 5, 5, 5, 5, 5),
(45, 16, 5, 5, 5, 5, 5, 5),
(46, 16, 5, 5, 5, 5, 5, 5),
(47, 16, 5, 5, 5, 5, 5, 5),
(48, 16, 5, 5, 5, 5, 5, 5),
(49, 16, 5, 5, 5, 5, 5, 5),
(50, 16, 5, 5, 5, 5, 5, 5),
(51, 16, 5, 5, 5, 5, 5, 5),
(52, 16, 5, 5, 5, 5, 5, 5),
(53, 16, 5, 5, 5, 5, 5, 5),
(54, 17, 5, 5, 5, 5, 5, 5),
(55, 17, 5, 5, 5, 5, 5, 5),
(56, 17, 5, 5, 5, 5, 5, 5),
(57, 17, 5, 5, 5, 5, 5, 5),
(58, 17, 5, 5, 5, 5, 5, 5),
(59, 17, 5, 5, 5, 5, 5, 5),
(60, 17, 5, 5, 5, 5, 5, 5),
(61, 17, 5, 5, 5, 5, 5, 5),
(62, 17, 5, 5, 5, 5, 5, 5),
(63, 17, 5, 5, 5, 5, 5, 5),
(64, 18, 5, 5, 5, 5, 5, 5),
(65, 18, 5, 5, 5, 5, 5, 5),
(66, 18, 5, 5, 5, 5, 5, 5),
(67, 18, 5, 5, 5, 5, 5, 5),
(68, 18, 5, 5, 5, 5, 5, 5),
(69, 18, 5, 5, 5, 5, 5, 5),
(70, 18, 5, 5, 5, 5, 5, 5),
(71, 18, 5, 5, 5, 5, 5, 5),
(72, 18, 5, 5, 5, 5, 5, 5),
(73, 18, 5, 5, 5, 5, 5, 5),
(74, 19, 5, 5, 5, 5, 5, 5),
(75, 19, 5, 5, 5, 5, 5, 5),
(76, 19, 5, 5, 5, 5, 5, 5),
(77, 19, 5, 5, 5, 5, 5, 5),
(78, 19, 5, 5, 5, 5, 5, 5),
(79, 19, 5, 5, 5, 5, 5, 5),
(80, 19, 5, 5, 5, 5, 5, 5),
(81, 19, 5, 5, 5, 5, 5, 5),
(82, 19, 5, 5, 5, 5, 5, 5),
(83, 19, 5, 5, 5, 5, 5, 5),
(84, 20, 5, 5, 5, 5, 5, 5),
(85, 20, 5, 5, 5, 5, 5, 5),
(86, 20, 5, 5, 5, 5, 5, 5),
(87, 20, 5, 5, 5, 5, 5, 5),
(88, 20, 5, 5, 5, 5, 5, 5),
(89, 20, 5, 5, 5, 5, 5, 5),
(90, 20, 5, 5, 5, 5, 5, 5),
(91, 20, 5, 5, 5, 5, 5, 5),
(92, 20, 5, 5, 5, 5, 5, 5),
(93, 20, 5, 5, 5, 5, 5, 5),
(124, 20, 5, 5, 5, 5, 5, 5),
(125, 20, 5, 5, 5, 5, 5, 5),
(126, 20, 5, 5, 5, 5, 5, 5),
(127, 20, 5, 5, 5, 5, 5, 5),
(128, 20, 5, 5, 5, 5, 5, 5),
(129, 19, 5, 5, 5, 5, 5, 5),
(130, 19, 5, 5, 5, 5, 5, 5),
(131, 19, 5, 5, 5, 5, 5, 5),
(132, 19, 5, 5, 5, 5, 5, 5),
(133, 19, 5, 5, 5, 5, 5, 5),
(134, 18, 5, 5, 5, 5, 5, 5),
(135, 18, 5, 5, 5, 5, 5, 5),
(136, 18, 5, 5, 5, 5, 5, 5),
(137, 18, 5, 5, 5, 5, 5, 5),
(138, 18, 5, 5, 5, 5, 5, 5),
(139, 17, 5, 5, 5, 5, 5, 5),
(140, 17, 5, 5, 5, 5, 5, 5),
(141, 17, 5, 5, 5, 5, 5, 5),
(142, 17, 5, 5, 5, 5, 5, 5),
(143, 17, 5, 5, 5, 5, 5, 5),
(144, 16, 5, 5, 5, 5, 5, 5),
(145, 16, 5, 5, 5, 5, 5, 5),
(146, 16, 5, 5, 5, 5, 5, 5),
(147, 16, 5, 5, 5, 5, 5, 5),
(148, 16, 5, 5, 5, 5, 5, 5),
(149, 15, 5, 5, 5, 5, 5, 5),
(150, 15, 5, 5, 5, 5, 5, 5),
(151, 15, 5, 5, 5, 5, 5, 5),
(152, 15, 5, 5, 5, 5, 5, 5),
(153, 15, 5, 5, 5, 5, 5, 5),
(154, 15, 5, 5, 5, 5, 5, 5),
(155, 18, 5, 5, 5, 5, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `roomID` int(6) NOT NULL AUTO_INCREMENT,
  `nodeID` int(6) NOT NULL,
  `roomSize` int(6) NOT NULL,
  PRIMARY KEY (`roomID`),
  UNIQUE KEY `nodeID` (`nodeID`),
  KEY `NodesFK01` (`nodeID`),
  KEY `roomSize` (`roomSize`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`roomID`, `nodeID`, `roomSize`) VALUES
(1, 34, 5),
(2, 35, 5),
(3, 36, 5),
(4, 37, 5),
(5, 38, 5),
(6, 39, 5),
(7, 40, 5),
(8, 41, 5),
(9, 42, 5),
(10, 43, 5),
(11, 44, 5),
(12, 45, 5),
(13, 46, 5),
(14, 47, 5),
(15, 48, 5),
(16, 49, 5),
(17, 50, 5),
(18, 51, 5),
(19, 52, 5),
(20, 53, 5),
(21, 54, 5),
(22, 55, 5),
(23, 56, 5),
(24, 57, 5),
(25, 58, 5),
(26, 59, 5),
(27, 60, 5),
(28, 61, 5),
(29, 62, 5),
(30, 63, 5),
(31, 64, 5),
(32, 65, 5),
(33, 66, 5),
(34, 67, 5),
(35, 68, 5),
(36, 69, 5),
(37, 70, 5),
(38, 71, 5),
(39, 72, 5),
(40, 73, 5),
(41, 74, 5),
(42, 75, 5),
(43, 76, 5),
(44, 77, 5),
(45, 78, 5),
(46, 79, 5),
(47, 80, 5),
(48, 81, 5),
(49, 82, 5),
(50, 83, 5),
(51, 84, 5),
(52, 85, 5),
(53, 86, 5),
(54, 87, 5),
(55, 88, 5),
(56, 89, 5),
(57, 90, 5),
(58, 91, 5),
(59, 92, 5),
(60, 93, 5);

-- --------------------------------------------------------

--
-- Table structure for table `stairs`
--

DROP TABLE IF EXISTS `stairs`;
CREATE TABLE IF NOT EXISTS `stairs` (
  `stairsID` int(6) NOT NULL AUTO_INCREMENT,
  `nodeID` int(6) NOT NULL,
  PRIMARY KEY (`stairsID`) USING BTREE,
  UNIQUE KEY `nodeID` (`nodeID`),
  KEY `StairsFK01` (`nodeID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stairs`
--

INSERT INTO `stairs` (`stairsID`, `nodeID`) VALUES
(6, 29),
(7, 30),
(8, 31),
(9, 32);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `elevator`
--
ALTER TABLE `elevator`
  ADD CONSTRAINT `elevator_ibfk_1` FOREIGN KEY (`nodeID`) REFERENCES `nodes` (`nodeID`);

--
-- Constraints for table `entrance`
--
ALTER TABLE `entrance`
  ADD CONSTRAINT `entrance_ibfk_1` FOREIGN KEY (`nodeID`) REFERENCES `nodes` (`nodeID`),
  ADD CONSTRAINT `entrance_ibfk_2` FOREIGN KEY (`buildingID`) REFERENCES `building` (`builingID`);

--
-- Constraints for table `floor`
--
ALTER TABLE `floor`
  ADD CONSTRAINT `floor_ibfk_1` FOREIGN KEY (`buildingID`) REFERENCES `building` (`builingID`);

--
-- Constraints for table `junction`
--
ALTER TABLE `junction`
  ADD CONSTRAINT `junction_ibfk_1` FOREIGN KEY (`nodeID`) REFERENCES `nodes` (`nodeID`);

--
-- Constraints for table `nodes`
--
ALTER TABLE `nodes`
  ADD CONSTRAINT `nodes_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`nodeID`) REFERENCES `nodes` (`nodeID`);

--
-- Constraints for table `stairs`
--
ALTER TABLE `stairs`
  ADD CONSTRAINT `stairs_ibfk_1` FOREIGN KEY (`nodeID`) REFERENCES `nodes` (`nodeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
