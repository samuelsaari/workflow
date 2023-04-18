; Activate an existing firefox.exe window, or open a new one

^SPACE:: IF WinExist("ahk_exe firefox.exe") {
WinActivate, ahk_exe firefox.exe
} else {
Run, firefox.exe
}