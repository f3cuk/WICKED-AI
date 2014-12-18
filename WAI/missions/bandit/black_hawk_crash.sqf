if(isServer) then {

	private 		["_complete","_crate_type","_mission","_playerPresent","_position","_crate","_baserunover"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"Medium","Black Hawk Crash","MainBandit",true] call mission_init;

	diag_log 		format["WAI: [Mission:[Bandit] Black Hawk Crash]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_medium call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];

	//Base
	_baserunover 	= createVehicle ["UH60_ARMY_Wreck_burned_DZ",[((_position select 0) + 5), ((_position select 1) + 5), 0],[],10,"FORM"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	//Troops
	[[_position select 0,_position select 1,0],3,"Medium",["Random","AT"],4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],3,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],3,"Medium","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

	//Static Guns
	[[
		[(_position select 0) + 25, (_position select 1) + 25, 0],
		[(_position select 0) - 25, (_position select 1) - 25, 0]
	],"M2StaticMG","Easy","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"A Black Hawk carrying supplies has crashed and heroes are securing the site! Check your map for the location!",	// mission announcement
		"Bandits have secured the crashed Black Hawk!",																	// mission success
		"Bandits did not secure the crashed Black Hawk in time"															// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,5,5,10,2] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Bandit] Black Hawk Crash]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};