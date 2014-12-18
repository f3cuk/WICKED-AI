if(isServer) then {

	private["_bomb","_area_max","_area_min","_position", "_area", "_num_mines","_allmines"];

	_position 	= _this select 0;
	_area_min 	= _this select 1;
	_area_max 	= _this select 2;
	_num_mines	= _this select 3;
	_allmines 	= [];
	
	for "_x" from 1 to _num_mines do {

		private["_mine_pos","_mine"];
		
		_mine_pos = [_position,_area_min,_area_max,10,0,2000,0] call BIS_fnc_findSafePos;
		_mine = createVehicle ["Mine", _mine_pos, [], 0, "CAN_COLLIDE"];

		_mine spawn {

			private["_vehicle_near","_bomb"];
			
			waitUntil
			{
				_vehicle_near = false;
				{
					if((isPlayer _x) && (vehicle _x != _x) && (vehicle _x distance _this < 4)) then {
						_vehicle_near = true
					};
				} count playableUnits;
				(_vehicle_near)
			};
			_bomb = "Bo_GBU12_lgb" createVehicle (getPosATL _this);
			sleep 3;
			deleteVehicle _bomb;
			deleteVehicle _this;
		};

		_allmines set [(count _allmines), _mine];

	};
	
	_allmines;

};