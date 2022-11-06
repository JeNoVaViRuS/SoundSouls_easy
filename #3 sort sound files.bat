@echo off
powershell.exe -ExecutionPolicy Bypass -File powershell\sort_sound_files.ps1

::copy to currentSoundBones folder cause FMOD needs it
robocopy bank currentSoundBones\bank /E >Nul 2>&1
pause