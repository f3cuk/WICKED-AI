// Updated single location mission example for DayZ Epoch 1.0.6+ by JasonTM. Please review missions in the hero and bandit folders for additional examples.

// Include local variables in this list
private ["_messages","_missionType","_aiType","_baserunover","_mission","_directions","_position","_crate","_crate_type","_num"];

// Get mission number, important we do this early
_mission = count wai_mission_data -1;
_missionType = _this select 0; // Type of mission "MainHero" or "MainBandit"
_aiType = _this select 1; // Type of AI - opposite of mission type

// Declare your static spawn point. You can also use static positions for your buildings, vehicles, and crate.
// Normally with the z coordinate you will just use 0 because 0 means that it is on the ground.
// Round the coordinates you get from the editor to whole numbers to make it easier. Ex. 1783.42963 is just 1783.
_position = [x, y, 0];

// If this is a hero mission use this line - delete if not
if !([_position] call wai_validSpotCheck) exitWith {h_missionsrunning = h_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true;};
// if this is a bandit mission use this line - delete if not
if !([_position] call wai_validSpotCheck) exitWith {b_missionsrunning = b_missionsrunning - 1; wai_mission_data set [_mission, -1]; WAI_MarkerReady = true;};

// Sends a message to the server's rpt file
diag_log format["WAI: Mission Test Mission started at %1",_position];

// Crate Spawning Format - [loot, position, crate type(array or class name), [x-offset, y-offset,z-coordinate(optional)],direction(optional)]
// Multiple crates can be spawned. See Firestation mission for example.
// See lines 203-205 in config.sqf for crate classname arrays

// Dynamic loot array example
// Parameters:	0: _crate
//				1: Max number of long guns OR [MAX number of long guns,gun_array]
//				2: Max number of tools OR [MAX number of tools,tool_array]
//				3: Max number of items OR [MAX number of items,item_array]
//				4: Max number of pistols OR [MAX number of pistol,pistol_array]
//				5: Max number of backpacks OR [MAX number of backpacks,backpack_array]
//[16,[8,crate_tools_sniper],[3,crate_items_high_value],3,[4,crate_backpacks_large]] - example of calling custom arrays instead of default

// Save loot array to a variable
_loot = [[1,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],3,4];

//Spawn Crate with loot variable in first position.
[[
	[_loot,crates_large,[0,0]] // [loot variable, crate array, 2d offsets]
],_position,_mission] call wai_spawnCrate;

//Spawn Crate with fixed classname and loot array not previously save to variable. It works either way.
[[
	[[8,5,15,3,2],"USBasicWeaponsBox",[.3,0,-.01],30] // [[loot array, crate classname, 3d offests], direction]
],_position,_mission] call wai_spawnCrate;
 
// Mission object Spawning Format - [class name, [x-offset, y-offset,z-offset(optional)],direction(optional)]
// Offsets are modifications to the [x,y,z] coordinates relative to the [0,0,0] mission center position.
// If no z-coordinate or direction are provided, then the function will set them to 0.
_baserunover = [[
	["land_fortified_nest_big",[-40,0],90],
	["land_fortified_nest_big",[40,0],270],
	["land_fortified_nest_big",[0,-40]],
	["land_fortified_nest_big",[0,40],180],
	["Land_Fort_Watchtower",[-10,0]],
	["Land_Fort_Watchtower",[10,0],180],
	["Land_Fort_Watchtower",[0,-10],270],
	["Land_Fort_Watchtower",[0,10],90]
],_position,_mission] call wai_spawnObjects;

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
// Parameters:	0: Spawn positions
//				1: Classname ("classname" or "random" to pick from ai_static_weapons)
//				2: Unit Skill ("easy","medium","hard","extreme" or "random") ***NO effect if ai_static_skills = true;***
//				3: Skin ("Hero","bandit","random","special" or "classname")
//				4: AI Type ("bandit","Hero" or "special") ***Used to determine humanity gain or loss***
//				5: Gun (0:ai_wep_assault 1:ai_wep_machine 2:ai_wep_sniper or "random") ***NO effect if ai_static_useweapon = false;***
//				6: Magazine Count ***NO effect if ai_static_useweapon = false;***
//				7: Backpack ("random" or "classname") ***NO effect if ai_static_useweapon = false;***
//				8: Gear (0:ai_gear0, 1:ai_gear1, 2:ai_gear2, 3:ai_gear3, 4:ai_gear4 or "random") ***NO effect if ai_static_useweapon = false;***
//				9: Mission variable from line 7 (_mission)

[[
	[(_position select 0) - 10, (_position select 1) + 10, 0],
	[(_position select 0) + 10, (_position select 1) - 10, 0],
	[(_position select 0) + 10, (_position select 1) + 10, 0],
	[(_position select 0) - 10, (_position select 1) - 10, 0]
],"M2StaticMG","easy","bandit","bandit",0,2,"random","random",_mission] call spawn_static;


// Heli Paradrop Example
// Parameters:	0: Paradrop position
//				1: Trigger radius
//				2: Vehicle classname
//				3: Direction of approach for the helicopter. Options: "North","South","East","West"
//				4: Random distance from the mission the helicopter should start. [min distance, max distance].
//				5: Fly in height of the helicopter. Be careful that the height is not too low or the AI might die when they hit the ground
//				6: Time in seconds between each deployed paratrooper. Higher number means paradropped AI will be more spread apart. Time of 0 means they all jump out rapidly.
//				7: Distance from the mission the helicopter should start dropping paratroopers
//				8: Amount of paratroopers
//				9: Unit Skill ("easy","medium","hard","extreme" or "random") ***NO effect if ai_static_skills = true;***
//				10: Gun (0:ai_wep_assault 1:ai_wep_machine 2:ai_wep_sniper or "random")
//				11: Magazine Count
//				12: Backpack ("random" or "classname")
//				13: Skin ("Hero","bandit","random","special" or "classname")
//				14: Gear (0:ai_gear0, 1:ai_gear1, 2:ai_gear2, 3:ai_gear3, 4:ai_gear4 or "random")
//				15: AI Type ("bandit","Hero" or "special") ***Used to determine humanity gain or loss***
//				16: Heli stay and fight after troop deployment? (true or false)
//				17: Mission variable from line 7 (_mission)

[_position,400,"UH60M_EP1_DZE","East",[3000,4000],150,1.0,200,10,"Random","Random",4,"Random","Hero","Random","Hero",false,_mission] spawn heli_para;

// Assassination target example
// This is the same as normal group spawns but we assign it to a variable instead for use in the trigger below (if there are multiple units in this group you'll need to kill them all)
_unitGroup = [[_position select 0, _position select 1, 0],1,"hard","random",4,"random","special","random","bandit",_mission] call spawn_group;

// Spawn Mission Vehicle Example
// Parameters:	0: Classname or Array from config.sqf
//				1: Position
//				2: Mission variable
//				3: Fixed vehicle position? If false the mission will pick a random position for the vehicle
//				4: Optional direction. If no number provided the mission will select a random direction

["MV22_DZ",[(_position select 0) - 20.5,(_position select 1) - 5.2,0], _mission,true,-82.5] call custom_publish; // with declared vehicle class, optional fixed position, and optional direction
[cargo_trucks,_position,_mission] call custom_publish; // with vehicle array, random position, and random direction
_vehicle = [cargo_trucks,_position,_mission] call custom_publish; // Same as above but saved to variable if necessary

// Mission messages examples -  they go into an array
"A Mission has spawned, hurry up to claim the loot!",	// mission announcement - this message displays when the mission starts
"The mission was complete/objective reached",			// mission success - this message displays when the mission is completed by a player
"The mission timed out and nobody was in the vicinity"	// mission fail - this message displays when a mission times out.

// Example with localized message strings
_messages = if (_missionType == "MainHero") then {
	["STR_CL_HERO_MISSIONNAME_ANNOUNCE","STR_CL_HERO_MISSIONNAME_WIN","STR_CL_HERO_MISSIONNAME_FAIL"];
} else {
	["STR_CL_BANDIT_MISSIONNAME_ANNOUNCE","STR_CL_BANDIT_MISSIONNAME_WIN","STR_CL_BANDIT_MISSIONNAME_FAIL"];
};

// Array of options to send to mission_winorfail with non-localized announcements
[
	_mission, // Mission Variable - This is a number.
	_position, // Position of mission
	"Hard", // Difficulty "Easy", "Medium", "Hard", "Extreme",
	"Name of Mission", // Name of Mission
	_missionType, // Mission Type: Hero or Bandit
	true, // show mission marker?
	true, // make minefields available for this mission?
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup], : crate - you have to get within 20 meters of the crate and kill at least the number of ai defined by variable wai_kill_percent in config.sqf. kill = you have to kill all of the AI. assassinate - you have to kill a special ai (see Mayor's Mansion mission).
	_messages
] call mission_winorfail;


// Array of options to send to mission_winorfail with localized announcements. You have to create localized strings in the community stringtable for this to work
[
	_mission, // Mission number
	_position, // Position of mission
	"Hard", // Difficulty
	"Lunch break Convoy", // Name of Mission
	_missionType, // Mission Type: Hero or Bandit
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] call mission_winorfail;

