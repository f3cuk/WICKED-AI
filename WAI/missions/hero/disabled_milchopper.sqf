if(isServer) then {

	private 		["_crate","_mission","_tanktraps","_mines","_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition"];

	//Military Chopper
	_vehclass 		= armed_chopper call BIS_fnc_selectRandom;
	_vehname 		= getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

	_position		= [30] call find_position;
	_mission		= [_position,"Medium",format["Disabled %1", _vehname],"MainHero",true] call init_mission;	
	diag_log 		format["WAI: Mission Armed Chopper Started At %1",_position];

	//Sniper Gun Box
	_crate 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
	[_crate] 		call Sniper_Gun_Box;

	//Spawn vehicle
	_vehicle		= [_vehclass,_position] call custom_publish;
	diag_log format["WAI: Mission Armed Chopper spawned a %1",_vehname];
	
	//Troops
	_rndnum = round (random 4) + 2;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Random","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Random","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//Turrets
	[[
		[(_position select 0) + 10, (_position select 1) - 10, 0],
		[(_position select 0) - 10, (_position select 1) + 10, 0]
	],"M2StaticMG","easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[_vehicle], 	// cleanup objects
		"A bandit helicopter is taking off with a crate of snipers! Save the cargo and take their chopper!",	// mission announcement
		"Survivors have secured the armed chopper!",															// mission success
		"Survivors did not secure the armed chopper in time"													// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Mission armed chopper ended at %1",_position];
	h_missionrunning = false;
};