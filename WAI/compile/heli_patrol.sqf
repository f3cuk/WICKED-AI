private ["_start_position","_diag_distance","_rndnum","_mission","_aitype","_aiskin","_skin","_aicskill","_wpnum","_radius","_gunner2","_gunner","_skillarray","_startingpos","_heli_class","_startPos","_helicopter","_unitGroup","_pilot","_skill","_position","_wp"];

_position 			= _this select 0;
_radius 			= _this select 1;
_wpnum 				= _this select 2;
_heli_class 		= _this select 3;
_skill 				= _this select 4;
_skin				= _this select 5;
_aitype				= _this select 6;

if (count _this > 7) then {
	_mission = _this select 7;
} else {
	_mission = nil;
};

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

ai_air_units 		= (ai_air_units +1);

// This random number is used to start the helicopter from 3000 to 4000 meters from the mission.
_rndnum = 3000 + round (random 1000);

_helicopter = createVehicle [_heli_class,[(_position select 0) + _rndnum,(_position select 1),100],[],0,"FLY"];
//_start_position = position _helicopter;
_diag_distance = _helicopter distance _position;
if (wai_debug_mode) then {
	diag_log format["WAI: the Heli Patrol has started %1 from the mission",_diag_distance];
};
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

ai_air_units 		= (ai_air_units + 1);

_gunner2 			= _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
_gunner2			assignAsGunner _helicopter;
_gunner2 			moveInTurret [_helicopter,[1]];
[_gunner2] 			joinSilent _unitGroup;

ai_air_units 		= (ai_air_units + 1);

call {
	if (_aitype == "Hero") 		exitWith {{ _x setVariable ["Hero",true,false]; _x setVariable ["humanity", ai_remove_humanity];} count [_pilot, _gunner, _gunner2]; };
	if (_aitype == "Bandit") 	exitWith {{ _x setVariable ["Bandit",true,false]; _x setVariable ["humanity", ai_add_humanity];} count [_pilot, _gunner, _gunner2]; };
	if (_aitype == "Special") 	exitWith {{ _x setVariable ["Special",true,false]; _x setVariable ["humanity", ai_special_humanity];} count [_pilot, _gunner, _gunner2]; };
};

{
	_pilot setSkill [_x,1]
} count _skillarray;

{
	_gunner 	setSkill [(_x select 0),(_x select 1)];
	_gunner2 	setSkill [(_x select 0),(_x select 1)];
} count _aicskill;

{
	_x addWeapon "Makarov_DZ";
	_x addMagazine "8Rnd_9x18_Makarov";
	_x addMagazine "8Rnd_9x18_Makarov";
} count (units _unitgroup);

{
	_x addEventHandler ["Killed",{[_this select 0, _this select 1, "air"] call on_kill;}];
} forEach (units _unitgroup);

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_helicopter];

if (!isNil "_mission") then {
	// Add unitGroup to array for mission clean up
	((wai_mission_data select _mission) select 1) set [count ((wai_mission_data select _mission) select 1), _unitGroup];
	((wai_mission_data select _mission) select 4) set [count ((wai_mission_data select _mission) select 4), _helicopter];
} else {
	(wai_static_data select 1) set [count (wai_static_data select 1), _unitGroup]; // Add unit group to an array for mission clean up
	(wai_static_data select 2) set [count (wai_static_data select 2), _helicopter];  // added for vehicle monitor
};

_unitGroup allowFleeing 0;
_unitGroup setBehaviour "AWARE";
_unitGroup setSpeedMode "FULL";

if(_aitype == "Hero") then {
	_unitGroup setCombatMode ai_hero_combatmode;
	_unitGroup setBehaviour ai_hero_behaviour;
} else {
	_unitGroup setCombatMode ai_bandit_combatmode;
	_unitGroup setBehaviour ai_bandit_behaviour;
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
