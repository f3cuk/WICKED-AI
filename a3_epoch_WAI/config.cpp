class CfgPatches {
	class WAI {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_server_settings"};
	};
};
class CfgFunctions {
	class Mission1 {
		class main {
			file = "x\addons\wai";
			class init {
				postInit = 1;
			};
		};
	};
};