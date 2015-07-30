# screensaver-password-toggle
Toggle screensaver password for osx

Use in combination with sleepwatcher (`brew install sleepwatcher`) to automatically enable/disable password lock when machines wakes in untrusted/trusted environment. Determined by connected SSID and optional BSSID (mac address) of SSID.

See example `sleepwatcher-scripts/wakeup` for usage with sleepwatcher.

# Trusted SSIDs and BSSIDs

Add your trusted SSIDs to `.ssid.trusted`. 
One SSID per line. BSSID optional.

Examples:
```
MyHomeNetwork
MyOfficeNetwork (0a:1b:2c:3f:44:5c)
```
