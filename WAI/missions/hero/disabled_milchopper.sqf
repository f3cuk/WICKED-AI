if(isServer) then {

	private 		["_complete","_vehicle","_rndnum","_crate_type","_crate","_mission","_vehname","_position","_vehclass"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	//Military Chopper
	_vehclass 		= armed_chopper call BIS_fnc_selectRandom;
	_vehname 		= getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

	_position		= [30] call find_position;
	[_mission,_position,"Medium",format["Disabled %1", _vehname],"MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Hero] Disabled Military Chopper]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_medium call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
	
	//Troops
	_rndnum = 2 + round (random 4);
	[[_position select 0,_position select 1,0],_rndnum,"Medium",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//Static Guns
	[[
		[(_position select 0) + 30, (_position select 1) - 30, 0],
		[(_position select 0) + 30, (_position select 1) + 30, 0],
		[(_position select 0) - 30, (_position select 1) - 30, 0],
		[(_position select 0) - 30, (_position select 1) + 30, 0]
	],"M2StaticMG","Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	//Spawn vehicle
	_vehicle		= [_vehclass,_position,_mission] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Hero] disabled_milchopper spawned a %1",_vehname];
	};
	
	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[_vehicle], 		// cleanup objects
		"A bandit helicopter is taking off with a crate of snipers! Save the cargo and take their chopper!",	// mission announcement
		"Survivors have secured the armed chopper!",															// mission success
		"Survivors did not secure the armed chopper in time"													// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,[10,ai_wep_sniper],[4,crate_tools_sniper],[4,crate_items_sniper],2] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Hero] Disabled Military Chopper]: Ended at %1",_position];
	
	h_missionsrunning = h_missionsrunning - 1;
};