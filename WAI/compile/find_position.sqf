private ["_i","_traders","_safepos","_validspot","_position","_color"];

if (wai_use_blacklist) then {
	_safepos = [getMarkerPos "center",150,((getMarkerSize "center") select 1),(_this select 0),0,0.4,0,wai_blacklist];
} else {
	_safepos = [getMarkerPos "center",150,((getMarkerSize "center") select 1),(_this select 0),0,0.4,0];
};

_i = 0;
_validspot = false;

while {!_validspot} do {
	_i			= _i + 1;
	_position 	= if (!wai_user_spawnpoints) then {_safepos call BIS_fnc_findSafePos} else {WAI_StaticSpawnPoints call BIS_fnc_selectRandom};
	_validspot 	= true;
	
	// if the count of the selected position is more than two BIS_fnc_findSafePos failed 
	if ((count _position) > 2) then {
		_validspot = false;
		_color = "ColorBlue";
	};
	
	if (wai_avoid_samespot) then {
		{
			if ((_position distance _x) < 200) then {
				_validspot = false;
				_color = "ColorBlue";
			};
		} forEach wai_markedPos;
	};

	if (_validspot && {wai_avoid_missions != 0}) then {
		{
			if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_avoid_missions)) exitWith {
				if (wai_debug_mode) then {diag_log format ["WAI: Invalid Position (Marker: %1)",_x];};
				_validspot = false;
				_color = "ColorBlue";
			};
		} count wai_mission_markers;
	};
	
	if (_validspot && {wai_avoid_safezones != 0}) then {
		{
			_szPos = _x select 0;
			if (_position distance _szPos < wai_avoid_safezones) exitWith {
				if (wai_debug_mode) then {diag_log "WAI: Invalid Position (SafeZone)";};
				_color = "ColorBrown";
				_validspot = false;
			};
		} forEach DZE_SafeZonePosArray;
	};

	if (_validspot && {wai_avoid_water != 0}) then {
		if ([_position,wai_avoid_water] call isNearWater) then {
			if (wai_debug_mode) then {diag_log "WAI: Invalid Position (Water)";};
			_color = "ColorBlue";
			_validspot = false;
		}; 
	};

	if (_validspot && {wai_avoid_town != 0}) then {
		if ([_position,wai_avoid_town] call isNearTown) then {
			if (wai_debug_mode) then {diag_log "WAI: Invalid Position (Town)";};
			_color = "ColorGreen";
			_validspot = false;
		};
	};

	if (_validspot && {wai_avoid_road != 0}) then {
		if ([_position,wai_avoid_road] call isNearRoad) then {
			if (wai_debug_mode) then {diag_log "WAI: Invalid Position (Road)";};
			_color = "ColorGrey";
			_validspot = false;
		};
	};

	if (_validspot && {wai_avoid_players != 0}) then {
		if ([_position,wai_avoid_players] call isNearPlayer) then {
			if (wai_debug_mode) then {diag_log "WAI: Invalid Position (player)";};
			_color = "ColorPink";
			_validspot = false;
		};
	};
	
	if (_validspot && {wai_avoid_plots != 0}) then {
		if (count (_position nearEntities ["Plastic_Pole_EP1_DZ", wai_avoid_plots]) > 0) then {
			if (wai_debug_mode) then {diag_log "WAI: Invalid Position (plot)";};
			_color = "ColorBlack";
			_validspot = false;
		};
	};

	if (!_validspot) then {
		if (wai_debug_mode) then {
			_marker = createMarkerLocal ["spotMarker" + (str _i),[_position select 0,_position select 1]];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "DOT";
			_marker setMarkerColorLocal _color;
			_marker setMarkerSizeLocal [1.0, 1.0];
			_marker setMarkerTextLocal "fail";
		};
	};

	if (_validspot) then {
		if (wai_debug_mode) then {diag_log format ["Loop complete, valid position %1 in %2 attempts.",_position,_i];};
	};
};

if (wai_avoid_samespot) then {
	wai_markedPos set [count wai_markedPos, _position];
};

_position set [2, 0];
_position
