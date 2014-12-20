if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_playerPresent","_rndnum","_rndgro","_num_guns","_num_tools","_num_items"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Medium","Weapon Cache","MainBandit",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Bandit] Weapons Cache]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	
	//Troops
	_rndnum 	= (1 + round(random 7));
	_rndgro 	= (1 + round(random 2));
	[[_position select 0,_position select 1,0],_rndnum,"Easy",["Random","AT"],3,"Random","Hero","Random","Hero",_mission] call spawn_group;
	for "_i" from 0 to _rndgro do {
		[[_position select 0,_position select 1,0],_rndnum,"Easy","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
	};

	//Static Guns
	[[
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0]
	],"M2StaticMG","Easy","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[], 				// cleanup objects
		"Heroes have obtained a weapon crate. Check your map for the location!",	// mission announcement
		"Bandits have secured the weapon cache!",									// mission success
		"Bandits did not secure the weapon cache in time"							// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,10,4,0,2] call dynamic_crate;
	};

	diag_log format["WAI: [Bandit] weapon_cache ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};