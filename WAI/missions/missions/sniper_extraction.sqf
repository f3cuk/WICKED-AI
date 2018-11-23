private ["_rndnum","_mission","_vehname","_vehicle","_position","_vehclass","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

//Military Chopper
_vehclass = armed_chopper call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

diag_log format["WAI: [Mission:[%2] Sniper Extraction]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_Extraction,crates_medium,[0,10]]
],_position,_mission] call wai_spawnCrate;

//Troops
[_position,5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 30, (_position select 1) - 30, 0],
	[(_position select 0) + 30, (_position select 1) + 30, 0],
	[(_position select 0) - 30, (_position select 1) - 30, 0],
	[(_position select 0) - 30, (_position select 1) + 30, 0]
],"M2StaticMG","Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicle
[_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [%2] sniper_extraction spawned a %1",_vehname,_missionType];
};

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_MILCHOPPER_ANNOUNCE","STR_CL_HERO_MILCHOPPER_WIN","STR_CL_HERO_MILCHOPPER_FAIL"];
} else {
	["STR_CL_BANDIT_EXTRACTION_ANNOUNCE","STR_CL_BANDIT_EXTRACTION_WIN","STR_CL_BANDIT_EXTRACTION_FAIL"];
};

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	format["Sniper Extraction %1", _vehname], // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
