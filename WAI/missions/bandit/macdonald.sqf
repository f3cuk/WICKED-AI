private ["_rndnum","_crate_type","_mission","_position","_crate","_baserunover","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11","_baserunover12","_baserunover13","_baserunover14"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] The Farm]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_small call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0) + 0.02,(_position select 1),0.1], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings 
_baserunover0 = createVehicle ["MAP_sara_stodola",[(_position select 0) + 4, (_position select 1) - 5,-0.12],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["MAP_HouseV_2T2",[(_position select 0) + 18, (_position select 1) - 11,-0.14],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["MAP_t_quercus3s",[(_position select 0) + 32.4, (_position select 1) - 32,-0.14],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["MAP_t_quercus2f", [(_position select 0) + 14, (_position select 1) - 3,-0.14],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["MAP_t_pinusN2s", [(_position select 0) - 12, (_position select 1) + 5,-0.14],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["datsun01Wreck", [(_position select 0) - 10, (_position select 1) - 1,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["Haystack",[(_position select 0) - 1, (_position select 1) - 32,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["Haystack_small",[(_position select 0) - 25, (_position select 1) - 36,-0.16],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["Haystack_small",[(_position select 0) + 33, (_position select 1) - 43,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["Haystack_small", [(_position select 0) + 10, (_position select 1) - 49,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["Haystack_small", [(_position select 0) + 13, (_position select 1) + 60,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["Haystack_small", [(_position select 0) - 33, (_position select 1) - 51,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["Haystack_small",[(_position select 0) + 20, (_position select 1) - 67,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["Land_Shed_wooden",[(_position select 0) + 10, (_position select 1) - 24,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover14 = createVehicle ["fiberplant",[(_position select 0) + 12, (_position select 1) - 23,-0.02],[], 0, "CAN_COLLIDE"];

_baserunover 	= [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14];

_directions = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

//Troops
_rndnum = round (random 5);
[[(_position select 0) - 1, (_position select 1) - 10, 0],5,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 2, (_position select 1) - 50, 0],5,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 1, (_position select 1) + 11, 0],5,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 1, (_position select 1) + 11, 0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) - 27, (_position select 1) - 18, 0],[(_position select 0) + 32, (_position select 1) + 1, 0],50,2,"Offroad_DSHKM_Gue_DZ","Hard","Hero","Hero",_mission] call vehicle_patrol;
 
//Static Guns
[[[(_position select 0) - 12, (_position select 1) - 18, 0]],"M2StaticMG","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"The Farm", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_CL_BANDIT_THEFARM_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_THEFARM_WIN", // mission success
	"STR_CL_BANDIT_THEFARM_FAIL", // mission fail
	[9,5,[15,crate_items_crop_raider],3,2] // Dynamic crate array
] call mission_winorfail;