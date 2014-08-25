if (isServer) then {

	private ["_aicskill","_aitype","_mission","_aipack","_class","_position2","_static","_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_weaponandmag","_gearmagazines","_geartools","_unit"];

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
		if (count _this == 10) then {_mission = _this select 9;};
		if (count _this == 6) then {_mission = _this select 5;};
	} else {
		_mission = nil;
	};

	_position2 		= [];
	_aiweapon 		= [];
	_aigear 		= [];
	_aiskin 		= "";
	_aipack 		= "";

	_unitGroup 		= createGroup east;
	_unitnumber 	= count _position;

	if (!isServer) exitWith {};

	{
		_position2 = _x;

		call {
			if (_skin == "Hero") 	exitWith { _aiskin = ai_hero_skin call BIS_fnc_selectRandom; };
			if (_skin == "Bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom; };
			if (_skin == "Random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom; };
			if (_skin == "Special") exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom; };
			_aiskin = _skin;
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
			if (_aitype == "Hero") 		exitWith { _unit setVariable ["Hero",true,true]; };
			if (_aitype == "Bandit") 	exitWith { _unit setVariable ["Bandit",true,true]; };
			if (_aitype == "Special") 	exitWith { _unit setVariable ["Special",true,true]; };
		};
		
		_unit enableAI "TARGET";
		_unit enableAI "AUTOTARGET";
		_unit enableAI "MOVE";
		_unit enableAI "ANIM";
		_unit enableAI "FSM";
		
		if(_aitype == "Hero") then {
			_unit setCombatMode ai_hero_combatmode;
			_unit setBehaviour ai_hero_behaviour;
		} else {
			_unit setCombatMode ai_bandit_combatmode;
			_unit setBehaviour ai_bandit_behaviour;
		};
		
		removeAllWeapons _unit;
		removeAllItems _unit;
		
		if (ai_static_useweapon) then {

			switch (_gun) do {
				case 0 : {_aiweapon = ai_wep_assault;};
				case 1 : {_aiweapon = ai_wep_machine;};
				case 2 : {_aiweapon = ai_wep_sniper;};
				case "Random" : {_aiweapon = ai_wep_random call BIS_fnc_selectRandom;};
			};

			_weaponandmag 		= _aiweapon call BIS_fnc_selectRandom;
			_weapon 			= _weaponandmag select 0;

			_magazine = _weaponandmag select 1;
				switch (_gear) do {
				case 0 : {_aigear = ai_gear0;};
				case 1 : {_aigear = ai_gear1;};
				case "Random" : {_aigear = ai_gear_random call BIS_fnc_selectRandom;};
			};

			if (_backpack == "Random") then {
				_aipack = ai_packs call BIS_fnc_selectRandom;
			} else {
				_aipack = _backpack
			};

			_gearmagazines 		= _aigear select 0;
			_geartools 			= _aigear select 1;
			_unit 				addweapon _weapon;

			for "_i" from 1 to _mags do {
				_unit addMagazine _magazine;
			};

			_unit addBackpack _aipack;

			{
				_unit addMagazine _x
			} forEach _gearmagazines;

			{
				_unit addweapon _x
			} forEach _geartools;
		};
		
		if (ai_static_skills) then {

			{
				_unit setSkill [(_x select 0),(_x select 1)]
			} forEach ai_static_array;

		} else {

			switch (_skill) do {
				case "easy"		: { _aicskill = ai_skill_easy; };
				case "medium" 	: { _aicskill = ai_skill_medium; };
				case "hard" 	: { _aicskill = ai_skill_hard; };
				case "extreme" 	: { _aicskill = ai_skill_extreme; };
				case "Random" 	: { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
				default { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
			};

			{
				_unit setSkill [(_x select 0),(_x select 1)]
			} foreach _aicskill;
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
			_static setVariable ["missionclean", "static"];
			_unit setVariable ["mission", _mission];
			_static setVariable ["mission", _mission];
			[_static,_mission] spawn vehicle_monitor;
		} else {
			[_static] spawn vehicle_monitor;
		};

	} forEach _position;

	_unitGroup selectLeader ((units _unitGroup) select 0);

	diag_log format ["WAI: Spawned in %1 %2",_unitnumber,_class];

};
