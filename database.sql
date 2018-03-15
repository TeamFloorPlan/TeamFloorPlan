-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 15, 2018 at 02:07 PM
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
('Liongate', 2, 2),
('Portland', 3, 4);

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `floor`
--

INSERT INTO `floor` (`floorID`, `buildingName`, `floorNumber`) VALUES
(2, 'Liongate', 0),
(3, 'Liongate', 1),
(4, 'Liongate', 2),
(8, 'Portland', 0),
(9, 'Portland', 1),
(10, 'Portland', 2),
(11, 'Portland', 3);

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
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `path`
--

INSERT INTO `path` (`pathID`, `roomID`, `entranceID`, `stairID`, `elevatorID`, `pathCoordinates`) VALUES
(136, NULL, 1, 1, NULL, '374, 207, 374, 130, 400, 130, 400, 118'),
(137, NULL, 1, 2, NULL, '374, 207, 374, 130, 450, 130, 450, 235, 520, 235, 520, 300, 475, 300, 475, 482, 360, 482, 360, 494'),
(138, NULL, 1, NULL, 1, '374, 207, 374, 130, 355, 130, 355, 118'),
(139, 3, 1, NULL, NULL, '374, 207, 374, 130, 450, 130, 450, 235, 520, 235, 520, 300, 475, 300, 475, 482, 500, 482'),
(140, 2, 1, NULL, NULL, '374, 207, 374, 130, 295, 130'),
(141, 1, 1, NULL, NULL, '374, 207, 374, 130, 295, 130, 200, 130, 200, 185, 150, 185'),
(142, NULL, 2, 1, NULL, '360, 440, 360, 482, 475, 482, 475, 300, 520, 300, 520, 235, 450, 235, 450, 130, 400, 130, 400, 118'),
(143, NULL, 2, 2, NULL, '374, 207, 374, 130, 450, 130, 450, 235, 520, 235, 520, 300, 475, 300, 475, 482, 360, 482, 360, 494'),
(144, NULL, 2, NULL, 1, '360, 440, 360, 482, 475, 482, 475, 300, 520, 300, 520, 235, 450, 235, 450, 130, 355, 130, 355, 118'),
(145, 3, 2, NULL, NULL, '360, 440, 360, 482, 500, 482'),
(146, 2, 2, NULL, NULL, '360, 440, 360, 482, 475, 482, 475, 300, 520, 300, 520, 235, 450, 235, 450, 130, 295, 130 '),
(147, 1, 2, NULL, NULL, '360, 440, 360, 482, 475, 482, 475, 300, 520, 300, 520, 235, 450, 235, 450, 130, 295, 130'),
(150, NULL, NULL, 1, 1, '179, 75, 179, 96, 152, 96'),
(151, 12, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 486, 306, 486, 306, 500'),
(152, 13, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 486, 326, 486'),
(153, 14, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 486, 426, 486, 426, 526, 441, 526'),
(154, 15, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 407, 364, 407'),
(155, 16, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 447, 341, 447'),
(156, 22, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 407, 354, 407, 354, 347, 376, 347'),
(157, 17, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 256, 340, 256'),
(158, 20, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 429, 123, 429, 134, 433, 134'),
(159, 19, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 429, 123, 429, 174, 433, 174'),
(160, 21, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 429, 123, 429, 119, 433, 119'),
(161, 4, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 329, 123, 329, 113'),
(162, 5, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 272, 123, 272, 132'),
(163, 6, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 213, 295, 213'),
(164, 7, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 262, 295, 262'),
(165, 8, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 309, 295, 309'),
(166, 9, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 352, 295, 352'),
(167, 10, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 400, 295, 400'),
(168, 11, NULL, 1, NULL, '179, 75, 179, 96, 226, 96, 226, 123, 319, 123, 319, 447, 295, 447'),
(169, NULL, NULL, 2, 1, '180, 494, 180, 486, 319, 486, 319, 123, 226, 123, 226, 96, 179, 96, 152, 96'),
(170, 13, NULL, 2, NULL, '180, 494, 180, 486, 326, 486'),
(171, 14, NULL, 2, NULL, '180, 494, 180, 486, 426, 486, 426, 526, 441, 526'),
(172, 15, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 407, 364, 407'),
(173, 16, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 447, 341, 447'),
(174, 22, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 407, 354, 407, 354, 347, 376, 347'),
(175, 17, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 256, 340, 256'),
(176, 20, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 196, 429, 196, 429, 134, 433, 134'),
(177, 19, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 196, 429, 196, 429, 174, 433, 174'),
(178, 21, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 196, 429, 196, 429, 119, 433, 119'),
(179, 4, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 123, 329, 123, 329, 113'),
(180, 5, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 123, 272, 123, 272, 132'),
(181, 6, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 213, 295, 213'),
(182, 7, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 262, 295, 262'),
(183, 8, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 309, 295, 309'),
(184, 9, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 352, 295, 352'),
(185, 10, NULL, NULL, NULL, '180, 494, 180, 486, 319, 486, 319, 400, 295, 400'),
(186, 11, NULL, 2, NULL, '180, 494, 180, 486, 319, 486, 319, 447, 295, 447'),
(187, 12, NULL, 2, NULL, '180, 494, 180, 486, 306, 486, 306, 500'),
(229, NULL, NULL, 1, 1, '152, 96, 179, 96, 179, 75'),
(230, NULL, NULL, 2, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 486, 180, 486, 180, 494'),
(231, 12, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 486, 306, 486, 306, 500'),
(232, 13, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 486, 326, 486'),
(233, 14, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 486, 426, 486, 426, 526, 441, 526'),
(234, 15, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 407, 364, 407'),
(235, 16, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 446, 341, 446'),
(236, 22, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 407, 354, 407, 354, 347, 376, 347'),
(237, 17, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 256, 340, 256'),
(238, 20, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 429, 123, 429, 134, 433, 134'),
(239, 19, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 429, 123, 429, 174, 433, 174'),
(240, 21, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 429, 123, 429, 119, 433, 119'),
(241, 4, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 329, 123, 329, 113'),
(242, 5, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 272, 123, 272, 132'),
(243, 6, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 213, 295, 213'),
(244, 7, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 262, 295, 262'),
(245, 8, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 309, 295, 309'),
(246, 9, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 352, 295, 352'),
(247, 10, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 400, 295, 400'),
(248, 11, NULL, NULL, 1, '152, 96, 226, 96, 226, 123, 319, 123, 319, 447, 295, 447'),
(249, NULL, NULL, 1, 1, '172, 74, 172, 93, 145, 93'),
(250, 23, NULL, 1, NULL, '172, 74, 172, 93, 309, 93, 309, 93, 309, 211, 287, 211'),
(251, 24, NULL, 1, NULL, '172, 74, 172, 93, 309, 93, 309, 274, 287, 274'),
(252, 25, NULL, 1, NULL, '172, 74, 172, 93, 309, 93, 309, 367, 287, 367'),
(253, 26, NULL, 1, NULL, '172, 74, 172, 93, 321, 93, 321, 79'),
(254, 27, NULL, 1, NULL, '172, 74, 172, 93, 309, 93, 309, 133, 333, 133'),
(255, 28, NULL, 1, NULL, '172, 74, 172, 93, 309, 93, 309, 236, 333, 236'),
(256, 29, NULL, 1, NULL, '172, 74, 172, 93, 309, 93, 309, 351, 333, 351'),
(257, 30, NULL, 1, NULL, '172, 74, 172, 93, 309, 93, 309, 483, 333, 483'),
(258, 31, NULL, 1, NULL, '172, 74, 172, 93, 309, 93, 309, 381, 333, 381 '),
(259, NULL, NULL, 2, 1, '172, 494, 172, 483, 309, 483, 309, 93, 145, 93'),
(260, 23, NULL, 2, NULL, '172, 494, 172, 483, 309, 483, 309, 211, 287, 211'),
(261, 24, NULL, 2, NULL, '172, 494, 172, 483, 309, 483, 309, 274, 287, 274'),
(262, 25, NULL, 2, NULL, '172, 494, 172, 483, 309, 483, 309, 367, 287, 367'),
(263, 26, NULL, 2, NULL, '172, 494, 172, 483, 309, 483, 309, 93, 321, 93, 321, 79'),
(264, 27, NULL, 2, NULL, '172, 494, 172, 483, 309, 483, 309, 133, 333, 133'),
(265, 28, NULL, 2, NULL, '172, 494, 172, 483, 309, 483, 309, 236, 333, 236'),
(266, 29, NULL, 2, NULL, '72, 494, 172, 483, 309, 483, 309, 351, 333, 351'),
(267, 30, NULL, 2, NULL, '172, 494, 172, 483, 333, 483'),
(268, 31, NULL, 2, NULL, '172, 494, 172, 483, 309, 483, 309, 381, 333, 381'),
(269, NULL, NULL, 1, 1, '145, 93, 309, 93, 309, 483, 172, 483, 172, 494'),
(270, NULL, NULL, 2, 1, '145, 93, 309, 93, 309, 483, 333, 483'),
(271, 23, NULL, NULL, 1, '145, 93, 309, 93, 309, 211, 287, 211'),
(272, 24, NULL, NULL, 1, '145, 93, 309, 93, 309, 274, 287, 274'),
(273, 25, NULL, NULL, 1, '145, 93, 309, 93, 309, 367, 287, 367'),
(274, 26, NULL, NULL, 1, '145, 93, 321, 93, 321, 79'),
(275, 27, NULL, NULL, 1, '145, 93, 309, 93, 309, 133, 333, 133'),
(276, 28, NULL, NULL, 1, '145, 93, 309, 93, 309, 236, 333, 236'),
(277, 29, NULL, NULL, 1, '145, 93, 309, 93, 309, 351, 333, 351'),
(278, 30, NULL, NULL, 1, '145, 93, 309, 93, 309, 483, 333, 483'),
(279, 31, NULL, NULL, 1, '145, 93, 309, 93, 309, 381, 333, 381');

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`roomID`, `floorID`, `roomName`) VALUES
(1, 2, '0.14b'),
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
