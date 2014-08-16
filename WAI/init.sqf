if(isServer) then {

	spawn_group				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_group.sqf";
	spawn_static			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_static.sqf";
	group_waypoints			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\group_waypoints.sqf";
	heli_para				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_para.sqf";
	heli_patrol				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_patrol.sqf";
	vehicle_patrol			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_patrol.sqf";

	on_kill					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\on_kill.sqf";

	ai_monitor				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_monitor.sqf";
	vehicle_monitor			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_monitor.sqf";

	createCenter			EAST;
	WEST					setFriend [EAST,0];
	EAST					setFriend [WEST,0];
	
	configloaded			= false;

	ai_ground_units			= 0;
	ai_emplacement_units	= 0;
	ai_air_units			= 0;
	ai_vehicle_units		= 0;
	
	//Load config
	ExecVM "\z\addons\dayz_server\WAI\config.sqf";

	waitUntil {configloaded};
		diag_log "WAI: AI Config File Loaded";

	if(use_blacklist) then {
		safepos				= [getMarkerPos "center",5,7000,30,0,0.5,0,blacklist];
	} else {
		safepos				= [getMarkerPos "center",0,5000,30,0,0.5,0];
	};

	[] spawn ai_monitor;

	if(static_missions) then {
		ExecVM "\z\addons\dayz_server\WAI\static\init.sqf";
	};
	
	if (ai_mission_system) then {
		ExecVM "\z\addons\dayz_server\WAI\missions\init.sqf";
	};

};