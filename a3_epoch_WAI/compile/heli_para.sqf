if (isServer) then {

	private ["_mission_data","_pos_x","_pos_y","_ainum","_missionrunning","_aitype","_helipos1","_geartools","_gearmagazines","_cleanheli","_drop","_helipos","_gunner2","_gunner","_player_present","_skillarray","_aicskill","_aiskin","_aigear","_wp","_helipatrol","_gear","_skin","_backpack","_vest","_mags","_gun","_triggerdis","_startingpos","_aiweapon","_mission","_heli_class","_aipack","_helicopter","_unitGroup","_pilot","_skill","_paranumber","_position","_wp1"];

	_position 		= _this select 0;
		_pos_x			= _position select 0;
		_pos_y			= _position select 1;
	_startingpos 	= _this select 1;
	_triggerdis 	= _this select 2;
	_heli_class 	= _this select 3;
	_paranumber 	= _this select 4;
	_skill 			= _this select 5;
	_aisoldier		= _this select 6;
	_aitype			= _this select 7;
	_helipatrol 	= _this select 8;

	if (count _this > 9) then {
		_mission = _this select 9;
	} else {
		_mission = nil;
	};

	_aicskill 		= [];
	_skillarray 	= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

	if(debug_mode) then { diag_log "WAI: Paradrop waiting for player"; };

	waitUntil
	{
		sleep 10;
		_player_present = false;
		if(debug_mode) then {_player_present = true; };
		{
			if((isPlayer _x) && (_x distance [_pos_x,_pos_y,0] <= _triggerdis)) then {
				_player_present = true;
			};
		} count playableUnits;
		(_player_present)
	};

	if(!isNil "_mission") then {
		_missionrunning = (typeName (wai_mission_data select _mission) == "ARRAY");
	} else {
		_missionrunning = true;
	};

	if(!_missionrunning) exitWith { if(debug_mode) then { diag_log format["WAI: Mission at %1 already ended, aborting para drop",_position]; }; };

	if(debug_mode) then { diag_log format ["WAI: Spawning a %1 with %2 units to be para dropped at %3",_heli_class,_paranumber,_position]; };

	/* HELI SETUP START */
	_unitGroup			= createGroup RESISTANCE;
	_unitGroup 			setVariable["LASTLOGOUT_EPOCH",1000000000000];
	_unitGroup 			setVariable["LAST_CHECK",1000000000000]; 
	_unitGroup 			setBehaviour "CARELESS";
	_unitGroup 			setSpeedMode "FULL";
	_unitGroup			allowFleeing 0;

	if(debug_mode) then { diag_log("WAI: Spawning Heli patrol at " + str(mapGridPosition(_startingpos))); };
	if(debug_mode) then { diag_log("WAI: Flying to " + str(mapGridPosition(_position))); };
	
	_helicopter 		= createVehicle [_heli_class, [(_startingpos select 0),(_startingpos select 1), 200], [], 0, "FLY"];
	_helicopter 		setFuel 1;
	_helicopter 		engineOn true;
	_helicopter 		setVehicleAmmo 1;
	_helicopter 		flyInHeight 150;
	_helicopter 		lock true;
	_helicopter 		= _helicopter call wai_vehicle_protect;
	
	
	if (!isNil "_mission") then {
		_ainum = (wai_mission_data select _mission) select 0;
		wai_mission_data select _mission set [0, (_ainum + 1)];
		_helicopter setVariable ["mission",_mission];
	};
	
	/* CREW START */	
	_pilot 				= [_unitGroup,_position,"unarmed",_skill,_aitype,_mission] call spawn_soldier;
	_pilot 				assignAsDriver _helicopter;
	_pilot 				moveInDriver _helicopter;
	if(debug_mode) then { diag_log("WAI: Spawning Heli pilot " + str(_pilot)); };
	
	_gunner 			= [_unitGroup,_position,"unarmed",_skill,_aitype,_mission] call spawn_soldier;
	_gunner 			assignAsCargo _helicopter;
	_gunner 			moveInCargo [_helicopter,2];
	_gunner				enablePersonTurret [2,true];
	if(debug_mode) then { diag_log("WAI: Spawning Heli gunner 1 " + str(_gunner)); };

	_gunner2 			= [_unitGroup,_position,"unarmed",_skill,_aitype,_mission] call spawn_soldier;
	_gunner2			assignAsCargo _helicopter;
	_gunner2 			moveInCargo [_helicopter,4];
	_gunner2			enablePersonTurret [4,true];
	if(debug_mode) then { diag_log("WAI: Spawning Heli gunner 2 " + str(_gunner2)); };
	
	[_pilot,_gunner,_gunner2] 	joinSilent _unitGroup;
	//Pilot is leader
	_unitGroup 			selectLeader _pilot;
	
		
	{
		_pilot setSkill [_x,1]
	} count _skillarray;
	
	{
		_gunner 	setSkill [_x,0.7];
		_gunner2 	setSkill [_x,0.7];
	} count _skillarray;
	
	{
		// uniform
		_x forceAddUniform "U_B_HeliPilotCoveralls";
		_x addHeadgear "H_32_EPOCH";
		// Make it an AIR unit
		_x removeEventHandler ["killed", 0];
		_x addEventHandler ["Killed",{[_this select 0, _this select 1, "air"] call on_kill;}];
		_x setVariable ["missionclean", "air"];
		ai_air_units 		= (ai_air_units + 1);
	} forEach (units _unitgroup);

	if (!isNil "_mission") then {
		[_unitGroup, _mission] spawn bandit_behaviour;
	} else {
		[_unitGroup] spawn bandit_behaviour;
	};

	/* CREW END */
	
	// Add waypoints to the chopper group.
	_wp = _unitGroup addWaypoint [[(_position select 0), (_position select 1)], 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 100;
	
	/* HELI SETUP END */
	_drop = True;
	
	
	waitUntil((speed _helicopter) > 200);
	if (alive _helicopter) then {
		_time = ceil((_helicopter distance _position) / (speed _helicopter) + 1); // taking 2 minutes into account for the engine to start
		diag_log (format ["Helicopter ETA is %1 minutes",_time]);
	};
	
	
	
	while {(alive _helicopter) && (_drop)} do {

		private ["_dir","_magazine","_weapon","_weapon","_chute","_para","_pgroup"];
		sleep 1;
		_helipos = getpos _helicopter ;
		//if(debug_mode) then {diag_log('WAI: Heli height ' + str(mapGridPosition(_helipos)) + '/ Heli speed ' + str(speed _helicopter)); };


		if (_helipos distance [(_position select 0),(_position select 1),100] <= 200) then {
				
				_pgroup			= createGroup RESISTANCE;
				_pgroup 		setVariable["LASTLOGOUT_EPOCH",1000000000000];
				_pgroup 		setVariable["LAST_CHECK",1000000000000]; 
				_pgroup 		setBehaviour "CARELESS";
				_pgroup			allowFleeing 0;
				_dir 			= direction _helicopter;
			

			for "_x" from 1 to _paranumber do {
				
				// AI
				_helipos = getpos _helicopter;
				_unit = [_pgroup,[(_helipos select 0), (_helipos select 1), (_helipos select 2)],_aisoldier,_skill,_aitype,_mission] call spawn_soldier;
				[_unit] joinSilent _pgroup;
				ai_ground_units = (ai_ground_units + 1);
				
				_unit disableCollisionWith _helicopter;
				_unit allowdamage false;
				_unit setDir (_dir + 90);
				sleep 0.55;//So units are not too far spread out when they land.
				
				// Parachut
				_chute = createVehicle ["Steerable_Parachute_F", position _unit, [], ((_dir)- 5 + (random 10)), 'FLY'];
				_chute setPos (getPos _unit);
				addToRemainsCollector [_chute];
				_unit assignAsDriver _chute;
				_unit moveIndriver _chute;
				_unit allowdamage true;		
			};
			_pgroup selectLeader ((units _pgroup) select 0);
			// LAND SAFE
			{ 
			  [_x] spawn wai_paraLandSafe;
			} forEach (units _pgroup);
			
			_drop = false;

			if(debug_mode) then { diag_log format ["WAI: Spawned in %1 ai units for paradrop",_paranumber]; };

			[_pgroup,_position,_skill] call group_waypoints;
			
				if (!isNil "_mission") then {
					[_pgroup, _mission] spawn bandit_behaviour;
				} else {
					[_pgroup] spawn bandit_behaviour;
				};
			
		};
	};

	if (_helipatrol) then {
		
		_wp1 = _unitGroup addWaypoint [[(_position select 0),(_position select 1)], 100];
		_wp1 setWaypointType "SAD";
		_wp1 setWaypointCompletionRadius 150;
		_unitGroup setBehaviour "AWARE";
		_unitGroup setSpeedMode "NORMAL";

	} else {

		{
			_x doMove [(_startingpos select 0), (_startingpos select 1), 100]
		} count (units _unitGroup);
		
		_unitGroup setBehaviour "CARELESS";
		_unitGroup setSpeedMode "FULL";

		_cleanheli = true;

		while {_cleanheli} do {

			sleep 5;
			_helipos1 = getpos _helicopter;

			if ((_helipos1 distance [(_startingpos select 0),(_startingpos select 1),100] <= 1000) || (!alive _helicopter)) then {
				
				deleteVehicle _helicopter;
				{
					deleteVehicle _x;
					ai_air_units = (ai_air_units -1);
				} count (units _unitgroup);

				deleteGroup _unitGroup;
				if(debug_mode) then { diag_log "WAI: Paradrop helicopter cleaned"; };
				_cleanheli = false;
			};

		};

	};

};
