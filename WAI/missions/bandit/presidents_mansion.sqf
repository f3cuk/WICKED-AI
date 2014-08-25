if(isServer) then {

	private			["_mission","_position","_crate","_playerPresent","_rndnum","_baserunover","_president","_firstlady"];

	_position		= [50] call find_position;
	_mission		= [_position,"Extreme","Presidents in Town","MainBandit",true] call mission_init;
	
	diag_log 		format["WAI: [Bandit] presidents_mansion started at %1",_position];

	//Large Gun Box
	_crate = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1) - 1, .5],[],0,"CAN_COLLIDE"];
	[_crate] call Large_Gun_Box;
	 
	//Presidents
	_baserunover 	= createVehicle ["Land_A_Office01",[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];

	//Troops
	[[_position select 0,_position select 1,0],4,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Extreme","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;

	//The President Himself
	_president = [[_position select 0, _position select 1, 0],1,"Extreme","Random",4,"none","Special","Random",["Hero",750],_mission] call spawn_group;
	_firstlady = [[_position select 0, _position select 1, 0],1,"Easy","Unarmed",4,"none","Secretary1","Random",["Hero",250],_mission] call spawn_group;

	//Humvee Patrol
	[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Random","Hero","Hero",_mission] call vehicle_patrol;

	//Heli Paradrop
	[[(_position select 0),(_position select 1),0],[0,0,0],800,"UH60M_EP1_DZE",6,"Random","Random",4,"Random","Hero","Random","Hero",true,_mission] spawn heli_para;
	[[(_position select 0),(_position select 1),0],[30,30,0],800,"UH60M_EP1_DZE",6,"Random","Random",4,"Random","Hero","Random","Hero",true,_mission] spawn heli_para;
	[[(_position select 0),(_position select 1),0],[60,0,0],800,"UH60M_EP1_DZE",6,"Random","Random",4,"Random","Hero","Random","Hero",true,_mission] spawn heli_para;
	
	//Static mounted guns
	[[
		[(_position select 0) - 13.135, (_position select 1) + 5.025, 5.27],
		[(_position select 0) + 14.225, (_position select 1) + 5.025, 5.27],
		[(_position select 0) + 1.97, (_position select 1) - 2.368, 10.54]
	],"M2StaticMG","Extreme","Hero","Hero",1,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],			// mission number and crate
		["assassinate",_president], // ["crate",wai_kill_percent], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 			// cleanup objects
		"The President is in town for a press conference, rumour has it bandits are planning his assasination",	// mission announcement
		"The President has been assassinated, a day of mourning has been announced",							// mission success
		"The President managed to get away from the assasination attempt"										// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Bandit] presidents_mansion ended at %1",_position];
	b_missionrunning = false;
};