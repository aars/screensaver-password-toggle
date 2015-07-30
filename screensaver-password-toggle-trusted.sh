#!/bin/sh
TRUSTED_SSIDS="./.ssid.trusted"
ENABLE="./screensaver-password-enable.applescript"
DISABLE="./screensaver-password-disable.applescript"
LOCK="./start-screensaver.applescript"

cd "$(dirname "$0")"

STATE=$(osascript ./screensaver-password-state.applescript)

SSID=$(./ssid.sh)
TRUSTED=$(grep $SSID $TRUSTED_SSIDS)

if [ "$TRUSTED" == "" ]
then
	osascript $ENABLE
	echo "Enabled: Connected to untrusted SSID $SSID"
	if [ ! "$STATE" == "true" ]
		then
			echo "Starting screensaver"
			osascript $LOCK
		fi
else
	osascript $DISABLE
	echo "Disabled: Connected to trusted SSID $SSID"
fi
