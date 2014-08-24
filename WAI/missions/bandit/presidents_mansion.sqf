if(isServer) then {

	private			["_mission","_position","_crate","_playerPresent","_rndnum","_baserunover","_president"];

	_position		= [50] call init_mission;
	_mission		= [_position,"Extreme","Presidents Palace","MainBandit",true] call init_mission;
	diag_log 		format["WAI: Mission Presidents Palace Started At %1",_position];

	//Large Gun Box
	_crate = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1) - 1, .5], [], 0, "CAN_COLLIDE"];
	[_crate] call Large_Gun_Box;
	 
	//Presidents Palace
	_baserunover 	= createVehicle ["Land_A_Office01",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];

	//Troops
	[[_position select 0, _position select 1, 0],4,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

	//The President Himself
	_president = [[_position select 0, _position select 1, 0],1,"Extreme","Random",4,"Random","Special","Random","Hero",_mission] call spawn_group;

	//Static mounted guns
	[[
		[(_position select 0) - 13.135, (_position select 1) + 5.254, 5.27],
		[(_position select 0) + 14.225, (_position select 1) + 5.025, 5.27],
		[(_position select 0) + 1.97, (_position select 1) - 2.368, 11.54]
	],"M2StaticMG","Extreme","Hero","Hero",1,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],			// mission number and crate
		["assassinate",_president], // ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[_baserunover], 			// cleanup objects
		"The President has claimed his leadership, who will assassinate him?",	// mission announcement
		"The President has been Assassinated!",									// mission success
		"The president lives to see another day."								// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Mission Presidents Palace ended at %1",_position];
	b_missionrunning = false;
};