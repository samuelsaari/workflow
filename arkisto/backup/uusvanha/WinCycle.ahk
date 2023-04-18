; WinCycle.ahk - Allan Marillier, January 31, 2017

; Cycle through windows at specified interval, activate and if necessary maximize

global Program := "WinCycle"
global Version := "0.4"
global Author := "Allan Marillier"
global DEBUG := 0
global SoundEnabled := 0
global Homepage := "http://ahkscript.org/"
global delay = 5000
global BindToApp := ""
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
global ConfigFile
global Active := 1
ConfigFile = %A_ScriptDir%\WinCycle.txt
AppName = %A_ScriptName%

/*
 currently working on:
	- 

	
*/

global Spaces
Spaces := "   "
global WinCycle_Changes =
WinCycle_Changes =
(
--------------------------------------------------------------------------
Changes: (most recent at top) 
planned changes:
	- test for invalid config file - if specified windows are missing - offer to open???
	- add to menu to allow setting sleep session specific delay without impacting config file

Changes with v 0.4 February 3, 2017
	- add a menu item (Win+Q, D ...) to display a slider control to allow temporary changing of the 
        global default time delay for windows with no custom delay specified. This pauses execution while 
        the new delay is defined, after which all windows with no custom delay use the new temporary delay
Changes with v 0.3 February 2, 2017
	- brought used library functions in from IAM_Libs.ahk so we have only what we need, all in one source file
	- added fincs' ActiveWinInfo.ahk in both 64 and 32 bit compiled formats, with FileInstall, and test for OS 
		and call the right version based on the operating system to allow for those stuck on a 32 bit OS still
Changes with v 0.2 February 1, 2017
	- added custom delay per window if present, otherwise use default delay
		custom delay takes the form e.g
		Delay 5 # delay in seconds
		Windows PowerShell ISE, 3
		Total Commander, 4
		Notepad
		Outlook, 10
	- added mouse click at coordinates if specified in config file e.g. (both x and y coords must be present)
		HP Service Manager - Google Chrome, 10, x=294 y=168  ; mouse click coordinates for refresh
		This mouse click is optional, if coordinates are found for a watched window, the mouse will be 
		clicked at that location each time the window is activated.
		Mouse moving is blocked for the short duration of checking if a mouse click is configured and
		actually cicking the mouse, to prevent a user accidentally moving the mouse during the operation
		and unintentionally clicking in another window.
	- added Toggle Paused / Run tray and popup menu items. This literally pauses and resumes window cycling
	- added a WinInfo item tray and popup menu items. This pauses cycling and starts a "window spy" to allow seeing
		window titles and mouse location coordinates to configure optional mouse clicks
	- test for and ignore empty lines in the config file
Changes with v 0.1 January 31, 2017
	- first version
	recent additions:
		- test for missing config file and complain with msgbox, then exit
		- allow optional delay line in config file e.g.
			Delay 4 ; delay in seconds  comments are allowed on this line, comment character is either ; or #
			if line is found, delay is changed from default 5 seconds
		- added hotkey Win C for immediate abort
		- added a Re-read config tray menu item
		- added an Edit config tray menu item
		- more robust test for delay to ensure Delay xx where xx is digit, and ignore, set default if
			xx is not digit
		- test for windows not existing, don't add to array of windows to cycle
		- added popup menu with hotkey Win+Q - this is the same as right clicking the system tray icon
)
StringReplace, WinCycle_Changes, WinCycle_Changes, `t, %Spaces%, All


global windowArray := Object()
global windowArrayCount := 0 
global delayArray := Object()
global clickXArray := Object()
global clickYArray := Object()
global MenuHotKey 
MenuHotKey = #Q  ; default hotkey equivalent to middle mouse button press
global WinCycleAbort
WinCycleAbort = #C   ; abort activities and exit app
global PauseHotKey
PauseHotKey = #T


FileInstall, WinCycle.png, %A_Temp%\WinCycle.png, 1
FileInstall, WinInfo.exe, %A_Temp%\WinInfo.exe, 1
FileInstall, WinInfo-32bit.exe, %A_Temp%\WinInfo-32bit.exe, 1

SetTitleMatchMode, 2
#Persistent
#SingleInstance  ; only allow one instance of the program to run, otherwise we may get funky behavior with any key mappings
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
; #Warn  ; Enable warnings to assist with detecting common errors
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory

; --------- set up tray menu ---------
Menu, tray, Icon, %AppName%,, 1
Menu, tray, tip, %Program%
Menu, tray, add, (&A)bout, AboutL ; Creates an about menu item
Menu, tray, add, (&C)hange Record, ChangeRecordL
Menu, tray, add, (&D)efault Delay Change, ChangeDelayL
Menu, tray, add, (&E)dit config, EditConfigL
Menu, tray, add, (&H)elp, HelpL
Menu, tray, add, (&R)e-read Config, ReReadConfigL
Menu, tray, add, (&T)oggle Paused / Run, ToggleL
Menu, tray, add, (&W)indow Info, WinInfoL
Menu, tray, Add, E(&X)it %Program%, ExitAppL
Menu, tray, NoStandard  ; this removes the standard tray icon menu items

; --------- set up popup menu ---------
Menu, PopupMenu, Add, (&A)bout, AboutL
Menu, PopupMenu, Add, (&C)hange Record, ChangeRecordL
Menu, PopupMenu, add, (&D)efault Delay Change, ChangeDelayL
Menu, PopupMenu, Add, (&E)dit config, EditConfigL
Menu, PopupMenu, Add, (&H)elp, HelpL
Menu, PopupMenu, Add, (&R)e-read Config, ReReadConfigL
Menu, PopupMenu, add, (&T)oggle Paused / Run, ToggleL
Menu, PopupMenu, add, (&W)indow Info, WinInfoL
Menu, PopupMenu, Add  ; Add a separator line.
Menu, PopupMenu, Add, (&E)xit %Program%, ExitAppL
; --------- set up popup menu ---------

; --------- start set up hot keys ---------

; React to MojoAbort hotkey (Win C) all the time
Hotkey, %WinCycleAbort%, ExitAppL
Hotkey, %MenuHotKey%, PopupMenuL
Hotkey, %PauseHotKey%, ToggleL

miniHelp()
ReadConfig()
WinCycle()




AboutL:
About()
Return

ChangeDelayL:
infoMessage = Window cycling has been paused while you change the default delay.`nAfter changing the delay, resume cycling by selecting the Toggle menu item, or press Win+T`n`nNOTE: window cycling will NOT automatically resume when the delay changing tool is closed.`nNOTE: this only changes the default delay temporarily while %Program% is running.`nTo make a permanent change you must edit the config file.
IAMMsgBox(48, Program ": INFO", infoMessage, 10, BindToApp)  ; 0 (ok) and 48 (exclamation image)
NewDelay := ChangeDelay()
Pause, On
Delay := NewDelay * 1000
return


ChangeRecordL:
ChangeRecord()
Return

EditConfigL:
IAMMsgBox(16, Program, Program " " Version "`nNOTE: The config file will be opened in Windows Notepad.`n`nAfter you edit this file you will need to use the Re-read config menu item to activate the changes to " Program, 0, BindToApp)  ; 0 (ok) and 16 (hand/stop image)
Run Notepad "%ConfigFile%"
return

HelpL:
Help(0)
Return

; --------------------------------
PopupMenuL:
MouseGetPos, MouseXPos, MouseYPos
Menu, PopupMenu, Show
Return

ReReadConfigL:
ReadConfig()
return

ToggleL:
Pause, Toggle
return

WinInfoL:
infoMessage = Window cycling has been paused while Window Info runs.`nAfter checking window info, resume cycling by selecting the Toggle menu item, or press Win+T`n`nNOTE: window cycling will NOT automatically resume when the Window Info tool is closed
IAMMsgBox(48, Program ": INFO", infoMessage, 10, BindToApp)  ; 0 (ok) and 48 (exclamation image)
if (A_Is64bitOS) {
	Run, %A_Temp%\WinInfo.exe
}
else {
	Run, %A_Temp%\WinInfo-32bit.exe
}
Pause, Toggle
return

ExitAppL:
FileDelete, %A_Temp%\WinInfo.exe
FileDelete, %A_Temp%\WinInfo-32bit.exe
FileDelete, %A_Temp%\WinCycle.png
ExitApp
return


; -------------------------------------------------------------------------------
; Functions begin here


; -------------------------------------------------------------------------------
; display a popup with info about this program
About()
{
	; -------------------------------------------
	MyAboutMessage =
	(
%Program%, %Version%: written by Allan Marillier using AutoHotkey
Compiled with AutoHotkey version %A_AhkVersion%

This program automates cycling through open windows for monitoring purposes.

See the help menu item to see what all this does and how to configure it.

Take a look at the change record. If you have seen this app before, there have probably been
significant changes since the last version you saw.
	)
	
	MyAboutSound = "" ; %A_Temp%\SM-Mojo.mp3
	MyAboutImage = %A_Temp%\WinCycle.png
	MyAboutTitle = About: %Program% %Version%
	MyAboutWindowColor = White
	MyAboutWindowTextColor = Blue
	IAMScrollableWindow(MyAboutTitle, MyAboutMessage, MyAboutWindowColor, MyAboutWindowTextColor, BindToApp, MyAboutSound, MyAboutImage)
	return
}  ; end of About

; -------------------------------------------------------------------------------
ChangeDelay()
{
	global NewDelay
	global OldDelay := Round(Delay / 1000)
	global Message

	NewDelay := OldDelay
	
	Monitor := 
	Monitor := IAMGetCurrentMonitor(BindToApp)
	SysGet, MonitorName, MonitorName, %Monitor%
	SysGet, Monitor, Monitor, %Monitor%
	SysGet, MonitorWorkArea, MonitorWorkArea, %Monitor%
	MonitorCenterX := MonitorLeft + ((MonitorRight - MonitorLeft) / 2)
	MonitorCenterY := MonitorTop + ((MonitorBottom - MonitorTop) / 2)
	
	Message = Pick a new default delay (currently %OldDelay%)
	Gui, 3:+LabelDelayGui
	Gui, 3:Add, Text, cBlue w480 h20 vMessage
	Gui, 3:Add, slider, w620 Range1-30 Tickinterval1 ToolTip Page5 vNewDelay gSlide, %OldDelay%
	Gui, 3:Add, Text, h20 x20 y60, 1
	Gui, 3:Add, Text, h20 x102 y60, 5
	Gui, 3:Add, Text, h20 x202 y60, 10
	Gui, 3:Add, Text, h20 x302 y60, 15
	Gui, 3:Add, Text, h20 x406 y60, 20
	Gui, 3:Add, Text, h20 x507 y60, 25
	Gui, 3:Add, Text, h20 x608 y60, 30
	Gui, 3:Add, Button, x300 gButtonChangeDelay, OK
	Gui, 3:Show,, Delay control
	GuiControl,3:,Message,%Message%
	
	WinGetPos, xPos, yPos, Width, Height, Delay control
	NewX := MonitorCenterX - (Width / 2)
	NewY := MonitorCenterY - (Height / 2)
	Location := "x" . NewX . " y" . NewY
	Gui, 3:Show, %Location%, Delay control
	Return 

	DelayGuiEscape:
	DelayGuiClose:
	ButtonChangeDelay:
	Gui, 3:Submit
	Gui, 3:Destroy
	myDelay := NewDelay * 1000
    Pause, Off
	Return myDelay
	
	Slide:
	NewMessage = Pick a new default delay (currently %OldDelay% is changing to %NewDelay%)
	GuiControl,3:,Message, %NewMessage%
    Return

	
	if DEBUG = 1
	{
		MsgBox ,,DEBUG ChangeDelay, Inside ChangeDelay: Delay = %OldDelay%  NewDelay = %NewDelay%,2
	}  ; end if Debug mode

	myDelay := NewDelay * 1000
    Pause, Off
	Return myDelay
}  ; end of ChangeDelay

; -------------------------------------------------------------------------------
; display a popup with change record info
ChangeRecord()
{
		; -------------------------------------------
	MyChangeMessage = %WinCycle_Changes%  ; `n%WinCycle_Changes1%`n%WinCycle_Changes2%
	
	MyChangeSound = "" ; %A_Temp%\SM-Mojo.mp3
	MyChangeImage = %A_Temp%\WinCycle.png
	MyChangeTitle = Change Record: %Program% %Version%
	MyChangeWindowColor = White
	MyChangeWindowTextColor = Blue
	IAMScrollableWindow(MyChangeTitle, MyChangeMessage, MyChangeWindowColor, MyChangeWindowTextColor, BindToApp, MyChangeSound, MyChangeImage)
	return
}  ; end of ChangeRecord

; -------------------------------------------------------------------------------
; display a popup with help
Help(displayTime)
{
		MyHelpMessage =
	(
%Program%, %Version%: written by Allan Marillier using AutoHotkey
Compiled with AutoHotkey version %A_AhkVersion%

This little application allows cycling through opened windows, activating and if necessary
maximizing them and delaying for a specified period in seconds.

After execution a system tray menu will appear. Right click the application's ico in the system
tray to activate the menu, and select any required options.

Win+C (Windows key and C) will immediately exit the program no matter what it is doing.
Win+Q (Windows key and Q) will pop up a menu on the active monitor with options
Win+T (Windows key and T) will toggle between Paused and Running states

A configuration file named WinCycle.txt should be placed in the same location as this executable
program.
The file can contain an optional line containing a delay to specify a delay different than
the default 5 seconds. All other lines should contain enough of the text in the title of any
window to be cycled that it can be uniquely identified. Each line can also contain optional 
cusom times to display windows other than the default time, as well as optional window coordinates
for mouse clicking to e.g. refresh, to prevent application timeout / log out
See the examples below:

Delay 5  ; delay in seconds
Windows PowerShell ISE, 3
Total Commander, 5
AutoHotkey Help
Outlook, 7
Notepad
HP Service Manager - Google Chrome, 10, x=294 y=168  ; custom delay 10 seconds, mouse click specified coordinates for refresh

Note that if more than one window with the same title is found to be running, e.g. Notepad, rather
than specifying a unique "WinCycle.txt - Notepad", the most recently opened / used Notepad will
be cycled. Others will not be activated unless they are uniquely identified.

If a specified window is not currently running, it will be quietly ignored and the next window in sequence
will be displayed. In future this might be enhanced to prompt if the window / application should be started.

If windows are active on different monitors on the same computer, they will be activated and maximized on
the same monitor they were last displayed on. This allows cycling with mutiple applications across
multiple monitors.

	)
	
	if (displayTime = "") {
		displayTime = 0
	}  ; end if no display time was specified
	MyHelpSound = "" ; %A_Temp%\SM-Mojo.mp3
	MyHelpImage = %A_Temp%\WinCycle.png
	MyHelpTitle = Help: %Program% %Version%
	MyHelpWindowColor = White
	MyHelpWindowTextColor = Blue
	IAMScrollableWindow(MyHelpTitle, MyHelpMessage, MyHelpWindowColor, MyHelpWindowTextColor, BindToApp, MyHelpSound, MyHelpImage)
	return
}  ; end of Help

; -------------------------------------------------------------------------------
IAMScrollableWindow(WindowTitle, WindowMessage, MyWindowColor := "white", MyWindowTextColor := "Black", BindToApp := "primary", WindowSound := "" , WindowImage := "", MyImageWidth := 0)
{
    ; Create and display a popup window with info about this program
    ; This can be used for all of About, Change record, Help and more
    
    ; WindowTitle is the text to be displayed in the title bar
    ; WindowMessage is the text to be displayed for about, change, help etc.
    ; BindToApp is an optional parameter and specifies one of "current", "primary" or a partial title of a
    ;     window on which monitor the new window is to be displayed. If BindToApp specifies a window open
    ;     on monitor 2, then this window will be on monitor 2. If BindToApp is ommitted, or empty, then this
    ;     window will be on the primary monitor
    ; WindowSound is an optional parameter and specifies a sound to be played if sound is enabled to be played or
    ;     not - full path required
    ; WindowImage is an optional parameter and specifies an image to be displayed - full path required
    ; ImageWidth specifies a horizontal image width, assuming the vertical will be kept appropriate with 
    ;   same aspect ratio by setting -1 as the size. Default is 0 which means leave the original image size
    
    /* Colors
    Gui Color, WindowColor, ControlColor
    Gui font, cRed
    Gui add, text, cRed, My text
    Black = 000000   Green = 008000 
    Silver = C0C0C0   Lime = 00FF00 
    Gray = 808080   Olive = 808000 
    White = FFFFFF   Yellow = FFFF00 
    Maroon = 800000   Navy = 000080 
    Red = FF0000   Blue = 0000FF 
    Purple = 800080   Teal = 008080 
    Fuchsia = FF00FF   Aqua = 00FFFF 
    */

    IfWinExist, %WindowTitle%
    {
        WinActivate, %WindowTitle%
        IAMMsgBox(48, Program ": ERROR", "You already have that dialog open`n`nOnly open once at any given time`n`nThat one will activate and come to the foreground now", 3, BindToApp)  ; 0 (ok) and 48 (exclamation image)
        return
    }  ; end if the requested GUI has already been opened

    MyGUINum++
    if ( SoundEnabled = 1 ) {
        SoundPlay, %WindowSound%
    }

    Monitor := 
    Monitor := IAMGetCurrentMonitor(BindToApp)
    SysGet, MonitorName, MonitorName, %Monitor%
    SysGet, Monitor, Monitor, %Monitor%
    SysGet, MonitorWorkArea, MonitorWorkArea, %Monitor%
    MonitorCenterX := MonitorLeft + ((MonitorRight - MonitorLeft) / 2)
    MonitorCenterY := MonitorTop + ((MonitorBottom - MonitorTop) / 2)
    ImageWidth := 0
    ImageHeight := 0
    xText := 5
    yText := 5
    
    StringReplace, WindowMessage, WindowMessage,`r`n,`n, All
    StringSplit, Stuff, WindowMessage, `n
    NumLines := Stuff0 ; Stuff.MaxIndex()

    ; Make a GUI window, scrollable if more than 2500 characters long
    if StrLen(WindowImage) {
        if (MyImageWidth = 0) {
            ImageSize := IAMImageSize(WindowImage)
            StringSplit, Size, ImageSize, ";"
            ImageWidth := Size1
            ImageHeight := Size2
        } else
            ImageWidth := MyImageWidth
        xText := ImageWidth + 15
        yText := 10
    }
    Gui, %MyGuiNum%:+LabelIAMScrollableWindow
    Gui, %MyGuiNum%:Color, %MyWindowColor%, WindowColor, %MyWindowColor%, ControlColor, %MyWindowColor%
    ;Gui, %MyGuiNum%:ControlColor, white
    if StrLen(WindowImage)    
        Gui, %MyGuiNum%:Add, Picture, w%ImageWidth% h-1, %WindowImage%
    Gui, %MyGuiNum%:Font, c%MyWindowTextColor%
    Gui, %MyGuiNum%:Font, s10, Verdana
    ;if (MessageLength > 2500 )
    if (NumLines > 40 )
        Gui, %MyGuiNum%:Add, Edit, -WantCtrlA ReadOnly VScroll x%xText% y%yText% h400 w600, %WindowMessage%
    else
        Gui, %MyGuiNum%:Add, Text,x%xText% y%yText%, %WindowMessage%
    Gui, %MyGuiNum%:Font, underline
    Gui, %MyGuiNum%:Add, Text, cBlue gScrollWindowHomePage, Click here to visit AutoHotKey's home page
    Gui, %MyGuiNum%:Font, norm
    Gui, %MyGuiNum%:Add, Button, gButtonCloseScrollWindow, Close
    Gui, %MyGuiNum%:Show,, ScrollWindow ; : %Program% %Version%
    Send ^{Home}  ; put the cursor at the start of the text
    WinGetPos, xPos, yPos, Width, Height, ScrollWindow
    NewX := MonitorCenterX - (Width / 2)
    NewY := MonitorCenterY - (Height / 2)
    Location := "x" . NewX . " y" . NewY
    Gui, %MyGuiNum%:Show, %Location%, %WindowTitle%
    WinSet, AlwaysOnTop, On, WindowTitle
    WinSet, AlwaysOnTop, Off, WindowTitle
    
    Return MyGUINum
    
    ScrollWindowHomePage:
    Run %HomePage%
    Return
    
    ScrollWindowGuiEscape:
    ScrollWindowGuiClose:
    ButtonCloseScrollWindow:
    Gui, %MyGuiNum%:Submit
    Gui, %MyGuiNum%:Destroy
    
    Return MyGUINum
}  ; end of IAMScrollableWindow

; -------------------------------------------------------------------------------
IAMMsgBox(Option, BoxTitle, Message, Timeout, BindToApp)
{
    ; Open a MsgBox centered on a specified monitor, then return the button clicked
    ; This calls IAMGetCurrentMonitor to figure out where to put the MsgBox
    
    ; Option contains a number for the options shown below
    ; BoxTitle contains the message to be put in the title bar of the MsgBox created
    ; Message contains the message to be displayed
    ; Timeout is a timeout in seconds, or 0 to wait until a key is clicked.
    ; BindToApp can be one of "current", "primary" or a partial title of an app e.g. Service Manager
    
    
    ; Test this function with e.g.:n
    ; ReturnCode := IAMMsgBox(34, "Test title!", "This is a boring test", 3, Service Manager)  ; 2 and 32 for image
    ; MsgBox we got: %ReturnCode%
    
    ; Message := "WARNING! This is experimental code and may not yet work properly based on the coordinate locations of window controls.`n`nDo you want to continue anyway? (press Yes or No)"
    ; Option = 8211  ; 3 and 16 for the image plus 8192 for on top
    ; BoxTitle = First Message Box
    ; ReturnCode := IAMMsgBox(Option, BoxTitle, Message, 0, Service Manager)
    
    ; This function basically does what MsgBox does, but allows passing the option and message
    ; after which it creates the MsgBox, positions it on the active display rather than primary
    ; display, and then returns the button clicked
    
    ; Option:
    ; OK (that is, only an OK button is displayed) 0 0x0 
    ; OK/Cancel 1 0x1 
    ; Abort/Retry/Ignore 2 0x2 
    ; Yes/No/Cancel 3 0x3 
    ; Yes/No 4 0x4 
    ; Retry/Cancel 5 0x5 
    ; Cancel/Try Again/Continue (2000/XP+) 6 0x6 
    ; Adds a Help button (see remarks below) 16384 0x4000 
    ;
    ; Icon Hand (stop/error) 16 0x10 
    ; Icon Question  32 0x20 
    ; Icon Exclamation 48 0x30 
    ; Icon Asterisk (info) 64 0x40 
    ;        
    ; Makes the 2nd button the default  256 0x100 
    ; Makes the 3rd button the default  512 0x200
    
    ; System Modal (always on top) 4096 0x1000 
    ; Task Modal 8192 0x2000 
    ; Always-on-top (style WS_EX_TOPMOST)(like System Modal but omits title bar icon) 262144 0x40000 


    Monitor := 
    Monitor := IAMGetCurrentMonitor(BindToApp)
    SysGet, MonitorName, MonitorName, %Monitor%
    SysGet, Monitor, Monitor, %Monitor%
    SysGet, MonitorWorkArea, MonitorWorkArea, %Monitor%
    MonitorCenterX := MonitorLeft + ((MonitorRight - MonitorLeft) / 2)
    MonitorCenterY := MonitorTop + ((MonitorBottom - MonitorTop) / 2)
    
    SetTimer, MoveBox, 1
    MsgBox, % Option , % BoxTitle, %Message%, % Timeout
    WinGetPos,,, Width, Height, % BoxTitle
    
    IfMsgBox, No
        ReturnCode := "No"
    IfMsgBox, Yes  
        ReturnCode := "Yes"
    IfMsgBox, OK
        ReturnCode := "OK"
    IfMsgBox, Cancel
        ReturnCode := "Cancel"
    IfMsgBox, Abort
        ReturnCode := "Abort"
    IfMsgBox, Ignore
        ReturnCode := "Ignore"
    IfMsgBox, Retry
        ReturnCode := "Retry"
    IfMsgBox, Timeout
        ReturnCode := "Timeout"
    
    Return ReturnCode
    
    MoveBox:
    IfWinNotExist, % BoxTitle
        Return  ; Keep waiting.
    
    SetTimer, MoveBox, off
    WinGetPos, xPos, yPos, Width, Height, % BoxTitle
    NewX := MonitorCenterX - (Width / 2)
    NewY := MonitorCenterY - (Height / 2)
    Location := "x" . NewX . " y" . NewY
    WinMove, % BoxTitle, , %NewX%, %NewY%
    Return
}  ; end of IAMMsgBox

; -------------------------------------------------------------------------------
IAMGetCurrentMonitor(AppWindow)
{
    ; Detect the monitor based on parameter passed
    ; AppWindow can be one of "current", "primary" or a partial title of an app e.g. Service Manager
    SetTitleMatchMode, 2  ; guarantee we can do partial matches even if this is not set in the main code
    
    SysGet, numberOfMonitors, MonitorCount
    IfWinNotActive , , %AppWindow%
        WinActivate, , %AppWindow%
    
    if (InStr(AppWindow, "primary", CaseSensitive = false)) {
        return MonitorPrimary
    }
    
    if (InStr(AppWindow, "current", CaseSensitive = false)) {
        WinGetPos, winX, winY, winWidth, winHeight, A
    } else {
        ControlGet, MyHandle, Hwnd,,,%AppWindow%
        WinGetPos, winX, winY, winWidth, winHeight, %AppWindow%
    }
    winMidX := winX + winWidth / 2
    winMidY := winY + winHeight / 2
    Loop %numberOfMonitors%
    {
        SysGet, monArea, Monitor, %A_Index%
        if (winMidX > monAreaLeft && winMidX < monAreaRight && winMidY < monAreaBottom && winMidY > monAreaTop)
             Return A_Index
    }
    SysGet, primaryMonitor, MonitorPrimary
    Return "No Monitor Found"
}  ; end of IAMGetCurrentMonitor

; -------------------------------------------------------------------------------
IAMImageSize(ImageFile) {
    ; Detect the size of an image. Supports only GIF, JPG, BMP
    ; This returns a single string containing a semi-colon delimited width and height
    ; The calling code muse receive, then split and use the width and height itself
    IfNotExist, %ImageFile%
        Return ""
    Size=2592
    DHW:=A_DetectHiddenWindows
    DetectHiddenWindows, ON
    Gui, 99:-Caption
    Gui, 99:Margin, 0, 0
    Gui, 99:Show,Hide w%Size% h%Size%, ImageWxH.Temporary.GUI
    Gui, 99:Add, Picture, x0 y0 , % ImageFile
    Gui, 99:Show,AutoSize Hide, ImageWxH.Temporary.GUI
    WinGetPos, , ,w,h, ImageWxH.Temporary.GUI
    Gui, 99:Destroy
    DetectHiddenWindows, %DHW%
    Return w ";" h
}  ; end of IAMImageSize

; -------------------------------------------------------------------------------
; display a popup with help
miniHelp()
{
	miniHelpMessage =
	(
%Program%, %Version%: written by Allan Marillier using AutoHotkey
Compiled with AutoHotkey version %A_AhkVersion%

Win+C (Windows key and C) will immediately exit the program no matter what it is doing.
Win+Q (Windows key and Q) will pop up a menu on the active monitor with options
Win+T (Windows key and T) will toggle between Paused and Running states
	)

	IAMMsgBox(48, Program ": INFO", miniHelpMessage, 10, BindToApp)  ; 0 (ok) and 48 (exclamation image)
	return
}  ; end of miniHelp

; -------------------------------------------------------------------------------

; activate and if necessary maximize the specified window
WinMaxActivate(myWindow)
{
	WinActivate, %myWindow%
	WinGet, winStatus, MinMax, %myWindow%
	if not (winStatus = 1) {
		WinMaximize, %myWindow%
	}  ; end if not already maximized
	BlockInput, MouseMove
	if (clickXArray[A_Index] > 0 and  clickYArray[A_Index] > 0) {
		MouseClick, left, clickXArray[A_Index], clickYArray[A_Index]
	}  ; end if we have click coordinates
	BlockInput, MouseMoveOff
	return
}  ; end of function WinMaxActivate

; -------------------------------------------------------------------------------
; cycle through specified windows
WinCycle()
{
	while [1] {
		if (Active) {
			Loop %windowArrayCount%
			{
				element := windowArray[A_Index]
				if WinExist(element) {
					WinMaxActivate(element)
                    if (delayArray[A_Index]) {
                        customdelay := delayArray[A_Index]
                        Sleep, delayArray[A_Index]
                    }
                    else {
                        Sleep, %delay%
                }
				}  ; end if the window exists - otherwise no action if it has since gone away
				else {
					Sleep, 1000
				}  ; end if the window has been closed since we started
			}  ; end looping windowArray
		}  ; end if active flag is set
	}  ; end looping forever
	return
}  ; end of function WinCycle

; -------------------------------------------------------------------------------
; read config file to list all windows to cycle
ReadConfig()
{
	if FileExist(ConfigFile) {
		Loop, Read, %ConfigFile%
		{
			myLine := RegExReplace(A_LoopReadLine, ";.*","")  ; remove ; xxx style comments
			myLine := RegExReplace(myLine, "#.*","")  ; remove # xxx style comments
			myLine := RegExReplace(myLine, "(^\s+|\s+$)","")  ; remove leading and trailing whitespace
			if (StrLen(myLine)) {
				DelayFound := RegExMatch(myLine, "i)^Delay\s+\d+")  ; now check for Delay xx where xx must be digits
				if (DelayFound) {
					delayText := StrSplit(myLine, " ")
					if (RegExMatch(delayText[2], "^\d+$")) {
						delay := delayText[2] * 1000
					}  ; end if a valid digit delay
				}  ; end if a delay line
				else {
					appText := StrSplit(myLine, ",")
					appName := appText[1]
					appDelay := RegExReplace(appText[2],"\s+", "")
					if (appDelay = "") {
						appDelay = 0  ; %delay%
					}  ; end if delay is null use default delay
					else {
						appDelay := appDelay * 1000
					}  ; end if custom delay specified
					appXClick = 0
					appYClick = 0
					if (appText[3]) {
						appClick := RegExReplace(appText[3],"\s+", "")
						appXClick := RegExReplace(appClick,"y=\d+", "")
						appXClick := RegExReplace(appXClick,"x=", "")
						appYClick := RegExReplace(appClick,"x=\d+", "")
						appYClick := RegExReplace(appYClick,"y=", "")
					}  ; end if mouse click info was found
					if WinExist(appName) {
						windowArrayCount += 1
						; windowArray[windowArrayCount] := A_LoopReadLine
						windowArray[windowArrayCount] := appName
						delayArray[windowArrayCount] := appDelay
						clickXArray[windowArrayCount] := appXClick
						clickYArray[windowArrayCount] := appYClick
					}  ; if window is active
					else {
						Message =
						(
WARNING: Config file %ConfigFile% lists process %appName% which is not actively running`nThis process will be ignored!
						)
			IAMMsgBox(48, Program ":  WARNING! Missing process", Message, 5, BindToApp)  ; 0 (0k) and 48 (exclamation image)
					}  ; end if the specified window is not running
				}  ; end if not a delay line
			}  ; end if the line has text, not a blank line - no message displayed when blank lines are found!
		}  ; end looping and reading config file
	}  ; end if file exists
	else {
		Message =
		(
WARNING: No config file %ConfigFile% was not found. You need to create one with one line per window to be cycled, with as much unique window title text as possible
		)
		IAMMsgBox(48, Program ":  WARNING! CONFIG FILE IS MISSING", Message, 10, BindToApp)  ; 0 (0k) and 48 (exclamation image)
		ExitApp
	}  ; end if config file was not found
	return
}  ; end of function ReadConfig

; -------------------------------------------------------------------------------

ExitApp


; -------------------------------------------------------------------------------

; Now this is not the end. It is not even the beginning of the end. But it is, perhaps, the end of the beginning.
; Winston Churchill, November 10, 1942
; 
; Soli Deo gloria
; Molon Labe