private ["_ainum","_unarmed","_aicskill","_aitype","_mission","_aipack","_class","_position2","_static","_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_gearmagazines","_geartools","_unit"];

if (!wai_enable_static_guns) exitWith {};

_position 	  = _this select 0;
_class 		  = _this select 1;
_skill 		  = _this select 2;
_skin 		  = _this select 3;
_aitype		  = _this select 4;

if (ai_static_useweapon) then {
	_gun 	  = _this select 5;
	_mags 	  = _this select 6;
	_backpack = _this select 7;
	_gear 	  = _this select 8;
};

if ((count _this == 10) OR (count _this == 6)) then {
	if (count _this == 10) 	then { _mission = _this select 9; };
	if (count _this == 6) 	then { _mission = _this select 5; };
} else {
	_mission = nil;
};

_aiweapon = [];
_aigear = [];
_aiskin = "";
_aipack = "";
_unarmed = false;
_unitnumber = count _position;

_unitGroup = if(_aitype == "Hero") then {createGroup RESISTANCE;} else {createGroup EAST;};

if (!isNil "_mission") then {
	((wai_mission_data select _mission) select 1) set [count ((wai_mission_data select _mission) select 1), _unitGroup];
} else {
	(wai_static_data select 1) set [count (wai_static_data select 1), _unitGroup];
};

{

	call {
		if(_skin == "random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom;};
		if(_skin == "hero") 	exitWith { _aiskin = ai_hero_skin call BIS_fnc_selectRandom;};
		if(_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom;};
		if(_skin == "special") 	exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom;};
		_aiskin = _skin;
	};
	
	if(typeName _aiskin == "ARRAY") then {
		_aiskin = _aiskin call BIS_fnc_selectRandom;
	};

	if (_class == "Random") then {_class = ai_static_weapons call BIS_fnc_selectRandom;};

	_unit = _unitGroup createUnit [_aiskin, [0,0,0], [], 10, "PRIVATE"];
	
	_static = _class createVehicle _x;
	_static setPos _x;
	
	[_unit] joinSilent _unitGroup;

	call {
		if (_aitype == "hero") exitWith {_unit setVariable ["Hero",true,false]; _unit setVariable ["humanity", ai_remove_humanity]; };
		if (_aitype == "bandit") exitWith {_unit setVariable ["Bandit",true,false]; _unit setVariable ["humanity", ai_add_humanity]; };
		if (_aitype == "special") exitWith {_unit setVariable ["Special",true,false]; _unit setVariable ["humanity", ai_special_humanity]; };
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
				if(_gun == 0) 			exitWith { _aiweapon = ai_wep_random call BIS_fnc_selectRandom; };
				if(_gun == 1) 			exitWith { _aiweapon = ai_wep_machine;};
				if(_gun == 2) 			exitWith { _aiweapon = ai_wep_sniper;};
			} else {
				if(_gun == "random") 	exitWith { _aiweapon = ai_wep_random call BIS_fnc_selectRandom; };
				if(_gun == "unarmed") 	exitWith { _unarmed = true; };
			};
		};
		
		if (!_unarmed) then {
			_weapon = if (typeName (_aiweapon) == "ARRAY") then {_aiweapon select (floor (random (count _aiweapon)))} else {_aiweapon};
			_magazine = _weapon call find_suitable_ammunition;
		};

		_weapon 	= _aiweapon call BIS_fnc_selectRandom;
		_magazine 	= _weapon call find_suitable_ammunition;
		
		_aigear = call {
			if(typeName(_gear) == "SCALAR") then {
				if(_gear == 0) exitWith {ai_gear0;};
				if(_gear == 1) exitWith {ai_gear1;};
				if(_gear == 2) exitWith {ai_gear2;};
				if(_gear == 3) exitWith {ai_gear3;};
				if(_gear == 4) exitWith {ai_gear4;};
			} else {
				if(_gear == "random") exitWith {ai_gear_random select (floor (random (count ai_gear_random)));};
			};
		};

		call {
			if(_backpack == "random") exitWith {_aipack = ai_packs call BIS_fnc_selectRandom;};
			if(_backpack == "none") exitWith {};
			_aipack = _backpack;
		};

		_gearmagazines = _aigear select 0;
		_geartools = _aigear select 1;

		if (!_unarmed) then {
			for "_i" from 1 to _mags do {
				_unit addMagazine _magazine;
			};
			_unit addWeapon _weapon;
		};

		if (_backpack != "none") then {
			_unit addBackpack _aipack;
		};

		{
			_unit addMagazine _x
		} count _gearmagazines;

		{
			_unit addWeapon _x
		} count _geartools;
	};
	
	if (ai_static_skills) then {

		{
			_unit setSkill [(_x select 0),(_x select 1)]
		} count ai_static_array;

	} else {

		_aicskill = call {
			if (_skill == "easy") exitWith {ai_skill_easy;};
			if (_skill == "medium") exitWith {ai_skill_medium;};
			if (_skill == "hard") exitWith {ai_skill_hard;};
			if (_skill == "extreme") exitWith {ai_skill_extreme;};
			if (_skill == "random") exitWith {ai_skill_random call BIS_fnc_selectRandom; };
			ai_skill_random call BIS_fnc_selectRandom;
		};

		{
			_unit setSkill [(_x select 0),(_x select 1)]
		} count _aicskill;
	};
	
	_unit addEventHandler ["Killed",{[_this select 0, _this select 1] call on_kill;}];
	
	_static addEventHandler ["GetOut",{
		_unit = _this select 2;
		_static = _this select 0;
		if (alive _unit) then {_unit moveInGunner _static};
	}];
		
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_static];
		
	if (sunOrMoon != 1) then {
		_unit addWeapon "NVGoggles";
	};
	
	_unit moveInGunner _static;
	_unit setVariable ["noKey",true];

	if (!isNil "_mission") then {
		_ainum = (wai_mission_data select _mission) select 0;
		wai_mission_data select _mission set [0, (_ainum + 1)];
		((wai_mission_data select _mission) select 4) set [count ((wai_mission_data select _mission) select 4), _static];
		_static setVariable ["mission" + dayz_serverKey, _mission, false];
		_unit setVariable ["mission" + dayz_serverKey, _mission, false];
	} else {
		wai_static_data set [0, ((wai_static_data select 0) + 1)];
		(wai_static_data select 2) set [count (wai_static_data select 2), _static];
	};

} forEach _position;

_unitGroup selectLeader ((units _unitGroup) select 0);

if(_aitype == "Hero") then {
	_unitGroup setCombatMode ai_hero_combatmode;
	_unitGroup setBehaviour ai_hero_behaviour;
} else {
	_unitGroup setCombatMode ai_bandit_combatmode;
	_unitGroup setBehaviour ai_bandit_behaviour;
};

if (wai_debug_mode) then {diag_log format ["WAI: Spawned in %1 %2",_unitnumber,_class];};
