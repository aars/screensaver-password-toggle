#!/bin/sh
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ BSSID/ {print substr($0, index($0, $2))}'