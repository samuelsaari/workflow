;ZOTERO PLUGIN HOTKEYS
#IfWinActive, Quick Format Citation
;Suppress Author
$^å::send, 
(
{Control down}{down}{Control up}{pause}{pause}{pause}{pause}{pause}{tab}{tab}{tab}{tab}{tab}{space}{pause}{pause}{pause}{enter}{pause}{pause}{enter}
)
#IfWinActive
Return

#IfWinNotActive, Quick Format Citation
#IfWinExist, Quick Format Citation
#IfWinNotActive, ahk_class OpusApp
$^å::
WinActivate, Quick Format Citation
#IfWinNotActive
#IfWinExist
Return