private ["_mission","_position","_aiType","_rndnum","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [80] call find_position;

diag_log format["WAI: [Mission:[%2] Gem Tower]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_GemTower select 0;} else {Loot_GemTower select 1;};

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
[[(_position select 0) + 29, (_position select 1) - 21, 0],5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 21, (_position select 1) + 19, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 23, (_position select 1) - 19, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 12, (_position select 1) + 23, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 12, (_position select 1) + 23, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],50,2,"HMMWV_Armored","Hard",_aiType,_aiType,_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) - 1, (_position select 1) + 39, 0],
	[(_position select 0) + 33, (_position select 1) - 21, 0]
],"KORD_high_TK_EP1","Easy",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Gem Tower", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_GENERAL_GEMTOWER_ANNOUNCE","STR_CL_GENERAL_GEMTOWER_WIN","STR_CL_GENERAL_GEMTOWER_FAIL"]
] call mission_winorfail;