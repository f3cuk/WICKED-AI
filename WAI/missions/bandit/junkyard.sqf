if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7","_baserunover8","_baserunover9","_baserunover10","_baserunover11","_baserunover12","_baserunover13","_baserunover14","_baserunover15","_baserunover16","_baserunover17","_baserunover18","_baserunover19","_baserunover20","_baserunover21","_baserunover22","_baserunover23","_baserunover24","_baserunover25","_baserunover26","_baserunover27","_baserunover28","_baserunover29","_baserunover30","_baserunover31"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Hard","Junk Yard","MainBandit",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Bandit] Junk Yard]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) + 0.2,(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_crate] call wai_crate_setup;

	//Medical Supply Camp
//Buildings 
_baserunover0 = createVehicle ["Mi8Wreck",[(_position select 0) + 31, (_position select 1) - 12.4,-0.12],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["UralWreck",[(_position select 0) - 7, (_position select 1) - 9,-0.04],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["UralWreck",[(_position select 0) + 23, (_position select 1) + 4,-0.04],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["UralWreck", [(_position select 0) - 7, (_position select 1) + 23,-0.04],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["HMMWVWreck", [(_position select 0) - 8, (_position select 1) + 7,-0.04],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["BMP2Wreck", [(_position select 0) - 4, (_position select 1) + 24,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["T72Wreck",[(_position select 0) + 11, (_position select 1) - 13,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["UralWreck",[(_position select 0) + 14, (_position select 1) + 10,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover8 = createVehicle ["T72Wreck",[(_position select 0) + 4, (_position select 1) + 16,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover9 = createVehicle ["UH60_ARMY_Wreck_DZ", [(_position select 0) + 7, (_position select 1) + 1.3,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover10 = createVehicle ["Land_Dirthump01", [(_position select 0) + 9, (_position select 1) + 1,-1.59],[], 0, "CAN_COLLIDE"];
_baserunover11 = createVehicle ["Land_Dirthump01", [(_position select 0) + 8, (_position select 1) + 0.2,-1.59],[], 0, "CAN_COLLIDE"];
_baserunover12 = createVehicle ["Mi8Wreck",[(_position select 0) + 5, (_position select 1) - 34,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover13 = createVehicle ["BRDMWreck",[(_position select 0) - 1, (_position select 1) - 20,-0.12],[], 0, "CAN_COLLIDE"];
_baserunover14 = createVehicle ["T72Wreck",[(_position select 0) - 9, (_position select 1) - 21,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover15 = createVehicle ["Mi8Wreck",[(_position select 0) - 21, (_position select 1) - 5,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover16 = createVehicle ["Land_Misc_Rubble_EP1",[(_position select 0) - 10.02, (_position select 1) + 7,-0.1],[], 0, "CAN_COLLIDE"];
_baserunover17 = createVehicle ["Land_Shed_W03_EP1", [(_position select 0) - 7, (_position select 1) - 1.4,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover18 = createVehicle ["Land_Misc_Garb_Heap_EP1", [(_position select 0) - 6, (_position select 1) + 1,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover19 = createVehicle ["Land_Misc_Garb_Heap_EP1", [(_position select 0) + 18, (_position select 1) + 10,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover20 = createVehicle ["Land_Misc_Garb_Heap_EP1",[(_position select 0) - 10, (_position select 1) - 12,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover21 = createVehicle ["MAP_garbage_misc",[(_position select 0) + 5, (_position select 1) - 21,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover22 = createVehicle ["MAP_garbage_misc",[(_position select 0) + 7, (_position select 1) + 18,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover23 = createVehicle ["MAP_garbage_paleta", [(_position select 0) - 12, (_position select 1) + 14,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover24 = createVehicle ["MAP_Kitchenstove_Elec", [(_position select 0) - 11, (_position select 1) + 1.5,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover25 = createVehicle ["MAP_tv_a", [(_position select 0) - 12, (_position select 1) - 0.01,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover26 = createVehicle ["MAP_washing_machine",[(_position select 0) - 11, (_position select 1) -1,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover27 = createVehicle ["MAP_P_toilet_b_02",[(_position select 0) - 16, (_position select 1) + 0.01,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover28 = createVehicle ["Land_Misc_Garb_Heap_EP1",[(_position select 0) - 17, (_position select 1) - 3,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover29 = createVehicle ["MAP_garbage_paleta",[(_position select 0) - 11, (_position select 1) - 0.01,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover30 = createVehicle ["Land_Fire_barrel_burning",[(_position select 0) - 13, (_position select 1) - 3,-0.02],[], 0, "CAN_COLLIDE"];
_baserunover31 = createVehicle ["Land_Fire_barrel_burning", [(_position select 0) + 2, (_position select 1) - 9,-0.02],[], 0, "CAN_COLLIDE"];

	_baserunover 	= [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_baserunover8,_baserunover9,_baserunover10,_baserunover11,_baserunover12,_baserunover13,_baserunover14,_baserunover15,_baserunover16,_baserunover17,_baserunover18,_baserunover19,_baserunover20,_baserunover21,_baserunover22,_baserunover23,_baserunover24,_baserunover25,_baserunover26,_baserunover27,_baserunover28,_baserunover29,_baserunover30,_baserunover31];
	
	_directions = [0,-49.99,201.46,80.879,44.77,-89,27,162,0,-41,25,53,94,-1.7,-75,-24,0,-99,0,0,0,0,-178,-91,146,108,100,36,93,21,0,0];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
	
	{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

	//Troops
	[[(_position select 0) - 2, (_position select 1) - 5, 0],4,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[(_position select 0) - 19, (_position select 1) + 19, 0],4,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[(_position select 0) + 17, (_position select 1) + 21, 0],4,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	
	//Condition
	_complete = [
		[_mission,_crate],				// mission number and crate
		["crate"],						// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 				// cleanup objects
		"Heroes are hiding something in a junk yard..go check it out",	// mission announcement
		"Survivors have secured the Junk Yard",								// mission success
		"Survivors were unable to clear the Junk Yard....mission failed"							// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,14,5,1,3,2] call dynamic_crate;
			};

	diag_log format["WAI: [Mission:[Bandit] Junk Yard]: Ended at %1",_position];

	b_missionsrunning = b_missionsrunning - 1;
};