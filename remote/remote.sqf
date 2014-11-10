fnc_remote_message = {

	private ["_type","_message","_player"];

	_type 		= _this select 0;
	_message 	= _this select 1;
	
	call {
		if(_type == "radio")		exitWith { systemChat _message; };
		if(_type == "say")			exitWith { player globalChat _message; };
	};
};

fnc_remote_marker = {

	private ["_player","_location","_shape","_color","_size","_alpha","_timeout","_marker","_name"];

	_player = _this select 0;

	if(player == _player) then {
	
		_location 	= _this select 1;
		_shape 		= _this select 2;
		_color 		= _this select 3;
		_size		= _this select 4;
		_alpha 		= _this select 5;
		_timeout 	= _this select 6;
		_name 		= _this select 7;

		_marker = createMarkerLocal [_name,_location];
		_marker setMarkerShapeLocal _shape;
		_marker setMarkerColorLocal _color;
		_marker setMarkerAlphaLocal _alpha;
		_marker setMarkerSizeLocal [(_size),(_size)];

		[_timeout, _marker] spawn {
			sleep (_this select 0);
			deleteMarkerLocal (_this select 1);
		};

	};

};

"RemoteMessage" addPublicVariableEventHandler { (_this select 1) call fnc_remote_message; };
"RemoteMarker" addPublicVariableEventHandler { (_this select 1) call fnc_custom_marker; };