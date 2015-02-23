if(!isDedicated) then {
	fnc_wai_client = {
		private ["_type","_position"];
		_type 		= _this select 0;
		// Can be used as option variable
		if (count _this > 1) then {
			_position = _this select 1;
		};
		
		switch (_type) do {
			// NUKE
			case "nuke":
			{
				// Count down 10 sec.
				0 = [_position] spawn {
					private["_position","_number"];
					_number 	= 10;
					_position 	= _this select 0;
					while {_number > 0} do {
						_number = _number - 1;
						0 = ["<t size='0.8' shadow='1' color='#FF0000'>Nuclear detonation in " + str(_number) + "</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
						sleep 1;
					};
					playsound "Alarm_BLUFOR";
				};
				
				0 = [_position] execVM "itsatrap\wai\nuke.sqf";
			};
			// 
			case "vehiclehit": {
				// Blow front wheels
				// _position is used as _player
				diag_log("Blow front wheels");
				(vehicle _position) sethit ["wheel_1_1_steering", 1];
				(vehicle _position) sethit ["wheel_2_1_steering", 1];

			};
		};
	
	};
	fnc_remote_message = {
	
		private ["_type","_message","_player","_items","_radio","_hasRadio","_hint","_i"];
	
		_type 		= _this select 0;
		_message 	= _this select 1;
		_items 		= assignedItems player;
		
		_hint = parseText format["
		<t align='center' color='#FF0033' shadow='1' size='1.5'>Mission</t><br/>
		<t size='1.0' align='center' color='#ffffff'>%1</t><br/>",_message];

		call {
			if(_type == "radio") exitWith {
				for [{_i=0},{_i<10},{_i=_i+1}] do
                {
					_radio = format ["EpochRadio%1",_i];
                    _hasRadio = _radio in _items;
                    
					if (_hasRadio) then {
						hintSilent _hint;
						playSound "RadioAmbient6";
					};
                };
			};
			
			if(_type == "global") exitWith { systemChat _message; };
			if(_type == "hint") exitWith { hintSilent _hint; };
			if(_type == "text") exitWith { 0 =["<t size='0.8' shadow='0' color='#99ffffff'>" + _message + "</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext; };
		};
	};
	
	"RemoteMessage" addPublicVariableEventHandler { (_this select 1) call fnc_remote_message; };
	"WAIclient" addPublicVariableEventHandler { (_this select 1) call fnc_wai_client; };
};
remote_ready = true;