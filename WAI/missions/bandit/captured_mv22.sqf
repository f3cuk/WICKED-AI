private ["_mission","_position","_rndnum","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Captured MV22]: Starting... %1",_position];

// Loot
_loot = [0,0,[80,crate_items_medical],3,1];

//Spawn Crates
[[
	[_loot,"USBasicWeaponsBox",[11.2,12.2,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["USMC_WarfareBFieldhHospital",[12.7,6.5],-210],
	["Barrack2",[16,-11],150],
	["Misc_cargo_cont_small",[2.8,17.4],12.5],
	["Barrack2",[9,-15],150],
	["Misc_cargo_cont_small",[6.7,18.3],12.5]
],_position,_mission] call wai_spawnObjects;

//Troops
[[_position select 0,_position select 1,0],5,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 33,(_position select 1) - 7,0.1],5,"Hard","Random",4,"Random","RU_Doctor","Random",["Hero",100],_mission] call spawn_group;
[[(_position select 0) - 33,(_position select 1) - 18,0.1],5,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 1,(_position select 1) + 29,0.1],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 1,(_position select 1) + 29,0.1],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;


 
//Static Guns
[[
	[(_position select 0) - 9.3, (_position select 1) + 11.2, 0],
	[(_position select 0) - 6, (_position select 1) - 21.4, 0]
],"M2StaticMG","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicles
["MV22_DZ",[(_position select 0) - 20.5,(_position select 1) - 5.2,0], _mission,true,-82.5] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Bandit] captured_mv22 spawned a MV22 at %1", _position];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Captured MV22", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_MV22_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_MV22_WIN", // mission success
	"STR_CL_BANDIT_MV22_FAIL" // mission fail
] call mission_winorfail;
