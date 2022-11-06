@echo off
::fuck batch
set /p DSpath=< DSpath.log
set /p soundfdp=< fdp.log

robocopy Build "%DSpath%\sound" *.fev >Nul 2>&1
robocopy "Build" "%DSpath%\sound" *.fsb >Nul 2>&1
exit