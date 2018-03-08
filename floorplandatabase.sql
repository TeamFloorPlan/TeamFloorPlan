-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 08, 2018 at 05:04 AM
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
) ENGINE=InnoDB AUTO_INCREMENT=23463 DEFAULT CHARSET=latin1;

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
  KEY `IndexelevatorCapacity` (`elevatorCapacity`) USING BTREE,
  KEY `ElevatorFK01` (`nodeID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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
  KEY `EntranceFK01` (`buildingID`),
  KEY `EntranceFK02` (`nodeID`),
  KEY `IndexentranceDisabledAccess` (`entranceDisabledAccess`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `floorNumberOfRooms` int(6) NOT NULL,
  PRIMARY KEY (`floorID`) USING BTREE,
  KEY `FloorFK01` (`buildingID`) USING BTREE,
  KEY `IndexfloorNumberOfElevators` (`floorNumberOfElevators`),
  KEY `IndexfloorNumberOfStairs` (`floorNumberOfStairs`),
  KEY `IndexfloorNumberOfRooms` (`floorNumberOfRooms`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `junction`
--

DROP TABLE IF EXISTS `junction`;
CREATE TABLE IF NOT EXISTS `junction` (
  `junctionID` int(11) NOT NULL AUTO_INCREMENT,
  `nodeID` int(11) NOT NULL,
  PRIMARY KEY (`junctionID`),
  KEY `JuncionFK01` (`nodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

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
  KEY `NodesFK01` (`nodeID`),
  KEY `roomSize` (`roomSize`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stairs`
--

DROP TABLE IF EXISTS `stairs`;
CREATE TABLE IF NOT EXISTS `stairs` (
  `stairsID` int(6) NOT NULL AUTO_INCREMENT,
  `nodeID` int(6) NOT NULL,
  PRIMARY KEY (`stairsID`) USING BTREE,
  KEY `StairsFK01` (`nodeID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

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
