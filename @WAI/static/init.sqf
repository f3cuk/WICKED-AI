if(isServer) then {

	diag_log "WAI: Initialising static missions";

	if(custom_per_world) then {

		ExecVM format["\x\addons\WAI\static\%1.sqf",toLower(worldName)];

	} else {

		ExecVM "\x\addons\WAI\static\default.sqf";

	};
	wai_staticloaded = true;
};
