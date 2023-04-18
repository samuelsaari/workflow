 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Keyboard shortcuts for Stata worflow
;;;; Author: Miika Mäki
;;;; Quide for hotkeys: https://autohotkey.com/docs/Hotkeys.htm
;;;;                    https://autohotkey.com/docs/KeyList.htm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;1. Opening Stata-windows with specific keyboard kombinations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Robust way of activating stata (will not launch stata)
#IfWinExist, Stata 
#1:: WinActivate
#IfWinExist

;;;;Unrobust way which includes launching stata (requires that stata is the first window in the taskbar)
NumpadDel:: 
if WinExist("Stata")
    WinActivate
else
Send, {Lwin down}{1 down}
Sleep, 100
Send,{1 up}{Lwin up}
Return

SetTitleMatchMode, 1
#IfWinExist, Do-file
LWin & ~§:: WinActivate 
#IfWinExist

#IfWinExist, Data Editor
#q:: WinActivate 
#IfWinExist

#IfWinExist, Viewer
#a:: WinActivate 
#IfWinExist

#IfWinExist, Graph
#z:: WinActivate 
#IfWinExist

;;;;activate first stata,then do-file
#IfWinExist, Stata
#<:: WinActivate
#IfWinExist, Do-file
#< Up::WinActivate
#IfWinExist


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 2. Commands when do-file window is active
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Do-file
;;;;Run one line of code
^ENTER::Send {Control down}l{Control up}{pause}^d{down}{Home}

;;;;Run code between braces
^ä::Send {Control down}{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{Control up}{pause}{pause}{pause}{pause}{pause}^d{down}{Home}

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;; 4. SHARE-Specific commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


#IfWinExist, Stata
^¨:: Send list if pidcom=="",ab(12){left}{left}{left}{left}{left}{left}{left}{left} ; SHARE-specific command
#IfWinExist


;;;; List when pidcom copied from excel. (pastes and executes automatically)
#IfWinActive, Stata
^<:: Send, cls{enter}{pause}{pause}{pause}{pause}list if pidcom==""{left}{Control down}v{Control up}{Backspace}{right},ab(12){Enter}*{Control down}v{Control up}{Backspace}{Enter} 
#IfWinActive





Return