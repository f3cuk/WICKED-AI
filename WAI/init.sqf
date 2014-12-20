if(isServer) then {

	spawn_group				= compile preprocessFileLineNumbers "\WAI\compile\spawn_group.sqf";
	spawn_static			= compile preprocessFileLineNumbers "\WAI\compile\spawn_static.sqf";
	group_waypoints			= compile preprocessFileLineNumbers "\WAI\compile\group_waypoints.sqf";
	heli_para				= compile preprocessFileLineNumbers "\WAI\compile\heli_para.sqf";
	heli_patrol				= compile preprocessFileLineNumbers "\WAI\compile\heli_patrol.sqf";
	vehicle_patrol			= compile preprocessFileLineNumbers "\WAI\compile\vehicle_patrol.sqf";

	on_kill					= compile preprocessFileLineNumbers "\WAI\compile\on_kill.sqf";

	ai_monitor				= compile preprocessFileLineNumbers "\WAI\compile\ai_monitor.sqf";
	vehicle_monitor			= compile preprocessFileLineNumbers "\WAI\compile\vehicle_monitor.sqf";
	find_position			= compile preprocessFileLineNumbers "\WAI\compile\find_position.sqf";

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
	ExecVM "\WAI\config.sqf";
	//ExecVM "\z\addons\dayz_server\WAI\configOverpoch.sqf";

	waitUntil {configloaded};
		diag_log "WAI: AI Config File Loaded";

	[] spawn ai_monitor;

	if(static_missions) then {
		ExecVM "\WAI\static\init.sqf";
	};
	
	if (wai_mission_system) then {
		ExecVM "\WAI\missions\init.sqf";
	};

};
