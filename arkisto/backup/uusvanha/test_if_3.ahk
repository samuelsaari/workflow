; Activate an existing firefox.exe window, or open a new one

^SPACE:: 
if WinExist("ahk_exe chrome.exe")
    WinActivate
else
    Run, chrome.exe