private ["_wp","_skill","_mission","_wp_rad","_wp","_pos_x","_pos_y","_pos_z","_unitGroup","_position"];

_unitGroup 		= _this select 0;
_position 		= _this select 1;
_pos_x 			= _position select 0;
_pos_y 			= _position select 1;
_pos_z 			= _position select 2;
_wp_rad 		= 0;

if(count _this > 2) then {

	_skill = _this select 2;
	
	_wp_rad = call {
		if (_skill == "easy") exitWith {20;};
		if (_skill == "medium") exitWith {40;};
		if (_skill == "hard") exitWith {80;};
		if (_skill == "extreme") exitWith {120;};
		if (_skill == "random") exitWith {random(100);};
	};
};

// AI is on a building so limit the movement
if (_pos_z > 1) then {
	_wp_rad = 0;
};

{
	_wp = _unitGroup addWaypoint [_x,10];
	_wp setWaypointType "MOVE";

} count [[_pos_x,(_pos_y+_wp_rad),0],[(_pos_x+_wp_rad),_pos_y,0],[_pos_x,(_pos_y-_wp_rad),0],[(_pos_x-_wp_rad),_pos_y,0]];

_wp = _unitGroup addWaypoint [[_pos_x,_pos_y,0],_wp_rad];
_wp setWaypointType "CYCLE";

