if(isServer) then {

	private			["_mission","_position","_vehclass3","_vehclass2","_vehicle3","_vehicle2","_playerPresent","_vehicle","_vehclass","_crate"];

	_position		= [40] call find_position;
	_mission		= [_position,"Hard","Disabled Convoy","MainHero",true] call init_mission;	
	diag_log		format["WAI: [Hero] ikea_convoy started At %1",_position];

	//Construction Supply Box
	_crate 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_crate] 		call Construction_Supply_box;

	//Troops
	_rndnum = round (random 3) + 5;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"Random","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"Random","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//Turrets
	[[
		[(_position select 0) + 25, (_position select 1) + 25, 0],
		[(_position select 0) - 25, (_position select 1) - 25, 0],
		[(_position select 0) + 25, (_position select 1) - 25, 0]
	],"M2StaticMG","Easy","Bandit","Bandit",1,2,"Random","Random",_mission] call spawn_static;

	//Heli Para Drop
	[[(_position select 0),(_position select 1),0],[0,0,0],400,"BAF_Merlin_HC3_D",10,"Random","Random",4,"Random","Bandit","Random","Bandit",true,_mission] spawn heli_para;

	// Spawn Vehicles
	_vehclass 		= cargo_trucks call BIS_fnc_selectRandom;		// Cargo Truck
	_vehclass2 		= refuel_trucks call BIS_fnc_selectRandom;		// Refuel Truck
	_vehclass3 		= military_unarmed call BIS_fnc_selectRandom;	// Military Unarmed
	
	_vehicle		= [_vehclass,_position] call custom_publish;
	_vehicle2		= [_vehclass2,_position] call custom_publish;
	_vehicle3		= [_vehclass3,_position] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Hero] ikea_convoy spawned a %1",_vehclass];
		diag_log format["WAI: [Hero] ikea_convoy spawned a %1",_vehclass3];
		diag_log format["WAI: [Hero] ikea_convoy spawned a %1",_vehclass2];
	};
	
	[
		[_mission,_crate],				// mission number and crate
		["crate"], 						// ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[_vehicle,_vehicle2,_vehicle3],	// cleanup objects
		"An Ikea delivery has been hijacked by bandits, take over the convoy and the building supplies are yours!",	// mission announcement
		"Survivors have secured the building supplies!",															// mission success
		"Survivors did not secure the convoy in time"																// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Hero] ikea_convoy ended at %1",_position];
	h_missionrunning = false;
};