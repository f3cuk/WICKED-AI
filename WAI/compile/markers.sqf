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
	
	switch (_difficulty) do {
		case "Easy":	{_color = "ColorGreen"};
		case "Medium":	{_color = "ColorYellow"};
		case "Hard":	{_color = "ColorOrange"};
		case "Extreme": {_color = "ColorRed"};
	};
	switch (_type) do {
		case "Bandit":	{ _name = "[B] " + _name; };
		case "Hero":	{ _name = "[H] " + _name; };
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