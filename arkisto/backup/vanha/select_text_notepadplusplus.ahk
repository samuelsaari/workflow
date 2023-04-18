!1::	; some hotkey
ControlGet, ScintillaHwnd, Hwnd,, Scintilla1, ahk_class Notepad++	; Note: The Scintilla control's instance number may vary
ScintillaText := GetText(ScintillaHwnd, "UTF-8")

StatusBarGetText, SBarText , 3, ahk_class Notepad++			; get status bar contents
RegExMatch(SBarText, "Ln\s*:\s*(\d+)\s+Col\s*:\s*(\d+)", SBar)		; find line # and col #

loop, parse, ScintillaText, `n, `r
	if (A_Index<Sbar1)
		P1 .= (P1?"`n":"") A_LoopField
	else if (A_Index=Sbar1)
		P1 .=  SubStr(A_LoopField, 1, SBar2), P2:= SubStr(A_LoopField, Sbar2+1)
	else if (A_Index>Sbar1)
		P2 .= (P2?"`n":"") A_LoopField

MsgBox % RegExReplace(P1, "s)^.*(?="")") . RegExReplace(P2, "s).*?""\K.*$")
return

GetText(hWnd, Encoding := "") { ; http://www.autohotkey.com/board/topic/38346-how-to-get-text-in-notepad/#entry612365
	DllCall("SendMessage", UInt, hWnd, UInt, 13, Int, VarSetCapacity(Text, DllCall("SendMessage", UInt, hWnd, UInt, 14) + 1 << 1) >> 1, Str, Text)
return Encoding ? StrGet(&Text, Encoding) : Text
}