if (isServer) then {

    private ["_rocket","_launcher","_pos_x","_pos_y","_pos_z","_aiskin","_unarmed","_current_time","_gain","_mission","_ainum","_aitype","_mission","_aipack","_aicskill","_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_gearmagazines","_geartools","_unit"];

	_position 			= _this select 0;
	_pos_x 			= _position select 0;
	_pos_y 			= _position select 1;
	_pos_z 			= _position select 2;
	_unitnumber 		= _this select 1;
	_skill 				= _this select 2;
	_gun 				= _this select 3;
	_mags 				= _this select 4;
	_backpack 			= _this select 5;
	_skin 				= _this select 6;
	_gear 				= _this select 7;
	_aitype				= _this select 8;
	
	if (typeName _gun == "ARRAY") then {
		_launcher		= _gun select 1;
		_gun			= _gun select 0;
	};

	if (typeName _aitype == "ARRAY") then {
		_gain 			= _aitype select 1;
		_aitype 		= _aitype select 0;
	};
	
	if (count _this > 9) then {
		_mission = _this select 9;
	} else {
		_mission = nil;
	};

	_aiweapon 			= [];
	_aigear 			= [];
	_aiskin 			= "";
	_aicskill 			= [];
	_aipack 			= "";
	_current_time		= time;
	_unarmed			= false;

	if(_aitype == "Hero") then {
		_unitGroup	= createGroup RESISTANCE;
	} else {
		_unitGroup	= createGroup EAST;
	};

	if(_pos_z == 0) then {
		if(floor(random 2) == 1) then { 
			_pos_x = _pos_x - (5 + random(25));
		} else {
			_pos_x = _pos_x + (5 + random(25));
		};			

		if(floor(random 2) == 1) then { 
			_pos_y = _pos_y - (5 + random(25));
		} else {
			_pos_y = _pos_y + (5 + random(25));
		};
	};

	for "_x" from 1 to _unitnumber do {

		call {
			if(typeName(_gun) == "SCALAR") then {
				if(_gun == 0) 			exitWith { _aiweapon = ai_wep_assault; };
				if(_gun == 1) 			exitWith { _aiweapon = ai_wep_machine; };
				if(_gun == 2) 			exitWith { _aiweapon = ai_wep_sniper; };
			} else {
				if(_gun == "random") 	exitWith { _aiweapon = ai_wep_random call BIS_fnc_selectRandom; };
				if(_gun == "unarmed") 	exitWith { _unarmed = true; };
				_weapon = _gun;
			}
		};

		if (!_unarmed) then {
			_weapon 	= _aiweapon call BIS_fnc_selectRandom;
			_magazine 	= _weapon 	call find_suitable_ammunition;
		};

		call {
			if(typeName(_gear) == "SCALAR") then {
				if(_gear == 0) 			exitWith { _aigear = ai_gear0; };
				if(_gear == 1) 			exitWith { _aigear = ai_gear1; };
			} else {
				if(_gear == "random") 	exitWith { _aigear = ai_gear_random call BIS_fnc_selectRandom; };
			};
		};
		
		_gearmagazines 	= _aigear select 0;
		_geartools 		= _aigear select 1;

		call {
			if(_skin == "random") 	exitWith { _aiskin = ai_all_skin 		call BIS_fnc_selectRandom; };
			if(_skin == "hero") 	exitWith { _aiskin = ai_hero_skin 		call BIS_fnc_selectRandom; };
			if(_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin 	call BIS_fnc_selectRandom; };
			if(_skin == "special") 	exitWith { _aiskin = ai_special_skin 	call BIS_fnc_selectRandom; };
			_aiskin = _skin;
		};

		if(typeName _aiskin == "ARRAY") then {
			_aiskin = _aiskin call BIS_fnc_selectRandom;
		};

		_unit = _unitGroup createUnit [_aiskin,[_pos_x,_pos_y,_pos_z],[],0,"CAN COLLIDE"];
		[_unit] joinSilent _unitGroup;

		call {
			if(_aitype == "hero") 		exitWith { _unit setVariable ["Hero",true]; _unit setVariable ["humanity", ai_remove_humanity]; };
			if(_aitype == "bandit") 	exitWith { _unit setVariable ["Bandit",true]; _unit setVariable ["humanity", ai_add_humanity]; };
			if(_aitype == "special") 	exitWith { _unit setVariable ["Special",true]; _unit setVariable ["humanity", ai_special_humanity]; };
		};

		if (!isNil "_gain") then { _unit setVariable ["humanity", _gain]; };

		call {
			if(_backpack == "random") 	exitWith { _aipack = ai_packs call BIS_fnc_selectRandom; };
			if(_backpack == "none") 	exitWith { };
			_aipack = _backpack;
		};
		
		if (isNil "_mission") then {
		
			_unit enableAI "TARGET";
			_unit enableAI "AUTOTARGET";
			_unit enableAI "MOVE";
			_unit enableAI "ANIM";
			_unit enableAI "FSM";
		
		};

		removeAllWeapons _unit;
		removeAllItems _unit;

		if (sunOrMoon != 1) then {
			_unit addweapon "NVGoggles";
		};

		if (!_unarmed) then {
			for "_i" from 1 to _mags do {
				_unit addMagazine _magazine;
			};
			_unit addweapon _weapon;
			_unit selectWeapon _weapon;
		};

		if(_backpack != "none") then {
			_unit addBackpack _aipack;
		};

		{
			_unit addMagazine _x
		} count _gearmagazines;

		{
			_unit addweapon _x
		} count _geartools;
		
		call {
			if(_skill == "easy") 		exitWith { _aicskill = ai_skill_easy; };
			if(_skill == "medium") 		exitWith { _aicskill = ai_skill_medium; };
			if(_skill == "hard") 		exitWith { _aicskill = ai_skill_hard; };
			if(_skill == "extreme") 	exitWith { _aicskill = ai_skill_extreme; };
			if(_skill == "random") 		exitWith { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
			_aicskill = ai_skill_random call BIS_fnc_selectRandom;
		};

		{
			_unit setSkill [(_x select 0),(_x select 1)]
		} count _aicskill;
		
		ai_ground_units = (ai_ground_units + 1);

		_unit addEventHandler ["Killed",{[_this select 0, _this select 1, "ground"] call on_kill;}];

		if (!isNil "_mission") then {
			wai_mission_data select _mission set [0, (((wai_mission_data select _mission) select 0) + 1)];
			_unit setVariable ["missionclean", "ground"];
			_unit setVariable ["mission", _mission, true];
		};

	};

	if (!isNil "_launcher" && wai_use_launchers) then {
		call {
			//if (_launcher == "Random") exitWith { _launcher = (ai_launchers_AT + ai_launchers_AA) call BIS_fnc_selectRandom; };
			if (_launcher == "at") exitWith { _launcher = ai_wep_launchers_AT call BIS_fnc_selectRandom; };
			if (_launcher == "aa") exitWith { _launcher = ai_wep_launchers_AA call BIS_fnc_selectRandom; };
		};
		_rocket = _launcher call find_suitable_ammunition;
		_unit addMagazine _rocket;
		_unit addMagazine _rocket;
		_unit addWeapon _launcher;
	};

	_unitGroup setFormation "ECH LEFT";
	_unitGroup selectLeader ((units _unitGroup) select 0);

	if(_aitype == "Hero") then {
		if (!isNil "_mission") then {
			[_unitGroup, _mission] spawn hero_behaviour;
		} else {
			[_unitGroup] spawn hero_behaviour;
		};
	} else {
		if (!isNil "_mission") then {
			[_unitGroup, _mission] spawn bandit_behaviour;
		} else {
			[_unitGroup] spawn bandit_behaviour;
		};
	};

	if(_pos_z == 0) then {
		[_unitGroup,[_pos_x,_pos_y,_pos_z],_skill] spawn group_waypoints;
	};

	diag_log format ["WAI: Spawned a group of %1 AI (%3) at %2",_unitnumber,_position,_aitype];
	
	_unitGroup
};