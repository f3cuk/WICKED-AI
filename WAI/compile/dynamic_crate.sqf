private ["_crateLoot","_vehicles","_complete","_marker","_ammo","_tool","_crate","_weapon","_item","_backpack","_num_tools","_num_items","_num_backpacks","_num_weapons","_weapons_array","_tool_array","_item_array","_backpack_array","_num_pistols","_pistols_array","_pistol","_pistolammo"];

_crate = _this select 0;
_crateLoot = _this select 1;
if ((count _this) > 2) then {
	_complete = _this select 2;
} else {
	_complete = nil;
};

if ((count _crateLoot) > 5) then {
	_vehicles = _crateLoot select 5;
	if (wai_vehicle_keys == "KeyinCrate") then {
		{
			[_x,nil,_crate] call wai_generate_vehicle_key;
		} forEach _vehicles;
	};
	if (wai_vehicle_keys == "KeyinVehicle" || wai_vehicle_keys == "NoVehicleKey") then {
		{
			_x setVehicleLock "unlocked";
		} forEach _vehicles;
	};
};

if !(isNil "_complete") then {
	if (typeOf(_crate) in (crates_large + crates_medium + crates_small)) then {
		if (wai_crates_smoke && sunOrMoon == 1) then {
			_marker = "smokeShellPurple" createVehicle getPosATL _crate;
			_marker setPosATL (getPosATL _crate);
			_marker attachTo [_crate,[0,0,0]];
		};
		if (wai_crates_flares && sunOrMoon != 1) then {
			_marker = "RoadFlare" createVehicle getPosATL _crate;
			_marker setPosATL (getPosATL _crate);
			_marker attachTo [_crate, [0,0,0]];
			
			PVDZ_obj_RoadFlare = [_marker,0];
			publicVariable "PVDZ_obj_RoadFlare";
		};
	};
};

if(typeName (_crateLoot select 0) == "ARRAY") then {
	_num_weapons	= (_crateLoot select 0) select 0;
	_weapons_array	= (_crateLoot select 0) select 1;
} else {
	_num_weapons	= _crateLoot select 0;
	_weapons_array	= ai_wep_random;
};

if(typeName (_crateLoot select 1) == "ARRAY") then {
	_num_tools	= (_crateLoot select 1) select 0;
	_tool_array = (_crateLoot select 1) select 1;
} else {
	_num_tools	= _crateLoot select 1;
	_tool_array = crate_tools;
};

if(typeName (_crateLoot select 2) == "ARRAY") then {
	_num_items	= (_crateLoot select 2) select 0;
	_item_array	= (_crateLoot select 2) select 1;
} else {
	_num_items	= _crateLoot select 2;
	_item_array	= crate_items_random;
};

if(typeName (_crateLoot select 3) == "ARRAY") then {
	_num_pistols	= (_crateLoot select 3) select 0;
	_pistols_array	= (_crateLoot select 3) select 1;
} else {
	_num_pistols	= _crateLoot select 3;
	if (WAI_Overpoch) then {
	_pistols_array	= ai_wep_owpistol;
	} else {
	_pistols_array	= ai_wep_pistol;
	};
};

if(typeName (_crateLoot select 4) == "ARRAY") then {
	_num_backpacks	= (_crateLoot select 4) select 0;
	_backpack_array = (_crateLoot select 4) select 1;
} else {
	_num_backpacks = _crateLoot select 4;
	_backpack_array = crate_backpacks_all;
};

if(_num_weapons > 0) then {

	_num_weapons = (ceil((_num_weapons) / 2) + floor(random (_num_weapons / 2)));
	
	if ([_weapons_array,ai_wep_random] call BIS_fnc_areEqual) then {

		for "_i" from 1 to _num_weapons do {
			_weapons_array = ai_wep_random select (floor (random (count ai_wep_random)));
			_weapon = _weapons_array select (floor (random (count _weapons_array)));
			_ammo = _weapon call find_suitable_ammunition;
			_crate addWeaponCargoGlobal [_weapon,1];
			_crate addMagazineCargoGlobal [_ammo, (1 + floor(random 5))];
		};
	} else {
		
		for "_i" from 1 to _num_weapons do {
			_weapon = _weapons_array select (floor (random (count _weapons_array)));
			_ammo = _weapon call find_suitable_ammunition;
			_crate addWeaponCargoGlobal [_weapon,1];
			_crate addMagazineCargoGlobal [_ammo, (1 + floor(random 5))];
		};
	};
};

if(_num_tools > 0) then {

	_num_tools	= (ceil((_num_tools) / 2) + floor(random (_num_tools / 2)));

	for "_i" from 1 to _num_tools do {
		_tool = _tool_array select (floor (random (count _tool_array)));

		if(typeName (_tool) == "ARRAY") then {
			_crate addWeaponCargoGlobal [_tool select 0,_tool select 1];
		} else {
			_crate addWeaponCargoGlobal [_tool,1];
		};
	};
};

if(_num_items > 0) then {

	_num_items	= (ceil((_num_items) / 2) + floor(random (_num_items / 2)));
	
	if ([_item_array,crate_items_random] call BIS_fnc_areEqual) then {
		
		for "_i" from 1 to _num_items do {
			_item_array = crate_items_random select (floor (random (count crate_items_random)));
			_item = _item_array select (floor (random (count _item_array)));

			if(typeName (_item) == "ARRAY") then {
				_crate addMagazineCargoGlobal [_item select 0,_item select 1];
			} else {
				_crate addMagazineCargoGlobal [_item,1];
			};
		};
	} else {
		
		for "_i" from 1 to _num_items do {
			_item = _item_array select (floor (random (count _item_array)));

			if(typeName (_item) == "ARRAY") then {
				_crate addMagazineCargoGlobal [_item select 0,_item select 1];
			} else {
				_crate addMagazineCargoGlobal [_item,1];
			};
		};
	};
};

if(_num_pistols > 0) then {

	_num_pistols = (ceil((_num_pistols) / 2) + floor(random (_num_pistols / 2)));

	for "_i" from 1 to _num_pistols do {
		_pistol = _pistols_array select (floor (random (count _pistols_array)));
		_pistolammo = _pistol call find_suitable_ammunition;
		_crate addWeaponCargoGlobal [_pistol,1];
		_crate addMagazineCargoGlobal [_pistolammo, (1 + floor(random 5))];
	};
};

if(_num_backpacks > 0) then {

	_num_backpacks	= (ceil((_num_backpacks) / 2) + floor(random (_num_backpacks / 2)));

	for "_i" from 1 to _num_backpacks do {
		_backpack = _backpack_array select (floor (random (count _backpack_array)));

		if(typeName (_backpack) == "ARRAY") then {
			_crate addBackpackCargoGlobal [_backpack select 0,_backpack select 1];
		} else {
			_crate addBackpackCargoGlobal [_backpack,1];
		};
	};
};

if(wai_high_value) then {

	if(random 100 < wai_high_value_chance) then {
		_item = crate_items_high_value select (floor (random (count crate_items_high_value)));
		_crate addMagazineCargoGlobal [_item,1];
	};
};

if(wai_debug_mode) then {
	diag_log format["WAI: Spawning in a dynamic crate with %1 guns, %2 tools, %3 items and %4 pistols and %5 backpacks",_num_weapons,_num_tools,_num_items,_num_pistols,_num_backpacks];
};
