DetectHiddenWindows, On
#Persistent
#NoEnv

buttonToPress := "Enter"

; --------- Constants 
; jump intervals
a = 667
b = 532
c = 467
d = 433
e = 383
; f = not needed since 200-300 can be done with a single interval

g = 400
g2 = 401

latency = 710
script = 1
; ---------- Gui Setup -------------
Gui, -MaximizeBox
Gui, -MinimizeBox
Gui, 2: -MaximizeBox
Gui, 2: -MinimizeBox
Gui, Color, c282a36, c6272a4
Gui, Add, Button, x15 y10 w70 default, Start
Gui, Add, Button, x15 y40 w70 default gVariableWindow, Variables
Gui, Font, ce8dfe3 s9 w550 Bold
Gui, Add, GroupBox, x90 y10 w120 h60, Button to press
Gui, Font, c758eff Bold, Verdana
Gui, Add, Radio, x100 y28 Checked altsubmit gButtonChange vButtonChoice group, X
Gui, Font, cff5754 Bold, Verdana
Gui, Add, Radio, altsubmit gButtonChange,  O
Gui, Font, ce8dfe3 s8 w550 Bold
Gui, Add, GroupBox, x15 y70 w190 h40, Script
Gui, Add, Radio, x25 y90 Checked altSubmit gScriptChange vScriptChoice group, QueueTip
Gui, Add, Radio, x115 y90 altSubmit gScriptChange, Septomor
;--------- Gui 2 Setup --------------
Gui, 2: Color, c535770, c6272a4
Gui, 2: Font, c11f s9 Bold
Gui, 2: Add, Text,, Jumps 2-19
Gui, 2: Add, Edit,  w40 vA, %a%
Gui, 2: Add, Text,, Jumps 20-49
Gui, 2: Add, Edit,  w40 vB, %b%
Gui, 2: Add, Text,, Jumps 50-99
Gui, 2: Add, Edit,  w40 vC, %c%
Gui, 2: Add, Text,, Jumps 100-199
Gui, 2: Add, Edit,  w40 vD, %d%
Gui, 2: Add, Text, x100 y10, Jumps 200-299
Gui, 2: Add, Edit,  w40 x100 y25 vE, %e%
Gui, 2: Add, Text, x100 y50, Jumps 300+
Gui, 2: Add, Edit,  w40 x100 y65 vG, %g%
Gui, 2: Add, Edit,  w40 x100 y90 vG2, %g2%
Gui, 2: Font, ccc3429 s9 Bold
Gui, 2: Add, Text, x100 y120, Latency
Gui, 2: Font, c11f s9 Bold
Gui, 2: Add, Edit, w40 x100 y135 vLat, %latency%
Gui, 2: Add, Button, x20  y192 gSaveVars, Save 
Gui, 2: Add, Button, x100 y192 gVarDef, Defaults 
Gui, Show,w220 h120,  Vivi Jumps QueueTip + Sept
return

VariableWindow:
Gui, 2: Show, w210 h225, Variables
return

SaveVars:
Gui, 2:Submit
GuiControlGet, a, 2:, A
GuiControlGet, b, 2:, B
GuiControlGet, c, 2:, C
GuiControlGet, d, 2:, D
GuiControlGet, e, 2:, E
GuiControlGet, g, 2:, G
GuiControlGet, g2, 2:, G2
GuiControlGet, latency, 2:, Lat
return

VarDef:
a = 667
b = 532
c = 467
d = 433
e = 383
g = 400
g2 = 401
Lat = 710
GuiControl, 2:, A, %a%
GuiControl, 2:, B, %b%
GuiControl, 2:, C, %c%
GuiControl, 2:, D, %d%
GuiControl, 2:, E, %e%
GuiControl, 2:, G, %g%
GuiControl, 2:, G2, %g2%
GuiControl, 2:, Lat, %lat%
return

ButtonStart:
Gui, Submit, NoHide
id := ""
SetKeyDelay, 100
Process, priority, , High
gosub, GrabRemotePlay
if  (id = "")
	return
gosub, PauseLoop
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
sleep 2000
if(script = 1)
	gosub, QueueTipS
else if(script = 2)
	gosub, SeptS
; ---------- Gui Setup End-------------

; ---------- Jump Loop -------------
; ---------- QueueTip
QueueTipS:
loop {

i = 1

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
PixelGetColor, jumpColor, 562, 416, RGB
ControlSend,, {%buttonToPress% down}, ahk_id %id%  ; Press down the %buttonToPress% key.
DllCall("Sleep", "Uint", 100)
ControlSend,, {%buttonToPress% up}, ahk_id %id%  ; Release %buttonToPress% key.

; Detect 1st jump

Loop {
PixelSearch, x, y, 562, 416, 562, 416, %jumpColor%, 20, Fast RGB
    If (ErrorLevel != 0) {
	DllCall("Sleep", "Uint",  latency - 220 )
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

    Gosub, timings
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

; ------- Septomor
SeptS:
loop{
i = 1

delay = 100
balancer = 0
currentInterval := a
extraTime = 0
ToolTip, start, 400,300
SendMode, Input

Send, {%buttonToPress% down}
Sleep, 100
Send {%buttonToPress% up}
Sleep, 2000
Send, {%buttonToPress% down}
Sleep, 100
Send {%buttonToPress% up}
Sleep, 3000
PixelGetColor, failColor, 644, 535, RGB
Send, {%buttonToPress% down}
Sleep, 100
Send {%buttonToPress% up}
Sleep, %latency%
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
		gosub, GrabRemotePlay
		break
	}
	gosub timings
	gosub, InputJump
}
}

timings:
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
return

inputJump:
fullTime := A_TickCount - start - extraTime
start := A_TickCount
if(i > 1) {
	balancer += currentInterval - fullTime
}
ToolTip, %i% - %fullTime%, 400, 400
Send, {%buttonToPress% down}    ; Press down the %buttonToPress% key.
Sleep, delay
Send {%buttonToPress% up}   ; Release %buttonToPress% key.
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

GrabRemotePlay:
WinGet, remotePlay_id, List, ahk_exe RemotePlay.exe
if (remotePlay_id = 0)
{
	MsgBox, PS4 Remote Play not found
	return
}
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
return

ScriptChange:
Gui, submit, nohide
if (ScriptChoice = 1)
{
	script = 1
}
if (ScriptChoice = 2)
{
	script = 2
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