@echo off
::user enters seconds
set /p seconds=Enter the lentgh in seconds (use dot decimal e.g.: 1.5):
echo.
::user enters name
set /p soundname=Enter the name of your sound event you want to overwrite or add:
echo.
mkdir additional_sound >Nul 2>&1
::create file with ffmpeg
ffmpeg\ffmpeg.exe -y -f lavfi -i anullsrc=r=44100:cl=mono -t %seconds% -b:a 160k -acodec libmp3lame additional_sound\%soundname%.wav >Nul 2>&1
set /p message=Your wav file was created in the "additional_sound" folder.
exit