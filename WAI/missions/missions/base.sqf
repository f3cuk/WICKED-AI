private ["_mission","_position","_rndnum","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [80] call find_position;

diag_log format["WAI: [Mission:[%2] Base]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_Base,crates_large,[0,0]]
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
[_position,5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Hard",_aiType,_aiType,_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) - 10, (_position select 1) + 10, 0],
	[(_position select 0) + 10, (_position select 1) - 10, 0],
	[(_position select 0) + 10, (_position select 1) + 10, 0],
	[(_position select 0) - 10, (_position select 1) - 10, 0]
],"M2StaticMG","Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

//Heli Paradrop
[_position,400,"UH1H_DZ","East",[3000,4000],150,1.0,200,10,"Hard","Random",4,"Random",_aiType,"Random",_aiType,true,_mission] spawn heli_para;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_BANDITBASE_ANNOUNCE","STR_CL_HERO_BANDITBASE_WIN","STR_CL_HERO_BANDITBASE_FAIL"];

} else {
	["STR_CL_BANDIT_HEROBASE_ANNOUNCE","STR_CL_BANDIT_HEROBASE_WIN","STR_CL_BANDIT_HEROBASE_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Base", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
