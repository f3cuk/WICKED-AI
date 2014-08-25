if(isServer) then {
	
	private ["_difficulty","_mission","_type","_color","_dot","_position","_marker","_name"];

	_position 	= _this select 0;
	_difficulty = _this select 1;
	_name		= _this select 2;
	_type		= _this select 3;
	_mines		= _this select 4;
	
	_mission 	= count wai_mission_data;
	//diag_log("WAI: Starting Mission number " + str(_mission + 1));
	wai_mission_data = wai_mission_data + [[0,_type,[]]];

	if(wai_enable_minefield && _mines) then {
		call {
			if (_difficulty == "Easy") exitWith {_mines = [_position,25,50,10] call minefield;};
			if (_difficulty == "Medium") exitWith {_mines = [_position,50,75,25] call minefield;};
			if (_difficulty == "Hard") exitWith {_mines = [_position,50,100,50] call minefield;};
			if (_difficulty == "Extreme") exitWith {_mines = [_position,50,100,75] call minefield;};
		};
		wai_mission_data select _mission set [2, _mines];
	};
	
	_marker 	= "";
	_dot 		= "";
	_color		= "";
	
	call {
		if (_difficulty == "Easy")		exitWith {_color = "ColorGreen"};
		if (_difficulty == "Medium")	exitWith {_color = "ColorYellow"};
		if (_difficulty == "Hard")		exitWith {_color = "ColorOrange"};
		if (_difficulty == "Extreme") 	exitWith {_color = "ColorRed"};
		_color = _difficulty;
	};
	
	call {
		if (_type == "MainHero")	exitWith { _name = "[H] " + _name; };
		if (_type == "MainBandit")	exitWith { _name = "[B] " + _name; };
		if (_type == "Special")		exitWith { _name = "[S] " + _name; };
	};

	[_position, _color, _name, _mission] spawn {
		_position	= _this select 0;
		_color 		= _this select 1;
		_name 		= _this select 2;
		_mission 	= _this select 3;
		_running 	= true;
		while {_running} do {
			_type	= (wai_mission_data select _mission) select 1;
			_marker 		= createMarker [_type, _position];
			_marker 		setMarkerColor _color;
			_marker 		setMarkerShape "ELLIPSE";
			_marker 		setMarkerBrush "Solid";
			_marker 		setMarkerSize [300,300];
			_marker 		setMarkerText _name;
			_dot 			= createMarker [_type + "dot", _position];
			_dot 			setMarkerColor "ColorBlack";
			_dot 			setMarkerType "mil_dot";
			_dot 			setMarkerText _name;

			sleep 1;
			deleteMarker 	_marker;
			deleteMarker 	_dot;
			_running = (typeName (wai_mission_data select _mission) == "ARRAY");
		};
	};
	
	//diag_log("WAI: Mission Data: " + str(wai_mission_data));
	markerready = true;
	_mission
};