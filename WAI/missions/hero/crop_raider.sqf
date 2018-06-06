private  ["_mission","_position","_crate","_rndnum","_crate_type","_baserunover","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11","_baserunover12","_baserunover13","_baserunover14","_baserunover15","_baserunover16","_baserunover17","_baserunover18","_baserunover19","_baserunover20","_baserunover21","_baserunover22","_baserunover23","_baserunover24"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

_position = [80] call find_position;

diag_log format["WAI: [Mission:[Hero] Hippy Commune]: Starting... %1",_position];

//Setup the crate
_crate_type  = crates_small call BIS_fnc_selectRandom;
_crate  = createVehicle [_crate_type,[(_position select 0) + 2,(_position select 1),0],[],0,"CAN_COLLIDE"];
_crate call wai_crate_setup;

//Buildings
_baserunover0 = createVehicle ["fiberplant",[(_position select 0) - 10.8, (_position select 1) - 16.3,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["fiberplant",[(_position select 0) + 16.2, (_position select 1) - 17.6,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["fiberplant",[(_position select 0) - 17.3, (_position select 1) + 21,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["fiberplant", [(_position select 0) + 28.6, (_position select 1) + 29,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["fiberplant", [(_position select 0) - 29.8, (_position select 1) - 31.1,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["fiberplant", [(_position select 0) + 30.2, (_position select 1) - 33,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["fiberplant",[(_position select 0) - 32, (_position select 1) + 28.7,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["fiberplant",[(_position select 0) - 32, (_position select 1) - 1.1,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["fiberplant",[(_position select 0) + 1.3, (_position select 1) - 28,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["fiberplant", [(_position select 0) + 27, (_position select 1) + 2,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["fiberplant", [(_position select 0) - 0.3, (_position select 1) + 26,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["fiberplant", [(_position select 0) + 35.9, (_position select 1) + 39,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["fiberplant",[(_position select 0) - 39, (_position select 1)- 40.3,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["fiberplant",[(_position select 0) - 36.9, (_position select 1) - 38.6,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover14 = createVehicle ["fiberplant",[(_position select 0) + 38, (_position select 1) - 38.9,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover15 = createVehicle ["fiberplant", [(_position select 0) - 37, (_position select 1) + 39.7,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover16 = createVehicle ["fiberplant", [(_position select 0) - 0.1, (_position select 1) + 42.3,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover17 = createVehicle ["fiberplant", [(_position select 0) + 42.1, (_position select 1) - 0.1,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover18 = createVehicle ["fiberplant", [(_position select 0) + 0.1, (_position select 1) - 40.2,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover19 = createVehicle ["hruzdum",[(_position select 0) - 0.01, (_position select 1)- 0.01,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover20 = createVehicle ["fiberplant",[(_position select 0) - 10, (_position select 1) - 11,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover21 = createVehicle ["fiberplant",[(_position select 0) + 13, (_position select 1) + 12.2,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover22 = createVehicle ["fiberplant", [(_position select 0) + 12.3, (_position select 1) - 10.6,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover23 = createVehicle ["fiberplant", [(_position select 0) - 11.3, (_position select 1) + 12.7,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover24 = createVehicle ["fiberplant", [(_position select 0) + 15, (_position select 1) + 10,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14,_baserunover15,_baserunover16,_baserunover17,_baserunover18,_baserunover19,_baserunover20,_baserunover21,_baserunover22,_baserunover23,_baserunover24];

_directions = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
	
{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

//Group Spawning
_rndnum = round (random 5);
[[(_position select 0) + 9, (_position select 1) - 13, 0],5,"Hard",["Random","AT"],4,"Random","Rocker3_DZ","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) + 13, (_position select 1) + 15, 0],5,"Hard","Random",4,"Random","Rocker1_DZ","Random","Bandit",_mission] call spawn_group;
[[(_position select 0) - 13, (_position select 1) + 15, 0],5,"Hard","Random",4,"Random","Policeman","Random","Bandit",_mission] call spawn_group;
[[(_position select 0), (_position select 1), 0],_rndnum,"Hard","Random",4,"Random","Policeman","Random","Bandit",_mission] call spawn_group;

//Humvee Patrol
[[(_position select 0) + 55, _position select 1, 0],[(_position select 0) + 50, _position select 1, 0],50,2,"HMMWV_Armored","Hard","Bandit","Bandit",_mission] call vehicle_patrol;

//Static Guns
[[[(_position select 0) - 48, (_position select 1) + 0.1, 0]],"M2StaticMG","Hard","Policeman","Bandit",0,2,"Random","Random",_mission] call spawn_static;
[[[(_position select 0) + 2, (_position select 1) +48, 0]],"M2StaticMG","Hard","Policeman","Bandit",0,2,"Random","Random",_mission] call spawn_static;

//Heli Paradrop
[[(_position select 0), (_position select 1), 0],200,"UH1H_DZ","North",[3000,4000],150,1.0,200,10,"Hard","Random",4,"Random","Bandit","Random","Bandit",true,_mission] spawn heli_para;

// Array of mission variables to send
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Crop Raider", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission
	_crate, // crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	[_baserunover], // cleanup objects
	"Crooked cops are about to raid the weed crops of a hippy commune...check your map", // mission announcement
	"Survivors saved the hippy commune", // mission success
	"Survivors did not stop the bandits in time.", // mission fail
	[6,5,[15,crate_items_crop_raider],3,3] // Dynamic crate array
] call mission_winorfail;