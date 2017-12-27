// ===========================================================================
// [IWAC] IBEN WAI AUTOCLAIM >> defines.hpp
// ===========================================================================
// [last update: 2017-10-22]
// ===========================================================================
// created by @iben for WAI, DayZ Epoch 1.0.6.2+
// ===========================================================================
// :: ID info
#define IWAC_NAME "IBEN WAI AUTOCLAIM ADDON"
#define IWAC_VERS "v1.0"
// ===========================================================================
// ...
// ---------------------------------------------------------------------------
// :: Debug for IBEN_fnc_init_ROOTer
#define __ROOTDBG__

// ---------------------------------------------------------------------------
// :: Compile patterns
#define CPP(HAN,FOL,FIL) HAN = compile preprocessFileLineNumbers format ["%1\%2\%3.sqf",WAIROOT,#FOL,#FIL]
#define CCP(FOL,FIL) call compile preprocessFileLineNumbers format ["%1\%2\%3.sqf",WAIROOT,#FOL,#FIL]

// ---------------------------------------------------------------------------
// :: Common formatting patterns
#define STRLO(ST) (localize ST)
#define FSTR1(ST,p1) (format [ST,p1])
#define FSTR2(ST,p1,p2) (format [ST,p1,p2])
#define FSTR3(ST,p1,p2,p3) (format [ST,p1,p2,p3])
#define FSTR4(ST,p1,p2,p3,p4) (format [ST,p1,p2,p3,p4])
#define FSTR5(ST,p1,p2,p3,p4,p5) (format [ST,p1,p2,p3,p4,p5])

// ---------------------------------------------------------------------------
// :: Debug pattern
#define DBG(ID,MSG) diag_log format ["=== [%1, %2] || DEBUG [%3] >> %4",IWAC_NAME,IWAC_VERS,ID,MSG]

// ---------------------------------------------------------------------------
// :: Common strings
#define RMSG_TYPE "IWAC"
#define ACSTR STRLO("STR_IWAC_INFOSYS")

// ---------------------------------------------------------------------------
// :: WAI mission data defult def
#define WMDEF wai_mission_data = wai_mission_data + [[0,"",[],[0,0,0],[false,["",""],[0,0,0],[]]]]

// ---------------------------------------------------------------------------
// :: IWAC claimers default arr
#define IWACC iben_wai_ACclaimers set [count iben_wai_ACclaimers, 0]

// ---------------------------------------------------------------------------
// :: IWAC claimers arr > set template
#define IWACS(OR,VL) iben_wai_ACclaimers set [OR, VL]

// ---------------------------------------------------------------------------
// :: WAI mission data base template
#define WMD(MS) (wai_mission_data select MS)

// ---------------------------------------------------------------------------
// :: WAI mission data > set full default claimer info arr pattern
#define WMDACD(MS) (WMD(MS) set [4, [false, ["",""], [0,0,0],[]]])

// ---------------------------------------------------------------------------
// :: WAI mission data > claimer info arr select pattern
#define WMDSEL(MS,IT) ((WMD(MS) select 4) select IT)

// ---------------------------------------------------------------------------
// :: WAI mission data > claimer info arr set pattern
#define WMDSST(MS,IT,DI,DV) ((WMDSEL(MS,IT)) set [DI,DV])

// ---------------------------------------------------------------------------
// :: WAI mission data > claimer name from info arr > prevent Function name err
//    when player dies, grab name from storage
#define CMNAME(MS) ((WMDSEL(MS,1)) select 0)

// ---------------------------------------------------------------------------
// :: Claimer list > select item pattern
#define CML(AR,IT) ((AR select 0) select IT)

// ---------------------------------------------------------------------------
// :: Remote msg pattern
#define RMSG(PLI,MSG) if (iben_wai_ACplayerMsg) then { RemoteMessage = [RMSG_TYPE, [PLI,MSG]]; publicVariable "RemoteMessage"; }

// === :: [IWAC] IBEN WAI AUTOCLAIM >> defines.hpp :: END
