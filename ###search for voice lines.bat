@echo off
set /p voiceID=Enter the voice ID:
echo.
findstr /m "%voiceID%<" SoundBones\*.fdp
echo.
pause