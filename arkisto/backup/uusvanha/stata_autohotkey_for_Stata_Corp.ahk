;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Keyboard shortcuts for Stata worflow
;;;; Author: Miika Mäki



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 0. Quick Guide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; # = Win-key
;;;; + = Shift
;;;; ^ = Ctrl
;;;; ! = Alt
;;;;
;;;; Complete Guide for hotkeys:	https://autohotkey.com/docs/Hotkeys.htm
;;;;                    	 	https://autohotkey.com/docs/KeyList.htm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;1. Opening Stata-windows with specific keyboard kombinations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Robust way of activating stata (will not launch stata)
#IfWinExist, Stata 
#1:: 
WinActivate
#IfWinExist

;;;;Unrobust way which includes launching stata
;;;;Custumize this for yourself by adding your own path
+NumpadEnter::
NumpadEnter:: 
if WinExist("Stata")
    WinActivate
else
Run, "C:\Program Files (x86)\Stata15\StataSE-64.exe"
Return

SetTitleMatchMode, 1
#IfWinExist, Do-file
LWin & ~§:: WinActivate
NumpadIns:: WinActivate
#IfWinExist

#IfWinExist, Data Editor
#q:: WinActivate 
NumpadEnd:: WinActivate
#IfWinExist

#IfWinExist, Viewer
#a:: WinActivate
NumpadDown:: WinActivate
#IfWinExist

#IfWinExist, Graph
#z:: WinActivate 
NumpadPgDn:: WinActivate
#IfWinExist

;;;;activate first stata,then do-file
#IfWinExist, Stata
#<:: WinActivate
NumpadDel:: WinActivate
#IfWinExist, Do-file
#< Up::WinActivate
NumpadDel Up:: WinActivate
#IfWinExist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 2. Commands when do-file window is active
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Do-file
;;;;Run one line of code
^ENTER::Send {Control down}l{Control up}{pause}^d{down}{Home}

;;;;Run code between braces. You can have between 1 and 15 braces and this code will run everything that is inbetween those braces
^+ENTER::Send {Control down}{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{Control up}{pause}{pause}{pause}{pause}{pause}^d{down}{Home}

;;;; Run code
+space::Send ^d{down}{Home}
#IfWinActive


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 3. Commands when stata main window is active
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinExist, Stata
;;;;three slashes
!7::Send {space}{/}{/}{/}
#IfWinExist




Return