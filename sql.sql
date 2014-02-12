-- --------------------------------------------------------
-- Host:                         10.0.0.2
-- Server version:               5.5.30-1.1 - (Debian)
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             8.0.0.4527
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for reputation
CREATE DATABASE IF NOT EXISTS `reputation` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `reputation`;


-- Dumping structure for table reputation.actions
CREATE TABLE IF NOT EXISTS `actions` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ActionType` int(11) unsigned NOT NULL DEFAULT '0',
  `Name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`),
  KEY `Action Category` (`ActionType`),
  CONSTRAINT `Action?Category` FOREIGN KEY (`ActionType`) REFERENCES `actionTypes` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table reputation.actions: ~15 rows (approximately)
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` (`ID`, `ActionType`, `Name`) VALUES
	(1, 1, 'Listen'),
	(2, 1, 'Read'),
	(3, 1, 'Watch'),
	(4, 2, 'Tag'),
	(5, 3, 'Write'),
	(6, 3, 'Draw'),
	(7, 3, 'Record Audio'),
	(8, 3, 'Record Video'),
	(9, 4, 'Rate'),
	(10, 4, 'Comment'),
	(11, 4, 'Review'),
	(12, 5, 'Gift'),
	(13, 5, 'Assign'),
	(14, 5, 'Broadcast'),
	(15, 5, 'Private Share');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;


-- Dumping structure for table reputation.actionTypes
CREATE TABLE IF NOT EXISTS `actionTypes` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table reputation.actionTypes: ~7 rows (approximately)
/*!40000 ALTER TABLE `actionTypes` DISABLE KEYS */;
INSERT INTO `actionTypes` (`ID`, `Name`) VALUES
	(1, 'Collect'),
	(2, 'Relate'),
	(3, 'Create - Generative'),
	(4, 'Create - Evaluative'),
	(5, 'Donate'),
	(6, 'Reflect'),
	(7, 'Observe');
/*!40000 ALTER TABLE `actionTypes` ENABLE KEYS */;


-- Dumping structure for table reputation.activities
CREATE TABLE IF NOT EXISTS `activities` (
  `Key` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `User` int(11) unsigned NOT NULL,
  `Action` int(11) unsigned NOT NULL,
  `Skill` int(11) unsigned NOT NULL,
  `Reference` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Key`),
  KEY `Actions` (`Action`),
  KEY `User` (`User`),
  KEY `Tags` (`Skill`),
  CONSTRAINT `Skills to activities` FOREIGN KEY (`Skill`) REFERENCES `skills` (`ID`),
  CONSTRAINT `Actions to activities` FOREIGN KEY (`Action`) REFERENCES `actions` (`ID`),
  CONSTRAINT `Users to activities` FOREIGN KEY (`User`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table reputation.activities: ~11 rows (approximately)
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` (`Key`, `User`, `Action`, `Skill`, `Reference`, `Date`) VALUES
	(1, 1, 8, 1, 'p1', '2014-02-04 11:16:52'),
	(2, 1, 5, 1, 'p2', '2014-02-04 11:17:35'),
	(3, 1, 9, 3, 'p3', '2012-02-07 14:56:04'),
	(4, 1, 4, 5, 'p4', '2014-02-07 15:35:23'),
	(5, 1, 5, 5, 'p5', '2014-02-10 11:12:00'),
	(6, 1, 6, 5, 'p6', '2014-02-10 11:12:07'),
	(7, 1, 7, 5, 'p7', '2014-02-10 11:33:52'),
	(8, 2, 9, 5, 'p1', '2014-02-10 11:33:52'),
	(9, 3, 9, 5, 'p1', '2014-02-10 11:33:52'),
	(10, 3, 9, 5, 'p7', '2014-02-10 11:33:52'),
	(11, 3, 9, 5, 'p9', '2014-02-10 11:33:52');
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;


-- Dumping structure for table reputation.GoalTings
CREATE TABLE IF NOT EXISTS `GoalTings` (
  `Key` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Thing` int(10) unsigned NOT NULL COMMENT 'The thing they did',
  `QuestID` int(10) unsigned NOT NULL,
  `Reference` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Stuff what happens to goals init';

-- Dumping data for table reputation.GoalTings: ~0 rows (approximately)
/*!40000 ALTER TABLE `GoalTings` DISABLE KEYS */;
/*!40000 ALTER TABLE `GoalTings` ENABLE KEYS */;


-- Dumping structure for table reputation.skills
CREATE TABLE IF NOT EXISTS `skills` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table reputation.skills: ~5 rows (approximately)
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` (`ID`, `Name`) VALUES
	(1, 'Database'),
	(4, 'Design'),
	(2, 'Elastic Cloud Computing'),
	(5, 'node.js'),
	(3, 'UX');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;


-- Dumping structure for table reputation.users
CREATE TABLE IF NOT EXISTS `users` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UUID` char(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table reputation.users: ~3 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`ID`, `UUID`) VALUES
	(2, '1C5D2E42-5C13-458B-AA5C-50A85B471F9'),
	(3, '31F2E6D0-A822-4B80-BDA6-9FFD4F09CED5'),
	(1, '4FA06769-C5C7-432B-9E37-4A3E7B4D294D');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


-- Dumping structure for table reputation.userSkills
CREATE TABLE IF NOT EXISTS `userSkills` (
  `Key` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `User` int(10) unsigned NOT NULL,
  `Skill` int(10) unsigned NOT NULL,
  `Action` int(10) unsigned NOT NULL,
  `Time` int(10) unsigned NOT NULL DEFAULT '0',
  `Count` int(10) unsigned NOT NULL DEFAULT '0',
  `Rating` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Key`),
  UNIQUE KEY `Combined index` (`User`,`Skill`,`Action`),
  KEY ` Skills to userSkills` (`Skill`),
  KEY `Actions to userSkills` (`Action`),
  CONSTRAINT ` Skills to userSkills` FOREIGN KEY (`Skill`) REFERENCES `skills` (`ID`),
  CONSTRAINT `Actions to userSkills` FOREIGN KEY (`Action`) REFERENCES `actions` (`ID`),
  CONSTRAINT `Users to userSkills` FOREIGN KEY (`User`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table reputation.userSkills: ~9 rows (approximately)
/*!40000 ALTER TABLE `userSkills` DISABLE KEYS */;
INSERT INTO `userSkills` (`Key`, `User`, `Skill`, `Action`, `Time`, `Count`, `Rating`) VALUES
	(1, 1, 1, 8, 0, 1, 2),
	(2, 1, 1, 5, 0, 1, 0),
	(3, 1, 3, 9, 0, 1, 0),
	(4, 1, 5, 4, 0, 1, 0),
	(5, 1, 5, 5, 0, 1, 0),
	(6, 1, 5, 6, 0, 1, 0),
	(7, 1, 5, 7, 0, 1, 1),
	(8, 2, 5, 9, 0, 1, 0),
	(9, 3, 5, 9, 0, 3, 0);
/*!40000 ALTER TABLE `userSkills` ENABLE KEYS */;


-- Dumping structure for trigger reputation.activity_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `activity_insert` AFTER INSERT ON `activities` FOR EACH ROW BEGIN
		INSERT INTO userSkills (User, Skill, Action, Count) VALUES (NEW.User, NEW.Skill, NEW.Action, 1) ON DUPLICATE KEY UPDATE Count = Count + 1;
		
		UPDATE userSkills, (SELECT User, Action, Skill FROM activities WHERE Reference = NEW.Reference AND User != NEW.User AND Action IN (SELECT ID FROM actions WHERE actions.ActionType = 3) LIMIT 1) as referencedRow SET Rating = Rating + 1 WHERE userSkills.User = referencedRow.User AND userSkills.Skill = referencedRow.Skill AND userSkills.Action = referencedRow.Action;

	END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
