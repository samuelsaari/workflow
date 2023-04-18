!SPACE:: 
if WinExist("ahk_exe notepad.exe")
    WinActivate, ahk_exe notepad.exe
else
    Run, notepad.exe
