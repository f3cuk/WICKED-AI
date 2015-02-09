if(isServer) then {
	private 		["_fn_position","_VehiclePosition","_complete","_crate_type","_mission","_playerPresent","_position","_crate","_baserunover"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;
	/*
		@﻿Description
			Find position for mission
		@﻿Parameter
			0 = Clear space for position
			1 = (optional) [0 = Road, 1 = Buldings, 2 = Wildness, 3 = Water/Coast]
		@Return
			select 0 = position
			select 1 = position type
	*/
	_fn_position	= [5] call find_position;
	_position		= _fn_position select 0;
	_missionType	= _fn_position select 1;
	
	/*
		@﻿Description
			Mission options
		@﻿Parameter
			0 = Mission number
			1 = Mission position
			2 = difficulty "easy","medium","hard","extreme"
			3 = Mission name
			4 = Missiontype "MainBandit", "special"
			5 = Spawn mines true OR false
			6 = (optional) Show marker true OR alse (default true)
		@Return
			null
	*/
	[_mission,_position,"Medium","MV22 Crash","MainBandit",true] call mission_init;
	diag_log 		format["WAI: [Mission: MV22 Crash]: Starting... %1", mapGridPosition(_position)];
	/*
		@﻿Description
		@﻿Parameter
			0 = Crate type[0 = small, 1 = medium, 2 = large]
			1 = Mission position
		@Return
			select 0 = crate
	*/
	_crate = [1,_position] call wai_spawn_create;

	//Base
	_baserunover 	= createVehicle ["Land_UWreck_MV22_F",[((_position select 0) + 5), ((_position select 1) + 5), 0],[],10,"FORM"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	/*
		@﻿Description
			Spawn AI soldiers
		@﻿Parameter
			0 = (array)			Mission Position
			1 = (int)			Number of AI
			2 = (str)			Skill "easy","medium","hard","extreme","random"
			3 = (str,int,array)	Ai "random","unarmed" OR [0 = Assault, 1 = machinegun 2 = sniper,] OR [0-2,AT],[0-2,AA](at = anti tank, aa, anti air)
			4 = (str,array)		Ai type "bandit","special" OR ["bandit",Krypto amount],["special",krypto amount]
			5 = Mission number
		@Return
			Group of AI
	*/
	/**************************************** Troops ********************************************/
	
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Medium",[1,"AT"],"bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Medium","Random","bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"Medium",0,"bandit",_mission] call spawn_group;

	/**************************************** Static ********************************************/
	/*
		@﻿Description
			Spawn Static gun
		@﻿Parameter
			0 = (array)			Mission position [GUN_1,GUN_2,GUN_3]
			1 = (str)			Static gun class name
			2 = (str)			Skill "easy","medium","hard","extreme","random"
			3 = (str,int,array)	Ai "random","unarmed" OR [0 = Assault, 1 = machinegun 2 = sniper,] OR [0-2,AT],[0-2,AA](at = anti tank, aa, anti air)
			4 = (str,array)		Ai type "bandit","special" OR ["bandit",Krypto amount],["special",krypto amount]
			5 = Mission number
			@Return
	*/

	[[
		[(_position select 0) + 25, (_position select 1) + 25, 0],
		[(_position select 0) - 25, (_position select 1) - 25, 0]
	],"O_HMG_01_high_F","Easy","bandit",_mission] call spawn_static;
	
	/**************************************** Heli ********************************************/
	/*
		@﻿Description
			Spawn heli thats fly to the mission
		@﻿Parameter
			0 = (array)			Patrol position
			1 = (array)			Start position
			2 = (int)			Radius of patrol 
			3 = (int)			Number of waypoints to give
			4 = (str)			Classname of vehicle
			5 = (str)			Skill "easy","medium","hard","extreme","random"
			6 = (str,int,array)	Ai "random","unarmed" OR [0 = Assault, 1 = machinegun 2 = sniper,] OR [0-2,AT],[0-2,AA](at = anti tank, aa, anti air)
			7 = (str,array)		Ai type "bandit","special" OR ["bandit",Krypto amount],["special",krypto amount]
			8 = Mission number
		@Return
			heli
	*/
	[
		[_position select 0,_position select 1,0],				// Position to patrol
		[0,0,0],				// Position to spawn chopper at
		200,					// Radius of patrol
		10,						// Number of waypoints to give
		"B_Heli_Light_01_EPOCH",	// Classname of vehicle (make sure it has driver and two gunners)
		"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
		"Random",				// AI CLASS
		"Bandit",				// AI Type, "Hero" or "Bandit".
		_mission
	] call heli_patrol;
	
	/**************************************** Vehicle ********************************************/
	_VehiclePosition = [_position, 700, random 360] call BIS_fnc_relPos; 
	/*
		@﻿Description
			Spawn vehicle thats drive to the mission
		@﻿Parameter
			0 = (array)			Patrol position
			1 = (array)			Start position
			2 = (int)			Radius of patrol 
			3 = (int)			Number of waypoints to give
			4 = (str)			Classname of vehicle
			5 = (str)			Skill "easy","medium","hard","extreme","random"
			6 = (str,int,array)	Ai "random","unarmed" OR [0 = Assault, 1 = machinegun 2 = sniper,] OR [0-2,AT],[0-2,AA](at = anti tank, aa, anti air)
			7 = (str,array)		Ai type "bandit","special" OR ["bandit",Krypto amount],["special",krypto amount]
			8 = Mission number
		@Return
			vehicle
	*/
	[
		[_position select 0,_position select 1,0],		// Position to patrol
		_VehiclePosition,		// Position to spawn chopper at
		300,					// Radius of patrol
		10,						// Number of waypoints to give
		"O_G_Offroad_01_armed_F",// Classname of vehicle (make sure it has driver and two gunners)
		"Random",				// Skill level of units (easy, medium, hard, extreme, Random)
		0,						// AI CLASS
		"Bandit",				// AI Type, "Hero" or "Bandit".
		_mission
	] call vehicle_patrol;
	
	/************************************************************************************/

	/*
		@﻿Description
			Run mission start, end and cleanup
		@﻿Parameter
			0 = (array)		Mission number and crate
			1 = (array)		"crate", "kill" OR ["assassinate", _unitGroup]
			2 = (array)		cleanup objects
			3 = (str)		Start message
			4 = (str)		Win message
			5 = (str)		Fail massage		
		@Return
			true or false
	*/
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"A MV22 carrying supplies has crashed and rebels are securing the site! Check your map for the location!",	// mission announcement
		"Rebels have secured the crashed MV22!",																	// mission success
		"Rebels did not secure the crashed MV22 in time"															// mission fail
	] call mission_winorfail;

	if(_complete) then {
	/*
		@﻿Description
			Spawns loot in _crate
		@﻿Parameter
			0 = (object)	Crate
			1 = (int)		Number of weapons OR [Weapon count, weapon type] TYPE: ai_assault_wep, ai_machine_wep, ai_sniper_wep
			2 = (int)		Number of Tools/item [item count, item type] TYPE: crate_tools, ai_assault_scope
			3 = (int)		Number of random items
			4 = (int)		Number of backpakcs
		@Retur
	*/
		[_crate,5,6,15,2] call dynamic_crate;
	};

	diag_log format["WAI: [Mission: MV22 Crash]: Ended at %1",mapGridPosition(_position)];
	
	b_missionsrunning = b_missionsrunning - 1;
};