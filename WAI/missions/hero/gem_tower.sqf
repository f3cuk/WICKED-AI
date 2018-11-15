private ["_mission","_position","_loot","_rndnum"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: [Mission:[Hero] Gem Tower]: Starting... %1",_position];

// Loot
_loot = [8,5,[4,crate_items_gems],3,2];

//Spawn Crates
[[
	[_loot,crates_medium,[-20,11]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_Misc_Coltan_Heap_EP1",[-3.41,16.4,-2.5],-82.16],
	["Land_Ind_SiloVelke_01",[-0.01,-0.01,-0.25]],
	["Land_Ind_SiloVelke_01",[-21,-0.4,-0.25],182.209],
	["Land_Misc_Coltan_Heap_EP1",[-31,12,-2],8.27],
	["Land_A_Castle_Bastion",[-21,11,-0.2]],
	["Land_Misc_Coltan_Heap_EP1",[-26,34,-2]]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) + 29, (_position select 1) - 21, 0],5,"Hard",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 19, 0],5,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) - 23, (_position select 1) - 19, 0],5,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 12, (_position select 1) + 23, 0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 12, (_position select 1) + 23, 0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],50,2,"HMMWV_Armored","Hard","Bandit","Bandit",_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) - 1, (_position select 1) + 39, 0],
	[(_position select 0) + 33, (_position select 1) - 21, 0]
],"KORD_high_TK_EP1","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Gem Tower", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_GENERAL_GEMTOWER_ANNOUNCE", // mission announcement
	"STR_CL_GENERAL_GEMTOWER_WIN", // mission success
	"STR_CL_GENERAL_GEMTOWER_FAIL" // mission fail
] call mission_winorfail;