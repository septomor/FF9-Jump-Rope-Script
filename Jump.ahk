t::
tooltip % "started"
pause
sleep 2
send {enter down}
sleep 50
send {enter up}

; YOUR LATENCY 
sleep  850

; rang 3-19


loop 9{
	Send {enter down}
sleep 50 
Send {enter up}
sleep 593
Send {enter down}
sleep 50 
Send {enter up}
sleep 588
}
;  rang 19 - 49
loop 15{
	Send {enter down}
sleep 50 
Send {enter up}
sleep 460
Send {enter down}
sleep 50 
Send {enter up}
sleep 440
}
; rang 50 -99
loop 10{
	Send {enter down}
sleep 50 
Send {enter up}
sleep 390.01
}
loop 20{
	Send {enter down}
sleep 50 
Send {enter up}
sleep 388
}
loop 20{
	Send {enter down}
sleep 50 
Send {enter up}
sleep 390.01
}
;100
loop 20{
	Send {enter down}
sleep 50
Send {enter up}
sleep 355
}
loop 10{
	Send {enter down}
sleep 50
Send {enter up}
sleep 349
}
;130
loop 25{
	Send {enter down}
sleep 50
Send {enter up}
sleep 355
}
;155
loop 10{
	Send {enter down}
sleep 50
Send {enter up}
sleep 349
}
;165
loop 25{
	Send {enter down}
sleep 50
Send {enter up}
sleep 353
}
;190
loop 10{
	Send {enter down}
sleep 50
Send {enter up}
sleep 349
}

;200
loop 5{
	Send {enter down}
sleep 45
Send {enter up}
sleep 305
Send {enter down}
sleep 45
Send {enter up}
sleep 310
}
;210
loop 30{
	Send {enter down}
sleep 45
Send {enter up}
sleep 300
Send {enter down}
sleep 45
Send {enter up}
sleep 312
}
;260
loop 10{
	Send {enter down}
sleep 45
Send {enter up}
sleep 300
Send {enter down}
sleep 45
Send {enter up}
sleep 310
}

;290?
loop 5{
	Send {enter down}
sleep 45
Send {enter up}
sleep 300
Send {enter down}
sleep 45
Send {enter up}
sleep 310
}

;300 (the big ka-hoon-a)
loop 10{
loop 14{
Send {enter down}
sleep 50 
Send {enter up}
sleep 315
Send {enter down}
sleep 50 
Send {enter up}
sleep 325
}
sleep 5
;328
Loop 3{
Send {enter down}
sleep 50 
Send {enter up}
sleep 310
Send {enter down}
sleep 50 
Send {enter up}
sleep 320
}
;334
loop 4{
Send {enter down}
sleep 50 
Send {enter up}
sleep 320
Send {enter down}
sleep 50 
Send {enter up}
sleep 330
}
;342
loop 4{
Send {enter down}
sleep 50 
Send {enter up}
sleep 317
Send {enter down}
sleep 50 
Send {enter up}
sleep 327
}
;350
loop 4{
Send {enter down}
sleep 50 
Send {enter up}
sleep 310
Send {enter down}
sleep 50 
Send {enter up}
sleep 320
}
;358
Send {enter down}
sleep 50 
Send {enter up}
sleep 320
Send {enter down}
sleep 50 
Send {enter up}
sleep 325
sleep 20
;360
loop 5{
Send {enter down}
sleep 50 
Send {enter up}
sleep 330
Send {enter down}
sleep 50 
Send {enter up}
sleep 325
}
;370
loop 15{
Send {enter down}
sleep 50 
Send {enter up}
sleep 315
Send {enter down}
sleep 50 
Send {enter up}
sleep 325
}
sleep 20
}
tooltip % "Why are you still jumping, go enjoy the game ^_^"
sleep 3000
ToolTip % "Auto-exiting script, enjoy your trophy!"
sleep 1000
ExitApp

Pause

esc::pause ; esc = pause, esc again = continue
^esc::exitapp ; ctrl+esc = terminate program