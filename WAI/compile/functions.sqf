KK_fnc_arrayShufflePlus = {
    private ["_arr","_cnt","_el1","_indx","_el2"];
    _arr = _this select 0;
    _cnt = count _arr - 1;
    _el1 = _arr select _cnt;
    _arr resize _cnt;
    for "_i" from 1 to (_this select 1) do {
        _indx = floor random _cnt;
        _el2 = _arr select _indx;
        _arr set [_indx, _el1];
        _el1 = _el2;
    };
    _arr set [_cnt, _el1];
    _arr
};

find_suitable_ammunition = {

	private["_weapon","_result","_ammoArray"];

	_result = false;
	_weapon = _this;
	_ammoArray = getArray (configFile >> "cfgWeapons" >> _weapon >> "magazines");

	if (count _ammoArray > 0) then {
		_result = _ammoArray select 0;
		call {
			if (_result == "20Rnd_556x45_Stanag") exitWith { _result = "30Rnd_556x45_Stanag"; };
		};
	};
	_result
};

wai_spawnCrate = {
	private ["_pos","_crate","_mission","_offset","_type","_loot","_position","_crates"];
	_crates = _this select 0;
	_pos = _this select 1;
	if (count _this > 2) then {
		_mission = _this select 2;
	};
	
	{	
		_loot = _x select 0;
		_type = _x select 1;
		_offset = _x select 2;
		
		_position = [(_pos select 0) + (_offset select 0), (_pos select 1) + (_offset select 1), 0];
		
		if (count _offset > 2) then {
			_position set [2, (_offset select 2)];
		}; 
		
		if (typeName _type == "ARRAY") then {
			_type = _type call BIS_fnc_selectRandom;
		};
		
		_crate = _type createVehicle [0,0,0];
		
		if (count _x > 3) then {
			_crate setDir (_x select 3);
		};
		
		if (surfaceIsWater _position) then {
			_crate setPosASL _position;
		} else {
			_crate setPos _position;
		};
		
		_crate setVariable ["permaLoot",true];
		clearWeaponCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		_crate addEventHandler ["HandleDamage", {0}];
		_crate enableSimulation false;
		if (!isNil "_mission") then {
			((wai_mission_data select _mission) select 3) set [count ((wai_mission_data select _mission) select 3), [_crate,_loot]];
		} else {
			(wai_static_data select 3) set [count (wai_static_data select 3), [_crate,_loot]];
		};
	} count _crates;
};

wai_server_message = {
	private ["_color","_params","_type"];
	_type = _this select 0;
	_message = _this select 1;
	
	call {
		if (wai_mission_announce == "Radio") exitWith {
			RemoteMessage = ["radio",_message];
		};		
		if (wai_mission_announce == "DynamicText") exitWith {
			_color = call {
				if(_type == "Easy") exitWith {"#00cc00"};
				if(_type == "Medium") exitWith {"#ffff66"};
				if(_type == "Hard") exitWith {"#990000"};
				if(_type == "Extreme") exitWith {"#33334d"};
			};
			_params = ["0.40","#FFFFFF","0.60",_color,0,-.35,10,0.5];
			RemoteMessage = ["dynamic_text", ["STR_CL_MISSION_ANNOUNCE",_message],_params];
		};		
		if (wai_mission_announce == "titleText") exitWith {
			RemoteMessage = ["titleText",_message];
		};
	};
	publicVariable "RemoteMessage";
};

wai_minefield_warning = {
	private ["_owner","_params"];
	_owner = (owner _this);
	_params = ["0","#FFFFFF","0.50","#ff3300",0,.3,10,0.5];
	RemoteMessage = ["dynamic_text",["","STR_CL_MINEFIELD_WARNING"],_params];
	(_owner) publicVariableClient "RemoteMessage";
};

wai_AutoClaimAlert = {
	private ["_unit","_owner","_mission","_type","_message","_name"];
	_unit = _this select 0;
	_mission = _this select 1;
	_type = _this select 2;
	if (typeName _unit == "ARRAY") then {
		_name = _unit select 1;
	} else {
		_owner = owner _unit;
		_name = name _unit;
	};
	
	_message = call {
		if (_type == "Start") exitWith {["STR_CL_AUTOCLAIM_ANNOUNCE",_mission,ac_delay_time];};
		if (_type == "Stop") exitWith {["STR_CL_AUTOCLAIM_NOCLAIM",_mission];};
		if (_type == "Return") exitWith {["STR_CL_AUTOCLAIM_RETURN",ac_timeout];};
		if (_type == "Reclaim") exitWith {"STR_CL_AUTOCLAIM_RECLAIM";};
		if (_type == "Claimed") exitWith {["STR_CL_AUTOCLAIM_CLAIM",_name,_mission];};
		if (_type == "Unclaim") exitWith {["STR_CL_AUTOCLAIM_ABANDON",_name,_mission];};
	};
	
	if (_type == "Claimed" || _type == "Unclaim") exitWith {
		RemoteMessage = ["IWAC",_message];
		publicVariable "RemoteMessage";
	};
	
	RemoteMessage = ["IWAC",_message];
	(_owner) publicVariableClient "RemoteMessage";
};

wai_monitor_ai_vehicles = {
	private "_vehicle";
	{
		_vehicle = _x;
		if (alive _vehicle && ({alive _x} count crew _vehicle > 0)) then {
			_vehicle setVehicleAmmo 1;
			_vehicle setFuel 1;
		} else {
			_vehicle setDamage 1;
		};
	} count _this;
};

wai_fnc_remove = {
	{
		deleteVehicle _x;
	} count _this;
};

wai_remove_vehicles = {
    private ["_mission","_vehicles"];
    _mission = _this select 0;
    _vehicles = _this select 1;
    
    {
        if (_x getVariable ["mission" + dayz_serverKey, nil] == _mission) then {
            deleteVehicle _x;
        };
    } count _vehicles;
};

wai_remove_ai = {
    {
        if (_x getVariable ["mission" + dayz_serverKey, nil] == _this) then {
            deleteVehicle _x;
        };
    } count allUnits;
};

wai_generate_vehicle_key = {
	private ["_isKeyOK","_crates","_keyColor","_keyNumber","_vehicle","_crate","_keySelected","_mission","_unit","_ailist","_characterID"];
	
	_vehicle = _this select 0;
	_mission = _this select 1;
	_crates = _this select 2;
		
	if (wai_vehicle_keys == "NoVehicleKey") exitWith {
		_vehicle setVariable ["CharacterID","0",true];
		_vehicle setVehicleLock "unlocked";
	};
	
	_keyColor = DZE_keyColors call BIS_fnc_selectRandom;
	_keyNumber = (ceil(random 2500)) + 1;
	_keySelected = format["ItemKey%1%2",_keyColor,_keyNumber];
	_isKeyOK = isClass(configFile >> "CfgWeapons" >> _keySelected);
	_characterID = str(getNumber(configFile >> "CfgWeapons" >> _keySelected >> "keyid"));
	
	if !(_isKeyOK) exitWith {
		_vehicle setVariable ["CharacterID","0",true];
		_vehicle setVehicleLock "unlocked";
		diag_log format["WAI: Failed to generate a key for vehicle %1 at mission %2",_vehicle,_mission];
	};
	
	_vehicle setVariable ["CharacterID",_characterID,true];
	
	if (wai_vehicle_keys == "KeyinVehicle") exitWith {
		_vehicle addWeaponCargoGlobal [_keySelected,1];
		_vehicle setVehicleLock "unlocked";
	};
	if (wai_vehicle_keys == "KeyinCrate") exitWith {
		_crate = (_crates select 0) select 0;
		_crate addWeaponCargoGlobal [_keySelected, 1];
	};			
	if (wai_vehicle_keys == "KeyonAI") exitWith {
		_ailist = [];
		{
			if ((_x getVariable ["mission" + dayz_serverKey,nil] == _mission) && (_x getVariable ["bodyName",nil] == "mission_ai") && !(_x getVariable ["noKey", false])) then {
				_ailist set [count _ailist, _x];
			};
		} count allDead;
		
		_unit = _ailist call BIS_fnc_selectRandom;
		_unit addWeapon _keySelected;
		
		if(wai_debug_mode) then {
			diag_log format["There are %1 Dead AI for mission %2 vehicle key",_ailist,_mission];
			diag_log format["Key added to %1 for vehicle %2",_unit,_vehicle];
		};
	};
};

wai_completion_check = {
	private ["_completionType","_complete","_position","_mission","_killpercent","_objectivetarget"];
	
	_mission = _this select 0;
	_completionType = _this select 1;
	_killpercent = _this select 2;
	_position = _this select 3;
	_complete = false;
	
	call
	{
		if (_completionType select 0 == "crate") exitWith {

			if(wai_kill_percent == 0) then {
				_complete = [_position,20] call isNearPlayer;
			} else {
				if(((wai_mission_data select _mission) select 0) <= _killpercent) then {
					_complete = [_position,20] call isNearPlayer;
				};
			};
		};
		
		if (_completionType select 0 == "kill") exitWith {
			if(((wai_mission_data select _mission) select 0) == 0) then {
				_complete = true;
			};
		};
		
		if (_completionType select 0 == "assassinate") exitWith {
			_objectivetarget = _completionType select 1;
			{
				if !(alive _x) exitWith {_complete = true;};
			} count units _objectivetarget;
		};

		/* no missions are using this function at the moment
		if (_completionType == "resource") exitWith {
			_node 		= _completionType select 1;
			_resource 	= _node getVariable ["Resource", 0];
			if (_resource == 0) then {
				if ([_position,80] call isNearPlayer) then {
					_complete = true;
				} else {
					_timeout = true;
				};
			};
		}; */
	};
	_complete
};

wai_clean_aircraft = {
	private ["_veh","_position","_group"];
	_veh = _this select 0;
	_position = _this select 1;
	_group = _this select 2;
	
	uiSleep 60;
	deleteVehicle _veh;
	
	while {(count (wayPoints _group)) > 0} do {
		deleteWaypoint ((wayPoints _group) select 0);
	};
	
	{
		deleteVehicle _x;
	} count (units _group);
	uiSleep 5;
	deleteGroup _group;
	if(wai_debug_mode) then {diag_log "WAI: Aircraft Cleaned";};
};