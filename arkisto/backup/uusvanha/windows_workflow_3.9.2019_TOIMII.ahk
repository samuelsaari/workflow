

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Windows workflow
;;;; Author: Miika Mäki

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

;;; 0.TO DO
/*
#EI TOIMI
EXCEL TOGGLE (nyt menee pohjalle)



#OPTIONAL
ZOTERO ahk_groupilla funktioon ja chromen tapaan funktioon
KEEP robustiksi
Explorer funktioon?

Mieti, miten pärjää sen kanssa, että eri koneilla .exe-tiedosto eri kansioissa (if-funktio)
--Spotify robustiksi
--Stata robustiksi

*/


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


/*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SetTitleMatchMode, 3
;ZOTERO PLUGIN HOTKEYS
#IfWinActive, Quick Format Citation
;Suppress Author
$^å::
$!j::
send, 
(
{Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}
)
#IfWinActive
Return


;OBS! saattaa aiheuttaa ongelmia (#if-rakenne)
;Aktivoi sitaattihomma, jos sitaattihomma tai word ei aktiivinen
#If (!WinActive("Quick Format Citation") && !WinActive("ahk_class OpusApp"))
#IfWinExist, Quick Format Citation
$^å::
<!r::
WinActivate, Quick Format Citation
#IfWinNotActive
#IfWinExist
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/


;; Saving references to Zotero in firefox - a very unrobust hack that works on my work computer. Basicly waiting for Zotero to come up with a build in solution
#IfWinActive, ahk_class MozillaWindowClass
^+s::
If Winexist("Zotero")
{
Click, 1230, 60
Mousemove, 600, 300
}
else
{	
	Run, zotero.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	Sleep, 500
	WinActivate, ahk_exe firefox.exe
	Sleep, 200
	Click, 1230, 60
	Mousemove, 600, 300
}
Return
#IfWinActive


;;;;;;;;;;;;;;;;;;;;;;;

;WORD WORKAROUND
;; -  Making word do Zotero related stuff with Ctrl & å - NB! change this to your key of liking
$^å::
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
; Activate Quick format citation under certain conditions with Alt & r or suppress the author
If !WinActive("Quick Format Citation") && WinExist("Quick Format Citation") && !WinActive("ahk_class OpusApp")
<!r::
{
WinActivate, Quick Format Citation
Return
}
;Suppress Author
If WinActive("Quick Format Citation")
{
send, 
(
{Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}
)
Return
}
Return

;;;;;;;;;;;;;;;;;;;;;;


; WORKAROUND FOR WORD THAT DOES NOT HAVE SPECIAL CHARACTERS OR SCANDINAVIAN LETTERS AS wdKeys
; NB! You need the VBA code for these to work


;ZoteroAddEditBibliography_SC
; paina ctrl + Shift + B (valmiiksi wordissa)




;Refresh bibliography
;huomaa, että myös wordin oma ctrl/shift/r toimii
#IfWinActive, ahk_exe winword.exe
$^+å::
Send, ^!r
Return
#IfWinActive



;Make paragraph green
; selecthighlight_SC
#IfWinActive, ahk_exe winword.exe
$^ö::
Send, ^!l
Return
#IfWinActive



;Remove color from paragraph
;selecthighlightR_SC
#IfWinActive, ahk_exe winword.exe
$^ä::
Send, ^!k
Return
#IfWinActive


;Select paragraph
;Normal_selectSC
#IfWinActive, ahk_exe winword.exe
$^¨::
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

;PREVIOUS WINDOW
§::    
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
^§::    
WinGet, ActiveProcess, ProcessName, A
WinSet, Bottom,, A
WinActivate, ahk_exe %ActiveProcess%
Return

*/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;;;; 4. OTHER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SUUREMPI JA PIENEMPI MERKIT JENKKINÄPPÄIMISTÖLLÄ (SUOMEN ASETUKSILLA)

#,::
Send, <
Return


#.::
Send, >
Return

/*
;LAKIMERKKI
^!§::Send,§
Return
*/







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for everything to work, 

;1.you will have to pin programs to the taskbar in the following order.
; If you dont have, say stata installed, just make sure that the rest of the programs are 2nd, 3rd..."nth" in the taskbar
; These are programs are the ones that do not work in a robust way (see the script below)
; (1 Stata)
; (2 Outlook)
; 3 spotify 
; 4 keep
; The rest won't matter (spotify & keep are actually the only truly unrobust oneS, I just prefer having Stata & Outlook...
; ...as the 1st and 2nd in the taskbar as the build in function Win + (1 or 2) works quite nicely together with...
; ...the hotkeys I have assigned for Stata and Outlook.

;2. numlock has to be off


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; X.1 Unrobust way of playing around with application windows
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

;Run, "C:\Users\mmak\AppData\Roaming\Spotify\Spotify.exe"
;Return

;;;;;CODE BACKUP

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
Sleep,2500
Winmaximize, ahk_exe Spotify.exe
}
Return
*/


;;;;;;;;;;;;;;;;;

<!LWin::
If !WinExist("Google Keep")
{
Send, {Alt up}#4
Sleep,2500
Winmaximize, Google Keep
}
else
Send, {Alt up}#4
Return


/*
;CODE BACKUP
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;CASE CONTROL
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
;;;; X.2. Robust, but cannot use generic function  (see below for "2.3. Run or Activate functions or roa" )
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

;OBS, create a function for firefox and chrome!!!!!
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
GroupActivate, firefox, R
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


/*
Groupadd, toggle_excel,ahk_exe excel.exe
GroupActivate, toggle_excel,R

Run, excel.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;WinGetClass, OutputVar , A
;WinSet, Bottom,, A
;WinActivate, ahk_class %OutputVar%
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
;Sleep, 10
;Send, {alt up}#e
;Sleep, 300
;Send, {win up}
;Send, {Lwin down}{3 down}{3 up}
;Sleep, 300
;Send, {Lwin up}
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SetTitleMatchMode, 3
;ZOTERO
<!e:: 
if (WinActive("Zotero") && WinExist("Quick Format Citation"))
	{
	WinActivate, Quick Format Citation
	Return
	}
if (WinActive("Zotero") && !WinExist("Quick Format Citation"))
{
WinGet,WinState,MinMax,Zotero
If WinState = -1
   WinMaximize
else
   WinMinimize
Return
}
if (WinActive("Quick Format Citation") && WinExist("Zotero")) 
	{
	WinActivate, Zotero
	Return
	}
else if (WinExist("Zotero") && WinExist("Quick Format Citation"))
	{
    	WinActivate, Zotero
	Return
	}
else if WinExist("Zotero")
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Edge ;; NB! Does not work properly
/*
{
	if WinExist("ahk_class ApplicationFrameWindow")
		if WinActive()
			WinMinimize
		else
			WinActivate
	else
		{
		Send,{Lwin}{pause}edge{pause}{Enter}
		Return
		}
	return
}


		Send, {Lwin}{pause}edge{pause}{Enter}
		Send, {Lwin Down}r{LWin up}{pause}microsoft-edge:
		microsoft-edge:?source=QuickActions
		%windir%\explorer.exe shell:Appsfolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge
		%windir%\explorer.exe microsoft-edge:
		
*/


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

; sources
;https://www.intowindows.com/create-screen-sketch-snip-desktop-shortcut-in-windows-10/
;https://www.autohotkey.com/boards/viewtopic.php?t=13818

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;
;opera
<!d::
<!o::
if WinActive("ahk_exe opera.exe")
{
	WinGet, num, count,ahk_exe opera.exe
		if num=1 
		{
		WinGet,WinState,MinMax,ahk_exe opera.exe
		If WinState = -1
		   WinMaximize
		else
		   WinMinimize
	} else 
	{
	WinSet, Bottom,, ahk_exe opera.exe
	WinActivate, ahk_exe opera.exe
	}
}
else if WinExist("ahk_exe opera.exe")
    WinActivate
else
{	
	Run, opera.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return

;opera2
<!u::
{
if !Winexist("ahk_exe opera.exe")
	{	
	Run, opera.exe,,,OutputVarPID
	WinWait, ahk_pid OutputVarPID
	WinActivate, ahk_pid OutputVarPID
	Return
	}
		if WinExist("ahk_exe opera.exe") && !WinActive("ahk_exe opera.exe")
		{
		WinActivate, ahk_exe opera.exe
		Return
		}
if WinActive("ahk_exe opera.exe")
	{
	WinGet, num, count,ahk_exe opera.exe
		if num=1 
		{
		WinGet,WinState,MinMax,ahk_exe opera.exe
		If WinState = -1
		WinMaximize
		else
		WinMinimize
		Return
		} else
			{
;WinGetClass, ActiveClass, A
WinGet, WinExeCount, Count, ahk_exe opera.exe
IF WinExeCount = 1
    Return
Else
WinGet, List, List,  ahk_exe opera.exe
Loop,  List
{
    index := List - A_Index + 1
    WinGet, State, MinMax,  "ahk_id " Listindex
    if (State <> -1)
    {
        WinID := Listindex
        break
    }
}
WinActivate,  "ahk_id " WinID
return
			}
	}
Return
}



/*
;;;;;;;;;;;;;;;;;;;;;;
;opera
<!p::
if WinActive("ahk_exe opera.exe")
{
WinGet,WinState,MinMax,ahk_exe opera.exem
If WinState = -1
   WinMaximize
else
   WinMinimize
}
else if WinExist("ahk_exe opera.exe")
    WinActivate
else
{	
	Run, opera.exe,,,OutputVarPID
	WinWait, ahk_pid %OutputVarPID%
	WinActivate, ahk_pid %OutputVarPID%
}
Return
*/






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;2.3 Run or Activate functions or roa (robust)
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
;Case CTRL - cannot use generic code
; chrome - cant use generic code
; excel - cant use generic code

<!f::roa("ahk_exe filezilla.exe", "filezilla.exe")
Return
;<!CapsLock::roa("ahk_class MozillaWindowClass ahk_exe firefox.exe", "firefox.exe")
Return
;keep - cant use generic code
<!n::roa("ahk_exe notepad.exe", "notepad.exe")
Return

<!2::roa("ahk_exe outlook.exe", "outlook.exe")
Return
<!w::roa("ahk_class PPTFrameClass", "powerpnt.exe")
Return
<!z::roa("ahk_exe rstudio.exe","rstudio.exe")
Return

;spotify - cant use generic code
;stata - see seperate file
<!§::roa("ahk_exe winword.exe", "winword.exe") ; WORD
;zotero - cant use generic code
; C - enter your tempoary program in here


;SetTitleMatchMode,3
;<!c::roa("Photos", "snippingtool.exe") ; activate photo viewer or launch snippingtool
;SetTitleMatchMode,1
;<!c::roa("ahk_exe ApplicationFrameHost.exe", "snippingtool.exe") ; activate photo viewer or launch snippingtool
;Enter your tempoary program in here
;<!f::roa("ahk_exe YOURPROGRAM.exe", "YOURPROGRAM.exe") ; activate photo viewer or launch snippingtool
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; BACKUP CODE;;;;;;;;;;;;;;;;;;;;;;;;
/*
!#::roa1("ahk_exe .exe", ".exe")
!#::roa2("ahk_exe .exe", ".exe")

;CHROME
!^SHIFT::
SetTitleMatchMode, 1
GroupAdd, notkeep,ahk_class Chrome_WidgetWin_1, , ,Google Keep
roa("ahk_group notkeep", "chrome.exe")

^!q::roa("ahk_exe excel.exe", "excel.exe") 
;<!a::roa("ahk_class CabinetWClass", "explorer.exe") ; FILE EXPLORER

;RUN OR ACTIVATE PROGRAM WITH THAT HAS THE MAXIMUM OF 1 WINDOW
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

ToggleActivate(OTSIKKO) {
Groupadd, toggle_group, %OTSIKKO%
GroupActivate, toggle_group,R
Return
}

*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
















































;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Y. Old functions in alphabetical order
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/*


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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







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

*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



