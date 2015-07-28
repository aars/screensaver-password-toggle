#!/bin/sh
TRUSTED_SSIDS="./.ssid.trusted"
ENABLE="./screensaver-password-enable.applescript"
DISABLE="./screensaver-password-disable.applescript"
LOCK="./start-screensaver.applescript"

cd "$(dirname "$0")"
SSID=$(./ssid.sh)
TRUSTED=$(grep $SSID $TRUSTED_SSIDS)

if [ ! $TRUSTED ]
then
	osascript $ENABLE
	echo "Enabled: Connected to untrusted SSID $SSID"
	osascript $LOCK
else
	osascript $DISABLE
	echo "Disabled: Connected to trusted SSID $SSID"
fi
