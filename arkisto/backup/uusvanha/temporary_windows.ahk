#w::  
if WinExist("ahk_exe firefox.exe")
    WinActivate
else
    Run, firefox.exe
Return


#s:: 
if WinExist("ahk_exe excel.exe")
    WinActivate
else
    Run, excel.exe
Return