private ["_baserunover","_mission","_directions","_position","_crate","_rndnum","_crate_type","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: [Mission:[Hero] Gem Tower]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_small call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0) -20,(_position select 1) + 11,0],[],0,"CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings
_baserunover0 = createVehicle ["Land_Misc_Coltan_Heap_EP1",[(_position select 0) - 3.41, (_position select 1) + 16.4,-1],[], 0, "CAN_COLLIDE"];;
_baserunover1 = createVehicle ["Land_Ind_SiloVelke_01",[(_position select 0) - 0.01, (_position select 1) - 0.01,-0.25],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["Land_Ind_SiloVelke_01",[(_position select 0) - 21, (_position select 1) - 0.4,-0.25],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["Land_Misc_Coltan_Heap_EP1",[(_position select 0) - 31, (_position select 1) + 12,-2],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Land_A_Castle_Bastion",[(_position select 0) - 21, (_position select 1) + 11,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["Land_Misc_Coltan_Heap_EP1",[(_position select 0) - 26, (_position select 1) + 34,-2],[], 0, "CAN_COLLIDE"];
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5];

_directions = [-82.16,0,182.209,8.27,0,0];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

//Troops
_rndnum = round (random 5);
[[(_position select 0) + 29, (_position select 1) - 21, 0],5,"Hard",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 19, 0],5,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) - 23, (_position select 1) - 19, 0],5,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) - 12, (_position select 1) + 23, 0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],50,2,"HMMWV_Armored","Hard","Bandit","Bandit",_mission] call vehicle_patrol;
 
//Static Guns
[[[(_position select 0) - 1, (_position select 1) + 39, 0]],"KORD_high_TK_EP1","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;
[[[(_position select 0) + 33, (_position select 1) - 21, 0]],"KORD_high_TK_EP1","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Gem Tower", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate,	// crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_HERO_GEMTOWER_ANNOUNCE", // mission announcement
	"STR_HERO_GEMTOWER_WIN", // mission success
	"STR_HERO_GEMTOWER_FAIL", // mission fail
	[8,5,[4,crate_items_gems],3,2] // Dynamic crate array
] call mission_winorfail;