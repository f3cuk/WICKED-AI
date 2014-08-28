if (isServer) then {

	private ["_skill","_mission","_wp_rad","_wp","_pos_x","_pos_y","_pos_z","_unitGroup","_position"];

	_unitGroup 		= _this select 0;
	_position 		= _this select 1;
	_pos_x 			= _position select 0;
	_pos_y 			= _position select 1;
	_pos_z 			= _position select 2;

	if (count _this > 2) then {
		_mission = _this select 2;
	} else {
		_mission = nil;
	};

	if(count _this > 3) then {

		_skill = _this select 3;
	
		switch (_skill) do {
			case "easy"		: { _wp_rad = 15; };
			case "medium" 	: { _wp_rad = 25; };
			case "hard" 	: { _wp_rad = 35; };
			case "extreme" 	: { _wp_rad = 50; };
			case "Random" 	: { _wp_rad = 15; };
			default { _wp_rad = 15; };
		};

	} else {

		_wp_rad = 15;

	};

	{
		private["_wp"];

		_wp = _unitGroup addWaypoint [_x,_wp_rad];
		_wp setWaypointType "MOVE";

	} count [[_pos_x,(_pos_y+_wp_rad),0],[(_pos_x+_wp_rad),_pos_y,0],[_pos_x,(_pos_y-_wp_rad),0],[(_pos_x-_wp_rad),_pos_y,0]];

	_wp = _unitGroup addWaypoint [[_pos_x,_pos_y,0],_wp_rad];
	_wp setWaypointType "CYCLE";


};