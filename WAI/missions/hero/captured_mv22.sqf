if(isServer) then {

	private			["_complete","_crate_type","_mission","_vehname","_vehicle","_position","_vehclass","_crate","_baserunover","_rndnum"];

	_position		= [30] call find_position;
	mission		= [_position,"Hard","Captured Transport Heli","MainBandit",true] call mission_init;

	diag_log 		format["WAI: [Mission:[Bandit] Captured Transport Heli]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) - 20,(_position select 1) - 20,0], [], 0, "CAN_COLLIDE"];
	
	//Medical Tent
	_baserunover 	= createVehicle ["Land_Medevac_HQ_V1_F",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	//Troops
	_rndnum = 3 + round (random 3);
	[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Random","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"Random","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	 
	//Static Guns
	[[
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0]
	],"O_HMG_01_support_high_F","Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	//MV22
	_vehclass 		= "B_Heli_Transport_01_camo_EPOCH";
	_vehicle		= [_vehclass,_position] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Hero] captured heli transport spawned a transport heli at %1", _position];
	};
	
	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_vehicle,_baserunover], 		// cleanup objects
		"Bandits have captured a Red Cross transport! An informant has advised there are medical supplies and has updated the map with the location!",	// mission announcement
		"Survivors have secured the shipment!",																										// mission success
		"Survivors did not secure the shipment in time."																								// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,0,0,[80,crate_items_medical],0] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Hero] Captured Transport Heli]: Ended at %1",_position];

	h_missionrunning = false;
};