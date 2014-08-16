if(isServer) then {

	private["_delete","_name","_marker_add"];

	_delete_leftovers		= _this select 0;
	_statement				= _this select 1;
	
	clean_running_mission	= true;

	{

		private["_cleanunits"];
		
		_cleanunits = _x getVariable "missionclean";
	
		if (!isNil "_cleanunits") then {

			switch (_cleanunits) do {
				case "ground" :  {ai_ground_units = (ai_ground_units -1);};
				case "air" :     {ai_air_units = (ai_air_units -1);};
				case "vehicle" : {ai_vehicle_units = (ai_vehicle_units -1);};
				case "static" :  {ai_emplacement_units = (ai_emplacement_units -1);};
			};

			deleteVehicle _x;
			sleep 0.05;
		};

	} forEach allUnits;

	{

		deleteVehicle _x;

	} forEach _delete_leftovers;

	[nil,nil,rTitleText,format["%1", _statement], "PLAIN",10] call RE;

};