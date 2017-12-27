if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11","_baserunover12","_baserunover13"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Hard","Tank Column","MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Hero] Tank Column]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) + 0.02,(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_crate] call wai_crate_setup;

	//Tank Column & Base
//Buildings 

_baserunover1 = createVehicle ["GUE_WarfareBAircraftFactory",[(_position select 0) + 13.5, (_position select 1) + 2,-0.17],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["MAP_T34",[(_position select 0) + 2.2, (_position select 1) - 12,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["MAP_T34", [(_position select 0) + 12.2, (_position select 1) - 12,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["MAP_T34", [(_position select 0) + 21, (_position select 1) - 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["MAP_T34", [(_position select 0) + 29, (_position select 1) - 16,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["GUE_WarfareBVehicleServicePoint",[(_position select 0) + 10, (_position select 1) - 19,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["MAP_Hlidac_budka",[(_position select 0) + 10, (_position select 1) - 7,-0.01],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["Land_tent_east",[(_position select 0) - 0.3, (_position select 1) + 0.3,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["MAP_t_picea2s", [(_position select 0) - 3, (_position select 1) + 12,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["MAP_t_pinusN1s", [(_position select 0) - 12, (_position select 1) + 3,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["MAP_t_pinusN2s", [(_position select 0) - 10, (_position select 1) + 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["MAP_t_acer2s",[(_position select 0) + 9, (_position select 1) + 2,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["Land_Fire_barrel_burning",[(_position select 0) - 9, (_position select 1) - 1,-0.02],[], 0, "CAN_COLLIDE"];

	_baserunover 	= [_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13];
	
	_directions = [0,91.28,92.01,108.4,112.3,0,0,90.007,0,0,0,0,0];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
	
	{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

	//Troops
	[[(_position select 0) - 7, (_position select 1) - 10, 0],4,"Hard",["Random","AT"],4,"Random","TK_Special_Forces_TL_EP1","Random","Bandit",_mission] call spawn_group;
	[[(_position select 0) + 16, (_position select 1) - 5, 0],4,"Hard","Random",4,"Random","TK_INS_Soldier_AT_EP1","Random","Bandit",_mission] call spawn_group;
	[[(_position select 0) + 4, (_position select 1) + 18, 0],4,"Hard","Random",4,"Random","TK_INS_Soldier_MG_EP1","Random","Bandit",_mission] call spawn_group;

	//Humvee Patrol
	[[(_position select 0) + 22, (_position select 1) + 32, 0],[(_position select 0) + 15, (_position select 1) - 33, 0],50,2,"HMMWV_Armored","Hard","Bandit","Bandit",_mission] call vehicle_patrol;
	 
	//Static Guns
	[[[(_position select 0) + 8, (_position select 1) - 29, 0]],"M2StaticMG","Hard","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;
	[[[(_position select 0) + 12, (_position select 1) + 24, 0]],"M2StaticMG","Hard","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	//Condition
	_complete = [
		[_mission,_crate],				// mission number and crate
		["crate"],						// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 				// cleanup objects
		"A bandit tank column stopped to resupply at an outpost",	// mission announcement
		"Survivors have secured the tank column and outpost",								// mission success
		"Survivors were unable to clear the tank column and outpost....mission failed"							// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,12,5,30,3,2] call dynamic_crate;
			};



	diag_log format["WAI: [Mission:[Hero] Tank Column]: Ended at %1",_position];

	h_missionsrunning = h_missionsrunning - 1;
};