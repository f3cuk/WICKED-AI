private ["_mission","_position","_rndnum","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Black Hawk Crash]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[[5,5,10,3,2],crates_medium,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["UH60_ARMY_Wreck_burned_DZ",[5,5]]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Medium",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Medium","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 25, (_position select 1) + 25, 0],
	[(_position select 0) - 25, (_position select 1) - 25, 0]
],"M2StaticMG","Easy",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_BHCRASH_ANNOUNCE","STR_CL_HERO_BHCRASH_WIN","STR_CL_HERO_BHCRASH_FAIL"];
} else {
	["STR_CL_BANDIT_BHCRASH_ANNOUNCE","STR_CL_BANDIT_BHCRASH_WIN","STR_CL_BANDIT_BHCRASH_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Black Hawk Crash", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
