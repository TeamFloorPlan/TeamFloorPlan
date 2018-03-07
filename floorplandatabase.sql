-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 07, 2018 at 11:36 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=23464 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `building`
--

INSERT INTO `building` (`builingID`, `buildingName`, `buildingNumberOfEntrances`, `buildingNumberOfFloors`) VALUES
(23461, 'Liongate', 2, 3),
(23462, 'Buckingham', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `elevator`
--

DROP TABLE IF EXISTS `elevator`;
CREATE TABLE IF NOT EXISTS `elevator` (
  `elevatorID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `elevatorCapacity` int(6) NOT NULL,
  `elevatorYAxis` int(6) NOT NULL,
  `elevatorXAxis` int(6) NOT NULL,
  PRIMARY KEY (`elevatorID`),
  KEY `ElevatorFK01` (`floorID`) USING BTREE,
  KEY `IndexelevatorCapacity` (`elevatorCapacity`) USING BTREE,
  KEY `IndexelevatorXAxis` (`elevatorXAxis`) USING BTREE,
  KEY `IndexelevatorYAxis` (`elevatorYAxis`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `elevator`
--

INSERT INTO `elevator` (`elevatorID`, `floorID`, `elevatorCapacity`, `elevatorYAxis`, `elevatorXAxis`) VALUES
(1, 3, 70, 56, 78),
(2, 12, 30, 23, 12);

-- --------------------------------------------------------

--
-- Table structure for table `entrances`
--

DROP TABLE IF EXISTS `entrances`;
CREATE TABLE IF NOT EXISTS `entrances` (
  `entranceID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingID` int(6) NOT NULL,
  `entranceYAxis` int(6) NOT NULL,
  `entranceXAxis` int(6) NOT NULL,
  `entranceDisabledAccess` tinyint(1) NOT NULL,
  PRIMARY KEY (`entranceID`),
  KEY `EntranceFK01` (`buildingID`) USING BTREE,
  KEY `IndexentranceDisabledAccess` (`entranceDisabledAccess`) USING BTREE,
  KEY `IndexentranceYAxis` (`entranceYAxis`) USING BTREE,
  KEY `IndexentranceXAxis` (`entranceXAxis`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entrances`
--

INSERT INTO `entrances` (`entranceID`, `buildingID`, `entranceYAxis`, `entranceXAxis`, `entranceDisabledAccess`) VALUES
(17, 23461, 51, -1, 1),
(29, 23462, 78, 12, 1),
(32, 23462, 12, 98, 1),
(33, 23462, 66, 51, 0),
(35, 23461, 39, 65, 1);

-- --------------------------------------------------------

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
CREATE TABLE IF NOT EXISTS `floor` (
  `floorID` int(6) NOT NULL AUTO_INCREMENT,
  `buildingID` int(6) NOT NULL,
  `floorNumberOfElevators` int(6) NOT NULL,
  `floorNumberOfStairs` int(6) NOT NULL,
  `floorNumberOfNodes` int(6) NOT NULL,
  `floorfloorNumberOfRooms` int(6) NOT NULL,
  PRIMARY KEY (`floorID`) USING BTREE,
  KEY `FloorFK01` (`buildingID`) USING BTREE,
  KEY `IndexfloorNumberOfElevators` (`floorNumberOfElevators`),
  KEY `IndexfloorNumberOfStairs` (`floorNumberOfStairs`),
  KEY `IndexfloorNumberOfNodes` (`floorNumberOfNodes`),
  KEY `IndexfloorNumberOfRooms` (`floorfloorNumberOfRooms`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `floor`
--

INSERT INTO `floor` (`floorID`, `buildingID`, `floorNumberOfElevators`, `floorNumberOfStairs`, `floorNumberOfNodes`, `floorfloorNumberOfRooms`) VALUES
(3, 23461, 1, 2, 20, 15),
(4, 23461, 1, 2, 8, 6),
(5, 23461, 1, 2, 12, 12),
(12, 23462, 1, 1, 5, 7),
(13, 23462, 0, 1, 10, 8),
(14, 23462, 0, 1, 2, 5);

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
  PRIMARY KEY (`nodeID`),
  KEY `NodesFK01` (`floorID`),
  KEY `IndexnodeYAxis` (`nodeYAxis`),
  KEY `IndexnodeXAxis` (`nodeXAxis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
CREATE TABLE IF NOT EXISTS `room` (
  `roomID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `roomYAxis` int(6) NOT NULL,
  `roomXAxis` int(6) NOT NULL,
  `roomSize` int(6) NOT NULL,
  PRIMARY KEY (`roomID`),
  KEY `RoomFK01` (`floorID`) USING BTREE,
  KEY `IndexroomSize` (`roomSize`) USING BTREE,
  KEY `IndexroomXAxis` (`roomXAxis`) USING BTREE,
  KEY `IndexroomYAxis` (`roomYAxis`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stairs`
--

DROP TABLE IF EXISTS `stairs`;
CREATE TABLE IF NOT EXISTS `stairs` (
  `stairsID` int(6) NOT NULL AUTO_INCREMENT,
  `floorID` int(6) NOT NULL,
  `stairsYAxis` int(6) NOT NULL,
  `stairsXAxis` int(6) NOT NULL,
  PRIMARY KEY (`stairsID`) USING BTREE,
  KEY `StairsFK01` (`floorID`) USING BTREE,
  KEY `IndexstairsYAxis` (`stairsYAxis`) USING BTREE,
  KEY `IndexstairsXAxis` (`stairsXAxis`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stairs`
--

INSERT INTO `stairs` (`stairsID`, `floorID`, `stairsYAxis`, `stairsXAxis`) VALUES
(1, 3, 60, 60),
(2, 12, 143, 1),
(5, 3, 256, 265);

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
-- Constraints for table `nodes`
--
ALTER TABLE `nodes`
  ADD CONSTRAINT `nodes_ibfk_1` FOREIGN KEY (`floorID`) REFERENCES `floor` (`floorID`);

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
