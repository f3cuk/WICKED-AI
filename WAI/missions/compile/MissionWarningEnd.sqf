private ["_msg","_text", "_vehicle_spawn", "_mission_warning_debug", "_marker_name", "_marker_pos", "_vehicle", "_nearestCity"];
	
	_mission_warning_debug = _this select 0;
	_marker_pos  = _this select 1;
	_text = _this select 2;
	
	/*_nearestCity = nearestLocations [_marker_pos, ["NameCityCapital","NameCity","NameVillage","NameLocal"],500];
	//diag_log format ["DEBUG MISSIONS: _nearestCity: %1", _nearestCity];
	
	if ((count _nearestCity) > 0) then {
		if (((text(_nearestCity select 0)) == "Center") && ((count _nearestCity) > 1)) then {
			_msg = "The Bandits have moved on. " + (text (_nearestCity select 1)) + " is now safe again.";
		} else {
			_msg = "The Bandits have moved on. " + (text (_nearestCity select 0)) + " is now safe again.";
		};
	} else {
		_msg = "Bandits have gone home.";
	};*/

	if (_mission_warning_debug) then {
		_hint = parseText format["<t align='center' color='#007f00' shadow='1' size='2'>Mission Over</t><br/><t size='1.0' font='Bitstream' align='center' color='#ffffff'>%2</t><br/>",_text];
		customRemoteMessage = ['hint',_hint];
		publicVariable "customRemoteMessage";
	} else {
		titleText [_text, "PLAIN",6];
	};
