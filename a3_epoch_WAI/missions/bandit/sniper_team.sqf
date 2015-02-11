if(isServer) then {

	private 		["_complete","_vehicle","_rndnum","_crate_type","_crate","_mission","_tanktraps","_mines","_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	
	_fn_position	= [5] call find_position;
	_position		= _fn_position select 0;
	_missionType	= _fn_position select 1;
	
	[_mission,_position,"easy","Sniper Team","MainBandit",true] call mission_init;

	diag_log 		format["WAI: [Mission:[Bandit] Sniper Team]: Starting... %1",_position];

	_crate = [0,_position] call wai_spawn_create;
	//Base
	_baserunover 	= createVehicle ["Land_HelipadEmpty_F",[((_position select 0) + 5), ((_position select 1) + 5), -50],[],10,"CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;
	
	[[(_position select 0) + (random(30)+1),(_position select 1) - (random(35)+1),0],2,"easy","random","bandit",_mission] call spawn_group;
	
	//PARA
	[
		[(_position select 0),(_position select 1),0],
		[0,0,0],
		200,
		"B_Heli_Transport_01_camo_EPOCH",
		4,
		"Random",
		"Random",
		"bandit",
		false,
		_mission
	] spawn heli_para;
	
	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["kill",100], 			// ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[_baserunover], 		// cleanup objects
		"Our scouts have spottede a sniper team, check the map for there location",	// mission announcement
		"Bandits have killed the snipers!",											// mission success
		"Bandits did not secure the sniper rifles in time"							// mission fail
	] call mission_winorfail;
	
	if(_complete) then {
		[_crate,[1,ai_sniper_wep],[2,(ai_sniper_gear+ai_sniper_skin+ai_sniper_scope)],0,0] call dynamic_crate;
	};

	diag_log format["WAI: [Mission: Sniper Team]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};