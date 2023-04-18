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
; 1 Stata 
; 2 Outlook 
; 3 explorer 
; 4 spotify
; 5 Chrome 
; 6 filezilla
; 7 Google keep 
; The rest won't matter

;2. numlock has to be off


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Unrobust
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Numpad0::
<!CapsLock::
if WinActive("ahk_exe firefox.exe")
{
WinGet, num, count,A
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
    Run, firefox.exe
Return

Numpad1::
<!§:: 
if WinActive("ahk_exe winword.exe")
{
WinGet, num, count,A
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
    Run, winword.exe
Return



Numpad2::
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
    Run, OUTLOOK.EXE
Return

Numpad3::
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
    Run, excel.exe
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Alphabetical
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;Chrome
Numpad4::
<!Shift::
Send, {Alt up}#5
Return



;NB! Unrobust
;explorer
Numpad5::
<!a::
if WinActive("ahk_pid 15520")
{
WinGetClass, ActiveClass, A
WinSet, Bottom,, A
WinActivate, ahk_class %ActiveClass%
return
}
else if WinExist("ahk_pid 15520")
	Winactivate
else
Sleep, 100
Send, #3
Sleep, 100
Return


;NB! Unrobust
Numpad6::
<!LCtrl::
if WinActive("ahk_exe spotify.exe")
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} 
else if WinExist("ahk_exe spotify.exe")
WinActivate
else
Sleep, 100
Send, {alt up}#4
Sleep, 100
Return
;Run, "C:\Users\mmak\AppData\Roaming\Spotify\Spotify.exe"
;Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 7 - 9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Numpad7::
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
    Run, SnippingTool.exe
Return

;Zotero
Numpad8::
<!e:: 
if (WinActive("ahk_class MozillaWindowClass") && Winactive(ahk_exe zotero.exe))
{
WinGet, num, count,A
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
    Run, zotero.exe
Return
;SetTitleMatchMode, 1



;NB! unrobust
Numpad9::
<!c:: 
Send, {Alt up}#6
Sleep, 100
;Run, "C:\Program Files\FileZilla FTP Client\filezilla.exe"
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; additional numpad buttons
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NumpadDot::
<!z::
if WinActive("ahk_exe rstudio.exe")
{
WinGet, num, count,A
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
    Run, rstudio.exe
Return



;NB! unrobust
;keep
NumpadAdd::
<!LWin:: 
Send, {Alt up}#7
Return



NumpadDiv::
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
    Run, notepad.exe
Return


;NumpadMult::
;+NumpadDiv
;+NumpadAdd
;+NumpadMult::
;NumpadEnter:: Reserved for stata (see stata-script for details)
;+NumpadEnter:: Reserved for stata (see stata-script for details)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Additional
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<!w:: 
if WinActive("ahk_exe powerpnt.exe") 
{
WinGet, num, count,A
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
    Run, powerpnt.exe
Return



<!3:: 
if WinActive("ahk_exe acrord32.exe")
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} 
else if WinExist("ahk_exe acrord32.exe")
    WinActivate
else
    Run, acrord32.exe
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Close active program
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NumpadSub::
+NumpadSub::
<!x::
Send, {Alt up}{pause}{LAlt down}{pause}{F4}{pause}{LAlt up}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


Return




