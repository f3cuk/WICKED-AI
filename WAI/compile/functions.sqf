find_suitable_ammunition = {

	private["_weapon","_result","_ammoArray"];

	_result 	= false;
	_weapon 	= _this;
	_ammoArray 	= getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");

	if (count _ammoArray > 0) then {
		_result = _ammoArray select 0;
		call {
			if(_result == "20Rnd_556x45_Stanag") 	exitWith { _result = "30Rnd_556x45_Stanag"; };
			//if(_result == "30Rnd_556x45_G36") 		exitWith { _result = "30Rnd_556x45_Stanag"; };
			//if(_result == "30Rnd_556x45_G36SD") 	exitWith { _result = "30Rnd_556x45_StanagSD"; };
		};
	};

	_result

};

wai_crate_setup = {

	private ["_crate"];
	
	_crate = _this select 0;
	_crate setVariable ["ObjectID","1",true];
	_crate setVariable ["permaLoot",true];
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_crate];
	_crate addEventHandler ["HandleDamage", {}];
	
};

hero_warning = {

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
};