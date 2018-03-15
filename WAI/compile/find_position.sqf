private ["_i","_traders","_safepos","_validspot","_position"];

markerready = false;

if (use_blacklist) then {
	_safepos = [getMarkerPos "center",0,8500,(_this select 0),0,0.5,0,blacklist];
} else {
	_safepos = [getMarkerPos "center",0,8500,(_this select 0),0,0.5,0];
};

_i = 0;
_validspot = false;

while {!_validspot} do {
	_i			= _i + 1;
	_position 	= if (!use_staticspawnpoints) then {_safepos call BIS_fnc_findSafePos} else {staticspawnpoints call BIS_fnc_selectRandom};
	_validspot 	= true;

	_color = "ColorBlack";
	if (_position call inDebug) then {
		_color = "ColorPink";
		if (debug_mode) then {diag_log "WAI: Invalid Position (Debug)";};
		_validspot = false;
	}; 

	if (_validspot && {wai_avoid_missions != 0}) then {
		{
			if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_avoid_missions)) exitWith {
				if (debug_mode) then {diag_log format ["WAI: Invalid Position (Marker: %1)",_x];};
				_validspot = false;
			};
		} count wai_mission_markers;
	};

	if (_validspot && {wai_avoid_traders != 0}) then {
		{
			if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_avoid_traders)) exitWith {
				if (debug_mode) then {diag_log format ["WAI: Invalid Position (Marker: %1)",_x];};
				_color = "ColorBrown";
				_validspot = false;
			};
		} count trader_markers;
	};

	if (_validspot && {wai_avoid_water != 0}) then {
		if ([_position,wai_avoid_water] call isNearWater) then {
			if (debug_mode) then {diag_log "WAI: Invalid Position (Water)";};
			_color = "ColorBlue";
			_validspot = false;
		}; 
	};

	if (_validspot && {wai_avoid_town != 0}) then {
		if ([_position,wai_avoid_town] call isNearTown) then {
			if (debug_mode) then {diag_log "WAI: Invalid Position (Town)";};
			_color = "ColorGreen";
			_validspot = false;
		};
	};

	if (_validspot && {wai_avoid_road != 0}) then {
		if ([_position,wai_avoid_road] call isNearRoad) then {
			if (debug_mode) then {diag_log "WAI: Invalid Position (Road)";};
			_color = "ColorGrey";
			_validspot = false;
		};
	};

	if (_validspot && {wai_avoid_players != 0}) then {
		if ([_position,wai_avoid_players] call isNearPlayer) then {
			if (debug_mode) then {diag_log "WAI: Invalid Position (player)";};
			_color = "ColorPink";
			_validspot = false;
		};
	};

	if (!_validspot) then {
		if (debug_mode) then {
			_marker = createMarkerLocal ["spotMarker" + (str _i),[_position select 0,_position select 1]];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "DOT";
			_marker setMarkerColorLocal _color;
			_marker setMarkerSizeLocal [1.0, 1.0];
			_marker setMarkerTextLocal "fail";
		};
	};

	if (_validspot) then {
		if (debug_mode) then {diag_log format ["Loop complete, valid position %1 in %2 attempts.",_position,_i];};
	} else {
		uiSleep 0.5;
	};
};

_position set [2, 0];
_position
