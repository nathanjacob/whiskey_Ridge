

RD_fnc_spawnVehicleStop = {

	_spawnpoint = (getPos MRAP) findEmptyPosition[2,20];
	_spawnName = "MRAP " + str (mapGridPosition MRAP);
	
	MRAPRespawn = [west, _spawnpoint, _spawnName] call BIS_fnc_addRespawnPosition;
};


RD_fnc_spawnVehicleMove = {

	
	MRAPRespawn call BIS_fnc_removeRespawnPosition;

};




MRAPMonitor = createTrigger ["EmptyDetector",(getPos MRAP),true];
MRAPMonitor setTriggerActivation ["ANY","PRESENT",true];
MRAPMonitor setTriggerTimeout [0,0,0,false];
MRAPMonitor setTriggerStatements ["(speed MRAP) < 1", "[] call RD_fnc_spawnVehicleStop","[] call RD_fnc_spawnVehicleMove"];