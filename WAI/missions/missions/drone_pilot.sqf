private ["_mission","_position","_rndnum","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [80] call find_position;

diag_log format["WAI: [Mission:[%2] Drone Pilot]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_DronePilot,crates_large,[2,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["MQ9PredatorB",[11,-28]],
	["TK_WarfareBUAVterminal_EP1",[-6,-15],-153.81],
	["Land_budova4_in",[-13,3.5]],
	["Land_Vysilac_FM",[-10,-7]],
	["MAP_runway_poj_draha",[10,5]],
	["ClutterCutter_EP1",[10,36]],
	["ClutterCutter_EP1",[10,30]],
	["ClutterCutter_EP1",[10,24]],
	["ClutterCutter_EP1",[10,18]],
	["ClutterCutter_EP1",[10,12]],
	["ClutterCutter_EP1",[10,6]],
	["ClutterCutter_EP1",[10,0.1]],
	["ClutterCutter_EP1",[10,-6]],
	["ClutterCutter_EP1",[10,-12]],
	["ClutterCutter_EP1",[10,-18]],
	["ClutterCutter_EP1",[10,-24]],
	["ClutterCutter_EP1",[-4,-5]]
],_position,_mission] call wai_spawnObjects;

// Troops
[[(_position select 0) + 17, (_position select 1) - 18, 0],5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) - 11, (_position select 1) + 9, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 15, (_position select 1) - 15, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 2, (_position select 1) + 18, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 2, (_position select 1) + 18, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 55, _position select 1, 0],[(_position select 0) + 17, _position select 1, 0],50,2,"HMMWV_Armored","Hard",_aiType,_aiType,_mission] call vehicle_patrol;

//Static Guns
[[[(_position select 0) - 7, (_position select 1) + 19, 0]],"KORD_high_TK_EP1","Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_DRONE_ANNOUNCE","STR_CL_HERO_DRONE_WIN","STR_CL_HERO_DRONE_FAIL"];
} else {
	["STR_CL_BANDIT_DRONEPILOT_ANNOUNCE","STR_CL_BANDIT_DRONEPILOT_WIN","STR_CL_BANDIT_DRONEPILOT_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Drone Pilot", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;
