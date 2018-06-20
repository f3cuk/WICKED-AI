private ["_directions","_rndnum","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Hero] Medical Supply Camp]: Starting... %1",_position];

//Setup the crate
_crate = createVehicle ["USVehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Medical Supply Camp
_baserunover1 = createVehicle ["MAP_fort_watchtower",[(_position select 0) + 1.5, (_position select 1) + 12.6,0],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["MAP_MASH",[(_position select 0) - 17, (_position select 1) + 5.3,0],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["MAP_Stan_east",[(_position select 0) - 16.5, (_position select 1) + 15.9,0],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["USMC_WarfareBFieldhHospital",[(_position select 0) + 3, (_position select 1) - 4.4,0],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["MAP_Stan_east",[(_position select 0) - 10, (_position select 1) + 19.6,0],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["MAP_MASH",[(_position select 0) - 14, (_position select 1) - 0.4,0],[], 0, "CAN_COLLIDE"];
_baserunover = [_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6];

// Set some directions for our buildings
_directions = [-210,60,-30,60,-30,60];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 20,(_position select 1) + 20,0],5,"Easy",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 20,(_position select 1) + 20,0],_rndnum,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Medical Supply Camp", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_HERO_MSC_ANNOUNCE", // mission announcement
	"STR_HERO_MSC_WIN", // mission success
	"STR_HERO_MSC_FAIL", // mission fail
	[0,0,[70,crate_items_medical],3,1] // Dynamic crate array
] call mission_winorfail;