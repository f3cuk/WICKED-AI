private ["_rndnum","_mission","_position","_aiType","_messages","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Tank Column]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_TankColumn select 0;} else {Loot_TankColumn select 1;};

//Spawn Crates
[[
	[_loot,crates_small,[.02,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
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
[[(_position select 0) - 7, (_position select 1) - 10, 0],5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 16, (_position select 1) - 5, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 4, (_position select 1) + 18, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 4, (_position select 1) + 18, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 4, (_position select 1) + 18, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 22, (_position select 1) + 32, 0],[(_position select 0) + 15, (_position select 1) - 33, 0],50,2,"HMMWV_Armored","Hard",_aiType,_aiType,_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) + 8, (_position select 1) - 29, 0],
	[(_position select 0) + 12, (_position select 1) + 24, 0]
],"M2StaticMG","Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_TANK_ANNOUNCE","STR_CL_HERO_TANK_WIN","STR_CL_HERO_TANK_FAIL"];
} else {
	["STR_CL_BANDIT_TANK_ANNOUNCE","STR_CL_BANDIT_TANK_WIN","STR_CL_BANDIT_TANK_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Tank Column", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
