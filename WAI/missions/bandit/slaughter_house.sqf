private ["_rndnum","_crate_type","_mission","_position","_crate","_baserunover","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11","_baserunover12","_baserunover13"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Slaughter House]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_medium call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0) + 2.5,(_position select 1),0], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings 
_baserunover0 = createVehicle ["Land_aif_tovarna1",[(_position select 0) - 0.01, (_position select 1) - 0.01,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["Land_stand_meat_EP1",[(_position select 0) - 4, (_position select 1) + 2,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["Land_stand_meat_EP1",[(_position select 0) - 2, (_position select 1) + 2,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["Land_stand_meat_EP1", [(_position select 0) + 0.001, (_position select 1) + 2,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Land_stand_meat_EP1", [(_position select 0) - 1, (_position select 1) + 2,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["Land_stand_meat_EP1", [(_position select 0) + 2, (_position select 1) + 2,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["Land_stand_meat_EP1",[(_position select 0) + 4, (_position select 1) + 2,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["Mass_grave",[(_position select 0) - 3, (_position select 1) + 12,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["Mass_grave",[(_position select 0) + 4, (_position select 1) + 12,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["Mass_grave", [(_position select 0) + 0.01, (_position select 1) - 9,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["Mass_grave", [(_position select 0) - 0.3, (_position select 1) + 26,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["Axe_woodblock", [(_position select 0) - 4, (_position select 1) - 14,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["Land_Table_EP1",[(_position select 0) + 2, (_position select 1) - 2,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["MAP_icebox",[(_position select 0) - 2, (_position select 1) - 0.01,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13];

_directions = [0,0.3693,0.3693,0.3693,0.3693,0.3693,0.3693,0,188,33,0,-25,0,0];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,"Easy",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 15, 0],_rndnum,"Easy","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Slaughter House", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_BANDIT_SLAUGHTERHOUSE_ANNOUNCE", // mission announcement
	"STR_BANDIT_SLAUGHTERHOUSE_WIN", // mission success
	"STR_BANDIT_SLAUGHTERHOUSE_FAIL", // mission fail
	[8,5,[6,crate_items_chainbullets],3,[2,crate_backpacks_large]] // Dynamic crate array
] call mission_winorfail;