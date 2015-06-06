if(isServer) then {

    private			["_complete","_baserunover","_crate_type","_crate","_mission","_position","_num_guns","_num_tools","_num_items","_rndnum","_rndgro"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Easy","Ural Attack","MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Hero] Ural Attack]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_medium call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) - 20,(_position select 1) - 20,0], [], 0, "CAN_COLLIDE"];

	//Base
	_baserunover 	= createVehicle ["UralWreck",[(_position select 0),(_position select 1),0],[],14,"FORM"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	//Troops
	_rndnum 	= 2 + round (random 2);
	_rndgro 	= 1 + round (random 2);

	[[_position select 0,_position select 1,0],_rndnum,"Easy",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	for "_i" from 0 to _rndgro do {
		[[_position select 0,_position select 1,0],_rndnum,"Easy","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	};
	
	//Condition
	_complete = [
		[_mission,_crate],		// mission number and crate
		["kill"], 				// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 		// cleanup objects
		"Bandits have destroyed a Ural with supplies and are securing the cargo! Check your map for the location!",	// mission announcement
		"The supplies have been secured by survivors!",																// mission success
		"Survivors did not secure the supplies in time"																// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,4,8,36,2] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Hero] Ural Attack]: Ended at %1",_position];
	
	h_missionsrunning = h_missionsrunning - 1;
};