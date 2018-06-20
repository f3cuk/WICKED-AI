private ["_crate_type","_mission","_position","_crate","_rndnum","_baserunover","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Weapons Cache]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_small call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings 
_baserunover0 = createVehicle ["Land_fortified_nest_big_EP1",[(_position select 0) - 14, (_position select 1) + 23.5,0],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["Land_fortified_nest_big_EP1",[(_position select 0) + 12, (_position select 1) - 24,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["Land_HBarrier_large",[(_position select 0) - 18, (_position select 1) + 1,-0.3],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["Land_HBarrier_large",[(_position select 0) - 8, (_position select 1) - 16,-0.3],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Land_HBarrier_large",[(_position select 0) + 18, (_position select 1) - 1.5,-0.3],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["Land_HBarrier_large",[(_position select 0) + 7, (_position select 1) + 16,-0.3],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["DesertLargeCamoNet_DZ",[(_position select 0) - 1, (_position select 1),0],[], 0, "CAN_COLLIDE"];

// Adding buildings to one variable just for tidiness
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6];

// Set some directions for our buildings
_directions = [-210,-390,90,30,90,30,-26];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

// Make buildings flat on terrain surface
{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 6.5,(_position select 1) - 12,0],5,"Easy",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 8,(_position select 1) + 14,0],5,"Easy","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 21,(_position select 1) - 12.5,0],_rndnum,"Easy","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 18, (_position select 1) - 13, 0],
	[(_position select 0) - 19.5, (_position select 1) + 12, 0]
],"M2StaticMG","Easy","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Weapon Cache", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate,	// mission number and crate
	["crate"], // ["crate"], or ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_BANDIT_WEAPONCACHE_ANNOUNCE", // mission announcement
	"STR_BANDIT_WEAPONCACHE_WIN", // mission success
	"STR_BANDIT_WEAPONCACHE_FAIL", // mission fail
	[10,4,0,3,2] // Dynamic crate array
] call mission_winorfail;