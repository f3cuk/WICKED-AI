private ["_mission","_position","_rndnum"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Hero] Ural Attack]: Starting... %1",_position];

//Spawn Crates
[[
	[[4,8,36,3,2],crates_medium,[-5,-5]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["UralWreck",[0,0]]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Easy",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 3);
[_position,_rndnum,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 3);
[_position,_rndnum,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Condition
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Ural Attack", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_URAL_ANNOUNCE",	// mission announcement
	"STR_CL_HERO_URAL_WIN", // mission success
	"STR_CL_HERO_URAL_FAIL" // mission fail
] call mission_winorfail;