§ & q::
if WinExist("ahk_exe chrome.exe")
    WinActivate
else
    Run, chrome.exe
Return