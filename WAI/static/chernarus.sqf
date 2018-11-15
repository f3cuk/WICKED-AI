//Custom Spawns file//

// These custom spawns are for use in static mission locations. You can set markers in mission.sqm if you want them.

/*
Custom group spawns Eg.

[
	[953.237,4486.48,0.001],		// Position
	4,								// Number Of units
	"Random",						// Skill level of unit (easy, medium, hard, extreme, Random)
	"Random", or ["Random","at"],	// Primary gun set number and rocket launcher. "Random" for random weapon set, "at" for anti-tank, "aa" for anti-air launcher
	4,								// Number of magazines
	"Random",						// Backpack classname, use "Random" or classname here
	"Random",						// Skin classname, use "Random" or classname here
	"Random",						// Gearset number. "Random" for random gear set
	"Bandit"						// AI Type, "Hero" or "Bandit".
] call spawn_group;

Place your custom group spawns below
*/





/*
Custom static weapon spawns Eg. (with multiple positions)

[
	[								// Position(s) (can be multiple)
		[911.21,4532.76,2.62],
		[921.21,4542.76,2.62]
	],
	"M2StaticMG",					// Classname of turret
	"easy",							// Skill level of unit (easy, medium, hard, extreme, Random)
	"Bandit2_DZ",					// Skin classname, use "Random" or classname here
	"Bandit",						// AI Type, "Hero" or "Bandit".
	"Random",						// Primary gun set number. "Random" for random weapon set
	2,								// Number of magazines
	"Random",						// Backpack classname, use "Random" or classname here
	"Random"						// Gearset classname, use "Random" or classname here
] call spawn_static;

Place your custom static weapon spawns below
*/





/*
Custom Chopper Patrol spawn Eg.

[
	[725.391,4526.06,0],			// Position to patrol
	700,							// Radius of patrol
	10,								// Number of waypoints to give
	"UH1H_DZ",						// Classname of vehicle (make sure it has driver and two gunners)
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",						// Skin classname, use "Random" or classname here
	"Bandit"						// AI Type, "Hero" or "Bandit".
] call heli_patrol;


Place your heli patrols below
*/





/* 
Custom Vehicle patrol spawns Eg. (Watch out they are stupid)

[
	[725.391,4526.06,0],			// Position to patrol
	[725.391,4526.06,0],			// Position to spawn at
	200,							// Radius of patrol
	10,								// Number of waypoints to give
	"HMMWV_Armored",				// Classname of vehicle (make sure it has driver and gunner)
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",						// Skin classname, use "Random" or classname here
	"Bandit"						// AI Type, "Hero" or "Bandit".
] call vehicle_patrol;

Place your vehicle patrols below this line
*/




/* 
Custom Boat patrol spawns

[
	[725.391,4526.06,0],			// Position to patrol
	[725.391,4526.06,0],			// Position to spawn at
	150,							// Radius of patrol. Your spawn point should be at least this distance from shore.
	10,								// Number of waypoints to give
	"RHIB",							// Classname of armed boat (make sure it has driver and gunner)
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",						// Skin classname, use "Random" or classname here
	"Bandit"						// AI Type, "Hero" or "Bandit".
] call vehicle_patrol;

Place your boat patrols below this line
*/





/* Uncomment this section for Skalisty Island Boat Patrols
[
	[13117.2,2866.65,0],			// Position to patrol
	[13117.2,2866.65,0],			// Position to spawn at, can be same as patrol location
	150,							// Radius of patrol
	10,								// Number of waypoints to give
	"RHIB",							// Classname of armed boat (make sure it has driver and gunner)
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",						// Skin classname, use "Random" or classname here
	"Bandit"						// AI Type, "Hero" or "Bandit".
] call vehicle_patrol;

[
	[13552.5,2566.86,0],			// Position to patrol
	[13552.5,2566.86,0],			// Position to spawn at, can be same as patrol location
	150,							// Radius of patrol
	10,								// Number of waypoints to give
	"RHIB",							// Classname of armed boat (make sure it has driver and gunner)
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",						// Skin classname, use "Random" or classname here
	"Bandit"						// AI Type, "Hero" or "Bandit".
] call vehicle_patrol;

[
	[13908.3,3259.23,0],			// Position to patrol
	[13908.3,3259.23,0],			// Position to spawn at, can be same as patrol location
	150,							// Radius of patrol
	10,								// Number of waypoints to give
	"RHIB",							// Classname of armed boat (make sure it has driver and gunner)
	"Random",						// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",						// Skin classname, use "Random" or classname here
	"Bandit"						// AI Type, "Hero" or "Bandit".
] call vehicle_patrol;
*/

/*
Paradropped unit custom spawn Eg.

[
	[911.21545,4532.7612,2.6292224],	// Position that units will be dropped by
	400,								// Radius from drop position a player has to be to spawn chopper
	"UH1H_DZ",							// Classname of chopper (Make sure it has 2 gunner seats!)
	"North",							// Direction of approach for the helicopter. Options: "North","South","East","West"
	[3000,4000],						// Random distance from the mission the helicopter should start. [min distance, max distance].
	150,								// Fly in height of the helicopter. Be careful that the height is not too low or the AI might die when they hit the ground
	1.0,								// Time in seconds between each deployed paratrooper. Higher number means paradropped AI will be more spread apart. Time of 0 means they all jump out rapidly.
	200,								// Distance from the mission the helicopter should start dropping paratroopers
	5,									// Number of units to be para dropped
	"Random",							// Skill level of units (easy, medium, hard, extreme, Random)
	"Random",	or ["Random","at"],		// Primary gun set number and rocket launcher. "Random" for random weapon set, "at" for anti-tank, "aa" for anti-air launcher
	4,									// Number of magazines
	"Random",							// Backpack classname, use "Random" or classname here
	"Bandit2_DZ",						// Skin classname, use "Random" or classname here
	"Random",							// Gearset number. "Random" for random gear set.
	"Bandit",							// AI Type, "Hero" or "Bandit".
	true								// true: Aircraft will stay at position and fight. false: Heli will leave if not under fire. 
] spawn heli_para;

Place your paradrop spawns under this line
*/




/* Custom Crate Spawns

_position = [911.21545,4532.7612,0]; // Position of the crate

_loot = 
[
	0, // Max number of long guns OR [MAX number of long guns,gun_array]
	0, // Max number of tools OR [MAX number of tools,tool_array]
	0, // Max number of items OR [MAX number of items,item_array]
	0, // Max number of pistols OR [MAX number of pistol,pistol_array]
	0 // Max number of backpacks OR [MAX number of backpacks,backpack_array]
];

// Spawn one crate - Best option for static positions because offsets are not needed.
[[
	[_loot,crates_large,[0,0]] // [loot variable, crate array, 2d offsets]
],_position] call wai_spawnCrate;


// Multiple crate spawning option
[[
	[_loot,"USVehicleBox",[0,0]], // [loot variable, crate classname, 2d offsets]
	[[0,0,[3,crate_items_crop_raider],0,0],crates_large,[0,0,0]], // [loot variable, crate array, 3d offsets]
	[[0,0,0,0,0],crates_large,[0,0],60] // [loot array, crate array, 2d offsets, optional direction]
],_position] call wai_spawnCrate;

Place your crate spawns under this line
*/




diag_log format["WAI: Static mission for %1 loaded", missionName];
