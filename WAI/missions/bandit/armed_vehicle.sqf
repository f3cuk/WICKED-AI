private ["_mission","_rndnum","_vehname","_position","_vehclass","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Armed Vehicle]: Starting... %1",_position];

// Loot
_loot = [0,0,[25,crate_items_chainbullets],0,2];

//Spawn Crates
[[
	[_loot,crates_small,[0,5]]
],_position,_mission] call wai_spawnCrate;

//Troops
[_position,5,"Medium",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[_position,5,"Medium","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[[(_position select 0),(_position select 1) + 10, 0]],"Random","Medium","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

//Spawn vehicles
[_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Bandit] armed_vehicle spawned a %1",_vehname];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["Disabled %1",_vehname], // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_ARMEDVEHICLE_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_ARMEDVEHICLE_WIN", // mission success
	"STR_CL_BANDIT_ARMEDVEHICLE_FAIL" // mission fail
] call mission_winorfail;
