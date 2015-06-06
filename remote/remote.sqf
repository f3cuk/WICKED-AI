if(!isDedicated) then {

	fnc_remote_message = {
	
		private ["_type","_message","_player"];
	
		_type 		= _this select 0;
		_message 	= _this select 1;
		
		call {
			if(_type == "radio") exitWith { 
				if(player hasWeapon "ItemRadio") then { 
					if(player getVariable["radiostate",true]) then {
						systemChat _message;
						[objNull,player,rSAY,"Radio_Message_Sound",30] call RE;
					};
				}; 
			};
			if(_type == "global") exitWith { systemChat _message; };
		};
	};
	
	"RemoteMessage" addPublicVariableEventHandler { (_this select 1) call fnc_remote_message; };

};

remote_ready = true;
