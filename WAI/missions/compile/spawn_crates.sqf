private ["_position", "_type", "_loot_type", "_crate","_dropPosition","_effectSmoke"];

	_position = _this select 0;
	_type = _this select 1;
	_loot_type = _this select 2;

	_crate = createVehicle [_type, _position, [], 0, "CAN_COLLIDE"];

	// Smoke at box
	if(wai_crates_smoke) then {
		
		_dropPosition = getpos _crate;
		_effectSmoke = "smokeShellPurple" createVehicle _dropPosition;
		_effectSmoke attachto [_crate, [0,0,-0.2]];
		//diag_log format["WAI: popping smoke %1",_dropPosition];
	};
	
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	_crate setVariable ['HBC',3, true];
	//diag_log format["WAI: spawing crate with loot: %1",_loot_type];
	[_crate, _loot_type] call loottable_box;
	_crate
