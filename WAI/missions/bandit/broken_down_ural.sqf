if(isServer) then {

	private			["_baserunover","_crate_type","_crate","_mission","_position","_num_guns","_num_tools","_num_items","_rndnum","_rndgro"];

	_position		= [30] call find_position;
	_mission		= [_position,"Easy","Ural Attack","MainBandit",true] call mission_init;

	diag_log 		format["WAI: [Bandit] broken_down_ural started at %1",_position];

	//Setup the crate
	_crate_type 	= crates_medium call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],10,"FORM"];

	[_crate,4,8,36,2] call dynamic_crate;

	_rndnum 	= 1 + round (random 4);
	_rndgro 	= 1 + round (random 3);

	for "_i" from 0 to _rndgro do {
		[[_position select 0, _position select 1, 0],_rndnum,"Easy","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	};
	
	//Spawn vehicles
	_baserunover 	= createVehicle ["UralWreck",[(_position select 0),(_position select 1),0],[],10,"FORM"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	[
		[_mission,_crate],			// mission number and crate
		["kill"], 					// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 			// cleanup objects
		"Heroes are defending a broken down Ural! Check your map for the location!",	// mission announcement
		"The supplies have been secured by bandits!",									// mission success
		"Bandits failed to secure the supplies"											// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Bandit] broken_down_ural ended at %1",_position];
	
	b_missionrunning = false;
};