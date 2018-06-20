private ["_crate","_unit","_ailist","_keyid","_carkey","_hit","_count","_vehpos","_max_distance","_vehicle","_position_fixed","_position","_dir","_class","_dam","_damage","_hitpoints","_selection","_fuel","_key","_inventory"];

_count = count _this;
_crate = _this select 0; // used for the "KeyInCrate" option
_class = _this select 1;
_position = _this select 2;
_mission = _this select 3;
_max_distance = 17;
_vehpos	= [0,0,0];

if(_count > 4) then {
	_position_fixed = _this select 4;
	if(_count > 5) then {
		_dir = _this select 5;
	} else {
		_dir = floor(round(random 360));
	};
} else {
	_position_fixed = false;
	_dir = floor(round(random 360));
};

if (!_position_fixed) then {	
	while{count _vehpos > 2} do { 
		_vehpos = [_position,12,_max_distance,10,0,2000,0] call BIS_fnc_findSafePos; // Works better
		//_vehpos = _position findEmptyPosition[20,_max_distance,_class]; 
		_max_distance = (_max_distance + 10);
	};
} else {
	_vehpos = _position;
};

_vehicle = _class createVehicle _vehpos;
_vehicle setDir _dir;
_vehicle setPos _vehpos;
_vehicle setVectorUp surfaceNormal position _vehicle;
_vehicle setVelocity [0,0,1];
_vehicle setVariable ["ObjectID","1",true];
_vehicle setVariable ["mission",_mission];
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
_fuel = 0;
if(wai_debug_mode) then { diag_log(format["WAI: Spawned %1 at %2",str(_class),str(_vehpos)]); };

if (getNumber(configFile >> "CfgVehicles" >> _class >> "isBicycle") != 1) then {
	_hitpoints = _vehicle call vehicle_getHitpoints;
	{
		_dam = (random((wai_vehicle_damage select 1) - (wai_vehicle_damage select 0)) + (wai_vehicle_damage select 0)) / 100;
		_selection = getText(configFile >> "cfgVehicles" >> _class >> "HitPoints" >> _x >> "name");

		if ((_selection in dayZ_explosiveParts) && _dam > 0.8) then {
			_dam = 0.8
		};

		_isglass = ["glass", _selection] call fnc_inString;

		if(!_isglass && _dam > 0.1) then {
			_strH = "hit_" + (_selection);
			_vehicle setHit[_selection,_dam];
			_vehicle setVariable [_strH,_dam,true];
			if(wai_debug_mode) then { diag_log(format["WAI: Calculated damage for %1 is %2",str(_selection),str(_dam)]); };
		};
	} count _hitpoints;
	
	_fuel = (random((wai_mission_fuel select 1) - (wai_mission_fuel select 0)) + (wai_mission_fuel select 0)) / 100;
	_vehicle setFuel _fuel;
	if(wai_debug_mode) then { diag_log(format["WAI: Added %1 percent fuel to vehicle",str(_fuel)]); };
};

if (wai_invincible_vehicles) then {
	_vehicle addEventHandler ["HandleDamage",{false}];
} else {
	_vehicle addEventHandler ["HandleDamage",{_this call fnc_veh_handleDam}];
};

// This fix is for missions where there is no crate. The key goes in the vehicle.
if (typeName _crate == "STRING") then {_crate = _vehicle};

// Call function to generate vehicle key
[_vehicle,_mission,_crate] call wai_generate_vehicle_key;

dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_vehicle];

if(wai_keep_vehicles) then {
	
	_vehicle addEventHandler ["GetIn", {
		_vehicle = _this select 0;
		
		// remove the mission variable so the vehicle does not get deleted during mission clean up
		_vehicle setVariable ["mission",nil];
		
		if(wai_debug_mode) then { diag_log ("PUBLISH: Attempt " + str(_vehicle)); };

		_class = typeOf _vehicle;
		_characterID = _vehicle getVariable ["CharacterID", "0"];
		_worldspace	= [getDir _vehicle, getPosATL _vehicle];
		_hitpoints = _vehicle call vehicle_getHitpoints;
		_damage = damage _vehicle;
		_array = [];
		
		{
			_hit = [_vehicle,_x] call object_getHit;
			_selection = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "HitPoints" >> _x >> "name");
			if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
			if (wai_debug_mode) then {diag_log format ["Section Part: %1, Dmg: %2",_selection,_hit];};
		} count _hitpoints;

		_inventory 	= [
			getWeaponCargo _vehicle,
			getMagazineCargo _vehicle,
			getBackpackCargo _vehicle
		];

		_fuel = fuel _vehicle;
		_uid = _worldspace call dayz_objectUID2;

		_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,_damage,_characterID,_worldspace,_inventory,_array,_fuel,_uid];

		if(wai_debug_mode) then { diag_log ("HIVE: WRITE: "+ str(_key)); };
		
		_key call server_hiveWrite;
		
		// GET DB ID
		_key = format["CHILD:388:%1:",_uid];
		
		if (wai_debug_mode) then {diag_log ("HIVE: WRITE: "+ str(_key));};
		
		_result = _key call server_hiveReadWrite;
		_outcome = _result select 0;
		
		if (_outcome != "PASS") then {
			deleteVehicle _vehicle;
			diag_log("CUSTOM: failed to get id for : " + str(_uid));
		} else {
			_oid = _result select 1;
			_vehicle setVariable ["ObjectID", _oid, true];

			if (wai_debug_mode) then {diag_log("CUSTOM: Selected " + str(_oid));};

			_vehicle setVariable ["lastUpdate",diag_tickTime];
			
			// Reset event handlers for server and clients
			_vehicle call fnc_veh_ResetEH;
			PVDZE_veh_Init = _vehicle;
			publicVariable "PVDZE_veh_Init";

			diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid));
			
			if (wai_vehicle_message) then {
				[nil,(_this select 2),"loc",rTitleText,"You have claimed this vehicle! It is now saved to the database.","PLAIN",5] call RE;
			};
		};
	}];

} else {
	_vehicle addEventHandler ["GetIn", {
		_vehicle = _this select 0;
		
		if (wai_vehicle_message) then {
			[nil,(_this select 2),"loc",rTitleText,"WARNING: This vehicle will be deleted at restart!","PLAIN",5] call RE;
		};
		
		// remove the mission variable so the vehicle does not get deleted during mission clean
		_vehicle setVariable ["mission",nil];
		
		// Reset event handlers for server and clients
		_vehicle call fnc_veh_ResetEH;
		PVDZE_veh_Init = _vehicle;
		publicVariable "PVDZE_veh_Init";
		
	}];
};

_vehicle
