private ["_baserunover","_mission","_directions","_position","_crate","_crate_type","_rndnum","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8"];

_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: Mission:[Bandit] Lumber Mill started at %1",_position];

//Setup the crate
_crate_type = crates_large call BIS_fnc_selectrandom; // Choose between crates_large, crates_medium and crates_small
_crate = createVehicle [_crate_type,[(_position select 0) + 5,(_position select 1) + 7,0],[],0,"CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings 
_baserunover0 = createVehicle ["Land_Ind_SawMill",[(_position select 0) - 2.4, (_position select 1) + 24,-0.15],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["Land_Ind_Timbers",[(_position select 0) + 11, (_position select 1) + 8.6,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["Land_Ind_Timbers",[(_position select 0) + 16, (_position select 1) + 12,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["Land_Ind_Timbers", [(_position select 0) + 6, (_position select 1) - 15,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Misc_palletsfoiled", [(_position select 0) + 5, (_position select 1) - 9,-0.009],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["Misc_palletsfoiled_heap", [(_position select 0) + 9, (_position select 1) - 8,-0.05],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["Land_water_tank",[(_position select 0) - 10, (_position select 1) - 7,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["UralWreck",[(_position select 0) - 17, (_position select 1) + 5,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["MAP_t_quercus3s",[(_position select 0) + 22, (_position select 1) + 25,-0.2],[], 0, "CAN_COLLIDE"];

// Adding buildings to one variable just for tidiness
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8];

// Set some directions for our buildings
_directions = [0,0,-10.45,104.95,0,0,0,59.2,0];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

// Make buildings flat on terrain surface
{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

_rndnum = round (random 5);
[[(_position select 0) + 12, (_position select 1) + 22.5, 0],5,"extreme",["random","at"],4,"random","Hero","random",["Hero",150],_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 11, 0],5,"hard","random",4,"random","Hero","random","Hero",_mission] call spawn_group;
[[(_position select 0) - 1.12, (_position select 1) - 0.43, 0],5,"random","random",4,"random","Hero","random","Hero",_mission] call spawn_group;
[[(_position select 0) - 13, (_position select 1) - 23, 0],_rndnum,"random","random",4,"random","Hero","random","Hero",_mission] call spawn_group;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Lumber Mill", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate,	// crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_BANDIT_LUMBERMILL_ANNOUNCE",	// mission announcement
	"STR_BANDIT_LUMBERMILL_WIN",	// mission success
	"STR_BANDIT_LUMBERMILL_FAIL", // mission fail
	[6,[8,crate_tools_sniper],[15,crate_items_wood],3,[4,crate_backpacks_large]] // Dynamic crate array
] call mission_winorfail;