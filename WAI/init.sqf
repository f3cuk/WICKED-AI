if(isServer) then {

	custom_spawns			= false;
	use_blacklist			= true;

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
	
	// Make AI Hostile to Zeds
	EAST 					setFriend [CIVILIAN,0];
	CIVILIAN 				setFriend [EAST,0];

	blackslist				= [
		[[5533.00,8445.00],[6911.00,7063.00]],	// Stary
		[[0,16000,0],[1000,-0,0]],				// Left
		[[0,16000,0],[16000.0,14580.3,0]]		// Top
	];
	
	if(use_blacklist) then {
		safepos				= [getMarkerPos "center",5,7000,30,0,1.1,0,blackslist];
	} else {
		safepos				= [getMarkerPos "center",0,5000,30,0,1.1,0];
	};
	
	/*
		Test blacklist settings
		This will spawn 2000 markers on server start that will give you a general idea of where the mission will spawn

	for "_i" from 1 to 2000 do {
	
		_position = safepos call BIS_fnc_findSafePos;
		
		_marker 		= createMarker [format["Mission_%1",_i], _position];
		_marker 		setMarkerColor "ColorRed";
		_marker 		setMarkerShape "ELLIPSE";
		_marker 		setMarkerBrush "Solid";
		_marker 		setMarkerSize [300,300];
		
	};

	*/
	
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

	//Load custom spawns]
	if(custom_spawns) then {
		ExecVM "\z\addons\dayz_server\WAI\custom_spawns.sqf";
	};
	
	if (ai_mission_system) then {
		ExecVM "\z\addons\dayz_server\WAI\missions\mission_ini.sqf";
	};

};
