if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Hard","ARMY Base","MainBandit",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Bandit] ARMY Base]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) + 1.2,(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_crate] call wai_crate_setup;

	//Medical Supply Camp
//Buildings 
_baserunover0 = createVehicle ["WarfareBCamp",[(_position select 0) - 1, (_position select 1) - 12.4,-0.12],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) + 15, (_position select 1) - 16,-0.64],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["Base_WarfareBBarrier10xTall",[(_position select 0) - 15, (_position select 1) - 16,-0.64],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["Base_WarfareBBarrier10xTall", [(_position select 0) + 15, (_position select 1) + 16,-0.64],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Base_WarfareBBarrier10xTall", [(_position select 0) - 15, (_position select 1) + 16,-0.64],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["MAP_posed", [(_position select 0) + 17, (_position select 1) + 11,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["MAP_posed",[(_position select 0) - 20, (_position select 1) + 11,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["MAP_fort_artillery_nest",[(_position select 0) - 1, (_position select 1) - 31,-0.56],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["MAP_Fortress_02",[(_position select 0) - 27, (_position select 1) - 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["MAP_Fortress_02", [(_position select 0) + 25, (_position select 1) - 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["MAP_fortified_nest_big", [(_position select 0) + 26, (_position select 1) + 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["MAP_fortified_nest_big", [(_position select 0) - 26, (_position select 1) + 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["MAP_Barbedwire",[(_position select 0) + 10, (_position select 1) - 20,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["MAP_Barbedwire",[(_position select 0) - 11, (_position select 1) - 20,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover14 = createVehicle ["MAP_Barbedwire",[(_position select 0) + 16, (_position select 1) - 20,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover15 = createVehicle ["MAP_Barbedwire",[(_position select 0) - 17, (_position select 1) - 20,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover16 = createVehicle ["WarfareBDepot",[(_position select 0) - 0.02, (_position select 1) + 20,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover17 = createVehicle ["T72Wreck", [(_position select 0) + 29, (_position select 1) - 30,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover18 = createVehicle ["T72WreckTurret", [(_position select 0) + 20, (_position select 1) - 36,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover19 = createVehicle ["MAP_T34", [(_position select 0) + 2, (_position select 1) + 5,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover20 = createVehicle ["Land_Fort_Watchtower_EP1",[(_position select 0) + 26, (_position select 1) - 4,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover21 = createVehicle ["Land_Fort_Watchtower_EP1",[(_position select 0) - 28, (_position select 1) - 6,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover22 = createVehicle ["Land_transport_crates_EP1",[(_position select 0) - 18, (_position select 1) - 9,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover23 = createVehicle ["MAP_Barel4", [(_position select 0) - 16, (_position select 1) - 10,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover24 = createVehicle ["MAP_Barel1", [(_position select 0) - 16, (_position select 1) - 11,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover25 = createVehicle ["MAP_t_picea3f", [(_position select 0) - 8, (_position select 1) - 6,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover26 = createVehicle ["MAP_t_picea3f",[(_position select 0) + 16, (_position select 1) + 20,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover27 = createVehicle ["MAP_t_pinusS2f",[(_position select 0) + 14, (_position select 1) + 9,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover28 = createVehicle ["MAP_t_pinusS2f",[(_position select 0) - 3, (_position select 1) - 6,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover29 = createVehicle ["MAP_t_picea3f",[(_position select 0) + 10, (_position select 1) - 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover30 = createVehicle ["MAP_t_pinusN2s",[(_position select 0) + 14, (_position select 1) - 8,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover31 = createVehicle ["MAP_t_pinusN2s", [(_position select 0) + 12, (_position select 1) + 19,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover32 = createVehicle ["MAP_t_pinusN2s", [(_position select 0) - 21, (_position select 1) - 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover33 = createVehicle ["MAP_t_pinusS2f", [(_position select 0) - 34, (_position select 1) + 12,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover34 = createVehicle ["MAP_t_picea3f",[(_position select 0) - 13, (_position select 1) + 21,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover35 = createVehicle ["MAP_t_picea2s",[(_position select 0) - 17, (_position select 1) + 21,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover36 = createVehicle ["MAP_t_picea2s",[(_position select 0) + 13, (_position select 1) - 12,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover37 = createVehicle ["MAP_t_picea1s", [(_position select 0) + 30, (_position select 1) - 0.01,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover38 = createVehicle ["MAP_t_picea2s", [(_position select 0) - 47, (_position select 1) - 21,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover39 = createVehicle ["MAP_t_picea2s", [(_position select 0) + 34, (_position select 1) - 48,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover40 = createVehicle ["MAP_t_pinusN2s",[(_position select 0) + 31, (_position select 1) - 52,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover41 = createVehicle ["MAP_t_pinusS2f",[(_position select 0) + 12, (_position select 1) - 5,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover42 = createVehicle ["Land_Fire_barrel_burning",[(_position select 0) - 0.01, (_position select 1) - 0.01,-0.02],[], 0, "CAN_COLLIDE"];

	_baserunover 	= [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14,_baserunover15,_baserunover16,_baserunover17,_baserunover18,_baserunover19,_baserunover20,_baserunover21,_baserunover22,_baserunover23,_baserunover24,_baserunover25,_baserunover26,_baserunover27,_baserunover28,_baserunover29,_baserunover30,_baserunover31,_baserunover32,_baserunover33,_baserunover34,_baserunover35,_baserunover36,_baserunover37,_baserunover38,_baserunover39,_baserunover40,_baserunover41,_baserunover42];
	
	_directions = [0,0,0,0,0,0,0,-178.615,0.089,-89.16,-180.55,-179.808,0,0,0,0,-179.832,82.75,0,-71.49,-180.097,0.999,52.43,0,0,0,0,0,-99.19,0,0,-73.36,52.65,0,0,0,0,0,0,0,0,0,0];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
	
	{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

	//Troops
	[[(_position select 0) - 12, (_position select 1) + 2, 0],4,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[(_position select 0) + 2, (_position select 1) + 2, 0],4,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[(_position select 0) + 14, (_position select 1) - 35, 0],4,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[(_position select 0) + 13, (_position select 1) + 35, 0],4,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

	//Humvee Patrol
	[[(_position select 0) - 22, (_position select 1) - 56, 0],[(_position select 0) + 22, (_position select 1) + 56, 0],50,2,"HMMWV_Armored","Hard","Hero","Hero",_mission] call vehicle_patrol;
	 
	//Static Guns
	[[[(_position select 0) - 0.01, (_position select 1) + 41, 0]],"M2StaticMG","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;
	[[[(_position select 0) + 0.1, (_position select 1) - 25, 0]],"M2StaticMG","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

	
	//Condition
	_complete = [
		[_mission,_crate],				// mission number and crate
		["crate"],						// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 				// cleanup objects
		"The ARMY set up a heavily guarded base",	// mission announcement
		"Survivors have secured the ARMY Base",								// mission success
		"Survivors were unable to clear the ARMY Base....mission failed"							// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,10,5,10,3,2] call dynamic_crate;
			};

	diag_log format["WAI: [Mission:[Bandit] ARMY Base]: Ended at %1",_position];

	b_missionsrunning = b_missionsrunning - 1;
};