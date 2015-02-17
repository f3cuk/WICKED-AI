/*
	All the code and information provided here is provided under a Commons License.
	http://creativecommons.org/licenses/by-sa/3.0/
*/
if(isServer) then {
	 
	private 		["_complete","_baserunover","_mission","_directions","_position","_crate","_num","_crate_type","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_fn_position	= [30] call find_position;
	_position		= _fn_position select 0;
	_missionType	= _fn_position select 1;
	[_mission,_position,"medium","Rebel Base","MainBandit",true] call mission_init;
	
	diag_log 		format["WAI: [Mission: Rebel Base]: Starting... %1",_position];

	//Setup the crate
	_crate = [2,_position] call wai_spawn_create;
	
	//Buildings
	_baserunover0 	= createVehicle ["Land_BagBunker_Large_F",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover1 	= createVehicle ["Land_BagBunker_Large_F",[(_position select 0) + 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover2 	= createVehicle ["Land_BagBunker_Large_F",[(_position select 0), (_position select 1) - 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover3 	= createVehicle ["Land_BagBunker_Large_F",[(_position select 0), (_position select 1) + 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover4 	= createVehicle ["Land_Cargo_Patrol_V2_F",[(_position select 0) - 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover5 	= createVehicle ["Land_Cargo_Patrol_V2_F",[(_position select 0) + 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover6 	= createVehicle ["Land_Cargo_Patrol_V2_F",[(_position select 0), (_position select 1) - 10,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover7 	= createVehicle ["Land_Cargo_Patrol_V2_F",[(_position select 0), (_position select 1) + 10,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7];
	
	_directions = [90,270,0,180,0,180,270,90];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
	
	{ _x setVectorUp surfaceNormal position _x; } count _baserunover;
	
	//Group Spawning
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"medium",[1,"AT"],"bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"medium","Random","bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"medium",0,"bandit",_mission] call spawn_group;
	//[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],3,"medium",0,"bandit",_mission] call spawn_group;

	[[
		[(_position select 0) - 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0],
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) - 10, (_position select 1) - 10, 0]
	],"O_HMG_01_high_F","medium","bandit",_mission] call spawn_static;

	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"Rebel have setup a heavily fortified base",	// mission announcement
		"Survivers have captured the bandit base",		// mission success
		"Survivers did not capture the base in time"	// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,[16,(ai_assault_wep+ai_machine_wep+ai_sniper_wep)],[8,crate_items],[3,crate_items_high_value],[4,crate_backpacks_large]] call dynamic_crate;
	};

	diag_log format["WAI: [Mission: bandit Base]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};