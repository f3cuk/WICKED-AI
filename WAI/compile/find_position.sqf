if(isServer) then {
	
	private ["_traders","_safepos","_validspot","_position"];

	waitUntil {markerready};

	if(use_blacklist) then {
		_safepos		= [getMarkerPos "center",5,9500,(_this select 0),0,0.5,0,blacklist];
	} else {
		_safepos		= [getMarkerPos "center",0,9500,(_this select 0),0,0.5,0];
	};

	_validspot = false;

	while{!_validspot} do {

		_position 	= _safepos call BIS_fnc_findSafePos;
		_validspot	= true;

		if (_position call inDebug) exitWith { _validspot = false; }; //diag_log("WAI: Invalid Position (Debug)");

		if(wai_near_water != 0) then {
			if ([_position,wai_near_water] call isNearWater) exitWith { _validspot = false; }; //diag_log("WAI: Invalid Position (Water)");
		};

		if (isNil "infiSTAR_LoadStatus1" && wai_near_town != 0))) then {
			if ([_position,wai_near_town] call isNearTown) exitWith { _validspot = false; }; //diag_log("WAI: Invalid Position (Town)");
		}; // ELSE infoSTAR is enabled, need to find another method of finding near Towns

		if(wai_near_water != 0) then {
			if ([_position,wai_near_road] call isNearRoad) exitWith { _validspot = false; }; //diag_log("WAI: Invalid Position (Road)");
		};

		if(debug_mode) then { diag_log("WAI DEBUG: FINDPOS: Checking nearby mission markers: " + str(wai_mission_markers)); };

		if (wai_avoid_missions) then {
			{
				if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_mission_spread)) exitWith { _validspot = false; };
			} count wai_mission_markers;
		};

		if(debug_mode) then { diag_log("WAI DEBUG: FINDPOS: Checking nearby trader markers: " + str(trader_markers)); };

		if (wai_avoid_traders) then {
			{
				if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_mission_spread)) exitWith { _validspot = false; };
			} count trader_markers;
		};

		diag_log("Loop complete, valid position " +str(_position) + " in " + str(_i) + " attempts.");
	};

	_position
};