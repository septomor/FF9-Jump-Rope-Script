t::
tooltip % "started"
stop = 0
pause

Loop
{
	If stop = 1
		Break
	Else
	{
		Send {Up up}
		Send {Down down}
		tooltip % "Up"
		Sleep 20
		Send {Up down}
		Send {Down up}
		tooltip % "Down"
		Sleep 20
		Send {enter down}
		Send {enter up}
		Send {enter down}
		Send {enter up}
	}
}

tooltip % "Script Over"
Send {Up up}
Send {Down up}
Send {enter up}

exitapp

esc::pause ; esc = pause, esc again = continue
^esc::exitapp ; ctrl+esc = terminate program
b::stop = 1