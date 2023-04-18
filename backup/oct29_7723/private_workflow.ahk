
; Preliminaries
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
Global UserProfile ; Make userprofile a global variable
EnvGet, UserProfile, UserProfile ; Get userprofile from system variables

; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Private autohotkeys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;
;; Likely only me ;;
;;;;;;;;;;;;;;;;;;;;



/*
<!<^::
Return
*/

;REFERENCE MISSING
;reference missing / add reference later
<^<!r::
Send,{(}{!}{!}{!}REF{)}
Return

;TEXSTUDIO
; typing \keys
#IfWinActive ahk_exe texstudio.exe
<^k::
;Send, keys
Send,  {\}keys{{}{}}{left}
;Send, {left}
Return
#IfWinActive
Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PRIVATE ;;;;;
;;;;;;;;;;;;;;;;

<^!w::
MsgBox, This is a test, and it works nicely
Return


;[FLH-THESIS]
<^!t::
Send,[FLH-THESIS]
Return

;PUHTI DIRECTORIES
<^<!p::
Send,/projappl/project_2003758
Return

<^<!s::
Send,/scratch/project_2003758/makimiik
Return

<^<!u::
Send,/users/makimiik
Return

;GIT
; Git most frequently used path
<^<!g::
Send, C:\Users\mmak\OneDrive - Väestöliitto ry\FLH-THESIS\2_Outcomes_Bachelor\2_outcomes_publish
Return


; Git most frequently used path
<^<!h::
Send, C:\Users\mmak\OneDrive\Autohotkey
Return



; Git add autohotkey changes
<^<+!h::
Send, git add Useful_material/ stata_workflow.ahk windows_workflow.ahk word_macros.txt README.md
Return


; Texcount
#IfWinActive, ahk_exe cmd.exe
<^<!c::
Send, texcount -inc -total 2outcomes.tex
Return
#IfWinActive


