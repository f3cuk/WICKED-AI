if(isServer) then {

	diag_log "WAI: Initialising static missions";

	if(custom_per_world) then {

		ExecVM format["\WAI\static\%1.sqf",toLower(worldName)];

	} else {

		ExecVM "\WAI\static\default.sqf";

	};

};
