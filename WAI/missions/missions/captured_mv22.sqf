private ["_mission","_position","_rndnum","_loot","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Captured MV22]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_CapturedMV22,"USBasicWeaponsBox",[11.2,12.2,.1]]
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
[[_position select 0,_position select 1,0],5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 33,(_position select 1) - 7,0.1],5,"Hard","Random",4,"Random","RU_Doctor","Random",[_aiType,100],_mission] call spawn_group;
[[(_position select 0) - 33,(_position select 1) - 18,0.1],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 1,(_position select 1) + 29,0.1],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 1,(_position select 1) + 29,0.1],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;


 
//Static Guns
[[
	[(_position select 0) - 9.3, (_position select 1) + 11.2, 0],
	[(_position select 0) - 6, (_position select 1) - 21.4, 0]
],"M2StaticMG","Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicles
["MV22_DZ",[(_position select 0) - 20.5,(_position select 1) - 5.2,0], _mission,true,-82.5] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [%2] captured_mv22 spawned a MV22 at %1", _position,_missionType];
};

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_MV22_ANNOUNCE","STR_CL_HERO_MV22_WIN","STR_CL_HERO_MV22_FAIL"];
} else {
	["STR_CL_BANDIT_MV22_ANNOUNCE","STR_CL_BANDIT_MV22_WIN","STR_CL_BANDIT_MV22_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Captured MV22", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
