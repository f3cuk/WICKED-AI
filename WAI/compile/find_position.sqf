if(isServer) then {
	
	private ["_traders","_safepos","_validspot","_position"];

	waitUntil {markerready};

	if(use_blacklist) then {
		_safepos		= [getMarkerPos "center",5,9500,(_this select 0),0,2000,0,blacklist];
	} else {
		_safepos		= [getMarkerPos "center",0,9500,(_this select 0),0,2000,0];
	};

	_position = _safepos call BIS_fnc_findSafePos;

	for "_i" from 0 to 1000 do {
		_position = _safepos call BIS_fnc_findSafePos;
		_validspot = true;
		if (_validspot && _position call inDebug)						then {_validspot = false;}; //diag_log("WAI: Invalid Position (Debug)");
		if (_validspot && [_position, 50, 30] call isSlope) 			then {_validspot = false;}; //diag_log("WAI: Invalid Position (Slope)");
		if (_validspot && [_position, wai_near_water] call isNearWater) then {_validspot = false;}; //diag_log("WAI: Invalid Position (Water)");

		if (isNil 'fnc_infiSTAR_Publish') then {
			if (_validspot && [_position, wai_near_town] call isNearTown) 	then {_validspot = false;}; //diag_log("WAI: Invalid Position (Town)");
		}; // ELSE infoSTAR is enabled, need to find another method of finding near Towns

		if (_validspot && [_position, wai_near_road] call isNearRoad) 	then {_validspot = false;}; //diag_log("WAI: Invalid Position (Road)");
		if(debug_mode && _validspot) then { diag_log("WAI DEBUG: FINDPOS: Checking nearby mission markers: " + str(wai_mission_markers)); };
		if (_validspot && wai_avoid_missions) then {
			{
				if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_mission_spread)) exitWith {_validspot = false; diag_log(format["WAI: Invalid Position (Marker:%1)", _x]); };
			} forEach wai_mission_markers;
		};
		if(debug_mode && _validspot) then { diag_log("WAI DEBUG: FINDPOS: Checking nearby trader markers: " + str(trader_markers)); };
		if (_validspot && wai_avoid_traders) then {
			{
				if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_mission_spread)) exitWith {_validspot = false; diag_log(format["WAI: Invalid Position (Marker:%1)", _x]); };
			} forEach trader_markers;
		};

		if (_validspot) exitWith { diag_log("Loop complete, valid position " +str(_position) + " in " + str(_i) + " attempts."); };
	};
	_position
};