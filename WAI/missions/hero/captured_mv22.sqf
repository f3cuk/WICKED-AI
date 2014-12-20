if(isServer) then {

	private			["_complete","_crate_type","_mission","_vehname","_vehicle","_position","_vehclass","_crate","_baserunover","_rndnum"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Hard","Captured MV22","MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Hero] Captured MV22]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) - 20,(_position select 1) - 20,0], [], 0, "CAN_COLLIDE"];
	
	//Medical Tent
	_baserunover 	= createVehicle ["USMC_WarfareBFieldhHospital",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	//Troops
	_rndnum = 3 + round (random 3);
	[[_position select 0,_position select 1,0],_rndnum,"Hard",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	 
	//Static Guns
	[[
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0]
	],"M2StaticMG","Hard","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	//MV22
	_vehclass 		= "MV22_DZ";
	_vehicle		= [_vehclass,_position,_mission] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Hero] captured_mv22 spawned a MV22 at %1", _position];
	};
	
	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_vehicle,_baserunover], 		// cleanup objects
		"Bandits have captured a Red Cross MV-22! An informant has advised there are medical supplies, he has updated the map for the location!",	// mission announcement
		"Survivors have secured the MV-22!",																										// mission success
		"Survivors did not secure the MV-22 in time"																								// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,0,0,[80,crate_items_medical],0] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Hero] Captured MV22]: Ended at %1",_position];

	h_missionsrunning = h_missionsrunning - 1;
};