if(isServer) then {
	sleep 90;
	spawn_group				= compile preprocessFileLineNumbers "\x\addons\WAI\compile\spawn_group.sqf";
	spawn_soldier			= compile preprocessFileLineNumbers "\x\addons\WAI\compile\spawn_soldier.sqf";
	spawn_static			= compile preprocessFileLineNumbers "\x\addons\WAI\compile\spawn_static.sqf";
	group_waypoints			= compile preprocessFileLineNumbers "\x\addons\WAI\compile\group_waypoints.sqf";
	heli_para				= compile preprocessFileLineNumbers "\x\addons\WAI\compile\heli_para.sqf";
	heli_patrol				= compile preprocessFileLineNumbers "\x\addons\WAI\compile\heli_patrol.sqf";
	vehicle_patrol			= compile preprocessFileLineNumbers "\x\addons\WAI\compile\vehicle_patrol.sqf";

	on_kill					= compile preprocessFileLineNumbers "\x\addons\WAI\compile\on_kill.sqf";
	bandit_behaviour		= compile preprocessFileLineNumbers "\x\addons\WAI\compile\bandit_behaviour.sqf";

	dynamic_crate 			= compile preprocessFileLineNumbers "\x\addons\WAI\compile\dynamic_crate.sqf";

	ai_monitor				= compile preprocessFileLineNumbers "\x\addons\WAI\compile\ai_monitor.sqf";
	vehicle_monitor			= compile preprocessFileLineNumbers "\x\addons\WAI\compile\vehicle_monitor.sqf";
	find_position			= compile preprocessFileLineNumbers "\x\addons\WAI\compile\find_position_new.sqf";
	load_ammo				= compile preprocessFileLineNumbers "\x\addons\WAI\compile\load_ammo.sqf";

	call 					compile preprocessFileLineNumbers "\x\addons\WAI\compile\functions.sqf";
	/*
		We use epoch default createCenter and SetFriend settings
		RESISTANCE setFriend[WEST,0];
		WEST setFriend[RESISTANCE,0];
		RESISTANCE setFriend[EAST,0];
		EAST setFriend[RESISTANCE,0];
		EAST setFriend[WEST,1];
		WEST setFriend[EAST,1];
	*/
	wai_staticloaded 		= false;
	WAIconfigloaded			= false;

	ai_ground_units			= 0;
	ai_emplacement_units	= 0;
	ai_air_units			= 0;
	ai_vehicle_units		= 0;
	
	//Load config
	ExecVM "\x\addons\WAI\config.sqf";
	waitUntil {WAIconfigloaded};
	if ((preProcessFileLineNumbers ("\x\addons\WAI\customsettings.sqf")) != "") then {
		ExecVM "\x\addons\WAI\customsettings.sqf";
		diag_log "WAI: Custom Config File Loaded";
	};
	diag_log "WAI: AI Config File Loaded";

	[] spawn ai_monitor;

	if(static_missions) then {
		ExecVM "\x\addons\WAI\static\init.sqf";
		waitUntil {wai_staticloaded};
	};
	
	if (wai_mission_system) then {
		ExecVM "\x\addons\WAI\missions\init.sqf";
	};

};
