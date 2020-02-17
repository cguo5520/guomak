#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Capslock::Control   ; make Caps Lock the control button

[::BackSpace

]::vkFF ; no-map key
] & q::+
] & w::-
] & f::*
] & p::/
] & g::SendInput `%
] & j::^
] & l::&
] & u::*
] & y::(
] & `;::)
] & a::<
] & r::{
] & s::[
] & t::(
] & d::_
] & h::@
] & n::)
] & e::]
] & i::}
] & o::>
] & '::=
] & Space::=