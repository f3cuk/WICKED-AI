private ["_mission","_position","_rndnum","_messages","_aiType","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Ural Attack]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_UralAttack,crates_medium,[-5,-5]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["UralWreck",[0,0]]
],_position,_mission] call wai_spawnObjects;

//Troops
_rndnum = round (random 5);
[_position,5,"Easy",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[_position,_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[_position,_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_URAL_ANNOUNCE","STR_CL_HERO_URAL_WIN","STR_CL_HERO_URAL_FAIL"];
} else {
	["STR_CL_BANDIT_URAL_ANNOUNCE","STR_CL_BANDIT_URAL_WIN","STR_CL_BANDIT_URAL_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Ural Attack", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;