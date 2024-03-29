# Workflow for Windows - Keyboard shortcuts with Autohotkey

Watch a teaser trailer on YouTube:
[![Trailer - Workflow for Windows](https://github.com/samuelsaari/workflow/assets/49607659/4a3ffa4d-6e55-491f-86a8-4277546284b6)](https://youtu.be/oFqOz5auLbk?feature=shared)

### I. Intro
This is a list of customized keyboard shortcuts to switch between windows and do other often repeated tasks **in _Windows_**. It consist of four seperate parts:
1) General Windows workflow including hotkeys for switching apps and making repetive tasks faster (windows_workflow.ahk)
2) Stata workflow (stata_workflow.ahk)
3) Word Macros (optional but very useful)
3) Other useful material:
	- "tooltip.ahk" to view windows-specific information easily (if you are going to modify the code to suit your needs)
	- "End scripts.ahk" (TheGood 2009) if you want to end ahk scripts (useful especially for tooltip, you can also do this via Ctrl-	Alt-Del).
	- "Zotero_Workflow_Practice.docx" to practice referencing and creating bibliographies in Word
	- "Stata_Workflow_practice.do" to practice Stata workflow + examples on looping
	- "R_workflow_examples.R" to demonstrate that you don't need loops to "loop" in R.
	- "workflow_instructions_in_finnish.pdf" detailed setup instructions and other workflow tips for windows. (In Finnish)
	
	
### II.Setup
A) Download Autohotkey at https://www.autohotkey.com/
B) Download the files of your choice ("windows_workflow.ahk", "word_macros.txt" and/or "stata_workflow_A(&B).ahk" files)
C) Edit the files to your liking. You might want to assign hotkeys to programs you use most often and delete sections which are irrelevant for you (see III. Customizing the code, this can be a time consuming phase)
D) Run the scripts by double-clicking them. 
That's it, now everything should work.

E) If you want the hotkeys to work every time you start Windows, add a shortcut of the ahk scripts in the startup folder:
https://www.thewindowsclub.com/startup-folder-in-windows-8

### III. Customizing
Before you run the code on your device:
- check places with "NB!" in the code as they might require customization for your computer
- if you are not using a Scandinavian keyboard, look for å, ä, ö and adjust the shortcuts for other letters. *If you don't do this, ahk won't let you run the script*!
- Modify hotkeys for Word workarounds (2.3 in windows_workflow) to work with "word_macros.txt" or simply delete section 2.3. If you are using a Scandinavian keyboard, everything should, however, work without any changes. To prepare the Word macros for the first time, press Alt-F11 in Word, Copy-Paste the code in "word_macros.txt", save and run the short-cut macros once in word via "View -> Macros -> View Macros" From there, you can simply run the "A_RUN_SHORCUTS" to activate the hotkeys.

### IV. Feedback 
Please let me know if you come up with any sort of improvements or advances in the code. Also feel free to suggest edits directly in the code.

### V. Licence
[CC-BY-4.0.](https://choosealicense.com/licenses/cc-by-4.0/)  For reference, you can use the following:

Mäki, M. (2019) Workflow for Windows - Keyboard shortcuts with Autohotkey. https://github.com/samuelsaari/workflow

### References and links:

seperman (2017) AutoHotkey_ErgoKeyboard [Accessed Oct 15, 2019] https://gist.github.com/seperman/8064659

Learning One(2009) Run application if not active - activate window if active [Accessed Oct 15, 2019] https://autohotkey.com/board/topic/79159-run-application-if-not-active-activate-window-if-active/

Autohotkey beginner tutorial https://www.autohotkey.com/docs/Tutorial.htm

Syntax highlighting and autofill for Autohotkey in Notepad ++ https://www.autohotkey.com/boards/viewtopic.php?t=50
