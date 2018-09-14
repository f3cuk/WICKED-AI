private ["_rndnum","_crate_type","_mission","_position","_vehclass3","_vehclass2","_vehicle3","_vehicle2","_vehicle","_vehclass","_crate"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [40] call find_position;

diag_log format["WAI: [Mission:[Bandit] Lunch break Convoy]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_large call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];
_crate call wai_crate_setup;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 25, (_position select 1) + 25, 0],
	[(_position select 0) - 25, (_position select 1) - 25, 0],
	[(_position select 0) + 25, (_position select 1) - 25, 0]
],"M2StaticMG","Hard","Hero","Hero",1,2,"Random","Random",_mission] call spawn_static;

//Heli Para Drop
[[(_position select 0),(_position select 1),0],400,"BAF_Merlin_HC3_D","North",[3000,4000],150,1.0,200,10,"Random","Random",4,"Random","Hero","Random","Hero",false,_mission] spawn heli_para;

uiSleep 3; // Wait for the ai list to populate so the key on ai option works.

_vehclass = cargo_trucks call BIS_fnc_selectRandom;	// Cargo Truck
_vehclass2 = refuel_trucks call BIS_fnc_selectRandom; // Refuel Truck
_vehclass3 = military_unarmed call BIS_fnc_selectRandom; // Military Unarmed

_vehicle = [_crate,_vehclass,_position,_mission] call custom_publish;
_vehicle2 = [_crate,_vehclass2,_position,_mission] call custom_publish;
_vehicle3 = [_crate,_vehclass3,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass];
	diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass3];
	diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass2];
};

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Lunch break Convoy", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[],	// cleanup objects
	"STR_CL_BANDIT_IKEA_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_IKEA_WIN", // mission success
	"STR_CL_BANDIT_IKEA_FAIL", // mission fail
	[[1,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],3,4] // Dynamic crate array
] call mission_winorfail;
