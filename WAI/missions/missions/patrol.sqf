private ["_mission","_vehname","_vehicle","_position","_vehclass","_name","_locations","_location","_blacklist","_messages","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type

_loot = if (_missionType == "MainHero") then {Loot_Patrol select 0;} else {Loot_Patrol select 1;};

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_locations = nearestLocations [getMarkerPos "center", ["NameCityCapital","NameCity","NameVillage"],15000];
_location = _locations call BIS_fnc_selectRandom;
_position = position _location;
_name = text _location;
_blacklist = ["Stary Sobor"];

{
	if ((text _x) == (text _location) || (text _x) in _blacklist) then {
		_locations set [_forEachIndex, "rem"];
		_locations = _locations - ["rem"];
	};
} forEach _locations;

diag_log format["WAI: [Mission:[%2] Patrol]: Starting... %1",_position,_missionType];

//Spawn units
[[(_position select 0) + 4,(_position select 1),0.1],3,"Hard","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Spawn vehicles
_vehicle = [_vehclass,_position,_mission] call custom_publish;

// load the guns
[_vehicle,_vehclass] call load_ammo;

((wai_mission_data select _mission) select 3) set [count ((wai_mission_data select _mission) select 3), [_vehicle,_loot]];

if(wai_debug_mode) then {
	diag_log format["WAI: [%2] patrol spawned a %1",_vehname,_missionType];
};

_messages = if (_missionType == "MainHero") then {
	[["STR_CL_HERO_PATROL_ANNOUNCE",_name],"STR_CL_HERO_PATROL_WIN","STR_CL_HERO_PATROL_FAIL"];
} else {
	[["STR_CL_BANDIT_PATROL_ANNOUNCE",_name],"STR_CL_BANDIT_PATROL_WIN","STR_CL_BANDIT_PATROL_FAIL"];
};

[
	_mission,
	_position, // Position of mission
	"Medium", // Difficulty
	format["Patrol %1",_vehname], // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	3, // Number of wayPoints
	_locations, // WayPoints
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call patrol_winorfail;
