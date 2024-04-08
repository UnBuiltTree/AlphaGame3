function inventory_search(_root_object, _item_type){
	for (var i = 0; i < INVENTORY_SLOTS; i+=1) {
	    if (_root_object.inventory[i] == _item_type)
		{
			return(i);
		}
	}
	return(-1);
}

function inventory_remove(_root_object, _item_type){
	var _slot = inventory_search(_root_object, _item_type);
	if (_slot != -1){
		with (_root_object){inventory[_slot] = -1;}
		return(true);
	} else {
		return(false);
	}
}

function inventory_add(_root_object, _item_type){
	var _slot = inventory_search(_root_object, -1);
	if (_slot != -1){
		with (_root_object){inventory[_slot] = _item_type;}
		return(true);
	} else {
		return(false);
	}
}