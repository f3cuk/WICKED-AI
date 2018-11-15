// This is a modified version of the DayZ Epoch file fn_spawnObjects.sqf used to spawn WAI mission objects.

private ["_offset","_fires","_position","_object","_objects","_type","_pos","_mission"];

_objects = _this select 0;
_pos = _this select 1;
_mission = _this select 2;

_fires = [
	"Base_Fire_DZ",
	"flamable_DZ",
	"Land_Camp_Fire_DZ",
	"Land_Campfire",
	"Land_Campfire_burning",
	"Land_Fire",
	"Land_Fire_burning",
	"Land_Fire_DZ",
	"Land_Fire_barrel",
	"Land_Fire_barrel_burning",
	"Misc_TyreHeap"
];

{
	_type = _x select 0;
	_offset = _x select 1;
	
	_position = [(_pos select 0) + (_offset select 0), (_pos select 1) + (_offset select 1), 0];
	
	if (count _offset > 2) then {
		_position set [2, (_offset select 2)];
	};
	_object = _type createVehicle [0,0,0];
	
	if (_type == "MQ9PredatorB") then {
		_object setVehicleLock "LOCKED";
	};
	
	if (count _x > 2) then {
		_object setDir (_x select 2);
	};
	
	_object setPos _position;
	_object setVectorUp surfaceNormal position _object;
	
	if (wai_godmode_objects) then {
		_object addEventHandler ["HandleDamage",{0}];
		if !(_type in _fires) then {_object enableSimulation false;};
	};
	
	((wai_mission_data select _mission) select 6) set [count ((wai_mission_data select _mission) select 6), _object];
} forEach _objects;

_object