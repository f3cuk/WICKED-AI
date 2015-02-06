private ["_isNearBlackspot","_cityrange","_cityPos","_selectedCity","_allCitys","_RoadList","_worldSize","_worldCenter","_position", "_isNear", "_nearby","_spawnRadius","_result"];
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
	markerready = false;
	_position = [];
	_chance = floor(random 3);
	//_chance = 1;
	
	 
	// Try 10 Times to Find a Mission Spot
	for "_x" from 1 to 10 do {
		switch (_chance) do
		{
			// ROAD
			case 0:
				{
					_RoadList = epoch_centerMarkerPosition nearRoads EPOCH_dynamicVehicleArea;
					waitUntil{!isNil "BIS_fnc_selectRandom"};
					_position = _RoadList call BIS_fnc_selectRandom;
					_position = _position modelToWorld [0,0,0];
					waitUntil{!isNil "BIS_fnc_findSafePos"};
					_position = [_position,0,100,5,0,3000,0,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position ROAD"];
				};
			// Buldings
			case 1:
				{
					_allCitys=(configfile >> "CfgWorlds" >> worldName >> "Names")call BIS_fnc_returnChildren;
					_selectedCity=_allCitys select(floor random(count _allCitys));
					_cityPos=getArray(_selectedCity >> "position");
					_cityrange=getNumber(_selectedCity >> "radiusA");
					waitUntil{!isNil "BIS_fnc_findSafePos"};
					_position = [_cityPos,0,200,1,0,3000,0,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position Buldings"];
				};
			// Wildness
			case 2:
				{	
					waitUntil{!isNil "BIS_fnc_findSafePos"};
					_position = [epoch_centerMarkerPosition,0,EPOCH_dynamicVehicleArea,100,0,3000,0,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position Wildness"];
				};
			// Water
			case 3:
				{	
					waitUntil{!isNil "BIS_fnc_findSafePos"};
					_position = [epoch_centerMarkerPosition,0,EPOCH_dynamicVehicleArea,100,1,1000,1,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position Water/Shore"];
				};
		};
		
		_isNearPlayer = [_position] call wai_nearbyPlayers;
		_isNearTrader = [_position] call wai_nearbyTrader;
		_isNearBlackspot = [_position] call wai_nearbyBlackspot;
		
		
		if ((!_isNearPlayer) && (!_isNearBlackspot) && (!_isNearTrader)) then {
			_x = 20;
			diag_log format["WAI: Good position At %1",_position];
		} else {
			_position = [];
			diag_log format["WAI: Bad position %1",_position];
		};
	};
	
	_position
