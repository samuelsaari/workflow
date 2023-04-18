;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Workflow for Stata - shortcuts to make life easier with Autohotkey (1/2)
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
;;;;Customize this for yourself by adding your own path and stata flavor (IC, SE, MP & 64/32 bit)
<!1::
if WinActive("ahk_exe StataSE-64.exe") ;NB! 
{
WinGet, num, count,ahk_exe StataSE-64.exe ;NB! 
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
WinGet, List, List, ahk_exe StataSE-64.exe ;NB! 
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
} else if WinExist("ahk_exe StataSE-64.exe") ;NB!
    WinActivate
else
Run, "C:\Program Files (x86)\Stata15\StataSE-64.exe" ;NB! 
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetTitleMatchMode, 1


;;;;;;;;;;;
;DO-FILE

#IfWinExist, Do-file
<#§::
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
<!<:: WinActivate
#IfWinExist, Do-file
<#< Up::WinActivate
<!< Up:: WinActivate
#IfWinExist


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 2. Commands when do-file window is active
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive, Do-file
;;;;Run one line of code
^ENTER::Send {Control down}l{Control up}{pause}^d{down}{Home}
Return

;;;;Run code between braces
!ENTER::Send {Control down}{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{pause}b{Control up}{pause}{pause}{pause}{pause}{pause}^d{down}{Home}
Return

;;;; Run code
+space::Send ^d{down}{Home}
Return

;;;; Run code until current line, NB! this is rather unrobust so you might want to uncomment this
^!b::
Send, exit
Send, ^d
WinActivate,Do-file
Send, {BS}{BS}{BS}{BS}{home}
Return

#IfWinActive



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 3. Commands when stata main window is active
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinExist, Stata
;;;;three slashes
<^7::Send {tab}{/}{/}{/}
;;;; macro
<^$´::Send, {SHIFT DOWN}´{SHIFT UP}'{left} 
;; braces
<^0::Send, {RAlt down}7{RAlt up}{Enter}{Enter}{RAlt down}0{RAlt up}{up} 
#IfWinExist



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;; 4. SHARE-Specific commands for country teams (and SHARE-researchers) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;;;;; Open a module in wave 7 in the public release
; Check https://ideas.repec.org/c/boc/bocode/s458405.html
#IfWinExist, Stata
<^,:: Send, readSHARE *, w(7) mod(){left}
#IfWinExist



; NB! This is only for internal data cleaning purposes, you might want to delete this
#IfWinExist, Stata
<^.:: Send list if pidcom=="",ab(20){left}{left}{left}{left}{left}{left}{left}{left} ; SHARE-specific command
#IfWinExist


;;;; List when pidcom copied from excel. (pastes and executes automatically)
#IfWinActive, Stata
^<:: Send, cls{enter}{pause}{pause}{pause}{pause}list if pidcom==""{left}{Control down}v{Control up}{Backspace}{right},ab(12){Enter}*{Control down}v{Control up}{Backspace}{Enter} 
#IfWinActive



Return

