if(isServer) then {

	private 		["_VehiclePosition","_complete","_crate_type","_mission","_playerPresent","_position","_crate","_baserunover"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	
	[_mission,_position,"Medium","MV22 Crash","MainBandit",true] call mission_init;

	diag_log 		format["WAI: [Mission:[Bandit] MV22 Crash]: Starting... %1", mapGridPosition(_position)];

	/************************************************************************************/
	
	// Setup the crate
	_crate_type 	= crates_medium call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];
	// Clear it
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;

	//Base
	_baserunover 	= createVehicle ["Land_UWreck_MV22_F",[((_position select 0) + 5), ((_position select 1) + 5), 0],[],10,"FORM"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	//Troops
	/*
		_position
		_unitnumber
		_skill
		_aisoldier
		_aitype
		_mission
	*/
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Medium",[1,"AT"],"bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Medium","Random","bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Medium",0,"bandit",_mission] call spawn_group;

	//Static Guns
	[[
		[(_position select 0) + 25, (_position select 1) + 25, 0],
		[(_position select 0) - 25, (_position select 1) - 25, 0]
	],"O_G_Offroad_01_armed_F","Easy","bandit",_mission] call spawn_static;
	
	/************************************************************************************/
	
	//Heli
	[
		[_position select 0,_position select 1,0],				// Position to patrol
		[0,0,0],				// Position to spawn chopper at
		200,					// Radius of patrol
		10,						// Number of waypoints to give
		"B_Heli_Light_01_F",	// Classname of vehicle (make sure it has driver and two gunners)
		"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
		"Random",				// AI CLASS
		"Bandit",				// AI Type, "Hero" or "Bandit".
		_mission
	] call heli_patrol;
	
	/************************************************************************************/
	
	//Vehicle
	_VehiclePosition = [_position, random 1000, random 360] call BIS_fnc_relPos; 
	[
		[_position select 0,_position select 1,0],				// Position to patrol
		_VehiclePosition,		// Position to spawn chopper at
		200,					// Radius of patrol
		10,						// Number of waypoints to give
		"O_G_Offroad_01_armed_F",	// Classname of vehicle (make sure it has driver and two gunners)
		"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
		0,						// AI CLASS
		"Bandit",				// AI Type, "Hero" or "Bandit".
		_mission
	] call vehicle_patrol;
	
	//Vehicle
	_VehiclePosition = [_position, random 1000, random 360] call BIS_fnc_relPos; 
	[
		[_position select 0,_position select 1,0],				// Position to patrol
		_VehiclePosition,		// Position to spawn chopper at
		200,					// Radius of patrol
		10,						// Number of waypoints to give
		"O_G_Offroad_01_armed_F",	// Classname of vehicle (make sure it has driver and two gunners)
		"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
		0,						// AI CLASS
		"Bandit",				// AI Type, "Hero" or "Bandit".
		_mission
	] call vehicle_patrol;
	
	/************************************************************************************/

	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"A MV22 carrying supplies has crashed and bandites are securing the site! Check your map for the location!",	// mission announcement
		"Bandits have secured the crashed MV22!",																	// mission success
		"Bandits did not secure the crashed MV22 in time"															// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,5,6,15,2] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Bandit] MV22 Crash]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};