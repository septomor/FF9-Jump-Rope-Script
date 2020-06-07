DetectHiddenWindows, On
#Persistent

buttonToPress := "Enter"


; ---------- Gui Setup -------------
Gui, -MaximizeBox
Gui, -MinimizeBox
Gui, Color, c282a36, c6272a4
Gui, Add, Button, x15 y25 w70 default, Start
Gui, Font, ce8dfe3 s9 w550 Bold
Gui, Add, Text, x100 y10, Button to press
Gui, Font, c758eff Bold, Verdana
Gui, Add, Radio, x100 y28 Checked altsubmit gButtonChange vButtonChoice group, X
Gui, Font, cff5754 Bold, Verdana
Gui, Add, Radio, altsubmit gButtonChange, O
Gui, Add, Edit, w130 x10 vColorFail
Gui, Add, Edit, w130 x10 vColorShadow
Gui, Show,w220 h150,  Vivi Jumps QueueTip + Sept
return

ButtonStart:
id := ""
SetKeyDelay, 100
Process, priority, , High
WinGet, remotePlay_id, List, ahk_exe RemotePlay.exe
Loop, %remotePlay_id%
{
  id := remotePlay_id%A_Index%
  WinGetTitle, title, % "ahk_id " id
  If InStr(title, "PS4")
    break
}
WinGetClass, remotePlay_class, ahk_id %id%
WinMove, ahk_id %id%,, 0, 0, 1440, 900
ControlFocus,, ahk_class %remotePlay_class%
WinActivate, ahk_id %id%
gosub, PauseLoop
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
sleep 2000
; ---------- Gui Setup End-------------

; ---------- Jump Loop -------------
loop {

i = 1

; jump intervals
a = 667
b = 532
c = 467
d = 433
e = 383
; f = not needed since 200-300 can be done with a single interval

g = 400
g2 = 401

delay = 100
balancer = 0
currentInterval := a
extraTime = 0

ToolTip, start, 400,400

; Initiate steps to begin
ControlSend,, {%buttonToPress% down}, ahk_id %id%  ; Press down the %buttonToPress% key.
DllCall("Sleep", "Uint", 100)
ControlSend,, {%buttonToPress% up}, ahk_id %id%  ; Release %buttonToPress% key.
Sleep, 2000
ControlSend,, {%buttonToPress% down}, ahk_id %id%  ; Press down the %buttonToPress% key.
DllCall("Sleep", "Uint", 100)
ControlSend,, {%buttonToPress% up}, ahk_id %id%  ; Release %buttonToPress% key.
Sleep, 3000
PixelGetColor, failColor, 644, 535, RGB
GuiControl,, ColorFail, %failColor%
PixelGetColor, jumpColor, 562, 416, RGB
GuiControl,, ColorShadow, %jumpColor%
ControlSend,, {%buttonToPress% down}, ahk_id %id%  ; Press down the %buttonToPress% key.
DllCall("Sleep", "Uint", 100)
ControlSend,, {%buttonToPress% up}, ahk_id %id%  ; Release %buttonToPress% key.

; Detect 1st jump
Loop {
PixelSearch, x, y, 562, 416, 562, 416, %jumpColor%, 20, Fast RGB
    If (ErrorLevel != 0) {
	sleep 480
	break
	}
}

start := A_TickCount + 50


loop
{
	; Detect if failed and back at the start to retry
	PixelSearch, x, y, 644, 535, 644, 535, %failColor%, 20, Fast RGB
    	If (ErrorLevel != 0) { ; reset
		ToolTip, failed, 400, 400
		sleep, 3000
		ControlSend,, {%buttonToPress% down}, ahk_id %id%  ; Press down the %buttonToPress% key.
		DllCall("Sleep", "Uint", 100)
		ControlSend,, {%buttonToPress% up}, ahk_id %id%  ; Release %buttonToPress% key.
		sleep, 2000
		break
	}

	; Manual override
	GetKeystate, state, %buttonToPress%
   	if (state = "D" and stop = 0)
	{
		break
   	}

	timer := A_TickCount - start

	if (i = 1) {
		currentInterval := a
	} else if (i = 21) {
		currentInterval := b
		balancer = 0
	} else if (i = 51) {
		currentInterval := c
		balancer = 0
	} else if (i = 101) {
		currentInterval := d
		balancer = 0
	} else if (i = 201) {
		;extraTime = 50
		delay = 70
		currentInterval := e
		balancer = 0
	} else if (i = 260) {
		extraTime = 20
		balancer = 0
	} else if (i = 301) {
		currentInterval := g
		balancer = 0
	} else if (i = 500 or i = 800) {
		currentInterval := g2
	} else if (i = 600 or i = 900) {
		currentInterval := g
	} else if (i => 1001) {
		if (Mod(i,2) = 0) {
			currentInterval := g
		} else {
			currentInterval := g2
		}
	}

	if(i > 1)
	{
		DllCall("Sleep", "Uint", (currentInterval - timer + balancer + extraTime))
	}
	Gosub, jump
}
}
return

jump:
fullTime := A_TickCount - start - extraTime
start := A_TickCount
if(i > 1) {
	balancer += currentInterval - fullTime
}
ToolTip, %i% - %fullTime%, 400, 400
ControlSend,, {%buttonToPress% down}, ahk_id %id%  ; Press down the %buttonToPress% key.
DllCall("Sleep", "Uint", delay)
ControlSend,, {%buttonToPress% up}, ahk_id %id%  ; Release %buttonToPress% key.
ToolTip
i += 1
extraTime = 0
return
; ---------- Jump Loop End-------------


ButtonChange:
Gui, submit, nohide
if (ButtonChoice = 1)
{
  buttonToPress := "Enter"
}
if (ButtonChoice = 2)
{
  buttonToPress := "Esc"
}
return

PauseLoop:
  Send, {%buttonToPress% Up}
  Send, {Esc Up}
  return

GuiClose:
gosub, PauseLoop
ExitApp

^Esc::ExitApp

r::Reload

a::Process, priority, , High
