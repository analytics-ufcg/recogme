//reference: http://www.javascripter.net/faq/keycodes.htm

var keycodes = new Array();

keycodes[8] = "Backspace"
keycodes[9] = "Tab"
keycodes[13] = "Enter"
keycodes[16] = "Shift"
keycodes[17] = "Ctrl"
keycodes[18] = "Alt"
keycodes[19] = "Pause" //Break
keycodes[20] = "CapsLock"
keycodes[27] = "Esc"
keycodes[32] = "Space"

keycodes[33] = "PageUp"
keycodes[34] = "PageDown"
keycodes[35] = "End"
keycodes[36] = "Home"

keycodes[37] = "Leftarrow"
keycodes[38] = "Uparrow"
keycodes[39] = "Rightarrow"
keycodes[40] = "Downarrow"

keycodes[44] = "PrntScrn"
keycodes[45] = "Insert"
keycodes[46] = "Delete"

//48-57      0 to 9
// 65-90      A to Z
keycodes[91] = "WINKey(Start)" 
keycodes[93] = "WINMenu"

//112-123     F1 to F12

keycodes[144] = "NumLock"
keycodes[145] = "ScrollLock"

keycodes[188] = ",<"
keycodes[190] = ".>"
keycodes[191] = "/?"
keycodes[192] = "`~"

keycodes[219] = "[{"
keycodes[220] = "\\|"
keycodes[221] = "]}"
keycodes[222] = "'" + '"' 

//The following key codes differ across browsers:

keycodes[173] = "MuteOn|Off" //firefox: 181
keycodes[181] = "MuteOn|Off"

keycodes[174] = "VolumeDown" //firefox: 182
keycodes[182] = "VolumeDown"

keycodes[175] = "VolumeUp" //firefox:  183
keycodes[183] = "VolumeUp"

keycodes[186] = ";:" //firefox: 59
keycodes[59] = ";:"

keycodes[187] = "=+" //firefox: 61
keycodes[61] = "=+"

keycodes[189] = "-_" //firefox: 173
keycodes[173] = "-_"