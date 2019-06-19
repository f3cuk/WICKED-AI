private ["_rndnum","_mission","_position","_aiType","_messages","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Hero Outpost]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_Outpost select 0;} else {Loot_Outpost select 1;};

//Spawn Crates
[[
	[_loot,crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_76n6_ClamShell",[-6,25],172],
	["MAP_budova4_in",[-29,18],0.24],
	["MAP_budova4_in",[-29,8],0.24],
	["MAP_Mil_Barracks_L",[-23,-13],-119],
	["MAP_CamoNetB_NATO",[1.6,0],-203],
	["MAP_fort_watchtower",[19,11],-185],
	["MAP_fort_watchtower",[4,-20],-103]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) + 2,_position select 1,0],5,"Easy",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) - 2,_position select 1,0],_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0),(_position select 1) + 15,0],_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_BANDITOUTPOST_ANNOUNCE","STR_CL_HERO_BANDITOUTPOST_WIN","STR_CL_HERO_BANDITOUTPOST_FAIL"];
} else {
	["STR_CL_BANDIT_HEROOUTPOST_ANNOUNCE","STR_CL_BANDIT_HEROOUTPOST_WIN","STR_CL_BANDIT_HEROOUTPOST_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Outpost", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;