private ["_directions","_vehclass","_vehicle","_rndnum","_crate_type","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Hero] Farmer]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_medium call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1),0.4], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings
_baserunover1 = createVehicle ["MAP_HouseV2_01A",[(_position select 0) -37, (_position select 1) +15,0],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["MAP_Farm_WTower",[(_position select 0) -17, (_position select 1) +32,0],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["MAP_sara_stodola3",[(_position select 0) +12, (_position select 1) +36.5,0],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["MAP_Misc_Cargo1C",[(_position select 0) +17, (_position select 1) +4,0],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["MAP_Misc_Cargo1C",[(_position select 0) +15, (_position select 1) +12,0],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["MAP_t_picea2s",[(_position select 0) -17.5, (_position select 1) +9,0],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["MAP_t_picea2s",[(_position select 0) -1, (_position select 1) -13,0],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["MAP_t_picea2s",[(_position select 0) -8.5, (_position select 1) +51.5,0],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["MAP_t_picea2s",[(_position select 0) +18.5, (_position select 1) -9.4,0],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["Haystack",[(_position select 0) +7, (_position select 1) +24.5,0],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["MAP_stodola_old_open",[(_position select 0), (_position select 1) -2,0.4],[], 0, "CAN_COLLIDE"];

_baserunover = [_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11];

// Set directions for the buildings
_directions = [-107,0,20.6,5.9,-41.2,0,0,0,0,15.3,-80.8];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

//Troops
_rndnum = round (random 5);
[[(_position select 0) -17,(_position select 1) +29,0],5,"Easy",["Random","AT"],4,"Random","RU_Villager2","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) -12,(_position select 1) +20,0],_rndnum,"Random","Random",4,"Random","Citizen2_EP1","Random","Bandit",_mission] call spawn_group;

uiSleep 3; // Wait for the ai list to populate so the key on ai option works.

//Spawn vehicles
_vehclass = "Tractor";
_vehicle = [_crate,_vehclass,[(_position select 0) -6.5, (_position select 1) +12.7],_mission,true,46.7] call custom_publish;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Farmer", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_CL_HERO_FARMER_ANNOUNCE", // mission announcement
	"STR_CL_HERO_FARMER_WIN", // mission success
	"STR_CL_HERO_FARMER_FAIL", // mission fail
	[6,5,[40,crate_items_medical],3,1,[_vehicle]] // Dynamic crate array
] call mission_winorfail;
