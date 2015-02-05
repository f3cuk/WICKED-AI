if(!isDedicated) then {

	fnc_remote_message = {
	
		private ["_type","_message","_player","_items","_Radios"];
	
		_type 		= _this select 0;
		_message 	= _this select 1;
		_items 		= assignedItems player;
		_pic = getText(configfile >> "CfgMarkers" >> "KIA" >> "icon");
		
		_hint = parseText format["
		<t align='center' color='#FF0033' shadow='1' size='1.5'>Check your map</t><br/>
		<img align='Center' size='3' image='%1'/><br/>
		<t size='1.0' align='center' color='#ffffff'>%2</t><br/>",_pic,_message];

		call {
			if(_type == "radio") exitWith {
				for [{_i=0},{_i<10},{_i=_i+1}] do
                {
					_radio = format ["EpochRadio%1",_i];
                    _hasRadio = _radio in _items;
                    
					if (_hasRadio) then {
						hintSilent _hint;
					};
                };
			};
			
			if(_type == "global") exitWith { systemChat _message; };
			if(_type == "hint") exitWith { hintSilent _hint; };
			if(_type == "text") exitWith { 
				0 =["<t size='0.8' shadow='0' color='#99ffffff'>" + _message + "</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
			};
		};
	};
	
	"RemoteMessage" addPublicVariableEventHandler { (_this select 1) call fnc_remote_message; };
};

remote_ready = true;