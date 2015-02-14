/*
	Medical Supply Camp by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)
	Updated to New Mission Format by itsatrap/nerdalertdk
*/
if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2",
					"_base1","_base2","_base3","_base4","_base5","_base6","_base7","_base8","_base9",
					"_base10","_base11","_base12","_base13","_base14","_base15","_base16","_base17"];

	// Get mission number, important we do this early
	_mission 		= count wai_mission_data -1;
	waitUntil{!isNil "_mission"};

	_fn_position	= [50] call find_position;
	_position		= _fn_position select 0;
	_missionType	= _fn_position select 1;
	
	[_mission,_position,"Easy","Medical Supply Camp","MainBandit",true] call mission_init;
	diag_log 		format["WAI: [Mission:  Medical Supply Camp]: Starting... %1",_position];

	//Setup the crate
	_crate = [0,_position] call wai_spawn_create;

	//Medical Supply Camp
	//Create the scenery
	/* 
	_device = createVehicle ["Land_Device_assembled_F",[(_position select 0) - 5.939,(_position select 1) + 10.0459,0],[], 0, "CAN_COLLIDE"];
	_device setDir -31.158424;
	_device setVehicleLock "LOCKED";
	_device setPos [(_position select 0) - 5.939,(_position select 1) + 10.0459,0];

	_laptop = createVehicle ["Land_Laptop_device_F",[(_position select 0) + 6.3374, (_position select 1) - 11.1944,0],[], 0, "CAN_COLLIDE"];
	_laptop setDir -211.14516;
	_laptop setVehicleLock "LOCKED";
	_laptop setPos [(_position select 0) + 6.3374, (_position select 1) - 11.1944,0];

	_base3 = createVehicle ["Land_Rampart_F",[(_position select 0) + 12.2456, (_position select 1) + 6.249,0],[], 0, "CAN_COLLIDE"];
	_base3 setDir -120.93051;
	_base3 setPos [(_position select 0) + 12.2456, (_position select 1) + 6.249,0];

	_base4 = createVehicle ["Land_Rampart_F",[(_position select 0) - 11.4253, (_position select 1) - 7.628,0],[], 0, "CAN_COLLIDE"];
	_base4 setDir 59.42643;
	_base4 setPos [(_position select 0) - 11.4253, (_position select 1) - 7.628,0];

	_base5 = createVehicle ["Land_CratesWooden_F",[(_position select 0) - 7.1519, (_position select 1) + 1.8144,0],[], 0, "CAN_COLLIDE"];
	_base5 setDir -29.851013;

	_base6 = createVehicle ["Land_CratesWooden_F",[(_position select 0) - 7.4116, (_position select 1) + 2.5244,0],[], 0, "CAN_COLLIDE"];

	_base7 = createVehicle ["WeaponHolder_ItemToolbox",[(_position select 0) - 7.7041, (_position select 1) + 3.332,0],[], 0, "CAN_COLLIDE"];
	_base7 setDir -106.46461;

	_base8 = createVehicle ["CamoNet_INDP_F",[(_position select 0) + 4.1738, (_position select 1) - 7.9112],[], 0, "CAN_COLLIDE"];
	_base8 setDir -27.004126;
	_base8 setPos [(_position select 0) + 4.1738, (_position select 1) - 7.9112];

	_base9 = createVehicle ["Land_PowerGenerator_F",[(_position select 0) - 0.8936, (_position select 1) + 8.1582,0],[], 0, "CAN_COLLIDE"];
	_base9 setDir -56.044361;

	_base10 = createVehicle ["Land_BarrelWater_F",[(_position select 0) - 2.5074, (_position select 1) + 7.3466,0],[], 0, "CAN_COLLIDE"];

	_base11 = createVehicle ["Land_BarrelWater_F",[(_position select 0) - 3.293, (_position select 1) + 7.9179,0],[], 0, "CAN_COLLIDE"];

	_base12 = createVehicle ["FirePlace_burning_F",[(_position select 0) + 3.1367, (_position select 1) - 5.087,0],[], 0, "CAN_COLLIDE"];

	_base13 = createVehicle ["Land_CampingChair_V2_F",[(_position select 0) + 0.8589, (_position select 1) - 6.2676,0],[], 0, "CAN_COLLIDE"];
	_base13 setDir -132.43658;

	_base14 = createVehicle ["Land_CampingChair_V2_F",[(_position select 0) + 2.6909, (_position select 1) - 7.4805,0],[], 0, "CAN_COLLIDE"];
	_base14 setDir -184.45828;

	_base15 = createVehicle ["Land_CampingChair_V2_F",[(_position select 0) + 5.4175, (_position select 1) - 5.4903,0],[], 0, "CAN_COLLIDE"];
	_base15 setDir 96.993355;

	_base16 = createVehicle ["Land_CampingChair_V2_F",[(_position select 0) + 4.5722, (_position select 1) - 7.2305,0],[], 0, "CAN_COLLIDE"];
	_base16 setDir 142.91867;

	_base17 = createVehicle ["Land_CampingChair_V2_F",[(_position select 0) + 5.0542, (_position select 1) - 3.4649,0],[], 0, "CAN_COLLIDE"];
	_base17 setDir 55.969147;

	_baserunover = [_device,_laptop,_base3,_base4,_base5,_base6,_base7,_base8,_base9,_base10,_base11,_base12,_base13,_base14,_base15,_base16,_base17];
	{ _x setVectorUp surfaceNormal position  _x; } count _baserunover; */

	//Troops
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],4,"Medium",[1,"AT"],"bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],4,"Medium","Random","bandit",_mission] call spawn_group;
	[[(_position select 0) + (random(10)+1),(_position select 1) - (random(15)+1),0],4,"Medium",0,"bandit",_mission] call spawn_group;

	//Condition
	_complete = [
		[_mission,_laptop],				// mission number and crate
		["kill"],						// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 				// cleanup objects
		"A soldier squad have set up a medical re-supply camp! Check your map for the location!",	// mission announcement
		"Survivors have taken control of the medical supply camp!",									// mission success
		"Survivors were unable to capture the medical supply camp"									// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,0,0,[30,crate_items_medical],2] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Medical Supply Camp]: Ended at %1",_position];
	
	b_missionsrunning = b_missionsrunning - 1;
};