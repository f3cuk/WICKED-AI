if(isServer) then {

	private 		["_mission","_playerPresent","_position","_crate","_baserunover"];

	_position		= [30] call find_position;
	_mission		= [_position,"Medium","Black Hawk Crash","MainHero",true] call mission_init;	
	diag_log 		format["WAI: Wrecked Black Hawk mission started at %1",_position];

	_num_guns		= round(random 5);
	_num_tools		= round(random 5);
	_num_items		= round(random 10);

	//Dynamic Box
	_crate 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_crate,_num_guns,_num_tools,_num_items] call spawn_ammo_box;

	_baserunover 	= createVehicle ["UH60_ARMY_Wreck_burned_DZ",[((_position select 0)  + 5 + random 15), ((_position select 1)  + 5 + random 15), 0], [], 0, "CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	[[_position select 0, _position select 1, 0],3,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],3,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//Turrets
	[[
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0]
	],"M2StaticMG","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"A Black Hawk carrying supplies has crashed and bandits are securing the site! Check your map for the location!",	// mission announcement
		"Survivors have secured the crashed Black Hawk!",																	// mission success
		"Survivors did not secure the crashed Black Hawk in time"															// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Wrecked Black Hawk mission ended at %1",_position];
	h_missionrunning = false;
};