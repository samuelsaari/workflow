
#IfWinActive, ahk_exe winword.exe
$^�::
Send, !l
Return
#IfWinActive

#IfWinActive, ahk_exe winword.exe
$^�::
Send, !k
Return
#IfWinActive


#IfWinNotActive, Quick Format Citation
#IfWinActive, ahk_exe winword.exe
$^�::
Send, !j
#IfWinNotActive
#IfWinActive
Return



/*
#IfWinActive, Quick Format Citation
;Suppress Author
$^�::
$!j::
send, 
(

)
#IfWinActive
Return
*/