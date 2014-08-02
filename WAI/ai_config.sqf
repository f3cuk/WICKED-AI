ai_mission_system 			= true;			// use built in mission system
ai_clear_body 				= false;		// instantly clear bodies
ai_clean_dead 				= true;			// clear bodies after certain amount of time
cleanup_time 				= 7200;			// time to clear bodies in seconds

ai_patrol_radius 			= 300;			// radius of ai patrols in meters
ai_patrol_radius_wp 		= 10;			// number of waypoints of patrols

ai_combatmode 				= "RED";		// combatmode of AI
ai_behaviour 				= "SAFE";		// behaviour of AI

ai_ahare_info 				= true;			// AI share info on player position
ai_share_distance 			= 300;			// Distance AI share your position

ai_humanity_gain 			= true;			// Gain humanity for killing AI
ai_add_humanity 			= 50;			// Amount of huminity gained for killing an AI
ai_banditkills_gain 		= true;			// Add kill to bandit kill score

ai_custom_skills 			= true;			// Allows you to set a custom skill array for units. (true: will use these arrays. false: will use number in spawn array)
ai_custom_array1 			= [["aimingAccuracy",1.00], ["aimingShake",0.80], ["aimingSpeed",0.80], ["endurance",1.00], ["spotDistance",0.80], ["spotTime",0.80], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00], ["general",1.00]]; 	// Epic
ai_custom_array2 			= [["aimingAccuracy",0.80], ["aimingShake",0.70], ["aimingSpeed",0.70], ["endurance",1.00], ["spotDistance",0.70], ["spotTime",0.70], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00], ["general",1.00]]; 	// Hard
ai_custom_array3 			= [["aimingAccuracy",0.60], ["aimingShake",0.60], ["aimingSpeed",0.60], ["endurance",1.00], ["spotDistance",0.60], ["spotTime",0.60], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00], ["general",1.00]];	// Medium
ai_custom_array4 			= [["aimingAccuracy",0.40], ["aimingShake",0.50], ["aimingSpeed",0.50], ["endurance",1.00], ["spotDistance",0.50], ["spotTime",0.50], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00], ["general",1.00]];	// Easy
ai_skill_random 			= [ai_custom_array1,ai_custom_array2,ai_custom_array3,ai_custom_array4];

ai_static_useweapon 		= true;			// Allows AI on static guns to have a loadout 	
ai_static_skills 			= true;			// Allows you to set custom array for AI on static weapons. (true: On false: Off) 
ai_static_array 			= [["aimingAccuracy",0.20], ["aimingShake",0.70], ["aimingSpeed",0.75], ["endurance",1.00], ["spotDistance",0.70], ["spotTime",0.50], ["courage",1.00], ["reloadSpeed",1.00], ["commanding",1.00],["general",1.00]];

ai_gear0 					= [["ItemBandage","ItemBandage","ItemPainkiller"],["ItemKnife","ItemFlashlight"]];
ai_gear1 					= [["ItemBandage","ItemBandage","ItemPainkiller"],["ItemKnife","ItemFlashlight"]];
ai_gear_random 				= [ai_gear0,ai_gear1];	// Allows the possibility of random gear

ai_wep0 					= [["M16A4_ACG","30Rnd_556x45_Stanag"], ["Sa58V_RCO_EP1","30Rnd_762x39_AK47"], ["SCAR_L_STD_Mk4CQT","30Rnd_556x45_Stanag"], ["M8_sharpshooter","30Rnd_556x45_Stanag"], ["M4A1_HWS_GL_camo","30Rnd_556x45_Stanag"], ["SCAR_L_STD_HOLO","30Rnd_556x45_Stanag"], ["M4A3_CCO_EP1","30Rnd_556x45_Stanag"], ["M4A3_CCO_EP1","30Rnd_556x45_Stanag"], ["M4A1_AIM_SD_camo","30Rnd_556x45_StanagSD"], ["M16A4","30Rnd_556x45_Stanag"], ["m8_carbine","30Rnd_556x45_Stanag"], ["BAF_L85A2_RIS_Holo","30Rnd_556x45_Stanag"], ["Sa58V_CCO_EP1","30Rnd_762x39_AK47"]];	// Assault
ai_wep1 					= [["RPK_74","75Rnd_545x39_RPK"], ["MK_48_DZ","100Rnd_762x51_M240"], ["M249_EP1_DZ","200Rnd_556x45_M249"], ["Pecheneg_DZ","100Rnd_762x54_PK"], ["M240_DZ","100Rnd_762x51_M240"]];	// Light machine guns
ai_wep2 					= [["M14_EP1","20Rnd_762x51_DMR"],["SCAR_H_LNG_Sniper_SD","20rnd_762x51_B_SCAR"], ["M110_NVG_EP1","20rnd_762x51_B_SCAR"], ["SVD_CAMO","10Rnd_762x54_SVD"], ["VSS_Vintorez","20Rnd_9x39_SP5_VSS"], ["DMR","20Rnd_762x51_DMR"], ["M40A3","5Rnd_762x51_M24"]];	// Sniper rifles
ai_wep_random 				= [ai_wep0,ai_wep0,ai_wep0,ai_wep1,ai_wep2];	// random weapon 60% chance assault rifle, 20% light machine gun, 20% sniper rifle

ai_packs 					= ["DZ_Czech_Vest_Puch", "DZ_ALICE_Pack_EP1", "DZ_TK_Assault_Pack_EP1", "DZ_British_ACU", "DZ_GunBag_EP1", "DZ_CivilBackpack_EP1", "DZ_Backpack_EP1", "DZ_LargeGunBag_EP1"];
ai_skin 					= ["Bandit1_DZ", "BanditW1_DZ", "BanditW2_DZ", "Camo1_DZ", "CZ_Soldier_Sniper_EP1_DZ", "FR_OHara_DZ", "FR_Rodriguez_DZ", "Functionary1_EP1_DZ", "Graves_Light_DZ", "Bandit2_DZ", "SurvivorWcombat_DZ", "GUE_Commander_DZ", "GUE_Soldier_2_DZ", "GUE_Soldier_Crew_DZ", "GUE_Soldier_MG_DZ", "GUE_Soldier_Sniper_DZ", "Haris_Press_EP1_DZ", "Ins_Soldier_GL_DZ", "Pilot_EP1_DZ", "Priest_DZ", "Rocker1_DZ", "Rocker2_DZ", "Rocker3_DZ", "Rocker4_DZ", "RU_Policeman_DZ", "Sniper1_DZ", "Soldier1_DZ", "Soldier_Sniper_PMC_DZ", "Soldier_TL_PMC_DZ", "Survivor2_DZ", "SurvivorW2_DZ", "TK_INS_Soldier_EP1_DZ", "TK_INS_Warlord_EP1_DZ"];

WAIconfigloaded 			= true;