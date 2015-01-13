if(!isDedicated) then {

	fnc_remote_message = {
	
		private ["_type","_message","_player"];
	
		_type 		= _this select 0;
		_message 	= _this select 1;
		_Radios = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9"];
		call {
			if(_type == "radio")		exitWith { if("_Radios" in (items player + assignedItems player)) then { systemChat _message; }; };
			if(_type == "global")		exitWith { systemChat _message; };
		};
	};
	
	"RemoteMessage" addPublicVariableEventHandler { (_this select 1) call fnc_remote_message; };

};

remote_ready = true;
