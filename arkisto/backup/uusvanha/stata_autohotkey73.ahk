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

<#CapsLock:: 
If (WinActive("Stata") && WinExist("Do-file"))
{
	WinActivate,Do-file
	Return
}
else if WinActive("Stata")
	WinMinimize
else if WinExist("Stata")
{
	WinActivate, Stata
	Return
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;Unrobust way which includes launching stata and toggling/minimizing stata window(s)
;;;;Customize this for yourself by adding your own path
<!1::
NumpadDel::
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
Return
} else 
{
WinGet, List, List, ahk_exe StataSE-64.exe
Loop, %List%
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return
}
} else if WinExist("ahk_exe StataSE-64.exe")
    WinActivate
else
Run, "C:\Program Files (x86)\Stata15\StataSE-64.exe"
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetTitleMatchMode, 1


;;;;;;;;;;;
;DO-FILE

#IfWinExist, Do-file
<#�::
<#SHIFT::
If (WinActive("Do-file") && WinExist("Stata"))
{
	WinActivate,Stata
	Return
}
else if WinExist("Do-file")
{
	WinActivate, Do-file
	Return
}
Return


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
<^�::Send, {RAlt down}7{RAlt up}{Enter}{Enter}{RAlt down}0{RAlt up}{up}
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