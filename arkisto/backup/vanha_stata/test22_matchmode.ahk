;Opening Stata-windows with specific keyboard kombinations

;#IfWinExist, Stata
;#1:: WinActivate 
;#IfWinExist

SetTitleMatchMode, 1
#IfWinExist, Do-file
#§:: WinActivate 
#IfWinExist

;first stata,then do-file

#IfWinExist, Stata
#<:: WinActivate
IfWinExist, Do-file
WinActivate
#IfWinExist

#IfWinExist, Data Editor
#q:: WinActivate 
#IfWinExist

#IfWinExist, Viewer
#a:: WinActivate 
#IfWinExist

#IfWinExist, Graph
#z:: WinActivate 
#IfWinExist
