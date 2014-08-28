if(isServer) then {
	
	private ["_safepos","_validspot","_position"];

	waitUntil {markerready};

	markerready = false;

	if(use_blacklist) then {
		_safepos		= [getMarkerPos "center",5,9500,(_this select 0),0,2000,0,blacklist];
	} else {
		_safepos		= [getMarkerPos "center",0,9500,(_this select 0),0,2000,0];
	};

	_position = _safepos call BIS_fnc_findSafePos;

	if(debug_mode) then { diag_log("Checking markers: " + str(wai_mission_markers)); };

	for "_i" from 0 to 1000 do {
		_position = _safepos call BIS_fnc_findSafePos;
		_validspot = true;
		if (_validspot && _position call inDebug)						then {_validspot = false;}; //diag_log("WAI: Invalid Position (Debug)");
		if (_validspot && [_position, 50, 30] call isSlope) 			then {_validspot = false;}; //diag_log("WAI: Invalid Position (Slope)");
		if (_validspot && [_position, wai_near_water] call isNearWater) then {_validspot = false;}; //diag_log("WAI: Invalid Position (Water)");
		//if (_validspot && [_position, wai_near_town] call isNearTown) 	then {_validspot = false;}; //diag_log("WAI: Invalid Position (Town)"); //infiSTAR.de RE detection problem
		if (_validspot && [_position, wai_near_road] call isNearRoad) 	then {_validspot = false;}; //diag_log("WAI: Invalid Position (Road)");
		if (_validspot) then {
			{
				if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_mission_spread)) exitWith {_validspot = false; diag_log(format["WAI: Invalid Position (Marker:%1)", _x]); };
			} forEach wai_mission_markers;
		};
		if (_validspot) exitWith { diag_log("Loop complete, valid position " +str(_position) + " in " + str(_i) + " attempts."); };
	};
	_position
};
