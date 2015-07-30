#!/bin/sh

# Where to find our list of trusted SSIDs
if [ ! $TRUSTED_SSIDS ]; then
	TRUSTED_SSIDS="./.ssid.trusted"
fi

if [ ! -f $TRUSTED_SSIDS ]; then
	echo "Failed to load trusted SSIDs file $TRUSTED_SSIDS"
	exit;
fi

# Scripts
SCRIPT_ENABLE="./applescripts/screensaver-password-enable.applescript"
SCRIPT_DISABLE="./applescripts/screensaver-password-disable.applescript"
SCRIPT_STATE="./applescripts/screensaver-password-state.applescript"
SCRIPT_LOCK="./applescripts/start-screensaver.applescript"

function enable {
	osascript $SCRIPT_ENABLE
	if [ "$1" == "BSSID mismatch" ]
	then
		echo "Enabled: BSSID mismatch for SSID $SSID; Expected $TRUSTED_SSID_BSSID; Found $BSSID;"
	else
		echo "Enabled: Connected to untrusted SSID $SSID"
	fi

	if [ ! "$STATE" == "true" ]; then
		echo "Starting screensaver"
		osascript $SCRIPT_LOCK
	fi
}
function disable {
	osascript $SCRIPT_DISABLE
	echo "Disabled: Connected to trusted SSID $SSID"
}

# Change working dir.
cd "$(dirname "$0")"

# Get current locking state.
STATE=$(osascript $SCRIPT_STATE)

# Get current SSID and BSSID
SSID=$(./ssid.sh)
BSSID=$(./bssid.sh)

# Are these trusted values?
TRUSTED_SSID=$(grep $SSID $TRUSTED_SSIDS) # Found SSID in trusted list?
TRUSTED_SSID_BSSID=$(echo $TRUSTED_SSID | grep -o \(.*\)) # BSSID supplied for SSID?
TRUSTED_BSSID=$(echo $TRUSTED_SSID_BSSID | grep $BSSID) # Does BSSID match?

if [ ! "$TRUSTED_SSID" ] # Not found in trusted SSID list.
then
	enable
else
	# SSID is trusted. Trust BSSID if supplied?
	if [ ! "$TRUSTED_SSID_BSSID" ] || [ "$TRUSTED_BSSID" ]
		then
			disable
		else
			enable "BSSID mismatch"
		fi
fi
