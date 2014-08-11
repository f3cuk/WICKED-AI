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
	blackslistpos			= [[[5533.00,8445.00],[6911.00,7063.00]]]; // [LEFT TOP COORDS, BOTTOM RIGHT RIGHT] - Currently set @ stary. Multiple area's possible.
	
	if(use_blacklist) then {
		safepos				= [getMarkerPos "center",0,6000,0,0,40,0];
	} else {
		safepos				= [getMarkerPos "center",0,6000,0,0,40,0,blackslistpos];
	};
	
	/*
		Test blacklist settings
	 
		for "_i" from 1 to 100 do {
		
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
