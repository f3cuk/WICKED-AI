private ["_mission","_position","_rndnum","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Scout Patrol]: Starting... %1",_position,_missionType];

// Spawn crates
[[
	[Loot_ScoutPatrol,crates_medium,[0,0]]
],_position,_mission] call wai_spawnCrate;

//Troops
[_position,5,"Easy",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[_position,_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[_position,_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Spawn vehicle
[civil_vehicles,_position,_mission] call custom_publish;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_BANDITPATROL_ANNOUNCE","STR_CL_HERO_BANDITPATROL_WIN","STR_CL_HERO_BANDITPATROL_FAIL"];
} else {
	["STR_CL_BANDIT_HEROPATROL_ANNOUNCE","STR_CL_BANDIT_HEROPATROL_WIN","STR_CL_BANDIT_HEROPATROL_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Scout Patrol", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
