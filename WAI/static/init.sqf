if(isServer) then {

	diag_log "WAI: Initialising static missions";

	if(custom_per_world) then {

		ExecVM format["\z\addons\dayz_server\WAI\static\%1.sqf",toLower(worldName)];

	} else {

		ExecVM "\z\addons\dayz_server\WAI\static\default.sqf";

	};
	wai_staticloaded = true;
};
