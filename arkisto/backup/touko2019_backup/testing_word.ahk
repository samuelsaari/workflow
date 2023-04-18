
#IfWinActive, ahk_exe winword.exe
$^ö::
Send, !l
Return
#IfWinActive

#IfWinActive, ahk_exe winword.exe
$^ä::
Send, !k
Return
#IfWinActive


#IfWinNotActive, Quick Format Citation
#IfWinActive, ahk_exe winword.exe
$^å::
Send, !j
#IfWinNotActive
#IfWinActive
Return



/*
#IfWinActive, Quick Format Citation
;Suppress Author
$^å::
$!j::
send, 
(

)
#IfWinActive
Return
*/