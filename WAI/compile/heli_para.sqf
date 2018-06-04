private ["_start_position","_diag_distance","_rndnum","_mission_data","_pos_x","_pos_y","_ainum","_missionrunning","_aitype","_helipos1","_geartools","_gearmagazines","_cleanheli","_drop","_helipos","_gunner2","_gunner","_player_present","_skillarray","_aicskill","_aiskin","_aigear","_wp","_helipatrol","_gear","_skin","_backpack","_mags","_gun","_triggerdis","_startingpos","_aiweapon","_mission","_heli_class","_aipack","_helicopter","_unitGroup","_pilot","_skill","_paranumber","_position","_wp1"];

if (!wai_enable_paradrops) exitWith {};

_position 		= _this select 0;
_pos_x			= _position select 0;
_pos_y			= _position select 1;
_triggerdis 	= _this select 1;
_heli_class 	= _this select 2;
_paranumber 	= _this select 3;
_skill 			= _this select 4;
_gun 			= _this select 5;
_mags 			= _this select 6;
_backpack 		= _this select 7;
_skin 			= _this select 8;
_gear 			= _this select 9;
_aitype			= _this select 10;
_helipatrol 	= _this select 11;
_aipack 		= "";
_player_present = false;

if (count _this > 12) then {
	_mission = _this select 12;
} else {
	_mission = nil;
};

_aiweapon 		= [];
_aigear 		= [];
_aiskin 		= "";
_aicskill 		= [];
_skillarray 	= ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];

if(wai_debug_mode) then { diag_log "WAI: Paradrop waiting for player"; };


// Wait until a player is within the trigger distance
while {!_player_present} do {
	_player_present = [[_pos_x,_pos_y,0],_triggerdis] call isNearPlayer;
	uiSleep 10;
};

call {
	if (_skin == "random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom; };
	if (_skin == "hero") 	exitWith { _aiskin = ai_hero_skin call BIS_fnc_selectRandom; };
	if (_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom; };
	if (_skin == "special") exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom; };
	_aiskin = _skin;
};

if(typeName _aiskin == "ARRAY") then {
	_aiskin = _aiskin call BIS_fnc_selectRandom;
};

if(!isNil "_mission") then {

	_missionrunning = (typeName (wai_mission_data select _mission) == "ARRAY");
		
} else {

	_missionrunning = true;

};

if(!_missionrunning) exitWith { if(wai_debug_mode) then { diag_log format["WAI: Mission at %1 already ended, aborting para drop",_position]; }; };

if(wai_debug_mode) then { diag_log format ["WAI: Spawning a %1 with %2 units to be para dropped at %3",_heli_class,_paranumber,_position]; };

if(_aitype == "Hero") then {
	_unitGroup	= createGroup RESISTANCE;
} else {
	_unitGroup	= createGroup EAST;
};

_pilot = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
[_pilot] joinSilent _unitGroup;

ai_air_units = (ai_air_units +1);

// This random number is used to start the helicopter from 3000 to 4000 meters from the mission.
_rndnum = 3000 + round (random 1000);

_helicopter = createVehicle [_heli_class,[(_position select 0),(_position select 1) + _rndnum,100],[],0,"FLY"];
_start_position = position _helicopter;
_diag_distance = _helicopter distance _position;
if (wai_debug_mode) then {
	diag_log format["WAI: the Paratrooper Drop has started %1 from the mission",_diag_distance];
};
_helicopter setFuel 1;
_helicopter engineOn true;
_helicopter setVehicleAmmo 1;
_helicopter flyInHeight 150;
_helicopter addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];

_pilot assignAsDriver _helicopter;
_pilot moveInDriver _helicopter;

_gunner = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
_gunner assignAsGunner _helicopter;
_gunner moveInTurret [_helicopter,[0]];
[_gunner] joinSilent _unitGroup;

ai_air_units = (ai_air_units +1);

_gunner2 = _unitGroup createUnit [_aiskin,[0,0,0],[],1,"NONE"];
_gunner2 assignAsGunner _helicopter;
_gunner2 moveInTurret [_helicopter,[1]];
[_gunner2] joinSilent _unitGroup;

call {
	if (_aitype == "Hero") 		exitWith { { _x setVariable ["Hero",true]; _x setVariable ["humanity", ai_add_humanity]; } count [_pilot, _gunner, _gunner2]; };
	if (_aitype == "Bandit") 	exitWith { { _x setVariable ["Bandit",true]; _x setVariable ["humanity", ai_remove_humanity]; } count [_pilot, _gunner, _gunner2]; };
	if (_aitype == "Special") 	exitWith { { _x setVariable ["Special",true]; _x setVariable ["humanity", ai_special_humanity]; } count [_pilot, _gunner, _gunner2]; };
};

ai_air_units = (ai_air_units +1);

{
	_pilot setSkill [_x,1]
} count _skillarray;

{
	_gunner 	setSkill [_x,0.7];
	_gunner2 	setSkill [_x,0.7];
} count _skillarray;


{
	_x addWeapon "Makarov_DZ";
	_x addMagazine "8Rnd_9x18_Makarov";
	_x addMagazine "8Rnd_9x18_Makarov";
} count (units _unitgroup);


dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_helicopter];

// If the para drop is part of a mission then it can be added to the mission data variable, otherwise you spawn the standalone vehicle monitor.
if (!isNil "_mission") then {
	// Add unit group to an array for mission clean up
	((wai_mission_data select _mission) select 1) set [count ((wai_mission_data select _mission) select 1), _unitGroup];
	((wai_mission_data select _mission) select 4) set [count ((wai_mission_data select _mission) select 4), _helicopter];
} else {
	(wai_static_data select 1) set [count (wai_static_data select 1), _unitGroup]; // Add unit group to an array for mission clean up
	(wai_static_data select 2) set [count (wai_static_data select 2), _helicopter];  // added for vehicle monitor
};

_unitGroup allowFleeing 0;
_unitGroup setBehaviour "CARELESS";
_unitGroup setSpeedMode "FULL";

if(_aitype == "Hero") then {
	_unitGroup setCombatMode ai_hero_combatmode;
	_unitGroup setBehaviour ai_hero_behaviour;
} else {
	_unitGroup setCombatMode ai_bandit_combatmode;
	_unitGroup setBehaviour ai_bandit_behaviour;
};

// Add waypoints to the chopper group.
_wp = _unitGroup addWaypoint [[(_position select 0), (_position select 1)], 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 100;

_drop = True;
_helipos = getPos _helicopter;

while {(alive _helicopter) && (_drop)} do {

	private ["_magazine","_weapon","_weapon","_chute","_para","_pgroup"];
	sleep 1;
	_helipos = getPos _helicopter;

	if (_helipos distance [(_position select 0),(_position select 1),100] <= 200) then {

		if(_aitype == "Hero") then {
			_pgroup	= createGroup RESISTANCE;
		} else {
			_pgroup	= createGroup EAST;
		};
		
		// Add unit group to an array for mission clean up
		if (!isNil "_mission") then {
			((wai_mission_data select _mission) select 1) set [count ((wai_mission_data select _mission) select 1), _pgroup];
		} else {
			(wai_static_data select 1) set [count (wai_static_data select 1), _pgroup];
		};

		for "_x" from 1 to _paranumber do {

			_helipos = getPos _helicopter;

			call {
				if (typeName(_gun) == "SCALAR") then {
					if(_gun == 0) 			exitWith { _aiweapon = ai_wep_random call BIS_fnc_selectRandom; };
					if(_gun == 1) 			exitWith { _aiweapon = ai_wep_machine; };
					if(_gun == 2) 			exitWith { _aiweapon = ai_wep_sniper; };
				} else {
					if(_gun == "random") 	exitWith { _aiweapon = ai_wep_random call BIS_fnc_selectRandom; };
				};
			};

			_weapon 	= _aiweapon call BIS_fnc_selectRandom;
			_magazine 	= _weapon call find_suitable_ammunition;

			call {
				if (typeName(_gear) == "SCALAR") then {
					if(_gear == 0) 			exitWith { _aigear = ai_gear0; };
					if(_gear == 1) 			exitWith { _aigear = ai_gear1; };
				} else {
					if(_gear == "random") 	exitWith { _aigear = ai_gear_random call BIS_fnc_selectRandom; };
				};
			};

			_gearmagazines 		= _aigear select 0;
			_geartools 			= _aigear select 1;
			
			call {
				if(_backpack == "random") 	exitWith { _aipack = ai_packs call BIS_fnc_selectRandom; };
				if(_backpack == "none") 	exitWith { };
				_aipack = _backpack;
			};
				
			call {
				if (_skin == "random") 	exitWith { _aiskin = ai_all_skin call BIS_fnc_selectRandom; };
				if (_skin == "hero") 	exitWith { _aiskin = ai_hero_skin call BIS_fnc_selectRandom; };
				if (_skin == "bandit") 	exitWith { _aiskin = ai_bandit_skin call BIS_fnc_selectRandom; };
				if (_skin == "special") exitWith { _aiskin = ai_special_skin call BIS_fnc_selectRandom; };
				_aiskin = _skin;
			};

			if(typeName _aiskin == "ARRAY") then {
				_aiskin = _aiskin call BIS_fnc_selectRandom;
			};

			_para = _pgroup createUnit [_aiskin,[0,0,0],[],1,"FORM"];
			
			_para enableAI "TARGET";
			_para enableAI "AUTOTARGET";
			_para enableAI "MOVE";
			_para enableAI "ANIM";
			_para enableAI "FSM";

			removeAllWeapons _para;
			removeAllItems _para;
			
			_para addWeapon _weapon;
			
			for "_i" from 1 to _mags do {
				_para addMagazine _magazine;
			};
			
			if(_backpack != "none") then {
				_para addBackpack _aipack;
			};
			
			{
				_para addMagazine _x
			} count _gearmagazines;
			
			{
				_para addWeapon _x
			} count _geartools;
			
			if (sunOrMoon != 1) then {
				_para addWeapon "NVGoggles";
			};
			
			call {
				if(_skill == "easy") 	exitWith { _aicskill = ai_skill_easy; };
				if(_skill == "medium") 	exitWith { _aicskill = ai_skill_medium; };
				if(_skill == "hard") 	exitWith { _aicskill = ai_skill_hard; };
				if(_skill == "extreme") exitWith { _aicskill = ai_skill_extreme; };
				if(_skill == "random") 	exitWith { _aicskill = ai_skill_random call BIS_fnc_selectRandom; };
				_aicskill = ai_skill_random call BIS_fnc_selectRandom;
			};
			
			{
				_para setSkill [(_x select 0),(_x select 1)]
			} count _aicskill;
			
			ai_ground_units = (ai_ground_units + 1);
			_para addEventHandler ["Killed",{[_this select 0, _this select 1, "ground"] call on_kill;}];
			_chute = createVehicle ["ParachuteWest", [(_helipos select 0), (_helipos select 1), (_helipos select 2)], [], 0, "NONE"];
			_para moveInDriver _chute;
			[_para] joinSilent _pgroup;

			uiSleep 1.5;
			
			if(!isNil "_mission") then {

				_mission_data = (wai_mission_data select _mission);

				if (typeName _mission_data == "ARRAY") then {
					_ainum = _mission_data select 0;
					wai_mission_data select _mission set [0, (_ainum + 1)];
					_para setVariable ["missionclean", "ground"];
					_para setVariable ["mission", _mission, true];
				};

			} else {
				wai_static_data set [0, ((wai_static_data select 0) + 1)];
			};
		};

		call {
			if (_aitype == "Hero") 		exitWith { { _x setVariable ["Hero",true,true]; } count (units _pgroup); };
			if (_aitype == "Bandit") 	exitWith { { _x setVariable ["Bandit",true,true]; } count (units _pgroup); };
			if (_aitype == "Special") 	exitWith { { _x setVariable ["Special",true,true]; } count (units _pgroup); };
		};
		
		_drop = false;
		_pgroup selectLeader ((units _pgroup) select 0);

		if(wai_debug_mode) then { diag_log format ["WAI: Spawned in %1 ai units for paradrop",_paranumber]; };

		[_pgroup,_position,_skill] call group_waypoints;
		
		if(_aitype == "Hero") then {
			_pgroup setCombatMode ai_hero_combatmode;
			_pgroup setBehaviour ai_hero_behaviour;
		} else {
			_pgroup setCombatMode ai_bandit_combatmode;
			_pgroup setBehaviour ai_bandit_behaviour;
		};
	};
};

if (_helipatrol) then { 
	
	_wp1 = _unitGroup addWaypoint [[(_position select 0),(_position select 1)], 100];
	_wp1 setWaypointType "SAD";
	_wp1 setWaypointCompletionRadius 150;
	_unitGroup setBehaviour "AWARE";
	_unitGroup setSpeedMode "FULL";
	
	{
		_x addEventHandler ["Killed",{[_this select 0, _this select 1, "air"] call on_kill;}];
	} forEach (units _unitgroup);

} else {

	{
		_x doMove [(_start_position select 0), (_start_position select 1), 100]
	} count (units _unitGroup);
	
	_unitGroup setBehaviour "CARELESS";
	_unitGroup setSpeedMode "FULL";

	_cleanheli = true;
	
	while {_cleanheli} do {

		uiSleep 5;
		_helipos1 = getPos _helicopter;
		
		if ((_helipos1 distance [(_start_position select 0),(_start_position select 1),100] <= 2000) || (!alive _helicopter)) then {
			
			deleteVehicle _helicopter;
			{
				deleteVehicle _x;
				ai_air_units = (ai_air_units -1);
			} count (units _unitgroup);

			deleteGroup _unitGroup;
			if(wai_debug_mode) then { diag_log "WAI: Paradrop helicopter cleaned"; };
			_cleanheli = false;
		};

	};
	
};
