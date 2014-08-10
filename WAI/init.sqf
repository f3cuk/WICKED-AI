if(isServer) then {

	spawn_group				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_group.sqf";
	group_waypoints			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\patrol.sqf";
	spawn_static			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_static.sqf";
	heli_para				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_para.sqf";
	heli_patrol				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_patrol.sqf";
	vehicle_patrol			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_patrol.sqf";

	on_kill					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_killed.sqf";

	ai_monitor				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_monitor.sqf";
	veh_monitor				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_monitor.sqf";

	createCenter			EAST;
	WEST					setFriend [EAST,0];
	EAST					setFriend [WEST,0];
	safepos					= [[6326.4805,304.99265,7809.4888],1000,5000,10,0,20,0];
	WAIconfigloaded			= false;
	WAImissionconfig		= false;

	ai_ground_units			= 0;
	ai_emplacement_units	= 0;
	ai_air_units			= 0;
	ai_vehicle_units		= 0;

	//Load config
	ExecVM "\z\addons\dayz_server\WAI\ai_config.sqf";
	waitUntil {WAIconfigloaded};
		diag_log "WAI: AI Config File Loaded";

	[] spawn ai_monitor;

	//Load custom spawns
		ExecVM "\z\addons\dayz_server\WAI\custom_spawns.sqf";

	if (ai_mission_system) then {
		ExecVM "\z\addons\dayz_server\WAI\missions\mission_ini.sqf";
	};

};
