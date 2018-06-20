private ["_rndnum","_crate_type","_mission","_position","_crate","_baserunover"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [30] call find_position;	

diag_log format["WAI: [Mission:[Hero] Black Hawk Crash]: Starting... %1",_position];

//Setup the crate
_crate_type = crates_medium call BIS_fnc_selectRandom;
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];
_crate call wai_crate_setup;

//Base
_baserunover = createVehicle ["UH60_ARMY_Wreck_burned_DZ",[((_position select 0) + 5), ((_position select 1) + 5), 0],[],10,"FORM"];
_baserunover setVectorUp surfaceNormal position _baserunover;

//Troops
_rndnum = round (random 5);
[[_position select 0,_position select 1,0],5,"Medium",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],5,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

//Static Guns
[[[(_position select 0) + 20, (_position select 1) + 20, 0]],"M2StaticMG","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;
[[[(_position select 0) - 20, (_position select 1) - 20, 0]],"M2StaticMG","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Medium", // Difficulty
	"Black Hawk Crash", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate,	// crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"STR_HERO_BHCRASH_ANNOUNCE", // mission announcement
	"STR_HERO_BHCRASH_WIN", // mission success
	"STR_HERO_BHCRASH_FAIL", // mission fail
	[5,5,10,3,2] // Dynamic crate array
] call mission_winorfail;