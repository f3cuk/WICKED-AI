private ["_mission","_position","_rndnum","_aiType","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [80] call find_position;

diag_log format["WAI: Mission:[%2] Cannibal started at %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_CannibalCave select 0;} else {Loot_CannibalCave select 1;};

//Spawn Crates
[[
	[_loot,crates_large,[5,7]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_R2_RockWall",[10,28,-4.15]],
	["MAP_R2_RockWall",[-23,9,-6.55],-96.315],
	["MAP_R2_RockWall",[25,4,-7.74],262.32],
	["MAP_R2_RockWall",[1,7,10.81],-29.29],
	["MAP_R2_RockWall",[18,-11,-5.509],-222.72],
	["MAP_R2_RockWall",[-22,6,-11.55],-44.01],
	["MAP_t_picea2s",[-13,-32,-0.1]],
	["MAP_t_picea2s",[-17,6,-0.2]],
	["MAP_t_pinusN2s",[-24,-53,-0.2]],
	["MAP_t_pinusN1s",[-22,-42,-0.2]],
	["MAP_t_picea1s",[-22.3,-35,-0.2]],
	["MAP_t_picea2s",[-33,-53,-0.2]],
	["MAP_t_picea2s",[-3,-43,-0.2]],
	["MAP_t_picea2s",[28,-39,-0.2]],
	["MAP_t_picea2s",[13,43,-0.2]],
	["MAP_t_picea1s",[57,11,-0.2]],
	["MAP_t_quercus3s",[31,49.3,-0.2]],
	["MAP_t_quercus3s",[-47,20,-0.2]],
	["MAP_R2_Rock1",[-47,-45,-14.29]],
	["Land_Campfire_burning",[-0.01,-0.01]],
	["Mass_grave",[-6,-7,-0.02],-50.94],
	["SKODAWreck",[-11,-46],151.15],
	["datsun01Wreck",[-2,-60],34.54],
	["UralWreck",[-41.3,-26],19.15]
],_position,_mission] call wai_spawnObjects;

[[(_position select 0) + 12, (_position select 1) + 42.5, .01],5,"extreme",["random","AT"],4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 11, (_position select 1) + 41, .01],5,"hard","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 12, (_position select 1) - 43, .01],5,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 13, (_position select 1) - 43, .01],_rndnum,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 20, (_position select 1) - 43, .01],_rndnum,"random","random",4,"random",_aiType,"random",_aiType,_mission] call spawn_group;

[
	_mission,
	_position, // Position of mission
	"Hard", // Difficulty
	"Cannibal Cave", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_GENERAL_CANNIBALCAVE_ANNOUNCE","STR_CL_GENERAL_CANNIBALCAVE_WIN","STR_CL_GENERAL_CANNIBALCAVE_FAIL"]
] call mission_winorfail;