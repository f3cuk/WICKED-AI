if(isServer) then {
	 
	private 		["_baserunover","_mission","_directions","_position","_crate","_crate_type","_num"];

	// Get a safe position 80 meters from the nearest object
	_position		= [80] call find_position;
	
	// Initialise the mission variable with the following options, [position, difficulty, mission name, mission type (MainHero/Mainbandit), minefield (true or false)] call mission_init;
	[_mission,_position,"hard","Test Mission","MainHero",true] call mission_init;

	diag_log 		format["WAI: Mission Test Mission started at %1",_position];

	//Setup the crate
	_crate_type 	= crates_large call BIS_fnc_selectrandom; // Choose between crates_large, crates_medium and crates_small
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];

	// Crate Spawn Example
	// Parameters:	0: _crate
	//				1: Max number of guns OR [MAX number of guns,gun_array]
	//				2: Max number of tools OR [MAX number of tools,tool_array]
	//				3: Max number of items OR [MAX number of items,item_array]
	//				4: Max number of backpacks OR [MAX number of backpacks,backpack_array]
	[_crate,16,[8,crate_tools_sniper],[3,crate_items_high_value],[4,crate_backpacks_large]] call dynamic_crate;
	 
	// Create some Buildings
	_baserunover0 	= createVehicle ["land_fortified_nest_big",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover1 	= createVehicle ["land_fortified_nest_big",[(_position select 0) + 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover2 	= createVehicle ["land_fortified_nest_big",[(_position select 0), (_position select 1) - 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover3 	= createVehicle ["land_fortified_nest_big",[(_position select 0), (_position select 1) + 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover4 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0) - 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover5 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0) + 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover6 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0), (_position select 1) - 10,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover7 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0), (_position select 1) + 10,-0.2],[], 0, "CAN_COLLIDE"];
	
	// Adding buildings to one variable just for tidiness
	_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7];
	
	// Set some directions for our buildings
	_directions = [90,270,0,180,0,180,270,90];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;

	// Make buildings flat on terrain surface
	{ _x setVectorUp surfaceNormal position _x; } count _baserunover;

	// Group Spawn Examples
	// Parameters:	0: Position
	//				1: Unit Count
	//				2: Unit Skill ("easy","medium","hard","extreme" or "random")
	//				3: Guns (gun or [gun,launcher])
	//					Guns options	: (0 = ai_wep_assault, 1 = ai_wep_machine, 2 = ai_wep_sniper, "random" = random weapon, "Unarmed" = no weapon)
	//					Launcher options: (at = ai_wep_launchers_AT, aa = ai_wep_launchers_AA or "classname")
	//				4: Magazine Count
	//				5: Backpack ("random" or "classname")
	//				6: Skin ("Hero","bandit","random","special" or "classname")
	//				7: Gear (0:ai_gear0, 1:ai_gear1, 2:ai_gear2, 3:ai_gear3, 4:ai_gear4 or "random")
	//				8: AI Type ("bandit","Hero","special" or ["type", #] format to overwrite default gain amount) ***Used to determine humanity gain or loss***
	//				9: Mission variable from line 9 (_mission)
	_num = round (random 3) + 4;
	[[_position select 0, _position select 1, 0],_num,"extreme",["random","at"],4,"random","bandit","random",["bandit",150],_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"hard","random",4,"random","bandit","random","bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"random","random",4,"random","bandit","random","bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"random","random",4,"random","bandit","random","bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"random","random",4,"random","bandit","random","bandit",_mission] call spawn_group;


	// Humvee Patrol Example
	// Parameters:	0: Patrol position
	//				1: Starting position
	//				2: Patrol radius
	//				3: Number of Waypoints
	//				4: Vehicle classname
	//				5: Unit Skill ("easy","medium","hard","extreme" or "random")
	//				6: Skin ("Hero","bandit","random","special" or "classname")
	//				7: AI Type ("bandit","Hero" or "special") ***Used to determine humanity gain or loss***
	//				8: Mission variable from line 9 (_mission)
	[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","random","bandit","bandit",_mission] call vehicle_patrol;
	 
	// Static Turret Examples
	// Parameters:	0: Spawn position
	//				1: Classname ("classname" or "random" to pick from ai_static_weapons)
	//				2: Unit Skill ("easy","medium","hard","extreme" or "random") ***NO effect if ai_static_skills = true;***
	//				3: Skin ("Hero","bandit","random","special" or "classname")
	//				4: AI Type ("bandit","Hero" or "special") ***Used to determine humanity gain or loss***
	//				5: Gun (0:ai_wep_assault 1:ai_wep_machine 2:ai_wep_sniper or "random") ***NO effect if ai_static_useweapon = false;***
	//				6: Magazine Count ***NO effect if ai_static_useweapon = false;***
	//				7: Backpack ("random" or "classname") ***NO effect if ai_static_useweapon = false;***
	//				8: Gear (0:ai_gear0, 1:ai_gear1, 2:ai_gear2, 3:ai_gear3, 4:ai_gear4 or "random") ***NO effect if ai_static_useweapon = false;***
	//				9: Mission variable from line 9 (_mission)
	};
	[[[(_position select 0) - 10, (_position select 1) + 10, 0]],"M2StaticMG","easy","bandit","bandit",0,2,"random","random",_mission] call spawn_static;
	[[[(_position select 0) + 10, (_position select 1) - 10, 0]],"M2StaticMG","easy","bandit","bandit",0,2,"random","random",_mission] call spawn_static;
	[[[(_position select 0) + 10, (_position select 1) + 10, 0]],"M2StaticMG","easy","bandit","bandit",0,2,"random","random",_mission] call spawn_static;
	[[[(_position select 0) - 10, (_position select 1) - 10, 0]],"M2StaticMG","easy","bandit","bandit",0,2,"random","random",_mission] call spawn_static;

	// Heli Paradrop Example
	// Parameters:	0: Paradrop position
	//				1: Spawn position
	//				2: Trigger radius
	//				3: Vehicle classname
	//				4: Amount of paratroopers
	//				5: Unit Skill ("easy","medium","hard","extreme" or "random") ***NO effect if ai_static_skills = true;***
	//				6: Gun (0:ai_wep_assault 1:ai_wep_machine 2:ai_wep_sniper or "random")
	//				7: Magazine Count
	//				8: Backpack ("random" or "classname")
	//				9: Skin ("Hero","bandit","random","special" or "classname")
	//				10: Gear (0:ai_gear0, 1:ai_gear1, 2:ai_gear2, 3:ai_gear3, 4:ai_gear4 or "random")
	//				11: AI Type ("bandit","Hero" or "special") ***Used to determine humanity gain or loss***
	//				12: Heli stay and fight after troop deployment? (true or false)
	//				13: Mission variable from line 9 (_mission)
	[[(_position select 0), (_position select 1), 0],[0,0,0],400,"UH1H_DZ",10,"random","random",4,"random","bandit","random","bandit",true,_mission] spawn heli_para;

	// Assassination target example
	// This is the same as normal group spawns but we assign it to a variable instead for use in the trigger below (if there are multiple units in this group you'll need to kill them all)
	_assassinate = [[_position select 0, _position select 1, 0],1,"hard","random",4,"random","special","random","bandit",_mission] call spawn_group;

	// Mission objective options and messages
	[
		[_mission,_crate],	// mission variable (from line 9) and crate
		["crate"], 			// Mission objective type (["crate"], or ["kill"], or ["assassinate", _assassinate])
		[_baserunover], 	// buildings to cleanup after mission is complete, does not include the crate
		"A Mission has spawned, hurry up to claim the loot!",	// mission announcement
		"The mission was complete/objective reached",			// mission success
		"The mission timed out and nobody was in the vicinity"	// mission fail
	] call mission_winorfail;

	// End of mission
	diag_log format["WAI: Mission bandit base ended at %1 ended",_position];

	h_missionsrunning = h_missionsrunning - 1;
};