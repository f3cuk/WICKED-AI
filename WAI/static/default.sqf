if(isServer) then {


	//Custom Spawns file//
	/*
	Custom group spawns Eg.

	[
		[953.237,4486.48,0.001],			// Position
		4,									// Number Of units
		"Random",							// Skill level of unit (easy, medium, hard, extreme, Random)
		"Random",							// Primary gun set number. "Random" for random weapon set
		4,									// Number of magazines
		"Random",							// Backpack classname, use "Random" or classname here
		"Random",							// Skin classname, use "Random" or classname here
		"Random"							// Gearset number. "Random" for random gear set
	] call spawn_group;

	Place your custom group spawns below
	*/
	[
		[13726,2920.75,0.001],			// Position
		5,									// Number Of units
		"Random",							// Skill level of unit (easy, medium, hard, extreme, Random)
		"Random",							// Primary gun set number. "Random" for random weapon set
		4,									// Number of magazines
		"Random",							// Backpack classname, use "Random" or classname here
		"Random",							// Skin classname, use "Random" or classname here
		"Random",							// Gearset number. "Random" for random gear set
		"Bandit"
	] call spawn_group;
	
	[
		[13729,2946.39,0.002],			// Position
		5,									// Number Of units
		"Random",							// Skill level of unit (easy, medium, hard, extreme, Random)
		"Random",							// Primary gun set number. "Random" for random weapon set
		4,									// Number of magazines
		"Random",							// Backpack classname, use "Random" or classname here
		"Random",							// Skin classname, use "Random" or classname here
		"Random",							// Gearset number. "Random" for random gear set
		"Bandit"
	] call spawn_group;
	
	[
		[13661.6,2947.76,0.001],			// Position
		5,									// Number Of units
		"Random",							// Skill level of unit (easy, medium, hard, extreme, Random)
		"Random",							// Primary gun set number. "Random" for random weapon set
		4,									// Number of magazines
		"Random",							// Backpack classname, use "Random" or classname here
		"Random",							// Skin classname, use "Random" or classname here
		"Random",							// Gearset number. "Random" for random gear set
		"Bandit"
	] call spawn_group;
	
	

	
	//Custom static weapon spawns Eg. (with mutiple positions)

	[
	[
		[13792.5,2905.23,0.002],[13713.1,2924.95,0.001]
	], 				// Position(s) (can be multiple)
	"O_HMG_01_support_high_F", 	// Classname of turret
	"hard", 		// Skill level of unit (easy, medium, hard, extreme, Random)
	"Random", 	// Skin classname, use "Random" or classname here
	"Bandit",
	"Random", 		// Primary gun set number. "Random" for random weapon set
	2, 				// Number of magazines
	"Random",		// Backpack classname, use "Random" or classname here
	"Random" 		// Gearset classname, use "Random" or classname here
] call spawn_static;

//Place your custom static weapon spawns below
	





	/*
	Custom Chopper Patrol spawn Eg.

	[
		[725.391,4526.06,0],				// Position to patrol
		[0,0,0],							// Position to spawn chopper at
		2000,								// Radius of patrol
		10,									// Number of waypoints to give
		"UH1H_DZ",							// Classname of vehicle (make sure it has driver and two gunners)
		"Random"							// Skill level of units (easy, medium, hard, extreme, Random)
	] spawn heli_patrol;

	Place your heli patrols below
	*/

//Custom Chopper Patrol spawn Eg.
/*
	[
		[7012.58,7775.55,0],				// Position to patrol
		[0,0,0],							// Position to spawn chopper at
		4000,								// Radius of patrol
		10,									// Number of waypoints to give
		"UH1H_DZ",							// Classname of vehicle (make sure it has driver and two gunners)
		"Random",							// Skill level of units (easy, medium, hard, extreme, Random)
		"Random",							// Skin classname, use "Random" or classname here
		"Bandit"							// AI Type, "Hero" or "Bandit".
	] spawn heli_patrol;
*/


	/* 
	Custom Vehicle patrol spawns Eg. (Watch out they are stupid)

	[
		[725.391,4526.06,0],				// Position to patrol
		[725.391,4526.06,0],				// Position to spawn at
		200,								// Radius of patrol
		10,									// Number of waypoints to give
		"HMMWV_Armored",					// Classname of vehicle (make sure it has driver and gunner)
		"Random"							// Skill level of units (easy, medium, hard, extreme, Random)
	] spawn vehicle_patrol;

	Place your vehicle patrols below this line
	*/





	/*
	Paradropped unit custom spawn Eg.

	[
		[911.21545,4532.7612,2.6292224],	// Position that units will be dropped by
		[0,0,0],							// Starting position of the heli
		400,								// Radius from drop position a player has to be to spawn chopper
		"UH1H_DZ",							// Classname of chopper (Make sure it has 2 gunner seats!)
		5,									// Number of units to be para dropped
		"Random",							// Skill level of units (easy, medium, hard, extreme, Random)
		"Random",							// Primary gun set number. "Random" for random weapon set.
		4,									// Number of magazines
		"Random",							// Backpack classname, use "Random" or classname here
		"Bandit2_DZ",						// Skin classname, use "Random" or classname here
		"Random",							// Gearset number. "Random" for random gear set.
		true								// true: Aircraft will stay at position and fight. false: Heli will leave if not under fire. 
	] spawn heli_para;

	Place your paradrop spawns under this line
	*/

	//Boxes
//Bandit Supply Base
_crate = createVehicle ["C_supplyCrate_F",[13697.3,2937.91,0.001],[],0,"CAN_COLLIDE"];
_crate1 = createVehicle ["C_supplyCrate_F",[13711.3,2943.25,0.001],[],0,"CAN_COLLIDE"];
[_crate,[2,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],4] call dynamic_crate;
[_crate1,[16,ai_wep_sniper],[8,crate_tools_sniper],[3,crate_items_high_value],[4,crate_backpacks_large]] call dynamic_crate;
	
	
	
	
	
	
	
	diag_log format["WAI: Static mission for %1 loaded", missionName];

};