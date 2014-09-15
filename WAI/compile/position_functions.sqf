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
		if(worldName == "Takistan")			exitWith { _result = ["Trader_City_Nur","Trader_City_Garm","Wholesaler","Wholesaler_1","Airplane Dealer","BanditTrader","BlackMarketVendor"]; };
		if(worldName == "Zargabad")			exitWith { _result = ["HeroCamp","BanditCamp"]; };
		if(worldName == "Dingor")			exitWith { _result = ["RaceTrack","RepairGuy","PlaneVendor","Wholesale","HighWeapons/ammo","Parts","Choppers","lowEndCars","LowEndWeapons","HighEndCars","MedicalandBags","Wholesaler","BagsNFood","Wholesalers","DirtTrackVendor","OffRoad4x4","BoatVendor","BoatVendor1","BoatVendor2","BagVendor1","BagVendor2","Doctor2","BanditTrader","HeroTrader"]; };
		if(worldName == "Lingor")			exitWith { _result = ["RaceTrack","RepairGuy","PlaneVendor","Wholesale","HighWeapons/ammo","Parts","Choppers","lowEndCars","LowEndWeapons","HighEndCars","MedicalandBags","Wholesaler","BagsNFood","Wholesalers","DirtTrackVendor","OffRoad4x4","BoatVendor","BoatVendor1","BoatVendor2","BagVendor1","BagVendor2","Doctor2","BanditTrader","HeroTrader"]; };
		if(worldName == "Chernarus")		exitWith { _result = ["Tradercitystary","wholesaleSouth","boatTraderEast","BoatDealerSouth","AirVehicles","BanditDen","Klen","BoatDealerEast","TradercityBash","HeroTrader"]; };
		if(worldName == "isladuala")		exitWith { _result = ["st_2","st_3","st_4","st_3_1","st_3_1_1","st_3_1_1_1","st_3_2","st_3_2_1","st_3_2_2","st_3_2_3","st_3_2_3_1"]; };
		if(worldName == "Tavi")				exitWith { _result = ["TraderCityLyepestok","TraderCitySabina","TraderCityBilgrad","TraderCityBranibor","BanditVendor","HeroVendor","AircraftDealer","AircraftDealer2","Misc.Vendor","Misc.Vendor2","BoatDealer","BoatDealer2","BoatDealer3","BoatDealer4","Wholesaler","Wholesaler2"]; };
		if(worldName == "Namalsk")			exitWith { _result = ["GerneralPartsSupplies","WholesalerNorth","Doctor","HighEndWeaponsAmmo","HeroVendor","VehicleFriendly","NeutralVendors","WholesalerSouth","LowEndWeaponsAmmo","BoatVendor","Bandit Trader","PlaneVendor"]; };
		if(worldName == "Panthera2")		exitWith { _result = ["AirVehiclesF","WholesalerNorth","HeroVehicles","NeutralAirVehicles","Boats","NeutralTraders","NeutralTraderCity2","WholesaleSouth","PlanicaTraders","IslandVehiclePartsVendors","Boat2"]; };
		if(worldName == "Sara")				exitWith { _result = ["Tradercitycorazol","wholesaleSouth","boatTraderEast","BoatDealerSouth","AirVehicles","BanditDen","Ixel","BoatDealerEast","TradercityBag","HeroTrader"]; };
		if(worldName == "FDF_Isle1_a")		exitWith { _result = ["wholesaleSouth","boatTraderEast","BoatDealerSouth","AirVehicles","BanditDen","Jesco","TradercityBash","HeroTrader"]; };
		if(worldName == "fapovo")			exitWith { _result = ["BanditTrader","AirVehicleUnarmed","TraderCity1","TraderCity2","Wholesaler","BanditVendor","HeroVendor","BoatVendor"]; };
		if(worldName == "Caribou")			exitWith { _result = ["boatTraderEast","BoatDealerSouth","AirVehicles","BanditDen","NorthNeutralVendors","SouthNeutralVendors","HeroTrader","BlackMarket","SouthWestWholesale"]; };
		if(worldName == "smd_sahrani_A2")	exitWith { _result = ["Tradercitycorazol","wholesaleSouth","boatTraderEast","BoatDealerSouth","AirVehicles","BanditDen","Ixel","BoatDealerEast","TradercityBag","HeroTrader","BlackMarket"]; };
		if(worldName == "cmr_ovaron")		exitWith { _result = ["AirVehiclesF","WholesalerWest","HeroVehicles","NeutralAirVehicles","Boats","NeutralTraders","NeutralTraderCity2","WholesaleSouth","PlanicaTraders","IslandVehiclePartsVendors"]; };
		if(worldName == "Napf") 			exitWith { _result = ["NeutralTraderCity","FriendlyTraderCity","HeroVendor","BanditVendor","West Wholesaler","NorthWholesaler","NorthBoatVendor","SouthBoatVendor","NeutralTraderCity","NeutralTraderCIty2","UnarmedAirVehicles"]; };
		if(worldName == "sauerland")		exitWith { _result = ["NeutralTraderCity","FriendlyTraderCity","HeroVendor","UnarmedAirVehicles","SouthWholesaler","NorthWholesaler","BanditVendor","NeutralTraderCIty2"]; };
	};

	_result

};