if(isServer) then {

	spawn_group				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_group.sqf";
	spawn_static			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\spawn_static.sqf";
	group_waypoints			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\group_waypoints.sqf";
	heli_para				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_para.sqf";
	heli_patrol				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\heli_patrol.sqf";
	vehicle_patrol			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_patrol.sqf";

	on_kill					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\on_kill.sqf";

	dynamic_crate 			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\dynamic_crate.sqf";

	ai_monitor				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\ai_monitor.sqf";
	vehicle_monitor			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\vehicle_monitor.sqf";
	find_position			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\find_position.sqf";

	call 					compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\functions.sqf";

	createCenter			EAST;
	createCenter			RESISTANCE;

	WEST					setFriend [EAST,0];
	WEST					setFriend [RESISTANCE,0];

	EAST					setFriend [WEST,0];
	EAST					setFriend [RESISTANCE,0];
	
	RESISTANCE				setFriend [EAST,0];
	RESISTANCE				setFriend [WEST,0];

	configloaded			= false;

	ai_ground_units			= 0;
	ai_emplacement_units	= 0;
	ai_air_units			= 0;
	ai_vehicle_units		= 0;
	
	//Load config
	ExecVM "\z\addons\dayz_server\WAI\config.sqf";
	
	if ((preProcessFileLineNumbers ("\z\addons\dayz_server\WAI\customsettings.sqf")) != "") then {
+		ExecVM "\z\addons\dayz_server\WAI\customsettings.sqf";
+		diag_log "WAI: Custom Config File Loaded";
+	};

	waitUntil {configloaded};
		diag_log "WAI: AI Config File Loaded";

	[] spawn ai_monitor;

	if(static_missions) then {
		ExecVM "\z\addons\dayz_server\WAI\static\init.sqf";
	};
	
	if (wai_mission_system) then {
		ExecVM "\z\addons\dayz_server\WAI\missions\init.sqf";
	};

};
