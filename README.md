# Automatic-hevc-to-hvc1-Converter
A collection of tools/scripts to automate the conversion of videos recorded in the h.265 HEVC codec to an apple compatible hvc1 codec instantly.


#####   HOW TO USE   #####

Place "Retag_HEVC_to_HVC1_newdelete.bat" in the target folder where you want to automatically convert the codec tag. For example, when recording from OBS, it automatically records videos to the Videos folder. I have mine there. It will wait for a video to be finished recording, then when it is done, the watcher will detect it then convert it immediately. It will ignore all videos already converted as they will automatically end with "_hvc1.mp4".

Next, place Watcher.ps1 inside of any folder of your choice. I reccomend your Documents or a scripts folder. You will need to edit this ps1 file to change the location where it targets the script to run. These lines are #3, #11, #12. For example: "C:\Users\John\Videos" (Keep the qoutation marks but remove the asterisks on these lines).

Use sc.exe (Built in with Windows) to create a service out of the ps1 command once you have verified it is working.

sc.exe --% create VideoWatcher binPath= "\"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe\" -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File \"C:\Scripts\Watcher.ps1\"" DisplayName= "Video Watcher" start= auto


Install ps2exe by running this command in Powershell as Admin:
Invoke-ps2exe -inputFile "C:\Scripts\Watcher.ps1" -outputFile "C:\Scripts\Watcher.exe" -noConsole

Replace the 2 files in qoutations to fit your preferences, the 1st one must be the path to Watcher.ps1, and the outputfile can be whatever you like, mine is Watcher.exe This will create an exe for the program to run in the background without any open powershell prompts on your taskbar.

Next, you'll want to add this as a Task in the Task Scheduler. 
Create Task -> Name it something like "Auto ReTag" and select to run either only when user is logged on or wether user is logged on or not. Run with highest priveleges. -> Go to triggers tab. Select "New" -> Begin task at log on and hit Ok. -> Go to Actions Tab, select Start a program, then select powershell.exe. Then add arguements: -NoLogo -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Scripts\Watcher.ps1"
Make the conditions tab fit your needs. Select Ok, then start the task.

If you set it up correct, it should be running a process called "VideoWatcher" and automatically converting your recordings and videos that are in mp4 format with h.265 hevc codec, to be tagged with the hvc1 codec. The program uses only about 10-16 MB of Ram in standby. The watcher script does not have much overhead.


