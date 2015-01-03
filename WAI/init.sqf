if(isServer) then {

	spawn_group				= compile preprocessFileLineNumbers "\a3\wai\compile\spawn_group.sqf";
	spawn_static			= compile preprocessFileLineNumbers "\a3\wai\compile\spawn_static.sqf";
	group_waypoints			= compile preprocessFileLineNumbers "\a3\wai\compile\group_waypoints.sqf";
	heli_para				= compile preprocessFileLineNumbers "\a3\wai\compile\heli_para.sqf";
	heli_patrol				= compile preprocessFileLineNumbers "\a3\wai\compile\heli_patrol.sqf";
	vehicle_patrol			= compile preprocessFileLineNumbers "\a3\wai\compile\vehicle_patrol.sqf";

	on_kill					= compile preprocessFileLineNumbers "\a3\wai\compile\on_kill.sqf";

	ai_monitor				= compile preprocessFileLineNumbers "\a3\wai\compile\ai_monitor.sqf";
	vehicle_monitor			= compile preprocessFileLineNumbers "\a3\wai\compile\vehicle_monitor.sqf";
	find_position			= compile preprocessFileLineNumbers "\a3\wai\compile\find_position.sqf";

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
	ExecVM "\a3\wai\config.sqf";
	
	waitUntil {configloaded};
		diag_log "wai: AI Config File Loaded";

	[] spawn ai_monitor;

	if(static_missions) then {
		ExecVM "\a3\wai\static\init.sqf";
	};
	
	if (wai_mission_system) then {
		ExecVM "\a3\wai\missions\init.sqf";
	};

};
