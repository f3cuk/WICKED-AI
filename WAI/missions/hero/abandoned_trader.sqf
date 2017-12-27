if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_baserunover"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Medium","Abandoned Trader","MainHero",true] call mission_init;	
	
	diag_log 		format["WAI: [Mission:[Hero] Abandoned Trader]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_medium call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) + 0.3,(_position select 1),0],[],0,"CAN_COLLIDE"];
	[_crate] call wai_crate_setup;

	// Create some Buildings
//Buildings 
_baserunover0 = createVehicle ["Land_Misc_Garb_Heap_EP1",[(_position select 0) - 0.9, (_position select 1) + 4.2,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["Land_Misc_Garb_Heap_EP1",[(_position select 0) - 18, (_position select 1) + 1.5,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["Land_Shed_W03_EP1",[(_position select 0) - 4, (_position select 1) + 4.7,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["Land_Shed_M01_EP1", [(_position select 0) - 10, (_position select 1) + 5,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Land_Market_shelter_EP1", [(_position select 0) - 10, (_position select 1) - 0.4,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["Land_Market_stalls_02_EP1", [(_position select 0) - 10, (_position select 1) - 5.8,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["Land_Market_stalls_01_EP1",[(_position select 0) + 11, (_position select 1) + 5,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["Land_Market_stalls_02_EP1",[(_position select 0) + 10, (_position select 1) - 5.8,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["Land_Market_shelter_EP1",[(_position select 0) + 10, (_position select 1) - 0.4,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["Land_transport_crates_EP1", [(_position select 0) + 22, (_position select 1) + 2,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["Fort_Crate_wood", [(_position select 0) + 18, (_position select 1) - 1,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["UralWreck", [(_position select 0) + 27, (_position select 1) - 3,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["Land_Canister_EP1",[(_position select 0) + 18, (_position select 1) + 1.4,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["MAP_ground_garbage_square5",[(_position select 0) + 13.6, (_position select 1) - 2,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover14 = createVehicle ["MAP_ground_garbage_square5",[(_position select 0) - 16, (_position select 1) - 2,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover15 = createVehicle ["MAP_ground_garbage_long", [(_position select 0) - 0.4, (_position select 1) - 2,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover16 = createVehicle ["MAP_garbage_misc", [(_position select 0) - 8, (_position select 1) - 2,-0.01],[], 0, "CAN_COLLIDE"];


	// Adding buildings to one variable just for tidiness
	_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14,_baserunover15,_baserunover16];
	
	// Set some directions for our buildings
	_directions = [0,0,0,0,0,-2.5,-0.34,0,2.32,-43.88,0,-67.9033,28.73,0,0,0,0];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

	// Make buildings flat on terrain surface
	{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

	//Troops
	[[_position select 0,_position select 1,0],3,"Medium",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],3,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],3,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//Static Guns
	[[
		[(_position select 0) + 0.1, (_position select 1) + 20, 0],
		[(_position select 0) + 0.1, (_position select 1) - 20, 0]
	],"M2StaticMG","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"A trader city was abandoned after a bandit raid....Go secure the loot",	// mission announcement
		"Survivors have secured the abandoned trader",																	// mission success
		"Survivors did not secure the abandoned trader in time"															// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Mission:[Hero] Abandoned Trader]: Ended at %1",_position];

	if(_complete) then {
		[_crate,8,5,15,3,2] call dynamic_crate;
	};

	h_missionsrunning = h_missionsrunning - 1;
};