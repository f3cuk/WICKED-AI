if(isServer) then {

	private["_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_position","_num_guns","_num_tools","_num_items","_rndnum","_rndgro"];

	_position 		= safepos call BIS_fnc_findSafePos;
	
	diag_log 		format["WAI: Ural Attack mission started at %1",_position];

	_baserunover 	= createVehicle ["UralWreck",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];

	_num_guns		= (1 + round (random 3));
	_num_tools		= (3 + round (random 8));
	_num_items		= (6 + round (random 36));

	//Medium Gun Box
	_box = createVehicle ["BAF_VehicleBox",[(_position select 0) - 20,(_position select 1) - 20,0], [], 0, "CAN_COLLIDE"];
	[_box,_num_guns,_num_tools,_num_items] call spawn_ammo_box;

	_rndnum 	= round (random 4) + 1;
	_rndgro 	= 1 + round (random 3);

	for "_i" from 0 to _rndgro do {
		[[_position select 0, _position select 1, 0],_rndnum,"easy","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;
	};

	[_position,"Easy","Ural Attack","Bandit"] execVM wai_marker;

	[nil,nil,rTitleText,"Bandits have destroyed a Ural with supplies and are securing the cargo! Check your map for the location!", "PLAIN",10] call RE;
		
	_missiontimeout 	= true;
	_cleanmission 		= false;
	_playerPresent 		= false;
	_starttime 			= floor(time);

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

		[1] call mission_type;

		[_box,"The supplies have been secured by survivors!"] call mission_succes;	

	} else {

		[[_box,_baserunover],"Survivors did not secure the supplies in time"] call mission_failure;

	};

	diag_log format["WAI: Ural attack mission ended at %1",_position];

	missionrunning = false;

};