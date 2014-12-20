if(isServer) then {

	/* GENERAL CONFIG */
	
		debug_mode				= true;		// enable debug
		use_blacklist				= true;			// use blacklist
		blacklist					= [
			[[5533.00,8445.00],[6911.00,7063.00]],	// Stary
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

		ai_bandit_combatmode		= "YELLOW";		// combatmode of bandit AI
		ai_bandit_behaviour			= "COMBAT";		// behaviour of bandit AI

		ai_hero_combatmode			= "YELLOW";		// combatmode of hero AI
		ai_hero_behaviour			= "COMBAT";		// behaviour of hero AI

		ai_share_info				= true;			// AI share info on player position
		ai_share_distance			= 200;			// Distance from killed AI for AI to share your rough position
		
		//THIS SECTION BELOW WILL LIKELY NEED REMOVED/EDITED FOR A3 EPOCH.  POSSIBLY GIVE KRYPTO FOR EACH KILL??***
		
		ai_kills_gain				= true;			// add kill to bandit/human kill score
		ai_humanity_gain			= true;			// gain humanity for killing AI
		ai_add_humanity				= 50;			// amount of humanity gained for killing a bandit AI  
		ai_remove_humanity			= 50;			// amount of humanity lost for killing a hero AI 
		ai_special_humanity			= 150;			// amount of humanity gain or loss for killing a special AI dependant on player alignment  
		
		//THIS SECTION ABOVE WILL LIKELY NEED REMOVED/EDITED FOR A3 EPOCH.  POSSIBLY GIVE KRYPTO FOR EACH KILL??***
		
		ai_skill_extreme	 		= [["aimingAccuracy",0.30], ["aimingShake",0.80], ["aimingSpeed",0.80], ["endurance",1.00], ["spotDistance",0.80], ["spotTime",0.80], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00], ["general",1.00]]; 	// Extreme
		ai_skill_hard 				= [["aimingAccuracy",0.25], ["aimingShake",0.70], ["aimingSpeed",0.70], ["endurance",1.00], ["spotDistance",0.70], ["spotTime",0.70], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00], ["general",1.00]]; 	// Hard
		ai_skill_medium 			= [["aimingAccuracy",0.20], ["aimingShake",0.60], ["aimingSpeed",0.60], ["endurance",1.00], ["spotDistance",0.60], ["spotTime",0.60], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00], ["general",1.00]];	// Medium
		ai_skill_easy				= [["aimingAccuracy",0.15], ["aimingShake",0.50], ["aimingSpeed",0.50], ["endurance",1.00], ["spotDistance",0.50], ["spotTime",0.50], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00], ["general",1.00]];	// Easy
		ai_skill_random				= [ai_skill_extreme,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_easy];

		ai_static_useweapon			= true;	// Allows AI on static guns to have a loadout 	
		ai_static_weapons			= ["O_HMG_01_support_high_F","O_static_AT_F","O_static_AA_F"];	// static guns **MAY BE BANNED IN EPOCH ANTIHACK***

		ai_static_skills			= false;	// Allows you to set custom array for AI on static weapons. (true: On false: Off) 
		ai_static_array				= [["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["endurance",1.00],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];

		ai_gear0 					= [["FAK"],["ItemWatch","NVG_EPOCH","Rangefinder","ItemCompass","Binocular","ItemGPS"]];
		ai_gear1					= [["FAK"],["ItemGPS","Binocular"]];
		ai_gear_random				= [ai_gear0,ai_gear1,ai_gear1];	// Allows the possibility of random gear

		ai_wep_assault				= [["srifle_EBR_F","20Rnd_762x51_Mag"],["arifle_Katiba_F","30Rnd_65x39_caseless_green"],["arifle_MX_F","30Rnd_65x39_caseless_mag"],["arifle_TRG20_F","30Rnd_556x45_Stanag"],["arifle_MXC_F","30Rnd_65x39_caseless_mag"],["m16_EPOCH","30Rnd_556x45_Stanag"],["m16RED_EPOCH","30Rnd_556x45_Stanag"],["m4a3_EPOCH","30Rnd_556x45_Stanag"],["AKM_EPOCH","30Rnd_762x39_Mag"]];	// Assault
		ai_wep_machine				= [["LMG_Mk200_F","200Rnd_65x39_cased_Box"],["LMG_Zafir_F","150Rnd_762x51_Box"],["m249Tan_EPOCH","200Rnd_556x45_M249"],["m249_EPOCH","200Rnd_556x45_M249"]];	// Light machine guns
		ai_wep_sniper				= [["m107Tan_EPOCH","5Rnd_127x108_Mag"],["srifle_LRR_F","7Rnd_408_Mag"],["srifle_DMR_01_F","10Rnd_762x51_Mag"],["M14_EPOCH","20Rnd_762x51_Mag"],["M14Grn_EPOCH","20Rnd_762x51_Mag"]];	// Sniper rifles
		ai_wep_random				= [ai_wep_assault,ai_wep_assault,ai_wep_assault,ai_wep_sniper,ai_wep_machine];	// random weapon 60% chance assault rifle,20% light machine gun,20% sniper rifle
		ai_wep_launchers_AT			= ["launch_NLAW_F","launch_RPG32_F"];
		ai_wep_launchers_AA			= ["launch_O_Titan_F"];
		
		ai_packs					= ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo"];
		ai_hero_skin				= ["O_sniper_F","O_recon_F","O_G_Soldier_A_F","O_G_officer_F","O_G_Soldier_SL_F"];
		ai_bandit_skin				= ["O_sniper_F","O_recon_medic_F","O_officer_F","O_G_Soldier_A_F","O_G_Soldier_LAT_F"];
		ai_special_skin				= ["O_support_Mort_F"];
		ai_all_skin					= [ai_hero_skin,ai_bandit_skin,ai_special_skin];

		ai_add_skin					= true;			// adds unit skin to inventory on death
		
	/* END AI CONFIG */

	/* WAI MISSIONS CONFIG */
		wai_mission_system			= true;	// use built in mission system

		wai_mission_markers			= ["DZMSMajMarker","DZMSMinMarker","DZMSBMajMarker","DZMSBMinMarker"];

		wai_avoid_missions			= true;								// avoid spawning near other missions, these are defined in wai_mission_markers
		wai_avoid_traders			= true;								// avoid spawning missions near traders
		wai_mission_spread			= 3000;								// make missions spawn this far apart from one another and other markers
		wai_near_town				= 500;								// make missions check for towns around this radius
		wai_near_road				= 0;								// make missions check for roads around this radius
		wai_near_water				= 50;								// nearest water allowed near missions
		
		wai_mission_timer			= [300,900];						// time between missions 5-15 minutes
		wai_mission_timeout			= [900,1800]; 						// time each missions takes to despawn if inactive 15-30 minutes
		wai_timeout_distance		= 1000;								// if a player is this close to a mission then it won't time-out
		
		wai_clean_mission			= true;								// clean all mission buildings after a certain period
		wai_clean_mission_time		= 1800;								// time after a mission is complete to clean mission buildings

		wai_mission_fuel			= [10,80];							// fuel inside mission spawned vehicles [min%,max%]
		wai_vehicle_damage			= [20,80];							// damages to spawn vehicles with [min%,max%]
		wai_keep_vehicles			= false;							// save vehicles to database and keep them after restart

		wai_crates_smoke			= true;								// pop smoke on crate when mission is finished during daytime ***WILL NEED MINE CLASSNAME CHANGED FOR A3 EPOCH***
		wai_crates_flares			= true;								// pop flare on crate when mission is finished during nighttime ***WILL NEED MINE CLASSNAME CHANGED FOR A3 EPOCH***
		
		wai_players_online			= 1; 								// number of players online before mission starts
		wai_server_fps				= 5; 								// missions only starts if server FPS is over wai_server_fps
		
		wai_kill_percent			= 70;								// percentage of AI players that must be killed at "crate" missions to be able to trigger completion

		wai_high_value				= true;								// enable the possibility of finding a high value item (defined below crate_items_high_value) inside a crate
		wai_high_value_chance		= 100;								// chance in percent you find above mentioned item

		wai_enable_minefield		= true;								// enable minefields to better defend missions ***WILL NEED MINE CLASSNAME CHANGED FOR A3 EPOCH***
		wai_use_launchers			= true;							// add a rocket launcher to each spawned AI group
		wai_remove_launcher			= true;							// remove rocket launcher from AI on death

		// Missions
		wai_hero_missions			= [ 								// ["mission filename",% chance of picking this mission],Make sure the chances add up to 100,or it will not be accurate percentages
										["black_hawk_crash",12],
										["armed_vehicle",13],
										["bandit_base",8],
										["captured_mv22",8],
										["ikea_convoy",8],
										["destroyed_ural",18],
										["disabled_milchopper",10],
										["mayors_mansion",10],
										["weapon_cache",13]
									];
		wai_bandit_missions			= [
										["armed_vehicle",12],
										["black_hawk_crash",14],
										["captured_mv22",6],
										["broken_down_ural",14],
										["hero_base",6],
										["ikea_convoy",8],
										["medi_camp",16],
										["presidents_mansion",6],
										["sniper_extraction",8],
										["weapon_cache",10]
									];
		/*
		wai_special_missions		= [
										["bunny_ranch",100]
									];
		*/
		
		// Vehicle arrays
		armed_vehicle 				= ["I_MRAP_03_hmg_F"]; //MAY BE BANNED VEHICLE CLASS IN EPOCH ANTIHACK
		armed_chopper 				= ["B_Heli_Attack_01_F"]; //MAY BE BANNED VEHICLE CLASS IN EPOCH ANTIHACK
		civil_chopper 				= ["B_Heli_Light_01_EPOCH","B_Heli_Transport_01_EPOCH","B_Heli_Transport_01_camo_EPOCH","O_Heli_Light_02_unarmed_EPOCH","I_Heli_Transport_02_EPOCH","I_Heli_light_03_unarmed_EPOCH"];
		military_unarmed 			= ["B_SDV_01_EPOCH","B_MRAP_01_EPOCH","B_Truck_01_transport_EPOCH","O_Truck_02_covered_EPOCH","O_Truck_02_transport_EPOCH","O_Truck_03_covered_EPOCH","O_Truck_02_box_EPOCH"];
		cargo_trucks 				= ["C_Van_01_box_EPOCH","C_Van_01_transport_EPOCH"];
		refuel_trucks				= ["O_Truck_02_fuel_F","O_Truck_03_fuel_F","B_Truck_01_fuel_F"]; //MAY BE BANNED VEHICLE CLASSES IN EPOCH ANTIHACK
		civil_vehicles 				= ["C_Hatchback_01_EPOCH","C_Hatchback_02_EPOCH","C_Offroad_01_EPOCH","C_Quadbike_01_EPOCH","C_SUV_01_EPOCH"];

		// Dynamic box array
		crates_large				= ["Cargo_Container"];  //MAY NOT HOLD ALL NEEDED ITEMS
		crates_medium				= ["C_supplyCrate_F"];  //MAY NOT HOLD ALL NEEDED ITEMS
		crates_small				= ["Pelican_EPOCH"];  //MAY NOT HOLD ALL NEEDED ITEMS

		crate_weapons_buildables	= [["ChainSaw","CSGAS"],["ChainSawB","CSGAS"],["ChainSawG","CSGAS"],["ChainSawP","CSGAS"],["ChainSawR","CSGAS"]];
		
		crate_tools					= ["Hatchet","MeleeSledge","Binocular","Rangefinder","ItemCompass","ItemGPS","NVG_EPOCH"];
		crate_tools_buildable		= ["ItemMixOil","Hatchet","MeleeSledge","ChainSaw","jerrycan_Epoch"];
		crate_tools_sniper			= ["ItemCompass","Binocular","Rangefinder","NVG_EPOCH","ItemGPS"];

		crate_items					= ["ItemSodaRbull","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaOrangeSherbet","ItemSodaMocha","ItemSodaBurst","FoodBioMeat","FoodSnooter","FoodWalkNSons","ItemMixOil","ItemScraps","ItemCorrugated","ItemCorrugatedLg","CSGAS","sledge_swing","hatchet_swing","EnergyPack","EnergyPackLg","WhiskeyNoodle","CircuitParts","VehicleRepair","VehicleRepairLg","Pelt_EPOCH","JackKit","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","Towelette","KitCinderWall","KitPlotPole","MortarBucket","KitFoundation","KitShelf","KitTiPi","KitFirePlace","KitWoodRamp","KitWoodStairs","KitWoodFloor","KitStudWall","EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7","EpochRadio8","EpochRadio9","FAK","ItemWatch","Binocular","Rangefinder","ItemMixOil","emptyjar_epoch","jerrycan_epoch"];
		crate_items_high_value		= ["MultiGun","Heal_EPOCH","Repair_EPOCH","ItemLockbox","Hatchet","Hatchet_swing"];
		crate_items_food			= ["WhiskeyNoodle","honey_epoch","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","ItemSodaRbull","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaOrangeSherbet","ItemSodaMocha","ItemSodaBurst","FoodBioMeat","FoodSnooter","FoodWalkNSons"];
		crate_items_buildables		= ["ItemMixOil",["ItemScraps",10],["ItemCorrugated",6],["ItemCorrugatedLg",6],"CSGAS","MeleeSledge","sledge_swing",'hatchet',"hatchet_swing",["EnergyPack",3],"EnergyPackLg",["CircuitParts",3],"Pelt_EPOCH","JackKit","PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel","KitCinderWall","KitPlotPole","MortarBucket","KitFoundation","KitShelf","KitTiPi","KitFirePlace","KitWoodRamp","KitWoodStairs","KitWoodFloor","KitStudWall"];
		crate_items_vehicle_repair	= ["VehicleRepair","VehicleRepairLg"];
		crate_items_medical			= ["Defib_EPOCH","Heal_EPOCH","FAK"];
		crate_items_chainbullets	= [];		//NEED TO THINK OF SOMETHING ELSE TO GO HERE OR PULL IT OUT
		crate_items_sniper			= ["Rangefinder","U_O_GhillieSuit","NVG_Epoch",["FAK",2]];
		crate_items_president		= ["ItemDocument","ItemGoldBar10oz"];

		crate_backpacks_all			= ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg"];
		crate_backpacks_large		= ["B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo"];

		crate_random				= [crate_items,crate_items_food,crate_items_buildables,crate_items_vehicle_repair,crate_items_medical];

	/* END WAI MISSIONS CONFIG */

	/* STATIC MISSIONS CONFIG */

		static_missions				= true;		// use static mission file
		custom_per_world			= false;		// use a custom mission file per world

	/* END STATIC MISSIONS CONFIG */

	configloaded = true;

};