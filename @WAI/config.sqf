if(isServer) then {

	/* GENERAL CONFIG */

		debug_mode					= false;		// enable debug
		use_blacklist				= true;			// use blacklist
		blacklist					= [
			[[0,16000,0],[1000,-0,0]],				// Left
			[[0,16000,0],[16000.0,14580.3,0]]		// Top
		];

	/* END GENERAL CONFIG */

	/* AI CONFIG */

		ai_clear_body 				= false;		// instantly clear bodies
		ai_clean_dead 				= true;			// clear bodies after certain amount of time
		ai_cleanup_time 			= 7200;			// time to clear bodies in seconds
		ai_clean_roadkill			= false; 		// clean bodies that are roadkills
		ai_roadkill_damageweapon	= 0;			// percentage of chance a roadkill will destroy weapon AI is carrying

		ai_bandit_combatmode		= "RED";		// combatmode of bandit AI
		ai_bandit_behaviour			= "COMBAT";		// behaviour of bandit AI

		ai_friendly_behaviour		= false;		// make ai friendly towards comrades

		ai_share_info				= true;			// AI share info on player position
		ai_share_distance			= 300;			// distance from killed AI for AI to share your rough position

		ai_kills_gain				= true;			// add kill to bandit/human kill score
		ai_crypto_gain				= true;			// gain crypto for killing AI
		ai_add_crypto				= 50;			// amount of crypto gained for killing a bandit AI
				
		ai_skill_extreme			= [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["endurance",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Extreme
		ai_skill_hard				= [["aimingAccuracy",0.80],["aimingShake",0.80],["aimingSpeed",0.80],["endurance",1.00],["spotDistance",0.80],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Hard
		ai_skill_medium				= [["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["endurance",1.00],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Medium
		ai_skill_easy				= [["aimingAccuracy",0.40],["aimingShake",0.50],["aimingSpeed",0.50],["endurance",1.00],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Easy
		ai_skill_random				= [ai_skill_extreme,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_easy];

		ai_static_useweapon			= true;	// Allows AI on static guns to have a loadout 	
		ai_static_weapons			= ["O_HMG_01_support_high_F","O_static_AT_F","O_static_AA_F"];	// static guns 

		ai_static_skills			= false;	// Allows you to set custom array for AI on static weapons. (true: On false: Off) 
		ai_static_array				= [["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["endurance",1.00],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];

		ai_gear0 					= [["FAK"],["ItemWatch","NVG_EPOCH","Rangefinder","ItemCompass","Binocular","ItemGPS"]];
		ai_gear1					= [["FAK"],["ItemGPS","Binocular"]];
		ai_gear2					= [["ItemDocument","FoodCanFrankBeans","ItemHeatPack"],["ItemToolbox"]];
		ai_gear3					= [["ItemWaterbottle","ItemBloodbag"],["ItemCompass","ItemCrowbar"]];
		ai_gear4					= [["ItemBandage","ItemEpinephrine","ItemPainkiller"],["ItemGPS","ItemKeyKit"]];
		ai_gear_random				= [ai_gear0,ai_gear1,ai_gear2,ai_gear3,ai_gear4];	// Allows the possibility of random gear

		ai_wep_assault				= ["srifle_EBR_F","arifle_Katiba_F","arifle_MX_F""arifle_TRG20_F","arifle_MXC_F","m16_EPOCH","m16RED_EPOCH","m4a3_EPOCH","AKM_EPOCH"];	// Assault
		ai_wep_machine				= ["LMG_Mk200_F","LMG_Zafir_F","m249Tan_EPOCH","m249_EPOCH"];	// Light machine guns
		ai_wep_sniper				= ["m107Tan_EPOCH","srifle_LRR_F","srifle_DMR_01_F","M14_EPOCH""M14Grn_EPOCH"];	// Sniper rifles
		ai_wep_random				= [ai_wep_assault,ai_wep_assault,ai_wep_assault,ai_wep_sniper,ai_wep_machine];	// random weapon 60% chance assault rifle,20% light machine gun,20% sniper rifle
		ai_wep_launchers_AT			= ["launch_NLAW_F","launch_RPG32_F"];
		ai_wep_launchers_AA			= ["launch_O_Titan_F"];
		
		ai_packs					= ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo"];
		ai_vests					= ["V_1_EPOCH","V_2_EPOCH","V_3_EPOCH","V_4_EPOCH","V_5_EPOCH","V_6_EPOCH","V_7_EPOCH","V_8_EPOCH","V_9_EPOCH","V_10_EPOCH","V_11_EPOCH","V_12_EPOCH","V_13_EPOCH","V_14_EPOCH","V_15_EPOCH","V_16_EPOCH","V_17_EPOCH","V_18_EPOCH","V_19_EPOCH","V_20_EPOCH","V_21_EPOCH","V_22_EPOCH","V_23_EPOCH","V_24_EPOCH","V_25_EPOCH","V_26_EPOCH","V_27_EPOCH","V_28_EPOCH","V_29_EPOCH","V_30_EPOCH","V_31_EPOCH","V_32_EPOCH","V_33_EPOCH","V_34_EPOCH","V_35_EPOCH","V_36_EPOCH","V_37_EPOCH","V_38_EPOCH","V_39_EPOCH","V_40_EPOCH"];
		ai_bandit_skin				= ["U_O_CombatUniform_ocamo","U_O_GhillieSuit","U_O_PilotCoveralls","U_O_Wetsuit","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader","U_Wetsuit_uniform","U_Wetsuit_White","U_Wetsuit_Blue","U_Wetsuit_Purp","U_Wetsuit_Camo","U_Camo_uniform","U_ghillie1_uniform","U_ghillie2_uniform","U_ghillie3_uniform","U_CamoBlue_uniform","U_CamoBrn_uniform","U_CamoRed_uniform"];
		ai_special_skin				= ["U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Poor_1","U_C_WorkerCoveralls","U_C_Journalist","U_C_Scientist","U_OrestesBody"];
		ai_all_skin					= [ai_bandit_skin,ai_special_skin];

		ai_add_skin					= true;			// adds unit skin to inventory on death
	/* END AI CONFIG */

	/* WAI MISSIONS CONFIG */
		wai_mission_system			= true;	// use built in mission system

		wai_mission_markers			= ["DZMSMajMarker","DZMSMinMarker","DZMSBMajMarker","DZMSBMinMarker"];
		wai_avoid_missions			= 750;								// avoid spawning missions this close to other missions, these are defined in wai_mission_markers
		wai_avoid_traders			= 750;								// avoid spawning missions this close to traders
		wai_avoid_town				= 0;								// avoid spawning missions this close to towns, *** doesn't function with infiSTAR enabled ***
		wai_avoid_road				= 0;								// avoid spawning missions this close to roads
		wai_avoid_water				= 50;								// avoid spawning missions this close to water

		
		wai_mission_timer			= [30,900];							// time between missions 5-15 minutes
		wai_mission_timeout			= [900,1800]; 						// time each missions takes to despawn if inactive 15-30 minutes
		wai_timeout_distance		= 1000;								// if a player is this close to a mission then it won't time-out
		
		wai_clean_mission			= true;								// clean all mission buildings after a certain period
		wai_clean_mission_time		= 1800;								// time after a mission is complete to clean mission buildings

		wai_mission_fuel			= [5,60];							// fuel inside mission spawned vehicles [min%,max%]
		wai_vehicle_damage			= [20,70];							// damages to spawn vehicles with [min%,max%]
		wai_keep_vehicles			= true;								// save vehicles to database and keep them after restart
		wai_lock_vehicles			= true;								// lock mission vehicles and add keys to random AI bodies (be careful with ai_clean_dead if this is true

		wai_crates_smoke			= true;								// pop smoke on crate when mission is finished during daytime
		wai_crates_flares			= true;								// pop flare on crate when mission is finished during nighttime
		
		wai_players_online			= 1; 								// number of players online before mission starts
		wai_server_fps				= 5; 								// missions only starts if server FPS is over wai_server_fps
		
		wai_kill_percent			= 30;								// percentage of AI players that must be killed at "crate" missions to be able to trigger completion

		wai_high_value				= true;								// enable the possibility of finding a high value item (defined below crate_items_high_value) inside a crate
		wai_high_value_chance		= 1;								// chance in percent you find above mentioned item

		wai_enable_minefield		= true;								// enable minefields to better defend missions
		wai_use_launchers			= true;								// add a rocket launcher to each spawned AI group
		wai_remove_launcher			= true;								// remove rocket launcher from AI on death

		// Missions
		wai_radio_announce			= true;								// Setting this to true will announce the missions to those that hold a radio only
		wai_bandit_limit			= 1;								// define how many bandit missions can run at once

		
		wai_bandit_missions			= [
										["patrol",10],
										["armed_vehicle",10],
										["black_hawk_crash",10],
										["captured_mv22",6],
										["broken_down_ural",12],
										["hero_base",6],
										["ikea_convoy",8],
										["medi_camp",14],
										["presidents_mansion",6],
										["sniper_extraction",8],
										["weapon_cache",10]
									];
		
		// Vehicle arrays
		armed_vehicle 				= ["I_MRAP_03_hmg_F"]; 
		armed_chopper 				= ["B_Heli_Attack_01_F"]; 
		civil_chopper 				= ["B_Heli_Light_01_EPOCH","B_Heli_Transport_01_EPOCH","B_Heli_Transport_01_camo_EPOCH","O_Heli_Light_02_unarmed_EPOCH","I_Heli_Transport_02_EPOCH","I_Heli_light_03_unarmed_EPOCH"];
		military_unarmed 			= ["B_SDV_01_EPOCH","B_MRAP_01_EPOCH","B_Truck_01_transport_EPOCH","O_Truck_02_covered_EPOCH","O_Truck_02_transport_EPOCH","O_Truck_03_covered_EPOCH","O_Truck_02_box_EPOCH"];
		cargo_trucks 				= ["C_Van_01_box_EPOCH","C_Van_01_transport_EPOCH"];
		refuel_trucks				= ["O_Truck_02_fuel_F","O_Truck_03_fuel_F","B_Truck_01_fuel_F"];
		civil_vehicles 				= ["C_Hatchback_01_EPOCH","C_Hatchback_02_EPOCH","C_Offroad_01_EPOCH","C_Quadbike_01_EPOCH","C_SUV_01_EPOCH"];

		// Dynamic box array
		crates_large				= ["Cargo_Container"]; 
		crates_medium				= ["C_supplyCrate_F"];  
		crates_small				= ["Pelican_EPOCH"];  
		crate_weapons_buildables    = [["MeleeSledge","swing"],["Hatchet","swing"],["ChainSawG","CSGAS"],["ChainSawP","CSGAS"],["ChainSawR","CSGAS"]];
		
		crate_tools					= ["Hatchet","MeleeSledge","Binocular","Rangefinder","ItemCompass","ItemGPS","NVG_EPOCH"];
		crate_tools_buildable		= ["ItemMixOil","Hatchet","MeleeSledge","ChainSaw","jerrycan_Epoch"];
		crate_tools_sniper			= ["ItemCompass","Binocular","Rangefinder","NVG_EPOCH","ItemGPS"];

		crate_items					= ["ItemSodaRbull","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaOrangeSherbet","ItemSodaMocha","ItemSodaBurst","FoodBioMeat","FoodSnooter","FoodWalkNSons","ItemMixOil","ItemScraps","ItemCorrugated","ItemCorrugatedLg","CSGAS","sledge_swing","hatchet_swing","EnergyPack","EnergyPackLg","WhiskeyNoodle","CircuitParts","VehicleRepair","VehicleRepairLg","Pelt_EPOCH","JackKit","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","Towelette","KitCinderWall","KitPlotPole","MortarBucket","KitFoundation","KitShelf","KitTiPi","KitFirePlace","KitWoodRamp","KitWoodStairs","KitWoodFloor","KitStudWall","EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9","FAK","ItemWatch","Binocular","Rangefinder","ItemMixOil","emptyjar_epoch","jerrycan_epoch"];
		crate_items_high_value		= ["MultiGun","Heal_EPOCH","Repair_EPOCH","ItemLockbox","Hatchet","Hatchet_swing"];
		crate_items_food			= ["WhiskeyNoodle","honey_epoch","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","ItemSodaRbull","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaOrangeSherbet","ItemSodaMocha","ItemSodaBurst","FoodBioMeat","FoodSnooter","FoodWalkNSons"];
		crate_items_buildables		= ["ItemMixOil",["ItemScraps",10],["ItemCorrugated",6],["ItemCorrugatedLg",6],"CSGAS","MeleeSledge","sledge_swing",'hatchet',"hatchet_swing",["EnergyPack",3],"EnergyPackLg",["CircuitParts",3],"Pelt_EPOCH","JackKit","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","KitCinderWall","KitPlotPole","MortarBucket","KitFoundation","KitShelf","KitTiPi","KitFirePlace","KitWoodRamp","KitWoodStairs","KitWoodFloor","KitStudWall"];
		crate_items_vehicle_repair	= ["VehicleRepair","VehicleRepairLg"];
		crate_items_medical			= ["Defib_EPOCH","Heal_EPOCH","FAK"];
		crate_items_sniper			= ["Rangefinder","U_O_GhillieSuit","NVG_Epoch",["FAK",2]];
		crate_items_president		= ["ItemDocument","ItemGoldBar10oz"];

		crate_backpacks_all			= ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg"];
		crate_backpacks_large		= ["B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo"];

		crate_random				= [crate_items,crate_items_food,crate_items_buildables,crate_items_vehicle_repair,crate_items_medical];

	/* END WAI MISSIONS CONFIG */

	/* STATIC MISSIONS CONFIG */

		static_missions				= true;		// use static mission file
		custom_per_world			= false;		// use a custom mission file per world

	WAIconfigloaded = true;

};