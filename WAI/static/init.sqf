if(isServer) then {

	diag_log "WAI: Initialising static missions";

	if(custom_per_world) then {

		ExecVM format["\a3\wai\static\%1.sqf",toLower(worldName)];

	} else {

		ExecVM "\a3\wai\static\default.sqf";

	};

};
