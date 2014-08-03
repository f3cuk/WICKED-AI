wai_mission_timer 					= 600; 		// time between missions
wai_mission_timeout 				= 2700; 	// time each missions take
wai_mission_fuel 					= .5;		// fuel inside mission spawned vehicles
wai_mission_numberofguns 			= 8;		// number of guns in dynamic boxes
wai_mission_numberoftools 			= 5;		// number of tools in dynamic boxes
wai_mission_numberofitems 			= 10;		// number of items in dynamic boxes

// Missions
wai_missions 						= ["black_hawk_crash","c130_crash","armed_vehicle","bandit_base","captured_mv22","ikea_convoy","destroyed_ural","disabled_milchopper","mayors_mansion","medi_camp","weapon_cache"];

// Vehicle arrays
armed_vehicle 						= ["ArmoredSUV_PMC_DZE","GAZ_Vodnik_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","LandRover_MG_TK_EP1_DZE","LandRover_Special_CZ_EP1_DZE","Offroad_DSHKM_Gue_DZE","Pickup_PK_GUE_DZE","Pickup_PK_INS_DZE","Pickup_PK_TK_GUE_EP1_DZE","UAZ_MG_TK_EP1_DZE"];
armed_chopper 						= ["CH_47F_EP1_DZE","Mi17_DZE","UH1H_DZE","UH1Y_DZE","UH60M_EP1_DZE"];
civil_aircraft 						= ["AH6X_DZ","AN2_DZ","MH6J_DZ","Mi17_Civilian_DZ"];
military_unarmed 					= ["GAZ_Vodnik_MedEvac","HMMWV_Ambulance","HMMWV_Ambulance_CZ_DES_EP1","HMMWV_DES_EP1","HMMWV_DZ","HMMWV_M1035_DES_EP1","LandRover_CZ_EP1","LandRover_TK_CIV_EP1","UAZ_CDF","UAZ_INS","UAZ_RU","UAZ_Unarmed_TK_CIV_EP1","UAZ_Unarmed_TK_EP1","UAZ_Unarmed_UN_EP1"];
cargo_trucks 						= ["Kamaz","MTVR_DES_EP1","Ural_CDF","Ural_TK_CIV_EP1","Ural_UN_EP1","V3S_Open_TK_CIV_EP1","V3S_Open_TK_EP1"];
refuel_trucks						= ["KamazRefuel_DZ","MtvrRefuel_DES_EP1_DZ","UralRefuel_TK_EP1_DZ","V3S_Refuel_TK_GUE_EP1_DZ"];
civil_vehicles 						= ["hilux1_civil_1_open","hilux1_civil_2_covered","hilux1_civil_3_open_EP1","SUV_Blue","SUV_Camo","SUV_Charcoal","SUV_Green","SUV_Orange","SUV_Pink","SUV_Red","SUV_Silver","SUV_TK_CIV_EP1","SUV_White","SUV_Yellow"];

// Dynamic box array
ammo_box_guns 						= ["BAF_L86A2_ACOG","BAF_LRR_scoped","DMR","KSVK_DZE","M110_NVG_EP1","M14_EP1","M16A4_ACG","M240_DZ","M249_EP1_DZ","M40A3","M4A1_AIM_SD_camo","M4A3_CCO_EP1","M8_carbine","M8_sharpshooter","M9","M9SD","Mk_48_DZ","Pecheneg_DZ","RPK_74","Sa58V_CCO_EP1","Sa58V_RCO_EP1","SCAR_H_LNG_Sniper_SD","SVD_CAMO","VSS_vintorez"];
ammo_box_tools 						= ["Binocular","Binocular_Vector","chainsaw","ItemCompass","ItemCrowbar","ItemEtool","ItemFishingPole","ItemFlashlightRed","ItemGPS","ItemHatchet_DZE","ItemKnife","ItemMachete","ItemMatchbox_DZE","ItemToolbox","NVGoggles"];
ammo_box_items 						= ["ItemBandage","ItemSodaCoke"];

WAImissionconfig 					= true;