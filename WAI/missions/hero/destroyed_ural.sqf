if(isServer) then {

	private			["_crate","_mission","_position","_num_guns","_num_tools","_num_items","_rndnum","_rndgro"];

	_position		= [30] call find_position;
	_mission		= [_position,"Easy","Ural Attack","MainHero",true] call mission_init;	
	diag_log 		format["WAI: Ural Attack mission started at %1",_position];

	_baserunover 	= createVehicle ["UralWreck",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];

	_num_guns		= (1 + round (random 3));
	_num_tools		= (3 + round (random 8));
	_num_items		= (6 + round (random 36));

	//Medium Gun Box
	_crate = createVehicle ["BAF_VehicleBox",[(_position select 0) - 20,(_position select 1) - 20,0], [], 0, "CAN_COLLIDE"];
	[_crate,_num_guns,_num_tools,_num_items] call spawn_ammo_box;

	_rndnum 	= round (random 4) + 1;
	_rndgro 	= 1 + round (random 3);

	for "_i" from 0 to _rndgro do {
		[[_position select 0, _position select 1, 0],_rndnum,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	};

	[
		[_mission,_crate],			// mission number and crate
		["kill"], 	// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 			// cleanup objects
		"Bandits have destroyed a Ural with supplies and are securing the cargo! Check your map for the location!",	// mission announcement
		"The supplies have been secured by survivors!",															// mission success
		"Survivors did not secure the supplies in time"														// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Ural attack mission ended at %1",_position];
	h_missionrunning = false;
};