@echo off
::copy to currentSoundBones folder cause FMOD needs it
robocopy bank currentSoundBones\bank /E >Nul 2>&1

set /p soundfdp=< fdp.log
currentSoundBones\%soundfdp%.fdp
exit