if(isServer) then {

	private["_box","_name","_marker","_delete_leftovers","_inRange"];

	_box 				= _this select 0;
	_statement			= _this select 1;

	if(count _this > 2) then {
		_delete_leftovers	= _this select 2;
	};
	
	if(wai_crates_smoke) then {

		if (sunOrMoon != 1) then {
			_marker = "RoadFlare" createVehicle getPosATL _box;
			_marker setPosATL (getPosATL _box);
			_marker attachTo [_box, [0,0,0]];
			
			_inRange = _box nearEntities ["CAManBase",1250];
			
			{
				if(isPlayer _x && _x != player) then {
					PVDZE_send = [_x,"RoadFlare",[_marker,0]];
					publicVariableServer "PVDZE_send";
				};
			} count _inRange;

		} else {
			_marker = "smokeShellPurple" createVehicle getPosATL _box;
			_marker setPosATL (getPosATL _box);
			_marker attachTo [_box,[0,0,0]];
		};
		
	};

	if(count _this > 2) then {

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