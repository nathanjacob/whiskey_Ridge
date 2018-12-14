
fnc_spawnPatrol = {
	
	//[[west,"HQ"],"Attempting to spawn Patrol"] remoteExec ["sideChat",0];
	
	if ((patrolCount <= patrolSquadMax) && (alive spawnPoint)) then 
	{

		_grp = "group" + str patrolCount;
		
		// NEW SQUAD SPAWN STUFF
		
		_tempArray = [];
		_groupSize = 2 + (floor random 4);
		for [{_i=0}, {_i <= _groupSize}, {_i = _i + 1}] do 
		{
			
			_tempArray pushback (selectRandom ME_Militia_Inf);
			
		};
		
		_grp = [(getPos spawnPoint), east, _tempArray] call BIS_fnc_spawnGroup;
		
		//_grp = [(getPos spawnPoint), east, 3] call BIS_fnc_spawnGroup;
		_grp deleteGroupWhenEmpty true;
		
		{
			//This event handler detects if  unit is killed and checks if his entire group is dead. If the group is all dead it reduces current convoy count and begins building new group
			_x addMPEventHandler ["mpkilled", {if ({alive _x} count units group (_this select 0) < 1) then {patrolCount = patrolCount - 1; null = [] spawn fnc_spawnSquads;};}];
			
		}forEach units _grp;
				
		_grp  addwaypoint [(getMarkerPos (selectRandom patrolEndpoint)),1,1];
		//_grp  addwaypoint [(getMarkerPos "patrolEnd_1"),1,1];
		[_grp,1] setWaypointType "MOVE";
		[_grp,1] setWaypointFormation "FILE";
		[_grp,1] setWaypointSpeed "LIMITED";
		[_grp,1] setWaypointBehaviour "SAFE";
		[_grp,1] setWaypointCompletionRadius 15;
		_grp setCurrentWaypoint [_grp, 1];
		[_grp,1] setWaypointStatements ["true","{deleteVehicle _x;}forEach thisList; patrolCount = patrolCount - 1; [] call fnc_spawnSquads;"];
		
		patrolCount = patrolCount + 1;
	};


};


fnc_spawnStalker = {

};



fnc_spawnSquads = {

	[] call fnc_spawnPatrol;
	
};







