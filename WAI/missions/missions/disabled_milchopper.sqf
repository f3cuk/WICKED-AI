//Military Chopper

private ["_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition"];

_position 		= safepos call BIS_fnc_findSafePos;
diag_log 		format["WAI: Mission Armed Chopper Started At %1",_position];

_vehclass 		= armed_chopper call BIS_fnc_selectRandom;
_vehname		= getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");

//Sniper Gun Box
_box 		= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
[_box] 		call Sniper_Gun_Box;

//Military Chopper
_veh 		= createVehicle [_vehclass,_position, [], 0, "CAN_COLLIDE"];
_vehdir 	= round(random 360);
_veh 		setDir _vehdir;
clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
_veh 		setVariable ["ObjectID","1",true];
PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_veh];
_objPosition = getPosATL _veh;

diag_log format["WAI: Mission Armed Chopper spawned a %1",_vehname];

//Troops
_rndnum = round (random 4) + 2;
[[_position select 0, _position select 1, 0],_rndnum,1,"hard",4,"","","Random",true] call spawn_group;
[[_position select 0, _position select 1, 0],_rndnum,1,"hard",4,"","","Random",true] call spawn_group;
[[_position select 0, _position select 1, 0],_rndnum,1,"Random",4,"","","Random",true] call spawn_group;
[[_position select 0, _position select 1, 0],_rndnum,1,"Random",4,"","","Random",true] call spawn_group;

//Turrets
[[[(_position select 0) + 10, (_position select 1) - 10, 0], [(_position select 0) - 10, (_position select 1) + 10, 0]],"M2StaticMG",0.8,"",0,2,"","Random",true] call spawn_static;

[_position,format["[Medium] Disabled %1", _vehname]] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";

[nil,nil,rTitleText,"A bandit helicopter is taking off with a crate of snipers! Save the cargo and take their chopper.", "PLAIN",10] call RE;

_missiontimeout 	= true;
_cleanmission 		= false;
_playerPresent 		= false;
_starttime 			= floor(time);

while {_missiontimeout} do {
	sleep 5;
	_currenttime = floor(time);
	{if((isPlayer _x) && (_x distance _position <= 150)) then {_playerPresent = true};}forEach playableUnits;
	if (_currenttime - _starttime >= wai_mission_timeout) then {_cleanmission = true;};
	if ((_playerPresent) || (_cleanmission)) then {_missiontimeout = false;};
};

if (_playerPresent) then {

	[_veh,[_vehdir,_objPosition],_vehclass,true,"0"] call custom_publish;

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

	[nil,nil,rTitleText,"Survivors have secured the armed chopper!", "PLAIN",10] call RE;

} else {

	clean_running_mission 	= true;
	deleteVehicle 			_veh;
	deleteVehicle 			_box;

	{
		_cleanunits = _x getVariable "missionclean";

		if (!isNil "_cleanunits") then {
			switch (_cleanunits) do {
				case "ground" :  {ai_ground_units = (ai_ground_units -1);};
				case "air" :     {ai_air_units = (ai_air_units -1);};
				case "vehicle" : {ai_vehicle_units = (ai_vehicle_units -1);};
				case "static" :  {ai_emplacement_units = (ai_emplacement_units -1);};
			};
			deleteVehicle _x;
			sleep 0.05;
		};	

	} forEach allUnits;
	
	[nil,nil,rTitleText,"Survivors did not secure the armed chopper in time!", "PLAIN",10] call RE;
};

diag_log format["WAI: Mission armed chopper ended at %1",_position];
missionrunning = false;