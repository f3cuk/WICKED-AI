if(isServer) then {
	
	private ["_safepos","_validspot","_position"];

	waitUntil {markerready};

	markerready = false;

	if(use_blacklist) then {
		_safepos		= [getMarkerPos "center",5,7000,(_this select 0),0,0.5,0,blacklist];
	} else {
		_safepos		= [getMarkerPos "center",0,5000,(_this select 0),0,0.5,0];
	};

	_position = _safepos call BIS_fnc_findSafePos;

	for "_i" from 0 to 1000 do {
		_position = _safepos call BIS_fnc_findSafePos;
		_validspot = true;
		{
			if (getMarkerColor _x == "") exitWith {};
			if ([_position, 50, 20] call isSlope) 				exitWith {_validspot = false;}; //diag_log("WAI: Invalid Position (Slope)"); 
			if ([_position, wai_near_water] call isNearWater) 	exitWith {_validspot = false;}; //diag_log("WAI: Invalid Position (Water)");
			if ([_position, wai_near_town] call isNearTown) 	exitWith {_validspot = false;}; //diag_log("WAI: Invalid Position (Town)"); 
			if ([_position, wai_near_road] call isNearRoad) 	exitWith {_validspot = false;}; //diag_log("WAI: Invalid Position (Road)");
			//diag_log(format["WAI: Marker loop %1 %2 %3:%4 distance %5.", _i, _position, _x, (getMarkerPos _x), (_position distance (getMarkerPos _x))]);
			if ((_position distance (getMarkerPos _x)) < wai_mission_spread) exitWith {_validspot = false;}; //diag_log(format["WAI: Invalid Position (Marker:%1)", _x]); 
		} forEach wai_mission_markers;
		//diag_log("Loop complete, valid position: " +str(_validspot));
		if (_validspot) exitWith { };
	};
	_position
};