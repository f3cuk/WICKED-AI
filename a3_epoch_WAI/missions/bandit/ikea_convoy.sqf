if(isServer) then {
	private			["_complete","_dir","_rndnum","_crate_type","_mission","_position","_vehclass3","_vehclass2","_vehicle3","_vehicle2","_playerPresent","_vehicle","_vehclass","_crate"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;
	waitUntil{!isNil "_mission"};

	_fn_position	= [40] call find_position;
	_position		= _fn_position select 0;
	_missionType	= _fn_position select 1;
	
	[_mission,_position,"Hard","Jem og Fix Convoy","MainBandit",true] call mission_init;
	diag_log 		format["WAI: [Mission:Jem og Fix Convoy]: Starting... %1",_position];

	//Setup the crate
	_crate = [2,_position] call wai_spawn_create;
	//Base
	_baserunover 	= createVehicle ["Land_HelipadEmpty_F",[((_position select 0) + 5), ((_position select 1) + 5), -150],[],10,"CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;
	
	//Troops
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Hard",[1,"AT"],"bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Hard","Random","bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Hard",0,"bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Hard",0,"bandit",_mission] call spawn_group;


	//Static Guns
	[
		[
			[(_position select 0) + 25, (_position select 1) + 25, 0],
			[(_position select 0) - 25, (_position select 1) - 25, 0],
			[(_position select 0) + 25, (_position select 1) - 25, 0]
		],
		"O_HMG_01_high_F",
		"hard","bandit",
		_mission
	] call spawn_static;

	//Heli Para Drop
	[
		[(_position select 0),(_position select 1),0],
		[0,0,0],
		400,
		"B_Heli_Transport_01_camo_EPOCH",
		10,
		"Random",
		"Random",
		"bandit",
		false,
		_mission
	] spawn heli_para;
	
	// Spawn Vehicles
	/*_dir 			= floor(round(random 360));

	_vehclass 		= cargo_trucks 		call BIS_fnc_selectRandom;		// Cargo Truck
	_vehclass2 		= refuel_trucks 	call BIS_fnc_selectRandom;		// Refuel Truck
	_vehclass3 		= military_unarmed 	call BIS_fnc_selectRandom;		// Military Unarmed

	//_vehicle		= [_vehclass,_position,_mission,false,_dir] call custom_publish;
	//_vehicle2		= [_vehclass2,_position,_mission,false,_dir] call custom_publish;
	//_vehicle3		= [_vehclass3,_position,_mission,false,_dir] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass];
		diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass3];
		diag_log format["WAI: [Bandit] ikea_convoy spawned a %1",_vehclass2];
	};
	*/
	
	//Condition
	_complete = [
		[_mission,_crate],				// mission number and crate
		["crate"], 						// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover],	// cleanup objects
		"A heavily guarded Jem og Fix convoy is taking a lunch break, bandites are securing the parameter. See if you can make the building supplies yours.",	// mission announcement
		"Bandits have successfully ambushed the Jem og Fix convoy and secured the building supplies!",			// mission success
		"Bandits were unable to surprise the bandites on their lunchbreak"									// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,[1,crate_weapons_buildables],[4,crate_tools_buildable],[20,crate_items_buildables],4] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:Jem og Fix Convoy]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};