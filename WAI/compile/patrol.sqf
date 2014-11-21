if (isServer) then {

	_this spawn {

		private["_vehicle","_position","_unitgroup","_waypoint_data","_waypoints","_leader"];

		_vehicle 		= _this select 0;
		_position 		= _this select 1;
		_unitgroup 		= _this select 2;
		_waypoint_data 	= _this select 3;
		_num_waypoints 	= _this select 4;
		_leader			= leader _unitgroup;
		_count_wp		= count _waypoint_data;

		_vehicle setvehiclelock "UNLOCKED";

		{

			if(_leader == _x) then {
				_x assignAsDriver _vehicle;
				_x action["getInDriver",_vehicle];
				diag_log format["WAI: %1 assigned as driver",_x];
			} else {

				if((_vehicle emptyPositions "GUNNER") > 0) then {
					_x assignAsGunner _vehicle;
					_x moveInGunner _vehicle;

					diag_log format["WAI: %1 assigned as gunner",_x];
				} else {
					_x moveInCargo _vehicle;
					diag_log format["WAI: %1 assigned as cargo",_x];
				};

			};

		} forEach units _unitgroup;

		waitUntil {(_vehicle emptyPositions "DRIVER" == 0)};	// Wait until designated driver gets inside vehicle

		diag_log format["WAI: Driver is inside vehicle, continue.."];

		[_vehicle,_unitgroup] spawn {

			private["_vehicle","_unitgroup","_runmonitor"];

			_vehicle 	= _this select 0;
			_unitgroup 	= _this select 1;
			_runmonitor = true;

			while {(canMove _vehicle && _runmonitor)} do {
				if (fuel _vehicle < 0.2) then { _vehicle setfuel 1; };
				if (!(alive leader _unitgroup)) then {
					diag_log "WAI: Driver was killed, ejecting AI and removing waypoints.";
					_runmonitor = false;
				};
				sleep .5;
			};

			if(_runmonitor) then {
				diag_log "WAI: Vehhicle became undriveable, ejecting crew.";
			};

			deleteWaypoint [_unitgroup, all];

			{
				_x action ["eject",vehicle _x];
			} forEach crew _vehicle;

			_wp = _unitgroup addWaypoint [(getPos _vehicle),0];
			_wp setWaypointType "GUARD";
			_wp setWaypointBehaviour "COMBAT";
			_unitgroup setBehaviour "COMBAT";
			_unitgroup setCombatMode "YELLOW";

		};

		for "_i" from 1 to _num_waypoints do {

			_rand_nr 	= ceil(random((_count_wp - 1)));
			_waypoint 	= (_waypoint_data select _rand_nr);
			_waypoints set[_rand_nr,-1];
			_waypoints	= _waypoints - [-1];
			
			_wp = _unitgroup addWaypoint [(_waypoint select 1),0];
			if(_i == _num_waypoints) then { _wp setWaypointType "GUARD"; } else { _wp setWaypointType "MOVE"; };
			_wp setWaypointBehaviour "CARELESS";
			_wp setWaypointCombatMode "YELLOW";
			
			_msg = format["[RADIO] The patrol is seen moving towards %1",(_waypoint select 0)];
	
			sleep random(10);
			
			if (wai_radio_announce) then {
				RemoteMessage = ["radio",_msg];
				publicVariable "RemoteMessage";
			} else {
				[nil,nil,rTitleText,_msg,"PLAIN",10] call RE;
			};
			
			waitUntil{sleep 1; (_vehicle distance (_waypoint select 1) < 30)};
		};

	};

};