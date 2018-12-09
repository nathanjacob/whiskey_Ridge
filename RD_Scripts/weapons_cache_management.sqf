



fnc_cacheObj = {

	(cache select 0) allowDamage true;
	(cache select 0) setDamage 1;
	["cacheTask","SUCCEEDED", true] call BIS_fnc_taskSetState;
};


fnc_createCache = {
	_cacheLocation = getPosASL (nearestBuilding target);
	_cacheLocation = [(_cacheLocation select 0),(_cacheLocation select 1),(_cacheLocation select 2)+1];

	cache = [_cacheLocation,"O_supplyCrate_F"] call BIS_fnc_spawnObjects;
	(cache select 0) enableSimulationGlobal true;
	(cache select 0) allowDamage false;

	cacheDestroyed = createTrigger ["EmptyDetector",(getPos target),true];
	cacheDestroyed setTriggerActivation ["ANY","PRESENT",false];
	cacheDestroyed setTriggerStatements ["!(alive (nearestBuilding target))","[] call fnc_cacheObj;",""];

	
	[west,["cacheTask"],["Locate and destroy enemy weapons cache","Locate and destroy enemy weapons cache","Destroy Weapons Cache"],(getPos cityCenter),true,0,true,"destroy",true] call BIS_fnc_taskCreate;
	
};


//[] call fnc_createCache;