	if(isServer) then {

	//Black Hawk Crash

	private ["_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_position"];

	_position 		= safepos call BIS_fnc_findSafePos;
	diag_log 		format["WAI: Wrecked Black Hawk mission started at %1",_position];

	_num_guns		= round(random 5);
	_num_tools		= round(random 5);
	_num_items		= round(random 10);

	//Dynamic Box
	_box 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_box,_num_guns,_num_tools,_num_items] call spawn_ammo_box;

	_baserunover 	= createVehicle ["UH60_ARMY_Wreck_burned_DZ",[((_position select 0)  + 5 + random 15), ((_position select 1)  + 5 + random 15), 0], [], 0, "CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	[[_position select 0, _position select 1, 0],3,"Random","Random",4,"Random","Random","Random",true] call spawn_group;
	[[_position select 0, _position select 1, 0],3,"Random","Random",4,"Random","Random","Random",true] call spawn_group;

	//Turrets
	[[[(_position select 0) + 10, (_position select 1) + 10, 0],[(_position select 0) + 10, (_position select 1) - 10, 0]],"M2StaticMG","easy","Random",0,2,"Random","Random",true] call spawn_static;

	[_position,"[Medium] Black Hawk Crash"] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";

	[nil,nil,rTitleText,"A Black Hawk carrying supplies has crashed and bandits are securing the site! Check your map for the location!", "PLAIN",10] call RE;
		
	_missiontimeout 		= true;
	_cleanmission 			= false;
	_playerPresent 			= false;
	_starttime 				= floor(time);

	while {_missiontimeout} do {
		sleep 5;
		_currenttime = floor(time);
		{if((isPlayer _x) AND (_x distance _position <= 150)) then {_playerPresent = true};}forEach playableUnits;
		if (_currenttime - _starttime >= wai_mission_timeout) then {_cleanmission = true;};
		if ((_playerPresent) OR (_cleanmission)) then {_missiontimeout = false;};
	};

	if (_playerPresent) then {

		[0] call mission_type;

		[_box,"Survivors have secured the crashed Black Hawk!"] call mission_succes;

	} else {

		[[_box],_x,"Survivors did not secure the crashed Black Hawk in time"] call mission_failure;
		
	};

	diag_log format["WAI: Wrecked Black Hawk mission ended at %1",_position];
	missionrunning = false;

};