if(isServer) then {

	private ["_mission","_baserunover","_position","_crate","_crate_type","_girls","_girls1","_girls2","_girls3","_girls4","_dirtyowner"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;

	_position		= [10] call find_position;
	[_mission,_position,"ColorPink","Bunny Ranch","Special",false] call mission_init;
		
	diag_log format	["WAI: Mission Bunny Ranch Started At %1",_position];

	//Setup the crate
	_crate_type 	= crates_large call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0),(_position select 1),0],[],0,"CAN_COLLIDE"];

	[_crate,0,0,10,0] call dynamic_crate;
	 
	//Ranch & Girls
	_baserunover = createVehicle ["Land_A_Villa_EP1",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];

	_girls1 = [[_position select 0, _position select 1, 0],4,"Extreme","Unarmed",0,"Random","RU_Hooker2","Random",["Hero",80],_mission] call spawn_group;
	_girls2 = [[_position select 0, _position select 1, 0],2,"Extreme","Unarmed",0,"Random","RU_Hooker3","Random",["Hero",80],_mission] call spawn_group;
	_girls3 = [[_position select 0, _position select 1, 0],2,"Extreme","Unarmed",0,"Random","RU_Hooker4","Random",["Hero",80],_mission] call spawn_group;
	_girls4 = [[_position select 0, _position select 1, 0],2,"Extreme","Unarmed",0,"Random","RU_Hooker5","Random",["Hero",80],_mission] call spawn_group;
	_girls = [_girls1,_girls2,_girls3,_girls4];
	
	//Bunny Ranch Owner
	_dirtyowner = [[_position select 0, _position select 1, 0],1,"Extreme","Random",4,"Random","Ins_Lopotev","Random",["Bandit",500],_mission] call spawn_group;

	[
		[_mission,_crate],								// mission number and crate
		["assassinate",_dirtyowner], 					// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 								// cleanup objects
		"The Owner of the Bunny Ranch has been beating his girls again, go give him a taste of his own medicine!",	// mission announcement
		"The Bunny Ranch is YOURS! The Girls want to show their gratitude",											// mission success
		"News reports of several women found beaten to death!"														// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Mission Bunny Ranch Ended At %1",_position];

	s_missionsrunning = s_missionsrunning - 1;
};