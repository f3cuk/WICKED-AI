waitUntil{uiSleep 1; initialized};

WAI_Overpoch = isClass (configFile >> "CfgWeapons" >> "USSR_cheytacM200");

// Compile all Functions
spawn_group = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_group.sqf";
spawn_static = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_static.sqf";
group_waypoints = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\group_waypoints.sqf";
heli_para = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_para.sqf";
heli_patrol = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_patrol.sqf";
vehicle_patrol = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_patrol.sqf";
on_kill = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\on_kill.sqf";
dynamic_crate = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\dynamic_crate.sqf";
static_spawn_manager = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\static_spawn_manager.sqf";
find_position = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\find_position.sqf";
load_ammo = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\load_ammo.sqf";
patrol_winorfail = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\patrol_winorfail.sqf";
mission_winorfail = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\mission_winorfail.sqf";
minefield = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\minefield.sqf";
custom_publish = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\custom_publish_vehicle.sqf";
wai_spawnObjects = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_objects.sqf";
wai_air_drop = compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\airdrop_winorfail.sqf";

call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\position_functions.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\functions.sqf";

if(isNil("DZMSInstalled")) then {

	createCenter EAST;
	createCenter RESISTANCE;

	WEST setFriend [EAST,0];
	WEST setFriend [RESISTANCE,0];

	EAST setFriend [WEST,0];
	EAST setFriend [RESISTANCE,0];
	
	RESISTANCE setFriend [EAST,0];
	RESISTANCE setFriend [WEST,0];

} else {

	createCenter RESISTANCE;
	
	EAST setFriend [RESISTANCE,0];
	WEST setFriend [RESISTANCE,0];
	
	RESISTANCE setFriend [EAST,0];
	RESISTANCE setFriend [WEST,0];	
};

wai_staticloaded = false;
WAIconfigloaded	= false;
wai_markedPos = [];
wai_static_data = [0,[],[],[]]; // [AI Count, UnitGroups, Vehicles to Monitor, Crates]

ExecVM "\z\addons\dayz_server\WAI\config.sqf";
waitUntil {WAIconfigloaded};

diag_log "WAI: AI Config File Loaded";

if (WAI_Overpoch) then {
	ExecVM "\z\addons\dayz_server\WAI\configs\overwatch.sqf";
};

if (wai_user_spawnpoints) then {
	ExecVM "\z\addons\dayz_server\WAI\configs\spawnpoints.sqf";
};

if (wai_use_blacklist) then {
	ExecVM "\z\addons\dayz_server\WAI\configs\blacklist.sqf";
};

if(wai_static_missions) then {
	ExecVM "\z\addons\dayz_server\WAI\static\init.sqf";
	waitUntil {wai_staticloaded};
};

if (wai_mission_system) then {
	ExecVM "\z\addons\dayz_server\WAI\missions\init.sqf";
};
