//Ural Attack

private ["_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_position","_num_guns","_num_tools","_num_items"];

_position = safepos call BIS_fnc_findSafePos;
diag_log format["WAI: Ural Attack mission started at %1",_position];

_baserunover = createVehicle ["UralWreck",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];

_num_guns	= 1 + round(rand 3);
_num_tools	= 3 + round(rand 8);
_num_items	= 6 + round(rand 36);

//Medium Gun Box
_box = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
[_box,_num_guns,_num_tools,_num_items] call spawn_ammo_box;

_rndnum 	= round (random 4) + 1;
_rndgro 	= 1 + round (random 3);

for "_i" from 0 to _rndgro do {
	[[_position select 0, _position select 1, 0], _rndnum, 1, "easy", 4, "", "", "Random", true] call spawn_group;
};

[_position,"[Easy] Ural Attack"] execVM "\z\addons\dayz_server\WAI\missions\compile\markers.sqf";

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

	[nil,nil,rTitleText,"The medical supplies have been secured by survivors!", "PLAIN",10] call RE;

} else {

	clean_running_mission = true;
	deleteVehicle _box;
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
	
	diag_log format["WAI: Ural Attack Mission Timed Out At %1",_position];
	[nil,nil,rTitleText,"Survivors did not secure the medical supplies in time!", "PLAIN",10] call RE;
};

diag_log format["WAI: Ural attack mission ended at %1",_position];
missionrunning = false;