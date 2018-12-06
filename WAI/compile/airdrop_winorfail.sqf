private ["_startDist","_PorM","_PorM2","_msgcrash","_msgdrop","_mission","_position","_difficulty","_name","_missionType","_showMarker","_enableMines","_completionType","_msgstart","_msgwin","_msglose","_mines"];

_mission		= _this select 0;
_position 		= _this select 1;
_difficulty 	= _this select 2;
_name			= _this select 3;
_missionType 	= _this select 4;
_showMarker 	= _this select 5;
_enableMines	= _this select 6;
_completionType	= _this select 7;
_airClass		= _this select 8;
_vehclass		= _this select 9;
_msgstart		= (_this select 10) select 0;
_msgcrash		= (_this select 10) select 1;
_msgdrop		= (_this select 10) select 2;
_msgwin			= (_this select 10) select 3;
_msglose		= (_this select 10) select 4;

if(wai_debug_mode) then {diag_log "WAI: Starting Mission number " + str _mission;};

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

_startDist = 10000; // increase this to delay the time it takes for the plane to arrive at the mission
_PorM = if (random 1 > .5) then {"+"} else {"-"};
_PorM2 = if (random 1 > .5) then {"+"} else {"-"};
_startPos = call compile format ["[(%1 select 0) %2 %4,(%1 select 1) %3 %4, 300]",_position,_PorM,_PorM2,_startDist];

if(wai_debug_mode) then {diag_log "WAI: Mission Data: " + str wai_mission_data;};

[_difficulty,_msgstart] call wai_server_message;

WAI_MarkerReady = true;

[_position,_mission,_name,_completionType,_color,_showMarker,_airClass,_vehclass,_msgcrash,_msgdrop,_msgwin,_msglose,_enableMines,_missionType,_difficulty,_startPos] spawn {

	private ["_loot","_vehMark","_return","_parachute","_vehPos","_vehicle","_aigroup","_speed","_dir","_wp","_msgcrash","_msgdrop","_dropzone","_plane","_pilot","_left","_leftTime","_claimTime","_acArray","_claimed","_acTime","_acdot","_acMarker","_timeStamp","_unitGroups","_playerArray","_enableMines","_aiVehicles","_aiVehArray","_baseclean","_msgwin","_msglose","_bomb","_position","_timeout","_player_near","_complete","_starttime","_timeout_time","_max_ai","_killpercent","_mission","_missionType","_airemain","_text","_name","_completionType","_marker","_dot","_color","_showMarker","_startPos"];

	_position		= _this select 0;
	_mission		= _this select 1;
	_name			= _this select 2;
	_completionType	= _this select 3;
	_color			= _this select 4;
	_showMarker		= _this select 5;
	_airClass		= _this select 6;
	_vehclass		= _this select 7;
	_msgcrash		= _this select 8;
	_msgdrop		= _this select 9;
	_msgwin			= _this select 10;
	_msglose		= _this select 11;
	_enableMines	= _this select 12;
	_missionType	= _this select 13;
	_difficulty		= _this select 14;
	_startPos		= _this select 15;
	
	_timeout 		= false;
	_player_near	= false;
	_complete		= false;
	_starttime 		= diag_tickTime;
	_timeout_time	= (random((wai_mission_timeout select 1) - (wai_mission_timeout select 0)) + (wai_mission_timeout select 0)) * 60;
	_max_ai			= (wai_mission_data select _mission) select 0;
	_unitGroups 	= (wai_mission_data select _mission) select 1;
	_mines 			= (wai_mission_data select _mission) select 2;
	_aiVehicles 	= (wai_mission_data select _mission) select 4;
	_vehicles 		= (wai_mission_data select _mission) select 5;
	_killpercent 	= _max_ai - (_max_ai * (wai_kill_percent / 100));
	_loot			= if (_missionType == "MainHero") then {Loot_VehicleDrop select 0;} else {Loot_VehicleDrop select 1;};
	_playerArray	= [];
	_timeStamp		= diag_tickTime;
	_closestPlayer	= objNull;
	_acArray		= [];
	_claimed		= false;
	_acTime			= diag_tickTime;
	_claimTime		= 0;
	_left			= false;
	_leftTime		= 0;
	_vehDropped		= false;
	_onGround		= false;
	_crashed		= false;
	
	_dropzone = "HeliHEmpty" createVehicle [0,0,0];
	_dropzone setPos _position;

	_plane = _airClass createVehicle _startPos;
	_dir = [_plane, _dropzone] call BIS_fnc_relativeDirTo;
	_plane setDir _dir;
	_plane setPos _startPos;
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_plane];
	_plane engineOn true;
	_speed = 150;
	_plane setVelocity [(sin _dir*_speed),(cos _dir*_speed),0];
	_plane flyInHeight 200;

	_aigroup = createGroup civilian;
	_pilot = _aigroup createUnit ["SurvivorW2_DZ",_startPos,[],0,"FORM"];
	[_pilot] joinSilent _aigroup;
	_pilot setSkill 1;
	_pilot setCombatMode "BLUE";
	_pilot moveInDriver _plane;
	_pilot assignAsDriver _plane;
	_aigroup setSpeedMode "LIMITED";

	_wp = _aigroup addWaypoint [_position, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointCompletionRadius 50;
	
	_t1 = 0;
	_dropTime = 0;
	
	while {!_timeout && !_complete} do {
	
		if (!alive _plane && {!_vehDropped}) exitWith {
			[_difficulty,_msgcrash] call wai_server_message;
			_crashed = true;
			_timeout = true;
		};
	
		if ((_plane distance _position < 230) && {!_vehDropped}) then {
			uiSleep 1; // This gets the drop near the center of the mission
			_planePos = [_plane] call FNC_GetPos;
			uiSleep 1; // need to do this otherwise the C130 blows up
			_parachute = createVehicle ["ParachuteMediumEast", _planePos, [], 0, "FLY"];
			_parachute setPos _planePos;
			_vehicle = [_vehclass,_planePos,_mission] call custom_publish;
			_vehicle attachTo [_parachute, [0, 0, 1]];
			_t1 = diag_tickTime;
			[_difficulty,_msgdrop] call wai_server_message;
			_return = _aigroup addWaypoint [_startPos, 0];
			_return setWaypointType "MOVE";
			_return setWaypointBehaviour "CARELESS";
			[_plane,_position,_aigroup] spawn wai_clean_aircraft;
			_vehDropped = true;
		};
		
		if (_vehDropped && {!_onGround}) then {
			_dropTime = diag_tickTime - _t1; // used to override if stuck in a tree or on top of a building
			if (((([_parachute] call FNC_GetPos) select 2) < 6) || {_dropTime > 55}) then {
				detach _vehicle;
				deleteVehicle _parachute;
				_vehPos = [_vehicle] call FNC_GetPos;
				//_vehPos set [2,0];
				//_position = _vehPos;
				_onGround = true;
			};
		};
		
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
			
			if (_onGround) then {
				_vehMark = createMarker [_missionType + str(_mission) + "vehicle", _vehPos];
				_vehMark setMarkerColor "ColorBlack";
				_vehMark setMarkerType "mil_dot";
				_vehMark setMarkerText _vehclass;
			};
			
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
			
			uiSleep 1;
			deleteMarker _marker;
			deleteMarker _dot;
			if (!isNil "_acMarker") then {deleteMarker _acMarker;};
			if (!isNil "_acdot") then {deleteMarker _acdot;};
			if (!isNil "_vehMark") then {deleteMarker _vehMark;};
		} else {
			uiSleep 1;
		};
		
		_player_near = [_position,wai_timeout_distance] call isNearPlayer;
		
		if (diag_tickTime - _starttime >= _timeout_time && !_player_near) then {
			_timeout = true;
		} else {
			if (_player_near) then {_starttime = diag_tickTime;};
		};
		
		if (_onGround) then {
			_complete = [_mission,_completionType,_killpercent,_vehPos] call wai_completion_check;
		};
	};

	if (_complete) then {
		
		[_vehicle,_mission,[[_vehicle]]] call wai_generate_vehicle_key;
		_vehicle setVehicleLock "unlocked";
		
		[_vehicle,_vehclass,2] call load_ammo;
		
		[_vehicle,_loot] call dynamic_crate;
		
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

				if (diag_tickTime - _finish_time >= 60*wai_clean_mission_time) then {
					
					if (count _aiVehicles > 0) then {
						_aiVehicles call wai_fnc_remove;
					};
					
					_mission call wai_remove_ai;
					
					if (count _vehicles > 0) then {
						[_mission,_vehicles] call wai_remove_vehicles;
					};
					
					deleteVehicle _dropzone;
					
					uiSleep 5;
					
					{
						if (count units _x == 0) then {
							deleteGroup _x;
						};
					} forEach _unitGroups;
					
					wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
					wai_mission_data set [_mission, -1];
					
					_cleaned = true;
				};
			};
		};
	};

	if (_timeout) then {
		
		if (alive _plane) then {
			[_plane,_position,_aigroup] spawn wai_clean_aircraft;
		};
		
		if (count _mines > 0) then {
			_mines call wai_fnc_remove;
		};
		
		if (count _aiVehicles > 0) then {
			_aiVehicles call wai_fnc_remove;
		};
		
		_mission call wai_remove_ai;
		
		if (count _vehicles > 0) then {
			[_mission,_vehicles] call wai_remove_vehicles;
		};
		
		deleteVehicle _dropzone;
		
		if (!_crashed) then {
			[_difficulty,_msglose] call wai_server_message;
		};
		
		if (_missionType == "MainBandit") then {
			b_missionsrunning = b_missionsrunning - 1;
			wai_b_starttime = diag_tickTime;
		} else {
			h_missionsrunning = h_missionsrunning - 1;
			wai_h_starttime = diag_tickTime;
		};
		
		uiSleep 5;
		
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
