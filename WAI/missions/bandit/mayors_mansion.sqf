if(isServer) then {

	private			["_mission","_position","_crate","_playerPresent","_baserunover","_mayor"];

	_position		= [40] call find_position;
	_mission		= [_position,"Hard","Mayors Mansion","MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Hero] mayors_mansion started at %1",_position];

	//Large Gun Box
	_crate = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1), .5], [], 0, "CAN_COLLIDE"];
	[_crate] call Large_Gun_Box;
	 
	//Mayors Mansion
	_baserunover 	= createVehicle ["Land_A_Villa_EP1",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];

	//Troops
	[[_position select 0, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//The Mayor Himself
	_mayor = [[_position select 0, _position select 1, 0],1,"Hard","Random",4,"Random","Special","Random",["Bandit",500],_mission] call spawn_group;

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
		"The survivors were unable to capture the mansion, time is up"										// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Hero] mayors_mansion ended at %1",_position];
	h_missionrunning = false;
};