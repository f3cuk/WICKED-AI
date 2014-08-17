if (isServer) then {

	private ["_mission","_aipack","_aicskill","_position","_unitnumber","_skill","_gun","_mags","_backpack","_skin","_gear","_aiweapon","_aigear","_aiskin","_skillarray","_unitGroup","_weapon","_magazine","_weaponandmag","_gearmagazines","_geartools","_unit"];

	_position 			= _this select 0;
	_unitnumber 		= _this select 1;
	_skill 				= _this select 2;
	_gun 				= _this select 3;
	_mags 				= _this select 4;
	_backpack 			= _this select 5;
	_skin 				= _this select 6;
	_gear 				= _this select 7;

	if (count _this > 8) then {
		_mission = _this select 8;
	} else {
		_mission = false;
	};

	_aiweapon 			= [];
	_aigear 			= [];
	_aiskin 			= "";
	_aicskill 			= [];
	_aipack 			= "";
	_skillarray 		= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
	_unitGroup 			= createGroup east;
	_current_time		= time;

	for "_x" from 1 to _unitnumber do {

		switch (_gun) do {
			case 0 : {_aiweapon = ai_wep_assault;};
			case 1 : {_aiweapon = ai_wep_machine;};
			case 2 : {_aiweapon = ai_wep_sniper;};
			case "Random" : {_aiweapon = ai_wep_random call BIS_fnc_selectRandom;};
		};

		_weaponandmag 	= _aiweapon call BIS_fnc_selectRandom;
		_weapon 		= _weaponandmag select 0;
		_magazine 		= _weaponandmag select 1;

		switch (_gear) do {
			case 0 : {_aigear = ai_gear0;};
			case 1 : {_aigear = ai_gear1;};
			case 2 : {_aigear = ai_gear2;};
			case 3 : {_aigear = ai_gear3;};
			case 4 : {_aigear = ai_gear4;};
			case "Random" : {_aigear = ai_gear_random call BIS_fnc_selectRandom;};
		};
		
		_gearmagazines = _aigear select 0;
		_geartools = _aigear select 1;

		if (_skin == "Random") then {
			_aiskin = ai_skin call BIS_fnc_selectRandom;
		} else {
			_aiskin = _skin;
		};

		_unit = _unitGroup createUnit [_aiskin, [(_position select 0),(_position select 1),(_position select 2)], [], 10, "PRIVATE"];
		[_unit] joinSilent _unitGroup;

		if (_backpack == "Random") then {
			_aipack = ai_packs call BIS_fnc_selectRandom;
		} else {
			_aipack = _backpack;
		};
		
		_unit enableAI "TARGET";
		_unit enableAI "AUTOTARGET";
		_unit enableAI "MOVE";
		_unit enableAI "ANIM";
		_unit enableAI "FSM";
		_unit setCombatMode ai_combatmode;
		_unit setBehaviour ai_behaviour;
		removeAllWeapons _unit;
		removeAllItems _unit;
		_unit addweapon _weapon;

		if (sunOrMoon != 1) then {
			_unit addweapon "NVGoggles";
		};

		for "_i" from 1 to _mags do {
			_unit addMagazine _magazine;
		};
		
		_unit addBackpack _aipack;

		{
			_unit addMagazine _x
		} foreach _gearmagazines;

		{
			_unit addweapon _x
		} foreach _geartools;
		
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
		
		ai_ground_units = (ai_ground_units + 1);

		_unit addEventHandler ["Killed",{[_this select 0, _this select 1, "ground"] call on_kill;}];

		if (_mission) then {
			_unit setVariable ["missionclean", "ground"];
		};

	};
	// Stops them from killing eachother when they fire..
	_unitGroup setFormation "ECH LEFT";

	_unitGroup selectLeader ((units _unitGroup) select 0);

	[_unitGroup, _position, _mission] call group_waypoints;

	diag_log format ["WAI: Spawned a group of %1 bandits at %2", _unitnumber, _position];

};
