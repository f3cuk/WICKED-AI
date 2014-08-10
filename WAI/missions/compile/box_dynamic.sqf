private ["_mission","_mags","_tool","_box","_class","_weapon","_namecfg","_item","_num_guns","_num_tools","_num_items"];

_box = _this select 0;
_box setVariable ["ObjectID","1",true];
_box setVariable ["permaLoot",true];

_num_guns	= _this select 1;
_num_tools	= _this select 2;
_num_items	= _this select 3;

PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_box];

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

if(_num_guns > 0) then {

	for "_i" from 0 to _num_guns do {
		_weapon = ammo_box_guns call BIS_fnc_selectRandom;
		_mags = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");
		_box addWeaponCargoGlobal [_weapon,1];
		_box addMagazineCargoGlobal [(_mags select 0), round(random 5) + 1];
	};

};

if(_num_tools > 0) then {

	for "_i" from 0 to _num_tools do {
		_tool = ammo_box_tools call BIS_fnc_selectRandom;
		_box addWeaponCargoGlobal [_tool,2];
	};

};

if(_num_items > 0) then {

	for "_i" from 0 to _num_items do {
		_item = ammo_box_items call BIS_fnc_selectRandom;
		_box addMagazineCargoGlobal [_item,1];
	};

};