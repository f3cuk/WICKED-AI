private["_marker","_unitGroup","_b_missionTime","_h_missionTime","_h_startTime","_b_startTime","_result","_cnt","_currTime","_mission","_heroarray","_banditarray"];

diag_log "WAI: Initializing missions";

WAI_MarkerReady		= true;
wai_mission_data	= [];
wai_hero_mission	= [];
wai_bandit_mission	= [];
h_missionsrunning	= 0;
b_missionsrunning	= 0;
wai_h_starttime 	= diag_tickTime;
wai_b_starttime 	= diag_tickTime;
_h_missionTime		= nil;
_b_missionTime		= nil;
_mission			= "";
_hresult 			= 0;
_bresult 			= 0;

while {true} do
{
	_cnt = {alive _x} count playableUnits;
	_currTime = diag_tickTime;

	if (isNil "_h_missionTime") then { _h_missionTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60; };
	if (isNil "_b_missionTime") then { _b_missionTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60; };

	if((_currTime - wai_h_starttime >= _h_missionTime) && (h_missionsrunning < wai_hero_limit)) then { _hresult = 1; };
	if((_currTime - wai_b_starttime >= _b_missionTime) && (b_missionsrunning < wai_bandit_limit)) then { _bresult = 1; };

	if((_cnt >= wai_players_online) && (diag_fps >= wai_server_fps)) then {

		if (_hresult == 1 && WAI_MarkerReady) then {
			WAI_MarkerReady	= false;
			h_missionsrunning = h_missionsrunning + 1;
			wai_h_starttime = diag_tickTime;
			_h_missionTime = nil;
			_hresult = 0;
			wai_mission_markers set [(count wai_mission_markers), ("MainHero" + str(count wai_mission_data))];
			wai_mission_data = wai_mission_data + [[0,[],[],[],[],[],[]]];
			
			if (isNil "_heroarray") then {_heroarray = wai_hero_missions;};
			
			if (count _heroarray > 2) then {_heroarray = [_heroarray, 100] call KK_fnc_arrayShufflePlus;};
			
			_mission = _heroarray call BIS_fnc_selectRandom;
			["MainHero","Bandit"] execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",_mission];
			
			if (wai_cycle_all_missions) then {
				_heroarray = _heroarray - [_mission];
				//diag_log text format["Hero Array Count : %1", (count _heroarray)];
				if (count _heroarray == 0) then {_heroarray = nil;};
			};
		};

		if (_bresult == 1 && WAI_MarkerReady) then {
			WAI_MarkerReady	= false;
			b_missionsrunning = b_missionsrunning + 1;
			wai_b_starttime = diag_tickTime;
			_b_missionTime = nil;
			_bresult = 0;
			wai_mission_markers set [(count wai_mission_markers), ("MainBandit" + str(count wai_mission_data))];
			wai_mission_data = wai_mission_data + [[0,[],[],[],[],[],[]]];
			
			if (isNil "_banditarray") then {_banditarray = wai_hero_missions;};
			
			if (count _banditarray > 2) then {_banditarray = [_banditarray, 100] call KK_fnc_arrayShufflePlus;};
			
			_mission = _banditarray call BIS_fnc_selectRandom;
			["MainBandit","Hero"] execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",_mission];
			
			if (wai_cycle_all_missions) then {
				_banditarray = _banditarray - [_mission];
				//diag_log text format["Bandit Array Count: %1", (count _banditarray)];
				if (count _banditarray == 0) then {_banditarray = nil;};
			};
		};	
	};
	uiSleep 5;
};
