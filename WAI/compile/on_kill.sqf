if (isServer) then {

	private ["_unit","_player","_humanity","_banditkills"];

	_unit 		= _this select 0;
	_player 	= _this select 1;
	_type 		= _this select 2;

	switch (_type) do {
		case "ground" : {ai_ground_units = (ai_ground_units -1);};
		case "air" : {ai_air_units = (ai_air_units -1);};
		case "vehicle" : {ai_vehicle_units = (ai_vehicle_units -1);};
		case "static" : {ai_emplacement_units = (ai_emplacement_units -1);};
	};

	_unit setVariable ["killedat", time];
	_unit removeWeapon "NVGoggles";

	if (isPlayer _player) then {

		private ["_banditkills","_humanity"];

		_humanity 		= _player getVariable["humanity",0];
		_banditkills 	= _player getVariable["banditKills",0];

		if (ai_humanity_gain) then {
			_player setVariable ["humanity",(_humanity + ai_add_humanity),true];
		};

		if (ai_banditkills_gain) then {
			_player setVariable ["banditKills",(_banditkills + 1),true];
		};

		if (ai_clear_body) then {
			{_unit removeMagazine _x;} forEach (magazines _unit);
			{_unit removeWeapon _x;} forEach (weapons _unit);
		};

		if (ai_share_info) then {
			{if (((position _x) distance (position _unit)) <= ai_share_distance) then {_x reveal [_player, 4.0];}} forEach allUnits;
		};

	} else {

		if (ai_clean_roadkill) then {

			ai_roadkills = (ai_roadkills + 1);

			removeBackpack _unit;
			removeAllWeapons _unit;

			{
				_unit removeMagazine _x
			} forEach magazines _unit;

		} else {

			if ((random 100) <= ai_roadkill_damageweapon) then {

				removeAllWeapons _unit;
				
			};

		};

	};

};
