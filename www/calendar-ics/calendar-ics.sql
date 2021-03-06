-- phpMyAdmin SQL Dump
-- version 3.5.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 20, 2014 at 12:57 PM
-- Server version: 5.5.37-0ubuntu0.12.04.1
-- PHP Version: 5.3.10-1ubuntu3.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `calendar-ics`
--
CREATE DATABASE `calendar-ics` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `calendar-ics`;

-- --------------------------------------------------------

--
-- Table structure for table `calendars`
--
-- Creation: Apr 24, 2014 at 10:40 AM
--

CREATE TABLE IF NOT EXISTS `calendars` (
  `id` varchar(32) NOT NULL DEFAULT '' COMMENT 'hash of ICS and Canvas pairing, generated by getPairingHash()',
  `name` text NOT NULL,
  `ics_url` text NOT NULL COMMENT 'URL of ICS feed',
  `canvas_url` text NOT NULL COMMENT 'canonical URL for Canvas object',
  `enable_regexp_filter` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'enable regular expression filtering',
  `include_regexp` text COMMENT 'regular expression that matches all event titles that will be included in sync',
  `exclude_regexp` text COMMENT 'regular expression that matches all event titles that will be excluded from sync (applied after include regexp)',
  `synced` varchar(64) DEFAULT NULL COMMENT 'sync identification, generated by getSyncTimestamp()',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'timestamp of last modificiation of the record',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--
-- Creation: Apr 24, 2014 at 10:40 AM
--

CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto-incremented cache record id',
  `calendar` varchar(32) NOT NULL DEFAULT '' COMMENT 'pair hash for cached calendar, generated by getPairingHash()',
  `calendar_event[id]` int(11) NOT NULL COMMENT 'Canvas ID of calendar event',
  `event_hash` varchar(32) NOT NULL DEFAULT '' COMMENT 'hash of cached event data from previous sync',
  `synced` varchar(64) DEFAULT NULL COMMENT 'sync identification, generated by getSyncTimestamp()',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'timestamp of last modification of the record',
  PRIMARY KEY (`id`),
  KEY `event_hash` (`event_hash`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=140453 ;

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--
-- Creation: Apr 24, 2014 at 10:40 AM
--

CREATE TABLE IF NOT EXISTS `schedules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'auto-incremented cache record id',
  `calendar` varchar(32) NOT NULL DEFAULT '' COMMENT 'pair hash for cached calendar, generated by getPairingHash()',
  `schedule` text NOT NULL COMMENT 'crontab data for scheduled synchronization',
  `synced` varchar(64) DEFAULT NULL COMMENT 'sync identification, generated by getSyncTimestamp()',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'timestamp of last modification of the record',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=39 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
