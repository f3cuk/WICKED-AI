private ["_mission","_position","_loot","_rndnum"];

_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: Mission:[Bandit] Lumber Mill started at %1",_position];

// Loot
_loot = [6,[8,crate_tools_sniper],[15,crate_items_wood],3,[4,crate_backpacks_large]];

//Spawn Crates
[[
	[_loot,crates_large,[5,7]]
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
[[(_position select 0) + 12, (_position select 1) + 22.5, 0],5,"extreme",["random","at"],4,"random","Hero","random",["Hero",150],_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 11, 0],5,"hard","random",4,"random","Hero","random","Hero",_mission] call spawn_group;
[[(_position select 0) - 1.12, (_position select 1) - 0.43, 0],5,"random","random",4,"random","Hero","random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 13, (_position select 1) - 23, 0],_rndnum,"random","random",4,"random","Hero","random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 13, (_position select 1) - 23, 0],_rndnum,"random","random",4,"random","Hero","random","Hero",_mission] call spawn_group;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Lumber Mill", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_LUMBERMILL_ANNOUNCE",	// mission announcement
	"STR_CL_BANDIT_LUMBERMILL_WIN",	// mission success
	"STR_CL_BANDIT_LUMBERMILL_FAIL" // mission fail
] call mission_winorfail;