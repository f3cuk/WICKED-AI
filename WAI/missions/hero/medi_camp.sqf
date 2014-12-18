if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Easy","Medical Supply Camp","MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Hero] Medical Supply Camp]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) + 15,(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];

	//Medical Supply Camp
	_baserunover1 	= createVehicle ["Land_fortified_nest_big",[(_position select 0) +15, (_position select 1) -20,0],[], 0, "CAN_COLLIDE"];
	_baserunover2 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0) +25, (_position select 1) +10,0],[], 0, "CAN_COLLIDE"];
	_baserunover 	= [_baserunover1,_baserunover2];

	{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

	//Troops
	[[_position select 0,_position select 1,0],4,"Easy",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//Condition
	_complete = [
		[_mission,_crate],				// mission number and crate
		["kill"],						// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 				// cleanup objects
		"Bandits have taken over a medical re-supply camp! Check your map for the location!",	// mission announcement
		"Survivors have taken control of the medical supply camp!",								// mission success
		"Survivors were unable to capture the medical supply camp"							// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,0,0,[70,crate_items_medical],0] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Hero] Medical Supply Camp]: Ended at %1",_position];

	h_missionsrunning = h_missionsrunning - 1;
};