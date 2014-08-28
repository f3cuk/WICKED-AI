if(isServer) then {

	private			["_mayor_himself","_crate_type","_mission","_position","_crate","_baserunover","_mayor"];

	_position		= [40] call find_position;
	_mission		= [_position,"Hard","Mayors Mansion","MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Hero] Mayors Mansion]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_large call BIS_fnc_selectRandom;
	_crate 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1), .5], [], 0, "CAN_COLLIDE"];
	
	[_crate,20,4,0,4] call dynamic_crate;
	 
	//Mayors Mansion
	_baserunover 	= createVehicle ["Land_A_Villa_EP1",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	//Troops
	[[_position select 0, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//The Mayor Himself
	_mayor = [[(_position select 0) + 10, (_position select 1) - 10, 4.1],1,"Hard","Random",4,"Random","Special","Random",["Bandit",500],_mission] call spawn_group;
	
	_mayor_himself = (units _mayor) select 0;
	_mayor_himself disableAI "MOVE";

	//Static mounted guns
	[[
		[(_position select 0) - 15, (_position select 1) + 15, 8],
		[(_position select 0) + 15, (_position select 1) - 15, 8]
	],"M2StaticMG","Easy","Bandit","Bandit",1,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],		// mission number and crate
		["assassinate",_mayor], // ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 		// cleanup objects
		"The Mayor has gone rogue, go take him and his task force out to claim the black market weapons!",	// mission announcement
		"The rogue mayor has been taken out, who will be the next Mayor of Cherno?",						// mission success
		"Survivors were unable to capture the mansion, time is up"										// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Mission:[Hero] Mayors Mansion]: Ended at %1",_position];

	h_missionrunning = false;
};