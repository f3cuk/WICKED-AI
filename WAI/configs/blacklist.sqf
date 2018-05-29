
call {
	if (toLower worldName == "chernarus") exitWith {wai_blacklist = [
		[[0,16000,0],[1000,-0,0]],				// Left
		[[0,16000,0],[16000.0,14580.3,0]]		// Top
	];};
	if (toLower worldName == "namalsk") exitWith {wai_blacklist = [];};
	if (toLower worldName == "panthera") exitWith {wai_blacklist = [];};
	if (toLower worldName == "tavi") exitWith {wai_blacklist = [];};
	if (toLower worldName == "lingor") exitWith {wai_blacklist = [];};
	if (toLower worldName == "napf") exitWith {wai_blacklist = [];};
	if (toLower worldName == "smd_sahrani_a2") exitWith {wai_blacklist = [];};
	if (toLower worldName == "sauerland") exitWith {wai_blacklist = [];};
	wai_blacklist = []; diag_log "You are on an unsupported map! No blacklist available."; //default if nothing above matches
};

diag_log "WAI: blacklist Loaded";
