private ["_rndnum","_mission","_position","_aiType","_missionType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] ARMY Base]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_ArmyBase select 0;} else {Loot_ArmyBase select 1;};

//Spawn Crates
[[
	[_loot,crates_small,[1.2,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["WarfareBCamp",[-1,-12.4,-0.12]],
	["Base_WarfareBBarrier10xTall",[15,-16,-0.64]],
	["Base_WarfareBBarrier10xTall",[-15,-16,-0.64]],
	["Base_WarfareBBarrier10xTall",[15,16,-0.64]],
	["Base_WarfareBBarrier10xTall",[-15,16,-0.64]],
	["MAP_posed",[17,11]],
	["MAP_posed",[-20,11]],
	["MAP_fort_artillery_nest",[-1,-31,-0.56],-178.615],
	["MAP_Fortress_02",[-27,-13]],
	["MAP_Fortress_02",[25,-13],-89.16],
	["MAP_fortified_nest_big",[26,13],-180.55],
	["MAP_fortified_nest_big",[-26,13],-179.808],
	["MAP_Barbedwire",[10,-20]],
	["MAP_Barbedwire",[-11,-20]],
	["MAP_Barbedwire",[16,-20]],
	["MAP_Barbedwire",[-17,-20]],
	["WarfareBDepot",[-0.02,20,-0.1],-179.832],
	["T72Wreck",[29,-30],82.75],
	["T72WreckTurret",[20,-36]],
	["MAP_T34",[2,5],-71.49],
	["Land_Fort_Watchtower_EP1",[26,-4],-180.097],
	["Land_Fort_Watchtower_EP1",[-28,-6],0.999],
	["Land_transport_crates_EP1",[-18,-9],52.43],
	["MAP_Barel4",[-16,-10]],
	["MAP_Barel1",[-16,-11]],
	["MAP_t_picea3f",[-8,-6]],
	["MAP_t_picea3f",[16,20]],
	["MAP_t_pinusS2f",[14,9]],
	["MAP_t_pinusS2f",[-3,-6],-99.19],
	["MAP_t_picea3f",[10,-13]],
	["MAP_t_pinusN2s",[14,-8]],
	["MAP_t_pinusN2s",[12,19],-73.36],
	["MAP_t_pinusN2s",[-21,-13],52.65],
	["MAP_t_pinusS2f",[-34,12]],
	["MAP_t_picea3f",[-13,21]],
	["MAP_t_picea2s",[-17,21]],
	["MAP_t_picea2s",[13,-12]],
	["MAP_t_picea1s",[30,-0.01]],
	["MAP_t_picea2s",[-47,-21]],
	["MAP_t_picea2s",[34,-48]],
	["MAP_t_pinusN2s",[31,-52]],
	["MAP_t_pinusS2f",[12,-5]],
	["Land_Fire_barrel_burning",[-0.01,-0.01]]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) - 12, (_position select 1) + 2, 0],5,"Hard",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 2, (_position select 1) + 2, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 14, (_position select 1) - 35, 0],5,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 13, (_position select 1) + 35, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[[(_position select 0) + 13, (_position select 1) + 35, 0],_rndnum,"Hard","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) - 22, (_position select 1) - 56, 0],[(_position select 0) + 22, (_position select 1) + 56, 0],50,2,"HMMWV_Armored","Hard",_aiType,_aiType,_mission] call vehicle_patrol;
 
//Static Guns
[[
	[(_position select 0) - 0.01, (_position select 1) + 41, 0],
	[(_position select 0) + 0.1, (_position select 1) - 25, 0]
],"M2StaticMG","Hard",_aiType,_aiType,0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Army Base", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_GENERAL_ARMYBASE_ANNOUNCE","STR_CL_GENERAL_ARMYBASE_WIN","STR_CL_GENERAL_ARMYBASE_FAIL"]
] call mission_winorfail;