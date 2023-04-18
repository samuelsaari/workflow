
; zoterosta alkaen voi jatkaa

;RunOrActivate(Robust) function
roar(ID_1,TARGET_1="",EX_TITLE:="",EX_AHK:="", TARGET_2:="notepad.exe",ID_2:="")
;-------------------------------------------------------------------------------
;ID_1		= 1st critria to identify an existing window
;TARGET_1	= executable program or a path to it
;EX_TITLE	= exclude windows with titles that start with a given string
;EX_AHK		= exclude processes (eg. ahk_exe firefox.ex) or strings in a window
;TARGET_2	= alternative path to an excecutable file (if for example the paths are different in different machines you use)
;ID_2 = 	= 2nd criteria to identify an existing window (not implemented yet)
;-------------------------------------------------------------------------------
{
;Creating groups with a uniques names;
	SetTitleMatchMode, 1
	this_group=%A_DDD%%A_YDay%%A_Hour%%A_Min%%A_MSec%
	this_group1=% this_group "1"
	this_group2=% this_group "2"
	if (EX_TITLE=="") && (EX_AHK=="") {
		GroupAdd, %this_group%, %ID_1%
	} else {
		GroupAdd, %this_group1%, %ID_1%
		extitle_str:= % EX_TITLE
		GroupAdd, %this_group2%,ahk_group %this_group1%, , ,%extitle_str%
		GroupAdd, %this_group%,ahk_group %this_group2%, , , , %EX_AHK%
	}
; checking if the windows is active
	if WinActive("ahk_group" . this_group) {
		WinGet, num, count,ahk_group %this_group%
		;MsgBox, %num%
		; if only one window minimize or maximize
		if (num==1) || (ID_1=="ahk_exe spotify.exe")						; for some reason it identifies 3 windows for spotify
			{
			WinGet,WinState,MinMax,ahk_group %this_group%
			If WinState = -1 
				WinRestore ;was WinMaximize	
				; MsgBox, winstate -1
			 else 
				WinMinimize
				;MsgBox, winstate up front
			} 
		; if multiple windows, toggle
		else 
		{
		;msgbox, multiple windows
		WinGet, List, List, ahk_group %this_group%
		Loop, % List
			{
				index := List - A_Index + 1
				WinGet, State, MinMax, % "ahk_id " List%index%
				if (State <> -1)
				{
					WinID := List%index%
					break
				}
			}
		WinActivate, % "ahk_id " WinID
		return
		}
	}
; activate window if exists but not active
	else if WinExist("ahk_group" . this_group) {
		;msgbox, activate window
		WinActivate
	}
; if window does not exist, run the target
	else
	{	
		try {
			If InStr(TARGET_1, "\")==1 {  
				Run, % UserProfile . TARGET_1
				;MsgBox, % TARGET_1
			} Else 
				Run, %TARGET_1%
		} catch e {
			MsgBox, Trying to run target_2
			If InStr(TARGET_2, "\")==1 {
				Run, % UserProfile . TARGET_2
			} Else 
				Run, %TARGET_2%
		}
	;MsgBox, waiting
	WinWait, ahk_group this_group,,2
	WinActivate, ahk_group this_group
	}
	Return
}

<!LWin::
{
SetTitleMatchMode,3
	if WinExist("Google Keep")
		if WinActive()
			WinMinimize
		else
			WinActivate
	else
		try {
		Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --app=https://keep.google.com
	} catch e {
		Run "C:\Program Files\Google\Chrome\Application\chrome.exe" --app=https://keep.google.com
	}
		
	return
SetTitleMatchMode,1
}
<^!LWin::roar("Google Keep", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --app=https://keep.google.com", TARGET_2:="C:\Program Files\Google\Chrome\Application\chrome.exe --app=https://keep.google.com")


!.::roar(ID_1:="ahk_exe spotify.exe",TARGET_1:="\AppData\Roaming\Spotify\Spotify.exe", TARGET_2:="\AppData\Local\Microsoft\WindowsApps\Spotify.exe")
;A few examples of use
^!o::roar("ahk_exe opera.exe", "opera.exe")
^!a::roar("ahk_class CabinetWClass", "explorer.exe")
^!SHIFT::roar("ahk_exe chrome.exe", "chrome.exe", "Google Keep")
<^!x::roar("Zoom","\AppData\Roaming\Zoom\bin\Zoom.exe") ; %A_Username%
<^!d::roar("ahk_exe teams.exe", "\AppData\Local\Microsoft\Teams\Update.exe --processStart Teams.exe")
<^!CAPSLOCK::roar("ahk_class MozillaWindowClass", "firefox.exe",EX_TITLE:="Quick Format Citation",EX_AHK:="ahk_exe zotero.exe")
 
<^!m::roar("ahk_class Notepad++", "notepad++.exe")
<^!q::roar("ahk_exe excel.exe", "excel.exe")
<^!i::roar("Photos ahk_exe ApplicationFrameHost.exe","ms-photos:")
; SnippingTool
<!k::roar("Snip & Sketch ahk_class ApplicationFrameWindow", "ms-screenclip:?source=QuickActions")
<^!c::roar("ahk_exe powershell.exe","C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")



	