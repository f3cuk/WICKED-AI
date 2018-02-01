if (isServer) then {

	private ["_killedat","_sound"];

	diag_log "WAI: AI Monitor Started";

	while {true} do {
	
		if (ai_clean_dead) then {
			{
				_killedat = _x getVariable "killedat";
				if (!isNil "_killedat") then {
					if ((time - _killedat) >= ai_cleanup_time) then {
						//Delete flies and body
						if (dayz_enableFlies) then {
							PVCDZ_flies = [0,_x];
							publicVariable "PVCDZ_flies";
							_sound = _x getVariable ["sched_co_fliesSource", nil];
							if !(isNil "_sound") then {
								detach _sound;
								deleteVehicle _sound;
							};
						};
						_x spawn {
							// Wait for PVEH to finish on all clients
							if (dayz_enableFlies) then {uiSleep 15;};
							_this call sched_co_deleteVehicle;
						};
					};
				};
			} forEach allDead;
		};

		if(debug_mode) then {
			diag_log format ["WAI: %1 Active ground units", ai_ground_units];
			diag_log format ["WAI: %1 Active emplacement units", ai_emplacement_units];
			diag_log format ["WAI: %1 Active chopper patrol units (Crew)", ai_air_units];
			diag_log format ["WAI: %1 Active vehicle patrol units (Crew)", ai_vehicle_units];
		};

		uiSleep 60;

	};

};
