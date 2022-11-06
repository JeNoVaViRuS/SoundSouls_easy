#you can change the sound bank extract folder here for tests. You need to set it in the next lines for the rm command. Don't mess up.
$soundfolder="bank"
$fdpLog = "fdp.log"

#clear the folders
#the $soundfolder var is not used here because it deletes the whole folder if it is empty or /
#Remove-Item -Recurse -Path bank | Out-Null
#Remove-Item -Recurse -Path additional_sound\ | Out-Null
#Remove-Item -Recurse -Path currentSoundBones\ | Out-Null
#Remove-Item -Recurse -Path Build\ | Out-Null
#out-null didn't work for Remove-Item file!? so New-Item with Force, gg ez. Hey, as long as it works...
New-Item -Path $fdpLog -Value "" -Force | Out-Null

#create folders
New-Item -Path $soundfolder -ItemType Directory -Force | Out-Null
New-Item -Path "additional_sound" -ItemType Directory -Force | Out-Null
New-Item -Path "currentSoundBones" -ItemType Directory -Force | Out-Null
New-Item -Path "Build" -ItemType Directory -Force | Out-Null

#check for existing path that was set
$pathfile="DSpath.log"
if (Test-Path $pathfile)
{
	$DSPathInFile = Get-Content $pathfile -First 1
	Write-Host Your default Dark Souls Path is: $DSPathInFile
}
else
{
Write-Host "Your default Dark Souls Path is: C:\Program Files (x86)\Steam\steamapps\common\Dark Souls Prepare to Die Edition\DATA\"
$DSPathInFile = "C:\Program Files (x86)\Steam\steamapps\common\Dark Souls Prepare to Die Edition\DATA\"
Set-Content -Path $pathfile -Value $DSPathInFile
}

#let the user enter a folder 
do {
$DSlocation = Read-Host -Prompt 'Enter your Dark Souls folder location if it differs otherwise leave empty then press Enter'

#check if the user entered nothing or something
If ($DSlocation)
{
#if the user set something then set the content
If (Test-Path $DSlocation)
{
	Set-Content -Path $pathfile -Value $DSlocation
}
#if user entered an invalid path then tell him and ask him to enter it again
else
{
	Write "This folder doesn't exist: " $DSlocation
}
#if user entered nothing then use the default path or path from the file
}
else
{
	$DSlocation = $DSPathInFile
}	
#until the user has chosen a valid folder
}until(Test-Path $DSlocation)

#ask user for .fsb file
do {
$soundfdp = Read-Host -Prompt 'Enter the name of the .fsb file without the .fsb extension'

$soundPath = $DSlocation+"\sound\"+$soundfdp+".fsb"
#test if file exists
If (-Not (Test-Path $soundPath -PathType Leaf))
{
	Write "This file doesn't exist: " $soundPath
}
#until user has chosen a valid file
}until(Test-Path $soundPath -PathType Leaf)

#set log file, fill it with the chosen .fsb/.fdp file name
Set-Content -Path $fdpLog -Value $soundfdp
$fdpPath="currentSoundBones/"+ $soundfdp +".fdp"
$Soundbones = "Soundbones\" + $soundfdp + ".fdp"

#copy the chosen .fdp files (the user can take a look manually, save and change them
Copy-Item $Soundbones currentSoundBones\

$fsbPath = $DSlocation + "\sound\" + $soundfdp + ".fsb"
$bankfrpgFolder = "bank\" + $soundfdp

#extract the .fsb
#command "| Out-Null" means it waits for it to end before continuing
FsbExtractor\FsbExtractor.exe /C /O:$bankfrpgFolder $fsbPath | Out-Null

#rename all files to be without .wav
dir $bankfrpgFolder | rename-item -NewName {$_.name -replace ".wav",""}

#this part is apparently not needed cause you only need to build the original file and not the additonally mentioned files *cries*
<#for each frpg or fdlc mentined, loop through the file
foreach ($frpg in (Select-String "<filename>bank/f" $fdpPath))
{
	#search for frpg in the file
	$frpgArray = $frpg.ToString().Split("/")
	$checkfrpg = Select-String -Path $fdpLog -Pattern $frpgArray[1]
	
	#execute if something with frpg was found in the file that's not already in the fdp log file
	If (!$checkfrpg) {
	
	$fsbPath = $DSlocation + "\sound\" + $frpgArray[1] + ".fsb"
	$bankfrpgFolder = "bank\" + $frpgArray[1]
	
	#extract the .fsb
	#command "| Out-Null" means it waits for it to end before continuing
	FsbExtractor\FsbExtractor.exe /C /O:$bankfrpgFolder $fsbPath | Out-Null

	#rename all files to be without .wav
	dir $bankfrpgFolder | rename-item -NewName {$_.name -replace ".wav",""}
	
	#add the found frpg to the log file so it doesn't do the same again for this frpg
	$frpgToFile = "`r`n" + $frpgArray[1]
	Add-Content -Path fdp.log -Encoding utf8 -Value $frpgToFile
	}	
}
#>