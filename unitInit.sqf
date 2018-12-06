_unit = _this select 0;

if ((paramsArray select 4) == 0) then {
	_unit enableFatigue false;
	_unit enableStamina false;
	_unit setCustomAimCoef 0.3;
}; 

[_unit, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;

//Need to revisit this addRating crap at some point this is simply here for testing purposes
_unit addRating 2000;