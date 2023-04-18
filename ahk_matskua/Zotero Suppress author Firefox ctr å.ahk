;; 1.2 Saving references to Zotero in firefox 

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.3
;WORKAROUNDS FOR WORD THAT DOES NOT HAVE SPECIAL CHARACTERS OR SCANDINAVIAN LETTERS AS wdKeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NB! You need the VBA code for these to work


;ZoteroAddEditBibliography_SC
; press ctrl + Shift + B (built in in word)




;Refresh bibliography
;note that word's own ctrl/alt/r works
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

Return