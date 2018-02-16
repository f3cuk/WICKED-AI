
call {
	if (toLower worldName == "chernarus") exitWith {blacklist = [
		[[0,16000,0],[1000,-0,0]],				// Left
		[[0,16000,0],[16000.0,14580.3,0]]		// Top
	];};
	if (toLower worldName == "namalsk") exitWith {blacklist = [];};
	if (toLower worldName == "panthera") exitWith {blacklist = [];};
	if (toLower worldName == "tavi") exitWith {blacklist = [];};
	if (toLower worldName == "lingor") exitWith {blacklist = [];};
	if (toLower worldName == "napf") exitWith {blacklist = [];};
	if (toLower worldName == "smd_sahrani_a2") exitWith {blacklist = [];};
	if (toLower worldName == "sauerland") exitWith {blacklist = [];};
};

diag_log "WAI: Blacklist Loaded";
