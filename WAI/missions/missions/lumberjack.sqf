private ["_mission","_position","_loot","_rndnum","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [80] call find_position;

diag_log format["WAI: Mission:[%2] Lumber Mill started at %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_LumberJack,crates_large,[5,7]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_Ind_SawMill",[-2.4,24]],
	["Land_Ind_Timbers",[11,8.6,-.1]],
	["Land_Ind_Timbers",[16,12,-.1],-10.45],
	["Land_Ind_Timbers",[6,-15],104.95],
	["Misc_palletsfoiled",[5,-9,-0.009]],
	["Misc_palletsfoiled_heap",[9,-8,-0.05]],
	["Land_water_tank",[-10,-7]],
	["UralWreck",[-17,5],59.2],
	["MAP_t_quercus3s",[22,25,-0.2]]
],_position,_mission] call wai_spawnObjects;

// Troops
[[(_position select 0) + 12, (_position select 1) + 22.5, 0],5,"extreme",["random","at"],4,"random",_aiType,"random",[_aiType,150],_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 11, 0],5,"hard","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 1.12, (_position select 1) - 0.43, 0],5,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 13, (_position select 1) - 23, 0],_rndnum,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 13, (_position select 1) - 23, 0],_rndnum,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_LUMBER_ANNOUNCE","STR_CL_HERO_LUMBER_WIN","STR_CL_HERO_LUMBER_FAIL"];
} else {
	["STR_CL_BANDIT_LUMBERMILL_ANNOUNCE","STR_CL_BANDIT_LUMBERMILL_WIN","STR_CL_BANDIT_LUMBERMILL_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Lumber Mill", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;