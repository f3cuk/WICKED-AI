if(isServer) then {

	private ["_tanktraps","_mines","_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition"];

	_position 		= safepos call BIS_fnc_findSafePos;
	_tanktraps		= [];
	_mines			= [];	
	
	diag_log 		format["WAI: Mission Armed Chopper Started At %1",_position];

	//Sniper Gun Box
	_box 		= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
	[_box] 		call Sniper_Gun_Box;

	//Military Chopper
	_vehclass 		= armed_chopper call BIS_fnc_selectRandom;
	_vehname		= getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

	_veh 			= createVehicle [_vehclass,_position, [], 0, "CAN_COLLIDE"];
	_vehdir 		= round(random 360);
	_veh 			setDir _vehdir;
	[_veh,true] 	call custom_publish;
	
	diag_log format["WAI: Mission Armed Chopper spawned a %1",_vehname];
	
	// deploy roadkill defense (or not)
	if(wai_enable_tank_traps) then {
		_tanktraps = [_position] call tank_traps;
	};
	
	if(wai_enable_minefield) then {
		_mines = [_position,50,100,50] call minefield;
	};
	
	//Troops
	_rndnum = round (random 4) + 2;
	[[_position select 0, _position select 1, 0],_rndnum,"hard","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"hard","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Random","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Random","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;

	//Turrets
	[[[(_position select 0) + 10, (_position select 1) - 10, 0],[(_position select 0) - 10, (_position select 1) + 10, 0]],"M2StaticMG","easy","Random",0,2,"Random","Random","Bandit",true] call spawn_static;

	if(wai_enable_tank_traps) then {
		[_position] call tank_traps;
	};

	[_position,"Medium",format["Disabled %1", _vehname],"Bandit"] execVM wai_marker;

	[nil,nil,rTitleText,"A bandit helicopter is taking off with a crate of snipers! Save the cargo and take their chopper.", "PLAIN",10] call RE;

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

		[0] call mission_type;

		[_box,"Survivors have secured the armed chopper!",[_tanktraps,_mines]] call mission_succes;	

	} else {

		[[_box,_veh,_tanktraps,_mines],"Survivors did not secure the armed chopper in time!"] call mission_failure;

	};

	diag_log format["WAI: Mission armed chopper ended at %1",_position];

	missionrunning = false;

};