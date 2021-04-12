/* GENERAL CONFIG */

wai_debug_mode		 = false; // enable debug
wai_user_spawnpoints = false; // setting this to true will disable the dynamic mission spawning system and enable server owners to define their own mission spawn points in WAI\configs\spawnpoints.sqf.
wai_use_blacklist	 = true; // You can edit the blacklist per map in file WAI\configs\blacklist.sqf.

/* END GENERAL CONFIG */
	
/* AI CONFIG */
ai_show_count		 = false; //this will show the ai count in the mission markers.
ai_hasMoney			 = false; //If you have ZSC installed then setting this to true will place random amounts of coins in 50 coin increments in ai wallets.
ai_moneyMultiplier	 = 200; //This value is multiplied by 50 to set the max amount of ZSC coins in AI wallets. ex. 200x50=10000 max coins.
ai_clear_body		 = false; // instantly clear bodies
ai_cleanup_time		 = 30; // time to clear bodies in minutes. Set to -1 to disable AI cleanup.
ai_clean_roadkill	 = false; // clean bodies that are roadkills
ai_rk_damageweapon	 = 0; // percentage of chance a roadkill will destroy weapon AI is carrying
ai_bandit_combatmode = "RED"; // combat mode of bandit AI
ai_bandit_behaviour	 = "COMBAT"; // behavior of bandit AI
ai_hero_combatmode	 = "RED"; // combat mode of hero AI
ai_hero_behaviour	 = "COMBAT"; // behavior of hero AI
ai_share_info		 = true; // AI share info on player position
ai_share_distance	 = 300; // distance from killed AI for AI to share your rough position
ai_kills_gain		 = true; // add kill to bandit/human kill score
ai_humanity_gain	 = true; // gain humanity for killing AI
ai_add_humanity		 = 50; // amount of humanity gained for killing a bandit AI
ai_remove_humanity	 = 50; // amount of humanity lost for killing a hero AI
ai_reward_veh_gunner = false; // Allows the gunner or "effectiveCommander" of a vehicle to get humanity and kill rewards
ai_killfeed			 = false; // Sends personal messages when the player kills an ai - may not be good for network performance

ai_skill_extreme	 = [["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["endurance",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Extreme
ai_skill_hard		 = [["aimingAccuracy",0.80],["aimingShake",0.80],["aimingSpeed",0.80],["endurance",1.00],["spotDistance",0.80],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]]; 	// Hard
ai_skill_medium		 = [["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["endurance",1.00],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Medium
ai_skill_easy		 = [["aimingAccuracy",0.40],["aimingShake",0.50],["aimingSpeed",0.50],["endurance",1.00],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];	// Easy
ai_skill_random		 = [ai_skill_extreme,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_hard,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_medium,ai_skill_easy];

ai_static_useweapon	 = true; // Allows AI on static guns to have a loadout 	
ai_static_weapons	 = ["KORD_high_TK_EP1","DSHKM_Ins","M2StaticMG"]; // static guns
ai_static_skills	 = false; // Allows you to set custom array for AI on static weapons. (true: On false: Off) 
ai_static_array		 = [["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["endurance",1.00],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];

ai_gear0			 = [["ItemBandage","ItemBandage","ItemAntibiotic"],["ItemRadio","ItemMachete","ItemCrowbar"]];
ai_gear1			 = [["ItemBandage","ItemSodaPepsi","ItemMorphine"],["Binocular_Vector"]];
ai_gear2			 = [["ItemDocument","FoodCanFrankBeans","ItemHeatPack"],["ItemToolbox"]];
ai_gear3			 = [["ItemWaterbottle","ItemBloodbag"],["ItemCompass","ItemCrowbar"]];
ai_gear4			 = [["ItemBandage","ItemEpinephrine","ItemPainkiller"],["ItemGPS","ItemKeyKit"]];
ai_gear_random		 = [ai_gear0,ai_gear1,ai_gear2,ai_gear3,ai_gear4];

// Weapons
ai_wep_ak = ["AK74_Kobra_DZ","AK74_Kobra_SD_DZ","AK74_GL_Kobra_DZ","AK74_GL_Kobra_SD_DZ","AK74_DZ","AK74_SD_DZ","AK74_GL_DZ","AK74_GL_SD_DZ","AK74_PSO1_DZ","AK74_PSO1_SD_DZ","AK74_GL_PSO1_DZ","AK74_GL_PSO1_SD_DZ","AK107_Kobra_DZ","AK107_DZ","AK107_GL_DZ","AK107_PSO_DZ","AK107_GL_PSO_DZ","AK107_GL_Kobra_DZ","AN94_DZ","AN94_GL_DZ","AKS74U_Kobra_DZ","AKS74U_Kobra_SD_DZ","AKS74U_DZ","AKS74U_SD_DZ","AKM_DZ","AKM_Kobra_DZ","AKM_PSO1_DZ","AKS_Gold_DZ","AKS_Silver_DZ","AKS_DZ"];
ai_wep_rk95 = ["RK95_DZ","RK95_SD_DZ","RK95_CCO_SD_DZ","RK95_ACOG_SD_DZ","RK95_CCO_DZ","RK95_ACOG_DZ"];
ai_wep_groza = ["Groza9_DZ","Groza9_Sniper_DZ","Groza9_GL_DZ","Groza9_GL_Sniper_DZ","Groza9_SD_DZ","Groza9_Sniper_SD_DZ","Groza1_DZ","Groza1_Sniper_DZ","Groza1_SD_DZ","Groza1_Sniper_SD_DZ"];
ai_wep_scar = ["SCAR_H_AK_DZ","SCAR_H_AK_CCO_DZ","SCAR_H_B_AK_CCO_DZ","SCAR_H_AK_HOLO_DZ","SCAR_H_AK_ACOG_DZ"];
ai_wep_sniper = ["WA2000_DZ","Barrett_MRAD_Iron_DZ","Barrett_MRAD_CCO_DZ","Barrett_MRAD_Sniper_DZ","MSR_DZ","MSR_SD_DZ","MSR_NV_DZ","MSR_NV_SD_DZ","XM2010_DZ","XM2010_SD_DZ","XM2010_NV_DZ","XM2010_NV_SD_DZ","XM2010_TWS_DZ","XM2010_TWS_SD_DZ","Anzio_20_DZ","BAF_AS50_scoped_DZ","m107_DZ","M4SPR_DZE","M200_CheyTac_DZ","M200_CheyTac_SD_DZ","L115A3_DZ","L115A3_2_DZ","KSVK_DZE","VSS_vintorez_DZE","M24_DZ","M24_Gh_DZ","M24_DES_DZ","M40A3_Gh_DZ","M40A3_DZ","CZ750_DZ","M110_NV_DZ","MK17_Sniper_DZ","MK17_Sniper_SD_DZ","MK14_Sniper_DZ","MK14_Sniper_SD_DZ","M21_DZ","M21A5_DZ","M21A5_SD_DZ","HK417_Sniper_DZ","HK417_Sniper_SD_DZ","M1A_SC16_BL_Sniper_DZ","M1A_SC2_BL_Sniper_DZ","M1A_SC16_TAN_Sniper_DZ","DMR_DZ","DMR_SKN","DMR_Gh_DZ","DMR_DZE","DMR_Gh_DZE","RSASS_DZ","RSASS_TWS_DZ","RSASS_SD_DZ","RSASS_TWS_SD_DZ","FNFAL_DZ","FNFAL_CCO_DZ","FNFAL_Holo_DZ","FNFAL_ANPVS4_DZ","FN_FAL_ANPVS4_DZE","G3_DZ"];
ai_wep_g36 = ["G36K_Camo_DZ","G36K_Camo_SD_DZ","G36A_Camo_DZ","G36A_Camo_SD_DZ","G36C_DZ","G36C_SD_DZ","G36C_CCO_DZ","G36C_CCO_SD_DZ","G36C_Holo_DZ","G36C_Holo_SD_DZ","G36C_ACOG_DZ","G36C_ACOG_SD_DZ","G36C_Camo_DZ","G36C_Camo_Holo_SD_DZ"];
ai_wep_m4 = ["M4A1_DZ","M4A1_FL_DZ","M4A1_MFL_DZ","M4A1_SD_DZ","M4A1_SD_FL_DZ","M4A1_SD_MFL_DZ","M4A1_GL_DZ","M4A1_GL_FL_DZ","M4A1_GL_MFL_DZ","M4A1_GL_SD_DZ","M4A1_GL_SD_FL_DZ","M4A1_GL_SD_MFL_DZ","M4A1_CCO_DZ","M4A1_CCO_FL_DZ","M4A1_CCO_MFL_DZ","M4A1_CCO_SD_DZ","M4A1_CCO_SD_FL_DZ","M4A1_CCO_SD_MFL_DZ","M4A1_GL_CCO_DZ","M4A1_GL_CCO_FL_DZ","M4A1_GL_CCO_MFL_DZ","M4A1_GL_CCO_SD_DZ","M4A1_GL_CCO_SD_FL_DZ","M4A1_GL_CCO_SD_MFL_DZ","M4A1_Holo_DZ","M4A1_Holo_FL_DZ","M4A1_Holo_MFL_DZ","M4A1_Holo_SD_DZ","M4A1_Holo_SD_FL_DZ","M4A1_Holo_SD_MFL_DZ","M4A1_GL_Holo_DZ","M4A1_GL_Holo_FL_DZ","M4A1_GL_Holo_MFL_DZ","M4A1_GL_Holo_SD_DZ","M4A1_GL_Holo_SD_FL_DZ","M4A1_GL_Holo_SD_MFL_DZ","M4A1_ACOG_DZ","M4A1_ACOG_FL_DZ","M4A1_ACOG_MFL_DZ","M4A1_ACOG_SD_DZ","M4A1_ACOG_SD_FL_DZ","M4A1_ACOG_SD_MFL_DZ","M4A1_GL_ACOG_DZ","M4A1_GL_ACOG_FL_DZ","M4A1_GL_ACOG_MFL_DZ","M4A1_GL_ACOG_SD_DZ","M4A1_GL_ACOG_SD_FL_DZ","M4A1_GL_ACOG_SD_MFL_DZ","M4A1_Rusty_DZ","M4A1_Camo_CCO_DZ","M4A1_Camo_CCO_SD_DZ","M4A1_Camo_Holo_GL_DZ","M4A1_Camo_Holo_GL_SD_DZ","M4A3_DES_CCO_DZ","M4A3_ACOG_GL_DZ","M4A3_Camo_DZ","M4A3_Camo_ACOG_DZ"];
ai_wep_hk416 = ["HK416_DZ","HK416_SD_DZ","HK416_GL_DZ","HK416_GL_SD_DZ","HK416_CCO_DZ","HK416_CCO_SD_DZ","HK416_GL_CCO_DZ","HK416_GL_CCO_SD_DZ","HK416_Holo_DZ","HK416_Holo_SD_DZ","HK416_GL_Holo_DZ","HK416C_DZ","HK416C_GL_DZ","HK416C_CCO_DZ","HK416C_GL_CCO_DZ","HK416C_Holo_DZ","HK416C_GL_Holo_DZ","HK416C_ACOG_DZ","HK416C_GL_ACOG_DZ"];
ai_wep_steyrAug = ["SteyrAug_A3_Green_DZ","SteyrAug_A3_Black_DZ","SteyrAug_A3_Blue_DZ","SteyrAug_A3_ACOG_Green_DZ","SteyrAug_A3_ACOG_Black_DZ","SteyrAug_A3_ACOG_Blue_DZ","SteyrAug_A3_Holo_Green_DZ","SteyrAug_A3_Holo_Black_DZ","SteyrAug_A3_Holo_Blue_DZ","SteyrAug_A3_GL_Green_DZ","SteyrAug_A3_GL_Black_DZ","SteyrAug_A3_GL_Blue_DZ","SteyrAug_A3_ACOG_GL_Green_DZ","SteyrAug_A3_ACOG_GL_Black_DZ","SteyrAug_A3_ACOG_GL_Blue_DZ","SteyrAug_A3_Holo_GL_Green_DZ","SteyrAug_A3_Holo_GL_Black_DZ","SteyrAug_A3_Holo_GL_Blue_DZ"];
ai_wep_hk53 = ["HK53A3_DZ","HK53A3_CCO_DZ","HK53A3_Holo_DZ"];
ai_wep_magpulPDR = ["PDR_DZ","PDR_CCO_DZ","PDR_Holo_DZ"];
ai_wep_famas = ["Famas_DZ","Famas_CCO_DZ","Famas_Holo_DZ","Famas_SD_DZ","Famas_CCO_SD_DZ","Famas_Holo_SD_DZ"];
ai_wep_acr = ["ACR_WDL_DZ","ACR_WDL_SD_DZ","ACR_WDL_GL_DZ","ACR_WDL_GL_SD_DZ","ACR_WDL_CCO_DZ","ACR_WDL_CCO_SD_DZ","ACR_WDL_CCO_GL_DZ","ACR_WDL_CCO_GL_SD_DZ","ACR_WDL_Holo_DZ","ACR_WDL_Holo_SD_DZ","ACR_WDL_Holo_GL_DZ","ACR_WDL_Holo_GL_SD_DZ","ACR_WDL_ACOG_DZ","ACR_WDL_ACOG_SD_DZ","ACR_WDL_ACOG_GL_DZ","ACR_WDL_ACOG_GL_SD_DZ","ACR_WDL_TWS_DZ","ACR_WDL_TWS_GL_DZ","ACR_WDL_TWS_SD_DZ","ACR_WDL_TWS_GL_SD_DZ","ACR_WDL_NV_DZ","ACR_WDL_NV_SD_DZ","ACR_WDL_NV_GL_DZ","ACR_WDL_NV_GL_SD_DZ","ACR_BL_DZ","ACR_BL_SD_DZ","ACR_BL_GL_DZ","ACR_BL_GL_SD_DZ","ACR_BL_CCO_DZ","ACR_BL_CCO_SD_DZ","ACR_BL_CCO_GL_DZ","ACR_BL_CCO_GL_SD_DZ","ACR_BL_Holo_DZ","ACR_BL_Holo_SD_DZ","ACR_BL_Holo_GL_DZ","ACR_BL_Holo_GL_SD_DZ","ACR_BL_ACOG_DZ","ACR_BL_ACOG_SD_DZ","ACR_BL_ACOG_GL_DZ","ACR_BL_ACOG_GL_SD_DZ","ACR_BL_TWS_DZ","ACR_BL_TWS_GL_DZ","ACR_BL_TWS_SD_DZ","ACR_BL_TWS_GL_SD_DZ","ACR_BL_NV_DZ","ACR_BL_NV_SD_DZ","ACR_BL_NV_GL_DZ","ACR_BL_NV_GL_SD_DZ","ACR_DES_DZ","ACR_DES_SD_DZ","ACR_DES_GL_DZ","ACR_DES_GL_SD_DZ","ACR_DES_CCO_DZ","ACR_DES_CCO_SD_DZ","ACR_DES_CCO_GL_DZ","ACR_DES_CCO_GL_SD_DZ","ACR_DES_Holo_DZ","ACR_DES_Holo_SD_DZ","ACR_DES_Holo_GL_DZ","ACR_DES_Holo_GL_SD_DZ","ACR_DES_ACOG_DZ","ACR_DES_ACOG_SD_DZ","ACR_DES_ACOG_GL_DZ","ACR_DES_ACOG_GL_SD_DZ","ACR_DES_TWS_DZ","ACR_DES_TWS_GL_DZ","ACR_DES_TWS_SD_DZ","ACR_DES_TWS_GL_SD_DZ","ACR_DES_NV_DZ","ACR_DES_NV_SD_DZ","ACR_DES_NV_GL_DZ","ACR_DES_NV_GL_SD_DZ","ACR_SNOW_DZ","ACR_SNOW_SD_DZ","ACR_SNOW_GL_DZ","ACR_SNOW_GL_SD_DZ","ACR_SNOW_CCO_DZ","ACR_SNOW_CCO_SD_DZ","ACR_SNOW_CCO_GL_DZ","ACR_SNOW_CCO_GL_SD_DZ","ACR_SNOW_Holo_DZ","ACR_SNOW_Holo_SD_DZ","ACR_SNOW_Holo_GL_DZ","ACR_SNOW_Holo_GL_SD_DZ","ACR_SNOW_ACOG_DZ","ACR_SNOW_ACOG_SD_DZ","ACR_SNOW_ACOG_GL_DZ","ACR_SNOW_ACOG_GL_SD_DZ","ACR_SNOW_TWS_DZ","ACR_SNOW_TWS_GL_DZ","ACR_SNOW_TWS_SD_DZ","ACR_SNOW_TWS_GL_SD_DZ","ACR_SNOW_NV_DZ","ACR_SNOW_NV_SD_DZ","ACR_SNOW_NV_GL_DZ","ACR_SNOW_NV_GL_SD_DZ"];
ai_wep_kac = ["KAC_PDW_DZ","KAC_PDW_CCO_DZ","KAC_PDW_HOLO_DZ","KAC_PDW_ACOG_DZ"];
ai_wep_tavor = ["CTAR21_DZ","CTAR21_CCO_DZ","CTAR21_ACOG_DZ"];
ai_wep_masada = ["Masada_DZ","Masada_SD_DZ","Masada_CCO_DZ","Masada_CCO_SD_DZ","Masada_Holo_DZ","Masada_Holo_SD_DZ","Masada_ACOG_DZ","Masada_ACOG_SD_DZ","Masada_BL_DZ","Masada_BL_SD_DZ","Masada_BL_CCO_DZ","Masada_BL_CCO_SD_DZ","Masada_BL_Holo_DZ","Masada_BL_Holo_SD_DZ","Masada_BL_ACOG_DZ","Masada_BL_ACOG_SD_DZ"];
ai_wep_mk16 = ["MK16_DZ","MK16_CCO_DZ","MK16_Holo_DZ","MK16_ACOG_DZ","MK16_GL_DZ","MK16_GL_CCO_DZ","MK16_GL_Holo_DZ","MK16_GL_ACOG_DZ","MK16_CCO_SD_DZ","MK16_Holo_SD_DZ","MK16_ACOG_SD_DZ","MK16_GL_CCO_SD_DZ","MK16_GL_Holo_SD_DZ","MK16_GL_ACOG_SD_DZ","MK16_BL_CCO_DZ","MK16_BL_GL_ACOG_DZ","MK16_BL_Holo_SD_DZ","MK16_BL_GL_CCO_SD_DZ"];
ai_wep_xm8 = ["XM8_DZ","XM8_DES_DZ","XM8_GREY_DZ","XM8_GREY_2_DZ","XM8_GL_DZ","XM8_DES_GL_DZ","XM8_GREY_GL_DZ","XM8_Compact_DZ","XM8_DES_Compact_DZ","XM8_GREY_Compact_DZ","XM8_GREY_2_Compact_DZ","XM8_Sharpsh_DZ","XM8_DES_Sharpsh_DZ","XM8_GREY_Sharpsh_DZ","XM8_SAW_DZ","XM8_DES_SAW_DZ","XM8_GREY_SAW_DZ","XM8_SD_DZ"];
ai_wep_m14 = ["M14_DZ","M14_Gh_DZ","M14_CCO_DZ","M14_CCO_Gh_DZ","M14_Holo_DZ","M14_Holo_Gh_DZ","M1A_SC16_BL_DZ","M1A_SC16_BL_ACOG_DZ","M1A_SC16_BL_CCO_DZ","M1A_SC16_BL_HOLO_DZ","M1A_SC16_BL_PU_DZ","M1A_SC16_TAN_DZ","M1A_SC16_TAN_ACOG_DZ","M1A_SC16_TAN_CCO_DZ","M1A_SC16_TAN_HOLO_DZ","M1A_SC16_TAN_PU_DZ","M1A_SC2_BL_DZ","M1A_SC2_BL_ACOG_DZ","M1A_SC2_BL_CCO_DZ","M1A_SC2_BL_HOLO_DZ","M1A_SC2_BL_PU_DZ"];
ai_wep_hk417 = ["HK417_DZ","HK417_SD_DZ","HK417_CCO_DZ","HK417_CCO_SD_DZ","HK417_Holo_DZ","HK417_Holo_SD_DZ","HK417_ACOG_DZ","HK417_ACOG_SD_DZ","HK417C_DZ","HK417C_GL_DZ","HK417C_CCO_DZ","HK417C_GL_CCO_DZ","HK417C_Holo_DZ","HK417C_GL_Holo_DZ","HK417C_ACOG_DZ","HK417C_GL_ACOG_DZ"];
ai_wep_mk14 = ["MK14_DZ","MK14_CCO_DZ","MK14_Holo_DZ","MK14_ACOG_DZ","MK14_SD_DZ","MK14_CCO_SD_DZ","MK14_Holo_SD_DZ","MK14_ACOG_SD_DZ"];
ai_wep_mk17 = ["MK17_DZ","MK17_CCO_DZ","MK17_Holo_DZ","MK17_ACOG_DZ","MK17_GL_DZ","MK17_GL_CCO_DZ","MK17_GL_Holo_DZ","MK17_GL_ACOG_DZ","MK17_CCO_SD_DZ","MK17_Holo_SD_DZ","MK17_ACOG_SD_DZ","MK17_GL_CCO_SD_DZ","MK17_GL_Holo_SD_DZ","MK17_BL_Holo_DZ","MK17_BL_GL_ACOG_DZ","MK17_BL_CCO_SD_DZ","MK17_BL_GL_Holo_SD_DZ"];
ai_wep_cz805 = ["CZ805_A1_DZ","CZ805_A1_GL_DZ","CZ805_A2_DZ","CZ805_A2_SD_DZ","CZ805_B_GL_DZ"];
ai_wep_shotgun = ["MR43_DZ","Winchester1866_DZ","Remington870_DZ","Remington870_FL_DZ","Remington870_MFL_DZ","Saiga12K_DZ","USAS12_DZ","AA12_DZ","M1014_DZ","M1014_CCO_DZ","M1014_Holo_DZ"];
ai_wep_svd = ["SVD_PSO1_DZ","SVD_PSO1_Gh_DZ","SVD_DZ","SVD_Gh_DZ","SVD_PSO1_Gh_DES_DZ","SVD_NSPU_DZ","SVD_Gold_DZ","SVU_PSO1_DZ"];
ai_wep_mosin = ["Mosin_DZ","Mosin_FL_DZ","Mosin_MFL_DZ","Mosin_Belt_DZ","Mosin_Belt_FL_DZ","Mosin_Belt_MFL_DZ","Mosin_PU_DZ","Mosin_PU_FL_DZ","Mosin_PU_MFL_DZ","Mosin_PU_Belt_DZ","Mosin_PU_Belt_FL_DZ","Mosin_PU_Belt_MFL_DZ"];
ai_wep_m16 = ["M16A2_DZ","M16A2_GL_DZ","M16A2_Rusty_DZ","M16A4_DZ","M16A4_FL_DZ","M16A4_MFL_DZ","M16A4_GL_DZ","M16A4_GL_FL_DZ","M16A4_GL_MFL_DZ","M16A4_CCO_DZ","M16A4_CCO_FL_DZ","M16A4_CCO_MFL_DZ","M16A4_GL_CCO_DZ","M16A4_GL_CCO_FL_DZ","M16A4_GL_CCO_MFL_DZ","M16A4_Holo_DZ","M16A4_Holo_FL_DZ","M16A4_Holo_MFL_DZ","M16A4_GL_Holo_DZ","M16A4_GL_Holo_FL_DZ","M16A4_GL_Holo_MFL_DZ","M16A4_ACOG_DZ","M16A4_ACOG_FL_DZ","M16A4_ACOG_MFL_DZ","M16A4_GL_ACOG_DZ","M16A4_GL_ACOG_FL_DZ","M16A4_GL_ACOG_MFL_DZ"];
ai_wep_sa58 = ["SA58_DZ","SA58_RIS_DZ","SA58_RIS_FL_DZ","SA58_RIS_MFL_DZ","SA58_CCO_DZ","SA58_CCO_FL_DZ","SA58_CCO_MFL_DZ","SA58_Holo_DZ","SA58_Holo_FL_DZ","SA58_Holo_MFL_DZ","SA58_ACOG_DZ","SA58_ACOG_FL_DZ","SA58_ACOG_MFL_DZ","Sa58V_DZ","Sa58V_Camo_CCO_DZ","Sa58V_Camo_ACOG_DZ"];
ai_wep_l85 = ["L85A2_DZ","L85A2_FL_DZ","L85A2_MFL_DZ","L85A2_SD_DZ","L85A2_SD_FL_DZ","L85A2_SD_MFL_DZ","L85A2_CCO_DZ","L85A2_CCO_FL_DZ","L85A2_CCO_MFL_DZ","L85A2_CCO_SD_DZ","L85A2_CCO_SD_FL_DZ","L85A2_CCO_SD_MFL_DZ","L85A2_Holo_DZ","L85A2_Holo_FL_DZ","L85A2_Holo_MFL_DZ","L85A2_Holo_SD_DZ","L85A2_Holo_SD_FL_DZ","L85A2_Holo_SD_MFL_DZ","L85A2_ACOG_DZ","L85A2_ACOG_FL_DZ","L85A2_ACOG_MFL_DZ","L85A2_ACOG_SD_DZ","L85A2_ACOG_SD_FL_DZ","L85A2_ACOG_SD_MFL_DZ","BAF_L85A2_RIS_TWS_DZ"];
ai_wep_pistol = ["M9_DZ","M9_SD_DZ","M9_Camo_DZ","M9_Camo_SD_DZ","M93R_DZ","P99_Black_DZ","P99_Black_SD_DZ","P99_Green_DZ","P99_Green_SD_DZ","P99_Silver_DZ","P99_Silver_SD_DZ","BrowningHP_DZ","P226_DZ","P226_Silver_DZ","P38_DZ","PPK_DZ","MK22_DZ","MK22_2_DZ","MK22_SD_DZ","MK22_2_SD_DZ","G17_DZ","G17_FL_DZ","G17_MFL_DZ","G17_SD_DZ","G17_SD_FL_DZ","G17_SD_MFL_DZ","G18_DZ","M1911_DZ","M1911_2_DZ","Kimber_M1911_DZ","Kimber_M1911_SD_DZ","USP_DZ","USP_SD_DZ","Makarov_DZ","Makarov_SD_DZ","Tokarew_TT33_DZ","Ruger_MK2_DZ","APS_DZ","APS_SD_DZ","PDW_DZ","PDW_SD_DZ","TEC9_DZ","Mac10_DZ","Revolver_DZ","Revolver_Gold_DZ","Colt_Anaconda_DZ","Colt_Anaconda_Gold_DZ","Colt_Bull_DZ","Colt_Python_DZ","Colt_Revolver_DZ","CZ75P_DZ","CZ75D_DZ","CZ75SP_DZ","CZ75SP_SD_DZ","DesertEagle_DZ","DesertEagle_Gold_DZ","DesertEagle_Silver_DZ","DesertEagle_Modern_DZ","Sa61_DZ"];
ai_wep_smg = ["Bizon_DZ","Bizon_Kobra_DZ","Bizon_SD_DZ","Bizon_Kobra_SD_DZ","MP5_DZ","MP5_SD_DZ","Kriss_DZ","Kriss_CCO_DZ","Kriss_Holo_DZ","Kriss_SD_DZ","Kriss_CCO_SD_DZ","Kriss_Holo_SD_DZ","Scorpion_Evo3_DZ","Scorpion_Evo3_CCO_DZ","Scorpion_Evo3_CCO_SD_DZ","MP7_DZ","MP7_FL_DZ","MP7_MFL_DZ","MP7_Holo_DZ","MP7_Holo_FL_DZ","MP7_Holo_MFL_DZ","MP7_CCO_DZ","MP7_CCO_FL_DZ","MP7_CCO_MFL_DZ","MP7_ACOG_DZ","MP7_ACOG_FL_DZ","MP7_ACOG_MFL_DZ","MP7_SD_DZ","MP7_SD_FL_DZ","MP7_SD_MFL_DZ","MP7_Holo_SD_DZ","MP7_Holo_SD_FL_DZ","MP7_Holo_SD_MFL_DZ","MP7_CCO_SD_DZ","MP7_CCO_SD_FL_DZ","MP7_CCO_SD_MFL_DZ","MP7_ACOG_SD_DZ","MP7_ACOG_SD_FL_DZ","MP7_ACOG_SD_MFL_DZ","TMP_DZ","TMP_CCO_DZ","TMP_Holo_DZ","TMP_SD_DZ","TMP_CCO_SD_DZ","TMP_Holo_SD_DZ","UMP_DZ","UMP_CCO_DZ","UMP_Holo_DZ","UMP_SD_DZ","UMP_CCO_SD_DZ","UMP_Holo_SD_DZ","P90_DZ","P90_CCO_DZ","P90_Holo_DZ","P90_SD_DZ","P90_CCO_SD_DZ","P90_Holo_SD_DZ","Sten_MK_DZ","MAT49_DZ","M31_DZ","VAL_DZ","VAL_Kobra_DZ","VAL_PSO1_DZ"];
ai_wep_machine = ["RPK_DZ","RPK_Kobra_DZ","RPK_PSO1_DZ","MG36_DZ","MG36_Camo_DZ","M249_CCO_DZ","M249_DZ","M249_Holo_DZ","M249_EP1_DZ","M249_m145_EP1_DZE","L110A1_CCO_DZ","L110A1_Holo_DZ","L110A1_DZ","BAF_L110A1_Aim_DZE","M240_DZ","M240_CCO_DZ","M240_Holo_DZ","m240_scoped_EP1_DZE","M60A4_EP1_DZE","Mk43_DZ","MK43_Holo_DZ","MK43_ACOG_DZ","MK43_M145_DZ","Mk48_CCO_DZ","Mk48_DZ","Mk48_Holo_DZ","Mk48_DES_CCO_DZ","PKM_DZ","Pecheneg_DZ","UK59_DZ","RPK74_Kobra_DZ","RPK74_DZ","RPK74_PSO1_DZ","L86A2_LSW_DZ"];
ai_wep_tws = ["MSR_TWS_DZ","MSR_TWS_SD_DZ","AKS_74_GOSHAWK","BAF_AS50_TWS","BAF_L85A2_RIS_TWS_DZ","M249_TWS_EP1_Small","m107_TWS_EP1_Small","m8_tws","m8_tws_sd","SCAR_L_STD_EGLM_TWS","SCAR_H_STD_TWS_SD","M110_TWS_EP1"];

// Random Weapons	 // By default, most of the mission crates and ai spawn weapons out of the group below. You can remove any weapon array entries from the list if you don't wish to include them.
ai_wep_random		 = [ai_wep_ak,ai_wep_rk95,ai_wep_groza,ai_wep_scar,ai_wep_sniper,ai_wep_g36,ai_wep_m4,ai_wep_hk416,ai_wep_steyrAug,ai_wep_hk53,ai_wep_magpulPDR,ai_wep_famas,ai_wep_acr,ai_wep_kac,ai_wep_tavor,ai_wep_masada,ai_wep_mk16,ai_wep_xm8,ai_wep_m14,ai_wep_hk417,ai_wep_mk14,ai_wep_mk17,ai_wep_cz805,ai_wep_shotgun,ai_wep_svd,ai_wep_mosin,ai_wep_m16,ai_wep_sa58,ai_wep_l85,ai_wep_smg,ai_wep_machine];

ai_wep_launchers_AT	 = ["M136","RPG18","JAVELIN"];
ai_wep_launchers_AA	 = ["Strela","Igla","STINGER"];

ai_packs			 = ["Patrol_Pack_DZE1","GymBag_Camo_DZE1","GymBag_Green_DZE1","Czech_Vest_Pouch_DZE1","Assault_Pack_DZE1","TerminalPack_DZE1","TinyPack_DZE1","ALICE_Pack_DZE1","TK_Assault_Pack_DZE1","School_Bag_DZE1","CompactPack_DZE1","British_ACU_DZE1","GunBag_DZE1","PartyPack_DZE1","NightPack_DZE1","SurvivorPack_DZE1","AirwavesPack_DZE1","CzechBackpack_DZE1","CzechBackpack_Camping_DZE1","CzechBackpack_OD_DZE1","CzechBackpack_DES_DZE1","CzechBackpack_3DES_DZE1","CzechBackpack_WDL_DZE1","CzechBackpack_MAR_DZE1","CzechBackpack_DMAR_DZE1","CzechBackpack_UCP_DZE1","CzechBackpack_6DES_DZE1","CzechBackpack_TAK_DZE1","CzechBackpack_NVG_DZE1","CzechBackpack_BLK_DZE1","CzechBackpack_DPM_DZE1","CzechBackpack_FIN_DZE1","CzechBackpack_MTC_DZE1","CzechBackpack_NOR_DZE1","CzechBackpack_WIN_DZE1","CzechBackpack_ATC_DZE1","CzechBackpack_MTL_DZE1","CzechBackpack_FTN_DZE1","WandererBackpack_DZE1","LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1"];
ai_hero_skin		 = ["Soldier_Sniper_PMC_DZ","Drake_Light_DZ","CZ_Special_Forces_GL_DES_EP1_DZ","FR_Rodriguez_DZ","FR_Marksman_DZ","FR_R_DZ","FR_Sapper_DZ","FR_TL_DZ","FR_OHara_DZ","USMC_Soldier_MG_DZ","US_Soldier_EP1_DZ","UN_CDF_Soldier_Guard_EP1_DZ","GER_Soldier_TL_EP1_DZ","BAF_Soldier_Officer_MTP_DZ","BAF_Soldier_N_MTP_DZ"];
ai_bandit_skin		 = ["Ins_Soldier_GL_DZ","TK_INS_Soldier_EP1_DZ","TK_INS_Warlord_EP1_DZ","GUE_Commander_DZ","GUE_Soldier_Sniper_DZ","GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_2_DZ","GUE_Soldier_CO_DZ","BanditW1_DZ","BanditW2_DZ","Bandit1_DZ","Bandit2_DZ","MVD_Soldier_DZ","Ins_Soldier_2_DZ","CDF_Soldier_DZ","RUS_Soldier1_DZ"];
ai_special_skin		 = ["Functionary2_EP1"];
ai_all_skin			 = [ai_hero_skin,ai_bandit_skin,ai_special_skin];
ai_add_skin			 = true; // adds unit skin to inventory on death. Should set to false if you have takeclothes installed.

/* END AI CONFIG */

/* WAI MISSIONS CONFIG */
wai_mission_system		= true; // use built in mission system

wai_mission_markers		= ["DZMSMajMarker","DZMSMinMarker","DZMSBMajMarker","DZMSBMinMarker"]; // List of DZMS mission markers to check
wai_avoid_samespot		= false; // Checks to see that a selected mission spawn point has not been used already - 200m check.
wai_avoid_missions		= 750; // avoid spawning missions this close to other missions, these are defined in wai_mission_markers
wai_avoid_safezones		= 750; // avoid spawning missions this close to safezones
wai_avoid_town			= 0; // avoid spawning missions this close to towns, *** doesn't function with infiSTAR enabled ***
wai_avoid_road			= 0; // avoid spawning missions this close to roads
wai_avoid_water			= 50; // avoid spawning missions this close to water
wai_avoid_players 		= 500; // avoid spawning missions this close to a player
wai_avoid_plots			= 100; // avoid spawning missions near player plots

wai_mission_timer		= [5,15]; // time between missions. Default: 5-15 minutes
wai_mission_timeout		= [15,30]; // time each mission takes to timeout if inactive. Default: 15-30 minutes
wai_timeout_distance	= 1000; // if a player is this close to a mission then it won't timeout

wai_clean_mission_time	= 30; // time in minutes after a mission is complete to clean mission buildings. Set to -1 to disable mission cleanup. Default: 30 minutes
wai_clean_mission_crate	= true; // include the mission crates with the mission cleanup. If a player is within 75 meters of the crates the cleanup script will wait. Does not apply to missions that timeout.
wai_clean_when_clear	= ["Road Block"]; // These mission names will get cleaned instantly overriding wai_clean_mission_time

wai_godmode_objects		= true; // prevents mission objects from taking damage
wai_mission_fuel		= [5,60]; // fuel inside mission spawned vehicles [min%,max%]
wai_vehicle_damage		= [20,70]; // damages to spawn vehicles with [min%,max%]
wai_keep_vehicles		= true; // save vehicles to database and keep them after restart
wai_godmode_vehicles	= true; // mission vehicles do not take damage until players enter them
wai_vehicle_keys		= "KeyinCrate"; // Options: "KeyonAI", "KeyinVehicle", "KeyinCrate", "NoVehicleKey".
wai_vehicle_message		= false; // Shows a warning message to the player when entering a mission vehicle

wai_crates_smoke		= true; // pop smoke on crate when mission is finished during daytime
wai_crates_flares		= true; // pop flare on crate when mission is finished during nighttime

wai_players_online		= 1; // number of players online before mission starts
wai_kill_percent		= 80; // percentage of AI players that must be killed at "crate" missions to be able to trigger completion
wai_high_value_chance	= 10; // chance in percent you find a high value item in the crate.
wai_num_mags 			= [3,6]; // Number of magazines per weapon in the crate [min,max]

wai_enable_minefield	= false; // enable minefields to better defend missions
wai_enable_static_guns	= true; // Enables or disables static gun placements at missions that have them.
wai_enable_paradrops	= true; // Enables or disables paratrooper drops at missions that have them.
wai_enable_patrols		= true; // Enables or disables armored vehicle patrols at missions that have them.
wai_use_launchers		= true; // add a rocket launcher to each spawned AI group
wai_remove_launcher		= true; // remove rocket launcher from AI on death
wai_mission_announce	= "DynamicText"; // Options: "Radio", "DynamicText", "titleText"
wai_hero_limit			= 1; // define how many hero missions can run at once
wai_bandit_limit		= 1; // define how many bandit missions can run at once

// Mission Arrays
// [mission name, chance to spawn] Chance to spawn is 0-1. Example - If you only want your mission to have a 25% chance to spawn enter .25
wai_hero_missions = [
	["patrol",1],
	["black_hawk_crash",1],
	["armed_vehicle",1],
	["base",1],
	["captured_mv22",1],
	["scout_patrol",1],
	["ikea_convoy",1],
	["medi_camp",1],
	["broken_down_ural",1],
	["sniper_extraction",1],
	["mayors_mansion",1],
	["weapon_cache",1],
	["gem_tower",1],
	["cannibal_cave",1],
	["crop_raider",1],
	["drone_pilot",1],
	["slaughter_house",1],
	["drugbust",1],
	["armybase",1],
	["abandoned_trader",1],
	["lumberjack",1],
	["presidents_mansion",1],
	["tankcolumn",1],
	["macdonald",1],
	["radioshack",1],
	["junkyard",1],
	["outpost",1],
	["farmer",1],
	["firestation",1],
	["vehicle_drop",1]
];

wai_bandit_missions	= [
	["patrol",1],
	["black_hawk_crash",1],
	["armed_vehicle",1],
	["base",1],
	["captured_mv22",1],
	["scout_patrol",1],
	["ikea_convoy",1],
	["medi_camp",1],
	["broken_down_ural",1],
	["sniper_extraction",1],
	["mayors_mansion",1],
	["weapon_cache",1],
	["gem_tower",1],
	["cannibal_cave",1],
	["crop_raider",1],
	["drone_pilot",1],
	["slaughter_house",1],
	["drugbust",1],
	["armybase",1],
	["abandoned_trader",1],
	["lumberjack",1],
	["presidents_mansion",1],
	["tankcolumn",1],
	["macdonald",1],
	["radioshack",1],
	["junkyard",1],
	["outpost",1],
	["farmer",1],
	["firestation",1],
	["vehicle_drop",1]
];

// Vehicle arrays
armed_vehicle 				= ["ArmoredSUV_PMC_DZE","GAZ_Vodnik_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","LandRover_MG_TK_EP1_DZE","LandRover_Special_CZ_EP1_DZE","Offroad_DSHKM_Gue_DZE","UAZ_MG_TK_EP1_DZE","Pickup_PK_GUE_DZE","Pickup_PK_INS_DZE","Pickup_PK_TK_GUE_EP1_DZE"];
armed_chopper 				= ["CH_47F_EP1_DZE","UH1H_DZE","Mi17_DZE","UH60M_EP1_DZE","UH1Y_DZE","MH60S_DZE"];
civil_chopper 				= ["AH6X_DZ","BAF_Merlin_DZE","MH6J_DZ","Mi17_Civilian_DZ"];
military_unarmed 			= ["GAZ_Vodnik_MedEvac_DZE","HMMWV_Ambulance_DZE","HMMWV_Ambulance_CZ_DES_EP1_DZE","HMMWV_DES_EP1_DZE","HMMWV_DZ","HMMWV_M1035_DES_EP1_DZE","LandRover_CZ_EP1_DZE","LandRover_TK_CIV_EP1_DZE","UAZ_CDF_DZE","UAZ_INS_DZE","UAZ_RU_DZE","UAZ_Unarmed_TK_CIV_EP1_DZE","UAZ_Unarmed_TK_EP1_DZE","UAZ_Unarmed_UN_EP1_DZE"];
cargo_trucks 				= ["Kamaz_DZE","MTVR_DES_EP1_DZE","Ural_INS_DZE","Ural_CDF_DZE","Ural_TK_CIV_EP1_DZE","Ural_UN_EP1_DZE","V3S_Open_TK_CIV_EP1_DZE","V3S_Open_TK_EP1_DZE"];
refuel_trucks				= ["KamazRefuel_DZ","MtvrRefuel_DES_EP1_DZ","UralRefuel_TK_EP1_DZ","V3S_Refuel_TK_GUE_EP1_DZ"];
civil_vehicles 				= ["hilux1_civil_1_open_DZE","hilux1_civil_2_covered_DZE","hilux1_civil_3_open_DZE","SUV_Blue","SUV_Camo","SUV_Charcoal","SUV_Green","SUV_Orange","SUV_Pink","SUV_Red","SUV_Silver","SUV_TK_CIV_EP1_DZE","SUV_White","SUV_Yellow"];

// Dynamic crate array
crates_large				= ["USVehicleBox","RUVehicleBox","TKVehicleBox_EP1"];
crates_medium				= ["USBasicWeaponsBox","RUBasicWeaponsBox","USSpecialWeaponsBox","USSpecialWeapons_EP1","RUSpecialWeaponsBox","SpecialWeaponsBox","TKSpecialWeapons_EP1","UNBasicWeapons_EP1"];
crates_small				= ["GuerillaCacheBox","RULaunchersBox","RUBasicAmmunitionBox","RUOrdnanceBox","USBasicAmmunitionBox","USLaunchersBox","USOrdnanceBox","USOrdnanceBox_EP1","USLaunchers_EP1","USBasicWeapons_EP1","USBasicAmmunitionBox_EP1","UNBasicAmmunitionBox_EP1","TKOrdnanceBox_EP1","TKLaunchers_EP1","TKBasicAmmunitionBox_EP1","GuerillaCacheBox_EP1","GERBasicWeapons_EP1"];

// Crate Arrays
crate_weapons_buildables	= ["ChainSaw","ChainSawB","ChainSawG","ChainSawP","ChainSawR"];
crate_tools					= ["ItemKeyKit","Binocular","Binocular_Vector","ItemCompass","ItemCrowbar","ItemEtool","ItemFishingPole","ItemFlashlightRed","ItemGPS","ItemHatchet","ItemKnife","ItemMachete","ItemMatchbox","ItemToolbox","NVGoggles"];
crate_tools_buildable		= ["ItemToolbox","ItemEtool","ItemCrowbar","ItemKnife"];
crate_tools_sniper			= ["ItemCompass","Binocular","Binocular_Vector","NVGoggles","ItemGPS"];
crate_items_misc			= ["ItemGoldBar","ItemGoldBar10oz"];
crate_items_high_value		= ["ItemBriefcase100oz","ItemVault","plot_pole_kit","ItemHotwireKit"];
crate_items_food			= ["ItemWaterbottle","FoodNutmix","FoodPistachio","FoodMRE","ItemSodaOrangeSherbet","ItemSodaRbull","ItemSodaR4z0r","ItemSodaMdew","ItemSodaPepsi","ItemSodaCoke","FoodbaconCooked","FoodCanBakedBeans","FoodCanFrankBeans","FoodCanPasta","FoodCanSardines","FoodchickenCooked","FoodmuttonCooked","FoodrabbitCooked","FishCookedTrout","FishCookedTuna","FishCookedSeaBass"];
crate_items_buildables		= ["forest_large_net_kit","cinder_garage_kit",["PartPlywoodPack",5],"ItemSandbagExLarge5X","park_bench_kit","ItemComboLock",["CinderBlocks",10],"ItemCanvas","ItemComboLock",["ItemLightBulb",5],"ItemLockbox",["ItemSandbag",10],["ItemTankTrap",10],["ItemWire",10],["MortarBucket",10],["PartPlankPack",5],"PartWoodPile"];
crate_items_vehicle_repair	= ["PartEngine","PartFueltank","PartGeneric","PartGlass","PartVRotor","PartWheel"];
crate_items_medical			= ["ItemWaterbottle","ItemAntibiotic","ItemBloodbag","ItemEpinephrine","ItemHeatPack","ItemMorphine","ItemBandage","FoodCanFrankBeans","FoodCanPasta"];
crate_items_chainbullets	= ["2000Rnd_762x51_M134","200Rnd_762x51_M240","100Rnd_127x99_M2","150Rnd_127x107_DSHKM"];
crate_items_sniper			= [["ItemPainkiller",5],"Skin_Sniper1_DZ","Skin_CZ_Soldier_Sniper_EP1_DZ","Skin_GUE_Soldier_Sniper_DZ"];
crate_items_president		= ["ItemDocument","ItemGoldBar10oz"];
crate_items_gems			= ["ItemRuby","ItemCitrine","ItemEmerald","ItemAmethyst","ItemSapphire","ItemObsidian","ItemTopaz"];
crate_items_crop_raider		= ["ItemKiloHemp"];
crate_items_wood			= [["ItemWoodFloorQuarter",5],["ItemWoodStairs",2],["ItemWoodLadder",2],["ItemWoodWallThird",5],"ItemWoodWallGarageDoor",["ItemWoodWallLg",3],"ItemWoodWallWithDoorLg","wood_ramp_kit"];
crate_backpacks_all			= ["Patrol_Pack_DZE1","GymBag_Camo_DZE1","GymBag_Green_DZE1","Czech_Vest_Pouch_DZE1","Assault_Pack_DZE1","TerminalPack_DZE1","TinyPack_DZE1","ALICE_Pack_DZE1","TK_Assault_Pack_DZE1","School_Bag_DZE1","CompactPack_DZE1","British_ACU_DZE1","GunBag_DZE1","PartyPack_DZE1","NightPack_DZE1","SurvivorPack_DZE1","AirwavesPack_DZE1","CzechBackpack_DZE1","CzechBackpack_Camping_DZE1","CzechBackpack_OD_DZE1","CzechBackpack_DES_DZE1","CzechBackpack_3DES_DZE1","CzechBackpack_WDL_DZE1","CzechBackpack_MAR_DZE1","CzechBackpack_DMAR_DZE1","CzechBackpack_UCP_DZE1","CzechBackpack_6DES_DZE1","CzechBackpack_TAK_DZE1","CzechBackpack_NVG_DZE1","CzechBackpack_BLK_DZE1","CzechBackpack_DPM_DZE1","CzechBackpack_FIN_DZE1","CzechBackpack_MTC_DZE1","CzechBackpack_NOR_DZE1","CzechBackpack_WIN_DZE1","CzechBackpack_ATC_DZE1","CzechBackpack_MTL_DZE1","CzechBackpack_FTN_DZE1","WandererBackpack_DZE1","LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1"];
crate_backpacks_large		= ["CzechBackpack_DZE1","CzechBackpack_Camping_DZE1","CzechBackpack_OD_DZE1","CzechBackpack_DES_DZE1","CzechBackpack_3DES_DZE1","CzechBackpack_WDL_DZE1","CzechBackpack_MAR_DZE1","CzechBackpack_DMAR_DZE1","CzechBackpack_UCP_DZE1","CzechBackpack_6DES_DZE1","CzechBackpack_TAK_DZE1","CzechBackpack_NVG_DZE1","CzechBackpack_BLK_DZE1","CzechBackpack_DPM_DZE1","CzechBackpack_FIN_DZE1","CzechBackpack_MTC_DZE1","CzechBackpack_NOR_DZE1","CzechBackpack_WIN_DZE1","CzechBackpack_ATC_DZE1","CzechBackpack_MTL_DZE1","CzechBackpack_FTN_DZE1","WandererBackpack_DZE1","LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1"];

// Random Items				// By default, most of the mission crates spawn items out of the list of arrays below. You can remove or add any array entries in the list.
crate_items_random			= [crate_items_food,crate_items_vehicle_repair,crate_items_medical,crate_items_chainbullets,crate_items_crop_raider,crate_items_misc];

/* END WAI MISSIONS CONFIG */

/* AUTO-CLAIM CONFIG */

use_wai_autoclaim			= false; // Turn on the auto-claim feature. You should increase wai_avoid_missions to more than the distance below
ac_alert_distance			= 1000; // Distance from the mission that auto-claim uses to alert closest player
ac_delay_time				= 30; // Time that the auto-claim waits until it declares a claim and places a marker - time in seconds
ac_timeout					= 60; // If the claimer leaves the mission area he/she has this much time to return - time in seconds

/* END AUTO-CLAIM CONFIG */

/* STATIC MISSIONS CONFIG */

wai_static_missions			= false; // use static mission file
wai_custom_per_world		= true;	// use a custom mission file per world

/* END STATIC MISSIONS CONFIG */

WAIconfigloaded = true;
