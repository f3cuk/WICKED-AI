if(isServer) then {

	private			["_complete","_crate_type","_mission","_vehicle","_position","_vehclass","_crate","_baserunover","_rndnum"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Hard","Captured MV22","MainBandit",true] call mission_init;

	diag_log 		format["WAI: [Mission:[Bandit] Captured MV22]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) - 20,(_position select 1),0],[],0,"CAN_COLLIDE"];
	
	//Medical Tent
	_baserunover 	= createVehicle ["USMC_WarfareBFieldhHospital",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	//Troops
	_rndnum = 4 + round (random 3);
	[[_position select 0,_position select 1,0],_rndnum,"Hard",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Doctor","Random",["Hero",200],_mission] call spawn_group;
	 
	//Static Guns
	[[
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0]
	],"M2StaticMG","Hard","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;
	
	//Spawn vehicles
	_vehclass 		= "MV22_DZ";
	_vehicle		= [_vehclass,_position,_mission] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Bandit] captured_mv22 spawned a MV22 at %1", _position];
	};
	
	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_vehicle], 		// cleanup objects
		"A group of red cross volunteers are giving away medical supplies, they are heavily guarded by trained soldiers",		// mission announcement
		"Bandits have murdered the volunteers, shame on them!",					// mission success
		"The medical supplies have been given away"								// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,0,0,[80,crate_items_medical],0] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Bandit] Captured MV22]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};