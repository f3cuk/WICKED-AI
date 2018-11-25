// This file contains loot array definitions per mission
// Array format [long guns, tools, items, pistols, backpacks] - Either a number or a custom array.
// First array is for Hero missions, second is for bandit missions. Change the values to preferences.
// [[Hero Loot Array],[Bandit Loot Array]]

// Easy Missions
Loot_UralAttack = [[4,8,36,3,1],  [4,8,36,3,1]];// Ural Attack
Loot_Farmer = [[6,5,[40,crate_items_medical],3,1],  [6,5,[40,crate_items_medical],3,1]]; // Farmer
Loot_MediCamp = [[0,0,[70,crate_items_medical],3,1],  [0,0,[70,crate_items_medical],3,1]]; // Medical Camp
Loot_Outpost = [[6,4,40,2,1],  [6,4,40,2,1]]; // Outpost
Loot_ScoutPatrol = [[4,8,36,2,1],[4,8,36,2,1]]; // Scout Patrol
Loot_SlaughterHouse = [[6,5,[6,crate_items_chainbullets],2,1],  [6,5,[6,crate_items_chainbullets],2,1]]; // Slaughter House

// Medium Missions
Loot_AbandonedTrader = [[8,5,15,3,1],  [8,5,15,3,1]]; // Abandoned Trader
Loot_ArmedVehicle = [[0,0,[25,crate_items_chainbullets],0,1],  [0,0,[25,crate_items_chainbullets],0,1]]; // Armed Vehicle
Loot_BHC = [[5,5,10,3,1],  [5,5,10,3,1]]; // Black Hawk Crash
Loot_DrugBust = [[5,5,[10,crate_items_crop_raider],3,1],  [5,5,[10,crate_items_crop_raider],3,1]]; // Drug Bust
Loot_Junkyard = [[14,5,1,3,1],  [14,5,1,3,1]]; // Junk Yard
Loot_Patrol = [[3,0,[2,["ItemBriefcase100oz"]],0,1],  [3,0,[2,["ItemBriefcase100oz"]],0,1]]; // Patrol
Loot_VehicleDrop = [[3,0,[2,["ItemBriefcase100oz"]],0,1],  [3,0,[2,["ItemBriefcase100oz"]],0,1]]; // Vehicle Drop
Loot_WeaponCache = [[10,4,0,3,1],  [10,4,0,3,1]]; // Weapon Cache

// Hard Missions
Loot_ArmyBase = [[10,5,10,3,2],  [10,5,10,3,2]];// Army Base
Loot_Base = [[[16,ai_wep_sniper],[8,crate_tools_sniper],[3,crate_items_high_value],3,[4,crate_backpacks_large]],  [[16,ai_wep_sniper],[8,crate_tools_sniper],[3,crate_items_high_value],3,[4,crate_backpacks_large]]]; // Bandit base or Hero base
Loot_CannibalCave = [[10,8,[2,crate_items_high_value],3,[2,crate_backpacks_large]],  [10,8,[2,crate_items_high_value],3,[2,crate_backpacks_large]]]; // Cannibal Cave
Loot_CapturedMV22 = [[0,0,[80,crate_items_medical],3,1],  [0,0,[80,crate_items_medical],3,1]]; // MV22
Loot_CropRaider = [[6,5,[15,crate_items_crop_raider],3,3],  [6,5,[15,crate_items_crop_raider],3,3]]; // Crop Raider
Loot_DronePilot = [[14,[8,crate_tools_sniper],[2,crate_items_high_value],3,[2,crate_backpacks_large]],  [14,[8,crate_tools_sniper],[2,crate_items_high_value],3,[2,crate_backpacks_large]]]; // Drone Pilot
Loot_GemTower = [[8,5,[4,crate_items_gems],3,2],  [8,5,[4,crate_items_gems],3,2]]; // Gem Tower
Loot_IkeaConvoy = [[[1,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],3,4],  [[1,crate_weapons_buildables],[4,crate_tools_buildable],[30,crate_items_buildables],3,4]]; // Ikea Convoy
Loot_LumberJack = [[6,[8,crate_tools_sniper],[15,crate_items_wood],3,[4,crate_backpacks_large]],  [6,[8,crate_tools_sniper],[15,crate_items_wood],3,[4,crate_backpacks_large]]]; // Lumber Jack
Loot_MacDonald = [[9,5,[15,crate_items_crop_raider],3,2],  [9,5,[15,crate_items_crop_raider],3,2]]; // MacDonald's Farm
Loot_Radioshack = [[10,5,30,3,2],  [10,5,30,3,2]]; // Radio Shack
Loot_Extraction = [[[10,ai_wep_sniper],[4,crate_tools_sniper],[4,crate_items_sniper],3,2],  [[10,ai_wep_sniper],[4,crate_tools_sniper],[4,crate_items_sniper],3,2]]; // Sniper Extraction
Loot_TankColumn = [[12,5,30,3,2],  [12,5,30,3,2]]; // Tank Column

// Extreme Missions
Loot_Firestation1 = [[0,0,[4,crate_items_high_value],0,1],  [0,0,[4,crate_items_high_value],0,1]]; // Fire Station Crate 1
Loot_Firestation2 = [[[10,ai_wep_sniper],3,20,3,1],  [[10,ai_wep_sniper],3,20,3,1]]; // Fire Station Crate 2
Loot_Mayors = [[10,5,[4,crate_items_high_value],3,[2,crate_backpacks_large]],  [10,5,[4,crate_items_high_value],3,[2,crate_backpacks_large]]]; // Mayor's Mansion
Loot_Presidents = [[0,0,[40,crate_items_president],0,1],  [0,0,[40,crate_items_president],0,1]]; // President's Mission