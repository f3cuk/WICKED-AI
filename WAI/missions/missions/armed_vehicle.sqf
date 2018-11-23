private ["_mission","_rndnum","_vehname","_position","_vehclass","_messages","_aiType","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

diag_log format["WAI: [Mission:[%2] Armed Vehicle]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_ArmedVehicle,crates_small,[0,5]]
],_position,_mission] call wai_spawnCrate;

//Troops
[_position,5,"Medium",["Random","AT"],3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Static Guns
[[[(_position select 0),(_position select 1) + 10, 0]],"Random","Medium",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicles
[_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [%2] armed_vehicle spawned a %1",_vehname,_missionType];
};

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_ARMEDVEHICLE_ANNOUNCE","STR_CL_HERO_ARMEDVEHICLE_WIN","STR_CL_HERO_ARMEDVEHICLE_FAIL"];
} else {
	["STR_CL_BANDIT_ARMEDVEHICLE_ANNOUNCE","STR_CL_BANDIT_ARMEDVEHICLE_WIN","STR_CL_BANDIT_ARMEDVEHICLE_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["Disabled %1",_vehname], // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
