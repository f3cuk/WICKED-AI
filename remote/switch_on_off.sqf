private["_state"];

_state = player getVariable["radiostate",true];

if(_state) then {
	systemChat "[RADIO] OFF";
	player setvariable["radiostate",false];
} else {
	systemChat "[RADIO] ON";
	player setvariable["radiostate",true];
};