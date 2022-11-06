@echo off
set soundfolder=bank
set /p soundfdp=< fdp.log
::ask for audio file format of their additional sound files
echo Now copy your additonal sound files to the "additional_sound" folder. They need to be either in .mp3 or .wav format.
echo Press Enter to continue.

::copy all additonal_sound .mp3 to the folder to convert them too
move /y additional_sound\*.mp3 bank\%soundfdp% >Nul 2>&1

::convert all to wav
::ffmpeg -i %soundfolder%\%%G\%%~nf.mp3 -acodec pcm_s16le -ac 1 -ar 44100 -b:a 160000 %soundfolder%\%%G\%%~nf.wav.wav
FOR /f %%G IN ('dir /b "%soundfolder%"') DO (
for /f %%f in ('dir /b %soundfolder%\%%G') do lame\lame.exe -b 160 %soundfolder%\%%G\%%~nf.mp3 %soundfolder%\%%G\%%~nf.wav >Nul 2>&1
del /q %soundfolder%\%%G\*.mp3
)

::copy all .wav to the folder
move /y additional_sound\*.wav bank\%soundfdp%\ >Nul 2>&1

exit