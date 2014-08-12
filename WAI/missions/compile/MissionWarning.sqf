private ["_msg","_text", "_vehicle_spawn", "_mission_warning_debug", "_marker_name", "_marker_pos", "_vehicle", "_nearestCity"];

	_mission_warning_debug = _this select 0;
	_marker_pos  = _this select 1;
	_vehicle = _this select 2;
	_text = _this select 3;

	_nearestCity = nearestLocations [_marker_pos, ["NameCityCapital","NameCity","NameVillage","NameLocal"],500];
	//_pic = (gettext (configFile >> 'CfgWeapons' >> 'Kostey_notepad' >> 'picture'));
	_pic = (gettext (configFile >> 'CfgVehicles' >> _vehicle >> 'picture'));
	
	if ((count _nearestCity) > 0) then {
		if (((text(_nearestCity select 0)) == "Center") && ((count _nearestCity) > 1)) then {
			//diag_log format ["DEBUG MISSIONS: _nearestCity: %1", (text (_nearestCity select 1))];
			_msg = _text + " it's rumored they have been spottet near " + (text (_nearestCity select 1));
		} else {
			//diag_log format ["DEBUG MISSIONS: _nearestCity: %1",(text (_nearestCity select 0))];
			_msg = _text + " it's rumored they have been spottet near " + (text (_nearestCity select 0));
		};
	} else {
		_msg = _text;
	};

	if (_mission_warning_debug) then {
		_hint = parseText format["
		<t align='center' color='#FF0033' shadow='1' size='2'>Check your map</t><br/>
		<img align='Center' size='5' image='%1'/><br/>
		<t size='1.0' font='Bitstream' align='center' color='#ffffff'>%2</t><br/>",_pic,_msg];
		customRemoteMessage = ['hint',_hint];
		publicVariable "customRemoteMessage";
	} else {
		titleText [_msg, "PLAIN",6];
	};
