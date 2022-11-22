$fdpLog = "fdp.log"
$soundfdp = Get-Content $fdpLog -First 1
$fdpPath="currentSoundBones/"+ $soundfdp +".fdp"

#add search through .fdp and create subfolders for the wav banks and move them there
foreach ($filename in (Select-String "<filename>bank/f" $fdpPath))
{
	#split string into array
	$filenameArray = $filename.ToString().Split("/")

	#if the second part of the string isn't the .wav file then it's a folder so create folder and move it there
	If ($filenameArray[2] -notlike "*.wav*") {
		
		$filenameSubFolder = "bank\" + $soundfdp + "\" + $filenameArray[2]
		#create folder if it doesn't exist
		If (-Not (Test-Path $filenameSubFolder)) {New-Item -Path $filenameSubFolder -ItemType Directory | Out-Null}
		
		$wavFile = "bank\" + $soundfdp + "\" + $filenameArray[3].Trim("<"," ")
		#move file to subfolder
		Move-Item $wavFile $filenameSubFolder | Out-Null
	}
}