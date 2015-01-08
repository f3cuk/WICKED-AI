if (isServer) then {

	private ["_rockets","_launcher","_type","_skin","_gain","_mission","_ainum","_unit","_player","_crypto","_banditkills","_humankills","_cryptogain"];
	
	_unit 		= _this select 0;
	_player 	= _this select 1;
	_type 		= _this select 2;
	_launcher 	= secondaryWeapon _unit;

	call {
		if(_type == "ground") 	exitWith { ai_ground_units = (ai_ground_units -1); };
		if(_type == "air") 		exitWith { ai_air_units = (ai_air_units -1); };
		if(_type == "vehicle") 	exitWith { ai_vehicle_units = (ai_vehicle_units -1); };
		if(_type == "static") 	exitWith { ai_emplacement_units = (ai_emplacement_units -1); };
	};
	
	_unit setVariable["missionclean", nil];
	
	_mission = _unit getVariable ["mission", nil];
		
	if (!isNil "_mission") then {
		if (typeName(wai_mission_data select _mission) == "ARRAY") then {
			wai_mission_data select _mission set [0, ((wai_mission_data select _mission) select 0) - 1];
		};
	};
	_unit setVariable ["killedat", time];

	if(ai_add_skin) then {

		_skin = (typeOf _unit);
		_skin = "Skin_" + _skin;

		if (isClass (configFile >> "CfgMagazines" >> _skin)) then {
			[_unit,_skin] call BIS_fnc_invAdd;
		};

	};

	if (isPlayer _player) then {

		
		private ["_crypto"];

		_crypto 		= _player getVariable["crypto",0];
		

		if (ai_crypto_gain) then {
			_gain = _unit getVariable ["crypto", 0];
			call {
				if (_unit getVariable ["Bandit", false]) exitWith { _player setVariable ["crypto",(_crypto + _gain),true]; };					
				};
		};

		
		if (ai_clear_body) then {
			{_unit removeMagazine _x;} count (magazines _unit);
			{_unit removeWeapon _x;} count (weapons _unit);
		};

		if (ai_share_info) then {
			{
				if (((position _x) distance (position _unit)) <= ai_share_distance) then {
					_x reveal [_player, 4.0];
				};
			} count allUnits;
		};

	} else {

		if (ai_clean_roadkill) then {

			removeBackpack _unit;
			removeAllWeapons _unit;

			{
				_unit removeMagazine _x
			} count magazines _unit;

		} else {

			if ((random 100) <= ai_roadkill_damageweapon) then {

				removeAllWeapons _unit;
				
			};

		};

	};

	if(wai_remove_launcher && _launcher != "") then {

		_rockets = _launcher call find_suitable_ammunition;
		_unit removeWeapon _launcher;
		
		{
			if(_x == _rockets) then {
				_unit removeMagazine _x;
			};
		} count magazines _unit;
		
	};

	if(_unit hasWeapon "NVG_Epoch" && floor(random 100) < 20) then {
		_unit removeWeapon "NVG_Epoch";
	};

};