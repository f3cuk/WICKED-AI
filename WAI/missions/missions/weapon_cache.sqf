private ["_mission","_position","_rndnum","_aiType","_messages","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Weapons Cache]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_WeaponCache select 0;} else {Loot_WeaponCache select 1;};

// Spawn crates
[[
	[_loot,crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_fortified_nest_big_EP1",[-14,23.5],-210],
	["Land_fortified_nest_big_EP1",[12,-24,-0.01],-390],
	["Land_HBarrier_large",[-18,1,-0.3],90],
	["Land_HBarrier_large",[-8,-16,-0.3],30],
	["Land_HBarrier_large",[18,-1.5,-0.3],90],
	["Land_HBarrier_large",[7,16,-0.3],30],
	["DesertLargeCamoNet_DZ",[-1,0],-26]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) + 6.5,(_position select 1) - 12,0],5,"Easy",["Random","AT"],3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 8,(_position select 1) + 14,0],5,"Easy","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[[(_position select 0) - 21,(_position select 1) - 12.5,0],_rndnum,"Easy","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[[(_position select 0) - 21,(_position select 1) - 12.5,0],_rndnum,"Easy","Random",3,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 18, (_position select 1) - 13, 0],
	[(_position select 0) - 19.5, (_position select 1) + 12, 0]
],"M2StaticMG","Easy",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_WEAPONCACHE_ANNOUNCE","STR_CL_HERO_WEAPONCACHE_WIN","STR_CL_HERO_WEAPONCACHE_FAIL"];
} else {
	["STR_CL_BANDIT_WEAPONCACHE_ANNOUNCE","STR_CL_BANDIT_WEAPONCACHE_WIN","STR_CL_BANDIT_WEAPONCACHE_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Weapon Cache", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;