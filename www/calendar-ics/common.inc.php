<?php

/* order of shell arguments for sync */
define('INDEX_COMMAND', 0);
define('INDEX_SCHEDULE', 1);
define('INDEX_WEB_PATH', 2);

/* argument values for sync */
define('SCHEDULE_ONCE', 'once');
define('SCHEDULE_WEEKLY', 'weekly');
define('SCHEDULE_DAILY', 'daily');
define('SCHEDULE_HOURLY', 'hourly');
define('SCHEDULE_CUSTOM', 'custom');

/* cache database tables */

/* calendars
	id				hash of ICS and Canvas pairing, generated by getPairingHash()
	ics_url			URL of ICS feed
	canvas_url		canonical URL for Canvas object
	synced			sync identification, generated by getSyncTimestamp()
	modified		timestamp of last modificiation of the record
*/

/* events
	id					auto-incremented cache record id
	calendar			pair hash for cached calendar, generated by getPairingHash()
	calendar_event[id]	Canvas ID of calendar event
	event_hash			hash of cached event data from previous sync
	synced				sync identification, generated by getSyncTimestamp()
	modified			timestamp of last modification of the record
*/

/* schedules
	id			auto-incremented cache record id
	calendar	pair hash for cached calendar, generated by getPairingHash()
	crontab		crontab data for scheduled synchronization
	synced		sync identification, generated by getSyncTimestamp()
	modified	timestamp of last modification of the record
*/

/**
 * Generate a unique ID to identify this particular pairing of ICS feed and
 * Canvas calendar
 **/
function getPairingHash($icsUrl, $canvasContext) {
	return md5($icsUrl . $canvasContext . CANVAS_API_URL);
}

/**
 * Generate a hash of this version of an event to cache in the database
 **/
function getEventHash($date, $time, $uid, $event) {
	return md5($date . $time . $uid . serialize($event));
}

/**
 * Generate a unique identifier for this synchronization pass
 **/
$SYNC_TIMESTAMP = null;
function getSyncTimestamp() {
	global $SYNC_TIMESTAMP;
	if ($SYNC_TIMESTAMP) {
		return $SYNC_TIMESTAMP;
	} else {
		$timestamp = new DateTime();
		$SYNC_TIMESTAMP = $timestamp->format(SYNC_TIMESTAMP_FORMAT) . SEPARATOR . md5($_SERVER['REMOTE_ADDR'] . time());
		return $SYNC_TIMESTAMP;
	}
}

?>