private ["_rndnum","_mission","_position","_messages","_aiType","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Farmer]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_Farmer select 0;} else {Loot_Farmer select 1;};

//Spawn Crates
[[
	[_loot,crates_medium,[.3,0,.4]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_HouseV2_01A",[-37,15],-107],
	["MAP_Farm_WTower",[-17,32]],
	["MAP_sara_stodola3",[12,36.5],20.6],
	["MAP_Misc_Cargo1C",[17,4],5.9],
	["MAP_Misc_Cargo1C",[15,12],-41.2],
	["MAP_t_picea2s",[-17.5,9]],
	["MAP_t_picea2s",[-1,-13]],
	["MAP_t_picea2s",[-8.5,51.5]],
	["MAP_t_picea2s",[18.5,-9.4]],
	["Haystack",[7,24.5],15.3],
	["MAP_stodola_old_open",[0,-2,0.4],-80.8]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) -17,(_position select 1) +29,0],5,"Easy",["Random","AT"],4,"Random","RU_Villager2","Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) -12,(_position select 1) +20,0],_rndnum,"Random","Random",4,"Random","Citizen2_EP1","Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) -17,(_position select 1) +29,0],_rndnum,"Easy",["Random","AT"],4,"Random","RU_Villager2","Random",_aiType,_mission] call spawn_group;

//Spawn vehicles
["Tractor",[(_position select 0) -6.5, (_position select 1) +12.7],_mission,true,46.7] call custom_publish;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_FARMER_ANNOUNCE","STR_CL_HERO_FARMER_WIN","STR_CL_HERO_FARMER_FAIL"];
} else {
	["STR_CL_BANDIT_FARMER_ANNOUNCE","STR_CL_BANDIT_FARMER_WIN","STR_CL_BANDIT_FARMER_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Farmer", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
