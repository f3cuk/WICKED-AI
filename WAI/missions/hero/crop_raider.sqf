private ["_mission","_position","_rndnum","_loot"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: [Mission:[Hero] Hippy Commune]: Starting... %1",_position];

// Loot
_loot = [6,5,[15,crate_items_crop_raider],3,3];

//Spawn Crates
[[
	[_loot,crates_small,[2,0,.1]]
],_position,_mission] call wai_spawnCrate;


// Spawn Objects
[[
	["fiberplant",[-10.8,-16.3]],
	["fiberplant",[16.2,-17.6]],
	["fiberplant",[-17.3,21]],
	["fiberplant",[28.6,29]],
	["fiberplant",[-29.8,-31.1]],
	["fiberplant",[30.2,-33]],
	["fiberplant",[-32,28.7]],
	["fiberplant",[-32,-1.1]],
	["fiberplant",[1.3,-28]],
	["fiberplant",[27,2]],
	["fiberplant",[-0.3,26]],
	["fiberplant",[35.9,39]],
	["fiberplant",[-39,-40.3]],
	["fiberplant",[-36.9,-38.6]],
	["fiberplant",[38,-38.9]],
	["fiberplant",[-37,39.7]],
	["fiberplant",[-0.1,42.3]],
	["fiberplant",[42.1,-0.1]],
	["fiberplant",[0.1,-40.2]],
	["hruzdum",[-0.01,-0.01]],
	["fiberplant",[-10,-11]],
	["fiberplant",[13,12.2]],
	["fiberplant",[12.3,-10.6]],
	["fiberplant",[-11.3,12.7]],
	["fiberplant",[15,10]]
],_position,_mission] call wai_spawnObjects;

//Group Spawning
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,"Hard",["Random","AT"],4,"Random","Rocker3_DZ","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 15, 0],5,"Hard","Random",4,"Random","Rocker1_DZ","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 15, 0],5,"Hard","Random",4,"Random","Rocker1_DZ","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) - 13, (_position select 1) + 15, 0],_rndnum,"Hard","Random",4,"Random","Policeman","Random","Bandit",_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0), (_position select 1), 0],_rndnum,"Hard","Random",4,"Random","Policeman","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 55, _position select 1, 0],[(_position select 0) + 50, _position select 1, 0],50,2,"HMMWV_Armored","Hard","Bandit","Bandit",_mission] call vehicle_patrol;

//Static Guns
[[
	[(_position select 0) - 48, (_position select 1) + 0.1, 0],
	[(_position select 0) + 2, (_position select 1) + 48, 0]
],"M2StaticMG","Hard","Policeman","Bandit",0,2,"Random","Random",_mission] call spawn_static;

//Heli Paradrop
[_position,200,"UH1H_DZ","North",[3000,4000],150,1.0,200,10,"Hard","Random",4,"Random","Bandit","Random","Bandit",true,_mission] spawn heli_para;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Crop Raider", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_GENERAL_CROPRAIDER_ANNOUNCE", // mission announcement
	"STR_CL_GENERAL_CROPRAIDER_WIN", // mission success
	"STR_CL_GENERAL_CROPRAIDER_FAIL" // mission fail
] call mission_winorfail;