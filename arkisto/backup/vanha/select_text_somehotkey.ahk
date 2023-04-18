!1::	; some hotkey
P1 := P2 := ""
WinGetText, NotepadText, ahk_class Notepad

StatusBarGetText, SBarText , 2, ahk_class Notepad			; get status bar contents
RegExMatch(SBarText, "Ln\s*(\d+),\s+Col\s*(\d+)", SBar)		; find line # and col #

loop, parse, NotepadText, `n, `r
	if (A_Index<Sbar1)
		P1 .= (P1?"`n":"") A_LoopField
	else if (A_Index=Sbar1)
		P1 .=  SubStr(A_LoopField, 1, SBar2), P2:= SubStr(A_LoopField, Sbar2+1)
	else if (A_Index>Sbar1)
		P2 .= (P2?"`n":"") A_LoopField
ToolTip % RegExReplace(P1, "s)^.*(?="")") . RegExReplace(P2, "s).*?""\K.*$")
return