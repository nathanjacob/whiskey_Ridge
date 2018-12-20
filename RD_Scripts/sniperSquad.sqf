


RD_fnc_buildSniperNests = {

	
	_sniperNests = [];
	_checkNum = 1;
	_checkString = "sniper_nest_" + str _checkNum;
	while {(getmarkerColor _checkString) != "" } do 
	{
		_sniperNests pushback _checkString;
		_checkNum = _checkNum + 1;
		_checkString = "sniper_nest_" + str _checkNum;
	};
	
	_checkNum = nil;
	_checkString = nil;
	_sniperNests;
	//[_sniperNests] call RD_fnc_buildSniperSquad;
	
};


RD_fnc_buildSniperSquad = {
	
	_NestMarkers = _this select 0;	
	
	_sniperSquadAlternates = ["LOP_AM_OPF_Infantry_AT","LOP_AM_OPF_Infantry_GL","LOP_AM_OPF_Infantry_Rifleman_3","LOP_AM_OPF_Infantry_AR"];
	_sniperCount = 2 + (floor random 3);
	
	for [{_z=0}, {_z <= _sniperCount}, {_z = _z + 1}] do 
	{
		_sniperSpawn = (selectRandom _NestMarkers);
		
		_groupSize = 1 + (floor random 2);
		_tempArray = ["LOP_AM_OPF_Infantry_Marksman"];
		for [{_s=0}, {_s <= _groupSize}, {_s = _s + 1}] do 
		{
			
			_tempArray pushback (selectRandom _sniperSquadAlternates);
			
		};
		
		
		_grp = [(getMarkerPos _sniperSpawn), east, _tempArray] call BIS_fnc_spawnGroup;
		_grp setBehaviour "AWARE";
		_grp setCombatMode "RED";
		{
			_x setSkill ["aimingShake", 0.1];
			_x setSkill ["aimingAccuracy", 0.2];
			_x setSkill ["aimingSpeed", 0.3];
			_x setSkill ["spotDistance", 0.8];
					
			
			/*
			_teamMember = _x;
			{
				_teamMember reveal [_x,4];
			}forEach allPlayers;
			*/
			
			_nearestRoad = [(getPos _x),500] call BIS_fnc_nearestRoad;
			_x doWatch (getPos _nearestRoad);
			
		}forEach units _grp;
		_NestMarkers deleteAt ( _NestMarkers find _sniperSpawn);
		
	};	
	

};


/*
bluforMoving = createTrigger ["EmptyDetector",(getMarkerPos "OP_Conflict"),true];
bluforMoving setTriggerActivation ["WEST","NOT PRESENT",false];
bluforMoving setTriggerArea [30,30,0,false,10];
bluforMoving setTriggerTimeout [10,10,10,true];
bluforMoving setTriggerStatements ["this", "[] call RD_fnc_buildSniperNests;",""];
*/

_sniperNests = [] call RD_fnc_buildSniperNests;

[_sniperNests] call RD_fnc_buildSniperSquad;


















