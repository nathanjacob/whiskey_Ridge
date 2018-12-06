if (!isServer) exitWith {};

maxArmedSquads = 3;
armedSquads = 1;




//tempSquad = createGroup east;
//tempSquad deleteGroupWhenEmpty false;

armedTemp = createGroup east;
//armedTemp deleteGroupWhenEmpty false;

rallyPosition = [];

_checkNum = 1;
_checkString = "rallyPoint_" + str _checkNum;
while {(getmarkerColor _checkString) != "" } do 
{
	rallyPosition pushback _checkString;
	_checkNum = _checkNum + 1;
	_checkString = "rallyPoint_" + str _checkNum;
};
_checkNum = nil;
_checkString = nil;


fnc_stripUnit = {
	
	_unit = _this select 0;
	
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

};


fnc_ArmUnit = {

	_unit = _this select 0;
	
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	
	
	_unit addItemToUniform "rhs_30Rnd_762x39mm";
	_unit addItemToUniform "FirstAidKit";
	_unit addVest "rhs_6sh92_digi";
	for "_i" from 1 to 4 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};
	for "_i" from 1 to 2 do {_unit addItemToVest "rhs_mag_rdg2_white";};
	for "_i" from 1 to 2 do {_unit addItemToVest "rhs_mag_rgo";};

	
	_unit addWeapon "rhs_weap_akm";
	_unit addPrimaryWeaponItem "rhs_acc_dtkakm";

	
	//[[west,"HQ"],"Unit Armed"] remoteExec ["sideChat",0];
		
	deleteWaypoint [(group _unit),1];
	(group _unit) addWayPoint [(getmarkerpos rally),1,1];
	
	[(group _unit),1] setWaypointCompletionRadius 15;
	[(group _unit),1] setWaypointStatements ["true","[this] call fnc_addTempSquad;"];
	
	//[] spawn fnc_checkUnarmed;
	
};

fnc_addTempSquad = {
	
	_unit = _this select 0;
	
	[_unit] join armedTemp;
	
	if ((count units armedTemp) >= squadSize) then 
	{
		
		[] call fnc_finishSquad;
		
	};
	
};


fnc_spawnUnit = {

	
	//Where the unit originates from
	_spawnPosition = (getPos (selectRandom buildings));
	
	//Where the unit will find equipment
	_cacheLocation = getPos target;
	
	while {(_spawnPosition isEqualto _cacheLocation)} do {_spawnPosition = (getPos (selectRandom buildings));};
	
	_tempSquad = createGroup east;
	_tempSquad deleteGroupWhenEmpty true;
	//[[west,"HQ"],"Unit Spawning"] remoteExec ["sideChat",0];
	_toSpawn = selectRandom RD_afghanInf;
	_toSpawn createUnit [_spawnPosition, _tempSquad,"[this] call fnc_stripUnit; this addMPEventHandler['mpkilled',{[] call fnc_spawnUnit;}]"];
			
	_tempSquad  addwaypoint [_cacheLocation,1,1];
	//_grp  addwaypoint [(getMarkerPos "patrolEnd_1"),1,1];
	[_tempSquad,1] setWaypointType "MOVE";
	[_tempSquad,1] setWaypointFormation "FILE";
	[_tempSquad,1] setWaypointSpeed "LIMITED";
	[_tempSquad,1] setWaypointBehaviour "SAFE";
	[_tempSquad,1] setWaypointCompletionRadius 3;
	_tempSquad setCurrentWaypoint [_tempSquad, 1];
	[_tempSquad,1] setWaypointStatements ["true","[this] call fnc_ArmUnit;"];
	
};

fnc_finishSquad = {
	
	_grpName = "armedSquad_" + str armedSquads;
	_grp = createGroup east;
	
	
	//[[west,"HQ"],"Squad Finished"] remoteExec ["sideChat",0];
	{
		_x removeAllMPEventHandlers "mpkilled";
		_x addMPEventHandler ["mpkilled", {if ({alive _x} count units group (_this select 0) < 1) then {armedSquads = armedSquads - 1; null = [] spawn fnc_checkUnarmed;};}];
		[_x] join _grp;
	}forEach units armedTemp;
	
	_grp addwaypoint [(getMarkerPos (selectRandom patrolEndpoint)),1,1];
	//_grp  addwaypoint [(getMarkerPos "patrolEnd_1"),1,1];
	[_grp,1] setWaypointType "MOVE";
	[_grp,1] setWaypointFormation "FILE";
	[_grp,1] setWaypointSpeed "LIMITED";
	[_grp,1] setWaypointBehaviour "SAFE";
	[_grp,1] setWaypointCompletionRadius 15;
	_grp setCurrentWaypoint [_grp, 1];
	[_grp,1] setWaypointStatements ["true","{deleteVehicle _x;}forEach thisList; armedSquads = armedSquads - 1; [] spawn fnc_checkUnarmed;"];
	
	missionNameSpace setVariable [_grpName,_grp,true];
	
	armedSquads = armedSquads + 1;
		
	[] spawn fnc_checkUnarmed;
};

  

fnc_checkUnarmed = {
	
	
	if (armedSquads <= maxArmedSquads) then
	{
		rally = selectRandom rallyPosition;
		squadSize = 2 + (floor random 3);
		//squadSize = 2;
				
		for [{_i=1}, {_i <= squadSize}, {_i = _i + 1}] do 
		{
			[] call fnc_spawnUnit;
		};
			
	};

};


//[] spawn fnc_checkUnarmed;
