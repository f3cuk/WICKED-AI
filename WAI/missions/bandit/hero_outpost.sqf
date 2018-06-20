private ["_directions","_rndnum","_crate_type","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Hero Outpost]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_large call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

// Buildings
_baserunover1 = createVehicle ["MAP_76n6_ClamShell",[(_position select 0) -6, (_position select 1) +25,0],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["MAP_budova4_in",[(_position select 0) -29, (_position select 1) +18,0],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["MAP_budova4_in",[(_position select 0) -29, (_position select 1) +8,0],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["MAP_Mil_Barracks_L",[(_position select 0) -23, (_position select 1) -13,0],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["MAP_CamoNetB_NATO",[(_position select 0) +1.6, (_position select 1),0],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["MAP_fort_watchtower",[(_position select 0) +19, (_position select 1) +11,0],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["MAP_fort_watchtower",[(_position select 0) +4, (_position select 1) -20,0],[], 0, "CAN_COLLIDE"];

_baserunover = [_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7];

// Set directions for the buildings
_directions = [172,0.24,0.24,-119,-203,-185,-103];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 2,_position select 1,0],5,"Easy",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 2,_position select 1,0],_rndnum,"Easy","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Hero Outpost", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_BANDIT_HEROOUTPOST_ANNOUNCE", // mission announcement
	"STR_BANDIT_HEROOUTPOST_WIN", // mission success
	"STR_BANDIT_HEROOUTPOST_FAIL", // mission fail
	[10,4,40,2,1] // Dynamic crate array
] call mission_winorfail;