isNearWater = {
	_result = false;
	_position = _this select 0;
	_radius	= _this select 1;
	
	for "_i" from 0 to 359 step 45 do {
		_position = [(_position select 0) + (sin(_i)*_radius), (_position select 1) + (cos(_i)*_radius)];
		if (surfaceIsWater _position) exitWith { _result = true; };
	};
	_result
};

isNearTown = {
	_result = false;
	_position = _this select 0;
	_radius = _this select 1;
	
	_locations = [["NameCityCapital","NameCity","NameVillage"],[_position,_radius]] call BIS_fnc_locations;
	if (count _locations > 0) then { _result = true; };
	_result
};

isNearRoad = {
	_result = false;
	_position = _this select 0;
	_radius = _this select 1;
	
	_roads = _position nearRoads _radius;
	if (count _roads > 0) then { _result = true; };
	_result
};

isSlope = {
	_result = false;
	_position = _this select 0;
	_posx = _position select 0;
	_posy = _position select 1;
	
	_radius = _this select 1;
	_gradient = _this select 2;
	_max = getTerrainHeightASL [_posx,_posy];
	_min = getTerrainHeightASL [_posx,_posy];
	for "_i" from 0 to 359 step 45 do {
		_pos = [_posx + (sin(_i)*_radius), _posy + (cos(_i)*_radius)];
		_min = _min min getTerrainHeightASL _pos;
		_max = _max max getTerrainHeightASL _pos;
	};

	_result = ((_max - _min) > _gradient);
	_result
};

inDebug = {
	_result = false;
	_position = _this;
	_noboundary = false;
	_leftX = 0;
	_topY = 0;
	_rightX = 0;
	_bottomY = 0;
	
	call {
		if (missionName == "DayZ_Epoch_11") exitWith {_leftX = 200; _topY = 15100;};
		if (missionName == "DayZ_Epoch_24") exitWith {_noboundary = true;};
	};
	
	if (_noboundary) exitWith {_result};
	
	if (_position select 0 < _leftX) exitWith { _result = true; _result };
	if (_position select 1 > _topY) exitWith { _result = true; _result };

};