if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2","_mps"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;
	waitUntil{!isNil "_mission"};

	_fn_position	= [5,1] call find_position;
	_position		= _fn_position select 0;
	_missionType	= _fn_position select 1;
	
	[_mission,_position,"hard","Nuclear device","MainBandit",false] call mission_init;
	diag_log 		format["WAI: [Mission: Nuclear device]: Starting... %1",_position];

	//Setup the crate
	_crate = [0,_position] call wai_spawn_create;
	_position = getposATL _crate;
	
	// Hide the create
	deleteVehicle _crate;
	//_crate setPos [(_position select 0),(_position select 1),-2000];

	//Nuke site
	//Create the scenery
	private["_tent","_device","_table","_laptop","_berrels","_boxEmpty","_palletMil","_pallets","_solar","_gen","_hbar"];

	//_tent = createVehicle ["Land_PartyTent_01_F",[(_position select 0),(_position select 1),(_position select 2)],[],0,"CAN_COLLIDE"];
	_tent = createVehicle ["CamoNet_BLUFOR_big_F",[(_position select 0),(_position select 1),(_position select 2)],[],0,"CAN_COLLIDE"];
	_device = createVehicle ["Land_Device_assembled_F",[(_position select 0)+3.5,(_position select 1)+2,(_position select 2)],[],0,"CAN_COLLIDE"];
	_table = createVehicle ["Land_CampingTable_small_F",[(_position select 0)+1.3,(_position select 1)+4,(_position select 2)],[],0,"CAN_COLLIDE"];
	_laptop = createVehicle ["Land_Laptop_unfolded_F", [(_position select 0),(_position select 1),(_position select 2)],[],0,"CAN_COLLIDE"];
	_laptop attachTo [_table,[0,0,0.58]];
	_laptop setDir 180;
	_berrels = createVehicle ["CargoNet_01_barrels_F", [(_position select 0)+3.5,(_position select 1)-1.8,(_position select 2)],[],0,"CAN_COLLIDE"];
	_boxEmpty = createVehicle ["Land_PaperBox_open_empty_F",[(_position select 0)-3.5,(_position select 1)+4,(_position select 2)],[],0,"CAN_COLLIDE"];
	_palletMil = createVehicle ["Land_Pallet_MilBoxes_F",[(_position select 0)-1.8,(_position select 1)+4,(_position select 2)],[],0,"CAN_COLLIDE"];
	_pallets = createVehicle ["Land_Pallets_F", [(_position select 0)-2.5,(_position select 1)+1,(_position select 2)],[],0,"CAN_COLLIDE"];
	_solar = createVehicle ["Land_spp_Mirror_F", [(_position select 0)-8,(_position select 1)-5,(_position select 2)],[],0,"CAN_COLLIDE"];
	_solar setDir 260;
	_gen = createVehicle ["Land_PowerGenerator_F", [(_position select 0)-4,(_position select 1)-3,(_position select 2)],[],0,"CAN_COLLIDE"];
	_hbar = createVehicle ["Land_HBarrier_5_F", [(_position select 0),(_position select 1)-7,(_position select 2)],[],0,"CAN_COLLIDE"];
	
	_baserunover = [_tent,_device,_table,_laptop,_berrels,_boxEmpty,_palletMil,_pallets,_solar,_gen,_hbar];
	{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

	//Troops
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],4,"hard",[1,"AT"],"bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],4,"hard","Random","bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],4,"hard",0,"bandit",_mission] call spawn_group;

	//Condition
	_complete = [
		[_mission,_laptop],				// mission number and crate
		["bomb"],						// ["crate"], or ["kill"], or ["assassinate", _unitGroup], "bomb"
		[_baserunover], 				// cleanup objects
		"A soldier squad have set up a nuclear device! Hurry disable it before it goes off<br/>You have 30 min to disarm it.",	// mission announcement
		"Survivors have taken control of the nuclear device!",		// mission success
		"Nuclear device detonated!!<br/>Seek cover!"															// mission fail
	] call mission_winorfail;

	if(_complete) then {
		//[_crate,0,0,[30,crate_items_medical],2] call dynamic_crate;
		
		//Reward
		if(ai_crypto_bomb > 0) then {
			_mps=createVehicle["Land_MPS_EPOCH",(getposATL _laptop),[],0.2,"CAN_COLLIDE"];
			diag_log format["ADMIN: Created crypto device for %1 with %2 at %3","NUKE",ai_crypto_bomb,(getposATL _laptop)];
			_mps attachTo [_laptop,[-0.6,0,0]];
			_mps setVariable["Crypto",ai_crypto_bomb,true];
		};
	};

	diag_log format["WAI: [Mission:[Nuclear device]: Ended at %1",_position];
	b_missionsrunning = b_missionsrunning - 1;
};