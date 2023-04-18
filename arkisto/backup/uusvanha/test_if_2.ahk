; Activate an existing firefox.exe window, or open a new one

^SPACE:: IF WinExist("ahk_exe chrome.exe") 
{WinActivate, ahk_exe chrome.exe} 
else {
Run, chrome.exe
}