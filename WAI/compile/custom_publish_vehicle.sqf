if (isServer) then {

    private ["_unit","_ailist","_keyid","_carkey","_hit","_classnames","_count","_vehpos","_max_distance","_vehicle","_position_fixed","_position","_dir","_class","_dam","_damage","_hitpoints","_selection","_fuel","_key"];

	_count 			= count _this;
	_classnames 	= _this select 0;
	_position 		= _this select 1;
	_mission 		= _this select 2;
	_max_distance 	= 35;
	_vehpos			= [];

	if (typeName(_classnames) == "ARRAY") then {
		_class = _classnames call BIS_fnc_selectRandom;
	} else {
		_class = _classnames;
	};

	if(_count > 3) then {

		_position_fixed = _this select 3;

		if(_count > 4) then {
			_dir = _this select 4;
		} else {
			_dir = floor(round(random 360));
		};

	} else {
		_position_fixed = false;
		_dir = floor(round(random 360));
	};

	if (!_position_fixed) then {	
		while{count _vehpos < 1} do { 
			_vehpos = _position findEmptyPosition[10,_max_distance,_class]; 
			_max_distance = (_max_distance + 15);
		};
	} else {
		_vehpos = _position;
	};

	_vehicle = createVehicle [_class,_vehpos,[],5,"FORM"];
	_vehicle setDir _dir;
	_vehicle setVectorUp surfaceNormal position _vehicle;
	_vehicle setvelocity [0,0,1];
	
	_vehicle setVariable ["ObjectID","1",true];
	
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	
	_fuel = 0;

	if (getNumber(configFile >> "CfgVehicles" >> _class >> "isBicycle") != 1) then {

		_hitpoints = _vehicle call vehicle_getHitpoints;
		
		if(debug_mode) then { diag_log(format["WAI: Spawned %1 at %2",str(_class),str(_position)]); };
		
		{
			_dam 		= (random((wai_vehicle_damage select 1) - (wai_vehicle_damage select 0)) + (wai_vehicle_damage select 0)) / 100;
			_selection	= getText(configFile >> "cfgVehicles" >> _class >> "HitPoints" >> _x >> "name");

			if ((_selection in dayZ_explosiveParts) && _dam > 0.8) then {
				_dam = 0.8
			};

			_isglass = ["glass", _selection] call KK_fnc_inString;

			if(!_isglass && _dam > 0.1) then {
				_hit = [_vehicle,_selection,_dam] call object_setHitServer;
				if(debug_mode) then { diag_log(format["WAI: Calculated damage for %1 is %2",str(_selection),str(_dam)]); };
			};

		} count _hitpoints;

		_fuel = ((wai_mission_fuel select 0) + random((wai_mission_fuel select 1) - (wai_mission_fuel select 0))) / 100;
		_vehicle setFuel _fuel;

		if(debug_mode) then { diag_log(format["WAI: Added %1 percent fuel to vehicle",str(_fuel)]); };

	};
	
	_vehicle addeventhandler ["HandleDamage",{ _this call vehicle_handleDamage } ];
	
	if (wai_lock_vehicles) then {
		_keyid = ceil(random(12500));
		_vehicle setVariable ["CharacterID",str(_keyid),true];

		call {
			if ((_keyid > 0) && (_keyid <= 2500)) 		exitWith {_carkey = format["ItemKeyGreen%1",_keyid];};
			if ((_keyid > 2500) && (_keyid <= 5000))	exitWith {_carkey = format["ItemKeyRed%1",_keyid-2500];};
			if ((_keyid > 5000) && (_keyid <= 7500)) 	exitWith {_carkey = format["ItemKeyBlue%1",_keyid-5000];};
			if ((_keyid > 7500) && (_keyid <= 10000)) 	exitWith {_carkey = format["ItemKeyYellow%1",_keyid-7500];};
			if ((_keyid > 10000) && (_keyid <= 12500)) 	exitWith {_carkey = format["ItemKeyBlack%1",_keyid-10000];};
		};

		_ailist = [];
		{
			if (_x getVariable ["mission",nil] == _mission) then {_ailist set [count _ailist, _x];};
		} count allUnits;

		_unit = _ailist select (floor(random(count _ailist)));
		
		_unit addWeapon _carkey;
		
		_vehicle setvehiclelock "locked";
	} else {
		_vehicle setVariable ["CharacterID","0",true];
	};

	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_vehicle];

	if(wai_keep_vehicles) then {
		
		_vehicle addEventHandler ["GetIn", {
			_vehicle 		= _this select 0;
			if(debug_mode) then { diag_log ("PUBLISH: Attempt " + str(_vehicle)); };

			_class 			= typeOf _vehicle;
			_characterID 	= _vehicle getVariable ["CharacterID", "0"];
			_worldspace		= [getDir _vehicle, getPosATL _vehicle];
			_hitpoints 		= _vehicle call vehicle_getHitpoints;
			_damage 		= damage _vehicle;
			_array 			= [];

			{
				_hit = [_vehicle,_x] call object_getHit;
				_selection = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "HitPoints" >> _x >> "name");
				if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
			} count _hitpoints;

			_fuel 	= fuel _vehicle;
			_uid 	= _worldspace call dayz_objectUID2;

			_key 	= format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,_damage,_characterID,_worldspace,[],_array,_fuel,_uid];

			if(debug_mode) then { diag_log ("HIVE: WRITE: "+ str(_key)); };

			_key call server_hiveWrite;
			
			[_vehicle,_uid,_fuel,_damage,_array,_characterID,_class] call {

				private["_vehicle","_uid","_fuel","_damage","_array","_characterID","_done","_retry","_key","_result","_outcome","_oid","_class"];

				_vehicle 		= _this select 0;
				_uid 			= _this select 1;
				_fuel 			= _this select 2;
				_damage 		= _this select 3;
				_array 			= _this select 4;
				_characterID	= _this select 5;
				_class 			= _this select 6;
				_done 			= false;

				while {!_done} do {
					_key 		= format["CHILD:388:%1:",_uid];
					_result 	= _key call server_hiveReadWrite;
					_outcome 	= _result select 0;

					waitUntil {!isNil "_outcome"};

					if(debug_mode) then { diag_log ("HIVE: WRITE: "+ str(_key)); };

					if(_outcome == "PASS") then {
						_oid = _result select 1;
						_vehicle setVariable ["ObjectID", _oid, true];
						if(debug_mode) then { diag_log("CUSTOM: Selected " + str(_oid)); };
						_done  = true;
					} else {
						if(debug_mode) then { diag_log("CUSTOM: trying again to get id for: " + str(_uid)); };
						_done = false;
					};
				};

				if(!_done) then { 
					deleteVehicle _vehicle;
					if(debug_mode) then { diag_log("CUSTOM: failed to get id for : " + str(_uid)); };
				} else {
					_vehicle setVariable ["lastUpdate",time];
				};
			};

			_vehicle call fnc_veh_ResetEH;
			PVDZE_veh_Init = _vehicle;

			publicVariable "PVDZE_veh_Init";

			if(debug_mode) then { diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid)); };
		}];

	};

	_vehicle

};