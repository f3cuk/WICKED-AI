if(isServer) then {

	private ["_color","_dot","_position","_marker","_name"];
	_position 	= _this select 0;
	_difficulty = _this select 1;
	_name 		= _this select 2;
	_type		= _this select 3;

	_marker 	= "";
	_dot 		= "";
	markerready = false;
	_color		= "ColorBlack";
	
	call {
		if (_difficulty == "Easy")		exitWith {_color = "ColorGreen"};
		if (_difficulty == "Medium")	exitWith {_color = "ColorYellow"};
		if (_difficulty == "Hard")		exitWith {_color = "ColorOrange"};
		if (_difficulty == "Extreme") 	exitWith {_color = "ColorRed"};
	};
	call {
		if (_type == "Bandit")	exitWith { _name = "[B] " + _name; };
		if (_type == "Hero")	exitWith { _name = "[H] " + _name; };
	};


	while {missionrunning} do {

		_marker 		= createMarker ["Mission", _position];
		_marker 		setMarkerColor _color;
		_marker 		setMarkerShape "ELLIPSE";
		_marker 		setMarkerBrush "Solid";
		_marker 		setMarkerSize [300,300];
		_marker 		setMarkerText _name;
		_dot 			= createMarker ["dot", _position];
		_dot 			setMarkerColor "ColorBlack";
		_dot 			setMarkerType "mil_dot";
		_dot 			setMarkerText _name;

		for "_i" from 0 to 30 do {
			sleep 1;
			if !(missionrunning) exitWith {};
		};

		deleteMarker 	_marker;
		deleteMarker 	_dot;

	};

	if (_marker == "Mission") then {

		deleteMarker 	_marker;
		deleteMarker 	_dot;

	};

	markerready = true;

};