if(isServer) then {

	//Mayors Mansion

	private 		["_position","_box","_missiontimeout","_cleanmission","_playerPresent","_starttime","_currenttime","_cleanunits","_rndnum"];

	_position		= safepos call BIS_fnc_findSafePos;
	diag_log 		format["WAI: Mission Mayors Mansion Started At %1",_position];

	vehclass 		= military_unarmed call BIS_fnc_selectRandom;

	//Large Gun Box
	_box = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1), .5], [], 0, "CAN_COLLIDE"];
	[_box] call Large_Gun_Box;
	 
	//Mayors Mansion
	_baserunover 	= createVehicle ["Land_A_Villa_EP1",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];

	_rndnum = round (random 3) + 4;
	[[_position select 0, _position select 1, 0],4,"medium","Random",4,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"medium","Random",4,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Random","Random",4,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Random","Random",4,"Random","Random","Random",true] call spawn_group;

	//The Mayor Himself
	[[_position select 0, _position select 1, 0],1,1,"Random",4,"","Functionary1_EP1_DZ","Random",true] call spawn_group;
	 
	[[[(_position select 0) - 15, (_position select 1) + 15, 8],[(_position select 0) + 15, (_position select 1) - 15, 8]],"M2StaticMG","easy","Random",1,2,"Random","Random",true] call spawn_static;
	 
	[_position,"[Medium] Mayors Mansion"] execVM wai_marker;

	[nil,nil,rTitleText,"The Mayor has gone rogue, go take him and his task force out to claim the black market weapons!", "PLAIN",10] call RE;

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

		[_box,"The rogue mayor has been taken out, who will be the next Mayor of Cherno?"] call mission_succes;
			
	} else {

		[[_box,_baserunover],"The survivors were unable to capture the mansion, time is up"] call mission_failure;

	};

	diag_log format["WAI: Mission Mayors Mansion ended at %1",_position];

	missionrunning = false;

};