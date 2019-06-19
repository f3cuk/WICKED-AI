private ["_rndnum","_room","_mayor_himself","_mission","_position","_mansion","_mayor","_aiType","_loot"];

_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission: "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type
_position = [40] call find_position;

diag_log format["WAI: [Mission:[%2] Mayors Mansion]: Starting... %1",_position,_missionType];

_loot = if (_missionType == "MainHero") then {Loot_Mayors select 0;} else {Loot_Mayors select 1;};

//Spawn Crates
[[
	[_loot,crates_large,[0,0,.25]]
],_position,_mission] call wai_spawnCrate;
 
// Spawn Objects
_mansion = [[
	["Land_A_Villa_EP1",[0,0]]
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

//The Mayor Himself
_mayor = [_position,1,"Extreme","Random",4,"Random","Special","Random",[_aiType,300],_mission] call spawn_group;
_mayor_himself = (units _mayor) select 0;

//Put the Mayor in his room
_room = (6 + ceil(random(3)));
_mayor_himself disableAI "MOVE";
_mayor_himself setPos (_mansion buildingPos _room);

//Let him move once player is near
_mayor_himself spawn {
	private ["_mayor","_player_near"];
	_mayor = _this;
	_player_near = false;
	while {!_player_near} do {
		_player_near = [(position _mayor),30] call isNearPlayer;
		uiSleep 1;
	};
	_mayor enableAI "MOVE";
};

//Humvee Patrol
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Random",_aiType,_aiType,_mission] call vehicle_patrol;

//Heli Paradrop
[_position,400,"UH60M_EP1_DZE","North",[3000,4000],150,1.0,100,10,"Random","Random",4,"Random",_aiType,"Random",_aiType,false,_mission] spawn heli_para;

//Static mounted guns
[[
	[(_position select 0) - 15, (_position select 1) + 15, 8],
	[(_position select 0) + 15, (_position select 1) - 15, 8]
],"M2StaticMG","Extreme",_aiType,_aiType,1,2,"Random","Random",_mission] call spawn_static;

[
	_mission, // Mission number
	_position, // Position of mission
	"Extreme", // Difficulty
	"Mayors Mansion", // Name of Mission
	_missionType, // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["assassinate",_mayor], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	["STR_CL_MAYOR_ANNOUNCE","STR_CL_MAYOR_WIN","STR_CL_MAYOR_FAIL"]
] call mission_winorfail;
