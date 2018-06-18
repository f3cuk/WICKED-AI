fnc_remote_message = {
	private ["_type","_message"];
	
	_type = _this select 0;
	_message = _this select 1;

	if (["STR_", _message] call fnc_inString) then {
		_message = localize _message;
	};
	
	if (_type == "radio") exitWith {
		if (player hasWeapon "ItemRadio") then {
			if (player getVariable["radiostate",true]) then {
				systemChat ("[RADIO] " + _message);
				playSound "Radio_Message_Sound";
			};
		};
	};
	if (_type == "IWAC") exitWith {
		if (player hasWeapon "ItemRadio") then {
			if (player getVariable["radiostate",true]) then {
				_message call dayz_rollingMessages;
				playSound "IWAC_Message_Sound";
			};
		};
	};

	if (_type == "private") exitWith {if(getPlayerUID player == (_message select 0)) then {systemChat (_message select 1);};};
	if (_type == "global") exitWith {systemChat _message;};
	if (_type == "hint") exitWith {hint _message;};
	if (_type == "titleCut") exitWith {titleCut [_message,"PLAIN DOWN",3];};
	if (_type == "titleText") exitWith {titleText [_message, "PLAIN DOWN"]; titleFadeOut 10;};
	if (_type == "rollingMessages") exitWith {_message call dayz_rollingMessages;};
	if (_type == "dynamic_text") exitWith {
		[
			format["<t size='0.40' color='#FFFFFF' align='center'>%1</t><br /><t size='0.60' color='#d5a040' align='center'>%2</t>",_message select 0,_message select 1],
			0, // X coordinate
			-0.25, // Y coordinate
			10, // Message duration
			0.5 // fade in
		] spawn BIS_fnc_dynamicText;
	};
	if (_type == "dynamic_text2") exitWith {
		[
			format["<t size='0.60' color='#ff0000' align='center'>%1</t>",_message],
			0, // X coordinate
			+0.5, // Y coordinate
			10, // Message duration
			0.5 // fade in
		] spawn BIS_fnc_dynamicText;
	};
};

"RemoteMessage" addPublicVariableEventHandler {(_this select 1) call fnc_remote_message;};
