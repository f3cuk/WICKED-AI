private ["_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Tank Column]: Starting... %1",_position];

//Spawn Crates
[[
	[[12,5,30,3,2],crates_small,[.02,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["GUE_WarfareBAircraftFactory",[13.5,2]],
	["MAP_T34",[2.2,-12],91.28],
	["MAP_T34",[12.2,-12],92.01],
	["MAP_T34",[21,-13],108.4],
	["MAP_T34",[29,-16],112.3],
	["GUE_WarfareBVehicleServicePoint",[10,-19]],
	["MAP_Hlidac_budka",[10,-7]],
	["Land_tent_east",[-0.3,0.3],90],
	["MAP_t_picea2s",[-3,12]],
	["MAP_t_pinusN1s",[-12,3]],
	["MAP_t_pinusN2s",[-10,13,-0.02]],
	["MAP_t_acer2s",[9,2]],
	["Land_Fire_barrel_burning",[-9,-1]]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) - 7, (_position select 1) - 10, 0],5,"Hard",["Random","AT"],4,"Random","UN_CDF_Soldier_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 16, (_position select 1) - 5, 0],5,"Hard","Random",4,"Random","UN_CDF_Soldier_Guard_EP1","Random","Hero",_mission] call spawn_group;
[[(_position select 0) + 4, (_position select 1) + 18, 0],5,"Hard","Random",4,"Random","UN_CDF_Soldier_EP1","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 4, (_position select 1) + 18, 0],_rndnum,"Hard","Random",4,"Random","UN_CDF_Soldier_EP1","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 4, (_position select 1) + 18, 0],_rndnum,"Hard","Random",4,"Random","UN_CDF_Soldier_EP1","Random","Hero",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 22, (_position select 1) + 32, 0],[(_position select 0) + 15, (_position select 1) - 33, 0],50,2,"HMMWV_Armored","Hard","Hero","Hero",_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) + 8, (_position select 1) - 29, 0],
	[(_position select 0) + 12, (_position select 1) + 24, 0]
],"M2StaticMG","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Tank Column", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_TANK_ANNOUNCE",	// mission announcement
	"STR_CL_BANDIT_TANK_WIN", // mission success
	"STR_CL_BANDIT_TANK_FAIL" // mission fail
] call mission_winorfail;