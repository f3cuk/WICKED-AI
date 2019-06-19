isNearWater = {

	private["_result","_position","_radius"];

	_result 	= false;
	_position 	= _this select 0;
	_radius		= _this select 1;
	
	for "_i" from 0 to 359 step 45 do {
		_position = [(_position select 0) + (sin(_i)*_radius), (_position select 1) + (cos(_i)*_radius)];
		if (surfaceIsWater _position) exitWith {
			_result = true; 
		};
	};

	_result

};

isNearTown = {

	private["_result","_position","_radius","_locations"];

	_result 	= false;
	_position 	= _this select 0;
	_radius 	= _this select 1;
	
	_locations = [["NameCityCapital","NameCity","NameVillage"],[_position,_radius]] call BIS_fnc_locations;

	if (count _locations > 0) then { 
		_result = true; 
	};

	_result

};

isNearRoad = {

	private["_result","_position","_radius","_roads"];

	_result 	= false;
	_position 	= _this select 0;
	_radius 	= _this select 1;
	
	_roads = _position nearRoads _radius;

	if (count _roads > 0) then {
		_result = true;
	};

	_result

};

isNearPlayer = {
	private["_result","_position","_radius"];

	_result 	= false;
	_position 	= _this select 0;
	_radius 	= _this select 1;

	{
		if ((isPlayer _x) && (_x distance _position <= _radius)) then {
			_result = true;
		};
	} count playableUnits;

	_result
};

// Player and mission proximity check used in single spawn point missions
wai_validSpotCheck = {
	
	private ["_position","_validspot"];
	
	_position = _this select 0;
	_validspot 	= true;
	
	if (_validspot && wai_avoid_missions != 0) then {
	if(wai_debug_mode) then { diag_log("WAI DEBUG: FINDPOS: Checking nearby mission markers: " + str(wai_mission_markers)); };
		{
			if (getMarkerColor _x != "" && (_position distance (getMarkerPos _x) < wai_avoid_missions)) exitWith { if(wai_debug_mode) then {diag_log("WAI: Invalid Position (Marker: " + str(_x) + ")");}; _validspot = false; };
		} count wai_mission_markers;
	};
	if (_validspot && {wai_avoid_players != 0}) then {
		if ([_position,wai_avoid_players] call isNearPlayer) then {
			if (wai_debug_mode) then {diag_log "WAI: Invalid Position (player)";};
			_validspot = false;
		};
	};
	if(_validspot) then {
		if(wai_debug_mode) then { diag_log("WAI: valid position found at" + str(_position));};
	};
	_validspot
};

// Closest player check used in auto-claim
wai_isClosest = {
	private ["_closest","_scandist","_dist","_position"];
	
	_position	= _this;
	_closest	= objNull;
	_scandist	= ac_alert_distance;
	
	{
	_dist = vehicle _x distance _position;
	if (isPlayer _x && _dist < _scandist) then {
		_closest = _x;
		_scandist = _dist;
	};
	} count playableUnits;
	
	_closest
};

wai_checkReturningPlayer = {
	private["_acArray","_position","_playerUID","_returningPlayer"];

	_position 	= _this select 0;
	_acArray	= _this select 1;
	_playerUID	= _acArray select 0;
	_returningPlayer = objNull;

	{
		if ((isPlayer _x) && (_x distance _position <= ac_alert_distance) && (getplayerUID _x == _playerUID)) then {
			_returningPlayer = _x;
		};
	} count playableUnits;
	
	_returningPlayer
};

