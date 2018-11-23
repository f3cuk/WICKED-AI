private ["_rndnum","_mission","_position","_aiType","_messages","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [30] call find_position;

diag_log format["WAI: [Mission:[%2] Drug Bust]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_DrugBust,crates_medium,[2.3,-3,.1]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_dum_zboreny",[-0.01,0.02,-0.1]],
	["Land_Misc_Garb_Heap_EP1",[5.6,3.4,-0.01]],
	["MAP_Kitchenstove_Elec",[2,5,-0.1]],
	["MAP_P_toilet_b_02",[-4.4,-3.3,-0.01],-90.84],
	["MAP_P_bath",[-4.9,-5,-0.01]],
	["MAP_armchair",[-1.7,-4.6,-0.01],179.92],
	["MAP_SmallTable",[2.6,1.4,-0.15]],
	["MAP_kitchen_chair_a",[2.5,2.2,-0.01]],
	["Land_Boots_EP1",[8.4,-1.5,-0.01],-170.27],
	["Land_Blankets_EP1",[-6.3,4.8,0.01],-170.27],
	["Land_Bench_EP1",[-3.2,-2.2,0.015]],
	["Land_Water_pipe_EP1",[-1.4,-3,0.01],105.15],
	["Land_Bag_EP1",[-5.9,1.9,0.01]],
	["LADAWreck",[-8,-4,-0.01],-119.578],
	["SKODAWreck",[11,-3,-0.01]],
	["MAP_tv_a",[-2.7,-0.1,0.01]],
	["MAP_Dkamna_uhli",[-0.01,5,-0.1]],
	["MAP_Skrin_opalena",[1.2,0.1,0.05]],
	["MAP_Dhangar_whiteskrin",[0.9,1.6,0.05],91.19],
	["MAP_garbage_paleta",[5.3,-2,-0.01]],
	["MAP_t_salix2s",[-0.01,15,-0.01],47.639],
	["MAP_t_salix2s",[-0.01,-17,-0.01]],
	["MAP_t_salix2s",[25,-0.01,-0.01]],
	["MAP_t_salix2s",[-24,-0.01,-0.01]]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) - 12, (_position select 1) - 15,0],5,"Medium",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[[(_position select 0) + 12, (_position select 1) + 15,0],5,"Medium","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[[(_position select 0), (_position select 1), 0],_rndnum,"Medium","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 4);
[[(_position select 0), (_position select 1), 0],_rndnum,"Medium","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_DRUGBUST_ANNOUNCE","STR_CL_HERO_DRUGBUST_WIN","STR_CL_HERO_DRUGBUST_FAIL"];
} else {
	["STR_CL_BANDIT_DRUGBUST_ANNOUNCE","STR_CL_BANDIT_DRUGBUST_WIN","STR_CL_BANDIT_DRUGBUST_FAIL"];
};

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Drug Bust", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;