/*
	This scheduled task checks for running WAI missions and starts them appropriately.
*/

sched_wai_init = {
	diag_log("WAI: Scheduler Started");
	local _hArray = +wai_hero_missions;
	local _bArray = +wai_bandit_missions;
	local _hTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60;
	local _bTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60;
	[_hArray,_bArray,_bTime,_hTime]
};

sched_wai = {
	local _hArray = _this select 0;
	local _bArray = _this select 1;
	local _bTime = _this select 2;
	local _hTime = _this select 3;
	local _mission = "";
	
	// Bandit mission timer
	if (WAI_MarkerReady  && {diag_tickTime - wai_b_starttime >= _bTime} && {b_missionsrunning < wai_bandit_limit}) then {	
		WAI_MarkerReady = false;
		local _selected = false;
		
		while {!_selected} do {
				if (wai_debug_mode) then {diag_log format["WAI: Bandit Array: %1",_bArray];};
				_mission = _bArray select (floor (random (count _bArray)));
				_index = [_bArray, (_mission select 0)] call BIS_fnc_findNestedElement select 0;
				_bArray = [_bArray,_index] call fnc_deleteAt;
				if (count _bArray == 0) then {_bArray = +wai_bandit_missions;};
				if ((_mission select 1) >= random 1) then {
					_selected = true;
					if (wai_debug_mode) then {diag_log format["WAI: Bandit mission %1 selected.",(_mission select 0)];};
				} else {
					if (wai_debug_mode) then {diag_log format["WAI: Bandit mission %1 NOT selected.",(_mission select 0)];};
				};
			};
			
		b_missionsrunning = b_missionsrunning + 1;
		wai_b_starttime = diag_tickTime;
		wai_mission_markers set [(count wai_mission_markers), ("MainBandit" + str(count wai_mission_data))];
		wai_mission_data = wai_mission_data + [[0,[],[],[],[],[],[]]];
		["MainBandit","Hero"] execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",(_mission select 0)];
	};
	
	// Hero mission timer
	if (WAI_MarkerReady  && {diag_tickTime - wai_h_starttime >= _hTime} && {h_missionsrunning < wai_hero_limit}) then {
		WAI_MarkerReady = false;
		local _selected = false;
		
		while {!_selected} do {
				if (wai_debug_mode) then {diag_log format["WAI: Hero Array: %1",_hArray];};
				_mission = _hArray select (floor (random (count _hArray)));
				_index = [_hArray, (_mission select 0)] call BIS_fnc_findNestedElement select 0;
				_hArray = [_hArray,_index] call fnc_deleteAt;
				if (count _hArray == 0) then {_hArray = +wai_hero_missions;};
				if ((_mission select 1) >= random 1) then {
					_selected = true;
					if (wai_debug_mode) then {diag_log format["WAI: Hero mission %1 selected.",(_mission select 0)];};
				} else {
					if (wai_debug_mode) then {diag_log format["WAI: Hero mission %1 NOT selected.",(_mission select 0)];};
				};
			};
			
		h_missionsrunning = h_missionsrunning + 1;
		wai_h_starttime = diag_tickTime;
		wai_mission_markers set [(count wai_mission_markers), ("MainHero" + str(count wai_mission_data))];
		wai_mission_data = wai_mission_data + [[0,[],[],[],[],[],[]]];
		["MainHero","Bandit"] execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",(_mission select 0)];
	};
	
	// Reset times
	_hTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60;
	_bTime = (random((wai_mission_timer select 1) - (wai_mission_timer select 0)) + (wai_mission_timer select 0)) * 60;
		
	[_hArray,_bArray,_bTime,_hTime]
};