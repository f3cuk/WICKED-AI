private ["_rndnum","_mission","_vehname","_vehicle","_position","_vehclass","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Military Chopper
_vehclass = armed_chopper call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Sniper Extraction]: Starting... %1",_position];

// Loot
_loot = [[10,ai_wep_sniper],[4,crate_tools_sniper],[4,crate_items_sniper],3,2];

//Spawn Crates
[[
	[_loot,crates_medium,[0,10]]
],_position,_mission] call wai_spawnCrate;

//Troops
[_position,5,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 30, (_position select 1) - 30, 0],
	[(_position select 0) + 30, (_position select 1) + 30, 0],
	[(_position select 0) - 30, (_position select 1) - 30, 0],
	[(_position select 0) - 30, (_position select 1) + 30, 0]
],"M2StaticMG","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicle
[_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Bandit] sniper_extraction spawned a %1",_vehname];
};

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	format["Sniper Extraction %1", _vehname], // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_EXTRACTION_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_EXTRACTION_WIN", // mission success
	"STR_CL_BANDIT_EXTRACTION_FAIL" // mission fail
] call mission_winorfail;
