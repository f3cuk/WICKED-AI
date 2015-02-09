wai_spawn_create = {
	private["_crate","_crate_size","_position","_crate_type"];
	_crate_size = _this select 0;
	_position	= _this select 1;
	
	/* Create type*/
	if(_crate_size == 0) then {
		_crate_type = crates_small call BIS_fnc_selectRandom;
	};
	
	if(_crate_size == 1) then {
		_crate_type = crates_medium call BIS_fnc_selectRandom;
	};
	
	if(_crate_size == 2) then {
		_crate_type = crates_large call BIS_fnc_selectRandom;
	};
	// Create the create
	_position		= _position findEmptyPosition [0,10,_crate_type];
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),(_position select 2)],[],0,"CAN_COLLIDE"];
	
	// Clean up
	_crate setVariable ["ObjectID","1",true];
	// God mod
	_crate addEventHandler ["HandleDamage", {}];
	
	/* CLEAR CREATE */
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;
	
	_crate
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

/*hero_warning = {

	private ["_warned"];
	_position = _this select 0;
	_mission = _this select 1;
	_running = (typeName (wai_mission_data select _mission) == "ARRAY");

	while {_running} do {
		{
			_warning_one = _x getVariable ["warning_one", false];
			_warning_two = _x getVariable ["warning_two", false];
			_warning_bandit = _x getVariable ["warning_bandit", false];
			if((isPlayer _x) && ((_x distance _position) <= 1200) && (_x getVariable ["humanity", 0] > player_bandit)) then {

				if (_x distance _position > ai_hero_engage_range) then {

					if (!_warning_one && (_x distance _position <= 150)) then {

						_msg = format ["Warning! This is a restricted area! Come closer and we will engage!"];
						[nil,_x,rTitleText,_msg,"PLAIN",10] call RE;
						_x setVariable ["warning_one", true];
					};

				} else {

					if (!_warning_two) then {
						_msg = format ["You were warned %1.", name _x];
						[nil,_x,rTitleText,_msg,"PLAIN",10] call RE;
						_x setVariable ["warning_two", true];
					};

				};
			};
		} forEach playableUnits;
	_running = (typeName (wai_mission_data select _mission) == "ARRAY");
	};
};*/

/*
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