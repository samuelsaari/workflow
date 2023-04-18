

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Windows workflow
;;;; Author: Miika M�ki

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 0. Quick Guide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 0. General Windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Matrix multiplication in Rstudio - shorcut for %*%
#IfWinActive ahk_exe rstudio.exe
<!'::
Send,{SHIFT DOWN}5'5{SHIFT UP}
Return
#IfWinActive

;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;1. Zotero & Word & other microsoft applications
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;plainpaste microsoft office
#If (WinActive("ahk_exe outlook.exe") or WinActive("ahk_exe winword.exe"))
$^$+$v::
Send, {Control down}{Alt down}v{Control up}{Alt up}{pause}{pause}{pause}{pause}{pause}{down}{pause}{enter}
Return
#IfWinActive

#IfWinActive ahk_exe powerpnt.exe
$^$+$v::
Send, {Control down}{Alt down}v{Control up}{Alt up}{pause}{pause}{pause}{pause}{pause}{tab}{pause}{down}{down}{pause}{enter}
Return
#IfWinActive


;; Saving references to Zotero in firefox 

#IfWinActive, ahk_exe firefox.exe
^+s::
If Winexist("ahk_exe zotero.exe")
{
Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
}
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	Sleep, 500
	WinActivate, ahk_exe firefox.exe
	Sleep, 200
	Send, {Ctrl down}{Shift down}s{pause}{Shift up}{Ctrl up}
}
Return
#IfWinActive
*/

;;;;;;;;;;;;;;;;;;;;;;;


;Suppress Author in word (Zotero)
If WinActive("Quick Format Citation")
{
send, 
(
{Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}
)
Return
}


; Activate Quick format citation under certain conditions with Alt & r or suppress the author
If !WinActive("Quick Format Citation") && WinExist("Quick Format Citation") && !WinActive("ahk_class OpusApp")
<!r::
{
WinActivate, Quick Format Citation
Return
}


;; -  Making word do Zotero related stuff with Ctrl & � - NB! change this to your key of liking
$^�::
If !WinActive("Quick Format Citation") && WinActive("ahk_class OpusApp") && Winexist("Zotero")
{
Send, ^!j ; this only works with the word macro (see the VBA script file)
Return
}
If !WinExist("Quick Format Citation") && WinActive("ahk_class OpusApp") && !Winexist("Zotero")
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	Sleep, 500
	WinActivate, ahk_class OpusApp
	Sleep, 200
	Send, ^!j
	Return
}
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; WORKAROUNDS FOR WORD THAT DOES NOT HAVE SPECIAL CHARACTERS OR SCANDINAVIAN LETTERS AS wdKeys
; NB! You need the VBA code for these to work


;ZoteroAddEditBibliography_SC
; press ctrl + Shift + B (built in in word)




;Refresh bibliography
;note that word's own ctrl/shift/r works
#IfWinActive, ahk_exe winword.exe
$^+�::
Send, ^!r
Return
#IfWinActive



;Make paragraph green
; selecthighlight_SC
#IfWinActive, ahk_exe winword.exe
$^�::
Send, ^!l
Return
#IfWinActive



;Remove color from paragraph
;selecthighlightR_SC
#IfWinActive, ahk_exe winword.exe
$^�::
Send, ^!k
Return
#IfWinActive


;Select paragraph
;Normal_selectSC
#IfWinActive, ahk_exe winword.exe
$^�::
Send, ^!p
Return
#IfWinActive


;Select paragraph, make normal
;Normal_selectSC
#IfWinActive, ahk_exe winword.exe
$^'::
Send, ^!i
Return
#IfWinActive


SetTitleMatchMode, 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 2. Close active program
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#IfWinNotActive, Program Manager ;this, and following prevents windows from getting rid of desktop items
#IfWinNotActive, "" 
#IfWinNotActive, ahk_class WorkerW
<!ESC::
WinClose A
Return
#IfWinNotActive

/*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
;;;; 3. TOGGLE WINDOWS OF ACTIVE PROGRAM - currently not in use
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;
;;;; Credit and simplified version of the functions
;https://autohotkey.com/board/topic/79159-run-application-if-not-active-activate-window-if-active/


;PREVIOUS WINDOW
�::    
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
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

;;;;;;;;; 
;Send to bottom
^�::    
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return

*/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;;;; 4. OTHER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;NB! 
;Larger and smaller than with an american keyboard with Scandinavian settings

#,::
Send, <
Return


#.::
Send, >
Return






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; X.0 Windows run or activate commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for everything to work, 

;X.1.you will have to pin programs to the taskbar in the following order.
; If you dont have, say stata installed, just make sure that the rest of the programs are 2nd, 3rd..."nth" in the taskbar
; These are programs are the ones that do not work in a robust way (see the script below)
; (1 Stata)
; (2 Outlook)
; 3 spotify 
; 4 keep
; The rest won't matter (spotify & keep are actually the only truly unrobust oneS, I just prefer having Stata & Outlook...
; ...as the 1st and 2nd in the taskbar as the build in function Win + (1 or 2) works quite nicely together with...
; ...the hotkeys I have assigned for Stata and Outlook.



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; X.2 Unrobust way of playing around with application windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
Send, {alt up}#3 ;Spotify has to be the 3rd window in the taskbar
Sleep, 3000
Winmaximize, Spotify
}
;else
;Send, {alt up}#3
;Sleep, 100
Return

;;;;;;;;;;;;;;;;;

<!LWin::
If !WinExist("Google Keep")
{
Send, {Alt up}#4
Sleep,2500
Winmaximize, Google Keep
}
else
Send, {Alt up}#4 // Google keep has to be the 4th window in the taskbar
Return
; For more info, see http://www.rawinfopages.com/tips/2016/11/run-google-keep-on-the-desktop-in-its-own-window/


;NB! 
;CASE CONTROL - only for CaseCtrl, which is not available to the public
<!x:: 
if (WinActive("ahk_exe Dep.exe"))
{
WinGet,WinState,MinMax,ahk_exe Dep.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
}
if (WinActive("ahk_exe BlaiseCaseControl.exe") && !WinExist("ahk_exe Dep.exe")) 
{
WinGet,WinState,MinMax, ahk_exe BlaiseCaseControl.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
}
if (WinActive("ahk_exe BlaiseCaseControl.exe") && WinExist("ahk_exe Dep.exe")) 
	{
	WinActivate, ahk_exe Dep.exe
	Return
	}
else if (WinExist("ahk_exe Dep.exe") && WinExist("ahk_exe BlaiseCaseControl.exe"))
	{
    	WinActivate, ahk_exe Dep.exe
	Return
	}
else if WinExist("ahk_exe BlaiseCaseControl.exe")
	Winactivate
else
{	
	Run, "C:/ProgramData/CentERdata/SHARE_CASE_CTRL_W8_2/casectrl/BlaiseCaseControl.exe",,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return


/*
; code backup
;Case Control
<!c::roa("ahk_exe BlaiseCaseControl.exe",  "BlaiseCaseControl.exe")
;Capi
<!x::roa("ahk_exe Dep.exe",  "Dep.exe")
*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; X.3. Robust, but cannot use generic function  (see below for "X.4. Run or Activate functions or roa" )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;CHROME
<!Shift::
SetTitleMatchMode, 1
GroupAdd, notkeep,ahk_exe chrome.exe, , ,Google Keep
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
GroupActivate, notkeep, R
Return
}
}
else if WinExist("ahk_group notkeep")
    WinActivate
else
{	
	Run, chrome.exe
	WinWait, ahk_group notkeep
	WinActivate, ahk_group notkeep
}
Return


;Firefox
<!CapsLock::
SetTitleMatchMode, 1
GroupAdd, firefox,ahk_exe firefox.exe, , ,Quick Format Citation
GroupAdd, firefox, ahk_class MozillaWindowClass, , , ,ahk_exe zotero.exe
if WinActive("ahk_group firefox")
{
WinGet, num, count,ahk_group firefox
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
GroupActivate, FIREFOX, R
Return
}
}
else if WinExist("ahk_group firefox")
    WinActivate
else
{	
	Run, firefox.exe
	WinWait, ahk_group firefox
	WinActivate, ahk_group firefox
}
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;opera
<!d::
GroupAdd, opera, ahk_exe opera.exe, , , ,Google Keep
;GroupAdd, opera, ahk_class Chrome_WidgetWin_1, , , ,ahk_exe chrome.exe
if WinActive("ahk_group opera")
{
WinGet, num, count,ahk_group opera
if num=1 
{
WinGet,WinState,MinMax,A
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
GroupActivate, opera, R
Return
}
}
else if WinExist("ahk_group opera")
    WinActivate
else
{	
	Run, opera.exe
	WinWait, ahk_group opera
	WinActivate, ahk_group opera
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
WinGet,WinState,MinMax,ahk_exe excel.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinSet, Bottom,,ahk_exe excel.exe
WinActivate, ahk_exe excel.exe
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
Groupadd, toggle_explorer,ahk_class CabinetWClass
GroupActivate, toggle_explorer,R
Sleep, 100
Return
}
}
else if WinExist("ahk_class CabinetWClass")
	WinActivate
else
	Run, explorer.EXE
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SetTitleMatchMode, 3
;ZOTERO
<!e:: 
if (WinActive("ahk_exe zotero.exe") && WinExist("Quick Format Citation"))
	{
	WinActivate, Quick Format Citation
	Return
	}
if (WinActive("ahk_exe zotero.exe") && !WinExist("Quick Format Citation"))
{
WinGet,WinState,MinMax,ahk_exe zotero.exe
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
}
if (WinActive("Quick Format Citation") && WinExist("ahk_exe zotero.exe")) 
	{
	WinActivate, ahk_exe zotero.exe
	Return
	}
else if (WinExist("ahk_exe zotero.exe") && WinExist("Quick Format Citation"))
	{
    	WinActivate, ahk_exe zotero.exe
	Return
	}
else if WinExist("ahk_exe zotero.exe")
	Winactivate
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return
;SetTitleMatchMode, 1




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;photos & snipping
<!c:: 
if WinActive("Photos")
{
WinGet, num, count,Photos
if num=1 
{
WinGet,WinState,MinMax,Photos
If WinState = -1
   WinMaximize
else
   WinMinimize
} else 
{
WinSet, Bottom,,Photos
WinActivate, Photos
Return
}
}
else if WinExist("Photos ahk_exe ApplicationFrameHost.exe")
    WinActivate
else
{
Run, ms-screenclip:?source=QuickActions,,,OutputVarPID ;snip&sketch
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SnippingTool
<!s::
{
	if WinExist("Snip & Sketch ahk_class ApplicationFrameWindow")
		if WinActive()
			WinMinimize
		else
			WinActivate
	else
		Run ms-screenclip:?source=QuickActions
	return
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;notepad++

<!m::
{
	if WinExist("ahk_class Notepad++")
		if WinActive()
			WinMinimize
		else
			WinActivate
	else
		Run notepad++.exe
	return
}

;Activate or minimize save
<!�::
{
	if WinExist("Save As")
		if WinActive()
			WinMinimize
		else
			WinActivate
	return
}



; sources
;https://www.intowindows.com/create-screen-sketch-snip-desktop-shortcut-in-windows-10/
;https://www.autohotkey.com/boards/viewtopic.php?t=13818

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;X.4 Run or Activate function or roa 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Credit and simplified version of the functions
;https://autohotkey.com/board/topic/79159-run-application-if-not-active-activate-window-if-active/

; RUN OR ACTIVATE PROGRAM THAT HAS ONE OR MORE WINDOWS IN EXISTENCE
roa(WINTITLE, TARGET) 
{
if !Winexist(WINTITLE)
	{	
	Run, %TARGET%,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
	Return
	}
		if WinExist(WINTITLE) && !WinActive(WINTITLE)
		{
		WinActivate, %WINTITLE%
		Return
		}
if WinActive(WINTITLE)
	{
	WinGet, num, count,%WINTITLE%
		if num=1 
		{
		WinGet,WinState,MinMax,%WINTITLE%
		If WinState = -1
		WinMaximize
		else
		WinMinimize
		Return
		} else
			{
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
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
	}
Return
}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;USING THE ABOVE FUNCTIONS TO CALL DIFFERENT APPS
<!3::roa("ahk_exe acrord32.exe","acrord32.exe") ;ADOBE READER
Return
<!f::roa("ahk_exe filezilla.exe", "filezilla.exe")
Return
;<!CapsLock::roa("ahk_class MozillaWindowClass ahk_exe firefox.exe", "firefox.exe")
Return
<!n::roa("ahk_exe notepad.exe", "notepad.exe")
Return
<!2::roa("ahk_exe outlook.exe", "outlook.exe")
Return
<!w::roa("ahk_class PPTFrameClass", "powerpnt.exe")
Return
<!z::roa("ahk_exe rstudio.exe","rstudio.exe")
Return
<!�::roa("ahk_exe winword.exe", "winword.exe") ; WORD
Return








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; X WORK IN PROGRESS
/*
#EI TOIMI
EXCEL TOGGLE (nyt menee pohjalle)


#OPTIONAL
ZOTERO ahk_groupilla funktioon ja chromen tapaan funktioon
KEEP robustiksi
Explorer funktioon?

Mieti, miten p�rj�� sen kanssa, ett� eri koneilla .exe-tiedosto eri kansioissa (if-funktio)
--Spotify robustiksi
--Stata robustiksi

*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; Y. BACKUP CODE;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
