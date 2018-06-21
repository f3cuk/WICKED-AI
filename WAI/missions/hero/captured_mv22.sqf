private ["_directions","_complete","_mission","_vehname","_vehicle","_position","_vehclass","_crate","_baserunover","_rndnum","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Hero] Captured MV22]: Starting... %1",_position];

//Setup the crate
_crate = createVehicle ["USBasicWeaponsBox",[(_position select 0) + 11.2,(_position select 1) + 12.2,0.1], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings
_baserunover0 = createVehicle ["USMC_WarfareBFieldhHospital",[(_position select 0) + 12.7, (_position select 1) + 6.5,0],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["Barrack2",[(_position select 0) + 16, (_position select 1) - 11,0],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["Misc_cargo_cont_small",[(_position select 0) + 2.8, (_position select 1) + 17.4,0],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["Barrack2", [(_position select 0) + 9, (_position select 1) - 15,0],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Misc_cargo_cont_small", [(_position select 0) + 6.7, (_position select 1) + 18.3,0],[], 0, "CAN_COLLIDE"];

// Adding buildings to one variable just for tidiness
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4];

// Set some directions for our buildings
_directions = [-210,150,12.5,150,12.5];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

// Make buildings flat on terrain surface
{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Hard",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) - 33,(_position select 1) - 18,0],5,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 1,(_position select 1) + 29,0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 33,(_position select 1) - 7,0],5,"Hard","Random",4,"Random","RU_Doctor","Random",["Bandit",100],_mission] call spawn_group;
 
//Static Guns
[[
	[(_position select 0) - 9.3, (_position select 1) + 11.2, 0],
	[(_position select 0) - 6, (_position select 1) - 21.4, 0]
],"M2StaticMG","Hard","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

uiSleep 3; // Wait for the ai list to populate so the key on ai option works.

//MV22
_vehclass = "MV22_DZ";
_vehicle = [_crate,_vehclass,[(_position select 0) - 20.5,(_position select 1) - 5.2,0], _mission,true,-82.5] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Hero] captured_mv22 spawned a MV22 at %1", _position];
};

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Captured MV22", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate,	// crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_CL_HERO_MV22_ANNOUNCE", // mission announcement
	"STR_CL_HERO_MV22_WIN", // mission success
	"STR_CL_HERO_MV22_FAIL", // mission fail
	[0,0,[80,crate_items_medical],3,1] // Dynamic crate array
] call mission_winorfail;