private ["_rndnum","_mission","_position","_aiType","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Slaughter House]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_SlaughterHouse select 0;} else {Loot_SlaughterHouse select 1;};

//Spawn Crates
[[
	[_loot,crates_medium,[2.5,0,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_aif_tovarna1",[-0.01,-0.01,-0.02]],
	["Land_stand_meat_EP1",[-4,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[-2,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[0.001,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[-1,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[2,2,-0.02],0.3693],
	["Land_stand_meat_EP1",[4,2,-0.02],0.3693],
	["Mass_grave",[-3,20,-0.02]],
	["Mass_grave",[4,18,-0.02]],
	["Mass_grave",[0,-15,-0.02]],
	["Axe_woodblock",[-4,-14,-0.02],-25],
	["Land_Table_EP1",[2,-2,-0.02]],
	["MAP_icebox",[-2,-0.01,-0.02]]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,"Easy",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) + 13, (_position select 1) + 15, 0],_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 3);
[[(_position select 0) + 13, (_position select 1) + 15, 0],_rndnum,"Easy","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

[
	_mission, // Mission number
	_position, // Position of mission
	"Easy", // Difficulty
	"Slaughter House", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_GENERAL_SLAUGHTERHOUSE_ANNOUNCE","STR_CL_GENERAL_SLAUGHTERHOUSE_WIN","STR_CL_GENERAL_SLAUGHTERHOUSE_FAIL"]
] call mission_winorfail;