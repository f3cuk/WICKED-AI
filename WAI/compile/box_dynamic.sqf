private ["_mags","_tool","_box","_weapon","_item","_num_guns","_num_tools","_num_items","_weaponarray"];

_box = _this select 0;
_box setVariable ["ObjectID","1",true];
_box setVariable ["permaLoot",true];

_num_guns	= _this select 1;
_num_tools	= _this select 2;
_num_items	= _this select 3;

diag_log format["WAI: Spawning in a dynamic box with %1 guns, %2 tools and %3 items",_num_guns,_num_tools,_num_items];

PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_box];

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

if(_num_guns > 0) then {

	for "_i" from 1 to _num_guns do {
		_weaponarray = ai_wep_random call BIS_fnc_selectRandom;
		_weapon = _weaponarray call BIS_fnc_selectRandom;
		_box addWeaponCargoGlobal [(_weapon select 0),1];
		_box addMagazineCargoGlobal [(_weapon select 1), (1 + round(random 5))];
	};

};

if(_num_tools > 0) then {

	for "_i" from 1 to _num_tools do {
		_tool = ammo_box_tools call BIS_fnc_selectRandom;
		_box addWeaponCargoGlobal [_tool,2];
	};

};

if(_num_items > 0) then {

	for "_i" from 1 to _num_items do {
		_item = ammo_box_items call BIS_fnc_selectRandom;
		_box addMagazineCargoGlobal [_item,1];
	};

};