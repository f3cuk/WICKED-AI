if(isServer) then {

	private			["_mission","_playerPresent","_vehname","_vehicle","_position","_vehclass","_crate","_tent","_rndnum"];

	_position		= [30] call find_position;
	_mission		= [_position,"Hard","Captured MV 22","MainBandit",true] call init_mission;	
	diag_log		format["WAI: Mission MV22 started at %1",_position];

	//Medical Supply Box
	_crate 			= createVehicle ["LocalBasicWeaponsBox",[(_position select 0) - 20,(_position select 1) - 20,0], [], 0, "CAN_COLLIDE"];
	[_crate] 		call Medical_Supply_Box;

	//Medical Tent
	_tent 			= createVehicle ["USMC_WarfareBFieldhHospital",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_tent 			setVectorUp surfaceNormal position _tent;

	//MV22
	_vehclass 		= "MV22_DZ";
	_vehicle		= [_vehclass,_position] call custom_publish;
	diag_log format["WAI: Mission MV22 spawned a MV22 at %1", _position];
	
	//Troops
	_rndnum = round (random 3) + 4;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	
	[[_position select 0, _position select 1, 0],_rndnum,"Random","Random",4,"Random","Doctor","Random",["Hero",200],_mission] call spawn_group;
	 
	//Turrets
	[[
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0]
	],"M2StaticMG","Medium","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_vehicle], 		// cleanup objects
		"A group of red cross volunteers are giving away medical supplies",		// mission announcement
		"Bandits have murdered the volunteers, shame on them!",					// mission success
		"The medical supplies have been given away"								// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Mission captured MV-22 ended at %1",_position];
	b_missionrunning = false;
};