if (isServer) then {

    private ["_unit","_ailist","_keyid","_carkey","_hit","_classnames","_count","_vehpos","_max_distance","_vehicle","_position_fixed","_position","_dir","_class","_dam","_damage","_hitpoints","_selection","_fuel","_key","_inventory"];

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

	
	addToRemainsCollector[_vehicle];
	
	
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

			_inventory 	= [
				getWeaponCargo _vehicle,
				getMagazineCargo _vehicle,
				getBackpackCargo _vehicle
			];

			_fuel 	= fuel _vehicle;
			_uid 	= _worldspace call dayz_objectUID2;

			_key 	= format["%1:%2",(call EPOCH_fn_InstanceID),_slot];

			if(debug_mode) then { diag_log ("HIVE: WRITE: "+ str(_key)); };
						
			_key call EPOCH_server_hiveSET;
			
			[_vehicle,_uid,_fuel,_damage,_array,_characterID,_class] spawn {  //this section needs redone

				private["_vehicle","_uid","_fuel","_damage","_array","_characterID","_done","_retry","_key","_result","_outcome","_oid","_class","_res"];

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
						if(_outcome != "PASS") then {
							_oid = _result select 1;
							_vehicle setVariable ["ObjectID", _oid, true];
							if(debug_mode) then { diag_log("CUSTOM: Selected " + str(_oid)); };
							_done  = true;
						} else {
							if(debug_mode) then { diag_log("CUSTOM: trying again to get id for: " + str(_uid)); };
							_done = false;
						};
					};
					sleep 1;
			

				if(!_done) then { 
					deleteVehicle _vehicle;
					if(debug_mode) then { diag_log("CUSTOM: failed to get id for : " + str(_uid)); };
				} else {
					_vehicle setVariable ["lastUpdate",time];
				};
			};

			_vehicle call fnc_veh_ResetEH;  //this needs fixed
			EPOCH_server_vehicleInit = _vehicle;

			publicVariable "EPOCH_server_vehicleInit";

			if(debug_mode) then { diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid)); };
		}];

	};

	_vehicle

};