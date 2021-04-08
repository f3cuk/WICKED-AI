
wai_blacklist = call {
    if (toLower worldName == "chernarus") exitWith {[
		[[0,16000,0],[1000,-0,0]],	// Left edge of map
        [[0,16000,0],[16000.0,14580.3,0]] // Top edge of map
    ];};
    if (toLower worldName == "panthera2") exitWith {[
		[[235,686,0],[758,160,0]] // Debug Island
	];};
    [];
};

if (count wai_blacklist > 0) then {
	diag_log "WAI: blacklist Loaded";
} else {
	diag_log "WAI: You are on an unsupported map! No blacklist available.";
};