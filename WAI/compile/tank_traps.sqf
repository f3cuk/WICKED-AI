if(isServer) then {

	private["_trigger_pos","_angle","_radius","_distance","_count","_step","_alltraps"];

	_trigger_pos 	= _this select 0;

	_angle 			= 0;
	_radius 		= 75;
	_distance 		= 3.5;
	_count 			= round((2 * 3.14592653589793 * _radius) / _distance);
	_step 			= 360/_count;
	_alltraps 		= [];

	for "_x" from 0 to _count do
	{
		private["_pos","_trap"];

		_a = (_trigger_pos select 0) + (sin(_angle)*_radius);
		_b = (_trigger_pos select 1) + (cos(_angle)*_radius);

		_pos 		= [_a,_b];
		_angle 		= _angle + _step;
		_trap 		= createVehicle ["Hedgehog", _pos, [], 0, "CAN_COLLIDE"];
		_alltraps 	set [(count _alltraps), _trap];

	};
	
	_alltraps;
	
};