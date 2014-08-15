if(isServer) then {

	private["_starTime","_result","_cnt","_currTime","_mission"];

	diag_log "WAI: Initialising missions";

	custom_publish  				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\custom_publish_vehicle.sqf";
	spawn_ammo_box 					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\box_dynamic.sqf";

	//Static Custom Boxes
	Construction_Supply_Box  		= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\supplybox_construction.sqf";
	Chain_Bullet_Box  				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\supplybox_chainbullets.sqf";
	Medical_Supply_Box  			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\supplybox_medical.sqf";

	//Static Weaponbox
	Sniper_Gun_Box  				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\gunbox_sniper.sqf";
	Extra_Large_Gun_Box				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\gunbox_extra_large.sqf";
	Large_Gun_Box 					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\gunbox_large.sqf";
	Medium_Gun_Box 					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\gunbox_medium.sqf";

	//Event handlers
	mission_succes					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\mission_succes.sqf";
	mission_failure					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\mission_failure.sqf";
	mission_time					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\mission_type.sqf";

	tank_traps						= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\tank_traps.sqf";

	clean_running_mission 			= false;
	markerready 					= true;
	missionrunning 					= false;
	_startTime 						= floor(time);
	_result 						= 0;

	while {true} do
	{
	
		_cnt 		= {alive _x} count playableUnits;
		_currTime 	= floor(time);

		if((_currTime - _startTime >= wai_mission_timer) && (!missionrunning)) then {
			_result = 1
		};
		
		if(missionrunning) then {
			_startTime = floor(time);
		};
		
		if((_result == 1) && (_cnt >= wai_players_online) && (markerready) && ((diag_fps) >= wai_server_fps)) then {

			clean_running_mission	= false;
			ai_roadkills			= 0;

			_mission 				= wai_missions call BIS_fnc_selectRandom;

			execVM format ["\z\addons\dayz_server\WAI\missions\%1.sqf",_mission];

			missionrunning 	= true;
			_startTime 		= floor(time);
			_result 		= 0;

			diag_log format["WAI: Starting mission %1",_mission];

		} else {

			sleep 60;

		};

	};

};