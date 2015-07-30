# screensaver-password-toggle
Toggle screensaver password for osx

Use in combination with sleepwatcher (`brew install sleepwatcher`) to automatically enable/disable password lock when machines wakes in untrusted environments, not connected to trusted SSIDs. 

See example `sleepwatcher-scripts/wakeup`.

# Trusted SSIDs and BSSIDs

Add your trusted SSIDs to `.ssid.trusted`. 
One SSID per line. BSSID optional.

Examples:
```
MyHomeNetwork
MyOfficeNetwork (0a:1b:2c:3f:44:5c)
```
