/********************************************************************************************
Usage:			|	[classname,position,(boolean),(direction)] call custom_publish;
Parameters		|	classname:	Class of vehicle to spawn
in brackets		|	position:	Position to spawn vehicle
are optional	|	boolean:	True, or False by default to spawn vehicle static at position
				|	direction:	Direction to face vehicle, random by default
/********************************************************************************************/
if (isServer) then {
	private ["_vehicle","_position_fixed","_position","_dir","_class","_dam","_damage","_hitpoints","_selection","_fuel","_key"];
	_count = count _this;
	_classnames = _this select 0;
	_position = _this select 1;
	if (typeName(_classnames) == "ARRAY") then {
		_class = _classnames call BIS_fnc_selectRandom;
	} else {
		_class = _classnames;
	};
	if(_count > 2) then {
		_position_fixed = _this select 2;
		if(_count > 3) then {
			_dir = _this select 3;
		} else {
			_dir = floor(round(random 360));
		};
	} else {
		_position_fixed = false;
		_dir = floor(round(random 360));
	};
	if (!_position_fixed) then { _position = _position findEmptyPosition [10,25,_class]; };

	_vehicle = createVehicle [_class,_position, [], 0, "FORM"];
	_vehicle setDir _dir;
	_vehicle setVectorUp surfaceNormal position _vehicle;
	_vehicle setvelocity [0,0,1];
	
	_vehicle setVariable ["ObjectID","1",true];
	_vehicle setVariable ["CharacterID","0",true];
	
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	
	_fuel = 0;
	if (getNumber(configFile >> "CfgVehicles" >> _class >> "isBicycle") != 1) then {
		_damage = (wai_vehicle_damage select 0) / 100;
		_vehicle setDamage _damage;
		_hitpoints = _vehicle call vehicle_getHitpoints;
		{
			_dam = ((wai_vehicle_damage select 0) + random((wai_vehicle_damage select 1) - (wai_vehicle_damage select 0))) / 100;
			_selection = getText(configFile >> "cfgVehicles" >> _class >> "HitPoints" >> _x >> "name");
			if (_selection in dayZ_explosiveParts && _dam > 0.8) then {_dam = 0.8};			
			[_vehicle, _selection, _dam] call vehicle_handleDamage;
		} forEach _hitpoints;
		_fuel = ((wai_mission_fuel select 0) + random((wai_mission_fuel select 1) - (wai_mission_fuel select 0))) / 100;;
	};
	diag_log("WAI: Spawned " +str(_class) + " at " + str(_position) + " with " + str(_fuel) + " fuel and " + str(_damage) + " damage.");
	
	_vehicle setFuel _fuel;
	
	_vehicle addeventhandler ["HandleDamage",{ _this call vehicle_handleDamage } ];
	
	PVDZE_serverObjectMonitor	set [count PVDZE_serverObjectMonitor,_vehicle];

	if(wai_keep_vehicles) then {
		
		_vehicle addEventHandler ["GetIn", {
			_vehicle = _this select 0;
			diag_log ("PUBLISH: Attempt " + str(_vehicle));
			_class = typeOf _vehicle;
			_characterID = _vehicle getVariable ["CharacterID", "0"];
			_worldspace = [getDir _vehicle, getPosATL _vehicle];
			_hitpoints = _vehicle call vehicle_getHitpoints;
			_damage = damage _vehicle;
			_array = [];
			{
				_hit = [_vehicle,_x] call object_getHit;
				_selection = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "HitPoints" >> _x >> "name");
				if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
			} count _hitpoints;
			_fuel = fuel _vehicle;
			_uid = _worldspace call dayz_objectUID2;

			_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance, _class, _damage , _characterID, _worldspace, [], _array, _fuel,_uid];

			diag_log ("HIVE: WRITE: "+ str(_key));
			_key call server_hiveWrite;

			//PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];
			
			[_vehicle,_uid,_fuel,_damage,_array,_characterID,_class] spawn {

				private["_vehicle","_uid","_fuel","_damage","_array","_characterID","_done","_retry","_key","_result","_outcome","_oid","_selection","_dam","_class"];

				_vehicle 		= _this select 0;
				_uid 			= _this select 1;
				_fuel 			= _this select 2;
				_damage 		= _this select 3;
				_array 			= _this select 4;
				_characterID	= _this select 5;
				_class 			= _this select 6;
				_done 			= false;
				_retry 			= 0;

				while {_retry < 10} do {
					sleep 1;
					_key 		= format["CHILD:388:%1:",_uid];
					_result 	= _key call server_hiveReadWrite;
					_outcome 	= _result select 0;
					diag_log ("HIVE: WRITE: "+ str(_key));

					if (_outcome == "PASS") then {
						_oid 	= _result select 1;
						_vehicle setVariable ["ObjectID", _oid, true];
						diag_log("CUSTOM: Selected " + str(_oid));
						_done 	= true;
						_retry 	= 100;
					} else {
						diag_log("CUSTOM: trying again to get id for: " + str(_uid));
						_done 	= false;
						_retry 	= _retry + 1;
					};
				};

				if(!_done) exitWith { 
					deleteVehicle _vehicle; diag_log("CUSTOM: failed to get id for : " + str(_uid));
				};

				_vehicle setVariable ["lastUpdate",time];

				_vehicle call fnc_veh_ResetEH;
				PVDZE_veh_Init = _vehicle;
				publicVariable "PVDZE_veh_Init";

				diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid));
			};

		}];
	};
	sleep .5;
};