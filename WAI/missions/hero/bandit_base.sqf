private ["_mission","_position","_rndnum","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: [Mission:[Hero] Bandit Base]: Starting... %1",_position];

// Loot
_loot = [[16,ai_wep_sniper],[8,crate_tools_sniper],[3,crate_items_high_value],3,[4,crate_backpacks_large]];

// Spawn crates
[[
	[_loot,crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["land_fortified_nest_big",[-40,0],90],
	["land_fortified_nest_big",[40,0],270],
	["land_fortified_nest_big",[0,-40]],
	["land_fortified_nest_big",[0,40],180],
	["Land_Fort_Watchtower",[-10,0]],
	["Land_Fort_Watchtower",[10,0],180],
	["Land_Fort_Watchtower",[0,-10],270],
	["Land_Fort_Watchtower",[0,10],90]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Hard",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Hard","Bandit","Bandit",_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) - 10, (_position select 1) + 10, 0],
	[(_position select 0) + 10, (_position select 1) - 10, 0],
	[(_position select 0) + 10, (_position select 1) + 10, 0],
	[(_position select 0) - 10, (_position select 1) - 10, 0]
],"M2StaticMG","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

//Heli Paradrop
[_position,400,"UH1H_DZ","North",[3000,4000],150,1.0,200,10,"Random","Random",4,"Random","Bandit","Random","Bandit",true,_mission] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Base", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_HERO_BANDITBASE_ANNOUNCE", // mission announcement
	"STR_CL_HERO_BANDITBASE_WIN", // mission success
	"STR_CL_HERO_BANDITBASE_FAIL" // mission fail
] call mission_winorfail;