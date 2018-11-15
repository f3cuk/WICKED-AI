private ["_mission","_position","_rndnum"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Black Hawk Crash]: Starting... %1",_position];

//Spawn Crates
[[
	[[5,5,10,3,2],crates_medium,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["UH60_ARMY_Wreck_burned_DZ",[5,5]]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Medium",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[_position,5,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 25, (_position select 1) + 25, 0],
	[(_position select 0) - 25, (_position select 1) - 25, 0]
],"M2StaticMG","Easy","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Black Hawk Crash", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_BHCRASH_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_BHCRASH_WIN",	// mission success
	"STR_CL_BANDIT_BHCRASH_FAIL" // mission fail
] call mission_winorfail;
