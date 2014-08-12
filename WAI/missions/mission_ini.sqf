custom_publish  				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\custom_publish_vehicle.sqf";
spawn_ammo_box 					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\box_dynamic.sqf";

MissionStartText				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\MissionWarning.sqf";
MissionEndText					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\MissionWarningEnd.sqf";

//Static Custom Boxes
Construction_Supply_Box  			= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\supplybox_construction.sqf";
Chain_Bullet_Box  				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\supplybox_chainbullets.sqf";
Medical_Supply_Box  				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\supplybox_medical.sqf";

//Static Weaponbox
Sniper_Gun_Box  				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\gunbox_sniper.sqf";
Extra_Large_Gun_Box				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\gunbox_extra_large.sqf";
Large_Gun_Box 					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\gunbox_large.sqf";
Medium_Gun_Box 					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\missions\compile\gunbox_medium.sqf";

clean_running_mission 			= false;

//load mission config
ExecVM "\z\addons\dayz_server\WAI\missions\mission_cfg.sqf";

waitUntil {WAImissionconfig};
	diag_log "WAI: Mission Config File Loaded";

ExecVM "\z\addons\dayz_server\WAI\missions\missions.sqf";
