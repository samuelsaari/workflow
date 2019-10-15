# Workflow for Windows - Keyboard shortcuts with Autohotkey

### I. Intro
This is a list of customized keyboards to switch between windows and do other often repeated tasks **in _Windows_**. It consist of three seperate parts:
1) General Windows workflow including hotkeys for switching apps and making repetive tasks faster (1 scripts)
2) Stata workflow (2 scripts)
3) Other useful material:
	- "shortcut_chart.pdf" for a quick overview of hotkeys
	- "tooltip_1.0.ahk" to view windows-specific information easily (if you are going to modify the code to suit your needs)
	- "End scripts.ahk" (TheGood 2009) if you want to end ahk scripts (useful especially for tooltip, also Ctrl-Alt-Del works).
	- "word_macros_1.0.txt" to incorporate ahk with word macros
	
### II.Setup
A) Download Autohotkey at https://www.autohotkey.com/
B) Download the files of your choice ("windows_workflow.ahk" and/or "stata_workflow_A(&B).ahk" files)
C) Edit the files to your liking (see III. Customizing the code, this is the most time consuming part)
D) Run the scripts by double-clicking them. 
That's it, now everything should work.

E) If you want the hotkeys to work every time you start Windows, add a shortcut of the ahk scripts in the startup folder:
https://www.thewindowsclub.com/startup-folder-in-windows-8

### III. Customizing
Before you run the code on your device:
- check places with "NB!" in the code as they might require customization for your computer
- if you are not using a Scandinavian keyboard, look for å, ä, ö and adjust the shortcuts for other letters.
- Modify hotkeys Word workarounds (1.1 in windows_workflow) to work with "word_macros_1.0.txt" or simply delete section 1.1. If you are using a Scandinavian keyboard, everything should, however, work without any changes. To prepare the Word macros for the first time, press Alt-F11 in Word, Copy-Paste the code in "word_macros_1.0.txt", save and run the short-cut macros once in word via "View -> Macros -> View Macros" From there, you can simply run all macros that end with "SC" (Shortcut).

### IV. Feedback
Please let me know if you come up with any sort of improvements or advances in the code. Also feel free to suggest edits directly in the code.

### References and links:

TheGood(2019) See running AutoHotkey scripts (and end them). [Accessed Oct 15, 2019] https://autohotkey.com/board/topic/38653-see-running-autohotkey-scripts-and-end-them/
Autohotkey beginner tutorial https://www.autohotkey.com/docs/Tutorial.htm
