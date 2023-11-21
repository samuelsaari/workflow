
; Preliminaries
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
Global UserProfile ; Make userprofile a global variable
EnvGet, UserProfile, UserProfile ; Get userprofile from system variables

; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Private autohotkeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;
;; Semi-private ;;
;;;;;;;;;;;;;;;;;;;;

#InputLevel 1

;;---------------------------------------------
;General

;;-----------------------
;Software specific

;;-----------------------
;-------TEXCOUNT-------
#IfWinActive, ahk_exe cmd.exe
<^<!c::
Send, texcount -inc -total 3Manuscript_Outcomes.tex ; Change the file
Return
#IfWinActive

;REFERENCE MISSING
;reference missing / add reference later



{
<^<!g::
Send,{(}{!}{!}{!}REF{)}
Return
}


; Z kansio
<^<!z::
Send,\\jakovl2012\users\mmak
Return

/*
;TIETOKONE MENEE JUNTTURAAN
;Teams mic toggle
#IfWinActive, ahk_exe teams.exe
SPACE::Send,{Ctrl down}{Space down}
SPACE Up::Send,{Space Up}{Ctrl Up}
Return
#IfWinActive
*/


;;-------------------------------------------------------------------
;Software specific

#IfWinActive ahk_exe cmd.exe
<^+c::Send,cd C:\Users\mmak\OneDrive\Tilasto\tikape\tasks
Return
/*
<^s::
Send,cses-cli submit -c tira22s .py{left}{left}{left}
Return
*/
#IfWinActive

#IfWinActive, ahk_exe code.exe
	^+,::Send,db.execute(f''''''){left}{left}{left}{left}{enter}{enter}{up}{tab}
				Return
	^+.::
	Send,db.execute(f'''''').fetchone()
				Loop,15 ;10
				{
				Send,{left}
				}
				Send,{enter}{enter}{up}{tab}
				Return
	^+-::
	Send,db.execute(f'''''').fetchall()
				Loop,15 ;10
				{
				Send,{left}
				}
				Send,{enter}{enter}{up}{tab}
				Return
#IfWinActive

;-------TEXSTUDIO-------
; typing \keys
#IfWinActive ahk_exe texstudio.exe
<^k::
;Send, keys
Send,  {\}keys{{}{}}{left}
;Send, {left}
Return
#IfWinActive
Return

;;-----------------------
;;-------RSTUDIO-------
; Matrix multiplication in Rstudio - shorcut for %*%
#IfWinActive ahk_exe rstudio.exe
<^'::
Send,{SHIFT DOWN}5'5{SHIFT UP}
Return
#IfWinActive

;------------------------------
;-----------spotify-------------
; control track and volume with alt+arrow
; pause/play with double clicking alt


; don't understand why, input level 1 for other commands and 0 for this so that does not launch stuff from the windows workflow file
#InputLevel 0 
#IfWinActive ahk_exe spotify.exe
<!LEFT::Send,{ctrl down}{LEFT}{ctrl up}
Return
<!RIGHT::Send,{ctrl down}{RIGHT}{ctrl up}
Return
<!UP::Send,{ctrl down}{UP}{ctrl up}
Return
<!DOWN::Send,{ctrl down}{DOWN}{ctrl up}
Return

~LAlt::
if (A_PriorHotkey <> "~LAlt" or A_TimeSincePriorHotkey > 400)
{
    ; Too much time between presses, so this isn't a double-press.
    KeyWait,LAlt
    return
}
;Msgbox, works
Send,{space}
Return
#IfWinActive
#InputLevel 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STRICTLY PRIVATE ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;[FLH-THESIS]
$^$!$t::
Send,[FLH-THESIS]
Return

;;-----------------------
;-------PUHTI DIRECTORIES-------
<^<!p::
Send,/projappl/project_2003758
Return

<^<!s::
Send,/scratch/project_2003758/makimiik
Return

<^<!u::
Send,/users/makimiik/flh
Return

;;-----------------------
;-------GIT-------
#IfWinNotActive,ahk_class OpusApp
; Git most frequently used path
<^<!j::
Send,C:\Users\mmak\OneDrive - Väestöliitto ry\FLH-THESIS\1_determinants\1publish_determinants
Return

<^<+j::
Send,cd C:\Users\mmak\OneDrive - Väestöliitto ry\FLH-THESIS\1_determinants\1publish_determinants
Return

; Git second most frequently used path
<^<+,::
Send,cd C:\Users\mmak\OneDrive - Väestöliitto ry\FLH-THESIS\3_outcomes\3publish_outcomes
Return

<^<!,::
Send,C:\Users\mmak\OneDrive - Väestöliitto ry\FLH-THESIS\3_outcomes\3publish_outcomes
Return

;Most frequently used Backup location
<^<!m::
Send,C:\Users\mmak\OneDrive - Väestöliitto ry\FLH-THESIS\1_determinants\1BACKUP_determinants
Return

;delete
<^<+l::
Send,del /S *.aux *.bbl *.blg *.log *.out  *.fdb_latexmk *.fls *.synctex.gz *.run.xml *.xdv *.xtr *.bcf *.lot *.lof
Return

; git commit all
<^<+k::
Send,git commit -a -m ""{left}
Return


; Git most frequently used path
<^<+h::
Send,cd C:\Users\mmak\OneDrive\Autohotkey
Return

<^<!h::
Send,C:\Users\mmak\OneDrive\Autohotkey
Return



; Git add autohotkey changes
<^<+!h::
Send, git add Useful_material/ stata_workflow.ahk windows_workflow.ahk word_macros.txt README.md
Return
#IfWinNotActive

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetKeyDelay , 70,10
; - Puhti.csc.fi
;Launch R studio
SetTitleMatchMode, 1
#IfWinactive,ahk_exe chrome.exe
$<^+!p::
;MsgBox,abs
Loop,12 ;10
{
Send,{Shift Down}{pause}{tab} ; go to Cores from below
}
Send,8 ; Cores
Send,{pause}{pause}{pause}{TAB}{pause}{pause}{pause}
Send,76 ; Memory (GB)
Send,{pause}{pause}{pause}{TAB}{pause}{pause}{pause}
Send,720 ; Local Disc (GB)
Send,{pause}{pause}{pause}{TAB}{pause}{pause}{pause}
Send,9:00:00 ; d-hh:mm:ss, or hh:mm:ss
Send,{pause}{pause}{pause}{TAB}{pause}{pause}{pause} 
; keep R version as is
Send,{pause}{pause}{pause}{TAB}{pause}{pause}{pause} 
Send,{space}{pause}{pause}{pause} ; multithreaded
Send,{pause}{pause}{pause}{TAB}{pause}{pause}{pause} 
Return
#IfWinActive



;;;;;;;;;;;;;;;;;;;;;;;;,
; Fill in nepton


fill_in_nepton(ETATYO)
{
;avaa muokkausikkuna
	MouseClick, left
	SetTitleMatchMode, 1
	Winwait,Lisää tapahtuma,,1 ; wait for X seconds max
	Winactivate,Lisää tapahtuma
	Sleep,200 ; oli 50
	If !WinExist("Lisää tapahtuma")
	{
		MsgBox, Muokkausikkuna ei auennut (ajoissa).`n Paina enter ja yritä uudestaan `n tai syötä tiedot manuaalisesti
		Return
	}
	;Msgbox,Activated
	Sleep,100 ; oli 1300

if (ETATYO==1)
{
	If WinActive("Lisää tapahtuma")
	{
		;Winwait,Lisää tapahtuma,,1
		Send,{e down}{pause}{e up}
		Sleep,400 ; oli 1100
	}
	else
	{
		MsgBox,Skripti pysähtyi ennenaikaisesti `n ennen etätyön lisäämistä
		Return
	}
}


;Mene työajan loppumiskohtaan, vaihda työaika ja mene projektiin
	If WinActive("Lisää tapahtuma")
	{
		;Winwait,Lisää tapahtuma,,1
		Loop,8
		{
		Send,{tab}
		Sleep,60 ; oli 80/40
		If (A_Index == 4)
			{
				; Vaihda työaika
				Send,16:00
				Sleep,80 ; oli 200
				;mene projektiin
			}
		}
	}
	else
	{
		MsgBox,Skripti pysähtyi ennenaikaisesti `n ennen ensimmäisiä siirtymisiä
		Return
	}


; vaihda projekti
	If WinActive("Lisää tapahtuma")
	{
		Winwait,Lisää tapahtuma,,1
		;Send,2_209_20 KP209 Tutkimustyö (SHARE)
		Send,2_211_20 KP211 Tutkimustyö LoveAge
		;Send,2_209_10 KP209 Hallintotyö (SHARE in Kind)
		Sleep,1400 ; oli 1200
		Send,{Enter}
		;Sleep,100
	}
	else
	{
		MsgBox,Skripti pysähtyi ennenaikaisesti `n  ennen projektin lisäämistä
		Return
	}


; Mene takaisin päin ja valitse tallenna
	If WinActive("Lisää tapahtuma")
	{
		;Winwait,Lisää tapahtuma,,1
		Loop,14
		{
		Send,{shift down}{tab}{shift up}
		Sleep,60 ; oli 60/40
		if (A_Index > 10)
			Sleep, 50 ; oli 40/40 
		}
		;Msgbox,Box paina enter
		Send,{Enter}
	}
	else 
	{
		MsgBox,Skripti pysähtyi ennenaikaisesti `n ennen isoa liikkumista
		Return
	}
	Return
}

#IfWinActive, Nepton
$<!$LButton::fill_in_nepton(ETATYO:=0)
$<!$RButton::fill_in_nepton(ETATYO:=1)
#IfWinactive

Return



;;;;;;;;;;;;;
/*
Loop
{
If (2110 - A_Index * 70 < 1710)
			break
	If WinActive(Lisää tapahtuma)
	{
		;Winwait,Lisää tapahtuma,,1
		MouseClick, left, 250, 2110 - A_Index * 70 ; not robust
		;Sleep,10
	}
}
Return
#IfWinActive
*/






/*
#IfWinActive,Lisää tapahtuma
MouseClick, left, 250, 1970 ; not robust
Sleep,20
#IfWinActive

#IfWinActive,Lisää tapahtuma
MouseClick, left, 250, 1900 ; not robust
Sleep,20
#IfWinactive

#IfWinActive,Lisää tapahtuma
MouseClick, left, 250, 1830 ; not robust
Sleep,20
#IfWinActive

#IfWinActive,Lisää tapahtuma
MouseClick, left, 250, 1770 ; not robust
Sleep,20
#IfWinActive

#IfWinActive,Lisää tapahtuma
MouseClick, left, 250, 1710 ; not robust
Sleep,20
#IfWinActive
*/



<!h::
{
Loop
{
MsgBox, % A_Index
/*
Msgbox, % 3100 - A_Index * 70
If (3100 - A_Index * 70 < 1710)
	break
}

*/
if (A_Index == 3)
	break
}
Return
}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXTRA CODE ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/*
<^!w::
MsgBox, This is a test, and it works nicely
Return
*/


;Larger and smaller than with an american keyboard with Scandinavian settings..
/*
#,::
Send, <
Return


#.::
Send, >
Return
*/

;SetKeyDelay to default
SetKeyDelay , 10, -1

;;-----------------------
#InputLevel 0
;;-----------------------


