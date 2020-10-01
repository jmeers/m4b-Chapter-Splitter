# m4b-Chapter-Splitter
A few PowerShell scripts that will split audiobook(s) by chapter markers and output .mp3s

## SplitByChapters.ps1
Using the file explorer you can select one .mp4, .m4a or .mp4 and it will cut it into chapters by chapter markers and output to .mp3s in the same directory as the audiobook.

## MassSplitChapters.ps1
Takes all .M4Bs in a directory it is placed in and converts them to mp3s and places them in a folder with the name of the audiobook.

## Requirments
ffmpeg is required. Its directory will need to be set in the script.

Chapter files will be output to the source file directory.

Current setup should work by downloading and extracting ffmpeg to the desktop and removing the version info so the folder is named ffmpeg.
