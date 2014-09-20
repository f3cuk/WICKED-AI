if(isServer) then {

	private["_marker","_unitGroup","_b_missionTime","_h_missionTime","_h_startTime","_b_startTime","_result","_cnt","_currTime","_mission"];

	diag_log "WAI: Initialising missions";

	// Mission functions
	call 							compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\position_functions.sqf";
	mission_init					= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\mission_init.sqf";
	mission_winorfail				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\mission_winorfail.sqf";
	minefield						= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\minefield.sqf";
	custom_publish  				= compile preprocessFileLineNumbers "\z\addons\dayz_server\WAI\compile\custom_publish_vehicle.sqf";
	
	trader_markers 					= call get_trader_markers;
	markerready 					= true;
	wai_mission_data				= [];
	wai_hero_mission				= [];
	wai_bandit_mission				= [];
	wai_special_mission				= [];
	h_missionsrunning				= 0;
	b_missionsrunning				= 0;
	//s_missionsrunning				= 0;
	_h_startTime 					= floor(time);
	_b_startTime 					= floor(time);
	//_s_startTime					= floor(time);
	_delayTime						= floor(time);
	_h_missionTime					= nil;
	_b_missionTime					= nil;
	//_s_missionTime					= nil;
	_mission						= "";
	_hresult 						= 0;
	_bresult 						= 0;
	//_sresult 						= 0;

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

	/*

	{
		for "_i" from 1 to (_x select 1) do {
			wai_special_mission set [count wai_special_mission, _x select 0];
		};
	} count wai_special_missions;

	*/

	// Start mission monitor
	while {true} do
	{
		_cnt 		= {alive _x} count playableUnits;
		_currTime 	= floor(time);

		if (isNil "_h_missionTime") then { _h_missionTime = ((wai_mission_timer select 0) + random((wai_mission_timer select 1) - (wai_mission_timer select 0))); };
		if (isNil "_b_missionTime") then { _b_missionTime = ((wai_mission_timer select 0) + random((wai_mission_timer select 1) - (wai_mission_timer select 0))); };
		//if (isNil "_s_missionTime") then { _s_missionTime = ((wai_mission_timer select 0) + random((wai_mission_timer select 1) - (wai_mission_timer select 0))); };

		if((_currTime - _h_startTime >= _h_missionTime) && (h_missionsrunning < wai_hero_limit)) then { _hresult = 1; };
		if((_currTime - _b_startTime >= _b_missionTime) && (b_missionsrunning < wai_bandit_limit)) then { _bresult = 1; };
		//if((_currTime - _s_startTime >= _s_missionTime) && (s_missionsrunning < wai_special_limit)) then { _sresult = 1; };

		if(h_missionsrunning == wai_hero_limit) then { _h_startTime = floor(time); };
		if(b_missionsrunning == wai_bandit_limit) then { _b_startTime = floor(time); };
		//if(s_missionsrunning == wai_special_limit) then { _s_startTime = floor(time); };

		if((_cnt >= wai_players_online) && (diag_fps >= wai_server_fps)) then {

			if (_hresult == 1) then {
				waitUntil {_currTime = floor(time);(_currTime - _delayTime > 10 && markerready)};
				markerready 		= false;
				h_missionsrunning 	= h_missionsrunning + 1;
				_h_startTime 		= floor(time);
				_delayTime			= floor(time);
				_h_missionTime		= nil;
				_hresult 			= 0;
				wai_mission_markers set [(count wai_mission_markers), ("MainHero" + str(count wai_mission_data))];
				wai_mission_data = wai_mission_data + [[0,"",[],[0,0,0]]];

				_mission 			= wai_hero_mission call BIS_fnc_selectRandom;
				execVM format ["\z\addons\dayz_server\WAI\missions\hero\%1.sqf",_mission];
			};

			if (_bresult == 1) then {
				waitUntil {_currTime = floor(time);(_currTime - _delayTime > 10 && markerready)};
				markerready 		= false;
				b_missionsrunning 	= b_missionsrunning + 1;
				_b_startTime 		= floor(time);
				_delayTime			= floor(time);
				_b_missionTime		= nil;
				_bresult 			= 0;
				wai_mission_markers set [(count wai_mission_markers), ("MainBandit" + str(count wai_mission_data))];
				wai_mission_data = wai_mission_data + [[0,"",[],[0,0,0]]];
				
				_mission 			= wai_bandit_mission call BIS_fnc_selectRandom;
				execVM format ["\z\addons\dayz_server\WAI\missions\bandit\%1.sqf",_mission];
			};

			/*

			if (_sresult == 1) then {
				waitUntil {_currTime = floor(time);(_currTime - _delayTime > 10 && markerready)};
				markerready 		= false;
				s_missionsrunning 	= s_missionsrunning + 1;
				_s_startTime 		= floor(time);
				_delayTime			= floor(time);
				_s_missionTime		= nil;
				_sresult 			= 0;
				wai_mission_markers set [(count wai_mission_markers), ("Special" + str(count wai_mission_data))];
				wai_mission_data = wai_mission_data + [[0,"",[],[0,0,0]]];

				_mission 			= wai_special_mission call BIS_fnc_selectRandom;
				execVM format ["\z\addons\dayz_server\WAI\missions\special\%1.sqf",_mission];
			};

			*/

		};
		sleep 1;
	};
};