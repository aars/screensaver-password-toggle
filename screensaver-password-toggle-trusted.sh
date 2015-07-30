#!/bin/sh
TRUSTED_SSIDS="./.ssid.trusted"
ENABLE="./screensaver-password-enable.applescript"
DISABLE="./screensaver-password-disable.applescript"
LOCK="./start-screensaver.applescript"

function enable {
	osascript $ENABLE
	if [ "$1" == "BSSID mismatch" ]
	then
		echo "Enabled: BSSID mismatch for SSID $SSID; Expected $TRUSTED_SSID_BSSID; Found $BSSID;"
	else
		echo "Enabled: Connected to untrusted SSID $SSID"
	fi

	if [ ! "$STATE" == "true" ]; then
		echo "Starting screensaver"
		osascript $LOCK
	fi
}
function disable {
	osascript $DISABLE
	echo "Disabled: Connected to trusted SSID $SSID"
}

# Change working dir.
cd "$(dirname "$0")"

# Get current locking state.
STATE=$(osascript ./screensaver-password-state.applescript)

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
