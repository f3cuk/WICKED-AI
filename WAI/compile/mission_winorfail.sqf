private ["_mission","_position","_difficulty","_name","_missionType","_showMarker","_enableMines","_completionType","_msgstart","_msgwin","_msglose","_mines"];

_mission		= _this select 0;
_position 		= _this select 1;
_difficulty 	= _this select 2;
_name			= _this select 3;
_missionType 	= _this select 4;
_showMarker 	= _this select 5;
_enableMines	= _this select 6;
_completionType	= _this select 7;
_msgstart		= (_this select 8) select 0;
_msgwin			= (_this select 8) select 1;
_msglose		= (_this select 8) select 2;

if(wai_debug_mode) then {diag_log format["WAI: Starting Mission number %1",_mission];};

if(wai_enable_minefield && _enableMines) then {
	_mines = [_position,50,75,100] call minefield;
	wai_mission_data select _mission set [2, _mines];
};

_color = call {
	if(_difficulty == "Easy") exitWith {"ColorGreen"};
	if(_difficulty == "Medium") exitWith {"ColorYellow"};
	if(_difficulty == "Hard") exitWith {"ColorRed"};
	if(_difficulty == "Extreme") exitWith {"ColorBlack"};
};

_name = call {
	if(_missionType == "MainHero") exitWith {"Bandit " + _name;};
	if(_missionType == "MainBandit") exitWith {"Hero " + _name;};
};

[_difficulty,_msgstart] call wai_server_message;

WAI_MarkerReady = true;

[_position,_mission,_name,_completionType,_color,_showMarker,_msgwin,_msglose,_enableMines,_missionType,_difficulty] spawn {

	private ["_left","_leftTime","_claimTime","_acArray","_claimed","_acTime","_acdot","_acMarker","_timeStamp","_unitGroups","_playerArray","_enableMines","_aiVehicles","_aiVehArray","_baseclean","_msgwin","_msglose","_bomb","_position","_minefieldRadius","_timeout","_player_near","_complete","_starttime","_timeout_time","_max_ai","_killpercent","_mission","_missionType","_airemain","_text","_name","_completionType","_marker","_dot","_objectivetarget","_color","_crateLoot","_crate","_showMarker","_cleanunits"];

	_position			= _this select 0;
	_mission			= _this select 1;
	_name				= _this select 2;
	_completionType		= _this select 3;
	_color				= _this select 4;
	_showMarker			= _this select 5;
	_msgwin				= _this select 6;
	_msglose			= _this select 7;
	_enableMines		= _this select 8;
	_missionType		= _this select 9;
	_difficulty			= _this select 10;
	
	_timeout 			= false;
	_player_near		= false;
	_complete			= false;
	_starttime 			= diag_tickTime;
	_timeout_time		= (random((wai_mission_timeout select 1) - (wai_mission_timeout select 0)) + (wai_mission_timeout select 0)) * 60;
	_max_ai				= (wai_mission_data select _mission) select 0;
	_unitGroups 		= (wai_mission_data select _mission) select 1;
	_mines 				= (wai_mission_data select _mission) select 2;
	_crates 			= (wai_mission_data select _mission) select 3;
	_aiVehicles 		= (wai_mission_data select _mission) select 4;
	_vehicles 			= (wai_mission_data select _mission) select 5;
	_baseclean 			= (wai_mission_data select _mission) select 6;
	_killpercent 		= _max_ai - (_max_ai * (wai_kill_percent / 100));
	_playerArray		= [];
	_timeStamp			= diag_tickTime;
	_closestPlayer		= objNull;
	_acArray			= [];
	_claimed			= false;
	_acTime				= diag_tickTime;
	_claimTime			= 0;
	_left				= false;
	_leftTime			= 0;
	
	while {!_timeout && !_complete} do {
		
		if (count _mines > 0) then {
			{
				if((isPlayer _x) && (vehicle _x != _x) && (vehicle _x distance _position < 275) && !(_x in _playerArray)) then {
					_x call wai_minefield_warning;
					_playerArray set [count _playerArray, _x];
				};
				
				if((isPlayer _x) && (vehicle _x != _x) && (vehicle _x distance _position < 75) && (alive _x) && ((([vehicle _x] call FNC_GetPos) select 2) < 1)) then {
					_bomb = "Bo_GBU12_lgb" createVehicle ([vehicle _x] call FNC_GetPos);
					uiSleep 3;
					deleteVehicle _bomb;
				};
			} count playableUnits;
		};
		
		if ((diag_tickTime - _timeStamp) > 180 && (count _aiVehicles) > 0) then {
			{
				if (_x isKindOf "StaticWeapon") then {
					(gunner _x) action ["getout",_x];
				};
			} forEach _aiVehicles;
			
			_timeStamp = diag_tickTime;
		};
		
		if (use_wai_autoclaim && _showMarker) then {
			#include "\z\addons\dayz_server\WAI\compile\auto_claim.sqf"	
		};
		
		if (count _aiVehicles > 0) then {
			_aiVehicles call wai_monitor_ai_vehicles;
		};
		
		if (_showMarker) then {
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
			
			if (use_wai_autoclaim) then {
				_acMarker = createMarker [_missionType + str(_mission) + "auto", _position];
				_acMarker setMarkerShape "ELLIPSE";
				_acMarker setMarkerBrush "Border";
				_acMarker setMarkerColor "ColorRed";
				_acMarker setMarkerSize [ac_alert_distance,ac_alert_distance];
			
				if (_claimed) then {
					_acdot = createMarker [_missionType + str(_mission) + "autodot", [(_position select 0) + 100, (_position select 1) + 100]];
					_acdot setMarkerColor "ColorBlack";
					_acdot setMarkerType "mil_objective";
					if (_left) then {
						_acdot setMarkerText format["%1 Claim Timeout [%2]",(_acArray select 1),_leftTime];
					} else {
						_acdot setMarkerText format["Claimed by %1",(name _closestPlayer)];
					};
				};
			};
			
			uiSleep 2;
			deleteMarker _marker;
			deleteMarker _dot;
			if (!isNil "_acMarker") then {deleteMarker _acMarker;};
			if (!isNil "_acdot") then {deleteMarker _acdot;};
		} else {
			uiSleep 2;
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
		
		if (count _vehicles > 0) then {
			{
				[_x,_mission,_crates] call wai_generate_vehicle_key;
			} count _vehicles;
		};
		
		{
			[(_x select 0),(_x select 1),_complete] call dynamic_crate;
		} count _crates;
		
		if (count _mines > 0) then {
			_mines call wai_fnc_remove;
		};
		
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
				
				if (count _aiVehicles > 0) then {
					_aiVehicles call wai_monitor_ai_vehicles;
				};

				if ((diag_tickTime - _finish_time >= 60*wai_clean_mission_time) || ({[_x,_name] call fnc_inString;} count wai_clean_when_clear) != 0) then {
					
					if (count _aiVehicles > 0) then {
						_aiVehicles call wai_fnc_remove;
					};
					
					_mission call wai_remove_ai;
					
					if (count _vehicles > 0) then {
						[_mission,_vehicles] call wai_remove_vehicles;
					};
					
					if (count _baseclean > 0) then {
						_baseclean call wai_fnc_remove;
					};
					
					{
						if (count units _x == 0) then {
							deleteGroup _x;
						};
					} forEach _unitGroups;
					
					wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
					wai_mission_data set [_mission, -1];
					
					if (wai_clean_mission_crate) then {

						_playernear = [_position,75] call isNearPlayer;
						
						if (!_playernear) then {
							{
								if ((typeOf (_x select 0)) in (crates_large + crates_medium + crates_small)) then {
									deleteVehicle (_x select 0);
								};
							} count _crates;
							
							_cleaned = true;
						};
					} else {
						_cleaned = true;
					};
				};
			};
		};
	};

	if (_timeout) then {
		
		if (count _mines > 0) then {
			_mines call wai_fnc_remove;
		};
		
		{
			deleteVehicle (_x select 0);
		} count _crates;
		
		if (count _aiVehicles > 0) then {
			_aiVehicles call wai_fnc_remove;
		};
		
		_mission call wai_remove_ai;
		
		if (count _vehicles > 0) then {
			[_mission,_vehicles] call wai_remove_vehicles;
		};
		
		if (count _baseclean > 0) then {
			_baseclean call wai_fnc_remove;
		};
		
		[_difficulty,_msglose] call wai_server_message;
		
		if (_missionType == "MainBandit") then {
			b_missionsrunning = b_missionsrunning - 1;
			wai_b_starttime = diag_tickTime;
		} else {
			h_missionsrunning = h_missionsrunning - 1;
			wai_h_starttime = diag_tickTime;
		};
		
		{
			if (count units _x == 0) then {
				deleteGroup _x;
			};
		} forEach _unitGroups;
	
		wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
		wai_mission_data set [_mission, -1];
		
		diag_log format["WAI: [Mission: %1]: Timed out at %2",_name,_position];
	};
};
