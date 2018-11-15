private ["_mission","_position","_rndnum","_vehclass"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Hero] Bandit Patrol]: Starting... %1",_position];

// Spawn crates
[[
	[[4,8,36,3,2],crates_medium,[0,0]]
],_position,_mission] call wai_spawnCrate;

//Troops
[_position,5,"Easy",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 3);
[_position,_rndnum,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 3);
[_position,_rndnum,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Spawn vehicle
_vehclass  = civil_vehicles call BIS_fnc_selectRandom;
[_vehclass,_position,_mission] call custom_publish;

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Bandit Patrol", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_BANDITPATROL_ANNOUNCE", // mission announcement
	"STR_CL_HERO_BANDITPATROL_WIN", // mission success
	"STR_CL_HERO_BANDITPATROL_FAIL" // mission fail
] call mission_winorfail;
