;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Windows workflow
;;;; Author: Miika Mäki

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 0. Quick Guide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; # = Win-key
;;;; <#= Left win-key
;;;; + = Shift
;;;; ^ = Ctrl
;;;; ! = Alt
;;;; <!= Left Alt-key
;;;; $ = will not fire any key but will prevent the hotkey itself from firing
;;;;
;;;; Complete Guide for hotkeys:	https://autohotkey.com/docs/Hotkeys.htm
;;;;                    	 	https://autohotkey.com/docs/KeyList.htm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;1. Zotero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;ZOTERO PLUGIN HOTKEYS
#IfWinActive, Quick Format Citation
;Suppress Author
$^å::send, 
(
{Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}
)
#IfWinActive
Return

#IfWinNotActive, Quick Format Citation
#IfWinExist, Quick Format Citation
#IfWinNotActive, ahk_class OpusApp
$^å::
WinActivate, Quick Format Citation
#IfWinNotActive
#IfWinExist
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 2. Windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for everything to work, 

;1.you will have to pin programs to the taskbar in the following order.
; If you dont have, say stata installed, just make sure that the rest of the programs are 2nd, 3rd..."nth" in the taskbar
; These are programs are the ones that do not work in a robust way (see the script below)
; (1 Stata)
; (2 Outlook)
; 3 spotify 
; 4 keep
; The rest won't matter (spotify & keep is actually the only truly unrobust one, I just prefer having Stata & Outlook...
; ...as the 1st and 2nd in the taskbar as the build in function Win + (1 or 2) works quite nicely together with...
; ...the hotkeys I have assigned for Stata and Outlook.

;2. numlock has to be off


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Unrobust
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;STATA
;See seperate file

;;;;;;;;;;;;;;;;;;;


/*
;DOES NOT WORK ON ALL DEVICES
;spotify BACKUP
<!LCtrl::
if WinActive("ahk_exe Spotify.exe")
{
WinGet,WinState,MinMax,ahk_exe Spotify.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
} 
else if WinExist("ahk_exe Spotify.exe")
    WinActivate
else
{
Run, Spotify.exe
Sleep,3000
Winmaximize, ahk_exe Spotify.exe
}
Return
*/



;;;;;;;;;;;
;SPOTIFY
<!LCtrl::
if WinActive("ahk_exe Spotify.exe")
{
WinGet,WinState,MinMax,ahk_exe Spotify.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
} 
else if WinExist("ahk_exe Spotify.exe")
    WinActivate
else if !WinExist("Spotify")
{
Send, {alt up}#3
Sleep,3000
Winmaximize, Spotify
}
;else
;Send, {alt up}#3
;Sleep, 100
Return

;Run, "C:\Users\mmak\AppData\Roaming\Spotify\Spotify.exe"
;Return

;;;;;;;;;;;;;;;;;

<!LWin::
If !WinExist("Google Keep")
{
Send, {Alt up}#4
Sleep,3000
Winmaximize, Google Keep
}
else
Send, {Alt up}#4
Return

/*

;BACKUP
;If !WinExist("Google Keep")
;KEEP
<!LWin::
if WinActive("Google Keep")
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} 
else if WinExist("Google Keep")
    WinActivate
else
{
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app=https://keep.google.com
Sleep,1000
Winwait, Google keep
WinActivate, Google Keep
Winmaximize, Google Keep
}
Return

*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Cannot use generic function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;CHROME
<!Shift::
SetTitleMatchMode, 1
GroupAdd, notkeep,ahk_class Chrome_WidgetWin_1, , ,Google Keep
if WinActive("ahk_group notkeep")
{
WinGet, num, count,ahk_group notkeep
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinSet, Bottom,, A
WinActivate, ahk_group notkeep
Return
}
}
else if WinExist("ahk_group notkeep")
    WinActivate
else
{	
	Run, chrome.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;EXCEL
<!q:: 
if WinActive("ahk_exe excel.exe")
{
WinGet, num, count,ahk_exe excel.exe
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist("ahk_exe excel.exe")
    WinActivate, ahk_class XLMAIN
else
{	
	Run, excel.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return


;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;Run or Activate functions
;https://autohotkey.com/board/topic/79159-run-application-if-not-active-activate-window-if-active/
;;;;;;;;;;;;;;;;;;;;;;;;;

roa1(WINTITLE, TARGET) {
if WinActive(WINTITLE)
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
}
else if WinExist(WINTITLE)
    WinActivate
else
{	
	Run, %TARGET%,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return
}



;;;;;;;;;;;

roa2(WINTITLE, TARGET) {
if WinActive(WINTITLE)
{
WinGet, num, count,%WINTITLE%
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinSet, Bottom,,%WINTITLE%
WinActivate, %WINTITLE%
Return
}
}
else if WinExist(WINTITLE)
    WinActivate
else
{	
	Run, %TARGET%,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return
}






^!3::roa2("ahk_exe acrord32.exe","acrord32.exe")

;CHROME
!^SHIFT::
SetTitleMatchMode, 1
GroupAdd, notkeep,ahk_class Chrome_WidgetWin_1, , ,Google Keep
roa2("ahk_group notkeep", "chrome.exe")
;chrome is different, can't use generic code

^!q::roa2("ahk_exe excel.exe", "excel.exe") 
;excel is slightly different, can't use generic code
^!a::roa2("ahk_class CabinetWClass", "explorer.exe")
^!c::roa1("ahk_exe filezilla.exe", "filezilla.exe")
^!CapsLock::roa2("ahk_exe firefox.exe", "firefox.exe")
^!d::roa2("ahk_exe notepad.exe", "notepad.exe")
^!2::roa2("ahk_exe outlook.exe", "outlook.exe")
^!w::roa2("ahk_exe powerpnt.exe", "powerpnt.exe")
^!z::roa2("ahk_exe rstudio.exe","rstudio.exe")
^!s::roa1("ahk_exe snippingtool.exe", "snippingtool.exe")
^!§::roa2("ahk_exe winword.exe", "winword.exe")
^!e::roa2("ahk_exe zotero.exe", "zotero.exe")



/*
!#::roa1("ahk_exe .exe", ".exe")
!#::roa2("ahk_exe .exe", ".exe")
*/




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Old functions in alphabetical order
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;ADOBE
<!3::
if WinActive("ahk_exe acrord32.exe")
{
WinGet, num, count,ahk_exe acrord32.exe
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist("ahk_exe acrord32.exe")
    WinActivate
else
{	
	Run, acrord32.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return


;roa2("ahk_exe acrord32.exe","acrord32.exe")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;EXPLORER
<!a::
if WinActive("ahk_class CabinetWClass")
{
WinGet, num, count,ahk_class CabinetWClass
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
} else 
{
WinGetClass, OutputVar , A
WinSet, Bottom,, A
WinActivate, ahk_class %OutputVar%
Sleep, 100
Return
}
}
else if WinExist("ahk_class CabinetWClass")
	WinActivate
else
	Run, explorer.EXE
;Sleep, 10
;Send, {alt up}#e
;Sleep, 300
;Send, {win up}
;Send, {Lwin down}{3 down}{3 up}
;Sleep, 300
;Send, {Lwin up}
Return





;;;;;;;;;;;;;;;;;
;FILEZILLA

<!c::
if WinActive("ahk_exe filezilla.exe")
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} 
else if WinExist("ahk_exe filezilla.exe")
    WinActivate
else
{	
	Run, filezilla.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return


;Run, "C:\Program Files\FileZilla FTP Client\filezilla.exe"
;Return

;;;;;;;;;;;;;;




;FIREFOX
<!CapsLock::
if WinActive("ahk_exe firefox.exe")
{
WinGet, num, count,ahk_exe firefox.exe
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist("ahk_exe firefox.exe")
    WinActivate
else
{	
	Run, firefox.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;NOTEPAD
<!d::
if WinActive("ahk_exe notepad.exe")
{
WinGet, num, count,ahk_exe notepad.exe
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist("ahk_exe notepad.exe")
    WinActivate
else
{	
	Run, notepad.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;OUTLOOK
<!2::
if WinActive("ahk_exe outlook.exe")
{
WinGet, num, count,ahk_exe outlook.exe
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist("ahk_exe OUTLOOK.EXE")
    WinActivate
else
{	
	Run, outlook.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return


;;;;;;;;;;;;;
;POWERPOINT
<!w:: 
if WinActive("ahk_exe powerpnt.exe") 
{
WinGet, num, count,ahk_exe powerpnt.exe
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist("ahk_exe powerpnt.exe")
    WinActivate
else
{	
	Run, powerpnt.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return

;;;;;;;;;;;

;RSTUDIO
<!z::
if WinActive("ahk_exe rstudio.exe")
{
WinGet, num, count,ahk_exe rstudio.exe
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist("ahk_exe rstudio.exe")
    WinActivate
else
{	
	Run, rstudio.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SNIPPING TOOL
<!s:: 
if WinActive("ahk_exe SnippingTool.exe")
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
}
else if WinExist("ahk_exe SnippingTool.exe")
    WinActivate
else
{	
	Run, SnippingTool.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;WORD
<!§:: 
if WinActive("ahk_exe winword.exe")
{
WinGet, num, count,ahk_exe winword.exe
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if WinExist("ahk_exe winword.exe")
    WinActivate
else
{	
	Run, winword.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;ZOTERO
<!e:: 
if (WinActive("ahk_class MozillaWindowClass") && Winactive(ahk_exe zotero.exe))
{
WinGet, num, count, A
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return
}
}
else if (WinExist("ahk_class MozillaWindowClass") && Winactive(ahk_exe zotero.exe))
    WinActivate
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Close active program
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;<!x::
;Send, {Alt up}{pause}{LAlt down}{pause}{F4}{pause}{LAlt up}
;Return

<!x::
WinClose A
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;; Muuta
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;

;BOTTOM ACTIVATE
§::    ; Last window
WinGet, ActiveProcess, ProcessName, A
WinActivateBottom, ahk_exe %ActiveProcess%
return

;;;;;;;;;
;TOP ACTIVATE 
^§::    ; Next window
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return




