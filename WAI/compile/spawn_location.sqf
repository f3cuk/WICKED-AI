wai_nearbyPlayers = {
	private ["_pos", "_isNearList", "_isNear"];
	_pos = _this select 0;

	_isNearList = _pos nearEntities ["CAManBase", wai_blacklist_players_range];
	_isNear = false;
	
	// Check for Players & Ignore SARGE AI
	if ((count(_isNearList)) > 0) then {
		{
			if (isPlayer _x) then {
				_isNear = true;
			};
		} forEach _isNearList;
	};

	if !(_isNear) then {
		_isNearList = _pos nearEntities [["LandVehicle", "Air"], wai_blacklist_players_range];
		{
			{
				if (isPlayer _x) then {
					_isNear = true;
				};
			} forEach (crew _x);
		} forEach _isNearList;
	};
	_isNear
};

wai_nearbyBlackspot = {
	private ["_position", "_isNear", "_nearby"];
	_position = _this select 0;
	_isNear = false;
	
	_nearby = nearestObjects [_position, ["Plastic_Pole_EP1_DZ", "Info_Board_EP1"], wai_blacklist_range];
	
	if ((count _nearby) > 0) then {
		_isNear = true;
	};
	_isNear
};

private ["_isTavi","_tavTest","_tavHeight","_position", "_isNear", "_nearby","_spawnRadius","_result"];
	// Spawn around buildings and 50% near roads
	/*
	1    Position
	2    Minimum distance
	3    Maximum distance
	4    Maximum distance from nearest object
	5    0 - cant be in water, 1 - ?
	6    Terrain gradient (how steep terrain)
	7    0 - shore mode; does not have to be in shore
	*/
	_position = [];
	_chance = floor(random 2);
	_spawnRadius = HeliCrashArea;
	_isTavi = false;
	_tavHeight = 0;
	 
	 /*if(worldName == "Tavi") then 
	 {
		_isTavi = true;
	 };*/
	
	// Try 10 Times to Find a Mission Spot
	for "_x" from 1 to 10 do {
		switch (_chance) do
		{
			// ROAD
			case 0:
				{
					waitUntil{!isNil "BIS_fnc_selectRandom"};
					_position = RoadList call BIS_fnc_selectRandom;
					_position = _position modelToWorld [0,0,0];
					waitUntil{!isNil "BIS_fnc_findSafePos"};
					_position = [_position,0,100,5,0,2000,0] call BIS_fnc_findSafePos;
				};
			// Buldings
			case 1:
				{
					waitUntil{!isNil "BIS_fnc_selectRandom"};
					_position = BuildingList call BIS_fnc_selectRandom;
					_position = _position modelToWorld [0,0,0];
					waitUntil{!isNil "BIS_fnc_findSafePos"};
					_position = [_position,0,100,5,0,2000,0] call BIS_fnc_findSafePos;
				};
			// Wildness
			case 2:
				{	
					waitUntil{!isNil "BIS_fnc_findSafePos"};
					_position = [getMarkerPos "center",0,_spawnRadius,100,0,2000,0] call BIS_fnc_findSafePos;
				};
		};
		//Lets test the height on Taviana
		/*if (_isTavi) then {
			_tavTest = createVehicle ["Can_Small",[_position select 0,_position select 1,0],[], 0, "CAN_COLLIDE"];
			_tavHeight = (getPosASL _tavTest) select 2;
			deleteVehicle _tavTest;
		};*/
		
		_isNearPlayer = [_position] call wai_nearbyPlayers;
		_isNearBlackspot = [_position] call wai_nearbyBlackspot;
		
		
		/*if (_isTavi && (_tavHeight <= 185)) then {
			_x = 20;
			diag_log format["WAI: Good position At %1",_position];
		} else {
			_position = [];
			diag_log format["WAI: Bad position At %1",_position];
		};*/
		
		if ((!_isNearPlayer) && (!_isNearBlackspot)) then {
			_x = 20;
			diag_log format["WAI: Good position At %1",_position];
		} else {
			_position = [];
			diag_log format["WAI: Bad position %1",_position];
		};
	};
	
	_position

