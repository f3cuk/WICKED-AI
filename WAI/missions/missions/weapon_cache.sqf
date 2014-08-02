//Weapon Cache

private ["_position","_box","_missiontimeout","_cleanmission","_playerPresent","_starttime","_currenttime","_cleanunits","_rndnum"];

_position 	= [getMarkerPos "center",0,5500,10,0,2000,0] call BIS_fnc_findSafePos;

diag_log format["WAI: Mission Weapon Cache Started At %1",_position];

_box 		= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
[_box] 		call spawn_ammo_box;

_rndnum = round (random 3) + 4;
[[_position select 0, _position select 1, 0], _rndnum, 1, "Random", 4, "", "Bandit2_DZ", "Random", true] call spawn_group;
[[_position select 0, _position select 1, 0], 4, 1, "Random", 4, "", "Bandit2_DZ", "Random", true] call spawn_group;

[[[(_position select 0), (_position select 1) + 10, 0],[(_position select 0) + 10, (_position select 1), 0]], "M2StaticMG", 0.8, "Bandit2_DZ", 0, 2, "", "Random", true] call spawn_static;


[_position,"Weapon cache"] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";

[nil,nil,rTitleText,"Bandits have obtained a weapon crate! Check your map for the location!", "PLAIN",10] call RE;

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

	[nil,nil,rTitleText,"Survivors have secured the Weapon Cache!", "PLAIN",10] call RE;

} else {

	clean_running_mission 	= true;
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
	
	[nil,nil,rTitleText,"Survivors did not secure the Weapon Cache in time", "PLAIN",10] call RE;
};

diag_log format["WAI: Mission Weapon cache ended at %1",_position];
missionrunning = false;