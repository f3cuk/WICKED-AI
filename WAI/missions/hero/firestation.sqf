private ["_rndnum","_mission","_position","_loot1","_loot2"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [50] call find_position;

diag_log format["WAI: [Mission:[Hero] Fire Station]: Starting... %1",_position];

_loot1 = [0,0,[4,crate_items_high_value],0,1];
_loot2 = [[10,ai_wep_sniper],3,20,3,1];

[[
	[_loot1,crates_large,[-3.6,-4.4],-30],
	[_loot2,crates_large,[2,-1.1],-30]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MAP_a_stationhouse",[0,0],-210],
	["Land_fort_bagfence_round",[3.5,-20],68],
	["Land_fort_bagfence_round",[-1,-23.3],219]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Extreme",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,5,"Extreme","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,5,"Extreme","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,5,"Extreme","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Extreme","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Extreme","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Spawn vehicles
_vehclass = armed_vehicle call BIS_fnc_selectRandom;
[_vehclass,[(_position select 0) -9.5, (_position select 1) -6.8],_mission,true,-29] call custom_publish;

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Random","Bandit","Bandit",_mission] call vehicle_patrol;

//Heli Paradrop
[_position,400,"UH60M_EP1_DZE","East",[3000,4000],150,1.0,200,10,"Random","Random",4,"Random","Bandit","Random","Bandit",false,_mission] spawn heli_para;

//Static guns
[[
	[(_position select 0) + 4.9, (_position select 1) + 6.5, 17.94],
	[(_position select 0) - 12.8, (_position select 1) - 4.2, 4.97],
	[(_position select 0) + 0.9, (_position select 1) - 20.9, 0],
	[(_position select 0) + 23.5, (_position select 1) + 1.1, 8.94]
],"M2StaticMG","Extreme","Bandit","Bandit",1,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Extreme", // Difficulty
	"Fire Station", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_FIRESTATION_ANNOUNCE", // mission announcement
	"STR_CL_HERO_FIRESTATION_WIN", // mission success
	"STR_CL_HERO_FIRESTATION_FAIL" // mission fail
] call mission_winorfail;