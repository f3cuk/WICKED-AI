private ["_complete","_crate","_mission","_static_gun","_crate_type","_rndnum","_playerPresent","_vehname","_vehicle","_position","_vehclass"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

//Armed Land Vehicle
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
_vehname = getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Hero] Armed Vehicle]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_small call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Medium",["Random","AT"],3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",3,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
_static_gun = ai_static_weapons call BIS_fnc_selectRandom;
[[[(_position select 0),(_position select 1) + 10, 0]],_static_gun,"Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

uiSleep 3; // Wait for the ai list to populate so the key on ai option works.

//Spawn Vehicle
_vehicle = [_crate,_vehclass,_position,_mission] call custom_publish;

if(wai_debug_mode) then {
	diag_log format["WAI: [Hero] armed_vehicle spawned a %1",_vehname];
};

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	format["Disabled %1",_vehname], // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate,	// crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[], // cleanup objects
	"STR_CL_HERO_ARMEDVEHICLE_ANNOUNCE",	// mission announcement
	"STR_CL_HERO_ARMEDVEHICLE_WIN", // mission success
	"STR_CL_HERO_ARMEDVEHICLE_FAIL", // mission fail
	[0,0,[25,crate_items_chainbullets],3,2] // Dynamic crate array
] call mission_winorfail;