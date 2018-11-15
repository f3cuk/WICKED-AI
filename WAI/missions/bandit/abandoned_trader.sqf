private ["_mission","_position","_rndnum"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;

diag_log format["WAI: [Mission:[Bandit] Abandoned Trader]: Starting... %1",_position];

//Spawn Crates
[[
	[[8,5,15,3,2],crates_medium,[.3,0]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_Misc_Garb_Heap_EP1",[-0.9,4.2,-0.01]],
	["Land_Misc_Garb_Heap_EP1",[-18,1.5,-0.01]],
	["Land_Shed_W03_EP1",[-4,4.7,-0.01]],
	["Land_Shed_M01_EP1",[-10,5,-0.01]],
	["Land_Market_shelter_EP1",[-10,-0.4,-0.01]],
	["Land_Market_stalls_02_EP1",[-10,-5.8,-0.01],-2.5],
	["Land_Market_stalls_01_EP1",[11,5,-0.01],-0.34],
	["Land_Market_stalls_02_EP1",[10,-5.8,-0.01]],
	["Land_Market_shelter_EP1",[10,-0.4,-0.01],2.32],
	["Land_transport_crates_EP1",[22,2,-0.01],-43.88],
	["Fort_Crate_wood",[18,-1,-0.01]],
	["UralWreck",[27,-3,-0.01],-67.9033],
	["Land_Canister_EP1",[18,1.4,-0.01],28.73],
	["MAP_ground_garbage_square5",[13.6,-2,-0.01]],
	["MAP_ground_garbage_square5",[-16,-2,-0.01]],
	["MAP_ground_garbage_long",[-0.4,-2,-0.01]],
	["MAP_garbage_misc",[-8,-2,-0.01]]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Medium",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[_position,5,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
_rndnum = ceil (random 4);
[_position,_rndnum,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

//Static Guns
[[
	[(_position select 0) + 0.1, (_position select 1) + 20, 0],
	[(_position select 0) + 0.1, (_position select 1) - 20, 0]
],"M2StaticMG","Easy","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Abandoned Trader", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	"STR_CL_BANDIT_ABANDONEDTRADER_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_ABANDONEDTRADER_WIN", // mission success
	"STR_CL_BANDIT_ABANDONEDTRADER_FAIL" // mission fail
] call mission_winorfail;