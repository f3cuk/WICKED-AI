if (isServer) then {

	private ["_ainum","_unarmed","_aicskill","_aitype","_mission","_aipack","_class","_position2","_static","_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_gearmagazines","_geartools","_unit"];

	_position 			= _this select 0;
	_class 				= _this select 1;
	_skill 				= _this select 2;
	_skin 				= _this select 3;
	_aitype				= _this select 4;

	if (ai_static_useweapon) then {
		_gun 			= _this select 5;
		_mags 			= _this select 6;
		_backpack 		= _this select 7;
		_gear 			= _this select 8;
	};
	
	if ((count _this == 10) OR (count _this == 6)) then {
		if (count _this == 10) 	then { _mission = _this select 9; };
		if (count _this == 6) 	then { _mission = _this select 5; };
	} else {
		_mission = nil;
	};

	_position2 		= [];
	_aiweapon 		= [];
	_aigear 		= [];
	_aiskin 		= "";
	_aipack 		= "";
	_unitnumber 	= count _position;

	if(_aitype == "Hero") then {
		_unitGroup	= createGroup RESISTANCE;
	} else {
		_unitGroup	= createGroup EAST;
	};
	
	if (!isServer) exitWith {};

	{
		_position2 = _x;

		call {
			if(_skin == "random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom; };
			if(_skin == "hero") 	exitWith { _aiskin = ai_hero_skin call BIS_fnc_selectRandom; };
			if(_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom; };
			if(_skin == "special") 	exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom; };
			_aiskin = _skin;
		};
		
		if(typeName _aiskin == "ARRAY") then {
			_aiskin = _aiskin call BIS_fnc_selectRandom;
		};

		call {
			if (_class == "Random") exitWith { _class = ai_static_weapons call BIS_fnc_selectRandom; };
		};

		_unit = _unitGroup createUnit [_aiskin, [0,0,0], [], 10, "PRIVATE"];
		
		_static = createVehicle [_class, [(_position2 select 0),(_position2 select 1),(_position2 select 2)], [], 0, "CAN_COLLIDE"];
		_static setDir round(random 360);
		_static setPos [(_position2 select 0),(_position2 select 1),(_position2 select 2)];
		
		[_unit] joinSilent _unitGroup;

		call {
			if(_aitype == "hero") 		exitWith { _unit setVariable ["Hero",true,true]; };
			if(_aitype == "bandit") 	exitWith { _unit setVariable ["Bandit",true,true]; };
			if(_aitype == "special") 	exitWith { _unit setVariable ["Special",true,true]; };
		};
		
		_unit enableAI "TARGET";
		_unit enableAI "AUTOTARGET";
		_unit enableAI "MOVE";
		_unit enableAI "ANIM";
		_unit enableAI "FSM";
		
		removeAllWeapons _unit;
		removeAllItems _unit;
		
		if (ai_static_useweapon) then {
		
			call {
				if(typeName(_gun) == "SCALAR") then {
					if(_gun == 0) 			exitWith { _aiweapon = ai_wep_assault; };
					if(_gun == 1) 			exitWith { _aiweapon = ai_wep_machine; };
					if(_gun == 2) 			exitWith { _aiweapon = ai_wep_sniper; };
				} else {
					if(_gun == "random") 	exitWith { _aiweapon = ai_wep_random call BIS_fnc_selectRandom; };
					if(_gun == "unarmed") 	exitWith { _unarmed = true; };
				};
			};

			_weapon 	= _aiweapon call BIS_fnc_selectRandom;
			_magazine 	= _weapon call find_suitable_ammunition;
			
			call {
				if(typeName(_gear) == "SCALAR") then {
					if(_gear == 0) 			exitWith { _aigear = ai_gear0; };
					if(_gear == 1) 			exitWith { _aigear = ai_gear1; };
				} else {
					if(_gear == "random") 	exitWith { _aigear = ai_gear_random call BIS_fnc_selectRandom; };
				};
			};

			call {
				if(_backpack == "random") 	exitWith { _aipack = ai_packs call BIS_fnc_selectRandom; };
				if(_backpack == "none") 	exitWith { };
				_aipack = _backpack;
			};

			_gearmagazines 		= _aigear select 0;
			_geartools 			= _aigear select 1;
			_unit 				addweapon _weapon;

			for "_i" from 1 to _mags do {
				_unit addMagazine _magazine;
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
		};
		
		if (ai_static_skills) then {

			{
				_unit setSkill [(_x select 0),(_x select 1)]
			} count ai_static_array;

		} else {

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
		};
		
		ai_emplacement_units = (ai_emplacement_units + 1);
		_unit addEventHandler ["Killed",{[_this select 0, _this select 1, "static"] call on_kill;}];
		_static addEventHandler ["GetOut",{(_this select 0) setDamage 1;}];
		PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_static];
			
		if (sunOrMoon != 1) then {
			_unit addweapon "NVGoggles";
		};
		
		_unit moveingunner _static;

		if (!isNil "_mission") then {
			_ainum = (wai_mission_data select _mission) select 0;
			wai_mission_data select _mission set [0, (_ainum + 1)];
			_static setVariable ["missionclean","static"];
			_static setVariable ["mission",_mission];
			_unit setVariable ["mission",_mission];
		};

		[_static] spawn vehicle_monitor;

	} forEach _position;

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

	diag_log format ["WAI: Spawned in %1 %2",_unitnumber,_class];

	_unitGroup
};