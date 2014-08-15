if(isServer) then {

	private [_missiontype,_playerPresent];

	_missiontype 	= select 0;
	_playerPresent 	= false;

	switch _missiontype do {

		case 0 : { // capture the box

			waitUntil
			{
				sleep 5;

				_playerPresent = false;

				{
					if((isPlayer _x) && (_x distance _position <= 30)) then {
						_playerPresent = true
					};
				} forEach playableUnits;

				(_playerPresent)
			};

		};

		case 1 : { // kill all ai ground

			waitUntil
			{
				sleep 5;

				_playerPresent = false;

				{
					if(ai_ground_units == 0 && ai_vehicle_units == 0) then {
						_playerPresent = true
					};
				} forEach playableUnits;

				(_playerPresent)
			};

		};

	};

};