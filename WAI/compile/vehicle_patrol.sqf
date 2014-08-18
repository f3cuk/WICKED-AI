if (isServer) then {

	private ["_aicskill", "_gunner", "_wpnum","_radius","_skillarray","_startingpos","_veh_class","_veh","_unitGroup","_pilot","_skill","_position","_wp"];

	_position 				= _this select 0;
	_startingpos 			= _this select 1;
	_radius 				= _this select 2;
	_wpnum 					= _this select 3;
	_veh_class 				= _this select 4;
	_skill 					= _this select 5;
	_aitype					= _this select 6;
	
	_skillarray 			= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

	switch (_skill) do {
		case "easy"		: { _aicskill = ai_skill_easy; };
		case "medium" 	: { _aicskill = ai_skill_medium; };
		case "hard" 	: { _aicskill = ai_skill_hard; };
		case "extreme" 	: { _aicskill = ai_skill_extreme; };
		case "Random" 	: { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
		default { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
	};

	_unitGroup 				= createGroup east;
	_pilot 					= _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
	[_pilot] 				joinSilent _unitGroup;
	switch (_aitype) do {
		case "Bandit":	{ _pilot setVariable ["humanity", ai_add_humanity, true]; };
		case "Hero":	{ _pilot setVariable ["humanity", -ai_remove_humanity, true]; };
	};
	ai_vehicle_units 		= (ai_vehicle_units + 1);

	_veh 					= createVehicle [_veh_class, [(_startingpos select 0),(_startingpos select 1), 0], [], 0, "CAN_COLLIDE"];
	_veh 					setFuel 1;
	_veh 					engineOn true;
	_veh 					setVehicleAmmo 1;
	_veh 					addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
	_veh 					allowCrewInImmobile true; 
	_veh 					lock true;

	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_veh];

	_pilot assignAsDriver 	_veh;
	_pilot moveInDriver 	_veh;

	_gunner 				= _unitGroup createUnit ["Bandit1_DZ", [0,0,0], [], 1, "NONE"];
	_gunner 				assignAsGunner _veh;
	_gunner 				moveInTurret [_veh,[0]];
	[_gunner] 				joinSilent _unitGroup;
	switch (_aitype) do {
		case "Bandit":	{ _gunner setVariable ["humanity", ai_add_humanity, true]; };
		case "Hero":	{ _gunner setVariable ["humanity", -ai_remove_humanity, true]; };
	};
	{
		_gunner setSkill [(_x select 0),(_x select 1)];
	} forEach _aicskill;


	ai_vehicle_units = (ai_vehicle_units + 1);

	{
		_pilot setSkill [_x,1]
	} forEach _skillarray;

	{
		_x addweapon "Makarov";
		_x addmagazine "8Rnd_9x18_Makarov";
		_x addmagazine "8Rnd_9x18_Makarov";
	} forEach (units _unitgroup);

	{
		_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill;}];
	} forEach (units _unitgroup);

	[_veh] spawn vehicle_monitor;

	_unitGroup 				allowFleeing 0;
	_unitGroup 				setBehaviour "AWARE";
	_unitGroup 				setCombatMode "RED";

	if(_wpnum > 0) then {

		for "_x" from 1 to _wpnum do
		{		
			_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],_radius];
			_wp setWaypointType "SAD";
			_wp setWaypointCompletionRadius 200;
		};

	};

	_wp = _unitGroup addWaypoint [[(_position select 0),(_position select 1),0],100];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius 200;

	waitUntil{clean_running_mission};

	if(clean_running_mission) then { 
		deleteVehicle _veh;
		deleteVehicle _gunner;
		deleteVehicle _pilot;
	};

};
