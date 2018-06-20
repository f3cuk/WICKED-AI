private ["_mission","_position","_crate","_rndnum","_crate_type","_baserunover","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11","_baserunover12","_baserunover13","_baserunover14","_baserunover15","_baserunover16"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: [Mission:[Bandit] Drone Pilot]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_large call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0) + 2,(_position select 1),0],[],0,"CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings
_baserunover0 = createVehicle ["TK_WarfareBUAVterminal_EP1",[(_position select 0) - 6, (_position select 1) - 15,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["Land_budova4_in",[(_position select 0) - 13, (_position select 1) + 3.5,-0.12],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["Land_Vysilac_FM",[(_position select 0) - 10, (_position select 1) - 7,-0.12],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["MAP_runway_poj_draha",[(_position select 0) + 10, (_position select 1) + 5,0],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["MQ9PredatorB",[(_position select 0) + 11, (_position select 1) - 28,0],[], 0, "CAN_COLLIDE"];
_baserunover4 setVehicleLock "LOCKED";
_baserunover4 setVariable ["mission",_mission];
_baserunover5 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) + 36,0],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) + 30,0],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) + 24,0],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) + 18,0],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) + 12,0],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) + 6,0],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) + 0.1,0],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) - 6,0],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) - 12,0],[], 0, "CAN_COLLIDE"];
_baserunover14 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) - 18,0],[], 0, "CAN_COLLIDE"];
_baserunover15 = createVehicle ["ClutterCutter_EP1",[(_position select 0) + 10, (_position select 1) - 24,0],[], 0, "CAN_COLLIDE"];
_baserunover16 = createVehicle ["ClutterCutter_EP1",[(_position select 0) - 4, (_position select 1) - 5,0],[], 0, "CAN_COLLIDE"];

_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14,_baserunover15,_baserunover16];

_directions = [-153.81,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

//Group Spawning
_rndnum = round (random 5);
[[(_position select 0) + 17, (_position select 1) - 18, 0],5,"Hard",["Random","AT"],4,"Random","US_Soldier_GL_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 11, (_position select 1) + 9, 0],5,"Hard","Random",4,"Random","US_Soldier_Officer_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 15, (_position select 1) - 15, 0],5,"Hard","Random",4,"Random","US_Soldier_Officer_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 2, (_position select 1) + 18, 0],_rndnum,"Hard","Random",4,"Random","US_Soldier_Medic_EP1","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 55, _position select 1, 0],[(_position select 0) + 17, _position select 1, 0],50,2,"HMMWV_Armored","Hard","Hero","Hero",_mission] call vehicle_patrol;

//Static Guns
[[[(_position select 0) - 7, (_position select 1) + 19, 0]],"KORD_high_TK_EP1","Hard","US_Soldier_Medic_EP1","Hero",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Drone Pilot", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // mission number and crate
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_BANDIT_DRONEPILOT_ANNOUNCE", // mission announcement
	"STR_BANDIT_DRONEPILOT_WIN", // mission success
	"STR_BANDIT_DRONEPILOT_FAIL", // mission fail
	[14,[8,crate_tools_sniper],[2,crate_items_high_value],3,[2,crate_backpacks_large]] // Dynamic crate array
] call mission_winorfail;