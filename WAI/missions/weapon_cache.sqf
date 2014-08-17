if(isServer) then {

	private ["_position","_box","_missiontimeout","_cleanmission","_playerPresent","_starttime","_currenttime","_cleanunits","_rndnum","_rndgro","_num_guns","_num_tools","_num_items"];

	_position 		= safepos call BIS_fnc_findSafePos;
	diag_log 		format["WAI: Mission Weapon cache started at %1",_position];

	_num_guns		= (3 + round(random 12));
	_num_tools		= 2;
	_num_items		= 2;

	_box 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_box,_num_guns,_num_tools,_num_items] call spawn_ammo_box;

	_rndnum 	= (1 + round (random 7));
	_rndgro 	= (1 + round (random 3));

	for "_i" from 0 to _rndgro do {
		[[_position select 0, _position select 1, 0],_rndnum,"easy","Random",3,"Random","Random","Random",true] call spawn_group;
	};

	[[[(_position select 0) + 10, (_position select 1) + 10, 0],[(_position select 0) + 10, (_position select 1) - 10, 0]],"M2StaticMG","easy","Random",0,2,"Random","Random",true] call spawn_static;

	[_position,"[Medium] Weapon cache"] execVM wai_marker;

	[nil,nil,rTitleText,"Bandits have obtained a weapon crate. Check your map for the location!", "PLAIN",10] call RE;

	_missiontimeout 		= true;
	_cleanmission 			= false;
	_playerPresent 			= false;
	_starttime 				= floor(time);

	while {_missiontimeout} do {

		sleep 5;
		
		_currenttime = floor(time);

		{
			if((isPlayer _x) && (_x distance _position <= 150)) then {
				_playerPresent = true
			};
		} forEach playableUnits;

		if (_currenttime - _starttime >= wai_mission_timeout) then {
			_cleanmission = true;
		};

		if ((_playerPresent) || (_cleanmission)) then {
			_missiontimeout = false;
		};

	};

	if (_playerPresent) then {

		[0] call mission_type;

		[_box,"Survivors have secured the weapon cache!"] call mission_succes;

	} else {

		[[_box],"Survivors did not secure the weapon cache in time"] call mission_failure;

	};

	diag_log format["WAI: Mission weapon cache ended at %1",_position];

	missionrunning = false;

};