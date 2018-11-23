private ["_rndnum","_president_himself","_mission","_position","_president","_firstlady","_aiType","_missionType"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [50] call find_position;

diag_log format["WAI: [Mission:[%2] Presidents in Town]: Starting... %1",_position,_missionType];

//Spawn Crates
[[
	[Loot_Presidents,crates_large,[0,0,.25]]
],_position,_mission] call wai_spawnCrate;

// Spawn Objects
[[
	["Land_A_Office01",[0,0]]
],_position,_mission] call wai_spawnObjects;

//Troops
[_position,5,"Extreme",["Random","AT"],4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Extreme","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Extreme","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
[_position,5,"Extreme","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Extreme","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;
_rndnum = ceil (random 5);
[_position,_rndnum,"Extreme","Random",4,"Random",_aiType,"Random",_aiType,_mission] call spawn_group;

//The President Himself
_president = [[((_position select 0) + 5), _position select 1, 4.1],1,"Extreme","Random",4,"none","Special","Random",[_aiType,500],_mission] call spawn_group;
_firstlady = [[((_position select 0) + 5), _position select 1, 4.1],1,"Extreme","Unarmed",4,"none","Secretary1","Random",[_aiType,0],_mission] call spawn_group;

_president_himself = (units _president) select 0;
_president_himself disableAI "MOVE";

//Let him move once player is near
_president_himself spawn {
	private ["_president","_player_near"];
	_president = _this;
	_player_near = false;
	while {!_player_near} do {
		_player_near = [(position _president),50] call isNearPlayer;
		uiSleep 1;
	};
	_president enableAI "MOVE";
};

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Random",_aiType,_aiType,_mission] call vehicle_patrol;

//Heli Paradrop
[_position,400,"UH60M_EP1_DZE","East",[3000,4000],150,1.0,200,10,"Random","Random",4,"Random",_aiType,"Random",_aiType,false,_mission] spawn heli_para;

//Static guns
[[
	[(_position select 0) - 13.135, (_position select 1) + 5.025, 5.27],
	[(_position select 0) + 14.225, (_position select 1) + 5.025, 5.27],
	[(_position select 0) + 1.97, (_position select 1) - 2.368, 10.54]
],"M2StaticMG","Extreme",_aiType,_aiType,1,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Extreme", // Difficulty
	"President's in Town", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["assassinate",_president], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_PRESIDENT_ANNOUNCE","STR_CL_PRESIDENT_WIN","STR_CL_PRESIDENT_FAIL"]
] call mission_winorfail;