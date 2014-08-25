if(isServer) then {

	private 		["_crate","_mission","_tanktraps","_mines","_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition"];

	//Military Chopper
	_vehclass 		= armed_chopper call BIS_fnc_selectRandom;
	_vehname 		= getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

	_position		= [30] call find_position;
	_mission		= [_position,"Hard",format["Sniper extraction %1", _vehname],"MainBandit",true] call mission_init;	
	diag_log 		format["WAI: Mission Sniper Extraction Started At %1",_position];

	//Sniper Gun Box
	_crate 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
	[_crate] 		call Sniper_Gun_Box;

	//Spawn vehicle
	_vehicle		= [_vehclass,_position] call custom_publish;
	diag_log format["WAI: Mission Sniper Extraction spawned a %1",_vehname];
	
	//Troops
	_rndnum = round (random 4) + 2;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

	//Turrets
	[[
		[(_position select 0) + 10, (_position select 1) - 10, 0],
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) - 10, (_position select 1) - 10, 0],
		[(_position select 0) - 10, (_position select 1) + 10, 0]
	],"M2StaticMG","medium","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[_vehicle], 		// cleanup objects
		"Heroes have captured a lot of sniper rifles from the Takistani bandit clan, make your move as a bandit whilst they are planning a getaway",		// mission announcement
		"Bandits have secured the snipers and taken the chopper!",		// mission success
		"Bandits did not secure the sniper rifles in time"				// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Mission Sniper Extraction ended at %1",_position];
	b_missionrunning = false;
};