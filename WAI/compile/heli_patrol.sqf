if (isServer) then {

	private ["_aitype","_aiskin","_skin","_aicskill","_wpnum","_radius","_gunner2","_gunner","_skillarray","_startingpos","_heli_class","_startPos","_helicopter","_unitGroup","_pilot","_skill","_position","_wp"];

	_position 			= _this select 0;
	_startingpos 		= _this select 1;
	_radius 			= _this select 2;
	_wpnum 				= _this select 3;
	_heli_class 		= _this select 4;
	_skill 				= _this select 5;
	_skin				= _this select 6;
	_aitype				= _this select 7;

	_skillarray			= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

	call {
		if(_skill == "easy") 	exitWith { _aicskill = ai_skill_easy; };
		if(_skill == "medium") 	exitWith { _aicskill = ai_skill_medium; };
		if(_skill == "hard") 	exitWith { _aicskill = ai_skill_hard; };
		if(_skill == "extreme") exitWith { _aicskill = ai_skill_extreme; };
		if(_skill == "random") 	exitWith { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
		_aicskill = ai_skill_random call BIS_fnc_selectRandom;
	};

	call {
		if (_skin == "random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom; };
		if (_skin == "hero") 	exitWith { _aiskin = ai_hero_skin call BIS_fnc_selectRandom; };
		if (_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom; };
		if (_skin == "special") exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom; };
		_aiskin = _skin;
	};

	if(typeName _aiskin == "ARRAY") then {
		_aiskin = _aiskin call BIS_fnc_selectRandom;
	};

	if(_aitype == "Hero") then {
		_unitGroup	= createGroup RESISTANCE;
	} else {
		_unitGroup	= createGroup EAST;
	};

	_pilot 				= _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
	
	[_pilot] joinSilent _unitGroup;
	
	call {
		if (_aitype == "Hero") 		exitWith { _pilot setVariable ["Hero",true,true]; };
		if (_aitype == "Bandit") 	exitWith { _pilot setVariable ["Bandit",true,true]; };
		if (_aitype == "Special") 	exitWith { _pilot setVariable ["Special",true,true]; };
	};
	
	ai_air_units 		= (ai_air_units +1);

	_helicopter 		= createVehicle [_heli_class, [(_startingpos select 0),(_startingpos select 1), 200], [], 0, "FLY"];
	_helicopter 		setFuel 1;
	_helicopter 		engineOn true;
	_helicopter 		setVehicleAmmo 1;
	_helicopter 		flyInHeight 150;
	_helicopter 		lock true;
	_helicopter 		addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];

	_pilot 				assignAsDriver _helicopter;
	_pilot 				moveInDriver _helicopter;

	_gunner 			= _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
	_gunner 			assignAsGunner _helicopter;
	_gunner 			moveInTurret [_helicopter,[0]];

	[_gunner] 			joinSilent _unitGroup;

	call {
		if (_aitype == "Hero") 		exitWith { _gunner setVariable ["Hero",true,true]; };
		if (_aitype == "Bandit") 	exitWith { _gunner setVariable ["Bandit",true,true]; };
		if (_aitype == "Special") 	exitWith { _gunner setVariable ["Special",true,true]; };
	};
	
	ai_air_units 		= (ai_air_units + 1);

	_gunner2 			= _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
	_gunner2			assignAsGunner _helicopter;
	_gunner2 			moveInTurret [_helicopter,[1]];
	[_gunner2] 			joinSilent _unitGroup;

	call {
		if (_aitype == "Hero") 		exitWith { _gunner2 setVariable ["Hero",true,true]; };
		if (_aitype == "Bandit") 	exitWith { _gunner2 setVariable ["Bandit",true,true]; };
		if (_aitype == "Special") 	exitWith { _gunner2 setVariable ["Special",true,true]; };
	};

	ai_air_units 		= (ai_air_units + 1);

	{
		_pilot setSkill [_x,1]
	} count _skillarray;

	{
		_gunner 	setSkill [(_x select 0),(_x select 1)];
		_gunner2 	setSkill [(_x select 0),(_x select 1)];
	} count _aicskill;

	{
		_x addweapon "Makarov";
		_x addmagazine "8Rnd_9x18_Makarov";
		_x addmagazine "8Rnd_9x18_Makarov";
	} count (units _unitgroup);

	{
		_x addEventHandler ["Killed",{[_this select 0, _this select 1, "air"] call on_kill;}];
	} forEach (units _unitgroup);

	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_helicopter];
	[_helicopter] spawn vehicle_monitor;

	_unitGroup allowFleeing 0;
	_unitGroup setBehaviour "AWARE";
	_unitGroup setSpeedMode "FULL";

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

	if(_wpnum > 0) then {

		for "_i" from 1 to _wpnum do {
			_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
			_wp setWaypointType "MOVE";
			_wp setWaypointCompletionRadius 200;
		};

	};

	_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius 200;

	_unitGroup
};
