private ["_mission","_position","_rndnum"];

_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: Mission:[Bandit] Radio Tower started at %1",_position];

//Spawn Crates
[[
	[[10,5,30,3,2],"UNBasicWeapons_EP1",[.01,.01]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_cihlovej_dum_in",[-3,-1]],
	["Land_Com_tower_ep1",[5,-2]],
	["LADAWreck",[-7.5,-3]],
	["FoldTable",[-1.2,-4]],
	["FoldChair",[-1,-3]],
	["SmallTV",[-1.7,-4,0.82]],
	["SatPhone",[-0.8,-4,0.82],-201.34],
	["MAP_t_picea2s",[-4.5,7]],
	["MAP_t_picea2s",[13,10]],
	["MAP_t_pinusN2s",[3,9]],
	["MAP_t_pinusN1s",[8,17]],
	["MAP_t_picea1s",[7,10]],
	["MAP_t_picea2s",[34,-29]],
	["MAP_t_fraxinus2s",[-14,1]],
	["MAP_t_carpinus2s",[28,-13]]
],_position,_mission] call wai_spawnObjects;

// Troops
[[(_position select 0) - 1.2, (_position select 1)  - 20, 0],5,"extreme",["random","at"],4,"random","Hero","random",["Hero",150],_mission] call spawn_group;
[[(_position select 0) - 4, (_position select 1) + 16, 0],5,"hard","random",4,"random","Hero","random","Hero",_mission] call spawn_group;
[[(_position select 0) - 17, (_position select 1) - 4, 0],5,"random","random",4,"random","Hero","random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 14, (_position select 1) - 3, 0],_rndnum,"random","random",4,"random","Hero","random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 14, (_position select 1) - 3, 0],_rndnum,"random","random",4,"random","Hero","random","Hero",_mission] call spawn_group;

[
	_mission, // Mission number
	_position, // Position of mission
	"hard", // Difficulty
	"Radio Tower", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_RADIOTOWER_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_RADIOTOWER_WIN", // mission success
	"STR_CL_BANDIT_RADIOTOWER_FAIL" // mission fail
] call mission_winorfail;