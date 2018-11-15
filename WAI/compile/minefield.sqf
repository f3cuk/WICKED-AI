private["_area_max","_area_min","_position","_num_mines","_mines"];

_position 	= _this select 0;
_area_min 	= _this select 1;
_area_max 	= _this select 2;
_num_mines	= _this select 3;
_mines 	= [];

for "_x" from 1 to _num_mines do {

	_mine_pos = [_position,_area_min,_area_max,10,0,2000,0] call BIS_fnc_findSafePos;
	_mine = createVehicle ["Mine", _mine_pos, [], 0, "CAN_COLLIDE"];
	_mines set [(count _mines), _mine];
};

_mines