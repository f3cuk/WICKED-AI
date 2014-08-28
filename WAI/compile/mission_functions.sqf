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
	_hasdebug = false;
	_xLeft = 0;
	_xRight = 0;
	_yTop = 0;
	_yBottom = 0;

	call {
		if (
			worldName == "Utes" ||
			worldName == "Bootcamp_ACR" ||
			worldName == "Dingor" ||
			worldName == "Lingor" ||
			worldName == "Woodland_ACR" ||
			worldName == "Mountains_ACR" ||
			worldName == "isladuala" ||
			worldName == "Tavi" ||
			worldName == "namalsk" ||
			worldName == "Panthera2" ||
			worldName == "Sara" ||
			worldName == "FDF_Isle1_a" ||
			worldName == "fapovo" ||
			worldName == "Caribou" ||
			worldName == "smd_sahrani_A2" ||
			worldName == "cmr_ovaron" ||
			worldName == "Napf"
		) exitWith {};
		if (worldName == "Takistan")			exitWith	{ _hasdebug = true; _xLeft = 200; _xRight = 12600; _yTop = 12600; _yBottom = 200; };
		if (worldName == "Shapur_BAF")			exitWith	{ _hasdebug = true; _xLeft = 200; _xRight = 1900; _yTop = 1900; _yBottom = 200; };
		if (worldName == "Zargabad")			exitWith	{ _hasdebug = true; _xLeft = 200; _xRight = 7963; _yTop = 8091; _yBottom = 200; };
		if (worldName == "ProvingGrounds_PMC")	exitWith	{ _hasdebug = true; _xLeft = 200; _xRight = 1900; _yTop = 1900; _yBottom = 200; };
		if (worldName == "Chernarus")			exitWith	{ _hasdebug = true; _xLeft = 1000; _xRight = 19000; _yTop = 14100; _yBottom = 1000; };
		if (worldName == "sauerland")			exitWith	{ _hasdebug = true; _xLeft = 1000; _xRight = 24400; _yTop = 24500; _yBottom = 1200; };
		
	};
	
	if (!_hasdebug) exitWith {_result};
	
	if (_position select 0 < _xLeft) exitWith { _result = true; _result };
	if (_position select 0 > _xRight) exitWith { _result = true; _result };
	if (_position select 1 > _yTop) exitWith { _result = true; _result };
	if (_position select 1 < _yBottom) exitWith { _result = true; _result };

};

get_trader_markers = {
	_markers = [];
	call {
		if (worldName == "Chernarus")			exitWith	{ _markers = ["Tradercitystary","wholesaleSouth","boatTraderEast","BoatDealerSouth","AirVehicles","BanditDen","Klen","BoatDealerEast","TradercityBash","HeroTrader"]; };
		if (worldName == "Napf")				exitWith	{ _markers = ["NeutralTraderCity","FriendlyTraderCity","HeroVendor","BanditVendor","West Wholesaler","NorthWholesaler","NorthBoatVendor","SouthBoatVendor","NeutralTraderCity","NeutralTraderCIty2","UnarmedAirVehicles"]; };
	};
	_markers
};

find_suitable_ammunition = {
	_weapon = _this;
	_ammo = "";
	_ammoArray = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");
	if (count _ammoArray > 0) then {
		_ammo = _ammoArray select 0;
		if (_ammo == "20Rnd_556x45_Stanag") then { _ammo = "30Rnd_556x45_Stanag"; };
		if (_ammo == "30Rnd_556x45_G36") then { _ammo = "30Rnd_556x45_Stanag"; };
		if (_ammo == "30Rnd_556x45_G36SD") then { _ammo = "30Rnd_556x45_StanagSD"; };
	};
	_ammo
};