private["_marker","_unitGroup","_b_missionTime","_h_missionTime","_h_startTime","_b_startTime","_result","_cnt","_currTime","_mission"];

diag_log "WAI: Initializing missions";

trader_markers 		= call get_trader_markers;
WAI_MarkerReady		= true;
wai_mission_data	= [];
wai_hero_mission	= [];
wai_bandit_mission	= [];
h_missionsrunning	= 0;
b_missionsrunning	= 0;
_h_startTime 		= diag_tickTime;
_b_startTime 		= diag_tickTime;
_h_missionTime		= nil;
_b_missionTime		= nil;
_mission			= "";
_hresult 			= 0;
_bresult 			= 0;

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
	_currTime 	= diag_tickTime;

	if (isNil "_h_missionTime") then { _h_missionTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60; };
	if (isNil "_b_missionTime") then { _b_missionTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60; };

	if((_currTime - _h_startTime >= _h_missionTime) && (h_missionsrunning < wai_hero_limit)) then { _hresult = 1; };
	if((_currTime - _b_startTime >= _b_missionTime) && (b_missionsrunning < wai_bandit_limit)) then { _bresult = 1; };

	if(h_missionsrunning == wai_hero_limit) then { _h_startTime = diag_tickTime; };
	if(b_missionsrunning == wai_bandit_limit) then { _b_startTime = diag_tickTime; };

	if((_cnt >= wai_players_online) && (diag_fps >= wai_server_fps)) then {

		if (_hresult == 1 && WAI_MarkerReady) then {
			WAI_MarkerReady		= false;
			h_missionsrunning 	= h_missionsrunning + 1;
			_h_startTime 		= diag_tickTime;
			_h_missionTime		= nil;
			_hresult 			= 0;
			wai_mission_markers set [(count wai_mission_markers), ("MainHero" + str(count wai_mission_data))];
			wai_mission_data = wai_mission_data + [[0,[],[],[],[]]];

			_mission 			= wai_hero_mission call BIS_fnc_selectRandom;
			execVM format ["\z\addons\dayz_server\WAI\missions\hero\%1.sqf",_mission];
		};

		if (_bresult == 1 && WAI_MarkerReady) then {
			WAI_MarkerReady		= false;
			b_missionsrunning 	= b_missionsrunning + 1;
			_b_startTime 		= diag_tickTime;
			_b_missionTime		= nil;
			_bresult 			= 0;
			wai_mission_markers set [(count wai_mission_markers), ("MainBandit" + str(count wai_mission_data))];
			wai_mission_data = wai_mission_data + [[0,[],[],[],[]]];
			
			_mission 			= wai_bandit_mission call BIS_fnc_selectRandom;
			execVM format ["\z\addons\dayz_server\WAI\missions\bandit\%1.sqf",_mission];
		};

	};
	uiSleep 5;
};
