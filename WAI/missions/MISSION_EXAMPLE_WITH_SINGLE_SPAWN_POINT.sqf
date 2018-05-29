// Updated single location mission example for DayZ Epoch 1.0.6+ by JasonTM. Please review missions in the hero and bandit folders for additional examples.

// Include local variables in this list
private ["_baserunover","_mission","_directions","_position","_crate","_crate_type","_num"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;

// Declare your static spawn point. You can also use static positions for your buildings, vehicles, and crate.
// Normally with the z coordinate you will just use 0 because 0 means that it is on the ground.
// Round the coordinates you get from the editor to whole numbers to make it easier. Ex. 1783.42963 is just 1783.
_position = [x, y, 0];

// If this is a hero mission use this line - delete if not
if !([_position] call wai_validSpotCheck) exitWith {h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true;};
// if this is a bandit mission use this line - delete if not
if !([_position] call wai_validSpotCheck) exitWith {b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true;};

diag_log format["WAI: Mission Test Mission started at %1",_position];

//Setup the crate
_crate_type = crates_large call BIS_fnc_selectrandom; // Choose between crates_large, crates_medium, and crates_small
_crate = createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];
_crate call wai_crate_setup; // This function wipes the crate and sets variables. It must be called.
 
// Create some Buildings with static coordinates
_baserunover0 = createVehicle ["land_fortified_nest_big",[x,y,0],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["land_fortified_nest_big",[x,y,0],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["land_fortified_nest_big",[x,y,0],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["land_fortified_nest_big",[x,y,0],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Land_Fort_Watchtower",[x,y,0],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["Land_Fort_Watchtower",[x,y,0],[], 0, "CAN_COLLIDE"];
_baserunover6 = createVehicle ["Land_Fort_Watchtower",[x,y,0],[], 0, "CAN_COLLIDE"];
_baserunover7 = createVehicle ["Land_Fort_Watchtower",[x,y,0],[], 0, "CAN_COLLIDE"];

// Adding buildings to one variable just for tidiness
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7];

// Set some directions for our buildings - This method uses the array _baserunover above and sets the direction to each element in order.
// This makes the buildings conform to the terrain
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
//				8: Mission Variable
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
_unitGroup = [[_position select 0, _position select 1, 0],1,"hard","random",4,"random","special","random","bandit",_mission] call spawn_group;

uiSleep 3; // If you are not spawning vehicles in below then you can remove this sleep. It is included to make sure the AI list has enough time to populate for the KeyonAI vehicle key option.

//Spawn vehicles Option
_vehclass = armed_vehicle call BIS_fnc_selectRandom; // selects a vehicle from an array in config.sqf. (see lines 236-242 in config.sqf for other arrays)
//_vehclass = "MV22_DZ"; You can also declare a static vehicle classname like this instead.
_vehicle = [_crate,_vehclass,_position,_mission] call custom_publish; // spawns a vehicle at a random location near the mission.
_vehicle2 = [_crate,_vehclass,[0,0,0],_mission,true] call custom_publish; // This option allows you to declare a static position.
_vehicle3 = [_crate,_vehclass,[0,0,0],_mission,true,_direction] call custom_publish; // This option allows you to declare a static position and define a direction.

// Array of mission variables to send
[
	_mission, // Mission Variable - This is a number.
	_position, // Position of mission
	"Hard", // Difficulty "Easy", "Medium", "Hard", "Extreme",
	"Name of Mission", // Name of Mission
	"MainHero", // Mission Type: MainHero or MainBandit
	true, // show mission marker?
	true, // make minefields available for this mission?
	_crate,	// crate object info
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup], : crate - you have to get within 20 meters of the crate and kill at least the number of ai defined by variable wai_kill_percent in config.sqf. kill = you have to kill all of the AI. assassinate - you have to kill a special ai (see Mayor's Mansion mission). 
	[_baserunover], // buildings to cleanup after mission is complete, does not include the crate. An array is expected. If you place the objects in an array above, then you don't need the brackets.
	"A Mission has spawned, hurry up to claim the loot!",	// mission announcement - this message displays when the mission starts
	"The mission was complete/objective reached",			// mission success - this message displays when the mission is completed by a player
	"The mission timed out and nobody was in the vicinity"	// mission fail - this message displays when a mission times out.
	[0,0,0,0,0] // Dynamic crate array. Example below.
] call mission_winorfail;

// Dynamic Crate Example
// Parameters:	0: _crate
//				1: Max number of long guns OR [MAX number of long guns,gun_array]
//				2: Max number of tools OR [MAX number of tools,tool_array]
//				3: Max number of items OR [MAX number of items,item_array]
//				4: Max number of pistols OR [MAX number of pistol,pistol_array]
//				5: Max number of backpacks OR [MAX number of backpacks,backpack_array]
//[16,[8,crate_tools_sniper],[3,crate_items_high_value],3,[4,crate_backpacks_large]] - example of calling custom arrays instead of default

