if(isServer) then {

	private			["_rndnum","_crate_type","_mission","_position","_vehclass3","_vehclass2","_vehicle3","_vehicle2","_playerPresent","_vehicle","_vehclass","_crate"];

	_position		= [40] call find_position;
	_mission		= [_position,"Hard","Lunch break Convoy","MainBandit",true] call mission_init;

	diag_log 		format["WAI: [Mission:[Bandit] Lunch break Convoy]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_large call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	
	[_crate,[2,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],4] call dynamic_crate;
	
	//Troops
	_rndnum = 5 + round (random 3);
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"Random","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"Random","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

	//Static Guns
	[[
		[(_position select 0) + 25, (_position select 1) + 25, 0],
		[(_position select 0) - 25, (_position select 1) - 25, 0],
		[(_position select 0) + 25, (_position select 1) - 25, 0]
	],"M2StaticMG","Easy","Hero","Hero",1,2,"Random","Random",_mission] call spawn_static;

	//Heli Para Drop
	[[(_position select 0),(_position select 1),0],[0,0,0],400,"BAF_Merlin_HC3_D",10,"Random","Random",4,"Random","Hero","Random","Hero",true,_mission] spawn heli_para;

	// Spawn Vehicles
	_vehclass 		= cargo_trucks call BIS_fnc_selectRandom;		// Cargo Truck
	_vehclass2 		= refuel_trucks call BIS_fnc_selectRandom;		// Refuel Truck
	_vehclass3 		= military_unarmed call BIS_fnc_selectRandom;	// Military Unarmed
	
	_vehicle		= [_vehclass,_position] call custom_publish;
	_vehicle2		= [_vehclass2,_position] call custom_publish;
	_vehicle3		= [_vehclass3,_position] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass];
		diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass3];
		diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass2];
	};
	
	//Condition
	[
		[_mission,_crate],				// mission number and crate
		["crate"], 						// ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[_vehicle,_vehicle2,_vehicle3],	// cleanup objects
		"A heavily guarded Ikea convoy is taking a lunch break, heroes are securing the parameter. See if you can make the building supplies yours.",	// mission announcement
		"Bandits have successfully ambushed the Ikea convoy and secured the building supplies!",			// mission success
		"Bandits were unable to surprise the heroes on their lunchbreak"									// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Mission:[Bandit] Lunch break Convoy]: Ended at %1",_position];
	
	b_missionrunning = false;
};