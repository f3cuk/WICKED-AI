if (isServer) then {

	private ["_veh"];
	
	_veh = _this select 0;

	if (count _this == 2) then {
		_mission = _this select 1;
	} else {
		_mission = nil;
	};
	
	waitUntil { count crew _veh > 0};
	
	while {(alive _veh) && ({alive _x} count crew _veh > 0)} do {
		_veh setVehicleAmmo 1;
		_veh setFuel 1;
		if ({alive _x} count crew _veh == 0) then {
			_veh setDamage 1;
			_veh setVariable ["killedat", time];
		};
		sleep 1;
	};
	_veh setDamage 1;
	_veh setVariable ["killedat", time];
	waitUntil
	{
		sleep 1;
		_playerPresent = false;
		{
			if((isPlayer _x) && (_x distance _veh <= 2000)) exitWith {
				_playerPresent = true
			};
		} forEach playableUnits;
		(!_playerPresent)
	};
	{deleteVehicle _x;} forEach (crew _veh) + [_veh];

};