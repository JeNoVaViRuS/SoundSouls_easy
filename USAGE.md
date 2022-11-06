####################################################################################### Preparation ########################################################################################

Preparation:

1. If you have PTDE edition: Your game must be unpacked to even see the "sounds" folder in your Dark Souls directory. This is needed: https://www.nexusmods.com/darksouls/mods/1304
2. Make a backup of your whole "sound" folder. It's way easier for you to restore it than me trying to prevent errors with backups in the scripts.
3. Go into the "FMODDesigner" folder and install either "42800" for DS1 PTDE or "44464" for DS1 Remastered.

###################################################################### SoundBones structure and how to find your sound ######################################################################

So you might wonder where to find sounds that aren't dialogues? No? Just want to edit dialogues? Skip to the next section "Preparation for dialogue".

- "frpg_cXXXX" = sound files of enemies
- "frpg_pXXXXZZ" = in-game event sounds, XXXX is the map reference e.g. "1002" = Firelink shrine, ZZ is the event number. E.g. frpg_p140015.fdp is the Bell Ring in Queelags Domain
- "frpg_main" = player character actions sounds (movement, damage, roll, footsteps etc.)
- "frpg_smain" = player character extra sounds (summon, playerdeath, bonfire rest, character creation, intro sound)
- "frpg_mixer" = in-game reverb
- "frpg_smXX" = sounds on the maps (boss fight music, cutscene sound, sfx sounds and dialogues with npcs)
- "frpg_mXX" = sounds on the maps (environment)
- "frpg_xmXX" = looping background sound that is played on every map

1. Go into the "SoundBones_named" folder and open the ones where you presume your desired sound must be. Go to the "Sound definitions" tab and take a look if it is there.
2. You can also open the freshly installed "FMOD Event player" to open the .fev files from your Dark Souls\sound directory. There you can double-click on the events to listen to the sounds.
3. Note down the filename that contains your desired sound e.g.: "frpg_p130100.fev" means the name is just "frpg_p130100"

################################################################################# Preparation for dialogue ##################################################################################

1. pick some distinctive part from a dialogue of the npc (not "Good-bye, then." , better: "Here, have you met that sunbathing Solaire?")
2. use "DS Map Studio" and go to "Text editor" -> "TalkMsg" and search for your dialogue. Note down the ID
3. use "DS Map Studio" and go to "Param editor" -> "TalkParam" and search for this ID. Note down the voiceID (text and voice ID can actually differ)
4. run "#search for voice lines.bat" and enter the voiceID you found. It will spit out all .fdp files that contain it. Note them down

####################################################################################### How to use ##########################################################################################

Warning: The folders "additional_sound, bank, Build, currentSoundBones" get deleted everytime you start with 1.)

How to use (read the text that pops up in the cmd windows closely):

1. run "#1 extract fsb.bat" and enter the path to your Dark Souls directory (if different from default or saved), then the name of your respective file from the preparation
	Important: your dialogue voiceID might be like: 23000100 but the extracted files are actually named "v023000100.mp3".
	So if you want to overwrite them then take a look into the "bank" folder how they are named and make sure you named your files in the "additional_sound" folder the same
	If you are adding a file then make sure to give it the next ID name e.g. conversation with Laurentius is "v023000100" - "v023000105" so your additional file should be "v023000106"
	1.1 optional: run "#1.1 create empty wav files" to generate an empty .wav file in the "additional_sound" folder
	1.2 optional: put your new sound files in the "additional_sound" folder as .mp3 or .wav
	1.3 optional: use https://fakeyou.com/ or https://murf.ai to enter your text and generate sound files and put them into the "additional_sound" folder as .mp3 or .wav
	
2. run "#2 Convert all to wav.bat" to convert all the ".mp3" files into ".wav" files
3. run "#3 sort sound files.bat" so it automatically sorts all files into folder according to the .fdp project structure. If you only wanted to replace a soundfile then skip to 5.
	3.1 your file is now in the bank\frpg... folder. You can put it into a fitting folder (not needed) e.g.: filename was "v023000100.wav" then put it into the folder "v023".
	
4. run "#4 Open the fdp with FMOD.bat"
	First complete all steps for only one event/sound. Then do it again for the next sound so you avoid mistakes.
	4.1 In the "events" tab you should look for the event that's the last voiceID of your dialogue you want to extend
	4.2 right-click that event and click "copy", then right-click again right there and click "paste"
	4.3 now you have it as a duplicate. In the middle lower part of the screen you need to edit the "value" for the "Name" property. DON'T select another event. Keep this new one selected.
	4.4 go to the "Sound definitions" tab
	4.5 right-click somewhere in the left side of the list
	4.6 go to the "Event editor" tab
	4.7 right-click in the free space in the lower middle and select "Replace sound..."
	4.8 select your created "Sound definition" and press "OK"
	4.9 Now repeat for other sounds or save the project: File -> Save Project (or Strg+S) and exit
	
5. run "#5 build fev and fsb.bat" and the files are now in the "Build" folder
6. run "#6 copy to DS folder.bat" to copy the files into your game directory. This will overwrite your original game files. Make sure you have a backup.
	