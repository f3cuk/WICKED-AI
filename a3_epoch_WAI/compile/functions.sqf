wai_vehicle_protect = {
	private["_vehicle"];
	_vehicle = _this;
	
	_vehicle addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
	_vehicle setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_vehicle setVariable["LAST_CHECK",1000000000000];
	
	_vehicle disableTIEquipment true; // Disable Thermal
	_vehicle call EPOCH_server_setVToken; // Set Token
	
	addToRemainsCollector [_vehicle]; 	// Cleanup
	
	// Set Vehicle Slot
	/*EPOCH_VehicleSlotsLimit = EPOCH_VehicleSlotsLimit + 1;
	EPOCH_VehicleSlots pushBack (str EPOCH_VehicleSlotsLimit);
	_vehicle setVariable ["VEHICLE_SLOT",(EPOCH_VehicleSlots select 0),true];
	EPOCH_VehicleSlots = EPOCH_VehicleSlots - [(EPOCH_VehicleSlots select 0)];
	EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;*/
	
	[_vehicle] spawn vehicle_monitor;
	
	if(debug_mode) then { diag_log("WAI: vehicle setup for " + str(_vehicle) + " is done."); };
	_vehicle
};
wai_spawn_create = {
	private["_height","_crate","_crate_size","_position","_crate_type"];
	_crate_size = _this select 0;
	_position	= _this select 1;
	if(debug_mode) then { diag_log("WAI: BOX SPAWN POS" + str(_position)); };
	
	/* Create type*/
	switch (_crate_size) do
	{
		// small
		case 0:
			{
				_crate_type = crates_small call BIS_fnc_selectRandom;
			};
		// Medium
		case 1:
			{
				_crate_type = crates_medium call BIS_fnc_selectRandom;
			};
		// large
		case 2:
			{
				_crate_type = crates_large call BIS_fnc_selectRandom;
			};
	};
		
	// Create the create
	//_position		= _position findEmptyPosition [0,10,_crate_type];
	_position 	= [_position,0,1,2,0,20,0] call BIS_fnc_findSafePos;
	_crate 		= createVehicle [_crate_type,_position,[],0,"CAN_COLLIDE"];
	
	// Clean up
	_crate setVariable ["ObjectID","1",true];
	// God mod
	_crate allowdamage false;
	
	/* CLEAR CREATE */
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;
	
	_crate
};
wai_paraLandSafe = {
	// Author: Beerkan:
    // Additional contributions cobra4v320, itsatrap
    private ["_smoke","_unit"];
    _unit = _this select 0;
    (vehicle _unit) allowDamage false;
    waitUntil {isTouchingGround _unit || (position _unit select 2) < 1 };
    _unit allowDamage false;
    _unit action ["EJECT", vehicle _unit];
    _unit setvelocity [0,0,0];
    sleep 1;
	if(wai_crates_smoke && ((leader group _unit) == _unit)) then {
        _smoke = "SmokeShellRed" createVehicle (getPos _unit);
    };
    _unit allowDamage true;
};
find_suitable_ammunition = {

	private["_weapon","_result","_ammoArray"];

	_result 	= false;
	_weapon 	= _this;
	_ammoArray 	= getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");

	if (count _ammoArray > 0) then {
		_result = _ammoArray select 0;
	};

	_result

};
find_suitable_suppressor = {
	
	private["_weapon","_result","_ammoName"];

	_result 	= "";
	_weapon 	= _this;
	_ammoName	= getText  (configFile >> "cfgWeapons" >> _weapon >> "displayName");

	if(["5.56", _ammoName] call KK_fnc_inString) then {
		_result = "muzzle_snds_M";
	};
	if(["6.5", _ammoName] call KK_fnc_inString) then {
		_result = "muzzle_snds_H";
	};
	if(["7.62", _ammoName] call KK_fnc_inString) then {
		_result = "muzzle_snds_H";
	};
	
	_result
};

/*
Author: http://killzonekid.com/arma-scripting-tutorials-how-to-find-a-string-within-a-string/
Parameter(s):
    _this select 0: <string> string to be found
    _this select 1: <string> string to search in
*/
KK_fnc_inString = {

	private ["_needle","_haystack","_needleLen","_hay","_found"]; 

	_needle 	= [_this, 0, "", [""]] call BIS_fnc_param; 
	
	_haystack 	= toArray ([_this, 1, "", [""]] call BIS_fnc_param); 
	_needleLen 	= count toArray _needle;
	
	_hay 		= +_haystack; 
	_hay 		resize _needleLen;
	_found 		= false; 

	for "_i" from _needleLen to count _haystack do { 

		if (toString _hay == _needle) exitWith {_found = true};
		_hay set [_needleLen, _haystack select _i]; 
		_hay set [0, "x"]; _hay = _hay - ["x"]
	 }; 

	_found
};