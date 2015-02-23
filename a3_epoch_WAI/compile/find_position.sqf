private ["_okPos","_airportPos","_allAirports","_height","_chance","_clear","_isNearBlackspot","_cityrange","_cityPos","_selectedCity","_allCitys","_RoadList","_worldSize","_worldCenter","_position", "_isNear", "_nearby","_spawnRadius","_result"];
	// Spawn around buildings and 50% near roads
	/*
	1    Position
	2    Minimum distance
	3    Maximum distance
	4    Maximum distance from nearest object
	5    0 - cant be in water, 1 - ?
	6    Terrain gradient (how steep terrain)
	7    0 - shore mode; does not have to be in shore
	8	 blacklist
	*/
	markerready = false;
	_okPos = false;
	_position = [];
	_clear 	= _this select 0;
	_chance = floor(random 3);
	
	// Manual set mission position type
	if (count _this == 2) then {
		_chance = _this select 1;
	};
	 
	// Try 10 Times to Find a Mission Spot
	waitUntil{!isNil "BIS_fnc_findSafePos"};
	for "_x" from 1 to 10 do {
		switch (_chance) do
		{
			// Road
			case 0:
				{
					_RoadList = epoch_centerMarkerPosition nearRoads EPOCH_dynamicVehicleArea;
					waitUntil{!isNil "BIS_fnc_selectRandom"};
					_position = _RoadList call BIS_fnc_selectRandom;
					_position = _position modelToWorld [0,0,0];
					_position = [_position,0,50,_clear,0,10,0,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position Road"];
					_okPos = true;
				};
			// City
			case 1:
				{
					_allCitys = nearestLocations [epoch_centerMarkerPosition, ["NameVillage","NameCity","NameCityCapital"], EPOCH_dynamicVehicleArea]; 
					_cityPos = position (_allCitys select (floor (random (count _allCitys)))); 
					_position = [_cityPos,0,150,_clear,0,10,0,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position City"];
					_okPos = true;
				};
			// Wildness
			case 2:
				{	
					_position = [epoch_centerMarkerPosition,0,EPOCH_dynamicVehicleArea,_clear,0,15,0,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position Wildness"];
					_okPos = true;
				};
			// Shore
			case 3:
				{	
					_position = [epoch_centerMarkerPosition,0,EPOCH_dynamicVehicleArea,_clear,0,10,1,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position Shore"];
					_okPos = true;
				};
			// Water (for special missions)
			case 4:
				{	
					_position = [epoch_centerMarkerPosition,0,(EPOCH_dynamicVehicleArea-1500),_clear,1,10,0,blacklist] call BIS_fnc_findSafePos;
					if([_position,_clear] call wai_isNearWater) then {
						_okPos = true;
					};
					diag_log format["WAI: position Water"];
				};
			// Airports (for special missions)
			case 5:
				{
					_allAirports = nearestLocations [epoch_centerMarkerPosition, ["Airport"], EPOCH_dynamicVehicleArea]; 
					_airportPos = position (_allAirports select (floor (random (count _allAirports)))); 
					_position = [_airportPos,0,50,_clear,0,10,0,blacklist] call BIS_fnc_findSafePos;
					diag_log format["WAI: position airport"];
					_okPos = true;
					
					/*Ok, i see, in configfile >> "CfgWorlds" >> "Stratis" >> "Names", Airport1's type is set to "nameLocal" instead of "airport". 
					use can use nearestLocations [pos,"nameLocal",rad] and then loop the result array checking if " text _location == "airfield" "	
					technically you could run that once, and with location use '_location setType "airport"', then it should find it with nearestlocations, although i had no luck in the 10 minutes i've been playing around
				
					http://forums.bistudio.com/showthread.php?85340-AI-landing*/
				};
		};
		
		_isNearPlayer 		= [_position] call wai_nearbyPlayers;
		_isNearBlackspot 	= [_position] call wai_nearbyBlackspot;
		//_isNearTrader 		= [_position] call wai_nearbyTrader;
		
		//if ((!_isNearPlayer) && (!_isNearBlackspot) && (!_isNearTrader)) then {
		if ( (!_isNearPlayer) && (!_isNearBlackspot) && (_okPos) ) then {
			_x = 20;
			diag_log format["WAI: Good position At %1",_position];
		} else {
			_x = 1;
			diag_log format["WAI: Bad position %1",_position];
		};
	};
	
	[_position, _chance]