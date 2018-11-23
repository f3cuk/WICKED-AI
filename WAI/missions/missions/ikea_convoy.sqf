private ["_rndnum","_mission","_position","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [40] call find_position;

diag_log format["WAI: [Mission:[%2] Lunch break Convoy]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_IkeaConvoy,crates_large,[0,0]]
],_position,_mission] call wai_spawnCrate;

//Troops
[_position,5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) - 30, (_position select 1) + 4, 0],
	[(_position select 0) + 10, (_position select 1) - 30, 0],
	[(_position select 0) + 8, (_position select 1) + 30, 0]
],"M2StaticMG","Hard",_aiType,_aiType,1,2,"Random","Random",_mission] call spawn_static;

//Heli Para Drop
[_position,400,"BAF_Merlin_HC3_D","North",[3000,4000],150,1.0,200,10,"Random","Random",4,"Random",_aiType,"Random",_aiType,false,_mission] spawn heli_para;

[cargo_trucks,[(_position select 0) + 19,(_position select 1) + 11],_mission,true,90] call custom_publish;
[refuel_trucks,[(_position select 0) - 14,(_position select 1) - 14],_mission,true,-90] call custom_publish;
[military_unarmed,[(_position select 0) - 20,(_position select 1) - 6],_mission,true,-90] call custom_publish;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_IKEA_ANNOUNCE","STR_CL_HERO_IKEA_WIN","STR_CL_HERO_IKEA_FAIL"];
} else {
	["STR_CL_BANDIT_IKEA_ANNOUNCE","STR_CL_BANDIT_IKEA_WIN","STR_CL_BANDIT_IKEA_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"IKEA Convoy", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
