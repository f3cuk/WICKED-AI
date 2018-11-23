private ["_rndnum","_mission","_position","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Medical Supply Camp]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_MediCamp,"USVehicleBox",[0,0],60]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_fort_watchtower",[1.5,12.6],-210],
	["MAP_MASH",[-17,5.3],60],
	["MAP_Stan_east",[-16.5,15.9],-30],
	["USMC_WarfareBFieldhHospital",[3,-4.4],60],
	["MAP_Stan_east",[-10,19.6],-30],
	["MAP_MASH",[-14,-0.4],60]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) - 7.5,(_position select 1) + 7.9,0],5,"Easy",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) - 26,(_position select 1) - 2.4,0],_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) - 26,(_position select 1) - 2.4,0],_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_MSC_ANNOUNCE","STR_CL_HERO_MSC_WIN","STR_CL_HERO_MSC_FAIL"];
} else {
	["STR_CL_BANDIT_MSC_ANNOUNCE","STR_CL_BANDIT_MSC_WIN","STR_CL_BANDIT_MSC_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Medical Supply Camp", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;