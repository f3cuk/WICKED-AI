if(isServer) then {
	 
	private 		["_complete","_baserunover","_mission","_directions","_position","_crate","_num","_crate_type","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [80] call find_position;
	[_mission,_position,"Hard","Gem Tower","MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Hero] Gem Tower]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_small call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) -20,(_position select 1) + 11,0],[],0,"CAN_COLLIDE"];
	
	//Buildings
_baserunover0 = createVehicle ["Land_Misc_Coltan_Heap_EP1",[(_position select 0) - 3.41, (_position select 1) + 16.4,-1],[], 0, "CAN_COLLIDE"];;
_baserunover1 = createVehicle ["MAP_Ind_SiloVelke_01",[(_position select 0) - 0.01, (_position select 1) - 0.01,-0.25],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["MAP_Ind_SiloVelke_01",[(_position select 0) - 21, (_position select 1) - 0.4,-0.25],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["Land_Misc_Coltan_Heap_EP1",[(_position select 0) - 31, (_position select 1) + 12,-2],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["Land_A_Castle_Bastion",[(_position select 0) - 21, (_position select 1) + 11,-0.2],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["Land_Misc_Coltan_Heap_EP1",[(_position select 0) - 26, (_position select 1) + 34,-2],[], 0, "CAN_COLLIDE"];
_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5];
	
	_directions = [-82.16,0,182.209,8.27,0,0];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
	
	{ _x setVectorUp surfaceNormal position _x; } count _baserunover;
	
	//Troops
	_num = 4 + round (random 3);
	[[(_position select 0) + 29, (_position select 1) - 21, 0],_num,"Hard",["Random","AT"],4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[(_position select 0) + 21, (_position select 1) + 19, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[(_position select 0) - 23, (_position select 1) - 19, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[(_position select 0) - 12, (_position select 1) + 23, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[(_position select 0) - 18, _position select 1, 0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//Humvee Patrol
[[(_position select 0) + 50, _position select 1, 0],[(_position select 0) - 60, _position select 1, 0],50,2,"HMMWV_Armored","Hard","Bandit","Bandit",_mission] call vehicle_patrol;
	 
	//Static Guns
[[[(_position select 0) - 1, (_position select 1) + 39, 0]],"KORD_high_TK_EP1","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;
[[[(_position select 0) + 33, (_position select 1) - 21, 0]],"KORD_high_TK_EP1","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"GEM TOWER! Climb up the tower and down the other side to get the loot",	// mission announcement
		"Survivors captured the Gem Tower, HOOAH!!",															// mission success
		"Survivors were unable to capture the Gem Tower"														// mission fail
	] call mission_winorfail;

	if(_complete) then {
	[_crate,8,5,[4,crate_items_gems],3,2] call dynamic_crate;
	};	
	
	diag_log format["WAI: [Mission:[Hero] Gem Tower]: Ended at %1",_position];

	h_missionsrunning = h_missionsrunning - 1;
};