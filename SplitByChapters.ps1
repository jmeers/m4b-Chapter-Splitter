#ffmpeg path
cd "C:\Users\$ENV:UserName\Desktop\ffmpeg\ffmpeg\bin\"

Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    InitialDirectory = [Environment]::GetFolderPath('Desktop')
    Filter = 'Audio Files (*.mp4,*.m4a,*.m4b,)|*.mp4;*m4a;*.m4b|All files (*.*)|*.*'
    Title = 'Select your audiobook files to open'
}
[void]$FileBrowser.ShowDialog()
$audioBook = $FileBrowser.FileNames
$Book = [System.IO.Path]::GetFileNameWithoutExtension("$audioBook")
$path = $FileBrowser.InitialDirectory

#Get Chapters from file, Convert from json
$json = (.\ffprobe.exe -i "$audioBook" -show_chapters -print_format json) | Out-String | ConvertFrom-Json

#Output only endtimes to varible
$Endtimes = $json.chapters.end_time

#First start time is 0 seconds
$Starttime = 0.000000

#For each endtime output file
for ($i=0; $i -lt $Endtimes.length; $i++) {
    $ChapterNum = $i + 1
    if ($ChapterNum  -le 9) {
    .\ffmpeg -i "$audioBook" -ss $Starttime -to $Endtimes[$i] "$path\Chapter 0$chapterNum - $Book.mp3"
    } Else {
    .\ffmpeg -i "$audioBook" -ss $Starttime -to $Endtimes[$i] "$path\Chapter $chapterNum - $Book.mp3"
    }
	$Starttime = $Endtimes[$i]
}
