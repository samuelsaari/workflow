Run, main.cpl
Winwait, Mouse Properties,,0.5
if ErrorLevel
{
    MsgBox, Mouse Properties did not open in time
    return
}
Sleep,20
Send, {Space}{pause}{Enter}
MsgBox,64,Autohotkey message:,Primary mouse button changed,0.8
Return