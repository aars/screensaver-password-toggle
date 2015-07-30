tell application "System Events" 
	do shell script "echo " & (security preferences's require password to wake)
end tell
