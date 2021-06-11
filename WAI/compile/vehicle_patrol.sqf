if (!wai_enable_patrols) exitWith {};
local _position	= _this select 0;
local _startingpos = _this select 1;
local _radius = _this select 2;
local _wpnum = _this select 3;
local _veh_class = _this select 4;
local _skill = _this select 5;
local _skin	= _this select 6;
local _aitype = _this select 7;
local _mission = nil;
if (count _this > 8) then {
	_mission = _this select 8;
};
local _unitGroup = grpNull;
local _wp = [];

local _aicskill = call {
	if(_skill == "easy") 		exitWith {ai_skill_easy;};
	if(_skill == "medium") 		exitWith {ai_skill_medium;};
	if(_skill == "hard") 		exitWith {ai_skill_hard;};
	if(_skill == "extreme") 	exitWith {ai_skill_extreme;};
	if(_skill == "random") 		exitWith {ai_skill_random call BIS_fnc_selectRandom;};
	ai_skill_random call BIS_fnc_selectRandom;
};

local _aiskin = call {
	if(_skin == "random") 	exitWith {ai_all_skin call BIS_fnc_selectRandom;};
	if(_skin == "hero") 	exitWith {ai_hero_skin call BIS_fnc_selectRandom;};
	if(_skin == "bandit") 	exitWith {ai_bandit_skin call BIS_fnc_selectRandom;};
	if(_skin == "special") 	exitWith {ai_special_skin call BIS_fnc_selectRandom;};
	_skin;
};

if(typeName _aiskin == "ARRAY") then {
	_aiskin = _aiskin call BIS_fnc_selectRandom;
};

if(_aitype == "Hero") then {
	_unitGroup	= createGroup RESISTANCE;
} else {
	_unitGroup	= createGroup EAST;
};

local _driver = _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
[_driver] joinSilent _unitGroup;

call {
	if (_aitype == "hero") exitWith {_driver setVariable ["Hero",true,false]; _driver setVariable ["humanity", ai_remove_humanity];};
	if (_aitype == "bandit") exitWith {_driver setVariable ["Bandit",true,false]; _driver setVariable ["humanity", ai_add_humanity];};
	if (_aitype == "special") exitWith {_driver setVariable ["Special",true,false]; _driver setVariable ["humanity", ai_special_humanity];};
};

local _vehicle = createVehicle [_veh_class, [(_startingpos select 0),(_startingpos select 1), 0], [], 0, "CAN_COLLIDE"];
_vehicle setFuel 1;
_vehicle engineOn true;
_vehicle setVehicleAmmo 1;
_vehicle allowCrewInImmobile true; 
_vehicle lock true;
_vehicle addEventHandler ["GetOut",{
	local _veh = _this select 0;
	local _role = _this select 1;
	local _unit = _this select 2;
	if (_role == "driver") then {
		_unit moveInDriver _veh;
	} else {
		_unit moveInTurret [_veh,[0]];
	};
}];

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_vehicle];

_driver assignAsDriver _vehicle;
_driver moveInDriver _vehicle;

local _gunner = _unitGroup createUnit [_aiskin, [0,0,0], [], 1, "NONE"];
_gunner assignAsGunner _vehicle;
_gunner moveInTurret [_vehicle,[0]];
[_gunner] joinSilent _unitGroup;

[_driver, _gunner] orderGetIn true;

call {
	if (_aitype == "hero") exitWith {_gunner setVariable ["Hero",true,false]; _gunner setVariable ["humanity", ai_remove_humanity];};
	if (_aitype == "bandit") exitWith {_gunner setVariable ["Bandit",true,false]; _gunner setVariable ["humanity", ai_add_humanity];};
	if (_aitype == "special") exitWith {_gunner setVariable ["Special",true,false]; _gunner setVariable ["humanity", ai_special_humanity];};
};

{
	_gunner setSkill [(_x select 0),(_x select 1)];
} count _aicskill;
{
	_driver setSkill [_x,1];
} count ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

{
	_x addWeapon "Makarov_DZ";
	_x addMagazine "8Rnd_9x18_Makarov";
	_x addMagazine "8Rnd_9x18_Makarov";
} count (units _unitgroup);

{
	_x addEventHandler ["Killed",{[_this select 0, _this select 1, "vehicle"] call on_kill;}];
} forEach (units _unitgroup);

if (!isNil "_mission") then {
	_vehicle setVariable ["mission" + dayz_serverKey, _mission, false];
	
	((wai_mission_data select _mission) select 1) set [count ((wai_mission_data select _mission) select 1), _unitGroup];
	((wai_mission_data select _mission) select 4) set [count ((wai_mission_data select _mission) select 4), _vehicle];
	{
		_ainum = (wai_mission_data select _mission) select 0;
		wai_mission_data select _mission set [0, (_ainum + 1)];
		_x setVariable ["mission" + dayz_serverKey, _mission, false];
		_x setVariable ["noKey",true];
	} count (crew _vehicle);
} else {
	{wai_static_data set [0, ((wai_static_data select 0) + 1)];} count (crew _vehicle);
	(wai_static_data select 1) set [count (wai_static_data select 1), _unitGroup];
	(wai_static_data select 2) set [count (wai_static_data select 2), _vehicle];
};

_unitGroup allowFleeing 0;

if(_aitype == "Hero") then {
	_unitGroup setCombatMode ai_hero_combatmode;
	_unitGroup setBehaviour ai_hero_behaviour;
} else {
	_unitGroup setCombatMode ai_bandit_combatmode;
	_unitGroup setBehaviour ai_bandit_behaviour;
};

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

