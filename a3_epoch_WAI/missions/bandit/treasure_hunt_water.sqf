if(isServer) then {

	private ["_SceneryType","_allScenery","_allLight","_wreck","_allTreasure","_treasure_totel","_complete","_crate_type","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2","_mps"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;
	waitUntil{!isNil "_mission"};

	_fn_position	= [10,4] call find_position;
	_position		= _fn_position select 0;
	_missionType	= _fn_position select 1;
	
	[_mission,_position,"easy","Treasure hunt","MainBandit",false] call mission_init;
	diag_log 		format["WAI: [Mission: treasure_hunt_water]: Starting... %1",_position];

	// Scenery
	_wreck 			= createVehicle ["Land_UWreck_MV22_F",[(_position select 0), (_position select 1), 0],[],10,"CAN_COLLIDE"];
	_wreck 			setPosATL [(getposatl _wreck select 0), (getposatl _wreck select 1), 0];
	_position 		= _wreck call wai_GetPos;
	_treasure_total = 30;
	_SceneryType	= ["Land_HumanSkeleton_F","Land_HumanSkull_F","CraterLong_small","CraterLong","Land_AncientPillar_damaged_F","Land_AncientPillar_fallen_F"];
	_allTreasure 	= [];
	_allLight 		= [];
	_allArrow 		= [];
	_allScenery		= [];
	
	//Spawn sharks	
	0 = _position spawn {
		//waitUntil( { isPlayer _x && _x distance _position < 500 } count playableunits > 0 );
		for "_x" from 1 to floor((random 6)+1) do {
			private["_shark","_position"];
			_position = [_this, (random 10) + 3, random 360] call BIS_fnc_relPos;
			_shark = createAgent ["GreatWhite_F", _position, [], 10, "NONE"];
			_shark disableAI "TARGET";_shark disableAI "AUTOTARGET";_shark disableAI "FSM";
			[_shark] execFSM "\x\addons\a3_epoch_code\System\Shark_Brain.fsm";
		};
	};

	//Spawn loot
	for "_x" from 1 to _treasure_total do {
		private["_Scenery_pos","_treasure_pos","_mps","_light","_Arrow","_Scenery"];
		
		_treasure_pos = [_position, (random 40) + 10, random 360] call BIS_fnc_relPos;
		//_Scenery_pos = [_position, (random 40) + 10, random 360] call BIS_fnc_relPos;
		
		// light 
		_light=createVehicle["Chemlight_red",_treasure_pos,[],0.1,"CAN_COLLIDE"];
		diag_log(str _light);
		//_Scenery=createVehicle[(_SceneryType call BIS_fnc_selectRandom),_Scenery_pos,[],0.1,"CAN_COLLIDE"];
		
		// Loot
		_mps=createVehicle["Land_MPS_EPOCH",_treasure_pos,[],0.1,"CAN_COLLIDE"];
		_mps setVariable["Crypto",ai_crypto_bomb,true];
		diag_log(str _mps);
		
		// Debug arrow
		_Arrow=createVehicle["Sign_Arrow_F",_treasure_pos,[],0.1,"CAN_COLLIDE"];
		_Arrow attachTo [_mps,[0,0,0.5]];
		diag_log(str _Arrow);

		_allTreasure 	pushBack _mps;
		_allLight 		pushBack _light;
		_allArrow 		pushBack _Arrow;
		//_allScenery 	pushBack _Scenery;
	};
	_baserunover = [_wreck]+_allTreasure+_allLight;
	{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;


	//Condition
	_complete = [
		[_mission,_wreck],			// mission number and crate
		["crate"],					// ["crate"], or ["kill"], or ["assassinate", _unitGroup], "bomb"
		[_baserunover+_allArrow], 	// cleanup objects
		"Sonars have detected an underwater treasure, watch out for sharks!",	// mission announcement
		"Divers have secured the treasure",	// mission success
		"Waves wash away at treasures"		// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Mission:[treasure_hunt_water]: Ended at %1",_position];
	b_missionsrunning = b_missionsrunning - 1;
};