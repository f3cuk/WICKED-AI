private ["_loot","_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Medical Supply Camp]: Starting... %1",_position];

// Loot
_loot = [0,0,[70,crate_items_medical],3,1];

//Spawn Crates
[[
	[_loot,"USVehicleBox",[0,0],60]
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
[[(_position select 0) - 7.5,(_position select 1) + 7.9,0],5,"Easy",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) - 26,(_position select 1) - 2.4,0],_rndnum,"Easy","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) - 26,(_position select 1) - 2.4,0],_rndnum,"Easy","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Medical Supply Camp", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_MSC_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_MSC_WIN", // mission success
	"STR_CL_BANDIT_MSC_FAIL" // mission fail
] call mission_winorfail;