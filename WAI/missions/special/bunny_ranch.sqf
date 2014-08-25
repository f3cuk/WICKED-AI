//****************Bunny Ranch*****************
//*********Created by HollowAddiction*********
//**********http://www.craftdoge.com**********
//Credit to Creator of WAI http://epochmod.com/forum/index.php?/topic/4427-wicked-aimission-system/
//Credit to MattL for Support http://opendayz.net/members/matt-l.7134/
if(isServer) then {

	private ["_mission","_baserunover","_position","_crate"];
	 
	_position		= [10] call find_position;
	_mission		= [_position,"ColorPink","Bunny Ranch","Special",false] call mission_init;	
	diag_log format	["WAI: Mission Bunny Ranch Started At %1",_position];

	//Large Gun Box
	_crate = createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1), .5], [], 0, "CAN_COLLIDE"];
	[_crate] call Ranch_Safe;
	 
	//Ranch & Girls
	_baserunover = createVehicle ["Land_A_Villa_EP1",[(_position select 0), (_position select 1),0],[], 0, "CAN_COLLIDE"];

	_girls1 = [[_position select 0, _position select 1, 0],4,"Extreme","Unarmed",0,"Random","RU_Hooker2","Random","Hero",_mission] call spawn_group;
	_girls2 = [[_position select 0, _position select 1, 0],2,"Extreme","Unarmed",0,"Random","RU_Hooker3","Random","Hero",_mission] call spawn_group;
	_girls3 = [[_position select 0, _position select 1, 0],2,"Extreme","Unarmed",0,"Random","RU_Hooker4","Random","Hero",_mission] call spawn_group;
	_girls4 = [[_position select 0, _position select 1, 0],2,"Extreme","Unarmed",0,"Random","RU_Hooker5","Random","Hero",_mission] call spawn_group;
	_girls = [_girls1,_girls2,_girls3,_girls4];
	
	//Bunny Ranch Owner
	_dirtyowner = [[_position select 0, _position select 1, 0],1,"Extreme","Random",4,"Random","Ins_Lopotev","Random","Bandit",_mission] call spawn_group;

	[
		[_mission,_crate],								// mission number and crate
		["assassinate",_dirtyowner], 					// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 								// cleanup objects
		"The Owner of the Bunny Ranch has been beating his girls again, Go give him a taste of his own medicine!",	// mission announcement
		"The Bunny Ranch is YOURS! The Girls want to show their gratitude",											// mission success
		"News reports of several women found beaten to death!"														// mission fail
	] call mission_winorfail;

	diag_log format["WAI: Mission Bunny Ranch Ended At %1",_position];
	s_missionrunning = false;
};