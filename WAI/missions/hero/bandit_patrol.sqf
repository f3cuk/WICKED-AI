private ["_crate","_mission","_position","_rndnum","_crate_type","_vehclass","_vehicle"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Hero] Bandit Patrol]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_medium call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Easy",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

uiSleep 3; // Wait for the ai list to populate so the key on ai option works.

// Select Vehicle
_vehclass  = civil_vehicles call BIS_fnc_selectRandom;

//Spawn vehicle
_vehicle = [_crate,_vehclass,_position,_mission] call custom_publish;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Bandit Patrol", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["kill"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[], // cleanup objects
	"STR_CL_HERO_BANDITPATROL_ANNOUNCE", // mission announcement
	"STR_CL_HERO_BANDITPATROL_WIN", // mission success
	"STR_CL_HERO_BANDITPATROL_FAIL", // mission fail
	[4,8,36,3,2] // Dynamic crate array
] call mission_winorfail;