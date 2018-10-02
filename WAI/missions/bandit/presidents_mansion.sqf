private ["_rndnum","_president_himself","_crate_type","_mission","_position","_crate","_baserunover","_president","_firstlady"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [50] call find_position;

diag_log format["WAI: [Mission:[Bandit] Presidents in Town]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_large call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1),.1], [], 0, "CAN_COLLIDE"];
_crate call wai_crate_setup;

//Hotel
_baserunover = createVehicle ["Land_A_Office01",[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];
_baserunover setVectorUp surfaceNormal position _baserunover;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Extreme",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

//The President Himself
_president = [[((_position select 0) + 5), _position select 1, 4.1],1,"Extreme","Random",4,"none","Special","Random",["Hero",750],_mission] call spawn_group;
_firstlady = [[((_position select 0) + 5), _position select 1, 4.1],1,"Extreme","Unarmed",4,"none","Secretary1","Random",["Hero",0],_mission] call spawn_group;

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
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Random","Hero","Hero",_mission] call vehicle_patrol;

//Heli Paradrop
[[(_position select 0),(_position select 1),0],400,"UH60M_EP1_DZE","East",[3000,4000],150,1.0,200,10,"Random","Random",4,"Random","Hero","Random","Hero",false,_mission] spawn heli_para;

//Static guns
[[
	[(_position select 0) - 13.135, (_position select 1) + 5.025, 5.27],
	[(_position select 0) + 14.225, (_position select 1) + 5.025, 5.27],
	[(_position select 0) + 1.97, (_position select 1) - 2.368, 10.54]
],"M2StaticMG","Extreme","Hero","Hero",1,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Extreme", // Difficulty
	"President's in Town", // Name of Mission
	"MainBandit", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["assassinate",_president], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_CL_BANDIT_PRESIDENT_ANNOUNCE", // mission announcement
	"STR_CL_BANDIT_PRESIDENT_WIN", // mission success
	"STR_CL_BANDIT_PRESIDENT_FAIL", // mission fail
	[0,0,[40,crate_items_president],0,1] // Dynamic crate array
] call mission_winorfail;