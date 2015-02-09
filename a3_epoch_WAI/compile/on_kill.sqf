if (isServer) then {

	private ["_rockets","_launcher","_type","_skin","_gain","_mission","_ainum","_unit","_player","_crypto","_banditkills","_humankills","_cryptogain"];
	
	_unit 		= _this select 0;
	_player 	= _this select 1;
	_type 		= _this select 2;
	_launcher 	= secondaryWeapon _unit;
	_krypto		= _unit getVariable ["crypto", 0];

	call {
		if(_type == "ground") 	exitWith { ai_ground_units = (ai_ground_units -1); };
		if(_type == "air") 		exitWith { ai_air_units = (ai_air_units -1); };
		if(_type == "vehicle") 	exitWith { ai_vehicle_units = (ai_vehicle_units -1); };
		if(_type == "static") 	exitWith { ai_emplacement_units = (ai_emplacement_units -1); };
	};
	
	_unit setVariable["missionclean", nil];
	
	_mission = _unit getVariable ["mission", nil];
		
	if (!isNil "_mission") then {
		if (typeName(wai_mission_data select _mission) == "ARRAY") then {
			wai_mission_data select _mission set [0, ((wai_mission_data select _mission) select 0) - 1];
		};
	};
	_unit setVariable ["killedat", time];

	if (isPlayer _player) then {

		if(ai_crypto_gain)then{
			_pos=getposATL _unit;
			_veh=createVehicle["Land_MPS_EPOCH",_pos,[],1.5,"CAN_COLLIDE"];
			diag_log format["ADMIN: Created crypto device for %1 with %2 at %3",_unit,_krypto,_pos];
			_veh setVariable["Crypto",_krypto,true];
		};
				
		if (ai_clear_body) then {
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeUniform _unit;
			removeVest _unit; 
			removeBackpack _unit;
			removeHeadgear _unit;
			removeGoggles _unit;
		};

		if (ai_share_info) then {
			{
				if (((position _x) distance (position _unit)) <= ai_share_distance) then {
					_x reveal [_player, 4.0];
				};
			} count allUnits;
		};

	} else {
	
		// Blow front wheel
		_player setHit ["pravy kolo",1];

		if (ai_clean_roadkill) then {
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeUniform _unit;
			removeVest _unit; 
			removeBackpack _unit;
			removeHeadgear _unit;
			removeGoggles _unit;
		} else {

			if ((random 100) <= ai_roadkill_damageweapon) then {
				removeAllWeapons _unit;
				removeUniform _unit;
				removeVest _unit; 
			};

		};

	};

	if(wai_remove_launcher && _launcher != "") then {

		_rockets = _launcher call find_suitable_ammunition;
		_unit removeWeapon _launcher;
		
		{
			if(_x == _rockets) then {
				_unit removeMagazine _x;
			};
		} count magazines _unit;
		
	};

	if(_unit hasWeapon "NVG_Epoch" && floor(random 100) < 20) then {
		_unit removeWeapon "NVG_Epoch";
	};

};