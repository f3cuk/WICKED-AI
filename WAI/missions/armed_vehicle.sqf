if(isServer) then {

	//Armed Vehicle

	private ["_static_gun","_crate_type","_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition"];

	_position 		= safepos call BIS_fnc_findSafePos;
	diag_log 		format["WAI: Mission Armed Vehicle Started At %1",_position];

	_vehclass 		= armed_vehicle call BIS_fnc_selectRandom;
	_vehname		= getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

	//Chain Bullet Box
	_crate_type = wai_crates call BIS_fnc_selectRandom;
	_box 			= createVehicle [_crate_type,[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
	[_box] call chain_bullet_box;

	//Armed Land Vehicle
	_veh 			= createVehicle [_vehclass,_position, [], 0, "CAN_COLLIDE"];
	_vehdir 		= round(random 360);
	_veh 			setDir _vehdir;
	_veh 			setVariable ["ObjectID","1",true];

	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_veh];
	_objPosition 	= getPosATL _veh;

	diag_log format["WAI: Mission Armed Vehicle spawned a %1",_vehname];

	//Troops
	_rndnum = (2 + round (random 4));
	[[_position select 0, _position select 1, 0],_rndnum,"medium","Random",3,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"medium","Random",3,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Random","Random",3,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],_rndnum,"Random","Random",3,"Random","Random","Random",true] call spawn_group;

	//Turrets
	_static_gun = ai_static_weapons call BIS_fnc_selectRandom;
	[[[(_position select 0), (_position select 1) + 10, 0]],_static_gun,"easy","Random",0,2,"Random","Random",true] call spawn_static;

	[_position,format["[Medium] Disabled %1", _vehname]] execVM wai_marker;

	[nil,nil,rTitleText,"Bandits have disabled an armed vehicle with lots of chain gun ammo in the gear! Check your map for the location!", "PLAIN",10] call RE;

	_missiontimeout 			= true;
	_cleanmission 				= false;
	_playerPresent				= false;
	_starttime 					= floor(time);

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

		[_veh,[_vehdir,_objPosition],_vehclass,true,"0"] call custom_publish;

		[_box,"Survivors have secured the armed vehicle!"] call mission_succes;

	} else {

		[[_box,_veh],"Survivors did not secure the armed vehicle in time"] call mission_failure;
		
	};

	diag_log format["WAI: Mission armed vehicle ended at %1",_position];

	missionrunning = false;

};