if(isServer) then {
	cache_units				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\cache_units.sqf";
	spawn_group				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_group.sqf";
	spawn_static			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_static.sqf";
	group_waypoints			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\group_waypoints.sqf";
	heli_para				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_para.sqf";
	heli_patrol				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_patrol.sqf";
	vehicle_patrol			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_patrol.sqf";

	on_kill					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\on_kill.sqf";
	hero_behaviour			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\hero_behaviour.sqf";
	bandit_behaviour		= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\bandit_behaviour.sqf";

	dynamic_crate 			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\dynamic_crate.sqf";

	ai_monitor				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_monitor.sqf";
	vehicle_monitor			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_monitor.sqf";
	find_position			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\find_position.sqf";
	load_ammo				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\load_ammo.sqf";

	call 					compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\functions.sqf";

	if(isNil("DZMSInstalled")) then {

		createCenter			EAST;
		createCenter			RESISTANCE;
	
		WEST					setFriend [EAST,0];
		WEST					setFriend [RESISTANCE,0];
	
		EAST					setFriend [WEST,0];
		EAST					setFriend [RESISTANCE,0];
		
		RESISTANCE				setFriend [EAST,0];
		RESISTANCE				setFriend [WEST,0];

	} else {
	
		createCenter			RESISTANCE;
		
		EAST					setFriend [RESISTANCE,0];
		WEST					setFriend [RESISTANCE,0];
		
		RESISTANCE				setFriend [EAST,0];
		RESISTANCE				setFriend [WEST,0];	
	};
	
	wai_staticloaded 		= false;
	WAIconfigloaded			= false;
	WAIcustomConfigloaded = false;

	ai_ground_units			= 0;
	ai_emplacement_units	= 0;
	ai_air_units			= 0;
	ai_vehicle_units		= 0;
	
	//Load config
	ExecVM "\z\addons\dayz_server\WAI\config.sqf";
	waitUntil {WAIconfigloaded};
	diag_log "WAI: AI Config File Loaded";
	if (use_staticspawnpoints) then {
		ExecVM "\z\addons\dayz_server\WAI\configs\spawnpoints.sqf";
	};
	if (use_blacklist) then {
		ExecVM "\z\addons\dayz_server\WAI\configs\blacklist.sqf";
	};
	if ((preProcessFileLineNumbers ("\z\addons\dayz_server\WAI\customsettings.sqf")) != "") then {
		ExecVM "\z\addons\dayz_server\WAI\customsettings.sqf";
		waitUntil {WAIcustomConfigloaded};
		diag_log "WAI: Custom Config File Loaded";
	};
	[] spawn ai_monitor;

	if(static_missions) then {
		ExecVM "\z\addons\dayz_server\WAI\static\init.sqf";
		waitUntil {wai_staticloaded};
	};
	
	// ---------------------------------------------------------------------------
	// :: IWAC conditional loading
	// :: If you want to run default WAI without addon, just set 'iben_wai_ACuseAddon'
	// :: to false ('WAI\customsettings.sqf') - nothing more is needed!
	if (wai_mission_system) then {
		if (WAIcustomConfigloaded && {iben_wai_ACuseAddon}) then {
			[] execVM format ["%1\addons\IWAC\init.sqf",WAIROOT];
		} else {
			ExecVM "\z\addons\dayz_server\WAI\missions\init.sqf";
		};
	};
  // ---------------------------------------------------------------------------

};
