private["_index","_selected","_b_missionTime","_h_missionTime","_currTime","_mission","_heroarray","_banditarray"];

diag_log "WAI: Initializing missions";

WAI_MarkerReady		= true;
wai_mission_data	= [];
h_missionsrunning	= 0;
b_missionsrunning	= 0;
wai_h_starttime 	= diag_tickTime;
wai_b_starttime 	= diag_tickTime;
_h_missionTime		= nil;
_b_missionTime		= nil;
_mission			= "";
_hresult 			= 0;
_bresult 			= 0;

while {true} do {
	_currTime = diag_tickTime;

	if (isNil "_h_missionTime") then { _h_missionTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60; };
	if (isNil "_b_missionTime") then { _b_missionTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60; };
	if((_currTime - wai_h_starttime >= _h_missionTime) && (h_missionsrunning < wai_hero_limit)) then { _hresult = 1; };
	if((_currTime - wai_b_starttime >= _b_missionTime) && (b_missionsrunning < wai_bandit_limit)) then { _bresult = 1; };

	if(({alive _x} count playableUnits) >= wai_players_online) then {

		if (_hresult == 1 && WAI_MarkerReady) then {
			WAI_MarkerReady	= false;
			_selected = false;
			
			while {!_selected} do {
				if (isNil "_heroarray") then {_heroarray = +wai_hero_missions;};
				if (wai_debug_mode) then {diag_log format["WAI: Hero Array: %1",_heroarray];};
				_mission = _heroarray select (floor (random (count _heroarray)));
				_index = [_heroarray, (_mission select 0)] call BIS_fnc_findNestedElement select 0;
				_heroarray = [_heroarray,_index] call fnc_deleteAt;
				if (count _heroarray == 0) then {_heroarray = nil;};
				if ((_mission select 1) >= random 1) then {
					_selected = true;
					if (wai_debug_mode) then {diag_log format["WAI: Hero mission %1 selected.",(_mission select 0)];};
				} else {
					if (wai_debug_mode) then {diag_log format["WAI: Hero mission %1 NOT selected.",(_mission select 0)];};
				};
			};
			
			h_missionsrunning = h_missionsrunning + 1;
			wai_h_starttime = diag_tickTime;
			_h_missionTime = nil;
			_hresult = 0;
			wai_mission_markers set [(count wai_mission_markers), ("MainHero" + str(count wai_mission_data))];
			wai_mission_data = wai_mission_data + [[0,[],[],[],[],[],[]]];
			["MainHero","Bandit"] execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",(_mission select 0)];
		};

		if (_bresult == 1 && WAI_MarkerReady) then {
			WAI_MarkerReady	= false;
			_selected = false;
			
			while {!_selected} do {
				if (isNil "_banditarray") then {_banditarray = +wai_bandit_missions;};
				if (wai_debug_mode) then {diag_log format["WAI: Bandit Array: %1",_banditarray];};
				_mission = _banditarray select (floor (random (count _banditarray)));
				_index = [_banditarray, (_mission select 0)] call BIS_fnc_findNestedElement select 0;
				_banditarray = [_banditarray,_index] call fnc_deleteAt;
				if (count _banditarray == 0) then {_banditarray = nil;};
				if ((_mission select 1) >= random 1) then {
					_selected = true;
					if (wai_debug_mode) then {diag_log format["WAI: Bandit mission %1 selected.",(_mission select 0)];};
				} else {
					if (wai_debug_mode) then {diag_log format["WAI: Bandit mission %1 NOT selected.",(_mission select 0)];};
				};
			};
			
			b_missionsrunning = b_missionsrunning + 1;
			wai_b_starttime = diag_tickTime;
			_b_missionTime = nil;
			_bresult = 0;
			wai_mission_markers set [(count wai_mission_markers), ("MainBandit" + str(count wai_mission_data))];
			wai_mission_data = wai_mission_data + [[0,[],[],[],[],[],[]]];
			["MainBandit","Hero"] execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",(_mission select 0)];
		};	
	};
	uiSleep 5;
};