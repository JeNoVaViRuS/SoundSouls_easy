@echo off
set soundfolder=bank
set /p soundfdp=< fdp.log
::FOR /f %%G IN ('dir /b "%soundfolder%"') DO FEVBuilder_4.28\fmod_designercl.exe -pc currentSoundBones\%%G.fdp -b Build\

::add fix for wrong lines in .fdp file (in the event tags there is <name>/frpg_sm10/v023000107</name> but when copied and pasted it has the wrong number (has the one from the copied one)


::ask user for DS1 version
echo Which Dark Souls version do you have?
echo.
echo 1. PTDE
echo 2. Remastered
echo.
CHOICE /C 12 /M "Enter the number and press Enter:"

If ERRORLEVEL 1 (
FEVBuilder_4.28\fmod_designercl.exe -pc -r currentSoundBones\%soundfdp%.fdp -b Build\
)

If ERRORLEVEL 2 (
FEVBuilder_4.44\fmod_designercl.exe -pc -r currentSoundBones\%soundfdp%.fdp -b Build\
)
pause