expand_to_paragraph:
!å:: send {up}{home}
loop,    ;# find start of paragraph
    {
    send +{right}   ; check first character
    selected := selected()
    send {left}     ; reset selection
    if selected is space    ; if space, tab or linefeed
        break
    send {up}       ; else try next line
    }

send {down}{home}
loop,    ;# find end of paragraph
    {
    send +{down}
    last_4 := subStr(selected(), -3, 4)   ; last 4 characters
    if last_4 is space
        break
    }

paragraph := trim(selected(), "`r`n")
return

selected() {
    clipboard := ""
    send ^{c}
    clipWait, 0.2
    return clipboard
}