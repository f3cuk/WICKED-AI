private ["_rndnum","_mission","_position"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Junk Yard]: Starting... %1",_position];

//Spawn Crates
[[
	[[14,5,1,3,2],crates_small,[.2,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Mi8Wreck",[31,-12.4,-0.12]],
	["UralWreck",[-7,-9,-0.04],-49.99],
	["UralWreck",[23,4,-0.04],201.46],
	["UralWreck",[-7,23,-0.04],80.879],
	["HMMWVWreck",[-8,7,-0.04],44.77],
	["BMP2Wreck",[-4,24,-0.02],-89],
	["T72Wreck",[11,-13,-0.02],27],
	["UralWreck",[14,10,-0.02],162],
	["T72Wreck",[4,16,-0.02]],
	["UH60_ARMY_Wreck_DZ",[7,1.3,-0.02],-41],
	["Land_Dirthump01",[9,1,-1.59],25],
	["Land_Dirthump01",[8,0.2,-1.59],53],
	["Mi8Wreck",[5,-34,-0.02],94],
	["BRDMWreck",[-1,-20,-0.12],-1.7],
	["T72Wreck",[-9,-21,-0.02],-75],
	["Mi8Wreck",[-21,-5,-0.02],-24],
	["Land_Misc_Rubble_EP1",[-10.02,7,-0.1]],
	["Land_Shed_W03_EP1",[-7,-1.4,-0.02],-99],
	["Land_Misc_Garb_Heap_EP1",[-6,1,-0.02]],
	["Land_Misc_Garb_Heap_EP1",[18,10,-0.02]],
	["Land_Misc_Garb_Heap_EP1",[-10,-12,-0.02]],
	["MAP_garbage_misc",[5,-21,-0.02]],
	["MAP_garbage_misc",[7,18,-0.02],-178],
	["MAP_garbage_paleta",[-12,14,-0.02],-91],
	["MAP_Kitchenstove_Elec",[-11,1.5,-0.02],146],
	["MAP_tv_a",[-12,-0.01,-0.02],108],
	["MAP_washing_machine",[-11,-1,-0.02],100],
	["MAP_P_toilet_b_02",[-16,0.01,-0.02],36],
	["Land_Misc_Garb_Heap_EP1",[-17,-3,-0.02],93],
	["MAP_garbage_paleta",[-11,-0.01,-0.02],21],
	["Land_Fire_barrel_burning",[-13,-3,-0.02]],
	["Land_Fire_barrel_burning",[2,-9,-0.02]]
],_position,_mission] call wai_spawnObjects;

//Troops
[[(_position select 0) - 2, (_position select 1) - 5, 0],5,"Medium",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[(_position select 0) - 19, (_position select 1) + 19, 0],5,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[[(_position select 0) + 17, (_position select 1) + 21, 0],_rndnum,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[[(_position select 0) + 17, (_position select 1) + 21, 0],_rndnum,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Junk Yard", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_JUNKYARD_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_JUNKYARD_WIN", // mission success
	"STR_CL_BANDIT_JUNKYARD_FAIL" // mission fail
] call mission_winorfail;