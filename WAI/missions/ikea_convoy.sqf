if(isServer) then {

	private["_tanktraps","_mines","_objPosition3","_objPosition2","_vehclass3","_vehclass2","_veh3","_veh2","_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition"];

	_position		= safepos call BIS_fnc_findSafePos;
	_tanktraps		= [];
	_mines			= [];

	diag_log		format["WAI: Mission Convoy Started At %1",_position];

	//Construction Supply Box
	_box 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_box] 			call Construction_Supply_box;

	// Cargo Truck
	_vehclass 		= cargo_trucks call BIS_fnc_selectRandom;
	[_vehclass,_position] call custom_publish;
	diag_log format["WAI: Mission Convoy spawned a %1",_vehclass];
	
	// Refuel Truck
	_vehclass2 		= refuel_trucks call BIS_fnc_selectRandom;
	[_vehclass2,_position] call custom_publish;
	diag_log format["WAI: Mission Convoy spawned a %1",_vehclass2];

	// Military Unarmed
	_vehclass3 		= military_unarmed call BIS_fnc_selectRandom;
	[_vehclass3,_position] call custom_publish;
	diag_log format["WAI: Mission convoy spawned a %1",_vehclass3];

	// deploy roadkill defense (or not)
	if(wai_enable_tank_traps) then {
		_tanktraps = [_position] call tank_traps;
	};
	
	if(wai_enable_minefield) then {
		_mines = [_position,50,100,50] call minefield;
	};
	
	//Troops
	_rndnum = round (random 3) + 5;
	[[_position select 0, _position select 1, 0],_rndnum,"hard","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"hard","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"Random","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;
	[[_position select 0, _position select 1, 0],5,"Random","Random",4,"Random","Random","Random","Bandit",true] call spawn_group;

	//Turrets
	[[[(_position select 0) + 5, (_position select 1) + 10, 0],[(_position select 0) - 5, (_position select 1) - 10, 0],[(_position select 0) - 5, (_position select 1) - 15, 0]],"M2StaticMG","easy","Random",1,2,"Random","Random","Bandit",true] call spawn_static;

	//Heli Para Drop
	[[(_position select 0),(_position select 1),0],[0,0,0],400,"BAF_Merlin_HC3_D",10,"Random","Random",4,"Random","Random","Random","Bandit",false] spawn heli_para;

	if(wai_enable_tank_traps) then {
		[_position] call tank_traps;
	};

	[_position,"Hard","Disabled Convoy","Bandit"] execVM wai_marker;
	
	[nil,nil,rTitleText,"An Ikea delivery has been hijacked by bandits, take over the convoy and the building supplies are yours!", "PLAIN",10] call RE;

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

		[_box,"Survivors have secured the building supplies!",[_tanktraps,_mines]] call mission_succes;

	} else {
		
		[[_box,_veh,_veh2,_veh3,_tanktraps,_mines],"Survivors did not secure the convoy in time!"] call mission_failure;
		
	};

	diag_log format["WAI: Mission Ikea convoy ended at %1",_position];

	missionrunning = false;

}