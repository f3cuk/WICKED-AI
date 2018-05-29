// Assign parameters passed from mission array to local variables
_mission		= _this select 0;
_position 		= _this select 1;
_difficulty 	= _this select 2;
_name			= _this select 3;
_missionType 	= _this select 4;
_showMarker 	= _this select 5;
_enableMines	= _this select 6;
_crate			= _this select 7;
_completionType	= _this select 8;
_baseclean		= _this select 9;
_msgstart		= _this select 10;
_msgwin			= _this select 11;
_msglose		= _this select 12;
_crateLoot 		= _this select 13;

// Initialize additional local variables
_minefieldRadius = 0;
_color		= "";
_mines		= nil;

if(wai_debug_mode) then { diag_log("WAI: Starting Mission number " + str(_mission)); };

// If minefield enabled, spawn the mines and set the radius used for vehicle detection
if(wai_enable_minefield && _enableMines) then {
	call {
		if(_difficulty == "easy") exitWith {_mines = [_position,20,37,20] call minefield; _minefieldRadius = 37;};
		if(_difficulty == "medium") exitWith {_mines = [_position,35,52,50] call minefield; _minefieldRadius = 52;};
		if(_difficulty == "hard") exitWith {_mines = [_position,50,75,100] call minefield; _minefieldRadius = 75;};
		if(_difficulty == "extreme") exitWith {_mines = [_position,60,90,150] call minefield; _minefieldRadius = 90;};
	};
	
	// add mines to WAI mission data array, third parameter
	wai_mission_data select _mission set [2, _mines];
};

// Set the marker color based on difficulty
call {
	if(_difficulty == "easy") exitWith {_color = "ColorGreen"};
	if(_difficulty == "medium") exitWith {_color = "ColorYellow"};
	if(_difficulty == "hard") exitWith {_color = "ColorRed"};
	if(_difficulty == "extreme") exitWith {_color = "ColorBlack"};
	_color = _difficulty;
};

// Set the name of the mission based on type (used in mission markers)
call {
	if(_missionType == "MainHero") exitWith { _name = "[Bandits] " + _name; };
	if(_missionType == "MainBandit") exitWith { _name = "[Heroes] " + _name; };
	//if(_missionType == "special") exitWith { _name = "[Special] " + _name; };
};

if(wai_debug_mode) then { diag_log("WAI: Mission Data: " + str(wai_mission_data)); };

// Send mission announcement to clients
_msgstart call wai_server_message;

// Let other missions spawn
WAI_MarkerReady = true;

// Spawn the mission thread
[_position,_minefieldRadius,_mission,_name,_completionType,_color,_crateLoot,_crate,_showMarker,_msgwin,_msglose,_baseclean,_enableMines,_missionType] spawn {

	private ["_left","_leftTime","_claimTime","_acArray","_claimed","_acTime","_acdot","_acMarker","_timeStamp","_unitGroups","_playerArray","_enableMines","_aiVehicles","_aiVehArray","_baseclean","_msgwin","_msglose","_bomb","_position","_minefieldRadius","_timeout","_player_near","_complete","_starttime","_timeout_time","_max_ai","_killpercent","_mission","_missionType","_airemain","_text","_name","_completionType","_marker","_dot","_objectivetarget","_color","_crateLoot","_crate","_showMarker","_cleanunits"];

	_position			= _this select 0;
	_minefieldRadius 	= _this select 1;
	_mission			= _this select 2;
	_name				= _this select 3;
	_completionType		= _this select 4;
	_color				= _this select 5;
	_crateLoot			= _this select 6;
	_crate				= _this select 7; // this variable is the vehicle if patrol mission
	_showMarker			= _this select 8;
	_msgwin				= _this select 9;
	_msglose			= _this select 10;
	_baseclean			= _this select 11;
	_enableMines		= _this select 12;
	_missionType		= _this select 13;
	
	_timeout 			= false;
	_player_near		= false;
	_complete			= false;
	_starttime 			= diag_tickTime;
	_timeout_time		= (60*(wai_mission_timeout select 0) + random(60*(wai_mission_timeout select 1) - 60*(wai_mission_timeout select 0)));
	_max_ai				= (wai_mission_data select _mission) select 0;
	_killpercent 		= _max_ai - (_max_ai * (wai_kill_percent / 100));
	_playerArray		= [];
	_unitGroups			= [];
	_timeStamp			= diag_tickTime;
	_closestPlayer		= objNull;
	_acArray			= [];
	_claimed			= false;
	_acTime				= diag_tickTime;
	_claimTime			= 0;
	_left				= false;
	_leftTime			= 0;
	
	// Start the mission loop
	while {!_timeout && !_complete} do {
		
		// Minefield functionality if enabled
		if (wai_enable_minefield && _enableMines) then {
			{
				// Warn player that they are approaching minefield: default is 200 meters from the edge of the minefield
				if((isPlayer _x) && (vehicle _x != _x) && (vehicle _x distance _position < (_minefieldRadius + 200)) && !(_x in _playerArray)) then {
					_x call wai_minefield_warning;
					// add player to array so it only sends the message once to each client
					_playerArray set [count _playerArray, _x];
					
				};
				
				// If the player is in a vehicle and gets within the minefield radius, an explosion occurs at vehicle location
				if((isPlayer _x) && (vehicle _x != _x) && (vehicle _x distance _position < _minefieldRadius) && (alive _x) && ((([vehicle _x] call FNC_GetPos) select 2) < 1)) then {
					_bomb = "Bo_GBU12_lgb" createVehicle ([vehicle _x] call FNC_GetPos);
					uiSleep 3;
					deleteVehicle _bomb;
					//{deleteVehicle _x;} forEach nearestObjects [_position, ["Mine"],4];
				};
			} count playableUnits;
		};
		
		// Invisible Static Gun Glitch Fix - Runs every 3 minutes - "GetOut" EventHandler forces the AI back onto the static gun immediately.
		_staticArray = ((wai_mission_data select _mission) select 3);
		if ((diag_tickTime - _timeStamp) > 180 && (count _staticArray) > 0) then {
			{
				if (typeName _x == "ARRAY") then {
					private ["_unit","_gun"];
					_unit = _x select 0;
					_gun = _x select 1;
					{
						_unit action ["getOut", _gun];
					} count _x;
				};
			} forEach _staticArray;
			_timeStamp = diag_tickTime;
		};
		
		// Auto Claim functionality if enabled
		if (use_wai_autoclaim && _showMarker) then {
			if (!_claimed) then {
			
				if (isNull _closestPlayer) then {
					_closestPlayer = _position call wai_isClosest; // if closest player is not chosen (isNull) call the function to find one
				};
				if (!(_closestPlayer in _acArray) && !(isNull _closestPlayer)) then {
					[_closestPlayer,_name,"Start"] call wai_AutoClaimAlert;	// Send alert to player who is closest
					_acArray set [count _acArray, _closestPlayer]; // add player to array so it only sends the message once
					_claimTime = diag_tickTime;
				};
				if (diag_tickTime - _claimTime > ac_delay_time) then {
					if ((_closestPlayer distance _position) > ac_alert_distance) then { // if the player leaves the mission area, set variables to default
						[_closestPlayer,_name,"Stop"] call wai_AutoClaimAlert; // Send alert to player who is closest
						_closestPlayer = objNull;
						_acArray = [];
					} else {
						_claimed = true;
						_acArray = [];
						[_closestPlayer,_name,"Claimed"] call wai_AutoClaimAlert; // Send alert to all players
					};
				};
			};
			if (_claimed) then {
				if ((_closestPlayer distance _position) > ac_alert_distance && !(_closestPlayer in _acArray)) then {
					[_closestPlayer,_name,"Return"] call wai_AutoClaimAlert; // notify player that he/she is outside the mission area
					_acArray set [count _acArray, _closestPlayer];
					_claimTime = diag_tickTime;
					_left = true;
				};
				if ((_closestPlayer distance _position) < ac_alert_distance && _left && (_closestPlayer in _acArray)) then {
					[_closestPlayer,_name,"Reclaim"] call wai_AutoClaimAlert;
					_left = false;
					_acArray = [];
				};
				if (diag_tickTime - _claimTime > ac_timeout && !(isNull _closestPlayer)) then {
					[_closestPlayer,_name,"Unclaim"] call wai_AutoClaimAlert; // Send alert to all players
					_closestPlayer = objNull;
					_claimed = false;
					_left = false;
					_acArray = [];
					
				} else {
					_leftTime = round (ac_timeout - (diag_tickTime - _claimTime));
				};
			};
		};
		
		// AI vehicle monitor
		_mission call wai_monitor_ai_vehicles;
		
		// JIP Mission Marker
		if (_showMarker) then {
			if (ai_show_count) then {
			_aiCount	= (wai_mission_data select _mission) select 0;
			_text	= format["%1 [%2 Remaining]",_name,_aiCount];
			} else {_text = _name};

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
			};
			
			if (use_wai_autoclaim && _claimed) then {
				_acdot = createMarker [_missionType + str(_mission) + "autodot", [(_position select 0) + 100, (_position select 1) + 100]];
				_acdot setMarkerColor "ColorBlack";
				_acdot setMarkerType "mil_objective";
				if (_left) then {
					_acdot setMarkerText format["Claim Timeout [%1]",_leftTime];
				} else {
					_acdot setMarkerText format["Claimed by %1",(name _closestPlayer)];
				};
			};
			
			// Make the entire loop sleep for 2 seconds
			uiSleep 2;
			
			// Delete mission markers so they can be recreated when the loop cycles
			deleteMarker _marker;
			deleteMarker _dot;
			if (!isNil "_acMarker") then {deleteMarker _acMarker;};
			if (!isNil "_acdot") then {deleteMarker _acdot;};
		} else {
			// Make the entire loop sleep for 2 seconds if show marker is false
			uiSleep 2;
		};
		
		// Check for mission timeout
		_player_near = [_position,wai_timeout_distance] call isNearPlayer;
		if (diag_tickTime - _starttime >= _timeout_time && !_player_near) then {
			_timeout = true;
		} else {
			//If player is near, reset the start time.
			if (_player_near) then {_starttime = diag_tickTime;};
		};
		
		// Check to see if the mission is complete
		_complete = [_mission,_completionType,_killpercent,_position] call wai_completion_check;
		
	};

	if (_complete) then {
		
		// Spawn loot in the mission crate
		[_crate,_crateLoot,_complete] call dynamic_crate;
		
		// Delete mines if enabled
		if (wai_enable_minefield && _enableMines) then {_mission call wai_remove_mines;};
		
		// Send "win" message to clients
		_msgwin call wai_server_message;
		
		// Remove the mission from the mission count so a new one can spawn
		if (_missionType == "MainBandit") then {
			b_missionsrunning = b_missionsrunning - 1;
		} else {
			h_missionsrunning = h_missionsrunning - 1;
		};
		
		// delete mission data if mission clean is turned off.
		if (wai_clean_mission_time <= 0) then {
			wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
			wai_mission_data set [_mission, -1];
		};
		
		diag_log format["WAI: [Mission: %1]: Ended at %2",_name,_position];
		
		if (wai_clean_mission_time > 0) then {
			private ["_finish_time","_cleaned","_playernear"];
			_finish_time = diag_tickTime;
			_cleaned = false;
			
			while {!_cleaned} do {
				
				// Continue monitoring AI vehicles until mission clean time is reached.
				_mission call wai_monitor_ai_vehicles;

				if ((diag_tickTime - _finish_time >= 60*wai_clean_mission_time)) then {
					
					// Delete AI vehicles if alive
					_mission call wai_remove_ai_vehicles;
					
					// Remove remaining AI and mission vehicles
					_mission call wai_remove_alive;
					
					// Delete Buildings
					if(count _baseclean > 0) then {_baseclean call wai_remove_buildings;};
					
					if (wai_clean_mission_crate) then {
						// Check player proximity to the crate
						_playernear = [_position,75] call isNearPlayer;
						
						// Do not delete the crate if there is a player within 75 meters - probably still looting
						if (!_playernear) then {
							// This check prevents deleting mission vehicles if they are used to spawn loot.
							if (typeOf(_crate) in (crates_large + crates_medium + crates_small)) then {
								deleteVehicle _crate;
							};
							
							// Remove the AI groups
							_unitGroups = (wai_mission_data select _mission) select 1;
							{if (count units _x == 0) then {deleteGroup _x}} forEach _unitGroups;
	
							// Remove the remaining mission data
							wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
							wai_mission_data set [_mission, -1];
							
							_cleaned = true;
						};
					} else {
						
						// Remove the AI groups
						_unitGroups = (wai_mission_data select _mission) select 1;
						{if (count units _x == 0) then {deleteGroup _x}} forEach _unitGroups;
	
						// Remove the remaining mission data
						wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
						wai_mission_data set [_mission, -1];
						
						_cleaned = true;
					};
				};
				uiSleep 3;
			};
		};
	};

	if (_timeout) then {
		
		// Remove Mines
		_mission call wai_remove_mines;
		
		// Delete the mission crate
		deleteVehicle _crate;
		
		// Remove AI vehicles
		_mission call wai_remove_ai_vehicles;
		
		// Remove alive AI and mission vehicles
		_mission call wai_remove_alive;
		
		// Remove Buildings
		if(count _baseclean > 0) then {_baseclean call wai_remove_buildings;};
		
		// Send mission timeout message to clients
		_msglose call wai_server_message;
		
		// Remove the mission from the mission count so a new one can spawn
		if (_missionType == "MainBandit") then {
			b_missionsrunning = b_missionsrunning - 1;
		} else {
			h_missionsrunning = h_missionsrunning - 1;
		};
		
		// Remove the AI groups
		_unitGroups = (wai_mission_data select _mission) select 1;
		{if (count units _x == 0) then {deleteGroup _x}} forEach _unitGroups;
	
		// Remove the remaining mission data
		wai_mission_markers = wai_mission_markers - [(_missionType + str(_mission))];
		wai_mission_data set [_mission, -1];
		
		diag_log format["WAI: [Mission: %1]: Timed out at %2",_name,_position];
	};
};
