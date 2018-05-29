private ["_vehicle","_rndnum","_crate_type","_crate","_mission","_vehname","_position","_vehclass"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Military Chopper
_vehclass = armed_chopper call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Hero] Disabled Military Chopper]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_medium call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Medium",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 30, (_position select 1) - 30, 0],
	[(_position select 0) + 30, (_position select 1) + 30, 0],
	[(_position select 0) - 30, (_position select 1) - 30, 0],
	[(_position select 0) - 30, (_position select 1) + 30, 0]
],"M2StaticMG","Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

uiSleep 3; // Wait for the ai list to populate so the key on ai option works.

//Spawn vehicle
_vehicle = [_crate,_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Hero] disabled_milchopper spawned a %1",_vehname];
};

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["Disabled %1", _vehname], // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate,	// crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[], // cleanup objects
	"A bandit helicopter is taking off with a crate of snipers! Save the cargo and take their chopper!", // mission announcement
	"Survivors have secured the armed chopper!", // mission success
	"Survivors did not secure the armed chopper in time", // mission fail
	[[10,ai_wep_sniper],[4,crate_tools_sniper],[4,crate_items_sniper],3,2] // Dynamic crate array
] call mission_winorfail;