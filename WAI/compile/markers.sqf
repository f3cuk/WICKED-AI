if(isServer) then {

	private ["_color","_dot","_position","_marker","_name"];
	_position 	= _this select 0;
	_name 		= _this select 1;
	_type		= _this select 2;

	switch (_type) do {
		case "Bandit":	{ _color = "ColorRed"; };
		case "Hero":	{ _color = "ColorGreen"; };
		case "":		{ _color = "ColorBlack"; };
	};
	if (isNil "_color") then { _color = "ColorBlack"; };
	_marker 	= "";
	_dot 		= "";
	markerready = false;

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

		sleep 30;

		deleteMarker 	_marker;
		deleteMarker 	_dot;

	};

	if (_marker == "Mission") then {

		deleteMarker 	_marker;
		deleteMarker 	_dot;

	};

	markerready = true;

};