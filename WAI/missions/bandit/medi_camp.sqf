if(isServer) then {

	private 		["_mission","_position","_crate","_playerPresent","_baserunover","_baserunover2"];

	_position		= [30] call find_position;
	_mission		= [_position,"Easy","Medical Supply Camp","MainBandit",true] call init_mission;
	diag_log 		format["WAI: Mission Medic Camp Started At %1",_position];

	// Medical Supply Box
	_crate = createVehicle ["BAF_VehicleBox",[(_position select 0) + 15,(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
	[_crate] call Medical_Supply_Box;

	//Medical Supply Camp
	_baserunover 	= createVehicle ["Land_fortified_nest_big",[(_position select 0) +15, (_position select 1) -20,0],[], 0, "CAN_COLLIDE"];
	_baserunover2 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0) +25, (_position select 1) +10,0],[], 0, "CAN_COLLIDE"];

	[[_position select 0, _position select 1, 0],4,"Easy","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Easy","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Random","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

	[
		[_mission,_crate],				// mission number and crate
		["kill"],						// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover,_baserunover2], 	// cleanup objects
		"A soldier squad have set up a medical re-supply camp! Check your map for the location!",	// mission announcement
		"Survivors have taken control of the medical supply camp!",									// mission success
		"The survivors were unable to capture the medical supply camp"								// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Mission Medic Camp ended at %1",_position];
	b_missionrunning = false;
};