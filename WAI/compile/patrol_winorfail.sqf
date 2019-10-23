private ["_location","_countWP","_wp","_mission","_position","_difficulty","_name","_missionType","_showMarker","_numWaypoints","_completionType","_msgstart","_msgwin","_msglose"];

_mission		= _this select 0;
_position 		= _this select 1;
_difficulty 	= _this select 2;
_name			= _this select 3;
_missionType 	= _this select 4;
_showMarker 	= _this select 5;
_numWaypoints	= _this select 6;
_locations		= _this select 7;
_completionType	= _this select 8;
_msgstart		= (_this select 9) select 0;
_msgwin			= (_this select 9) select 1;
_msglose		= (_this select 9) select 2;
_countWP		= [];
_unitGroup = ((wai_mission_data select _mission) select 1) select 0;

if(wai_debug_mode) then {diag_log format["WAI: Starting Mission number %1",_mission];};

_color = call {
	if (_difficulty == "Easy") exitWith {"ColorGreen"};
	if (_difficulty == "Medium") exitWith {"ColorYellow"};
	if (_difficulty == "Hard") exitWith {"ColorRed"};
	if (_difficulty == "Extreme") exitWith {"ColorBlack"};
};

_name = call {
	if (_missionType == "MainHero") exitWith {"Bandit " + _name;};
	if (_missionType == "MainBandit") exitWith {"Hero " + _name;};
};

for "_i" from 0 to _numWaypoints - 1 do {
	_location = _locations call BIS_fnc_selectRandom;
	_countWP set [_i, _location];
	_locations set [_i, "rem"];
	_locations = _locations - ["rem"];
	_wp = _unitGroup addWayPoint [position _location,0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "LIMITED";
	//_wp setWaypointSpeed "FULL";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointCombatMode "YELLOW";
	_wp setWaypointCompletionRadius 300;
};

[_difficulty,_msgstart] call wai_server_message;

WAI_MarkerReady = true;

[_position,_mission,_name,_completionType,_color,_showMarker,_msgwin,_msglose,_missionType,_difficulty,_countWP] spawn {

	private ["_horb","_crates","_wpReached","_startMarker","_vehicle","_leader","_countWP","_difficulty","_unitGroup","_msgwin","_msglose","_position","_timeout","_player_near","_complete","_starttime","_timeout_time","_max_ai","_killpercent","_mission","_missionType","_airemain","_text","_name","_completionType","_marker","_dot","_color","_showMarker"];

	_position = _this select 0;
	_mission = _this select 1;
	_name = _this select 2;
	_completionType = _this select 3;
	_color = _this select 4;
	_showMarker = _this select 5;
	_msgwin	= _this select 6;
	_msglose = _this select 7;
	_missionType = _this select 8;
	_difficulty = _this select 9;
	_countWP = _this select 10;
	
	_startMarker = false;
	_timeout = false;
	_player_near = false;
	_complete = false;
	_starttime = diag_tickTime;
	_timeout_time = (random((wai_mission_timeout select 1) - (wai_mission_timeout select 0)) + (wai_mission_timeout select 0)) * 60;
	_max_ai	= (wai_mission_data select _mission) select 0;
	_unitGroup = ((wai_mission_data select _mission) select 1) select 0;
	_crates = (wai_mission_data select _mission) select 3;
	_vehicle = ((wai_mission_data select _mission) select 5) select 0;
	_killpercent = _max_ai - (_max_ai * (wai_kill_percent / 100));
	_leader	= leader _unitgroup;
	_vehicle setDamage 0;
	_vehicle removeAllEventHandlers "HandleDamage";
	_vehicle addEventHandler ["HandleDamage",{_this call fnc_veh_handleDam}];
	_wpReached = true;
	_disabled = false;
	_currentWP = nil;
	_index = 1;
	
	
	{
		if (_leader == _x) then {
			_x assignAsDriver _vehicle;
			_x moveInDriver _vehicle;
		} else {
			if ((_vehicle emptyPositions "GUNNER") > 0) then {
				_x assignAsGunner _vehicle;
				_x moveInGunner _vehicle;
			} else {
				_x moveInCargo _vehicle;
			};
		};
	
	} count units _unitgroup;

	while {!_timeout && !_complete} do {
		
		if ((count _countWP == 0) && {_wpReached}) then {
			_timeout = true;
		};
		
		if ((count _countWP > 0) && {_wpReached}) then {
			
			if (!isNil "_currentWP") then {
				_countWP set [0, "rem"];
				_countWP = _countWP - ["rem"];
			};
			
			_unitGroup setCurrentWaypoint [_unitGroup, _index];
			_currentWP = _countWP select 0;
			_wpReached = false;
			uiSleep 10;
			[_difficulty,["STR_CL_PATROL_MOVE",(text _currentWP)]] call wai_server_message;
			_index = _index + 1;
		};
		
		if (_showMarker && {_startMarker}) then {
			if (ai_show_count) then {
				_aiCount = (wai_mission_data select _mission) select 0;
				_text = format["%1 (%2 A.I.)",_name,_aiCount];
			} else {
				_text = _name;
			};

			_marker = createMarker [_missionType + str(_mission), _position];
			_marker setMarkerColor _color;
			_marker setMarkerShape "ELLIPSE";
			_marker setMarkerBrush "Solid";
			_marker setMarkerSize [300,300];
			_dot = createMarker [_missionType + str(_mission) + "dot", _position];
			_dot setMarkerColor "ColorBlack";
			_dot setMarkerType "mil_dot";
			_dot setMarkerText _text;
			
			uiSleep 2;
			deleteMarker _marker;
			deleteMarker _dot;
		} else {
			uiSleep 2;
		};
		
		if (count crew _vehicle > 0) then {
			_vehicle setVehicleAmmo 1;
			_vehicle setFuel 1;
		};
		
		if (!_disabled && (!(canMove _vehicle) || !(alive _leader))) then {
			_horb = if (_missionType == "MainHero") then {"Hero"} else {"Bandit"};
			[_difficulty,["STR_CL_PATROL_DISABLED",_horb]] call wai_server_message;
			_disabled = true;
			_startMarker = true;
			_position = getPos _vehicle;
			
			waitUntil {speed _vehicle < 10};

			{
				_x action ["eject",vehicle _x];
			} count crew _vehicle;
			
			_unitGroup2 = createGroup EAST; // Creating a new group seems to be the best solution here
			{[_x] joinSilent _unitGroup2} forEach (units _unitGroup);
			_unitGroup2 selectLeader ((units _unitGroup2) select 0);
			_unitGroup2 setFormation "ECH LEFT";
			_unitGroup2 setCombatMode "RED";
			_unitGroup2 setBehaviour "COMBAT";
			[_unitGroup2,_position,"easy"] call group_waypoints;
		};
		
		if (!_wpReached) then {
			if (_vehicle distance (position _currentWP) < 300) then {
				_wpReached = true;
				[_difficulty,["STR_CL_PATROL_ARRIVE",text _currentWP]] call wai_server_message;
			};
		};
		
		_player_near = [_position,wai_timeout_distance] call isNearPlayer;
		
		if (diag_tickTime - _starttime >= _timeout_time && !_player_near) then {
			_timeout = true;
		} else {
			if (_player_near) then {_starttime = diag_tickTime;};
		};
		
		_complete = [_mission,_completionType,_killpercent,_position] call wai_completion_check;
		
	};

	if (_complete) then {
	
		[_vehicle,_mission,[[_vehicle]]] call wai_generate_vehicle_key;
		_vehicle setVehicleLock "UNLOCKED";
		
		{
			[(_x select 0),(_x select 1)] call dynamic_crate;
		} count _crates;
		
		[_difficulty,_msgwin] call wai_server_message;
		
		if (_missionType == "MainBandit") then {
			b_missionsrunning = b_missionsrunning - 1;
			wai_b_starttime = diag_tickTime;
		} else {
			h_missionsrunning = h_missionsrunning - 1;
			wai_h_starttime = diag_tickTime;
		};
		
		diag_log format["WAI: [Mission: %1]: Ended at %2",_name,_position];
		
		if (wai_clean_mission_time > 0) then {
			private ["_finish_time","_cleaned","_playernear"];
			_finish_time = diag_tickTime;
			_cleaned = false;
			
			while {!_cleaned} do {
				
				uiSleep 3;

				if (diag_tickTime - _finish_time >= 60*wai_clean_mission_time) then {
					
					_mission call wai_remove_ai;
					
					deleteVehicle _vehicle;
					
					uiSleep 5;
					
					deleteGroup _unitGroup;
					
					if (!isNil "_unitGroup2") then {deleteGroup _unitGroup2;};
					
					wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
					wai_mission_data set [_mission, -1];
					
					_cleaned = true;
				};
			};
		};
	};

	if (_timeout) then {

		_mission call wai_remove_ai;
		
		deleteVehicle _vehicle;
		
		[_difficulty,_msglose] call wai_server_message;
		
		if (_missionType == "MainBandit") then {
			b_missionsrunning = b_missionsrunning - 1;
			wai_b_starttime = diag_tickTime;
		} else {
			h_missionsrunning = h_missionsrunning - 1;
			wai_h_starttime = diag_tickTime;
		};
		
		uiSleep 5;
		
		deleteGroup _unitGroup;
		
		if (!isNil "_unitGroup2") then {deleteGroup _unitGroup2;};
	
		wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
		wai_mission_data set [_mission, -1];
		
		diag_log format["WAI: [Mission: %1]: Timed out at %2",_name,_position];
	};
};
