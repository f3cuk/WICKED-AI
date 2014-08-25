if(isServer) then {

	private 		["_crate","_mission","_static_gun","_crate_type","_rndnum","_playerPresent","_vehname","_vehicle","_position","_vehclass"];

	//Armed Land Vehicle
	_vehclass 		= armed_vehicle call BIS_fnc_selectRandom;
	_vehname 		= getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

	_position		= [30] call find_position;
	_mission		= [_position,"Medium",format["Disabled %1",_vehname],"MainBandit",true] call mission_init;
	
	diag_log		format["WAI: [Bandit] armed_vehicle started at %1",_position];

	//Chain Bullet Box
	_crate_type 	= wai_crates call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
	[_crate] call chain_bullet_box;

	//Troops
	_rndnum = (2 + round (random 4));
	[[_position select 0, _position select 1, 0],_rndnum,"Medium","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Medium","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Medium","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Medium","Random",3,"Random","Hero","Random","Hero",_mission] call spawn_group;

	//Turrets
	_static_gun = ai_static_weapons call BIS_fnc_selectRandom;
	[[
		[(_position select 0),(_position select 1) + 10, 0]
	],_static_gun,"Medium","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;

	//Spawn vehicles
	_vehicle		= [_vehclass,_position] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Bandit] armed_vehicle spawned a %1",_vehname];
	};
	
	[
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_vehicle], 		// cleanup objects
		"Heroes have taken an armed vehicle from the bandits! Check your map for the location!",	// mission announcement
		"Bandits have secured the armed vehicle!",													// mission success
		"Bandits did not secure the armed vehicle in time"										// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Bandit] armed_vehicle ended at %1",_position];
	b_missionrunning = false;
};