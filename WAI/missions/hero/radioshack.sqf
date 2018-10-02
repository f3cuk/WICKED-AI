private ["_baserunover","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11","_baserunover12","_baserunover13","_baserunover14","_mission","_directions","_position","_crate","_crate_type","_rndnum"];

_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: Mission:[Hero] Radio Tower started at %1",_position];

//Setup the crate
_crate_type = crates_large call BIS_fnc_selectrandom; // Choose between crates_large, crates_medium and crates_small
_crate = createVehicle [_crate_type,[(_position select 0) + 0.01,(_position select 1) + 0.01,0],[],0,"CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings 
_baserunover0 = createVehicle ["Land_cihlovej_dum_in",[(_position select 0) - 3, (_position select 1) - 1,-0.015],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["Land_Com_tower_ep1",[(_position select 0) + 5, (_position select 1) - 2,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["LADAWreck",[(_position select 0) - 7.5, (_position select 1) - 3,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["FoldTable", [(_position select 0) - 1.2, (_position select 1) - 4,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["FoldChair", [(_position select 0) - 1, (_position select 1) - 3,-0.09],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["SmallTV", [(_position select 0) - 1.7, (_position select 1) - 4,+0.82],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["SatPhone",[(_position select 0) - 0.8, (_position select 1) - 4,+0.82],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["MAP_t_picea2s",[(_position select 0) - 4.5, (_position select 1) + 7,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["MAP_t_picea2s",[(_position select 0) + 13, (_position select 1) + 10,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["MAP_t_pinusN2s", [(_position select 0) + 3, (_position select 1) + 9,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["MAP_t_pinusN1s", [(_position select 0) + 8, (_position select 1) + 17,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["MAP_t_picea1s", [(_position select 0) + 7, (_position select 1) + 10,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["MAP_t_picea2s",[(_position select 0) + 34, (_position select 1) - 29,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["MAP_t_fraxinus2s",[(_position select 0) - 14, (_position select 1) + 1,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover14 = createVehicle ["MAP_t_carpinus2s",[(_position select 0) + 28, (_position select 1) - 13,-0.02],[], 0, "CAN_COLLIDE"];

// Adding buildings to one variable just for tidiness
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14];

// Set some directions for our buildings
_directions = [0,0,0,0,0,0,-201.34,0,0,0,0,0,0,0,0];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

// Make buildings flat on terrain surface
{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

// Troops
_rndnum = round (random 5);
[[(_position select 0) - 1.2, (_position select 1)  - 20, 0],5,"extreme",["random","at"],4,"random","bandit","random","bandit",_mission] call spawn_group;
[[(_position select 0) - 4, (_position select 1) + 16, 0],5,"hard","random",4,"random","bandit","random","bandit",_mission] call spawn_group;
[[(_position select 0) - 17, (_position select 1) - 4, 0],5,"random","random",4,"random","bandit","random","bandit",_mission] call spawn_group;
[[(_position select 0) + 14, (_position select 1) - 3, 0],_rndnum,"random","random",4,"random","bandit","random","bandit",_mission] call spawn_group;


// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"hard", // Difficulty
	"Radio Tower", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate,	// crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_CL_HERO_RADIO_ANNOUNCE", // mission announcement
	"STR_CL_HERO_RADIO_WIN", // mission success
	"STR_CL_HERO_RADIO_FAIL", // mission fail
	[10,5,30,3,2] // Dynamic crate array
] call mission_winorfail;