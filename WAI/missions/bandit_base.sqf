if(isServer) then {

	//Bandit Base
	 
	private ["_position","_box","_missiontimeout","_cleanmission","_playerPresent","_starttime","_currenttime","_cleanunits","_rndnum"];

	_position 		= safepos call BIS_fnc_findSafePos;
	diag_log 		format["WAI: Mission bandit base started at %1",_position];

	//Extra Large Gun Box
	_box 			= createVehicle ["RUVehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_box] 			call Extra_Large_Gun_Box;
	 
	//Buildings 
	_baserunover 	= createVehicle ["land_fortified_nest_big",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover1 	= createVehicle ["land_fortified_nest_big",[(_position select 0) + 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover2 	= createVehicle ["land_fortified_nest_big",[(_position select 0), (_position select 1) - 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover3 	= createVehicle ["land_fortified_nest_big",[(_position select 0), (_position select 1) + 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover4 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0) - 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover5 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0) + 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover6 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0), (_position select 1) - 10,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover7 	= createVehicle ["Land_Fort_Watchtower",[(_position select 0), (_position select 1) + 10,-0.2],[], 0, "CAN_COLLIDE"];

	_baserunover 	setDir 90;
	_baserunover1 	setDir 270;
	_baserunover2 	setDir 0;
	_baserunover3 	setDir 180;
	_baserunover4 	setDir 0;
	_baserunover5 	setDir 180;
	_baserunover6 	setDir 270;
	_baserunover7 	setDir 90;

	_baserunover 	setVectorUp surfaceNormal position _baserunover;
	_baserunover1 	setVectorUp surfaceNormal position _baserunover1;
	_baserunover2 	setVectorUp surfaceNormal position _baserunover2;
	_baserunover3 	setVectorUp surfaceNormal position _baserunover3;
	_baserunover4 	setVectorUp surfaceNormal position _baserunover4;
	_baserunover5 	setVectorUp surfaceNormal position _baserunover5;
	_baserunover6 	setVectorUp surfaceNormal position _baserunover6;
	_baserunover7 	setVectorUp surfaceNormal position _baserunover7;

	//Group Spawning
	_rndnum = round (random 3) + 4;
	[[_position select 0, _position select 1, 0],_rndnum,"hard","Random",4,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"hard","Random",4,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Random","Random",4,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Random","Random",4,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],4,"Random","Random",4,"Random","Random","Random",true] call spawn_group;
	 
	//Humvee Patrol
	[[(_position select 0) + 40, _position select 1, 0],[(_position select 0) + 40, _position select 1, 0],50,2,"HMMWV_Armored","Random"] spawn vehicle_patrol;
	 
	//Turrets
	[[[(_position select 0) - 10, (_position select 1) + 10, 0]],"M2StaticMG","easy","Random",0,2,"Random","Random",true] call spawn_static;
	[[[(_position select 0) + 10, (_position select 1) - 10, 0]],"M2StaticMG","easy","Random",0,2,"Random","Random",true] call spawn_static;
	[[[(_position select 0) + 10, (_position select 1) + 10, 0]],"M2StaticMG","easy","Random",0,2,"Random","Random",true] call spawn_static;
	[[[(_position select 0) - 10, (_position select 1) - 10, 0]],"M2StaticMG","easy","Random",0,2,"Random","Random",true] call spawn_static;

	//Heli Paradrop
	[[(_position select 0), (_position select 1), 0],[0,0,0],400,"UH1H_DZ",10,1,"Random",4,"Random","Random","Random",false] spawn heli_para;

	if(wai_enable_tank_traps) {
		[_position] call tank_traps;
	};

	[_position,"[Extrme] Bandit Base"] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";

	[nil,nil,rTitleText,"A jungle task force have set up a temporary encampment! Go and ambush it to make it yours!","PLAIN",10] call RE;

	_missiontimeout = true;
	_cleanmission = false;
	_playerPresent = false;
	_starttime = floor(time);

	while {_missiontimeout} do {
		sleep 5;
		_currenttime = floor(time);
		{
			if((isPlayer _x) && (_x distance _position <= 150)) then {
				_playerPresent = true
			};
		}forEach playableUnits;

		if ((_currenttime - _starttime) >= wai_mission_timeout) then {
			_cleanmission = true;
		};

		if ((_playerPresent) || (_cleanmission)) then {
			_missiontimeout = false;
		};
	};

	if (_playerPresent) then {

		[0] call mission_type;

		deleteVehicle _sign;

		[_box,"Survivors captured the base, HOOAH!!"] call mission_succes;

	} else {



		[[_box,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7,_sign],_x,"Survivors were unable to capture the base"] call mission_failure;

	};

	diag_log format["WAI: Mission bandit base ended at %1 ended",_position];

	missionrunning = false;

};