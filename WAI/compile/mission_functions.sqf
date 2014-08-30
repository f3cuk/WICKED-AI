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

isSlope = {

	private["_pos","_result","_position","_posx","_posy","_radius","_gradient","_max","_min","_posx","_posy"];

	_result 	= false;
	_position 	= _this select 0;
	_posx 		= _position select 0;
	_posy 		= _position select 1;
	_radius 	= _this select 1;
	_gradient 	= _this select 2;
	_max 		= getTerrainHeightASL [_posx,_posy];
	_min 		= getTerrainHeightASL [_posx,_posy];

	for "_i" from 0 to 359 step 45 do {
		_pos = [_posx + (sin(_i)*_radius), _posy + (cos(_i)*_radius)];
		_min = _min min getTerrainHeightASL _pos;
		_max = _max max getTerrainHeightASL _pos;
	};

	_result = ((_max - _min) > _gradient);
	_result

};

inDebug = {

	private["_result","_position","_hasdebug","_xLeft","_xRight","_yTop","_yBottom"];

	_result 		= false;
	_position 		= _this;
	_hasdebug 		= false;
	_xLeft 			= 0;
	_xRight 		= 0;
	_yTop 			= 0;
	_yBottom 		= 0;

	call {
		if(worldName == "Takistan") 			exitWith { _hasdebug = true; _xLeft = 200; _xRight = 12600; _yTop = 12600; _yBottom = 200; };
		if(worldName == "Shapur_BA") 			exitWith { _hasdebug = true; _xLeft = 200; _xRight = 1900; _yTop = 1900; _yBottom = 200; };
		if(worldName == "Zargabad") 			exitWith { _hasdebug = true; _xLeft = 200; _xRight = 7963; _yTop = 8091; _yBottom = 200; };
		if(worldName == "ProvingGrounds_PMC")	exitWith { _hasdebug = true; _xLeft = 200; _xRight = 1900; _yTop = 1900; _yBottom = 200; };
		if(worldName == "Chernarus") 			exitWith { _hasdebug = true; _xLeft = 1000; _xRight = 13350; _yTop = 13350; _yBottom = 1000; };
		if(worldName == "sauerland") 			exitWith { _hasdebug = true; _xLeft = 1000; _xRight = 24400; _yTop = 24500; _yBottom = 1200; };
	};

	if(_hasdebug) then {
		if (_position select 0 < _xLeft) 	exitWith { _result = true; };
		if (_position select 0 > _xRight)	exitWith { _result = true; };
		if (_position select 1 > _yTop)		exitWith { _result = true; };
		if (_position select 1 < _yBottom)	exitWith { _result = true; };
	};

	_result

};

get_trader_markers = {

	private["_result"];

	_result = [];

	call {
		if(worldName == "Chernarus")	exitWith { _result = ["Tradercitystary","wholesaleSouth","boatTraderEast","BoatDealerSouth","AirVehicles","BanditDen","Klen","BoatDealerEast","TradercityBash","HeroTrader"]; };
		if(worldName == "Napf") 		exitWith { _result = ["NeutralTraderCity","FriendlyTraderCity","HeroVendor","BanditVendor","West Wholesaler","NorthWholesaler","NorthBoatVendor","SouthBoatVendor","NeutralTraderCity","NeutralTraderCIty2","UnarmedAirVehicles"]; };
	};

	_result

};

find_suitable_ammunition = {

	private["_weapon","_result","_ammoArray"];

	_result 	= false;
	_weapon 	= _this;
	_ammoArray 	= getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");

	if (count _ammoArray > 0) then {
		_result = _ammoArray select 0;
		call {
			if(_result == "20Rnd_556x45_Stanag") 	exitWith { _result = "30Rnd_556x45_Stanag"; };
			if(_result == "30Rnd_556x45_G36") 		exitWith { _result = "30Rnd_556x45_Stanag"; };
			if(_result == "30Rnd_556x45_G36SD") 	exitWith { _result = "30Rnd_556x45_StanagSD"; };
		};
	};

	_result

};