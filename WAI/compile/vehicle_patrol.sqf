if (isServer) then {

	private ["_ainum","_vehicle","_aiskin","_skin","_mission","_aitype","_aicskill", "_gunner", "_wpnum","_radius","_skillarray","_startingpos","_veh_class","_veh","_unitGroup","_pilot","_skill","_position","_wp"];

	_position 				= _this select 0;
	_startingpos 			= _this select 1;
	_radius 				= _this select 2;
	_wpnum 					= _this select 3;
	_veh_class 				= _this select 4;
	_skill 					= _this select 5;
	_skin					= _this select 6;
	_aitype					= _this select 7;

	if (count _this > 8) then {
		_mission = _this select 8;
	} else {
		_mission = nil;
	};

	_skillarray 			= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

	call {
		if(_skill == "easy") 		exitWith { _aicskill = ai_skill_easy; };
		if(_skill == "medium") 		exitWith { _aicskill = ai_skill_medium; };
		if(_skill == "hard") 		exitWith { _aicskill = ai_skill_hard; };
		if(_skill == "extreme") 	exitWith { _aicskill = ai_skill_extreme; };
		if(_skill == "random") 		exitWith { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
		_aicskill = ai_skill_random call BIS_fnc_selectRandom;
	};

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

	if(_aitype == "Hero") then {
		_unitGroup	= createGroup RESISTANCE;
	} else {
		_unitGroup	= createGroup EAST;
	};

	_pilot 					= _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
	[_pilot] 				joinSilent _unitGroup;
	
	call {
		if (_aitype == "hero") 		exitWith { _pilot setVariable ["Hero",true,true]; };
		if (_aitype == "bandit") 	exitWith { _pilot setVariable ["Bandit",true,true]; };
		if (_aitype == "special") 	exitWith { _pilot setVariable ["Special",true,true]; };
	};
	
	ai_vehicle_units 		= (ai_vehicle_units + 1);

	_vehicle 				= createVehicle [_veh_class, [(_startingpos select 0),(_startingpos select 1), 0], [], 0, "CAN_COLLIDE"];
	_vehicle 				setFuel 1;
	_vehicle 				engineOn true;
	_vehicle 				setVehicleAmmo 1;
	_vehicle 				addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
	_vehicle 				allowCrewInImmobile true; 
	_vehicle 				lock true;

	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_vehicle];

	_pilot assignAsDriver 	_vehicle;
	_pilot moveInDriver 	_vehicle;

	_gunner 				= _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
	_gunner 				assignAsGunner _vehicle;
	_gunner 				moveInTurret [_vehicle,[0]];
	[_gunner] 				joinSilent _unitGroup;
	
	call {
		if (_aitype == "hero") 		exitWith { _gunner setVariable ["Hero",true,true]; };
		if (_aitype == "bandit") 	exitWith { _gunner setVariable ["Bandit",true,true]; };
		if (_aitype == "special") 	exitWith { _gunner setVariable ["Special",true,true]; };
	};
	
	{
		_gunner setSkill [(_x select 0),(_x select 1)];
	} count _aicskill;

	ai_vehicle_units = (ai_vehicle_units + 1);

	{
		_pilot setSkill [_x,1]
	} count _skillarray;

	{
		_x addweapon "Makarov";
		_x addmagazine "8Rnd_9x18_Makarov";
		_x addmagazine "8Rnd_9x18_Makarov";
	} count (units _unitgroup);

	{
		_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill;}];
	} forEach (units _unitgroup);

	if (!isNil "_mission") then {
		_vehicle setVariable ["missionclean","vehicle"];
		_vehicle setVariable ["mission",_mission];
		{
			_ainum = (wai_mission_data select _mission) select 0;
			wai_mission_data select _mission set [0, (_ainum + 1)];
			_x setVariable ["mission",_mission]; 
		} count (crew _vehicle);
	};

	[_vehicle] spawn vehicle_monitor;

	_unitGroup 				allowFleeing 0;

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
	
	_unitGroup
};
