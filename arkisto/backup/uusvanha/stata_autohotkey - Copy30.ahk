;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Keyboard shortcuts for Stata worflow
;;;; Author: Miika M�ki



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
;;;;1. Opening Stata-windows with specific keyboard kombinations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Robust way of activating stata (will not launch stata)
#IfWinExist, Stata
<#CapsLock:: 
WinActivate
#IfWinExist
Return

;;;;Unrobust way which includes launching stata
;;;;Custumize this for yourself by adding your own path
<!1::
if WinActive("ahk_exe StataSE-64.exe")
{
WinGet, num, count,ahk_exe StataSE-64.exe
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
} else if WinExist("ahk_exe StataSE-64.exe")
    WinActivate
else
Run, "C:\Program Files (x86)\Stata15\StataSE-64.exe"
Return

;;;;;;;;;;;;

SetTitleMatchMode, 1
#IfWinExist, Do-file
<#�:: WinActivate
NumpadIns:: WinActivate
#IfWinExist

#IfWinExist, Data Editor
<#q:: WinActivate 
NumpadEnd:: WinActivate
#IfWinExist

#IfWinExist, Viewer
<#a:: WinActivate
NumpadDown:: WinActivate
#IfWinExist

#IfWinExist, Graph
<#z:: WinActivate 
NumpadPgDn:: WinActivate
#IfWinExist

;;;;activate first stata,then do-file
#IfWinExist, Stata
<#<:: WinActivate
NumpadDel:: WinActivate
<!<:: WinActivate
#IfWinExist, Do-file
<#< Up::WinActivate
NumpadDel Up:: WinActivate
<!< Up:: WinActivate
#IfWinExist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 2. Commands when do-file window is active
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Do-file
;;;;Run one line of code
^ENTER::Send {Control down}l{Control up}{pause}^d{down}{Home}

;;;;Run code between braces
!ENTER::Send {Control down}{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{Control up}{pause}{pause}{pause}{pause}{pause}^d{down}{Home}

;;;; Run code
+space::Send ^d{down}{Home}
#IfWinActive


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 3. Commands when stata main window is active
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinExist, Stata
;;;;three slashes
<!7::Send {space}{/}{/}{/}
<^�::Send, +�'{left}
<^�::Send, {RAlt down}7{RAlt up}{Enter}{Enter}{RAlt down}7{RAlt up}{up}
#IfWinExist



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;; 4. SHARE-Specific commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


#IfWinExist, Stata
^�:: Send list if pidcom=="",ab(20){left}{left}{left}{left}{left}{left}{left}{left} ; SHARE-specific command
#IfWinExist


;;;; List when pidcom copied from excel. (pastes and executes automatically)
#IfWinActive, Stata
^<:: Send, cls{enter}{pause}{pause}{pause}{pause}list if pidcom==""{left}{Control down}v{Control up}{Backspace}{right},ab(12){Enter}*{Control down}v{Control up}{Backspace}{Enter} 
#IfWinActive





Return