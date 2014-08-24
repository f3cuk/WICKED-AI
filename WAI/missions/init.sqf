if(isServer) then {

	private["_h_startTime","_b_startTime","_result","_cnt","_currTime","_mission"];

	diag_log "WAI: Initialising missions";

	call compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\mission_functions.sqf";

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

	init_mission					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\init_mission.sqf";
	mission_winorfail				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\mission_winorfail.sqf";
	tank_traps						= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\tank_traps.sqf";
	minefield						= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\minefield.sqf";
	
	{ wai_mission_markers set [count wai_mission_markers, _x]; } count ["MainHero","MainBandit","Side1Hero","Side1Bandit","Side2Hero","Side2Bandit","SideSpecial"];
	markerready 					= true;
	wai_mission_data				= [];
	wai_hero_mission				= [];
	wai_bandit_mission				= [];
	wai_special_mission				= [];
	h_missionrunning				= false;
	b_missionrunning				= false;
	s_missionrunning				= false;
	_h_startTime 					= floor(time);
	_b_startTime 					= floor(time);
	_s_startTime					= floor(time);
	_h_missionTime					= nil;
	_b_missionTime					= nil;
	_s_missionTime					= nil;
	_mission						= "";
	_result 						= 0;

	// Set mission frequencies from config
	{
		for "_i" from 1 to (_x select 1) do {
			wai_hero_mission set [count wai_hero_mission, _x select 0];
		};
	} count wai_hero_missions;

	{
		for "_i" from 1 to (_x select 1) do {
			wai_bandit_mission set [count wai_bandit_mission, _x select 0];
		};
	} count wai_bandit_missions;

	// Start mission monitor
	while {true} do
	{
	
		_cnt 		= {alive _x} count playableUnits;
		_currTime 	= floor(time);

		if (isNil "_h_missionTime") then { _h_missionTime = ((wai_mission_timer select 0) + random((wai_mission_timer select 1) - (wai_mission_timer select 0))); };
		if (isNil "_b_missionTime") then { _b_missionTime = ((wai_mission_timer select 0) + random((wai_mission_timer select 1) - (wai_mission_timer select 0))); };
		//if (isNil "_s_missionTime") then { _s_missionTime = ((wai_mission_timer select 0) + random((wai_mission_timer select 1) - (wai_mission_timer select 0))); };
		
		if((_currTime - _h_startTime >= _h_missionTime) && (!h_missionrunning)) then { _result = 1; };
		if((_currTime - _b_startTime >= _b_missionTime) && (!b_missionrunning)) then { _result = 2; };
		//if((_currTime - _s_startTime >= _s_missionTime) && (!s_missionrunning)) then { _result = 3; };

		if(h_missionrunning) then {
			_h_startTime = floor(time);
		};
		if(b_missionrunning) then {
			_b_startTime = floor(time);
		};
		//if(s_missionrunning) then {
		//	_s_startTime = floor(time);
		//};

		if((_cnt >= wai_players_online) && (markerready) && ((diag_fps) >= wai_server_fps)) then {
			if (_result == 1) then {
				_mission 			= wai_hero_mission call BIS_fnc_selectRandom;
				execVM format ["\z\addons\dayz_server\WAI\missions\hero\%1.sqf",_mission];

				ai_roadkills		= 0;
				h_missionrunning 	= true;
				_h_startTime 		= floor(time);
				_h_missionTime		= nil;
				_result 			= 0;
			};
			if (_result == 2) then {
				_mission 			= wai_bandit_mission call BIS_fnc_selectRandom;
				execVM format ["\z\addons\dayz_server\WAI\missions\bandit\%1.sqf",_mission];

				ai_roadkills		= 0;
				b_missionrunning 	= true;
				_b_startTime 		= floor(time);
				_b_missionTime		= nil;
				_result 			= 0;
			};
			/*if (_result == 3) then {
				_mission 			= wai_special_mission call BIS_fnc_selectRandom;
				execVM format ["\z\addons\dayz_server\WAI\missions\special\%1.sqf",_mission];

				ai_roadkills		= 0;
				b_missionrunning 	= true;
				_b_startTime 		= floor(time);
				_b_missionTime		= nil;
				_result 			= 0;
			};*/
		};
		sleep 1;
	};
};