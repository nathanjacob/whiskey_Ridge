if (!isServer) exitWith {};

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
	
		if (typeOf _unit == "LOP_AM_OPF_Infantry_Engineer") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 4 do {_unit addItemToUniform "rhs_30Rnd_762x39mm";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addWeapon "rhs_weap_akm";
		_unit addPrimaryWeaponItem "rhs_acc_dtkakm";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_Corpsman") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 3 do {_unit addItemToUniform "rhs_30Rnd_545x39_AK";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addBackpack "LOP_AM_Sidor_Med";
		for "_i" from 1 to 15 do {_unit addItemToBackpack "FirstAidKit";};
		_unit addHeadgear "LOP_H_Turban";
		_unit addWeapon "rhs_weap_aks74u";
		_unit addPrimaryWeaponItem "rhs_acc_pgs64_74u";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_GL") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 4 do {_unit addItemToUniform "rhs_30Rnd_762x39mm";};
		for "_i" from 1 to 4 do {_unit addItemToUniform "rhs_VOG25";};
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addWeapon "rhs_weap_akm_gp25";
		_unit addPrimaryWeaponItem "rhs_acc_dtkakm";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_Rifleman_6") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 4 do {_unit addItemToUniform "rhs_30Rnd_762x39mm";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addWeapon "rhs_weap_pm63";
		_unit addPrimaryWeaponItem "rhs_acc_dtkakm";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_Rifleman") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 4 do {_unit addItemToUniform "rhs_30Rnd_762x39mm";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addWeapon "rhs_weap_akm";
		_unit addPrimaryWeaponItem "rhs_acc_dtkakm";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_Rifleman_2") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 5 do {_unit addItemToUniform "rhs_30Rnd_762x39mm";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rdg2_black";
		for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_rgd5";};
		_unit addWeapon "rhs_weap_akms";
		_unit addPrimaryWeaponItem "rhs_acc_dtkakm";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_Rifleman_4") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 3 do {_unit addItemToUniform "rhs_30Rnd_545x39_AK";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgn";
		_unit addWeapon "rhs_weap_aks74";
		_unit addPrimaryWeaponItem "rhs_acc_dtk1983";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_Rifleman_5") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 3 do {_unit addItemToUniform "rhs_30Rnd_545x39_AK";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgn";
		_unit addHeadgear "LOP_H_Pakol";
		_unit addWeapon "rhs_weap_aks74u";
		_unit addPrimaryWeaponItem "rhs_acc_pgs64_74u";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_Rifleman_3") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 4 do {_unit addItemToUniform "LOP_10rnd_77mm_mag";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addWeapon "LOP_Weap_LeeEnfield";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_AT") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 3 do {_unit addItemToUniform "rhs_30Rnd_545x39_AK";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addBackpack "LOP_AM_RPG_Pack";
		_unit addItemToBackpack "rhs_rpg7_PG7VR_mag";
		_unit addHeadgear "LOP_H_Pakol";
		_unit addWeapon "rhs_weap_aks74u";
		_unit addPrimaryWeaponItem "rhs_acc_pgs64_74u";
		_unit addWeapon "rhs_weap_rpg7";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_Marksman") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 6 do {_unit addItemToUniform "rhs_10Rnd_762x54mmR_7N1";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rdg2_black";
		for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_rgd5";};
		_unit addHeadgear "LOP_H_Turban_mask";
		_unit addWeapon "rhs_weap_svd";
		_unit addPrimaryWeaponItem "rhs_acc_pso1m2";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_AR") then
		{
		_unit addItemToUniform "FirstAidKit";
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rdg2_black";
		for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_rgd5";};
		_unit addBackpack "LOP_AM_Fieldpack_PKM";
		for "_i" from 1 to 3 do {_unit addItemToBackpack "rhs_100Rnd_762x54mmR";};
		_unit addHeadgear "LOP_H_Pakol";
		_unit addWeapon "rhs_weap_pkm";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};
				
	if (typeOf _unit == "LOP_AM_OPF_Infantry_AR_Asst") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 4 do {_unit addItemToUniform "LOP_10rnd_77mm_mag";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addBackpack "LOP_AM_Fieldpack_PKM";
		for "_i" from 1 to 3 do {_unit addItemToBackpack "rhs_100Rnd_762x54mmR";};
		_unit addWeapon "LOP_Weap_LeeEnfield";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		};

	if (typeOf _unit == "LOP_AM_OPF_Infantry_SL") then
		{
		_unit addItemToUniform "FirstAidKit";
		for "_i" from 1 to 4 do {_unit addItemToUniform "rhs_30Rnd_762x39mm";};
		_unit addItemToUniform "rhs_mag_rdg2_white";
		_unit addItemToUniform "rhs_mag_rgd5";
		_unit addHeadgear "LOP_H_Turban_mask";
		_unit addWeapon "rhs_weap_akm";
		_unit addPrimaryWeaponItem "rhs_acc_dtkakm";
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit linkItem "ItemRadio";
		};

		
	
	deleteWaypoint [(group _unit),1];
	(group _unit) addWayPoint [(getmarkerpos rally),1,1];
	[(group _unit),1] setWaypointCompletionRadius 15;
	[(group _unit),1] setWaypointStatements ["true","[this] call fnc_addTempSquad;"];
		
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
	_toSpawn = selectRandom ME_Militia_Inf;
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
