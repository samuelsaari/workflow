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
#IfWinActive, ahk_class MozillaDialogClass
;Suppress Author
$^å::send, 
(
{Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}
)

#IfWinActive


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
; 4 Google keep 
; 5 spotify 
; 6 filezilla 
; The rest won't matter

;2. numlock has to be off


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 0-3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Numpad0::
<!CapsLock::
if WinExist("ahk_exe firefox.exe")
    WinActivate
else
    Run, firefox.exe
Return

Numpad1::
<!§:: 
if WinExist("ahk_exe winword.exe")
    WinActivate
else
    Run, winword.exe
Return

Numpad2::
<!2::
if WinExist("ahk_exe OUTLOOK.EXE")
    WinActivate
else
    Run, OUTLOOK.EXE
Return

Numpad3::
<!q:: 
if WinExist("ahk_exe excel.exe")
    WinActivate, ahk_class XLMAIN
else
    Run, excel.exe
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 4-6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;if WinExist("Google Keep")
;   WinActivate,ahk_exe chrome.exe,,Google Keep

;toimii
;if WinActive("ahk_exe chrome.exe")
;{
;WinMinimize,ahk_exe chrome.exe,,Google Keep
;Return
;}
;else if

Numpad4::
<!Shift::
if (WinActive("ahk_exe chrome.exe") && WinExist("Google Keep"))
	WinMinimize,ahk_exe chrome.exe,,Google Keep
else if WinActive("ahk_exe chrome.exe")
{
	WinMinimize
Return
}
else if (WinExist("ahk_exe chrome.exe") && WinExist("Google Keep")) 
	WinActivate,ahk_exe chrome.exe,,Google Keep
else if WinExist("ahk_exe chrome.exe")
	WinActivate
else
    Run, chrome.exe
Return


;NB! Unrobust
;explorer
Numpad5::
<!<a::
Send, {Alt up}#3
Sleep, 100
Return


;NB! Unrobust
Numpad6::
<!LCtrl::
if WinExist("ahk_exe spotify.exe")
WinActivate
else
Send, {Alt up}#5
Sleep, 100
Return
;Run, "C:\Users\mmak\AppData\Roaming\Spotify\Spotify.exe"
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 7 - 9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Numpad7::
<!s:: 
if WinExist("ahk_exe SnippingTool.exe")
    WinActivate
else
    Run, SnippingTool.exe
Return

Numpad8::
<!e:: 
if WinExist("ahk_exe zotero.exe")
    WinActivate
else
    Run, zotero.exe
Return

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
if WinExist("ahk_exe rstudio.exe")
    WinActivate
else
    Run, rstudio.exe
Return

;NB! unrobust
NumpadAdd::
<!LWin:: 
if WinExist("Google Keep")
    WinActivate
else
Send, {Alt up}#4
Return

NumpadDiv::
<!d::
if WinExist("ahk_exe notepad.exe")
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
if WinExist("ahk_exe powerpnt.exe")
    WinActivate
else
    Run, powerpnt.exe
Return


<!3:: 
if WinExist("ahk_class acrobatsdiwindow")
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




