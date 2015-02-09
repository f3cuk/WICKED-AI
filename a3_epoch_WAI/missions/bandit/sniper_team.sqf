if(isServer) then {

	private 		["_complete","_vehicle","_rndnum","_crate_type","_crate","_mission","_tanktraps","_mines","_playerPresent","_cleanmission","_currenttime","_starttime","_missiontimeout","_vehname","_veh","_position","_vehclass","_vehdir","_objPosition"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [30] call find_position;
	[_mission,_position,"easy",format["Sniper Team"],"MainBandit",true] call mission_init;	
	
	diag_log 		format["WAI: [Mission:[Bandit] Sniper Team]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_medium call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),-50],[],0,"CAN_COLLIDE"];
	// Clear it
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;

	//Base
	_baserunover 	= createVehicle ["Land_HelipadEmpty_F",[((_position select 0) + 5), ((_position select 1) + 5), -50],[],10,"CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;
	
	// SNIPER TEAM
	/*
		_position
		_unitnumber
		_skill
		_aisoldier
		_aitype
		_mission
	*/
	[[(_position select 0) + (random(30)+1),(_position select 1) - (random(35)+1),0],3,"easy",2,"bandit",_mission] call spawn_group;
	
	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["kill",100], 			// ["crate"], or ["kill",wai_kill_percent], or ["assassinate", _unitGroup],
		[_baserunover], 		// cleanup objects
		"Our scouts have spottede a sniper team, check the map for there location",	// mission announcement
		"Bandits have killed the snipers!",											// mission success
		"Bandits did not secure the sniper rifles in time"							// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Mission:[Bandit] Sniper Team]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};