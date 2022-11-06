FSB Extractor - FMOD Sample Bank Extraction Tool
------------------------------------------------
With the tool, you can display and extract the sound samples contained within an FSB file. FSB stands for "FMOD Sample Bank". FSB files are a common filetype for storing audio in some games.

Supports the FSB3, FSB4 and FSB5 file formats.

This program was originally made to open the FSB files of "Dragon Age", but has since been expanded into a general FSB Extractor.

Extracted sound samples are written to "%TEMP%\FsbExtractor\". You can open this directory from the Show menu or by pressing [F12]. You can also choose to extract to a specific folder by pressing [F6]. Make sure you have write access. When using the "Extract & Run" feature, it's possible to use a "Custom Sound Player" to play the extracted file. Might be useful for ADPCM. This feature will circumvent your system's file association. See below for more info.

Write Wave Header
-----------------
When an audio file is extracted, a RIFF WAVE header will automatically be generated and added to the file, this ensures that it can be played.
If for some reason the header added interfers with playback or is just in the way, you can disable this feature from the Options menu (F7).

MP3 Frame Verification
----------------------
This option probably requires a little explanation. MP3 files consists of many small frames, normally these frames, along with their data,
are aligned right next to each other. For some FSB files however, this is not the case, as their frames are aligned on 4 byte borders.
To work around this issue, this option will write each frame individually and skip the empty alignment space between them.
The penalty of using this option is a slightly slower extracting speed, but it shouldn't be too bad.
Examples of games with FSB files that has aligned MP3 frames: League of Legends, Don't Starve.

Command Line Parameters
-----------------------
FsbExtractor.exe [/C] [/V[0|1]] [/S[0|1]] [/O:<path>] [/L:<logfile>] [<fsbfile1>] [<fsbfile2>] [<fsbfile(n)>]
	/C				Enables console mode. When enabled, files are extracted and program will terminate when done.
	/V[0|1]			Enables or disables verbose logging. When enabled, more information is detailed in the logs.
	/S[0|1]			Toggles scanning for sub-FSB-files. This could take a while for large files. Only works in console mode.
	/O:path			Sets the output path of the extracted files. If not set, current folder is used.
	/L:logfile		Writes a log file of the "Sound Bank" and "Extraction" logs.
Here is an example that can be used on many FSB files, which will extract the samples of each to their own subfolder.
	for /r %%f in (*.fsb) do X:\PATH\FsbExtractor.exe /C "/O:fsb.%%~nf" "%%f"

Sample Formats & Color
----------------------
Each sample is assigned a different colored icon, which is determined by its sample format.
- Black  = Invalid (0) - Should never appear, but might do so if the FSB file is corrupted.
- Green  = PCM (1) - Raw uncompressed sample data.
- Teal   = ADPCM (17) - Compressed data. Use VLC or the "in_xbadpcm" Winamp plugin to play.
- Red    = MP3 (85) - Some FSB files will have an alignment between MP3 frames, use "MP3 Frame Verification" in such cases.
- Yellow = Ogg Vorbis (26447) - Usually have no headers, so they can sadly not be played when extracted.

Custom Sound Player
-------------------
It's possible to override the default file association, for the file extension of the current extracted file.
You can do this from the option menu, by picking the "Select Player App" item.
I recommend setting the player to VLC, as I've found that to open and play most of the files, including ADPCM.

Games Using FSB Files
---------------------
Here is a very incomplete list of games with FSB files, based on which files this tool has been tested on.
Have you tried this tool on any games not listed here? If so, I would love to hear which one and the version of FSB files its using.
- BioShock					FSB3. ADPCM format.
- BioShock 2				FSB4: Singleplayer. FSB3: Multiplayer.
- Dragon Age: Origins		FSB4.
- League of Legends			FSB4. MP3 frames have space between them, use the option "MP3 Frame Verification".
- Natural Selection 2		FSB5. Used to have FSB4 during alpha/beta.
- Orcs Must Die!			FSB4.
- Orcs Must Die! 2			FSB4.
- The Witcher 2				FSB4. All samples here makes use of the Ogg CELT format. Google "tw2unfsb".
- Don't Starve				FSB5. The "MP3 Frame Verification" option should be on.
- PlanetSide 2				FSB5. The FSB files are inside the many "Assets_XXX.pack" files. ADPCM and Ogg Vorbis format.
- DuckTales Remastered		FSB5.
- Deus Ex: Human Revolution	FSB4. Contained within the BIGFILES.

- Alan Wake					FSB4.
- Mafia II					FSB4.
- The Walking Dead			FSB4. Requires the option "MP3 Frame Verification" to be on.
- World of Tanks			FSB4.
- World of Warplanes		FSB5 (Closed Beta).
- MechWarrior Online		FSB5.
- Strike Suit Zero			FSB4. Has some interleaved multichannel MP3 samples.
- War Thunder MMO			FSB4. Headerless Ogg samples.
- Kingdoms of Amalur		FSB4. Some samples have basic headers.
- Shantae: Risky's Revenge	FSB5. Mainly MP3.

Dragon Age Music
----------------
The music of Dragon Age you will find in this file:
"\Dragon Age\packages\core\audio\sound\music_bank_strm_new.fsb"
The song "I Am the One" you can find in this file:
"\Dragon Age\packages\core\audio\sound\music_notstream_sting.fsb"

Forum Threads
-------------
http://forums.unknownworlds.com/discussion/118938
http://social.bioware.com/forum/1/topic/9/index/295486

Special Thanks
--------------
- Mark James for the famfamfam mini and silk icon sets.		http://www.famfamfam.com/lab/icons/silk/
- Luigi Auriemma - Author of fsbext.

Lacking Features, Ideas & Problems
----------------------------------
- ADPCM: Ensure the corrent "wSamplesPerBlock" value is being written to the WAVE header.
- FSB5: Obtain sample rate for MP3 samples through reading the MP3 frame data.
- Sample bitrate is currently initialized to 44100 Hz. However, some samples stored as MP3 does not fill in this field of the FSB file, and the real sample rate is only available by reading an MP3 frame header.
- Aligned streaming samples, those that needs frame verification, can extend beyond the reported data size of the sample. It may be possible to check the next samples offset to get the real raw aligned size of the data.
- Header statusbar panel does not account for the "infoSizeTotal" section of FSB5 files.
- Ogg Vorbis in FSB files do not have any headers. This makes them unplayable when extracted. The solution would probably be to add some sort of estimated faux header.
- PlanetSize 2 has extra data of the type #11 (8 to 1016 bytes) and #17 (4 bytes). Currently this data is just skipped, but what does it contain?
- Option to decode ADPCM data back to raw PCM data. Not sure adding this is worth it, since ADPCM plays "alright" in VLC. The "in_xbadpcm" Winamp plugin is also an option, plays it better than VLC.

Fixed Issues
------------
- Scroll to selected item when re-sorting entries (column click).
- A good and unique main icon for the program. The current musical node icon is a bad stock image.
- There seem to be a problem with some ADPCM data (Seen in NS2's FSB5 files), which makes them unplayable, at least to VLC and in_xbadpcm. These samples have the flag 0x80 and have been marked by a half opaque icon for now.
- Feature: "Scan for FSB Offset". Some FSB files reside inside large archives, which you'd have to extract manually with a hex editor, a tedious task. This feature should be able to find each FSB inside these archives.
- Handle and distinguish samples with a higher than 16 bits per sample value. This is a floating PCM format WAVE_IEEE(3). Might be using the "FSOUND_MPEGHALFRATE" flag.
- If an FSB file has several samples with the same name, it overwrites previous file when extracting.
- Figure out the proper way to detect ADPCM samples in FSB5 files. Flag = 0x04 = ADPCM?