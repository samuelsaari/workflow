; This example allows you to move the mouse around to see
; the title of the window currently under the cursor:

Toggle := False
^!ö::
#Persistent
SetTimer, WatchCursor, 100
return

WatchCursor:
MouseGetPos,X, Y , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
   If (Toggle = False) {

      Toggle := True

      ToolTip, `X %X%`nY %Y%`nahk_id %id%`nahk_class %class%`n%title%`nControl: %control%

   } Else If (Toggle = True) {

      Toggle := False

      ToolTip

   } Return
return

