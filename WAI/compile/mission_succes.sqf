if(isServer) then {

	private["_box","_name","_marker_add","_delete_leftovers","_flare_light"];

	_box 				= _this select 0;
	_statement			= _this select 1;
	_delete_leftovers	= _this select 2;

	if(wai_crates_smoke) then {

		if (sunOrMoon != 1) then {
			_marker_add = "RoadFlare" createVehicle getPosATL _box;
			_marker_add setPosATL (getPosATL _box);
			_marker_add attachTo [_box, [0,0,0]];
			_flare_light = [_marker_add,0] spawn object_roadFlare;
		} else {
			_marker_add = "smokeShellPurple" createVehicle getPosATL _box;
			_marker_add setPosATL (getPosATL _box);
			_marker_add attachTo [_box,[0,0,0]];
		};
		
	};

	if(count _delete_leftovers > 0) then {

		{
			if(typeName _x == "ARRAY") then {
			
				{
					deleteVehicle _x;
				} forEach _x;
			
			} else {
			
				deleteVehicle _x;
			};
			
		} forEach _delete_leftovers;
		
	};

	[nil,nil,rTitleText,format["%1", _statement], "PLAIN",10] call RE;

};