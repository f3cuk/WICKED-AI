if(isServer) then {

	private 		["_baserunover","_mission","_directions","_position","_crate","_crate_type","_num"];

	_mission 		= count wai_mission_data -1;
	// Get a safe position 80 meters from the nearest object
	_position		= [80] call find_position;
	
	// Initialise the mission variable with the following options, [position, difficulty, mission name, mission type (MainHero/Mainbandit), minefield (true or false)] call mission_init;
	[_mission,_position,"hard","Cannibal Cave","MainBandit",true] call mission_init;

	diag_log 		format["WAI: Mission:[Bandit] Cannibal started at %1",_position];

	//Setup the crate
	_crate_type 	= crates_large call BIS_fnc_selectrandom; // Choose between crates_large, crates_medium and crates_small
	_crate 			= createVehicle [_crate_type,[(_position select 0) + 5,(_position select 1) + 7,0],[],0,"CAN_COLLIDE"];
	[_crate] call wai_crate_setup;

	// Create some Buildings
//Buildings 
_baserunover0 = createVehicle ["MAP_R2_RockWall",[(_position select 0) + 10, (_position select 1) + 28,-4.15],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["MAP_R2_RockWall",[(_position select 0) - 23, (_position select 1) + 9,-6.55],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["MAP_R2_RockWall",[(_position select 0) + 25, (_position select 1) + 4,-7.74],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["MAP_R2_RockWall", [(_position select 0) + 1, (_position select 1) + 7,10.81],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["MAP_R2_RockWall", [(_position select 0) + 18, (_position select 1) - 11,-5.509],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["MAP_R2_RockWall", [(_position select 0) - 22, (_position select 1) + 6,-11.55],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["MAP_t_picea2s",[(_position select 0) - 13, (_position select 1) - 32,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["MAP_t_picea2s",[(_position select 0) - 17, (_position select 1) + 6,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["MAP_t_pinusN2s",[(_position select 0) - 24, (_position select 1) - 53,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["MAP_t_pinusN1s", [(_position select 0) - 22, (_position select 1) - 42,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["MAP_t_picea1s", [(_position select 0) - 22.3, (_position select 1) - 35,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["MAP_t_picea2s", [(_position select 0) - 33, (_position select 1) - 53,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["MAP_t_picea2s",[(_position select 0) - 3, (_position select 1)- 43,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["MAP_t_picea2s",[(_position select 0) + 28, (_position select 1) - 39,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover14 = createVehicle ["MAP_t_picea2s",[(_position select 0) + 13, (_position select 1) +43,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover15 = createVehicle ["MAP_t_picea1s", [(_position select 0) + 57, (_position select 1) + 11,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover16 = createVehicle ["MAP_t_quercus3s", [(_position select 0) + 31, (_position select 1) + 49.3,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover17 = createVehicle ["MAP_t_quercus3s", [(_position select 0) - 47, (_position select 1) + 20,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover18 = createVehicle ["MAP_R2_Rock1", [(_position select 0) + - 47, (_position select 1) - 45,-14.29],[], 0, "CAN_COLLIDE"];
_baserunover19 = createVehicle ["Land_Campfire_burning",[(_position select 0) - 0.01, (_position select 1) - 0.01,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover20 = createVehicle ["Mass_grave",[(_position select 0) - 6, (_position select 1) - 7,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover21 = createVehicle ["SKODAWreck",[(_position select 0) - 11, (_position select 1) - 44,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover22 = createVehicle ["datsun01Wreck", [(_position select 0) - 2, (_position select 1) - 60,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover23 = createVehicle ["UralWreck", [(_position select 0) - 41.3, (_position select 1) - 26,-0.02],[], 0, "CAN_COLLIDE"];


	// Adding buildings to one variable just for tidiness
	_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14,_baserunover15,_baserunover16,_baserunover17,_baserunover18,_baserunover19,_baserunover20,_baserunover21,_baserunover22,_baserunover23];
	
	// Set some directions for our buildings
	_directions = [0,-96.315,262.32,-29.29,-222.72,-44.01,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-50.94,151.15,34.54,19.15];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

	// Make buildings flat on terrain surface
	{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

	_num = round (random 3) + 4;
	[[(_position select 0) + 12, (_position select 1) + 42.5, 0],_num,"extreme",["random","at"],4,"random","TK_INS_Soldier_AT_EP1","random",["Hero",150],_mission] call spawn_group;
	[[(_position select 0) + 11, (_position select 1) + 41, 0],4,"hard","random",4,"random","TK_Special_Forces_EP1","random","Hero",_mission] call spawn_group;
	[[(_position select 0) - 12, (_position select 1) - 43, 0],4,"random","random",4,"random","TK_Special_Forces_EP1","random","Hero",_mission] call spawn_group;
	[[(_position select 0) - 13, (_position select 1) - 43, 0],4,"random","random",4,"random","TK_INS_Soldier_AT_EP1","random","Hero",_mission] call spawn_group;


	//Condition
	_complete = [
		[_mission,_crate],	// mission variable (from line 9) and crate
		["crate"], 			// Mission objective type (["crate"], or ["kill"], or ["assassinate", _assassinate])
		[_baserunover], 	// buildings to cleanup after mission is complete, does not include the crate
		"Cannibals are hiding in a cave...Check your map",	// mission announcement
		"Survivors secured the Cannibal's Cave",			// mission success
		"The Cannibal mission timed out and nobody was in the vicinity"	// mission fail
	] call mission_winorfail;


	 
	if(_complete) then {
		[_crate,10,8,[2,crate_items_high_value],3,[2,crate_backpacks_large]] call dynamic_crate;
	};	
	
	// End of mission
	diag_log format["WAI: Mission:[Bandit] Cannibal ended at %1 ended",_position];
	b_missionsrunning = b_missionsrunning - 1;
};