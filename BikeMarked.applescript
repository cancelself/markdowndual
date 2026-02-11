on open theFiles
	repeat with f in theFiles
		set filePath to POSIX path of f
		do shell script "open -a 'Bike' " & quoted form of filePath
		do shell script "open -a 'Marked 2' " & quoted form of filePath
	end repeat

	delay 0.5

	tell application "Finder"
		set {_, _, screenW, screenH} to bounds of window of desktop
	end tell

	set halfW to screenW / 2

	tell application "Bike"
		activate
		set bounds of front window to {0, 0, halfW, screenH}
	end tell

	tell application "Marked 2"
		activate
		set bounds of front window to {halfW, 0, screenW, screenH}
	end tell
end open
