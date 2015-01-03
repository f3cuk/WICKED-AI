if(isServer) then {
	 
	private 		["_complete","_baserunover","_mission","_directions","_position","_crate","_num","_crate_type","_baserunover0","_baserunover1","_baserunover2","_baserunover3","_baserunover4","_baserunover5","_baserunover6","_baserunover7"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [80] call find_position;
	[_mission,_position,"Hard","bandit Base","MainBandit",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Bandit] bandit Base]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_large call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];
	
	//Buildings
	_baserunover0 	= createVehicle ["Land_BagBunker_Large_F",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover1 	= createVehicle ["Land_BagBunker_Large_F",[(_position select 0) + 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover2 	= createVehicle ["Land_BagBunker_Large_F",[(_position select 0), (_position select 1) - 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover3 	= createVehicle ["Land_BagBunker_Large_F",[(_position select 0), (_position select 1) + 40,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover4 	= createVehicle ["Land_Cargo_Tower_V3_F",[(_position select 0) - 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover5 	= createVehicle ["Land_Cargo_Tower_V3_F",[(_position select 0) + 10, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover6 	= createVehicle ["Land_Cargo_Tower_V3_F",[(_position select 0), (_position select 1) - 10,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover7 	= createVehicle ["Land_Cargo_Tower_V3_F",[(_position select 0), (_position select 1) + 10,-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover = [_baserunover0,_baserunover1,_baserunover2,_baserunover3,_baserunover4,_baserunover5,_baserunover6,_baserunover7];
	
	_directions = [90,270,0,180,0,180,270,90];
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
	
	{ _x setVectorUp surfaceNormal position _x; } count _baserunover;
	
	//Group Spawning
	_num = 4 + round (random 3);
	[[_position select 0,_position select 1,0],_num,"Hard",["Random","AT"],4,"Random","bandit","Random","bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Hard","Random",4,"Random","bandit","Random","bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Hard","Random",4,"Random","bandit","Random","bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Hard","Random",4,"Random","bandit","Random","bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Hard","Random",4,"Random","bandit","Random","bandit",_mission] call spawn_group;

	//Humvee Patrol
	[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Hard","bandit","bandit",_mission] call vehicle_patrol;
	 
	//Static Guns
	[[[(_position select 0) - 10, (_position select 1) + 10, 0]],"I_HMG_01_high_weapon_F","Hard","bandit","bandit",0,2,"Random","Random",_mission] call spawn_static;
	[[[(_position select 0) + 10, (_position select 1) - 10, 0]],"I_HMG_01_high_weapon_F","Hard","bandit","bandit",0,2,"Random","Random",_mission] call spawn_static;
	[[[(_position select 0) + 10, (_position select 1) + 10, 0]],"I_HMG_01_high_weapon_F","Hard","bandit","bandit",0,2,"Random","Random",_mission] call spawn_static;
	[[[(_position select 0) - 10, (_position select 1) - 10, 0]],"I_HMG_01_high_weapon_F","Hard","bandit","bandit",0,2,"Random","Random",_mission] call spawn_static;

	//Heli Paradrop
	[[(_position select 0), (_position select 1), 0],[0,0,0],400,"UH1H_DZ",10,"Hard","Random",4,"Random","bandit","Random","bandit",true,_mission] spawn heli_para;

	//Condition
	_complete = [
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"bandites have setup a heavily fortified base, are you bandit enough to take them down?",	// mission announcement
		"Bandits have captured the bandit base",										// mission success
		"Bandits did not capture the base in time"									// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,[16,ai_wep_sniper],[8,crate_tools_sniper],[3,crate_items_high_value],[4,crate_backpacks_large]] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Bandit] bandit Base]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};